Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:48699 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482Ab3JKHUT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2013 03:20:19 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MUH000ZFTPTBJG0@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 11 Oct 2013 16:20:17 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Marek Vasut' <marex@denx.de>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Frank Li' <lznuaa@gmail.com>,
	'Richard Zhu' <r65037@freescale.com>,
	'Sascha Hauer' <s.hauer@pengutronix.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Shawn Guo' <shawn.guo@linaro.org>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Yinghai Lu' <yinghai@kernel.org>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com>
 <1381457552-6575-1-git-send-email-marex@denx.de>
 <1381457552-6575-2-git-send-email-marex@denx.de>
In-reply-to: <1381457552-6575-2-git-send-email-marex@denx.de>
Subject: Re: [PATCH 2/2] PCI: imx6: Fix the clock for PCIe
Date: Fri, 11 Oct 2013 16:20:16 +0900
Message-id: <000c01cec652$55adbb30$01093190$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, October 11, 2013 11:13 AM, Marek Vasut wrote:
> 
> The clk #205 are lvds_sel, not lvds_gate , so fix this. Moreover,
> the PCIe needs lvds_gate for successful operation, so make the PCIe
> driver enable (set as output) the lvds_gate .
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Frank Li <lznuaa@gmail.com>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Sean Cross <xobs@kosagi.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Yinghai Lu <yinghai@kernel.org>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi |  6 +++---
>  drivers/pci/host/pci-imx6.c    | 19 ++++++++++++++++++-
>  2 files changed, 21 insertions(+), 4 deletions(-)

Hi Marek Vasut,

How about splitting this patch into two patches such as
arch part and driver part?

It is because driver part was merged into PCI tree by Bjorn Helgaas,[1]
and arch part was merged into i.MX tree by Shawn Guo.[2]
Thus, your patch can make the conflict issue.

For example,
  [PATCH 1/2] ARM: dts: imx6qdl: Fix the clock for PCIe
  [PATCH 2/2] PCI: imx6: Fix the clock for PCIe

Then, 1st patch can be merged to i.MX tree, and 2nd patch can be merged
to PCI tree.

If I am wrong, please let me know kindly. :-)

[1] http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=next&id=bb38919ec56e0758c3ae56dfc091dcde1391353e
[2] https://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=commit;h=3a57291fa4ca7f7647d826f5b47082ef306d839f

Best regards,
Jingoo Han

