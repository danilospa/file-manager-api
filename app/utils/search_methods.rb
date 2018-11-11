# frozen_string_literal: true

module SearchMethods
  def must_terms(field, query)
    parse_terms(field, query, '+')
  end

  def must_not_terms(field, query)
    parse_terms(field, query, '-')
  end

  def parse_terms(field, query, operator)
    terms_with_operators = query.split.select { |t| t.starts_with?(operator) }
    terms_with_operators.map { |t| term(field, t[1..-1]) }
  end

  def term(field, value)
    { term: { field => value } }
  end

  def self.values_from_query(query)
    query.split.map { |value| value[1..-1] }
  end
end
