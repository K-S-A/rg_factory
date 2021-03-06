require "rg_factory/version"

module RgFactory
  class Factory
    def self.new(name, *atrs, &block)
      name.is_a?(String) ? class_name = name : atrs.unshift(name)
      klass = Class.new do
      atrs.each { |atr| attr_accessor atr }
      define_method :initialize do |*params|
        params.each_with_index do |param, index|
          instance_variable_set("@#{atrs[index]}", param)
        end
      end

      def inspect
        "#{self.class.superclass.name} #{self.class.name} #{self.instance_variables.map{ |var| "#{var}=#{instance_variable_get(var)}" }.join(", ") }"
      end
      
      def ==(obj)
        self.inspect == obj.inspect 
      end
    
      def [](var)
        instance_variable_get(var.is_a?(Fixnum) ? instance_variables[var.to_i] : "@#{var.to_s}")
      end
      
      def []=(var, value)
        instance_variable_set(var.is_a?(Fixnum) ? instance_variables[var.to_i] : "@#{var.to_s}", value)
      end
      
      def each(&block)  
        if block_given? then values.each &block
        else                 values.each
        end
      end
      
      def each_pair(&block)
        if block_given? then to_h.each_pair &block 
        else                 to_h.each_pair
        end
      end
      
      def members
        instance_variables.map { |var| var[1..-1].to_sym }
      end
      
      def length
        instance_variables.length
      end
      
      def values
        instance_variables.map { |var| instance_variable_get(var) }
      end
            
      def values_at(*values)
        values.map { |val| instance_variable_get(instance_variables[val]) }
      end
      
      def to_h
        members.each_with_object({}) { |var, hsh| hsh[var] = instance_variable_get("@#{var}") }
      end
      
      def select(&block)
        values.select &block
      end
      
      alias :to_s :inspect
      alias :size :length
      alias :to_a :values
            
      self.class_eval(&block) if block_given?
    
      end
    self.const_set(class_name, klass) if class_name
    klass
    end
  end
end
