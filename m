Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752244AbdGDQZk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jul 2017 12:25:40 -0400
Date: Tue, 4 Jul 2017 11:25:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: guodong.xu@linaro.org, bhelgaas@google.com,
        suzhuangluan@hisilicon.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS:add maintainer for kirin pcie
Message-ID: <20170704162538.GJ13824@bhelgaas-glaptop.roam.corp.google.com>
References: <20170704021516.96575-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170704021516.96575-1-songxiaowei@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 04, 2017 at 10:15:16AM +0800, Xiaowei Song wrote:
> Kirin PCIe Driver does not have a maintainer at present,
> 
> Add maintainers for kirin pcie driver and Doc, the two fellowing files.
> Documentation/devicetree/bindings/pci/pcie-kirin.txt
> drivers/pci/dwc/pcie-kirin.c
> 
> Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
> Cc: Guodong Xu <guodong.xu@linaro.org>

Applied to pci/host-kirin for v4.13, thanks!

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5ee3125f8341..c64ff79587c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9851,6 +9851,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>  F:	drivers/pci/dwc/pcie-hisi.c
>  
> +PCIE DRIVER FOR Kirin
> +M:	Xiaowei Song <songxiaowei@hisilicon.com>
> +M:	Binghui Wang <wangbinghui@hisilicon.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/pcie-kirin.txt
> +F:	drivers/pci/dwc/pcie-kirin.c
> +
>  PCIE DRIVER FOR ROCKCHIP
>  M:	Shawn Lin <shawn.lin@rock-chips.com>
>  M:	Wenrui Li <wenrui.li@rock-chips.com>
> -- 
> 2.11.GIT
> 
