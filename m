Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35772 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbdAWOwG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2017 09:52:06 -0500
Date: Mon, 23 Jan 2017 08:52:04 -0600
From: Rob Herring <robh@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-pci@vger.kernel.org, yurovsky@gmail.com,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: imx6: Add code to support i.MX7D
Message-ID: <20170123145204.5lablvhf7m2hf3na@rob-hp-laptop>
References: <20170119163631.10668-1-andrew.smirnov@gmail.com>
 <20170119163631.10668-4-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170119163631.10668-4-andrew.smirnov@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 19, 2017 at 08:36:31AM -0800, Andrey Smirnov wrote:
> Add various bits of code needed to support i.MX7D variant of the IP.
> 
> Cc: yurovsky@gmail.com
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
>  drivers/pci/host/pci-imx6.c                        | 188 ++++++++++++++++++---
>  include/linux/mfd/syscon/imx7-gpc.h                |  18 ++
>  include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
>  include/linux/mfd/syscon/imx7-src.h                |  18 ++
>  5 files changed, 208 insertions(+), 26 deletions(-)
>  create mode 100644 include/linux/mfd/syscon/imx7-gpc.h
>  create mode 100644 include/linux/mfd/syscon/imx7-src.h
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 83aeb1f..20b9382 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -4,7 +4,8 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
>  and thus inherits all the common properties defined in designware-pcie.txt.
>  
>  Required properties:
> -- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie", "fsl,imx6qp-pcie"
> +- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie",
> +  	      "fsl,imx6qp-pcie", "fsl,imx7d-pcie"

Please reformat to one valid combination per line.

>  - reg: base address and length of the PCIe controller
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> @@ -34,6 +35,9 @@ Additional required properties for imx6sx-pcie:
>  - clock names: Must include the following additional entries:
>  	- "pcie_inbound_axi"
>  
> +Additional required properties for imx7d-pcie:
> +- pcie-phy-supply: Should specify the regulator supplying PCIe PHY
> +
>  Example:
>  
>  	pcie@0x01000000 {
