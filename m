Return-Path: <bharatku@xilinx.com>
Return-Path: <bharatku@xilinx.com>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "manoha@qca.qualcomm.com"
	<manoha@qca.qualcomm.com>
Subject: CPU stall with TP-Link wifi PCIe card
Date: Wed, 30 Nov 2016 13:32:49 +0000
Message-ID: <8520D5D51A55D047800579B094147198263A1763@XAP-PVEXMBX02.xlnx.xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi,=20

We are testing TP-link wifi PCIe card(TL-WDN4800) on our soc (pcie-xilinx-n=
wl.c). This card is using=20
legacy interrupts and it doesn't support MSI.

When we do scan on wifi interface(using "iw dev wlan0 scan") cpu is getting=
 stalled=20
making whole system hang.

After debugging found that IRQ is being disabled after getting 1 or 2 inter=
rupts=20
immediately after we run the scan command.

But interrupts are being received to root port continuously but not being s=
erviced by EP due to following=20
condition, due to continuous interrupts cpu is getting stalled.=20

In handle_simple_irq:

if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
                desc->istate |=3D IRQS_PENDING;
                goto out_unlock;
  }   =20

The irqd_irq_disabled(&desc->irq_data) is returning 1 after 1 or 2 interrup=
ts after we scan.

Can any one tell why irq is going into disabled state ?

What might be the source that's making it go into disabled state ?

Thanks & Regards,
Bharat
