Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbeISQHH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 12:07:07 -0400
Date: Wed, 19 Sep 2018 11:29:44 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Nathan Chancellor <natechancellor@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] PCI: kirin: Fix section mismatch warning
Message-ID: <20180919102944.GA15014@e107981-ln.cambridge.arm.com>
References: <20180919053829.4858-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180919053829.4858-1-natechancellor@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Xiaowei, Binghui,

On Tue, Sep 18, 2018 at 10:38:29PM -0700, Nathan Chancellor wrote:
> WARNING: vmlinux.o(.text+0x4758cc): Section mismatch in reference from
> the function kirin_pcie_probe() to the function
> .init.text:kirin_add_pcie_port()
> The function kirin_pcie_probe() references
> the function __init kirin_add_pcie_port().
> This is often because kirin_pcie_probe lacks a __init
> annotation or the annotation of kirin_add_pcie_port is wrong.
> 
> Remove '__init' from kirin_add_pcie_port so there is no mismatch.

I think that instead of removing __init section tag we should add
it to kirin_pcie_probe().

Please let me know and ACK accordingly.

Lorenzo

> Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index 5352e0c3be82..9b599296205d 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -467,8 +467,8 @@ static int kirin_pcie_add_msi(struct dw_pcie *pci,
>  	return 0;
>  }
>  
> -static int __init kirin_add_pcie_port(struct dw_pcie *pci,
> -				      struct platform_device *pdev)
> +static int kirin_add_pcie_port(struct dw_pcie *pci,
> +			       struct platform_device *pdev)
>  {
>  	int ret;
>  
> -- 
> 2.19.0
> 
