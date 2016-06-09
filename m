Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35719 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbcFILnO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2016 07:43:14 -0400
Received: by mail-it0-f66.google.com with SMTP id z123so4791794itg.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Jun 2016 04:43:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1465392461-3469-1-git-send-email-fabio.estevam@nxp.com>
References: <1465392461-3469-1-git-send-email-fabio.estevam@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 9 Jun 2016 08:43:13 -0300
Message-ID: <CAOMZO5CH=Pwq8iDT5LZdk6bqy=8TP==UqnJrBrrdpTyFXsvtzw@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: Add missing required clocks
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 8, 2016 at 10:27 AM, Fabio Estevam <fabio.estevam@nxp.com> wrote:
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
>         - "msi": The interrupt that is asserted when an MSI is received
> -- clock-names: Must include the following additional entries:
> -       - "pcie_phy"
> +- clock-names: Must include the following entries:
> +       - "pcie", "pcie_bus" and "pcie_phy".

Ah, just realized that the  "pcie" and "pcie_bus" are already listed
in designware-pci.txt.
