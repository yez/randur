#! /home/jake/.rvm/rubies/ruby-2.0.0-p195/bin/ruby -w

class FillImages

  THREAD_POOL = 20

  def threaded_fill(amount)
    @amount_to_fetch = amount
    join_threads
  end

  def threads
    @threads = []
    THREAD_POOL.times do |i|
      @threads << Thread.new do
        while @amount_to_fetch > 0
          RandomImage.new
          sleep(0.5)
          @amount_to_fetch -= 1 
        end
      end
    end
  end

  def join_threads
    threads
    @threads.each { |tr| tr.join }
  end
end