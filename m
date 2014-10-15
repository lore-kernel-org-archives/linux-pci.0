Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33403 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbaJOARu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Oct 2014 20:17:50 -0400
Received: by mail-ig0-f169.google.com with SMTP id uq10so18939982igb.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2014 17:17:49 -0700 (PDT)
Date: Tue, 14 Oct 2014 18:17:46 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: l.stach@pengutronix.de, Hong-Xing.Zhu@freescale.com,
	linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Richard Zhu <r65037@freescale.com>,
	Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: imx6q-pcie doc: Update the clocks descriptions to
 use defines
Message-ID: <20141015001746.GC15225@google.com>
References: <1412434548-11219-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412434548-11219-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rob, Arnd, linux-arm-kernel]

On Sat, Oct 04, 2014 at 11:55:48AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Let's make the imx6q-pcie example to actually match the usage on imx6qdl.dtsi
> by providing the clock names via defines rather than hardcoded numbers.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Is this an arm-soc thing?

If you want me to take it, I'll wait for an ack from the likes of
Richard/Lucas/Rob/Arnd since I can't review this myself.

> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 6fbba53..0b28b52 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -35,6 +35,8 @@ Example:
>  		                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
>  		                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
>  		                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&clks 144>, <&clks 206>, <&clks 189>;
> +		clocks = <&clks IMX6QDL_CLK_PCIE_AXI>,
> +			 <&clks IMX6QDL_CLK_LVDS1_GATE>,
> +			 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
>  		clock-names = "pcie", "pcie_bus", "pcie_phy";
>  	};
> -- 
> 1.9.1
> 
