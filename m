Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:60151 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbaIYBjd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Sep 2014 21:39:33 -0400
MIME-Version: 1.0
In-Reply-To: <366bf7b53b044fdd94f12ed21f505841@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1411445498-20250-1-git-send-email-r65037@freescale.com>
	<1411445498-20250-2-git-send-email-r65037@freescale.com>
	<CAOMZO5BuPcw9bJSdLMJ2D=a6EMFMPtKeY352N9-x8dwmRnnfWw@mail.gmail.com>
	<f72dd09d379d4c1b89cc27612afcea77@BY1PR0301MB0855.namprd03.prod.outlook.com>
	<CAOMZO5CKZce3AZfm79DVGShx7bY6DJ3YvSC7q9MYx5v+Zwve5g@mail.gmail.com>
	<366bf7b53b044fdd94f12ed21f505841@DM2PR0301MB0862.namprd03.prod.outlook.com>
Date: Wed, 24 Sep 2014 22:39:30 -0300
Message-ID: <CAOMZO5DC55n_2=5qCeGa-cdkRRnc1z9F+hau=jgTkP_66gn=qA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] PCI: imx6: enable pcie on imx6qdl sabreauto
From: Fabio Estevam <festevam@gmail.com>
To: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
Cc: "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 24, 2014 at 10:21 PM, Hong-Xing.Zhu@freescale.com
<Hong-Xing.Zhu@freescale.com> wrote:
> [Richard] Yes it is. On ARD board, the PCIE_RST_B is connected to CPU_PER_RST_B.
> But this is not one signal that can be controlled by PCIE module itself.

Let's take imx6qdl-sabresd.dtsi for example:

&pcie {
    pinctrl-names = "default";
    pinctrl-0 = <&pinctrl_pcie>;
    reset-gpio = <&gpio7 12 0>;
    status = "okay";
};

It uses GPIO7_12 for PCI reset.

For sabreauto we just need to change to something like this format:

reset-gpio = <&max7310_b 2 0>;

> It is kicked once at the moment when the board is powered up.

Yes, the signal is connected to power-on and it can also be
independently controlled via MAX7310.

Anyway, no need to change this if you don't want. I can send a patch
adding the reset later :-)
