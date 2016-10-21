Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935930AbcJUUXO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Oct 2016 16:23:14 -0400
Date: Fri, 21 Oct 2016 15:23:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        bhelgaas@google.com, benh@au1.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, clsoto@us.ibm.com
Subject: Re: [PATCH v2 1/2] pci: Call pcibios_sriov_enable() before IOV BARs
 are enabled
Message-ID: <20161021202309.GF9007@localhost>
References: <1475192870-7763-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475192870-7763-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 30, 2016 at 09:47:49AM +1000, Gavin Shan wrote:
> In current implementation, pcibios_sriov_enable() is used by PPC
> PowerNV platform only. In PowerNV specific pcibios_sriov_enable(),
> PF's IOV BARs might be updated (shifted) by pci_update_resource().
> It means the IOV BARs aren't ready for decoding incoming memory
> address until pcibios_sriov_enable() returns.
> 
> This calls pcibios_sriov_enable() earlier before the IOV BARs are
> enabled. As the result, the IOV BARs have been configured correctly
> when they are enabled.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Tested-by: Carol Soto <clsoto@us.ibm.com>
> ---
>  drivers/pci/iov.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 2194b44..f1343f0 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -303,13 +303,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  			return rc;
>  	}
>  
> -	pci_iov_set_numvfs(dev, nr_virtfn);
> -	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
> -	pci_cfg_access_lock(dev);
> -	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
> -	msleep(100);
> -	pci_cfg_access_unlock(dev);
> -
>  	iov->initial_VFs = initial;
>  	if (nr_virtfn < initial)
>  		initial = nr_virtfn;
> @@ -320,6 +313,13 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  		goto err_pcibios;
>  	}
>  
> +	pci_iov_set_numvfs(dev, nr_virtfn);
> +	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
> +	pci_cfg_access_lock(dev);
> +	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
> +	msleep(100);
> +	pci_cfg_access_unlock(dev);

This one looks fine to me.

>  	for (i = 0; i < initial; i++) {
>  		rc = pci_iov_add_virtfn(dev, i, 0);
>  		if (rc)
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
