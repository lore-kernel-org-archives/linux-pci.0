Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47739 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753386AbcANQbf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Jan 2016 11:31:35 -0500
Date: Thu, 14 Jan 2016 16:33:13 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
Subject: Re: [PATCH V3 14/21] x86, ia64: Include acpi_pci_{add|remove}_bus to
 the default pcibios_{add|remove}_bus implementation.
Message-ID: <20160114163313.GB19513@red-moon>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-15-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452691267-32240-15-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 13, 2016 at 02:21:00PM +0100, Tomasz Nowicki wrote:
> Arches in subject are the only one who use pcibios_{add|remove}_bus hooks

"x86 and ia64 are the only arches that implement..."

> and implement it in the same way. Moreover ARM64 is going to do the same.

"implement them"

> So it seams that acpi_pci_{add|remove}_bus is generic enough to be default

s/seams/seems

> option for pcibios_{add|remove}_bus hooks. Also, it is always safe to run
> acpi_pci_{add|remove}_bus as they have empty stubs for !ACPI case and
> return if ACPI has been switched off in run time.
> 
> After all we can remove x86 and ia64 pcibios_{add|remove}_bus
> implementation.

I think you should rephrase the commit log and fix the typos.

> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  arch/ia64/pci/pci.c   | 10 ----------
>  arch/x86/pci/common.c | 10 ----------
>  drivers/pci/probe.c   |  3 +++
>  3 files changed, 3 insertions(+), 20 deletions(-)

Patch seems fine to me, I do not see why moving the acpi calls into
generic code would create issues (and why it has not been done before)
as you mentioned in the commit log, so:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
> index 978d6af..be4c9ef 100644
> --- a/arch/ia64/pci/pci.c
> +++ b/arch/ia64/pci/pci.c
> @@ -358,16 +358,6 @@ void pcibios_fixup_bus(struct pci_bus *b)
>  	platform_pci_fixup_bus(b);
>  }
>  
> -void pcibios_add_bus(struct pci_bus *bus)
> -{
> -	acpi_pci_add_bus(bus);
> -}
> -
> -void pcibios_remove_bus(struct pci_bus *bus)
> -{
> -	acpi_pci_remove_bus(bus);
> -}
> -
>  void pcibios_set_master (struct pci_dev *dev)
>  {
>  	/* No special bus mastering setup handling */
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index eccd4d9..ed3236d 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -171,16 +171,6 @@ void pcibios_fixup_bus(struct pci_bus *b)
>  		pcibios_fixup_device_resources(dev);
>  }
>  
> -void pcibios_add_bus(struct pci_bus *bus)
> -{
> -	acpi_pci_add_bus(bus);
> -}
> -
> -void pcibios_remove_bus(struct pci_bus *bus)
> -{
> -	acpi_pci_remove_bus(bus);
> -}
> -
>  /*
>   * Only use DMI information to set this if nothing was passed
>   * on the kernel command line (which was parsed earlier).
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index cad836f..2fbf840 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/cpumask.h>
> +#include <linux/pci-acpi.h>
>  #include <linux/pci-aspm.h>
>  #include <linux/aer.h>
>  #include <linux/acpi.h>
> @@ -2067,10 +2068,12 @@ int __weak pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  
>  void __weak pcibios_add_bus(struct pci_bus *bus)
>  {
> +	acpi_pci_add_bus(bus);
>  }
>  
>  void __weak pcibios_remove_bus(struct pci_bus *bus)
>  {
> +	acpi_pci_remove_bus(bus);
>  }
>  
>  struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
> -- 
> 1.9.1
> 
