Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0042.outbound.protection.outlook.com ([104.47.40.42]:29453
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753898AbcK3RFb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Nov 2016 12:05:31 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "manoha@qca.qualcomm.com" <manoha@qca.qualcomm.com>
Subject: RE: CPU stall with TP-Link wifi PCIe card
Date: Wed, 30 Nov 2016 16:50:26 +0000
Message-ID: <8520D5D51A55D047800579B094147198263A1961@XAP-PVEXMBX02.xlnx.xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just to add, im using 4.6 kernel version. And the card is working on ARM, X=
86 machine.

> Subject: CPU stall with TP-Link wifi PCIe card
>=20
> Hi,
>=20
> We are testing TP-link wifi PCIe card(TL-WDN4800) on our soc (pcie-xilinx=
-
> nwl.c). This card is using
> legacy interrupts and it doesn't support MSI.
>=20
> When we do scan on wifi interface(using "iw dev wlan0 scan") cpu is getti=
ng
> stalled
> making whole system hang.
>=20
> After debugging found that IRQ is being disabled after getting 1 or 2 int=
errupts
> immediately after we run the scan command.
>=20
> But interrupts are being received to root port continuously but not being
> serviced by EP due to following
> condition, due to continuous interrupts cpu is getting stalled.
>=20
> In handle_simple_irq:
>=20
> if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
>                 desc->istate |=3D IRQS_PENDING;
>                 goto out_unlock;
>   }
>=20
> The irqd_irq_disabled(&desc->irq_data) is returning 1 after 1 or 2 interr=
upts after
> we scan.
>=20
> Can any one tell why irq is going into disabled state ?
>=20
> What might be the source that's making it go into disabled state ?
>=20
> Thanks & Regards,
> Bharat
>=20

