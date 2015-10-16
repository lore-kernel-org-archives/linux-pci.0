Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6837 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbbJPBzi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 Oct 2015 21:55:38 -0400
Subject: Re: [PATCH RFC 0/7] Adding core support for wire-MSI bridges
To: Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
Cc: Ma Jun <majun258@huawei.com>, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <56205917.7090001@linux.intel.com>
Date: Fri, 16 Oct 2015 09:55:35 +0800
MIME-Version: 1.0
In-Reply-To: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/10/15 23:39, Marc Zyngier wrote:
> There seems to be a new class of interrupt controller out there whose
> sole purpose (apart from making everybody's life a nightmare) is to
> turn wired interrupts into MSIs.
> 
> Instead of considering that the MSIs allocated to a device are for the
> direct use of that device, we can turn this set of MSIs into a irq
> domain, and use that domain to build a standard irqchip on top of
> that.
Hi Marc,
	There's a working to enable Intel VMD storage device, which
has the similar requirement. Basically a PCIe hierarchy is hidden
behind a parent PCIe device, so we need to use the PCIe irqs on parent
to de-multiple PCIe IRQs from hidden PCIe devices. Seems a chance for
consolidation here.
	cc Keith Busch <keith.busch@intel.com> who is the author of
VMD device driver.
Thanks!
Gerry

> 
> This requires some (slightly ugly) surgery in both the generic MSI and
> platform MSI layers, but the amount of code is actually relatively
> small (about +150 LoC so far).
> 
> On top of that, we add a dummy driver for a such a bridge, hoping that
> this will give enough information to driver authors so that they can
> use this new feature. An even more stupid client driver is provided to
> show the interrupt stack allocation:
> 
>      dummydev dummy-dev: Probing
>      dummydev dummy-dev: Allocated IRQ35
>      dummydev dummy-dev: Probing OK
>      dummydev dummy-dev: IRQ35 hwirq 5 domain msichip_domain_ops
>      dummydev dummy-dev: IRQ35 hwirq 0 domain msi_domain_ops
>      dummydev dummy-dev: IRQ35 hwirq 8192 domain its_domain_ops
>      dummydev dummy-dev: IRQ35 hwirq 8192 domain gic_irq_domain_ops
> 
> While this seems to work, it is far from being perfect:
> 
> - This is a prototype: error handling is rubbish, and there could be
>   better abstractions to use.
> 
> - It relies on not declaring this bridge with IRQCHIP_DECLARE in order
>   to prevent the DT layer from allocating interrupts behind our back.
> 
> - There is some probe ordering issues between the bridge and the wired
>   interrupt device, leading to the use of -EPROBE_DEFER.
> 
> The last two points could be addressed directly in the OF layer, as
> this is a generic device ordering issue (and people are already
> working on that).
> 
> I'd welcome any comment on that approach (though I'm going to make
> myself scarse over the next two weeks).
> 
> Marc Zyngier (7):
>   platform-msi: Allow MSIs to be allocated in chunks
>   platform-msi: Factor out allocation/free of private data
>   irqdomain: Make irq_domain_alloc_irqs_recursive available
>   genirq/msi: Make the .prepare callback reusable
>   genirq/msi: Add msi_domain_populate_irqs
>   platform-msi: Allow creation of a MSI-based stacked irq domain
>   irqchip: [Example] dummy wired interrupt/MSI bridge driver
> 
>  drivers/base/platform-msi.c   | 185 ++++++++++++++++++++--------
>  drivers/irqchip/Kconfig       |   7 ++
>  drivers/irqchip/Makefile      |   1 +
>  drivers/irqchip/irq-msichip.c | 271 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/irqdomain.h     |   3 +
>  include/linux/msi.h           |  16 +++
>  kernel/irq/irqdomain.c        |   6 +-
>  kernel/irq/msi.c              |  47 +++++++-
>  8 files changed, 481 insertions(+), 55 deletions(-)
>  create mode 100644 drivers/irqchip/irq-msichip.c
> 
