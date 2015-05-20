Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25385 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbbETJij (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 May 2015 05:38:39 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch v2 00/14] Split struct irq_data into common part and per-chip part
Date: Wed, 20 May 2015 17:40:31 +0800
Message-Id: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,
	Now the irq core supports hierarchy irq and stacked irqchips,
so there may be multiple irq_datas associated with the same irq. But
some fields in struct irq_data are per-irq instance and duplicating
those fields into multiple irq_data may cause troubles.
	So this patch introduces a new data structure 'struct
irq_common_data' to host per-irq instance data fields, and struct
irq_data will only host per-chip data fields after the conversion.

It's based on tip/x86/apic.

And it passes Fengguang's zeroday test suite.

V1->V2:
1) Patch "net/mlx4: Cache irq_desc->affinity instead of irq_desc" is
   still kept to avoid build failure. It may be dropped if Amir Vadai
   changed related code.
2) Reorganize patches according to Thomas's suggestion.
3) Rename irq_data_get_msi() as irq_data_get_msi_desc().

Thanks!
Gerry

Jiang Liu (14):
  genirq: Introduce struct irq_common_data to host shared irq data
  genirq: Introduce helper function irq_data_get_node()
  x86, irq: Use accessor irq_data_get_node() to hide struct irq_data
    detail
  sh, irq: Use accessor irq_data_get_node() to hide struct irq_data
    detail
  genirq: Move field 'node' from struct irq_data into struct
    irq_common_data
  genirq: Move field 'handler_data' from struct irq_data into struct
    irq_common_data
  mn10300: Fix incorrect use of data->affinity
  genirq: Introduce helper function irq_data_get_affinity_mask()
  net/mlx4: Cache irq_desc->affinity instead of irq_desc
  genirq: Move field 'affinity' from struct irq_data into struct
    irq_common_data
  genirq: Rename irq_data_get_msi() as irq_data_get_msi_desc()
  genirq: Use helper function to access irq_data->msi_desc
  genirq: Move field 'msi_desc' from struct irq_data into struct
    irq_common_data
  genirq: Pass irq_data to helper function
    __irq_set_chip_handler_name_locked()

 arch/alpha/kernel/irq.c                      |    2 +-
 arch/arm/kernel/irq.c                        |    4 +-
 arch/arm64/kernel/irq.c                      |    4 +-
 arch/blackfin/mach-common/ints-priority.c    |    3 +-
 arch/ia64/kernel/iosapic.c                   |    8 +-
 arch/ia64/kernel/irq.c                       |    6 +-
 arch/ia64/kernel/msi_ia64.c                  |    6 +-
 arch/ia64/sn/kernel/msi_sn.c                 |    4 +-
 arch/metag/kernel/irq.c                      |   10 ++-
 arch/mips/alchemy/common/irq.c               |    4 +-
 arch/mips/bcm63xx/irq.c                      |    2 +-
 arch/mips/cavium-octeon/octeon-irq.c         |   14 ++--
 arch/mips/pmcs-msp71xx/msp_irq_cic.c         |    3 +-
 arch/mn10300/kernel/cevt-mn10300.c           |    2 +-
 arch/mn10300/kernel/irq.c                    |   13 +--
 arch/parisc/kernel/irq.c                     |   12 +--
 arch/powerpc/kernel/irq.c                    |    2 +-
 arch/powerpc/sysdev/xics/ics-opal.c          |    4 +-
 arch/powerpc/sysdev/xics/ics-rtas.c          |    4 +-
 arch/sh/kernel/irq.c                         |    9 ++-
 arch/sparc/kernel/irq_64.c                   |   27 ++++---
 arch/sparc/kernel/leon_kernel.c              |    6 +-
 arch/sparc/kernel/sun4d_irq.c                |    4 +-
 arch/sparc/kernel/sun4m_irq.c                |    6 +-
 arch/tile/kernel/pci_gx.c                    |    2 +-
 arch/x86/kernel/apic/io_apic.c               |    2 +-
 arch/x86/kernel/apic/msi.c                   |    2 +-
 arch/x86/kernel/apic/vector.c                |   13 ++-
 arch/x86/kernel/hpet.c                       |    4 +-
 arch/x86/kernel/irq.c                        |    5 +-
 arch/x86/platform/uv/uv_irq.c                |    2 +-
 arch/xtensa/kernel/irq.c                     |   10 ++-
 drivers/gpio/gpio-davinci.c                  |    2 +-
 drivers/gpio/gpio-zynq.c                     |    9 +--
 drivers/irqchip/irq-metag-ext.c              |    5 +-
 drivers/irqchip/irq-mips-gic.c               |   13 ++-
 drivers/net/ethernet/mellanox/mlx4/en_cq.c   |    6 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   |    5 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |    2 +-
 drivers/parisc/iosapic.c                     |    2 +-
 drivers/pci/host/pcie-designware.c           |    2 +-
 drivers/pci/msi.c                            |    4 +-
 drivers/sh/intc/chip.c                       |    6 +-
 drivers/sh/intc/virq.c                       |    4 +-
 drivers/xen/events/events_base.c             |    4 +-
 include/linux/irq.h                          |  111 +++++++++++++++++---------
 include/linux/irqdesc.h                      |   19 +++--
 kernel/irq/chip.c                            |    4 +-
 kernel/irq/internals.h                       |   15 ++--
 kernel/irq/irqdesc.c                         |   27 +++----
 kernel/irq/irqdomain.c                       |    5 +-
 kernel/irq/manage.c                          |   14 ++--
 kernel/irq/proc.c                            |    4 +-
 53 files changed, 259 insertions(+), 203 deletions(-)

-- 
1.7.10.4

