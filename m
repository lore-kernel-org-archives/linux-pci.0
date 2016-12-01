Return-Path: <SRS0=kBte=XQ=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=kBte=XQ=linutronix.de=tglx@kernel.org>
Date: Thu, 1 Dec 2016 10:41:56 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
    Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
    "arnd@arndb.de" <arnd@arndb.de>, "qnguyen@apm.com" <qnguyen@apm.com>,
    "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
    "sudeep.holla@arm.com" <sudeep.holla@arm.com>
Subject: RE: CPU stall with TP-Link wifi PCIe card
In-Reply-To: <8520D5D51A55D047800579B094147198263A1E2B@XAP-PVEXMBX02.xlnx.xilinx.com>
Message-ID: <alpine.DEB.2.20.1612011012320.3453@nanos>
References: <8520D5D51A55D047800579B094147198263A1E2B@XAP-PVEXMBX02.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Thu, 1 Dec 2016, Bharat Kumar Gogada wrote:

> After further debugging found that irq_enable is not being invoked by
> kernel in kernel/irq/chip.c after the few interrupts when we do wlan
> scan.
>
> In ARM64, when an interrupt arises who invokes irq_disable(struct
> irq_desc *desc)/irq_enable(struct irq_desc *desc) functions.

What invokes irq_disable()/irq_enable()? In which function is this
happening? There are exactly three places in the interrupt core which
invoke irq_disable():

__disable_irq(), which is invoked from disable_irq() and
		 disable_irq_nosync() and suspend_device_irq()
       
irq_pm_check_wakeup(), whis suspend/wakeup related

note_interrupt(), which disables interrupt when the handler refuses to
		  handle them.

There is nothing in the core code which invokes irq_disable/enable() pairs
in any interrupt handling code path and I have no idea how ARM64 would do
that.

> From my debugging for successful interrupt handling
> irq_disable->handler->irq_enabling is happening, irrespective of
> IRQD_IRQ_DISABLED state, is it correct ?

To be honest, I have not the faintest clue what you are trying to
explain/ask.

> > Just to add, im using 4.6 kernel version. And the card is working on ARM, X86
> > machine.
> > 
> > > Subject: CPU stall with TP-Link wifi PCIe card
> > >
> > > Hi,
> > >
> > > We are testing TP-link wifi PCIe card(TL-WDN4800) on our soc
> > > (pcie-xilinx- nwl.c). This card is using legacy interrupts and it
> > > doesn't support MSI.

That card information is useless. Which driver is handling the card?

You are neither telling which interrupt controller is used for this legacy
interrupt.

> > > When we do scan on wifi interface(using "iw dev wlan0 scan") cpu is
> > > getting stalled making whole system hang.
> > >
> > > After debugging found that IRQ is being disabled after getting 1 or 2
> > > interrupts immediately after we run the scan command.
> > >
> > > But interrupts are being received to root port continuously but not
> > > being serviced by EP due to following condition, due to continuous
> > > interrupts cpu is getting stalled.
> > >
> > > In handle_simple_irq:
> > >
> > > if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
> > >                 desc->istate |= IRQS_PENDING;
> > >                 goto out_unlock;
> > >   }
> > >
> > > The irqd_irq_disabled(&desc->irq_data) is returning 1 after 1 or 2
> > > interrupts after we scan.

So the interrupt is disabled, but it's not masked in hardware.

> > > Can any one tell why irq is going into disabled state ?
> > >
> > > What might be the source that's making it go into disabled state ?

Simply a call to disable_irq() or disable_irq_nosync().

If you can come up with some coherent information about the problem instead
of weird theories and useless conclusions then we might be able to help.

Thanks,

	tglx
