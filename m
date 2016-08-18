Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754076AbcHSBLO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Aug 2016 21:11:14 -0400
Date: Thu, 18 Aug 2016 14:15:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: bhelgaas@google.com, jszhang@marvell.com, jingoohan1@gmail.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pcie-designware: build error fix
Message-ID: <20160818191546.GG27353@localhost>
References: <7083dc9188405f25307d0a75d4e199846ac06ac9.1471525771.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7083dc9188405f25307d0a75d4e199846ac06ac9.1471525771.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 18, 2016 at 02:18:29PM +0100, Joao Pinto wrote:
> This patch is to fix a building error in branch pci/host-designware. 
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>

Thanks, I fixed this yesterday, and I got a build success report for it
(commit 01c076732e82).

> ---
>  drivers/pci/host/pcie-designware.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index be70f28..6a743c5 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -511,9 +511,8 @@ static const struct irq_domain_ops msi_domain_ops = {
>  
>  static u8 dw_pcie_iatu_unroll_enabled(struct pcie_port *pp)
>  {
> -	u32 val = 0;
> +	u32 val = dw_pcie_readl_rc(pp, PCIE_ATU_VIEWPORT);
>  
> -	dw_pcie_readl_rc(pp, PCIE_ATU_VIEWPORT, &val);
>  	if (val == 0xffffffff)
>  		return 1;
>  
> -- 
> 1.8.1.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
