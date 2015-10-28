Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54602 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731AbbJ1Qhu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 28 Oct 2015 12:37:50 -0400
Date: Wed, 28 Oct 2015 11:37:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Duyck <aduyck@mirantis.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iov: Reset resources to 0 if totalVFs increases
 after enabling ARI
Message-ID: <20151028163747.GA29223@localhost>
References: <20151027204607.14626.59671.stgit@localhost.localdomain>
 <20151027205221.14626.8940.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151027205221.14626.8940.stgit@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,

On Tue, Oct 27, 2015 at 01:52:21PM -0700, Alexander Duyck wrote:
> This patch forces us to reallocate VF BARs if the totalVFs value has
> increased after enabling ARI.  This normally shouldn't occur, however I
> have seen some non-spec devices that shift between 7 and some value greater
> than 7 based on the ARI value and we want to avoid triggering any issues
> with such devices.

Can you include specifics about the devices?  The value "7" is pretty
specific, so if we're going to include that level of detail, we should
have the actual device info to go with it.

I guess the problem is:

  - Device supports 7 TotalVFs with ARI disabled, >7 with ARI enabled
  - Firmware leaves ARI disabled in SRIOV_CTRL
  - Firmware computes size based on 7 VFs
  - Firmware allocates space and programs BARs for 7 VFs
  - Linux enables ARI, reads >7 TotalVFs
  - Linux computes size based on >7 VFs
  - Increased size may overlap other resources

Right?

> Fixes: 3aa71da412fe ("PCI: Enable SR-IOV ARI Capable Hierarchy before reading TotalVFs")
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/pci/iov.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 099050d78a39..238950412de0 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -393,7 +393,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  	int rc;
>  	int nres;
>  	u32 pgsz;
> -	u16 ctrl, total;
> +	u16 ctrl, total, orig_total;
>  	struct pci_sriov *iov;
>  	struct resource *res;
>  	struct pci_dev *pdev;
> @@ -402,6 +402,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  	    pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT)
>  		return -ENODEV;
>  
> +	pci_read_config_word(dev, pos + PCI_SRIOV_TOTAL_VF, &orig_total);
>  	pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
>  	if (ctrl & PCI_SRIOV_CTRL_VFE) {
>  		pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, 0);
> @@ -450,6 +451,14 @@ found:
>  		}
>  		iov->barsz[i] = resource_size(res);
>  		res->end = res->start + resource_size(res) * total - 1;
> +
> +		/* force reallocation of BARs if total VFs increased */
> +		if (orig_total < total) {
> +			res->flags |= IORESOURCE_UNSET;
> +			res->end -= res->start;
> +			res->start = 0;
> +		}

Two thoughts here:

1) Even if the required space increased, it's possible that firmware
placed the BAR somewhere where the extra space is available.  In that
case, this forces reallocation unnecessarily.

2) This *feels* like something the PCI core should be doing anyway,
even without any help here.  Shouldn't we fail in pci_claim_resource()
and set IORESOURCE_UNSET there?

OK, and a third: re-reading TotalVF is (I think) completely
unnecessary per spec, so if we're going to do it we should probably
have a one-line comment about why the code is doing something that
appears unnecessary, and really should have a concrete example device
in the changelog.

> +
>  		dev_info(&dev->dev, "VF(n) BAR%d space: %pR (contains BAR%d for %d VFs)\n",
>  			 i, res, i, total);
>  		i += bar64;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
