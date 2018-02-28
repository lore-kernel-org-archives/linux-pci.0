Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932236AbeB1RAR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 12:00:17 -0500
Date: Wed, 28 Feb 2018 17:00:12 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        rfi@lists.rocketboards.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] PCI: altera: Fix bool initialization in tlp_read_packet
Message-ID: <20180228170012.GB14610@e107981-ln.cambridge.arm.com>
References: <20180120032651.GA14512@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180120032651.GA14512@embeddedgus>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 19, 2018 at 09:26:51PM -0600, Gustavo A. R. Silva wrote:
> Bool initializations should use true and false.
> 
> This issue was detected with the help of Coccinelle.
> 
> Fixes: eaa6111b70a7 ("PCI: altera: Add Altera PCIe host controller driver")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/pci/host/pcie-altera.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/altera for v4.17, thanks.

Lorenzo

> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
> index 5cc4f59..f9ee090 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -156,7 +156,7 @@ static bool altera_pcie_valid_device(struct altera_pcie *pcie,
>  static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
>  {
>  	int i;
> -	bool sop = 0;
> +	bool sop = false;
>  	u32 ctrl;
>  	u32 reg0, reg1;
>  	u32 comp_status = 1;
> -- 
> 2.7.4
> 
