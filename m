Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbdHSVZW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 19 Aug 2017 17:25:22 -0400
Date: Sat, 19 Aug 2017 16:25:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, bhelgaas@google.com,
        songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: make dw_pcie_host_ops const
Message-ID: <20170819212519.GW28977@bhelgaas-glaptop.roam.corp.google.com>
References: <1502264928-30004-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502264928-30004-1-git-send-email-bhumirks@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 09, 2017 at 01:18:48PM +0530, Bhumika Goyal wrote:
> Make these structures const as they are only stored in the ops field of
> a pcie_port structure, which is of type const.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to pci/host-hisi and pci/host-kirin for v4.14, thanks!

> ---
>  drivers/pci/dwc/pcie-hisi.c  | 2 +-
>  drivers/pci/dwc/pcie-kirin.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> index e51acee..518cd7e 100644
> --- a/drivers/pci/dwc/pcie-hisi.c
> +++ b/drivers/pci/dwc/pcie-hisi.c
> @@ -223,7 +223,7 @@ static int hisi_pcie_link_up(struct dw_pcie *pci)
>  	return hisi_pcie->soc_ops->hisi_pcie_link_up(hisi_pcie);
>  }
>  
> -static struct dw_pcie_host_ops hisi_pcie_host_ops = {
> +static const struct dw_pcie_host_ops hisi_pcie_host_ops = {
>  	.rd_own_conf = hisi_pcie_cfg_read,
>  	.wr_own_conf = hisi_pcie_cfg_write,
>  };
> diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
> index 33fddb9..a623f96 100644
> --- a/drivers/pci/dwc/pcie-kirin.c
> +++ b/drivers/pci/dwc/pcie-kirin.c
> @@ -441,7 +441,7 @@ static void kirin_pcie_host_init(struct pcie_port *pp)
>  	.link_up = kirin_pcie_link_up,
>  };
>  
> -static struct dw_pcie_host_ops kirin_pcie_host_ops = {
> +static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
>  	.rd_own_conf = kirin_pcie_rd_own_conf,
>  	.wr_own_conf = kirin_pcie_wr_own_conf,
>  	.host_init = kirin_pcie_host_init,
> -- 
> 1.9.1
> 
