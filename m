Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.10]:35264 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752432AbdDDOC1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2017 10:02:27 -0400
Subject: Re: [PATCH] PCI: generic: stop hiding pci_host_common_probe
 declaration
To: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>
CC: Jayachandran C <jchandra@broadcom.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Christopher Covington <cov@codeaurora.org>,
        Duc Dang <dhdang@apm.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>
References: <20170321160003.339217-1-arnd@arndb.de>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <eef2bf83-97aa-270f-f83f-372fb30ea132@sigmadesigns.com>
Date: Tue, 4 Apr 2017 16:02:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170321160003.339217-1-arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 21/03/2017 16:59, Arnd Bergmann wrote:

> When pci_host_common_probe() was moved into a separate module, the #ifdef around
> the declaration was left in the header file, which can lead to build errors in
> some configurations:
> 
> drivers/pci/host/pci-thunder-pem.c: In function 'thunder_pem_probe':
> drivers/pci/host/pci-thunder-pem.c:412:9: error: implicit declaration of function 'pci_host_common_probe';did you mean 'pci_host_bridge_priv'? [-Werror=implicit-function-declaration]
> 
> The ifdef serves no real purpose anyway, so we can just remove it.
> 
> Fixes: 4e64dbe226e7 ("PCI: generic: Expose pci_host_common_probe() for use by other drivers")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/pci-ecam.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index f0d2b9451270..92a73847e1d3 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -68,9 +68,7 @@ extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
>  extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
>  #endif
>  
> -#ifdef CONFIG_PCI_HOST_GENERIC
>  /* for DT-based PCI controllers that support ECAM */
>  int pci_host_common_probe(struct platform_device *pdev,
>  			  struct pci_ecam_ops *ops);
>  #endif
> -#endif
> 

I ran into this issue as well (on v4.9) and submitted a patch a week
after you did, by pure coincidence:

Subject: [TRIVIAL PATCH] PCI: Change pci_host_common_probe visibility
Date: Tue, 28 Mar 2017 17:29:51 +0200
https://www.spinics.net/lists/linux-pci/msg59823.html

Regards.
