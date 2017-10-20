Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752469AbdJTXDc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Oct 2017 19:03:32 -0400
Date: Fri, 20 Oct 2017 18:03:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: faraday: Fix wrong pointer passed to PTR_ERR()
Message-ID: <20171020230328.GX6332@bhelgaas-glaptop.roam.corp.google.com>
References: <1508242263-73684-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1508242263-73684-1-git-send-email-weiyongjun1@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 17, 2017 at 12:11:03PM +0000, Wei Yongjun wrote:
> PTR_ERR should access the value just tested by IS_ERR, otherwise
> the wrong error code will be returned.
> 
> Fixes: 2eeb02b28579 ("PCI: faraday: Add clock handling")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied with Linus' reviewed-by to pci/host-faraday for v4.15, thanks!

> ---
>  drivers/pci/host/pci-ftpci100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
> index 06d9687..fae6bd1 100644
> --- a/drivers/pci/host/pci-ftpci100.c
> +++ b/drivers/pci/host/pci-ftpci100.c
> @@ -463,7 +463,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
>  	}
>  	p->bus_clk = devm_clk_get(dev, "PCICLK");
>  	if (IS_ERR(p->bus_clk))
> -		return PTR_ERR(clk);
> +		return PTR_ERR(p->bus_clk);
>  	ret = clk_prepare_enable(p->bus_clk);
>  	if (ret) {
>  		dev_err(dev, "could not prepare PCICLK\n");
> 
