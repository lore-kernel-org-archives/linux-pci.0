Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:64063 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbaI3QVb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Sep 2014 12:21:31 -0400
MIME-Version: 1.0
In-Reply-To: <1412069804-17162-11-git-send-email-r65037@freescale.com>
References: <1412069804-17162-1-git-send-email-r65037@freescale.com>
	<1412069804-17162-11-git-send-email-r65037@freescale.com>
Date: Tue, 30 Sep 2014 13:21:28 -0300
Message-ID: <CAOMZO5A3Bdxdspc_UnJcQ-DVrmUXQCKW0W08msnDs7TELzXEJg@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] ARM: imx6sx: enable pcie on imx6sx sdb board
From: Fabio Estevam <festevam@gmail.com>
To: Richard Zhu <r65037@freescale.com>
Cc: "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shawn Guo <shawn.guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Richard,

On Tue, Sep 30, 2014 at 6:36 AM, Richard Zhu <r65037@freescale.com> wrote:
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  arch/arm/boot/dts/imx6sx-sdb.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
> index a3980d9..2976913 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dts
> @@ -251,6 +251,13 @@
>         };
>  };
>
> +&pcie {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_pcie>;
> +       reset-gpio = <&gpio2 0 0>;
> +       status = "okay";
> +};

There is also GPIO2_1 which is the PCIE_PWR_EN signal and should be
added as a GPIO controlled regulator.
