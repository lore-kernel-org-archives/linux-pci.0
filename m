Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35077 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbcDLEnP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Apr 2016 00:43:15 -0400
Date: Mon, 11 Apr 2016 23:43:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 2/3] drivers: pci: host-generic: claim bus resources
 on PCI_PROBE_ONLY set-ups
Message-ID: <20160412044311.GB11361@localhost>
References: <1456843449-19393-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1456843449-19393-3-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456843449-19393-3-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Tue, Mar 01, 2016 at 02:44:08PM +0000, Lorenzo Pieralisi wrote:
> The PCI host generic driver does not reassign bus resources on systems
> that require the BARs set-up to be immutable (ie PCI_PROBE_ONLY) since
> that would trigger system failures. Nonetheless, PCI bus resources
> allocated to PCI bridge and devices must be claimed in order to be
> validated and inserted in the kernel resource tree, but the current
> driver omits the resources claiming and relies on arch specific kludges
> to prevent probing failure (ie preventing resources enablement on
> PCI_PROBE_ONLY systems).
> 
> This patch adds code to the PCI host generic driver that correctly
> claims bus resources upon probe on systems that are required to
> prevent reassignment after bus enumeration, so that the allocated
> resources can be enabled successfully upon PCI device drivers probing,
> without resorting to arch back-ends workarounds.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-host-generic.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index 1652bc7..e529825 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -252,7 +252,10 @@ static int gen_pci_probe(struct platform_device *pdev)
>  
>  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>  
> -	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> +
> +	if (pci_has_flag(PCI_PROBE_ONLY)) {
> +		pci_bus_claim_resources(bus);
> +	} else {
>  		pci_bus_size_bridges(bus);
>  		pci_bus_assign_resources(bus);
>  

The next patch removes the arm and arm64 pcibios_enable_device()
implementations, which implies that arm and arm64 only need the generic
version, which simply calls pci_enable_resources().  That assumes r->parent
is set.

After this patch, we'll call pci_bus_claim_resources() for the
PCI_PROBE_ONLY case, and that sets r->parent for all the resources.

Where does r->parent get set in the non-PCI_PROBE_ONLY case?  Obviously
that path *works*, because you're not changing anything there.  I'd just
like to have a hint that makes this change more obvious.

Bjorn
