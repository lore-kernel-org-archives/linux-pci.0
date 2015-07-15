Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40135 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940AbbGORHb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jul 2015 13:07:31 -0400
Date: Wed, 15 Jul 2015 18:07:01 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Robert Richter <rrichter@cavium.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/5] arm64, pci: Add ECAM/PCIe support for Cavium ThunderX
Message-ID: <20150715170701.GA19480@leverpostej>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Wed, Jul 15, 2015 at 05:54:40PM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The subject pretty much says it all.  The first four patches tweak the
> infrastructure a little so that we can get required behavior.  The
> final patch adds the drivers.
> 
> David Daney (5):
>   pci: Add is_pcierc element to struct pci_bus
>   gic-its: Allow pci_requester_id to be overridden.
>   arm64, pci: Allow RC drivers to supply pcibios_add_device()
>     implementation.
>   irqchip: gic-v3: Add gic_get_irq_domain() to get the irqdomain of the
>     GIC.
>   PCI: Add host drivers for Cavium ThunderX processors.
> 
>  arch/arm64/include/asm/pci.h        |   3 +
>  arch/arm64/kernel/pci.c             |  10 +
>  drivers/irqchip/irq-gic-v3-its.c    |  14 +-
>  drivers/irqchip/irq-gic-v3.c        |   5 +
>  drivers/pci/host/Kconfig            |  12 +
>  drivers/pci/host/Makefile           |   2 +
>  drivers/pci/host/pcie-thunder-pem.c | 462 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pcie-thunder.c     | 422 ++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c                 |   2 +
>  include/linux/irqchip/arm-gic-v3.h  |   3 +
>  include/linux/pci.h                 |   1 +
>  11 files changed, 935 insertions(+), 1 deletion(-)

I note that the driver attempts to probe with DT, yet there is no DT
binding in this patch, nor has the devicetree mailing list been placed
on Cc.

A DT binding document is mandatory for anything probing via DT.

Please write one, and submit it (as its own patch) with the next version
of this series as per
Documentation/devicetree/bindings/submitting-patches.txt.

Thanks,
Mark.
