Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46754 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbaJ1MKd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Oct 2014 08:10:33 -0400
Message-ID: <1414498231.3300.3.camel@pengutronix.de>
Subject: Re: Setting cpu affinity for MSI-X on i.mx6 possible?
From: Lucas Stach <l.stach@pengutronix.de>
To: Heiner Kallweit <heiner.kallweit@web.de>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 28 Oct 2014 13:10:31 +0100
In-Reply-To: <544E99FD.5040306@web.de>
References: <544D37F7.2060800@web.de>
	 <1414399977.2421.1.camel@pengutronix.de> <544E99FD.5040306@web.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 27.10.2014, 20:16 +0100 schrieb Heiner Kallweit:
> Thanks, Lucas.
> 
> It's interesting however that the igb driver claims it's using MSI-X.
> Maybe the DW PCIE drivers offers MSI-X on the bus and just internally falls back to MSI?
> 
Are you running a upstream or downstream vendor kernel?
On my upstream kernel igb properly falls back to MSI.

Regards,
Lucas

> Rgds, Heiner
> 
> [    4.165850] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.2.15-k
> [    4.172930] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    4.178638] igb 0000:01:00.0: enabling device (0140 -> 0142)
> [    4.235789] igb 0000:01:00.0: added PHC on eth0
> [    4.235793] igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection
> [    4.235799] igb 0000:01:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 00:01:c0:14:b1:58
> [    4.235804] igb 0000:01:00.0: eth0: PBA No: FFFFFF-0FF
> [    4.235810] igb 0000:01:00.0: Using MSI-X interrupts. 2 rx queue(s), 2 tx queue(s)
> 
> 
> Am 27.10.2014 um 09:52 schrieb Lucas Stach:
> > Hello Heiner,
> > 
> > Am Sonntag, den 26.10.2014, 19:05 +0100 schrieb Heiner Kallweit:
> >> I use a mini pc with i.mx6 dual and Intel igb based nic (I211) connected via PCIE.
> >> igb driver uses MSI-X and creates two rx/tx queue pairs. However the IRQs of all queues are handled by the same CPU.
> >> Changing affinity is not possible. Obvious direct reason is that irq_chip PCI-MSI doesn't implement the callback
> >> for setting cpu affinity.
> >> I'd appreciate a hint whether this is a general limitation of the Cortex-A9 / GICv1 / Synopsys Designware
> >> architecture or whether just a proper implementation is missing yet.
> >>
> >> Rgds, Heiner
> > 
> > The MSI controller on imx6 doesn't support MSI-X so igb falls back to
> > regular MSI interrupts. Also all MSI interrupts are aggregated into a
> > single GIC interrupt line. This means the best we could do is switch all
> > PCIe MSI interrupts to some other CPU. Configuring the CPU affinity on a
> > per interrupt basis is impossible on this hardware.
> > 
> > Regards,
> > Lucas
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

