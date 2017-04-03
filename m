Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 3 Apr 2017 16:33:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Christopher Covington <cov@codeaurora.org>,
        Duc Dang <dhdang@apm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: generic: stop hiding pci_host_common_probe
 declaration
Message-ID: <20170403213332.GE13232@bhelgaas-glaptop.roam.corp.google.com>
References: <20170321160003.339217-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170321160003.339217-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 21, 2017 at 04:59:52PM +0100, Arnd Bergmann wrote:
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

It looks like 4e64dbe226e7 was merged for v4.6-rc1.  Does that mean
this build error has been there that long?  Is there another, more
recent commit that actually broke this?

I suspect something broke in the v4.11 merge window, so I'm fishing
for a commit from that window so I can include this for v4.11.

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
> -- 
> 2.9.0
> 
