Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730218AbeISCzg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Sep 2018 22:55:36 -0400
Date: Tue, 18 Sep 2018 16:21:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Patrick Talbert <ptalbert@redhat.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [[v1]] PCI/ASPM: Do not initialize link state when aspm_disabled
 is set
Message-ID: <20180918212107.GD13616@bhelgaas-glaptop.roam.corp.google.com>
References: <1536131573-15087-1-git-send-email-ptalbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1536131573-15087-1-git-send-email-ptalbert@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 05, 2018 at 09:12:53AM +0200, Patrick Talbert wrote:
> Now that ASPM is configured for *all* PCIE devices at boot, a problem is seen
> with systems that set the FADT NO_ASPM bit. This bit indicates that the OS
> should not alter the ASPM state, but when pcie_aspm_init_link_state() runs it
> only checks for !aspm_support_enabled. This misses the ACPI_FADT_NO_ASPM case
> because that is setting aspm_disabled.
> 
> The result is systems may hang at boot after 1302fcf; avoidable if they boot
> with pcie_aspm=off (sets !aspm_support_enabled).
> 
> Fix this by having aspm_init_link_state() check for either !aspm_support_enabled
> or acpm_disabled.
> 
> Fixes: 1302fcf ("PCI: Configure *all* devices, not just hot-added ones")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201001
> Signed-off-by: Patrick Talbert <ptalbert@redhat.com>

Applied to pci/aspm for v4.20, thanks!

> ---
>  drivers/pci/pcie/aspm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 53269167..4feb8ba 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -895,7 +895,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>  	struct pcie_link_state *link;
>  	int blacklist = !!pcie_aspm_sanity_check(pdev);
>  
> -	if (!aspm_support_enabled)
> +	if (!aspm_support_enabled || aspm_disabled)
>  		return;
>  
>  	if (pdev->link_state)
> -- 
> 1.8.3.1
> 
