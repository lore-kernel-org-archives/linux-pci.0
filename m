Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Grant Likely <grant.likely@linaro.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [Patch v4 00/16] Enable support of IOAPIC hotplug on x86 platforms
Date: Mon, 08 Sep 2014 00:05:42 +0200
Message-ID: <1786205.ifzMNBRd6l@vostro.rjw.lan>
In-Reply-To: <1409192561-19744-1-git-send-email-jiang.liu@linux.intel.com>
References: <1409192561-19744-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, August 28, 2014 10:22:25 AM Jiang Liu wrote:
> This patch set enhances IOAPIC core and ACPI drivers to support IOAPIC
> hotplug on x86 platforms. It's based on latest mainstream kernel at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> You may pull it from 
> https://github.com/jiangliu/linux.git ioapic/hotplug_v4
> 
> We have pick up several patches from Yinghai's original IOAPIC hotplug
> patch set and reimplemented IOAPIC driver as an ACPI driver instead of
> a PCI driver.
> 
> It has been tested on a 4-socket Intel SDV with socket hot-addition
> capability. Any suggestions are welcomed!
> 
> Patch 1-5 are bugfixes and enhancements to ACPI subsystem
> Patch 6-14 enhances IOAPIC core to support IOAPIC hotplug
> Patch 15 killes PCI IOAPIC driver
> Patch 16 reimplements ACPI IOAPIC driver and enables IOAPIC hotplug
> 
> V3->V4:
> 1) Fix a bug in manage IOAPIC reference count
> 2) Rebase to v3.17-rc2
> 3) Refine commit messages
> V2->V3:
> 1) Refine ACPI resource walk functions for PCI root bus and IOAPIC
> 2) Improve commit messages
> 3) Reorder patch order for better maintenence
> 
> Jiang Liu (13):
>   x86, PCI, ACPI: Kill private function resource_to_addr() in
>     arch/x86/pci/acpi.c
>   ACPI: Correct return value of acpi_dev_resource_address_space()
>   ACPI: Fix minor syntax issues in processor_core.c
>   ACPI: Rename processor_core.c as apic_id.c
>   x86, irq: Remove __init marker for functions will be used by IOAPIC
>     hotplug
>   x86, irq: Keep balance of IOAPIC pin reference count
>   x86, irq: Refine mp_register_ioapic() to prepare for IOAPIC hotplug
>   x86, irq, ACPI: Introduce a rwsem to protect IOAPIC operations from
>     hotplug
>   x86, irq, ACPI: Implement interface to support ACPI based IOAPIC
>     hot-addition
>   x86, irq, ACPI: Implement interfaces to support ACPI based IOAPIC
>     hot-removal
>   x86, irq: Introduce helper to check whether an IOAPIC has been
>     registered
>   PCI: Remove PCI ioapic driver
>   x86, irq, ACPI: Implement ACPI driver to support IOAPIC hotplug
> 
> Yinghai Lu (3):
>   ACPI: Add interfaces to parse IOAPIC ID for IOAPIC hotplug
>   x86, irq: Split out alloc_ioapic_save_registers()
>   x86, irq: Prefer assigned ID in APIC ID register for x86_64

I don't see any major problems in this patchset, but I'd prefer it to
go through the tip tree if possible.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
