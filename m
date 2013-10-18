Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:44191 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab3JRFE7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2013 01:04:59 -0400
Received: by mail-wi0-f173.google.com with SMTP id ey11so397715wid.0
        for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2013 22:04:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1381853200-5534-6-git-send-email-marex@denx.de>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
	<1381853200-5534-6-git-send-email-marex@denx.de>
Date: Thu, 17 Oct 2013 22:04:57 -0700
Message-ID: <CAJ+vNU2_=qVP4mvzwcjBRMxo88Qa+8OQqqwo1f9SqVxSNyavgA@mail.gmail.com>
Subject: Re: [PATCH 5/6] PCI: imx6: Force Gen1 operation
From: Tim Harvey <tharvey@gateworks.com>
To: Marek Vasut <marex@denx.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 15, 2013 at 9:06 AM, Marek Vasut <marex@denx.de> wrote:
> Without forcing the PCIe core into Gen1 operation, the PCIe switch
> attached directly to the PCIe port is not recognised at all. The
> PCIe switch is Gen2 capable to make this issue even more puzzling.
>
[...]
>
>         while (!dw_pcie_link_up(pp)) {
>                 usleep_range(100, 1000);
>                 count++;
> -               if (count >= 10) {
> +               if (count >= 200) {
>                         dev_err(pp->dev, "phy link never came up\n");
>                         dev_dbg(pp->dev,
>                                 "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
> --
> 1.8.4.rc3
>

Marek,

Can you split this patch out?  I found that with the PLX PEX860x PCIe
switches I have on the i.MX6 RC I needed this longer wait for link as
well, but I don't think this is related to gen1/gen2.

Thanks,

Tim
