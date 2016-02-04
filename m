Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56670 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754923AbcBDPOf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 10:14:35 -0500
Date: Thu, 4 Feb 2016 09:14:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kelly Zytaruk <kelly.zytaruk@amd.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] PCI: Support SRIOV on Legacy EndPoint device
Message-ID: <20160204151425.GA27474@localhost>
References: <1454597306-26189-1-git-send-email-kelly.zytaruk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454597306-26189-1-git-send-email-kelly.zytaruk@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alex, Yu (participants in previous discussion)]

Hi Kelly,

On Thu, Feb 04, 2016 at 09:48:26AM -0500, Kelly Zytaruk wrote:
> Some AMD GPUs have hardware support for grapics SRIOV.
> If the GPU has a display output then the GPU needs to support Legacy VGA operation.
> If CLASS_CODE = VGA then the device should have a Port Type = Legacy EndPoint.
> Therefore in order to enable SRIOV on a GPU with a display output LEGACY_END_POINT is supported as a valid Port Type.
> 
> Signed-off-by: Kelly Zytaruk <kelly.zytaruk@amd.com>

We had an interesting discussion about this two years ago:
http://lkml.kernel.org/r/B756807489D6244883AC0B799A6EEC15EAB2E8@storexdag02.amd.com

Please include a reference to that discussion in your changelog.  In that
discussion, I also asked for some details (dmesg and lspci info) that
motivate the change, so please collect and add a reference to them as well.

It's not clear to me why we check the device type at all.  If there's no
spec restriction on the types of devices that can have an SR-IOV
capability, we should consider removing the test altogether (Alex mentioned
this possiblity in the earlier discussion).

Bjorn

> ---
>  drivers/pci/iov.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 31f31d4..da4fbac 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -388,7 +388,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  	struct pci_dev *pdev;
>  
>  	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END &&
> -	    pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT)
> +	    pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT &&
> +	    pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END)
>  		return -ENODEV;
>  
>  	pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
