Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:65511 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726401AbeIENTx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Sep 2018 09:19:53 -0400
Message-ID: <1536137433.31406.17.camel@mhfsdcap03>
Subject: Re: [PATCH] PCI: mediatek: Fix unchecked return value
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC: Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date: Wed, 5 Sep 2018 16:50:33 +0800
In-Reply-To: <20180720150158.GA10922@embeddedor.com>
References: <20180720150158.GA10922@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-07-20 at 10:01 -0500, Gustavo A. R. Silva wrote:
> Check return value of devm_pci_remap_iospace.
> 
> Notice that, currently, all instances of devm_pci_remap_iospace
> are being checked.
> 
> Addresses-Coverity-ID: 1471965 ("Unchecked return value")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Hi, Gustavo, thanks for your help.

Acked-by: Honghui Zhang <honghui.zhang@mediatek.com>

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 861dda6..1477939 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -1109,7 +1109,9 @@ static int mtk_pcie_request_resources(struct mtk_pcie *pcie)
>  	if (err < 0)
>  		return err;
>  
> -	devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
> +	err = devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
> +	if (err)
> +		return err;
>  
>  	return 0;
>  }
