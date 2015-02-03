Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21845 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965737AbbBCCwM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 Feb 2015 21:52:12 -0500
Message-ID: <54D037D5.7080704@linux.intel.com>
Date: Tue, 03 Feb 2015 10:52:05 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
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
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Cohen <david.a.cohen@linux.intel.com>,
	Sander Eikelenboom <linux@eikelenboom.it>,
	David Vrabel <david.vrabel@citrix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [Patch Part2 v4 00/33] Clean up obsoleted x86 interrupt manangement
 code and interfaces
References: <1421733113-15704-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1421733113-15704-1-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ping)

On 2015/1/20 13:51, Jiang Liu wrote:
> This is a following-on patch of "[Patch Part1 v7 00/38] Convert x86 to
> hierarchy irqdomain and stacked irqchip" at
> https://lkml.org/lkml/2015/1/19/685
> 
> The precedent patch has convert x86 interrupt management subsystem to
> hierarchy irqdomain and stacked irqchip, so this patch set cleans up
> code and interfaces obsoleted by the precedent patch set.
> 
> Main changes since last version:
> 1) rebased onto v3.19-rc5
> 2) add patch 33 to avoid memory allocation/free when assigning CPU vector 
> 
> Regards,
> Gerry
> 
> Jiang Liu (29):
>   x86/irq: Kill unused old IOAPIC irqdomain interfaces
>   x86/irq: Kill unused struct mp_pin_info
>   x86/irq: Kill x86_io_apic_ops.print_entries and related interfaces
>   x86/irq: Kill x86_io_apic_ops.setup_entry and related interfaces
>   x86/irq: Kill x86_io_apic_ops.set_affinity and related interfaces
>   x86/irq: Kill x86_io_apic_ops.eoi_ioapic_pin and related interfaces
>   x86/irq: Kill GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
>   x86/irq: Clean up unused forward declarations in x86_init.h
>   irq_remapping: Clean up unsued code to support IOAPIC
>   irq_remapping/vt-d: Clean up unsued code
>   irq_remapping/amd: Clean up unsued code
>   irq_remapping: Clean up unused interfaces
>   x86/irq: Kill irq_cfg.irq_remapped
>   irq_remapping/vt-d: Move struct irq_2_iommu into
>     intel_irq_remapping.c
>   irq_remapping/amd: Move struct irq_2_irte into amd_iommu.c
>   x86/irq: Move irq_cfg.irq_2_pin into io_apic.c
>   x86/irq: Kill struct io_apic_irq_attr
>   x86/irq: Kill x86_io_apic_ops.write and x86_io_apic_ops.modify
>   x86/irq: Clean up io_apic.h
>   x86/irq: Use cached IOAPIC entry instead of reading from hardware
>   x86/irq: Kill unused alloc_irq_and_cfg_at()
>   x86/irq: Change functions only used in vector.c as static
>   x86/irq: Kill function apic_set_affinity()
>   x86/irq: Move check of cfg->move_in_progress into
>     send_cleanup_vector()
>   x86/irq: Move private data in struct irq_cfg into dedicated data
>     structure
>   x86/irq: Refine the way to calculate NR_IRQS
>   x86/irq, ACPI: Kill private function mp_register_gsi()/
>     mp_unregister_gsi()
>   x86/irq: Move irqdomain specific code into asm/irqdomain.h
>   x86/irq: Avoid memory allocation in __assign_irq_vector()
> 
> Thomas Gleixner (4):
>   x86/irq: Remove sis apic bug workaround
>   x86, ioapic: Use proper defines for the entry fields
>   x86,ioapic: Cleanup irq_trigger/polarity()
>   x86: Cleanup irq_domain ops
> 
>  arch/x86/Kconfig                     |    1 -
>  arch/x86/include/asm/hw_irq.h        |   63 ---
>  arch/x86/include/asm/io_apic.h       |  108 +----
>  arch/x86/include/asm/irq_remapping.h |   38 +-
>  arch/x86/include/asm/irq_vectors.h   |   18 +-
>  arch/x86/include/asm/irqdomain.h     |   63 +++
>  arch/x86/include/asm/x86_init.h      |   16 -
>  arch/x86/kernel/acpi/boot.c          |   70 +--
>  arch/x86/kernel/apic/htirq.c         |    2 +-
>  arch/x86/kernel/apic/io_apic.c       |  868 +++++++++-------------------------
>  arch/x86/kernel/apic/msi.c           |    2 +-
>  arch/x86/kernel/apic/vector.c        |  342 ++++++--------
>  arch/x86/kernel/devicetree.c         |   12 +-
>  arch/x86/kernel/hpet.c               |    2 +-
>  arch/x86/kernel/mpparse.c            |    9 +-
>  arch/x86/kernel/x86_init.c           |    6 -
>  arch/x86/platform/sfi/sfi.c          |   10 +-
>  arch/x86/platform/uv/uv_irq.c        |    5 +-
>  drivers/iommu/amd_iommu.c            |  153 +-----
>  drivers/iommu/intel_irq_remapping.c  |  206 +-------
>  drivers/iommu/irq_remapping.c        |   80 ----
>  drivers/iommu/irq_remapping.h        |   16 -
>  drivers/pci/quirks.c                 |    7 -
>  23 files changed, 490 insertions(+), 1607 deletions(-)
>  create mode 100644 arch/x86/include/asm/irqdomain.h
> 
