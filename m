Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55822 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbbKWNrc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 Nov 2015 08:47:32 -0500
Date: Mon, 23 Nov 2015 13:47:28 +0000
From: Will Deacon <will.deacon@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] drivers: pci: host-generic: claim bus resources on
 PROBE_ONLY set-ups
Message-ID: <20151123134727.GA4236@arm.com>
References: <1447779838-15585-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1447779838-15585-2-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447779838-15585-2-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 17, 2015 at 05:03:57PM +0000, Lorenzo Pieralisi wrote:
> The PCI host generic driver does not reassign bus resources on systems
> that require the BARs set-up to be immutable (ie PROBE_ONLY) since
> that would trigger system failures. Nonetheless, PCI bus resources
> allocated to PCI bridge and devices must be claimed in order to be
> validated and inserted in the kernel resource tree, but the current
> driver omits the resources claiming and relies on arch specific kludges
> to prevent probing failure (ie preventing resources enablement on
> PROBE_ONLY systems).
> 
> This patch adds code to the PCI host generic driver that correctly
> claims bus resources upon probe on systems that are required to
> prevent reassignment after bus enumeration, so that the allocated
> resources can be enabled successfully upon PCI device drivers probing,
> without resorting to arch back-ends workarounds.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-host-generic.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Assuming patch one is accepted, then this looks fine to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index 5434c90..c62d13f 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -261,7 +261,10 @@ static int gen_pci_probe(struct platform_device *pdev)
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
> -- 
> 2.5.1
> 
