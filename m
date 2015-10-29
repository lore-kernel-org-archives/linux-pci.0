Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45565 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757471AbbJ2QcT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 Oct 2015 12:32:19 -0400
Date: Thu, 29 Oct 2015 11:32:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Duyck <aduyck@mirantis.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iov: Fix sriov_enable exception handling path
Message-ID: <20151029163209.GA19083@localhost>
References: <20151027204607.14626.59671.stgit@localhost.localdomain>
 <20151027205227.14626.13514.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151027205227.14626.13514.stgit@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,

Thanks, this definitely clears up some problems.  Two minor questions
below.

On Tue, Oct 27, 2015 at 01:52:27PM -0700, Alexander Duyck wrote:
> >From what I can tell there were several errors in the sriov_enable
> exception handling path.  Below is a brief list of what I believe I am
> fixing:
> 
> 1.  If pcibios_enable_sriov failed, we returned without disabling SR-IOV on
>     the device.
> 2.  If virtfn_add failed we didn't call pcibios_disable_sriov to undo
>     pcibios_enable_sriov.
> 3.  We were resetting numvfs to 0 before a second had passed for the VFs to
>     quiesce.
> 4.  Minor coding style issues for white space and for assignment in
>     conditional check.
> 
> Beyond addressing these 4 issues there were also 2 other minor issues in
> that retval was a redundant variable with rc, and j wasn't actually needed
> as we could simply reverse the loop we were running when setting up i.  As
> such I have updated the code to address those two items.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/pci/iov.c |   31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 238950412de0..cecc242c1af0 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -231,13 +231,18 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
>  
>  int __weak pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>  {
> -       return 0;
> +	return 0;
> +}
> +
> +int __weak pcibios_sriov_disable(struct pci_dev *pdev)
> +{
> +	return 0;
>  }
>  
>  static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  {
>  	int rc;
> -	int i, j;
> +	int i;
>  	int nres;
>  	u16 offset, stride, initial;
>  	struct resource *res;
> @@ -245,7 +250,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	struct pci_sriov *iov = dev->sriov;
>  	int bars = 0;
>  	int bus;
> -	int retval;
>  
>  	if (!nr_virtfn)
>  		return 0;
> @@ -322,10 +326,11 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	if (nr_virtfn < initial)
>  		initial = nr_virtfn;
>  
> -	if ((retval = pcibios_sriov_enable(dev, initial))) {
> +	rc = pcibios_sriov_enable(dev, initial);
> +	if (rc) {
>  		dev_err(&dev->dev, "failure %d from pcibios_sriov_enable()\n",
> -			retval);
> -		return retval;
> +			rc);
> +		goto err_pcibios;
>  	}
>  
>  	for (i = 0; i < initial; i++) {
> @@ -340,25 +345,23 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	return 0;
>  
>  failed:
> -	for (j = 0; j < i; j++)
> -		virtfn_remove(dev, j, 0);
> +	while (i--)
> +		virtfn_remove(dev, i, 0);
>  
> +	pcibios_sriov_disable(dev);
> +err_pcibios:
>  	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
>  	pci_cfg_access_lock(dev);
>  	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
> -	pci_iov_set_numvfs(dev, 0);
>  	ssleep(1);
>  	pci_cfg_access_unlock(dev);
>  
>  	if (iov->link != dev->devfn)
>  		sysfs_remove_link(&dev->dev.kobj, "dep_link");
>  
> -	return rc;
> -}
> +	pci_iov_set_numvfs(dev, 0);

Do you have a spec pointer for the 1 sec delay before clearing NumVFs?

Does we need to clear NumVFs while holding the cfg access lock?

> -int __weak pcibios_sriov_disable(struct pci_dev *pdev)
> -{
> -       return 0;
> +	return rc;
>  }
>  
>  static void sriov_disable(struct pci_dev *dev)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
