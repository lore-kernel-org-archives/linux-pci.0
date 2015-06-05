Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 5 Jun 2015 16:24:17 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [Patch v2 0/4] Introduce a mechanism to allocate PCI IRQ on
 demand
Message-ID: <20150605212417.GU3631@google.com>
References: <1433213360-3700-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433213360-3700-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 02, 2015 at 10:49:15AM +0800, Jiang Liu wrote:
> This patch set introduces a mechanism to allocate PCI IRQ on demand and
> free it when not used anymore by hooking pci_device_probe() and
> pci_device_remove().
> 
> It will be used to track IOAPIC pin usage on x86 so we could support
> IOAPIC hot-removal.
> 
> The patch set passes Fengguang's 0day test suite.
> 
> V1->V2:
> 1) Refine pci_device_probe() to optimize for mainline code as suggested
>    by Bjorn
> 2) Reorder patch set to put optional patch as the last (Patch 4)
> 
> Thanks!
> Gerry
> 
> 
> Jiang Liu (4):
>   PCI: Add hooks to allocate/free IRQ resources when binding/unbinding
>     driver
>   PCI, x86: Allocate PCI IRQ on demand and free it when not used
>     anymore
>   PCI: Introduce helpers to manage pci_dev->irq and
>     pci_dev->irq_managed
>   PCI, MSI: Optionally free legacy PCI IRQ when enabling MSI/MSI-X
> 
>  arch/x86/include/asm/pci_x86.h |    2 --
>  arch/x86/pci/common.c          |   20 +++++++++-----------
>  arch/x86/pci/intel_mid_pci.c   |    9 ++++++---
>  arch/x86/pci/irq.c             |   23 ++++-------------------
>  drivers/acpi/pci_irq.c         |   17 ++++-------------
>  drivers/pci/msi.c              |    6 +++++-
>  drivers/pci/pci-driver.c       |   26 ++++++++++++++++++++------
>  include/linux/pci.h            |   19 +++++++++++++++++++
>  8 files changed, 67 insertions(+), 55 deletions(-)

I'm fine with these patches, and I can merge them, but I would like an ack
from Thomas.

Or, if it makes more sense to route these along with other related patches
through Thomas, here's my ack:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
