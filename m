Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:54350 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbaJYT4g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 Oct 2014 15:56:36 -0400
Received: by mail-la0-f51.google.com with SMTP id q1so951121lam.24
        for <linux-pci@vger.kernel.org>; Sat, 25 Oct 2014 12:56:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1414118200-2018-2-git-send-email-richard.zhu@freescale.com>
References: <1414118200-2018-1-git-send-email-richard.zhu@freescale.com>
	<1414118200-2018-2-git-send-email-richard.zhu@freescale.com>
Date: Sat, 25 Oct 2014 10:46:54 -0200
Message-ID: <CAOMZO5DxSXmNXU0pZ0QOb82niVmgmS34nM_ub+-KheG7BvgJFA@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: imx6: Wait the clocks to stabilize after ref_en
From: Fabio Estevam <festevam@gmail.com>
To: Richard Zhu <richard.zhu@freescale.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shawn Guo <shawn.guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>,
	m-karicheri2 <m-karicheri2@ti.com>,
	Richard Zhu <r65037@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Richard,

On Fri, Oct 24, 2014 at 12:36 AM, Richard Zhu <richard.zhu@freescale.com> wrote:
> From: Richard Zhu <r65037@freescale.com>
>
> For boards without a reset GPIO we skip the delay between enabling the
> pcie_ref_clk and touching the RC registers for configuration.
> This hangs the system if there isn't a proper delay to ensure the clocks
> are settled in the DW PCIe core.
>
> Also iMX6Q always needs an additional 10us delay to make sure the reset
> is propagated through the core, as we don't have an explicitly
> controlled reset input on this SoC.
>
> Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
> Tested-by: Tim Harvey <tharvey@gateworks.com>
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

The previous Tested-by tags that myself and Tim gave were for the
previous version of the patch without the delay.

I tested this new version of the patch now and you have my new tag :-)

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

I would suggest you to resed this patch (you can add Lucas's Acked-by)
and also make sure to copy Bjorn so that it can be applied to 3.18 as
a fix.

Thanks
