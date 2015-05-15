require "rg_factory/version"

class RgFactory
  def self.new(*atrs)
    Class.new do
      atrs.each { |atr| attr_accessor atr }
      define_method :initialize do |*params|
        params.each_with_index do |param, index|
          instance_variable_set("@#{atrs[index]}", param)
        end
      end
      
      def inspect
        "#{self.class.superclass.name} #{self.class.name} #{self.instance_variables.map{ |var| "#{var}=#{instance_variable_get(var)}" }.join(", ") }"
      end
      
      alias :to_s :inspect
      
      def ==(obj)
        self.inspect == obj.inspect 
      end
    
      def [](var)
        var_name = var.is_a?(Fixnum) ? instance_variables[var.to_i] : "@#{var.to_s}"
        instance_variable_get(var_name)
      end
      
      def []=(var, value)
        var_name = var.is_a?(Fixnum) ? instance_variables[var.to_i] : "@#{var.to_s}"
        instance_variable_set(var_name, value)
      end
      
      def each#(&block)     
#        if block_given?
#          instance_variables.map{ |var| instance_variable_get(var) }.each &block
#        else
          instance_variables.map{ |var| instance_variable_get(var) }.each
#        end
      end
      
      def members
        instance_variables.map { |var| var[1..-1].to_sym }
      end
      
      def length
        instance_variables.length
      end
      
      alias :size :length
      
      def values
        instance_variables.map { |var| instance_variable_get(var) }
      end
      
      alias :to_a :values
      
      def values_at(*values)
        values.map { |val| instance_variable_get(instance_variables[val]) }
      end
      
      def to_h
        members.each_with_object({}) { |var, hsh| hsh[var] = instance_variable_get("@#{var}") }
      end
    
      end
    end
  

  
  
#  def to_s(obj)
#    "#{self.class.downcase} #{obj.to_h.map{|k,v| "#{k}=#{v}"}.join(", ")}"
#  end
end
      
      
      
      
      
      
