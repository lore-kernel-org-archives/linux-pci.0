Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:58632 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab3JKLzv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2013 07:55:51 -0400
From: Marek Vasut <marex@denx.de>
To: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 2/2] PCI: imx6: Fix the clock for PCIe
Date: Fri, 11 Oct 2013 13:55:04 +0200
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Frank Li'" <lznuaa@gmail.com>,
	"'Richard Zhu'" <r65037@freescale.com>,
	"'Sascha Hauer'" <s.hauer@pengutronix.de>,
	"'Sean Cross'" <xobs@kosagi.com>,
	"'Shawn Guo'" <shawn.guo@linaro.org>,
	"'Tim Harvey'" <tharvey@gateworks.com>,
	"'Yinghai Lu'" <yinghai@kernel.org>
References: <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com> <1381457552-6575-2-git-send-email-marex@denx.de> <000c01cec652$55adbb30$01093190$%han@samsung.com>
In-Reply-To: <000c01cec652$55adbb30$01093190$%han@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310111355.04746.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jingoo Han,

> On Friday, October 11, 2013 11:13 AM, Marek Vasut wrote:
> > The clk #205 are lvds_sel, not lvds_gate , so fix this. Moreover,
> > the PCIe needs lvds_gate for successful operation, so make the PCIe
> > driver enable (set as output) the lvds_gate .
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Frank Li <lznuaa@gmail.com>
> > Cc: Richard Zhu <r65037@freescale.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Sean Cross <xobs@kosagi.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Tim Harvey <tharvey@gateworks.com>
> > Cc: Yinghai Lu <yinghai@kernel.org>
> > ---
> > 
> >  arch/arm/boot/dts/imx6qdl.dtsi |  6 +++---
> >  drivers/pci/host/pci-imx6.c    | 19 ++++++++++++++++++-
> >  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> Hi Marek Vasut,
> 
> How about splitting this patch into two patches such as
> arch part and driver part?
> 
> It is because driver part was merged into PCI tree by Bjorn Helgaas,[1]
> and arch part was merged into i.MX tree by Shawn Guo.[2]
> Thus, your patch can make the conflict issue.
> 
> For example,
>   [PATCH 1/2] ARM: dts: imx6qdl: Fix the clock for PCIe
>   [PATCH 2/2] PCI: imx6: Fix the clock for PCIe
> 
> Then, 1st patch can be merged to i.MX tree, and 2nd patch can be merged
> to PCI tree.
> 
> If I am wrong, please let me know kindly. :-)

By all means, you're right. Is the patch addressing the issue correctly (if we 
ignore that it's not split)? Shawn?

Best regards,
Marek Vasut
