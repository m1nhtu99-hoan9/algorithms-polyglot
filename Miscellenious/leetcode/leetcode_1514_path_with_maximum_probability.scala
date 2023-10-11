import scala.collection.mutable
import scala.collection.mutable.{ArrayBuffer, HashMap, ListBuffer}

/*
1514. Path with Maximum Probability (Medium)

Runtime: 1164 ms (beats 100%)
Memory:  69.8 MB (beats 100%)
*/

object Solution {
  private type NodeValue = Int
  private sealed case class NodeProb(value: NodeValue, prob: Double)

  def maxProbability(n: Int,
                     edges: Array[Array[NodeValue]],
                     succProb: Array[Double],
                     start_node: NodeValue,
                     end_node: NodeValue
                    ): Double = {
    val prevs = ArrayBuffer.fill[Option[NodeValue]](n)(None)
    val probs = ArrayBuffer.fill[Double](n)(0.0)
    probs(start_node) = 1.0

    val adjNodes = mutable.HashMap.empty[NodeValue, ListBuffer[NodeProb]]
    for ((Array(node, adjNode), prob) <- edges.zip(succProb)) {
      adjNodes.getOrElseUpdate(node, ListBuffer.empty[NodeProb]) += NodeProb(adjNode, prob)
      adjNodes.getOrElseUpdate(adjNode, ListBuffer.empty[NodeProb]) += NodeProb(node, prob)
    }

    val visited = mutable.HashMap.empty[NodeValue, Boolean].withDefaultValue(false)
    val pqueue = mutable.PriorityQueue.empty[NodeProb](Ordering.by(x => x.prob))
    pqueue.enqueue(NodeProb(start_node, 1d))

    while (pqueue.nonEmpty) {
      // beware: java.util.NoSuchElementException
      val NodeProb(node, prob) = pqueue.dequeue()
      // println(s"dequeued: (${node}), ${prob}")

      if (node == end_node)
        return prob

      if (!visited(node) && adjNodes.contains(node)) {
        visited(node) = true

        for (NodeProb(adjNode, edgeProb) <- adjNodes(node)) {
          val altProb = edgeProb * prob
          // var updated = false

          if (altProb > probs(adjNode)) {
            probs(adjNode) = altProb
            prevs(adjNode) = Some(node)
            // updated = true
          }

          // println(s"\t($node)->($adjNode) ${if (updated) "⭐" else ""} ; altProb = $prob * succProb($node) = $altProb")
          // println(s"\t\tprevs = (${prevs}); probs = ${probs}; visited = $visited")

          if (!visited(adjNode)) {
            pqueue.enqueue(NodeProb(adjNode, altProb))
          }
        }
      }
    }

    0d
  }
}
