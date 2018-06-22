Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 22 Jun 2018 21:44:44 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] genirq: Synchronize only with single thread on
 free_irq()
In-Reply-To: <20180622080125.GA13709@wunner.de>
Message-ID: <alpine.DEB.2.21.1806222144160.1589@nanos.tec.linutronix.de>
References: <8f770886632640321592873e4c902218d42c436b.1527194314.git.lukas@wunner.de> <alpine.DEB.2.21.1806212217571.1591@nanos.tec.linutronix.de> <20180622080125.GA13709@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 22 Jun 2018, Lukas Wunner wrote:
> On Thu, Jun 21, 2018 at 10:21:44PM +0200, Thomas Gleixner wrote:
> > On Thu, 24 May 2018, Lukas Wunner wrote:
> > >  static int irq_wait_for_interrupt(struct irqaction *action)
> > >  {
> > > -	set_current_state(TASK_INTERRUPTIBLE);
> > > +	for (;;) {
> > > +		set_current_state(TASK_INTERRUPTIBLE);
> > >  
> > > -	while (!kthread_should_stop()) {
> > > +		if (kthread_should_stop()) {
> > > +			/* may need to run one last time. */
> > > +			if (test_and_clear_bit(IRQTF_RUNTHREAD,
> > > +					       &action->thread_flags)) {
> > > +				__set_current_state(TASK_RUNNING);
> > > +				return 0;
> > > +			}
> > > +			__set_current_state(TASK_RUNNING);
> > > +			return -1;
> > > +		}
> > >  
> > >  		if (test_and_clear_bit(IRQTF_RUNTHREAD,
> > >  				       &action->thread_flags)) {
> > > @@ -766,10 +776,7 @@ static int irq_wait_for_interrupt(struct irqaction *action)
> > >  			return 0;
> > >  		}
> > >  		schedule();
> > > -		set_current_state(TASK_INTERRUPTIBLE);
> > >  	}
> > > -	__set_current_state(TASK_RUNNING);
> > > -	return -1;
> > >  }
> > >  
> > >  /*
> > > @@ -990,7 +997,7 @@ static int irq_thread(void *data)
> > >  	/*
> > >  	 * This is the regular exit path. __free_irq() is stopping the
> > >  	 * thread via kthread_stop() after calling
> > > -	 * synchronize_irq(). So neither IRQTF_RUNTHREAD nor the
> > > +	 * synchronize_hardirq(). So neither IRQTF_RUNTHREAD nor the
> > >  	 * oneshot mask bit can be set. We cannot verify that as we
> > >  	 * cannot touch the oneshot mask at this point anymore as
> > >  	 * __setup_irq() might have given out currents thread_mask
> > > @@ -1595,7 +1602,7 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
> > >  	unregister_handler_proc(irq, action);
> > >  
> > >  	/* Make sure it's not being used on another CPU: */
> > > -	synchronize_irq(irq);
> > > +	synchronize_hardirq(irq);
> > 
> > So after that, action can be freed and when the thread above tries to
> > access it. Nice Use After Free. That needs more thought.
> 
> No, after that, kthread_stop() is called which blocks until the IRQ
> thread has completed.  Only then is the action freed.

Missed that. Fair enough.

Thanks,

	tglx
