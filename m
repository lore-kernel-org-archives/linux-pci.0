Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dimitri Sivanich <sivanich@sgi.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Cohen <david.a.cohen@linux.intel.com>,
	Sander Eikelenboom <linux@eikelenboom.it>,
	David Vrabel <david.vrabel@citrix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [Patch Part2 v5 00/33] Clean up obsoleted x86 interrupt manangement code and interfaces
Date: Tue, 14 Apr 2015 10:29:37 +0800
Message-Id: <1428978610-28986-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch set "[Patch Part1 v8 00/37] Convert x86 to hierarchy irqdomain
and stacked irqchip" at http://www.spinics.net/lists/kernel/msg1967024.html
has converted x86 interrupt managment to use hierarchy irqdomain and
stacked irqchip. And this is the following-on patch set to clean up code
and interfaces obseleted by previous patch set.

With the these two patch sets combined, we have
63 files changed, 2430 insertions(+), 2613 deletions(-)
That's good, the refactor improves code maintanence with less code.

Main changes since last reviewed version:
1) rebased onto v4.0-rc6
2) add patch 33 to avoid memory allocation/free when assigning CPU vector 

Regards,
Gerry

Jiang Liu (29):
  x86/irq: Kill unused old IOAPIC irqdomain interfaces
  x86/irq: Kill unused struct mp_pin_info
  x86/irq: Kill x86_io_apic_ops.print_entries and related interfaces
  x86/irq: Kill x86_io_apic_ops.setup_entry and related interfaces
  x86/irq: Kill x86_io_apic_ops.set_affinity and related interfaces
  x86/irq: Kill x86_io_apic_ops.eoi_ioapic_pin and related interfaces
  x86/irq: Kill GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
  x86/irq: Clean up unused forward declarations in x86_init.h
  irq_remapping: Clean up unsued code to support IOAPIC
  irq_remapping/vt-d: Clean up unsued code
  irq_remapping/amd: Clean up unsued code
  irq_remapping: Clean up unused interfaces
  x86/irq: Kill irq_cfg.irq_remapped
  irq_remapping/vt-d: Move struct irq_2_iommu into
    intel_irq_remapping.c
  irq_remapping/amd: Move struct irq_2_irte into amd_iommu.c
  x86/irq: Move irq_cfg.irq_2_pin into io_apic.c
  x86/irq: Kill struct io_apic_irq_attr
  x86/irq: Kill x86_io_apic_ops.write and x86_io_apic_ops.modify
  x86/irq: Clean up io_apic.h
  x86/irq: Use cached IOAPIC entry instead of reading from hardware
  x86/irq: Kill unused alloc_irq_and_cfg_at()
  x86/irq: Change functions only used in vector.c as static
  x86/irq: Kill function apic_set_affinity()
  x86/irq: Move check of cfg->move_in_progress into
    send_cleanup_vector()
  x86/irq: Move private data in struct irq_cfg into dedicated data
    structure
  x86/irq: Refine the way to calculate NR_IRQS
  x86/irq, ACPI: Kill private function mp_register_gsi()/
    mp_unregister_gsi()
  x86/irq: Move irqdomain specific code into asm/irqdomain.h
  x86/irq: Avoid memory allocation in __assign_irq_vector()

Thomas Gleixner (4):
  x86/irq: Remove sis apic bug workaround
  x86, ioapic: Use proper defines for the entry fields
  x86,ioapic: Cleanup irq_trigger/polarity()
  x86: Cleanup irq_domain ops

 arch/x86/Kconfig                     |    1 -
 arch/x86/include/asm/hw_irq.h        |   63 ---
 arch/x86/include/asm/io_apic.h       |  103 +---
 arch/x86/include/asm/irq_remapping.h |   38 +-
 arch/x86/include/asm/irq_vectors.h   |   18 +-
 arch/x86/include/asm/irqdomain.h     |   63 +++
 arch/x86/include/asm/x86_init.h      |   16 -
 arch/x86/kernel/acpi/boot.c          |   70 +--
 arch/x86/kernel/apic/htirq.c         |    2 +-
 arch/x86/kernel/apic/io_apic.c       |  869 +++++++++-------------------------
 arch/x86/kernel/apic/msi.c           |    2 +-
 arch/x86/kernel/apic/vector.c        |  342 ++++++-------
 arch/x86/kernel/devicetree.c         |   12 +-
 arch/x86/kernel/hpet.c               |    2 +-
 arch/x86/kernel/mpparse.c            |    9 +-
 arch/x86/kernel/x86_init.c           |    6 -
 arch/x86/platform/sfi/sfi.c          |   10 +-
 arch/x86/platform/uv/uv_irq.c        |    5 +-
 drivers/iommu/amd_iommu.c            |  153 +-----
 drivers/iommu/intel_irq_remapping.c  |  206 +-------
 drivers/iommu/irq_remapping.c        |   80 ----
 drivers/iommu/irq_remapping.h        |   16 -
 drivers/pci/quirks.c                 |    7 -
 23 files changed, 491 insertions(+), 1602 deletions(-)
 create mode 100644 arch/x86/include/asm/irqdomain.h

-- 
1.7.10.4

