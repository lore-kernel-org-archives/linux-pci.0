Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33730 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbaJXTBh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Oct 2014 15:01:37 -0400
Received: by mail-lb0-f175.google.com with SMTP id u10so3014740lbd.6
        for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2014 12:01:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1414117852-31657-2-git-send-email-richard.zhu@freescale.com>
References: <1414117852-31657-1-git-send-email-richard.zhu@freescale.com>
	<1414117852-31657-2-git-send-email-richard.zhu@freescale.com>
Date: Fri, 24 Oct 2014 17:01:32 -0200
Message-ID: <CAOMZO5BttdTucmnbAu7ULHBkyp0kccu_qxTwf61y18sRST-0wg@mail.gmail.com>
Subject: Re: [PATCH V1] PCI: imx6: Wait the clocks to stabilize after ref_en
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

On Fri, Oct 24, 2014 at 12:30 AM, Richard Zhu <richard.zhu@freescale.com> wrote:

> -       /* allow the clocks to stabilize */
> -       usleep_range(200, 500);
> -
>         /* power up core phy and enable ref clock */
>         regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>                         IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> +       /*
> +        * the async reset input need ref clock to sync internally,
> +        * when the ref clock comes after reset, internal synced
> +        * reset time is too short , cannot meet the requirement.
> +        * add one ~10us delay here.
> +        */
> +       udelay(10);

I am curious about this delay here: have you seen boot issues without
it? If so, which hardware was that?
