class Node
    attr_reader :val, :tag, :children, :parent
    def initialize(val, tag)
        @val = val
        @tags = tag ? [tag] : []
        @children = {}
        @parent = nil
    end

    def add_child_node(node)
        @children[node.val] = node
        node.add_parent_node(self)
    end

    def add_parent_node(node)
        @parent = node
    end

    def has_tag?(tag)
        @tags.include?(tag)
    end
end