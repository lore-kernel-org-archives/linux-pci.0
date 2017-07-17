Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:59153 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbdGQN2D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 09:28:03 -0400
Subject: Re: [PATCH] PCI: dwc: designware: make dw_pcie_prog_*_atu_unroll()
 static
To: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <Joao.Pinto@synopsys.com>
References: <20170717131334.1761-1-palminha@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <18cf8549-c1c6-bed2-60f2-202abc06d6b3@synopsys.com>
Date: Mon, 17 Jul 2017 14:27:58 +0100
MIME-Version: 1.0
In-Reply-To: <20170717131334.1761-1-palminha@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Carlos,

Às 2:13 PM de 7/17/2017, Carlos Palminha escreveu:
> Helper functions dw_pcie_prog_*_atu_unroll don't need to be in global scope,
> so make it static.
> 
> Cleans up sparse warnings:
> - symbol 'dw_pcie_prog_outbound_atu_unroll' was not declared. Should it be static?
> - symbol 'dw_pcie_prog_inbound_atu_unroll' was not declared. Should it be static?
> 
> Signed-off-by: Carlos Palminha <palminha@synopsys.com>
> ---
> Patch made against linux-next tree, tag next-20170714
> 
>  drivers/pci/dwc/pcie-designware.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
> index 0e03af279259..48d6d0712ea8 100644
> --- a/drivers/pci/dwc/pcie-designware.c
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -107,7 +107,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
>  	dw_pcie_writel_dbi(pci, offset + reg, val);
>  }
> 
> -void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index, int type,
> +static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index, int type,
>  				      u64 cpu_addr, u64 pci_addr, u32 size)
>  {
>  	u32 retries, val;
> @@ -200,7 +200,7 @@ static void dw_pcie_writel_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg,
>  	dw_pcie_writel_dbi(pci, offset + reg, val);
>  }
> 
> -int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index, int bar,
> +static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index, int bar,
>  				    u64 cpu_addr, enum dw_pcie_as_type as_type)
>  {
>  	int type;
> --
> 2.11.0
> 

That indeed escaped in the refactoring :) Thanks!

Acked-by: Joao Pinto <jpinto@synopsys.com>
