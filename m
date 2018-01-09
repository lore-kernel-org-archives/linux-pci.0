Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932205AbeAIPZF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jan 2018 10:25:05 -0500
Date: Tue, 9 Jan 2018 15:25:58 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Koen Vandeputte <koen.vandeputte@ncentric.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com,
        niklas.cassel@axis.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: dwc: fix enumeration end when reaching root
 subordinate
Message-ID: <20180109152550.GA16285@red-moon>
References: <1515508941-20055-1-git-send-email-koen.vandeputte@ncentric.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515508941-20055-1-git-send-email-koen.vandeputte@ncentric.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 09, 2018 at 03:42:21PM +0100, Koen Vandeputte wrote:
> The subordinate value indicates the highest bus number which can be
> reached downstream though a certain device.
> 
> Commit a20c7f36bd3d ("PCI: Do not allocate more buses than available in
> parent")
> ensures that downstream devices cannot assign busnumbers higher than the
> upstream device subordinate number, which was indeed illogical.
> 
> By default, dw_pcie_setup_rc() inits the Root Complex subordinate to a
> value of 0x01.
> 
> Due to this combined with above commit, enumeration stops digging deeper
> downstream as soon as bus num 0x01 has been assigned, which is always
> the case for a bridge device.
> 
> This results in all devices behind a bridge bus to remain undetected, as
> these would be connected to bus 0x02 or higher.
> 
> Fix this by initializing the RC to a subordinate value of 0xff, meaning
> that all busses [0x00-0xff] are reachable through this RC.

This is not a correct description of the problem. AFAICS all busses
are reachable through this RC _regardless_ of whatever subordinate
bus number value you programme into it.

You should extend the CC list to all dwc host submaintainers so
that you can actually get it tested.

> Fixes: a20c7f36bd3d ("PCI: Do not allocate more buses than available in
> parent")
> Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> Tested-by: Niklas Cassel <niklas.cassel@axis.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> 
> Will send separate patches to stable as this file got moved/renamed

Fixes: commit appeared at v4.15-rc1 (and v4.15 has not been released
yet) - there is no separate patch to be sent.

Thanks,
Lorenzo

>  drivers/pci/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index bf558df5b7b3..2b5470173196 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -616,7 +616,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	/* setup bus numbers */
>  	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
>  	val &= 0xff000000;
> -	val |= 0x00010100;
> +	val |= 0x00ff0100;
>  	dw_pcie_writel_dbi(pci, PCI_PRIMARY_BUS, val);
>  
>  	/* setup command register */
> -- 
> 2.7.4
> 
