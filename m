Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: dra7xx: mark dra7xx_pcie_msi irq as IRQF_NO_THREAD
To: Grygorii Strashko <grygorii.strashko@ti.com>,
	Kishon Vijay Abraham I <kishon@ti.com>
References: <1446748990-27722-1-git-send-email-grygorii.strashko@ti.com>
 <563C6A7D.7040503@linutronix.de> <563D06BF.5010707@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, tony@atomide.com,
	nsekhar@ti.com, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Felipe Balbi <balbi@ti.com>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <5644599C.8030905@linutronix.de>
Date: Thu, 12 Nov 2015 10:19:24 +0100
MIME-Version: 1.0
In-Reply-To: <563D06BF.5010707@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/06/2015 08:59 PM, Grygorii Strashko wrote:
> Hi Sebastian,

Hi Grygorii,

> - IRQF_NO_THREAD is the first considered option for such kind of issues.
>   But: Now in LKML there are ~60 occurrences of IRQF_NO_THREAD - most of
>   them are used by Arch code. And It's only used by 6 drivers (drivers/*) [Addendum 2].
>   During past year, I've found only two threads related to IRQF_NO_THREAD
>   and, in both cases, IRQF_NO_THREAD was added for arch specific IRQs which
>   can't be threaded (https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-November/122659.html,
>   https://lkml.org/lkml/2015/4/21/404).

That powerpc patch you reference is doing the same thing you are doing
here.

> - ARM UP system: TI's am437xx SoCs for example.
>    Here everything is started from /drivers/irqchip/irq-gic.c -> gic_handle_irq()
> 

> GIC IRQ handler gic_handle_irq() may process more than one IRQ without leaving HW IRQ mode
> (during my experiments I saw up to 6 IRQs processed in one cycle).

not only GIC. But then what good does it do if it leaves and returns
immediately back to the routine?

> As result, It was concluded, that having such current HW/SW and all IRQs forced threaded [1],
> it will be potentially possible to predict system behavior, because gic_handle_irq() will
> do the same things for most of processed IRQs.
> But, once there will be chained [2] or IRQF_NO_THREAD [3] IRQs - complete unpredictability.

I would not go as far as "complete unpredictability". What you do (or
should do) is testing the system for longer period of time with
different behavior in order to estimate the worst case.
You can't predict the system anyway since it is way too complex. Just
try something that ensures that cyclictest is no longer cache hot and
see what happens then.

> So, It was selected as goal to have all PPI IRQs (forced) threaded. And if someone
> will require faster IRQ handling - IRQF_NO_THREAD can be always added, but it will
> be custom solution then. 
> 
> I'd be appreciated for your comments - if above problem is not a problem.
> Good - IRQF_NO_THREAD forever!

Yes, we try to avoid IRQF_NO_THREAD under all circumstances. However it
is required for low-level arch code. This includes basically
everything that is using raw-locks which includes interrupt controller
(the "real" ones like GIC or cascading like MSI or GPIO).
Here it is simple - you have a cascading MSI-interrupt controller and
as such it should be IRQF_NO_THREAD marked.
The latency spikes in worst case are not huge as explained earlier: The
only thing your cascading controller is allowed to do is to mark
interrupt as pending (which is with threaded interrupts just a task
wakeup).
And this is not a -RT only problem: it is broken in vanilla linux with
threaded interrupts as well.

Btw: There is an exception to this rule (as always): If you are on a
slow/blocking bus then you don't do IRQF_NO_THREAD. A slow bus would be
a GPIO controller behind an I2C/SPI controller which also acts as an
interrupt controller. Here you use a threaded-handler +
handle_nested_irq().

> Thanks.

Sebastian
