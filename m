Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 30 Jul 2015 14:23:08 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [Patch v3 0/4] Introduce a mechanism to allocate PCI IRQ on
 demand
Message-ID: <20150730192308.GJ9640@google.com>
References: <1433926501-22956-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433926501-22956-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 10, 2015 at 04:54:57PM +0800, Jiang Liu wrote:
> Hi Bjorn,
> 	I have verified that this patch set could be applied to the
> mainstream kernel without dependency on other patches, so could you
> please help to merge it?
> 
> This patch set introduces a mechanism to allocate PCI IRQ on demand and
> free it when not used anymore by hooking pci_device_probe() and
> pci_device_remove().
> 
> It will be used to track IOAPIC pin usage on x86 so we could support
> IOAPIC hot-removal.
> 
> The patch set passes Fengguang's 0day test suite.
> 
> V2->V3:
> 1) Change the default pcibios_alloc_irq() to always return 0, as
>    suggested by Bjorn.
> 2) Refine comments.
> 
> V1->V2:
> 1) Refine pci_device_probe() to optimize for mainline code as suggested
>    by Bjorn
> 2) Reorder patch set to put optional patch as the last (Patch 4)
> 
> 
> Jiang Liu (4):
>   PCI: Add hooks to allocate/free IRQ resources when binding/unbinding
>     driver
>   PCI, x86: Allocate PCI IRQ on demand and free it when not used
>     anymore
>   PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed
>   PCI, MSI: Free legacy PCI IRQ when enabling MSI/MSI-X

Applied to pci/irq with the following changelogs for v4.3, thanks!

commit 890e4847587fcff5eb0438e90992ad7d2a261f33
Author: Jiang Liu <jiang.liu@linux.intel.com>
Date:   Wed Jun 10 16:54:58 2015 +0800

    PCI: Add pcibios_alloc_irq() and pcibios_free_irq()
    
    Add pcibios_alloc_irq() and pcibios_free_irq(), which are called when
    binding/unbinding PCI device drivers.
    
    PCI arch code may implement these to manage IRQ resources for hotplugged
    devices.
    
    [bhelgaas: changelog]
    Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Thomas Gleixner <tglx@linutronix.de>

commit 991de2e59090e55c65a7f59a049142e3c480f7bd
Author: Jiang Liu <jiang.liu@linux.intel.com>
Date:   Wed Jun 10 16:54:59 2015 +0800

    PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()
    
    To support IOAPIC hotplug, we need to allocate PCI IRQ resources on demand
    and free them when not used anymore.
    
    Implement pcibios_alloc_irq() and pcibios_free_irq() to dynamically
    allocate and free PCI IRQs.
    
    Remove mp_should_keep_irq(), which is no longer used.
    
    [bhelgaas: changelog]
    Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Thomas Gleixner <tglx@linutronix.de>

commit 811a4e6fce09bc9239c664c6a1a53645a678c303
Author: Jiang Liu <jiang.liu@linux.intel.com>
Date:   Wed Jun 10 16:55:00 2015 +0800

    PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed
    
    Add pci_has_managed_irq(), pci_set_managed_irq(), and
    pci_reset_managed_irq() to simplify code.  No functional change.
    
    [bhelgaas: changelog]
    Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Thomas Gleixner <tglx@linutronix.de>

commit 5f2269916b0e509f2926346b58209abfa8316143
Author: Jiang Liu <jiang.liu@linux.intel.com>
Date:   Thu Jul 30 14:00:08 2015 -0500

    PCI/MSI: Free legacy IRQ when enabling MSI/MSI-X
    
    Once MSI/MSI-X is enabled by the device driver, a PCI device won't use
    legacy IRQs again until MSI/MSI-X is disabled.
    
    Call pcibios_free_irq() when enabling MSI/MSI-X and pcibios_alloc_irq()
    when disabling MSI/MSI-X.  This allows arch code to manage resources
    associated with the legacy IRQ.
    
    [bhelgaas: changelog]
    Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Thomas Gleixner <tglx@linutronix.de>
