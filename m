Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753031AbeAKNs1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jan 2018 08:48:27 -0500
Date: Thu, 11 Jan 2018 13:49:25 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com
Cc: thierry.reding@gmail.com, cyndis@kapsi.fi, jonathanh@nvidia.com,
        robh+dt@kernel.org, frowand.list@gmail.com, rjw@rjwysocki.net,
        tglx@linutronix.de, vidyas@nvidia.com, kthota@nvidia.com,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V5 3/7] PCI: tegra: Remove PCI_REASSIGN_ALL_BUS flag for
 Tegra PCIe
Message-ID: <20180111134925.GA10168@red-moon>
References: <1515489577-2197-1-git-send-email-mmaddireddy@nvidia.com>
 <1515489577-2197-4-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515489577-2197-4-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, Jan 09, 2018 at 02:49:33PM +0530, Manikanta Maddireddy wrote:
> Primary, secondary and subordinate default bus numbers are 0 in Tegra and
> it is expecting SW to program these numbers in configration space.
> 
> pci_scan_bridge_extend() function programs these numbers in configuration
> space if secondary & subordinate bus numbers are 0 or PCI_REASSIGN_ALL_BUS
> flag is set. Since secondary & subordinate default bus numbers are 0,
> PCI_REASSIGN_ALL_BUS flag can be removed for Tegra PCIe.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Would you mind applying this patch (NB: it is the patch in the v5
version - this patch - not the one in v6 that is a rebased version):

https://patchwork.ozlabs.org/patch/857318/

to your pci/resource branch please (there is a dependency) ?

This would allow me to apply the rest of the patches in the series
that I consider mergeable independently of your tree branches, to
simplify the dependency.

Thanks !
Lorenzo

> ---
> V3:
> * new patch in V3
> V4:
> * no change in this patch
> V5:
> * no change in this patch
> 
>  drivers/pci/host/pci-tegra.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index d790a26ad87e..e4b47ebc91fe 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -2293,7 +2293,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  
>  	tegra_pcie_enable_ports(pcie);
>  
> -	pci_add_flags(PCI_REASSIGN_ALL_BUS);
>  	host->busnr = pcie->busn.start;
>  	host->dev.parent = &pdev->dev;
>  	host->ops = &tegra_pcie_ops;
> -- 
> 2.1.4
> 
