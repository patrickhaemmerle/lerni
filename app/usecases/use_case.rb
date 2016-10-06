# This one is inspired by this article:
# http://webuild.envato.com/blog/a-case-for-use-cases/

module UseCase extend ActiveSupport::Concern
  include ActiveModel::Model

  module ClassMethods
    # The perform method of a UseCase should always return itself
    def perform(*args)
      new(*args).tap { |use_case| use_case.perform }
    end
  end

  # implement all the steps required to complete this use case
  def perform
    raise NotImplementedError
  end

  # inside of perform, add errors if the use case did not succeed
  def success?
    errors.none?
  end
end