Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53410 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965636AbcJ0Opp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2016 10:45:45 -0400
Message-ID: <1477561902.2274.28.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] MAINTAINERS: PCI: imx6: Add devicetree binding file
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: bhelgaas@google.com, hongxing.zhu@nxp.com,
        linux-pci@vger.kernel.org
Date: Thu, 27 Oct 2016 11:51:42 +0200
In-Reply-To: <1477499244-10640-3-git-send-email-fabio.estevam@nxp.com>
References: <1477499244-10640-1-git-send-email-fabio.estevam@nxp.com>
         <1477499244-10640-3-git-send-email-fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 26.10.2016, 14:27 -0200 schrieb Fabio Estevam:
> Add an entry for the devicetree binding file, so that when
> people run ./scripts/get_maintainer.pl the PCI imx6 maintainers could
> also be listed.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf828f4..d61aead 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9262,6 +9262,7 @@ M:	Lucas Stach <l.stach@pengutronix.de>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>  F:	drivers/pci/host/*imx6*
>  
>  PCI DRIVER FOR TI KEYSTONE


