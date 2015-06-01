Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch v3 00/36] Split struct irq_data into common part and per-chip part
Date: Mon,  1 Jun 2015 16:05:09 +0800
Message-Id: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
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

V2->V3:
1) Add patch 1-2 to fix a regression revealed by this patch set.
   It caused me about ten days to shoot down this bug, and it also
   proves that this patch set is the right thing to do.
2) Split changes into per-arch slices
3) Kill the last direct reference to data->common->handler_data
   from file drivers/sh/intc/virq.c.

V1->V2:
1) Patch "net/mlx4: Cache irq_desc->affinity instead of irq_desc" is
   still kept to avoid build failure. It may be dropped if Amir Vadai
   changed related code.
2) Reorganize patches according to Thomas's suggestion.
3) Rename irq_data_get_msi() as irq_data_get_msi_desc().

Thanks!
Gerry

Jiang Liu (36):
  genirq: Enhance irq_data_to_desc() to support hierarchy irqdomain
  genirq: Fix crash caused by irq_move_irq() when hierarch irqdomain is
    enabled
  genirq: Introduce struct irq_common_data to host shared irq data
  genirq: Introduce helper function irq_data_get_node()
  x86, irq: Use accessor irq_data_get_node() to hide struct irq_data
    detail
  sh, irq: Use accessor irq_data_get_node() to hide struct irq_data
    detail
  genirq: Move field 'node' from struct irq_data into struct
    irq_common_data
  sparc, irq: Use helper irq_data_get_irq_handler_data() to hide
    irq_desc details
  x86, irq: Use helper irq_data_get_irq_handler_data() to hide irq_desc
    details
  x86, irq: Use helper irq_data_get_irq_handler_data() to hide irq_desc
    details
  sh, irq: Use helper irq_data_get_irq_handler_data() to hide irq_desc
    details
  genirq: Move field 'handler_data' from struct irq_data into struct
    irq_common_data
  mn10300: Fix incorrect use of data->affinity
  genirq: Introduce helper function irq_data_get_affinity_mask()
  alpha, irq: Use access helper irq_data_get_affinity_mask()
  ARM, irq: Use access helper irq_data_get_affinity_mask()
  ARM64, irq: Use access helper irq_data_get_affinity_mask()
  blackfin, irq: Use access helper irq_data_get_affinity_mask()
  IA64, irq: Use access helper irq_data_get_affinity_mask()
  metag, irq: Use access helper irq_data_get_affinity_mask()
  mips, irq: Use access helper irq_data_get_affinity_mask()
  mn10300, irq: Use access helper irq_data_get_affinity_mask()
  parisc, irq: Use access helper irq_data_get_affinity_mask()
  powerpc, irq: Use access helper irq_data_get_affinity_mask()
  sh, irq: Use access helper irq_data_get_affinity_mask()
  sparc, irq: Use access helper irq_data_get_affinity_mask()
  x86, irq: Use access helper irq_data_get_affinity_mask()
  xtensa, irq: Use access helper irq_data_get_affinity_mask()
  irqchip, irq: Use access helper irq_data_get_affinity_mask()
  net/mlx4: Cache irq_desc->affinity instead of irq_desc
  genirq: Move field 'affinity' from struct irq_data into struct
    irq_common_data
  genirq: Rename irq_data_get_msi() as irq_data_get_msi_desc()
  genirq: Use helper function to access irq_data->msi_desc
  genirq: Move field 'msi_desc' from struct irq_data into struct
    irq_common_data
  genirq: Pass irq_data to helper function
    __irq_set_chip_handler_name_locked()
  genirq: Optimize irq_data_to_desc() to avoid irq_to_desc() lookup

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
 drivers/sh/intc/virq.c                       |   12 +--
 drivers/xen/events/events_base.c             |    4 +-
 include/linux/irq.h                          |  112 +++++++++++++++++---------
 include/linux/irqdesc.h                      |   23 ++++--
 kernel/irq/chip.c                            |    4 +-
 kernel/irq/internals.h                       |   17 ++--
 kernel/irq/irqdesc.c                         |   27 +++----
 kernel/irq/irqdomain.c                       |    5 +-
 kernel/irq/manage.c                          |   14 ++--
 kernel/irq/migration.c                       |    9 ++-
 kernel/irq/proc.c                            |    4 +-
 54 files changed, 277 insertions(+), 209 deletions(-)

-- 
1.7.10.4

