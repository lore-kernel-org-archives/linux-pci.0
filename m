Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45177 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbeAVH2L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jan 2018 02:28:11 -0500
Message-ID: <1516634888.2377.21.camel@intel.com>
Subject: Re: [PATCH] PCI: altera: Fix bool initialization in tlp_read_packet
From: Ley Foon Tan <ley.foon.tan@intel.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ley Foon Tan <lftan@altera.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: rfi@lists.rocketboards.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Mon, 22 Jan 2018 23:28:08 +0800
In-Reply-To: <20180120032651.GA14512@embeddedgus>
References: <20180120032651.GA14512@embeddedgus>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-01-19 at 21:26 -0600, Gustavo A. R. Silva wrote:
> Bool initializations should use true and false.
> 
> This issue was detected with the help of Coccinelle.
> 
> Fixes: eaa6111b70a7 ("PCI: altera: Add Altera PCIe host controller
> driver")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/pci/host/pcie-altera.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-
> altera.c
> index 5cc4f59..f9ee090 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -156,7 +156,7 @@ static bool altera_pcie_valid_device(struct
> altera_pcie *pcie,
>  static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
>  {
>         int i;
> -       bool sop = 0;
> +       bool sop = false;
>         u32 ctrl;
>         u32 reg0, reg1;
>         u32 comp_status = 1;
> --
> 2.7.4

Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>
