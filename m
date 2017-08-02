Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751032AbdHBVuN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 17:50:13 -0400
Date: Wed, 2 Aug 2017 16:50:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com, Joao.Pinto@synopsys.com
Subject: Re: [PATCH] PCI: dwc: designware: make dw_pcie_prog_*_atu_unroll()
 static
Message-ID: <20170802215011.GN20308@bhelgaas-glaptop.roam.corp.google.com>
References: <20170717131334.1761-1-palminha@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170717131334.1761-1-palminha@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 17, 2017 at 02:13:34PM +0100, Carlos Palminha wrote:
> Helper functions dw_pcie_prog_*_atu_unroll don't need to be in global scope,
> so make it static.
> 
> Cleans up sparse warnings:
> - symbol 'dw_pcie_prog_outbound_atu_unroll' was not declared. Should it be static?
> - symbol 'dw_pcie_prog_inbound_atu_unroll' was not declared. Should it be static?
> 
> Signed-off-by: Carlos Palminha <palminha@synopsys.com>

Applied with acks from Joao and Jingoo to pci/host-designware for v4.14,
thanks!

I rewrapped these so they still fit in 80 columns, like the rest of the
file.

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
