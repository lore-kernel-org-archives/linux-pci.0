Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751428AbeACLmq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jan 2018 06:42:46 -0500
Date: Wed, 3 Jan 2018 11:43:42 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@axis.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: dwc: artpec6: Fix return value check in
 artpec6_add_pcie_ep()
Message-ID: <20180103114342.GB26554@red-moon>
References: <1514964815-93190-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1514964815-93190-1-git-send-email-weiyongjun1@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 03, 2018 at 07:33:35AM +0000, Wei Yongjun wrote:
> In case of error, the function devm_ioremap() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.
> 
> Fixes: b5074ef6fe7d ("PCI: dwc: artpec6: Add support for endpoint mode")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pci/dwc/pcie-artpec6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to pci/dwc for v4.16, thanks.

Lorenzo

> diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
> index 312f21b..b1e9820 100644
> --- a/drivers/pci/dwc/pcie-artpec6.c
> +++ b/drivers/pci/dwc/pcie-artpec6.c
> @@ -485,8 +485,8 @@ static int artpec6_add_pcie_ep(struct artpec6_pcie *artpec6_pcie,
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
>  	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
> -	if (IS_ERR(pci->dbi_base2))
> -		return PTR_ERR(pci->dbi_base2);
> +	if (!pci->dbi_base2)
> +		return -ENOMEM;
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>  	if (!res)
> 
