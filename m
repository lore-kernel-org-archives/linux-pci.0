Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbeILHud (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Sep 2018 03:50:33 -0400
Date: Tue, 11 Sep 2018 21:48:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: linux-pci@vger.kernel.org, okaya@codeaurora.org,
        bhelgaas@google.com
Subject: Re: [PATCH for-rc] PCI: Fix enabling of PASID on RC integrated
 endpoints
Message-ID: <20180912024817.GD118330@bhelgaas-glaptop.roam.corp.google.com>
References: <1536607662-11690-1-git-send-email-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1536607662-11690-1-git-send-email-Felix.Kuehling@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 10, 2018 at 03:27:42PM -0400, Felix Kuehling wrote:
> Set the eetlp_prefix_path on PCIE_EXP_TYPE_RC_END devices to allow PASID
> to be enabled on them. This fixes IOMMUv2 initialization on AMD Carrizo
> APUs.
> 
> Fixes: 7ce3f912ae ("PCI: Enable PASID only if entire path supports End-End TLP prefixes")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201079
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

Applied to for-linus for v4.19, thanks!

> ---
>  drivers/pci/probe.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ec78400..201f9e5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2074,6 +2074,7 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
>  {
>  #ifdef CONFIG_PCI_PASID
>  	struct pci_dev *bridge;
> +	int pcie_type;
>  	u32 cap;
>  
>  	if (!pci_is_pcie(dev))
> @@ -2083,7 +2084,9 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
>  	if (!(cap & PCI_EXP_DEVCAP2_EE_PREFIX))
>  		return;
>  
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> +	pcie_type = pci_pcie_type(dev);
> +	if (pcie_type == PCI_EXP_TYPE_ROOT_PORT ||
> +	    pcie_type == PCI_EXP_TYPE_RC_END)
>  		dev->eetlp_prefix_path = 1;
>  	else {
>  		bridge = pci_upstream_bridge(dev);
> -- 
> 2.7.4
> 
