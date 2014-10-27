Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60745 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbaJ0Iw6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Oct 2014 04:52:58 -0400
Message-ID: <1414399977.2421.1.camel@pengutronix.de>
Subject: Re: Setting cpu affinity for MSI-X on i.mx6 possible?
From: Lucas Stach <l.stach@pengutronix.de>
To: Heiner Kallweit <heiner.kallweit@web.de>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Mon, 27 Oct 2014 09:52:57 +0100
In-Reply-To: <544D37F7.2060800@web.de>
References: <544D37F7.2060800@web.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Heiner,

Am Sonntag, den 26.10.2014, 19:05 +0100 schrieb Heiner Kallweit:
> I use a mini pc with i.mx6 dual and Intel igb based nic (I211) connected via PCIE.
> igb driver uses MSI-X and creates two rx/tx queue pairs. However the IRQs of all queues are handled by the same CPU.
> Changing affinity is not possible. Obvious direct reason is that irq_chip PCI-MSI doesn't implement the callback
> for setting cpu affinity.
> I'd appreciate a hint whether this is a general limitation of the Cortex-A9 / GICv1 / Synopsys Designware
> architecture or whether just a proper implementation is missing yet.
> 
> Rgds, Heiner

The MSI controller on imx6 doesn't support MSI-X so igb falls back to
regular MSI interrupts. Also all MSI interrupts are aggregated into a
single GIC interrupt line. This means the best we could do is switch all
PCIe MSI interrupts to some other CPU. Configuring the CPU affinity on a
per interrupt basis is impossible on this hardware.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

