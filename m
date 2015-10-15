Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36722 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbbJOPjd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 Oct 2015 11:39:33 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Ma Jun <majun258@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 0/7] Adding core support for wire-MSI bridges
Date: Thu, 15 Oct 2015 16:39:21 +0100
Message-Id: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There seems to be a new class of interrupt controller out there whose
sole purpose (apart from making everybody's life a nightmare) is to
turn wired interrupts into MSIs.

Instead of considering that the MSIs allocated to a device are for the
direct use of that device, we can turn this set of MSIs into a irq
domain, and use that domain to build a standard irqchip on top of
that.

This requires some (slightly ugly) surgery in both the generic MSI and
platform MSI layers, but the amount of code is actually relatively
small (about +150 LoC so far).

On top of that, we add a dummy driver for a such a bridge, hoping that
this will give enough information to driver authors so that they can
use this new feature. An even more stupid client driver is provided to
show the interrupt stack allocation:

     dummydev dummy-dev: Probing
     dummydev dummy-dev: Allocated IRQ35
     dummydev dummy-dev: Probing OK
     dummydev dummy-dev: IRQ35 hwirq 5 domain msichip_domain_ops
     dummydev dummy-dev: IRQ35 hwirq 0 domain msi_domain_ops
     dummydev dummy-dev: IRQ35 hwirq 8192 domain its_domain_ops
     dummydev dummy-dev: IRQ35 hwirq 8192 domain gic_irq_domain_ops

While this seems to work, it is far from being perfect:

- This is a prototype: error handling is rubbish, and there could be
  better abstractions to use.

- It relies on not declaring this bridge with IRQCHIP_DECLARE in order
  to prevent the DT layer from allocating interrupts behind our back.

- There is some probe ordering issues between the bridge and the wired
  interrupt device, leading to the use of -EPROBE_DEFER.

The last two points could be addressed directly in the OF layer, as
this is a generic device ordering issue (and people are already
working on that).

I'd welcome any comment on that approach (though I'm going to make
myself scarse over the next two weeks).

Marc Zyngier (7):
  platform-msi: Allow MSIs to be allocated in chunks
  platform-msi: Factor out allocation/free of private data
  irqdomain: Make irq_domain_alloc_irqs_recursive available
  genirq/msi: Make the .prepare callback reusable
  genirq/msi: Add msi_domain_populate_irqs
  platform-msi: Allow creation of a MSI-based stacked irq domain
  irqchip: [Example] dummy wired interrupt/MSI bridge driver

 drivers/base/platform-msi.c   | 185 ++++++++++++++++++++--------
 drivers/irqchip/Kconfig       |   7 ++
 drivers/irqchip/Makefile      |   1 +
 drivers/irqchip/irq-msichip.c | 271 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/irqdomain.h     |   3 +
 include/linux/msi.h           |  16 +++
 kernel/irq/irqdomain.c        |   6 +-
 kernel/irq/msi.c              |  47 +++++++-
 8 files changed, 481 insertions(+), 55 deletions(-)
 create mode 100644 drivers/irqchip/irq-msichip.c

-- 
2.1.4

