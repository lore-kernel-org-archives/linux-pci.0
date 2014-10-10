Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:46904 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbaJJOul (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Oct 2014 10:50:41 -0400
Received: by mail-la0-f51.google.com with SMTP id ge10so3351620lab.24
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2014 07:50:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412919676-25344-10-git-send-email-richard.zhu@freescale.com>
References: <1412919676-25344-1-git-send-email-richard.zhu@freescale.com>
	<1412919676-25344-10-git-send-email-richard.zhu@freescale.com>
Date: Fri, 10 Oct 2014 11:50:39 -0300
Message-ID: <CAOMZO5ByYLX4O0-YZdU3XE0A8sE3D9QG34nq4x9B2uQzsv3P2g@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] ARM: imx6sx: enable pcie on imx6sx sdb board
From: Fabio Estevam <festevam@gmail.com>
To: Richard Zhu <richard.zhu@freescale.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shawn Guo <shawn.guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>,
	Richard Zhu <r65037@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 10, 2014 at 2:41 AM, Richard Zhu <richard.zhu@freescale.com> wrote:

> +               pinctrl_pcie: pciegrp {
> +                       fsl,pins = <
> +                               MX6SX_PAD_ENET1_COL__GPIO2_IO_0 0x17059

Why 0x17059 instead of the default 0x10b0?

> +                       >;
> +               };
> +
> +               pinctrl_pcie_reg: pciereggrp {
> +                       fsl,pins = <
> +                               MX6SX_PAD_ENET1_CRS__GPIO2_IO_1 0x17059

Same here.
