class Node
    attr_reader :val, :tag, :children
    def initialize(val, tag)
        @val = val
        @tags = tag ? [tag] : []
        @children = {}
    end

    def add_child_node(node)
        @children[node.val] = node
    end

    def has_tag?(tag)
        @tags.include?(tag)
    end
end