Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42785 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbcB2SAW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Feb 2016 13:00:22 -0500
Date: Mon, 29 Feb 2016 12:00:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kelly.zytaruk@amd.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Support SRIOV on Legacy EndPoint device
Message-ID: <20160229180018.GA3653@localhost>
References: <1455041338-3644-1-git-send-email-kelly.zytaruk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455041338-3644-1-git-send-email-kelly.zytaruk@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 09, 2016 at 01:08:58PM -0500, kelly.zytaruk@amd.com wrote:
> From: Kelly Zytaruk <kelly.zytaruk@amd.com>
> 
> It is not neccessary to check for PCI_EXP_TYPE in sriov_init().  There appears to be no reason for the check.
> 
> Some AMD GPUs have hardware support for grapics SRIOV.
> If the GPU has a display output then the GPU needs to support Legacy VGA operation.
> If CLASS_CODE = VGA then the device should have a Port Type = Legacy EndPoint.
> Therefore in order to enable SRIOV on a GPU with a display output, LEGACY_END_POINT is supported as a valid Port Type by removing the check for Port Type.
> 
> Patch is also logged in Bugzilla #112221
> 
> Signed-off-by: Kelly Zytaruk <kelly.zytaruk@amd.com>

Applied to pci/virtualization for v4.6, with changelog as follows:

    PCI: Support SR-IOV on any function type
    
    Previously, we only supported SR-IOV on PCI Express Endpoints and Root
    Complex Integrated Endpoints.  This restriction has been present since
    d1b054da8f59 ("PCI: initialize and release SR-IOV capability") added SR-IOV
    support, but the spec does not require it.  In fact, the SR-IOV spec r1.1,
    sec 3.3, says the SR-IOV extended capability may be present for any Type 0
    function.
    
    Remove the function type test, so we can support SR-IOV on any function.
    
    Some AMD GPUs have display outputs, use the VGA class code, are Legacy
    Endpoints, and support SR-IOV.  This change allows Linux to enable SR-IOV
    on these devices.
    
    [bhelgaas: changelog]
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=112221
    Signed-off-by: Kelly Zytaruk <kelly.zytaruk@amd.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/iov.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 31f31d4..fe4bd0a 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -387,10 +387,6 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  	struct resource *res;
>  	struct pci_dev *pdev;
>  
> -	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END &&
> -	    pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT)
> -		return -ENODEV;
> -
>  	pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
>  	if (ctrl & PCI_SRIOV_CTRL_VFE) {
>  		pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, 0);
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
