Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45785 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964790AbcFMK7H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2016 06:59:07 -0400
Message-ID: <1465815543.2313.9.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6: Add missing required clocks
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: bhelgaas@google.com, hongxing.zhu@nxp.com,
	linux-pci@vger.kernel.org
Date: Mon, 13 Jun 2016 12:59:03 +0200
In-Reply-To: <1465392461-3469-1-git-send-email-fabio.estevam@nxp.com>
References: <1465392461-3469-1-git-send-email-fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 08.06.2016, 10:27 -0300 schrieb Fabio Estevam:
> The PCI hardware on imx6 requires the following clocks:
> "pcie", "pcie_bus" and "pcie_phy", so add the missing clocks
> in the clock-names property.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 83aeb1f..94ab92c 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -10,8 +10,8 @@ Required properties:
>    entry for each entry in the interrupt-names property.
>  - interrupt-names: Must include the following entries:
>  	- "msi": The interrupt that is asserted when an MSI is received
> -- clock-names: Must include the following additional entries:
> -	- "pcie_phy"
> +- clock-names: Must include the following entries:
> +	- "pcie", "pcie_bus" and "pcie_phy".

NACK.

Both "pcie" and "pcie_bus" are inherited from the common
designware-pcie.txt binding. That's why it reads "must include the
following ADDITIONAL entries".

Regards,
Lucas


