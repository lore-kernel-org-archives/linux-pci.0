Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:36647 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbaBSVyC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 16:54:02 -0500
Received: by mail-ie0-f170.google.com with SMTP id rl12so705664iec.29
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2014 13:54:02 -0800 (PST)
Date: Wed, 19 Feb 2014 14:53:59 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Mohit Kumar <mohit.kumar@st.com>
Cc: jg1.han@samsung.com, Pratyush Anand <pratyush.anand@st.com>,
	Arnd Bergmann <arnd@arndb.de>, spear-devel@list.st.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] Designware:RC BARs setup related fix
Message-ID: <20140219215359.GA19233@google.com>
References: <1392811475-17744-1-git-send-email-mohit.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392811475-17744-1-git-send-email-mohit.kumar@st.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 19, 2014 at 05:34:35PM +0530, Mohit Kumar wrote:
> The Synopsys  PCIe core provides one pair of 32-bit BARs (BAR 0 and BAR 1).
> The BARs can  be configured as follows:
> 
> - One 64-bit BAR: BARs 0 and 1 are combined to form a single 64-bit BAR.
> - Two 32-bit BARs: BARs 0 and 1 are two independent 32-bit BARs
> 
> This patch corrects 64-bit, non-prefetchable memory BAR configuration
> implemented in dw driver.
> 
> Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: spear-devel@list.st.com
> Cc: linux-pci@vger.kernel.org

Applied to pci/host-designware for v3.15, thanks!

I update the summary to the following; let me know if it's not accurate:

  PCI: designware: Fix RC BAR to be single 64-bit non-prefetchable memory BAR

> ---
>  drivers/pci/host/pcie-designware.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 17ce88f..6d23d8c 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -800,7 +800,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  
>  	/* setup RC BARs */
>  	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_0);
> -	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_1);
> +	dw_pcie_writel_rc(pp, 0x00000000, PCI_BASE_ADDRESS_1);
>  
>  	/* setup interrupt pins */
>  	dw_pcie_readl_rc(pp, PCI_INTERRUPT_LINE, &val);
> -- 
> 1.7.0.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
