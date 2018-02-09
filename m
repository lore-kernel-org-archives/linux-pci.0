Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35379 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbeBIXi7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Feb 2018 18:38:59 -0500
Date: Fri, 9 Feb 2018 17:38:57 -0600
From: Rob Herring <robh@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI: rockchip: Add rockchip,rk3399-pcie-host
 compatible
Message-ID: <20180209233857.osoyfvst3waa54b3@rob-hp-laptop>
References: <1517971650-61555-1-git-send-email-shawn.lin@rock-chips.com>
 <1517971650-61555-5-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1517971650-61555-5-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 07, 2018 at 10:47:28AM +0800, Shawn Lin wrote:
> To avoid confusion when folks use this controller as endponint

s/endponint/endpoint/

> mode, we add rockchip,rk3399-pcie-host to clearly state that
> it's driver for host here. And rename/update the document to
> reflect this fact.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  .../bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt}         | 3 ++-
>  drivers/pci/rockchip/pcie-rockchip-host.c                              | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} (98%)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
> similarity index 98%
> rename from Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> rename to Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
> index af34c65..f2f3091 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
> @@ -5,7 +5,8 @@ Required properties:
>  - #size-cells: Size representation for root ports, set to <2>
>  - #interrupt-cells: specifies the number of cells needed to encode an
>  		interrupt source. The value must be 1.
> -- compatible: Should contain "rockchip,rk3399-pcie"
> +- compatible: Should contain "rockchip,rk3399-pcie" or
> +	"rockchip,rk3399-pcie-host"

I don't think this is necessary. Endpoint is generally the exception and 
having "endpoint" or "ep" in the endpoint compatible should be enough.

>  - reg: Two register ranges as listed in the reg-names property
>  - reg-names: Must include the following names
>  	- "axi-base"
> diff --git a/drivers/pci/rockchip/pcie-rockchip-host.c b/drivers/pci/rockchip/pcie-rockchip-host.c
> index f5b0492..efb740d 100644
> --- a/drivers/pci/rockchip/pcie-rockchip-host.c
> +++ b/drivers/pci/rockchip/pcie-rockchip-host.c
> @@ -1120,6 +1120,7 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id rockchip_pcie_of_match[] = {
>  	{ .compatible = "rockchip,rk3399-pcie", },
> +	{ .compatible = "rockchip,rk3399-pcie-host", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, rockchip_pcie_of_match);
> -- 
> 1.9.1
> 
> 
