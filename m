Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35945 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030685AbbKEPkc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2015 10:40:32 -0500
Received: by igdg1 with SMTP id g1so14409078igd.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2015 07:40:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1446735481-27326-1-git-send-email-tharvey@gateworks.com>
References: <1446735481-27326-1-git-send-email-tharvey@gateworks.com>
Date: Thu, 5 Nov 2015 13:40:32 -0200
Message-ID: <CAOMZO5COsBaL_Czo_V-GoDAaycJX2kOziYzzo4Dp5b1pKP_amA@mail.gmail.com>
Subject: Re: [PATCH RFC] PCI: imx6: add dt prop for link gen, default to gen1
From: Fabio Estevam <festevam@gmail.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Richard Zhu <r65037@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Adding Richard Zhu]

On Thu, Nov 5, 2015 at 12:58 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> Freescale has stated [1] that the LVDS clock source of the IMX6 does not pass
> the PCI Gen2 clock jitter test, therefore unless an external Gen2 compliant
> external clock source is present and supplied back to the IMX6 PCIe core
> via LVDS CLK1/CLK2 you can not claim Gen2 compliance.
>
> Add a dt property to specify gen1 vs gen2 and check this before allowing
> a Gen2 link.
>
> We default to Gen1 if the property is not present because at this time there
> are no IMX6 boards in mainline that 'input' a clock on LVDS CLK1/CLK2.
>
> In order to be Gen2 compliant on IMX6 you need to:
>  - have a Gen2 compliant external clock generator and route that clock back
>    to either LVDS CLK1 or LVDS CLK2 as an input.
>    (see IMX6SX-SabreSD reference design)
>  - specify this clock in the pcie node in the dt
>    (ie IMX6QDL_CLK_LVDS1_IN or IMX6QDL_CLK_LVDS2_IN instead of
>     IMX6QDL_CLK_LVDS1_GATE which configures it as a CLK output)
>
> [1] https://community.freescale.com/message/453209
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>
> This is an RFC because I'm assuming the decision to default to Gen1 link only
> is going to ruffle some feathers. My understanding is that if you do not
> use an external Gen2 compliant clockgen for peripepherals 'and' the IMX6 core
> you should not claim Gen2 compliance. This was not obvious on original IMX6
> reference designs and I believe the jitter issue was discovered by Freescale
> later and future reference designs were modified to state you need an ext
> clockgen for Gen2 compliance.

Looks good to me:

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
