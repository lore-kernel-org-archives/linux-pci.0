Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44789 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbeFXJrg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Jun 2018 05:47:36 -0400
Date: Sun, 24 Jun 2018 11:47:31 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] genirq: Update code comments wrt recycled
 thread_mask
In-Reply-To: <32fc25aa35ecef4b2692f57687bb7fc2a57230e2.1529828292.git.lukas@wunner.de>
Message-ID: <alpine.DEB.2.21.1806241145320.8650@nanos.tec.linutronix.de>
References: <32fc25aa35ecef4b2692f57687bb7fc2a57230e2.1529828292.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lukas,

On Sun, 24 Jun 2018, Lukas Wunner wrote:

> Previously a race existed between __free_irq() and __setup_irq() wherein
> the thread_mask of a just removed action could be handed out to a newly
> added action and the freed irq thread would then tread on the oneshot
> mask bit of the newly added irq thread in irq_finalize_oneshot():
> 
> time
>  |  __free_irq()
>  |    raw_spin_lock_irqsave(&desc->lock, flags);
>  |    <remove action from linked list>
>  |    raw_spin_unlock_irqrestore(&desc->lock, flags);
>  |
>  |  __setup_irq()
>  |    raw_spin_lock_irqsave(&desc->lock, flags);
>  |    <traverse linked list to determine oneshot mask bit>
>  |    raw_spin_unlock_irqrestore(&desc->lock, flags);
>  |
>  |  irq_thread() of freed irq (__free_irq() waits in synchronize_irq())
>  |    irq_thread_fn()
>  |      irq_finalize_oneshot()
>  |        raw_spin_lock_irq(&desc->lock);
>  |        desc->threads_oneshot &= ~action->thread_mask;
>  |        raw_spin_unlock_irq(&desc->lock);
>  v
> 
> The race was known at least since 2012 when it was documented in a code
> comment by commit e04268b0effc ("genirq: Remove paranoid warnons and
> bogus fixups").

The race was known, but it was also harmless as nothing would touch stuff
after synchronize_irq().

> But it wasn't until 2017 that it was fixed by commit 9114014cf4e6
> ("genirq: Add mutex to irq desc to serialize request/free_irq()"),
> apparently inadvertantly so because the race is neither mentioned in the
> commit message nor was the code comment updated.  Make up for that.

Thanks for following up. This update is very well done.

       tglx
