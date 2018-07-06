Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51864 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753061AbeGFJcB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jul 2018 05:32:01 -0400
Subject: Re: [PATCH v6 11/11] PCI: endpoint: Add MSI set maximum restriction.
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>,
        <shawn.lin@rock-chips.com>
References: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
 <5bceea0ec98a7436ac5960635898ddfbec2cf6e1.1529595907.git.gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <3a33b9b2-0afa-3639-12af-cea1083e2714@ti.com>
Date: Fri, 6 Jul 2018 15:01:44 +0530
MIME-Version: 1.0
In-Reply-To: <5bceea0ec98a7436ac5960635898ddfbec2cf6e1.1529595907.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Thursday 21 June 2018 09:31 PM, Gustavo Pimentel wrote:
> Add pci_epc_set_msi() maximum 32 interrupts validation.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Change v4->v5:
>  - New patch file.
> Change v5->v6:
>  - Nothing changed, just to follow the patch set version.
> 
>  drivers/pci/endpoint/pci-epc-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index c72e656..094dcc3 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -201,7 +201,8 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
>  	u8 encode_int;
>  	unsigned long flags;
>  
> -	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
> +	    interrupts > 32)
>  		return -EINVAL;
>  
>  	if (!epc->ops->set_msi)
> 
