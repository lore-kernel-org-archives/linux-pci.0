Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:41330 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbaIWMkf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 08:40:35 -0400
MIME-Version: 1.0
In-Reply-To: <1411445498-20250-2-git-send-email-r65037@freescale.com>
References: <1411445498-20250-1-git-send-email-r65037@freescale.com>
	<1411445498-20250-2-git-send-email-r65037@freescale.com>
Date: Tue, 23 Sep 2014 09:40:33 -0300
Message-ID: <CAOMZO5BuPcw9bJSdLMJ2D=a6EMFMPtKeY352N9-x8dwmRnnfWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] PCI: imx6: enable pcie on imx6qdl sabreauto
From: Fabio Estevam <festevam@gmail.com>
To: Richard Zhu <r65037@freescale.com>
Cc: linux-pci-owner@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shawn Guo <shawn.guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Richard,

On Tue, Sep 23, 2014 at 1:11 AM, Richard Zhu <r65037@freescale.com> wrote:
> - enable pcie on imx6qdl sabreauto boards.
>
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index 009abd6..d6040a5 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -410,6 +410,10 @@
>         };
>  };
>
> +&pcie {
> +       status = "okay";
> +};

It would be better if you could pass the PCI reset pin that comes from
the GPIO expander.
