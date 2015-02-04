Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:64223 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966160AbbBDQ2a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Feb 2015 11:28:30 -0500
Received: by mail-ob0-f176.google.com with SMTP id wo20so2244899obc.7
        for <linux-pci@vger.kernel.org>; Wed, 04 Feb 2015 08:28:29 -0800 (PST)
Date: Wed, 4 Feb 2015 10:28:26 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, benh@au1.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] pci/iov: fix memory leak introduced in "PCI: Store
 individual VF BAR size in struct pci_sriov"
Message-ID: <20150204162826.GA7643@google.com>
References: <CAErSpo4nLEvL4XGvkvZbfy0dFQcRDHdn5aznkx2fRMMnt1_n4g@mail.gmail.com>
 <1423066130-8587-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423066130-8587-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 05, 2015 at 12:08:50AM +0800, Wei Yang wrote:
> Bjorn, this is an error introduced in the patch "PCI: Store individual VF BAR
> size in struct pci_sriov".
> 
> This patch is based on the pci/virtualization branch. I have tried, it could
> merge with the bad one cleanly.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Great, thanks.  I folded this into "PCI: Store individual VF BAR size in
struct pci_sriov".

> ---
>  drivers/pci/iov.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index d64b9df..721987b 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -430,10 +430,8 @@ found:
>  	pci_write_config_dword(dev, pos + PCI_SRIOV_SYS_PGSIZE, pgsz);
>  
>  	iov = kzalloc(sizeof(*iov), GFP_KERNEL);
> -	if (!iov) {
> -		rc = -ENOMEM;
> -		goto failed;
> -	}
> +	if (!iov)
> +		return -ENOMEM;
>  
>  	nres = 0;
>  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> @@ -485,6 +483,8 @@ failed:
>  		res->flags = 0;
>  	}
>  
> +	kfree(iov);
> +
>  	return rc;
>  }
>  
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
