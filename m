Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46412 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbbGIN5j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Jul 2015 09:57:39 -0400
Date: Thu, 9 Jul 2015 14:58:09 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>
Subject: Re: [PATCH v3 00/15] Introducing per-device MSI domain
Message-ID: <20150709135809.GA5223@red-moon>
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 07, 2015 at 06:17:50PM +0100, Marc Zyngier wrote:
> [Picking up this series again after sleeping on it for too long,
>  hopefully still relevant]
> 
> MSI-like interrupts are starting to creep out of the PCI world, and
> can now be seen into a number of "platform"-type busses. The
> introduction of the MSI domains feature in v3.19 recognised that fact,
> and started providing a way to implement this.
> 
> Another problem we have to solve is to identify which MSI domain a
> device is "connected" to. Currently, PCI gets away with a mixture of
> arch-specific callbacks, and a msi_controller structure that can
> optionally carry a pointer to an MSI domain. As we add new bus types
> and start dealing with topologies that do not map to what PCI does,
> this doesn't scale anymore.
> 
> This patch series tries to address some of it by providing a basic
> link between 'struct device' and an MSI domain. It also adds :
> 
> - a way to "tag" domains according to the "type" of interrupt it
>   provides (PCI/MSI, platform MSI...), allowing a driver for a piece
>   of HW identified by its device_node to provide several IRQ domains
> 
> - (yet another) way for PCI to propagate the domain pointer through
>   the PCI device hierarchy, providing a method for OF to kick-start
>   the propagation process, and finally allowing the PCI/MSI layer to
>   use that information
> 
> - a similar way to hook an MSI domain to a platform device.
> 
> Hopefully this can serve as a model to implement support for different
> but types.
> 
> Additionally, the last few patches use all the above to remove any
> trace of the msi_controller structure from the three MSI controllers
> we use on arm64, so that they solely rely on the above infrastructure,
> leading to some interesting improvements. We take this opportunity to
> also kill the domain pointer from the msi_controller structure.
> 
> My hope is to eventually kill msi_controller entirely, and only rely
> on the msi_domain contained in the device structure (any help
> welcomed).

And kill pcibios_msi_controller from arch/arm, which means we have
to convert all arm platforms relying on pci_sys_data for the MSI look-up,
I only have an iMX6 Sabrelite, so yes, help is welcome here.

BTW, is there a reason why _all_ arm host bridges rely on
pcibios_msi_controller (so pci_sys_data) instead of initializing
the struct pci_bus.msi pointer to carry out the MSI controller look-up ?

I do not see any (and I want to get rid of pcibios_msi_controller on
arm asap, if we can use the struct pci_bus.msi pointer patch that's
trivial).

I know that the way forward is by doing it through domains and this
patchset, just asking (to understand why pcibios_msi_controller is
even needed on arm at present).

> This has been tested on arm64 with GICv2m (AMD Seattle) and GICv3 ITS
> (FVP model).

I tested it on arm64 AMD Seattle too, so FWIW:

Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> Patches are on top of 4.2-rc1 and available at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/msi_domain
> 
> As always, comments most welcome.
> 
> Marc Zyngier (15):
>   genirq: irqdomain: Allow irq domain aliasing
>   PCI: MSI: Register irq domain with specific token
>   device core: Introduce per-device MSI domain pointer
>   PCI/MSI: Add hooks to populate the msi_domain field
>   PCI/MSI: of: Add support for OF-provided msi_domain
>   PCI/MSI: of: Allow msi_domain lookup using the host bridge node
>   PCI/MSI: Let pci_msi_get_domain use struct device's msi_domain
>   platform: of: Assign MSI domain to platform device
>   irqchip: gicv3-its: Split PCI/MSI code from the core ITS driver
>   irqchip: gicv3-its: Register irq domain with platform MSI token
>   irqchip: GICv2m: Get rid of struct msi_controller
>   irqchip: gicv3-its: Get rid of struct msi_controller
>   irqchip: gicv3-its: Make the PCI/MSI code standalone
>   PCI/MSI: pci-xgene-msi: Get rid of struct msi_controller
>   PCI/MSI: Drop domain field from msi_controller
> 
>  arch/powerpc/platforms/512x/mpc5121_ads_cpld.c   |   3 +-
>  arch/powerpc/platforms/cell/interrupt.c          |   3 +-
>  arch/powerpc/platforms/embedded6xx/flipper-pic.c |   3 +-
>  arch/powerpc/platforms/powermac/pic.c            |   3 +-
>  arch/powerpc/platforms/powernv/opal-irqchip.c    |   3 +-
>  arch/powerpc/platforms/ps3/interrupt.c           |   3 +-
>  arch/powerpc/sysdev/ehv_pic.c                    |   3 +-
>  arch/powerpc/sysdev/i8259.c                      |   3 +-
>  arch/powerpc/sysdev/ipic.c                       |   3 +-
>  arch/powerpc/sysdev/mpic.c                       |   3 +-
>  arch/powerpc/sysdev/qe_lib/qe_ic.c               |   3 +-
>  arch/powerpc/sysdev/xics/xics-common.c           |   3 +-
>  drivers/irqchip/Makefile                         |   2 +-
>  drivers/irqchip/irq-gic-v2m.c                    |  27 ++---
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c         | 135 +++++++++++++++++++++++
>  drivers/irqchip/irq-gic-v3-its.c                 | 130 ++++------------------
>  drivers/of/irq.c                                 |  16 +++
>  drivers/of/platform.c                            |   1 +
>  drivers/pci/host/pci-xgene-msi.c                 |  41 +++----
>  drivers/pci/msi.c                                |  11 +-
>  drivers/pci/of.c                                 |  24 ++++
>  drivers/pci/probe.c                              |  31 ++++++
>  include/linux/device.h                           |  20 ++++
>  include/linux/irqchip/arm-gic-v3.h               |   3 +
>  include/linux/irqdomain.h                        |  25 ++++-
>  include/linux/msi.h                              |   3 -
>  include/linux/of_irq.h                           |   1 +
>  include/linux/pci.h                              |   3 +
>  kernel/irq/irqdomain.c                           |  18 ++-
>  29 files changed, 350 insertions(+), 177 deletions(-)
>  create mode 100644 drivers/irqchip/irq-gic-v3-its-pci-msi.c
> 
> -- 
> 2.1.4
> 
