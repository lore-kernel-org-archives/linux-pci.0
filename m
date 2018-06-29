Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755568AbeF2UJv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jun 2018 16:09:51 -0400
Date: Fri, 29 Jun 2018 15:09:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        oss-drivers@netronome.com, Don Dutile <ddutile@redhat.com>
Subject: Re: [PATCH] nfp: align setting totalvfs to changes in PCI core
Message-ID: <20180629200949.GC40928@bhelgaas-glaptop.roam.corp.google.com>
References: <20180628180705.GB120578@bhelgaas-glaptop.roam.corp.google.com>
 <20180628183009.24837-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180628183009.24837-1-jakub.kicinski@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 28, 2018 at 11:30:09AM -0700, Jakub Kicinski wrote:
> Since commit 8d85a7a4f2c9 ("PCI/IOV: Allow PF drivers to limit total_VFs
> to 0") the meaning of pci_sriov_set_totalvfs(pdev, 0) changed from
> 'no limit set/can use total_VFs' to 'limit set to 0/can't use any VFs'.
> The driver was resetting the limit in case different FW or driver has
> set it to an incorrect value.  Now the PCI core will take care of
> resetting so we don't have to do that.
> 
> Fixes: 8d85a7a4f2c9 ("PCI/IOV: Allow PF drivers to limit total_VFs to 0")
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Applied to for-linus for v4.18,thanks!

> ---
>  drivers/net/ethernet/netronome/nfp/nfp_main.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
> index 46b76d5a726c..152283d7e59c 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
> @@ -240,7 +240,6 @@ static int nfp_pcie_sriov_read_nfd_limit(struct nfp_pf *pf)
>  		return pci_sriov_set_totalvfs(pf->pdev, pf->limit_vfs);
>  
>  	pf->limit_vfs = ~0;
> -	pci_sriov_set_totalvfs(pf->pdev, 0); /* 0 is unset */
>  	/* Allow any setting for backwards compatibility if symbol not found */
>  	if (err == -ENOENT)
>  		return 0;
> @@ -668,7 +667,7 @@ static int nfp_pci_probe(struct pci_dev *pdev,
>  
>  	err = nfp_net_pci_probe(pf);
>  	if (err)
> -		goto err_sriov_unlimit;
> +		goto err_fw_unload;
>  
>  	err = nfp_hwmon_register(pf);
>  	if (err) {
> @@ -680,8 +679,6 @@ static int nfp_pci_probe(struct pci_dev *pdev,
>  
>  err_net_remove:
>  	nfp_net_pci_remove(pf);
> -err_sriov_unlimit:
> -	pci_sriov_set_totalvfs(pf->pdev, 0);
>  err_fw_unload:
>  	kfree(pf->rtbl);
>  	nfp_mip_close(pf->mip);
> @@ -715,7 +712,6 @@ static void nfp_pci_remove(struct pci_dev *pdev)
>  	nfp_hwmon_unregister(pf);
>  
>  	nfp_pcie_sriov_disable(pdev);
> -	pci_sriov_set_totalvfs(pf->pdev, 0);
>  
>  	nfp_net_pci_remove(pf);
>  
> -- 
> 2.17.1
> 
