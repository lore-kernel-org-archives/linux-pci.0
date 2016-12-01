Return-Path: <SRS0=XKCX=XQ=xilinx.com=bharatku@kernel.org>
Return-Path: <SRS0=XKCX=XQ=xilinx.com=bharatku@kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "qnguyen@apm.com" <qnguyen@apm.com>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>
Subject: RE: CPU stall with TP-Link wifi PCIe card
Date: Thu, 1 Dec 2016 00:48:19 +0000
Message-ID: <8520D5D51A55D047800579B094147198263A1E2B@XAP-PVEXMBX02.xlnx.xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

After further debugging found that irq_enable is not being invoked by kerne=
l in kernel/irq/chip.c after the few interrupts when we do wlan scan.

In ARM64, when an interrupt arises who invokes irq_disable(struct irq_desc =
*desc)/irq_enable(struct irq_desc *desc)
functions.=20

>From my debugging for successful interrupt handling irq_disable->handler->i=
rq_enabling is happening,
irrespective of IRQD_IRQ_DISABLED state, is it correct ?

Regards,
Bharat

>=20
> Just to add, im using 4.6 kernel version. And the card is working on ARM,=
 X86
> machine.
>=20
> > Subject: CPU stall with TP-Link wifi PCIe card
> >
> > Hi,
> >
> > We are testing TP-link wifi PCIe card(TL-WDN4800) on our soc
> > (pcie-xilinx- nwl.c). This card is using legacy interrupts and it
> > doesn't support MSI.
> >
> > When we do scan on wifi interface(using "iw dev wlan0 scan") cpu is
> > getting stalled making whole system hang.
> >
> > After debugging found that IRQ is being disabled after getting 1 or 2
> > interrupts immediately after we run the scan command.
> >
> > But interrupts are being received to root port continuously but not
> > being serviced by EP due to following condition, due to continuous
> > interrupts cpu is getting stalled.
> >
> > In handle_simple_irq:
> >
> > if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
> >                 desc->istate |=3D IRQS_PENDING;
> >                 goto out_unlock;
> >   }
> >
> > The irqd_irq_disabled(&desc->irq_data) is returning 1 after 1 or 2
> > interrupts after we scan.
> >
> > Can any one tell why irq is going into disabled state ?
> >
> > What might be the source that's making it go into disabled state ?
> >
> > Thanks & Regards,
> > Bharat
> >
