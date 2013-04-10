Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:48694 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935352Ab3DJIIp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Apr 2013 04:08:45 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so181710pad.30
        for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2013 01:08:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1364395234-11195-8-git-send-email-thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Mitch Bradley <wmb@firmworks.com>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364395234-11195-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130410080838.14359.58967@quantum>
Subject: Re: [PATCHv7 07/17] clk: mvebu: add more PCIe clocks for Armada XP
Date: Wed, 10 Apr 2013 01:08:38 -0700
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Quoting Thomas Petazzoni (2013-03-27 07:40:24)
> The current revision of the datasheet only mentions the gatable clocks
> for the PCIe 0.0, 0.1, 0.2 and 0.3 interfaces, and forgot to mention
> the ones for the PCIe 1.0, 1.1, 1.2, 1.3, 2.0 and 3.0
> interfaces. After confirmation with Marvell engineers, this patch adds
> the missing gatable clocks for those PCIe interfaces.
> 
> It also changes the name of the previously existing PCIe gatable
> clocks, in order to match the naming using the datasheets.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
>  drivers/clk/mvebu/clk-gating-ctrl.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
> index b35785a..2f03723 100644
> --- a/drivers/clk/mvebu/clk-gating-ctrl.c
> +++ b/drivers/clk/mvebu/clk-gating-ctrl.c
> @@ -137,10 +137,14 @@ static const struct mvebu_soc_descr __initconst armada_xp_gating_descr[] = {
>         { "ge2", NULL,  2 },
>         { "ge1", NULL, 3 },
>         { "ge0", NULL, 4 },
> -       { "pex0", NULL, 5 },
> -       { "pex1", NULL, 6 },
> -       { "pex2", NULL, 7 },
> -       { "pex3", NULL, 8 },
> +       { "pex00", NULL, 5 },
> +       { "pex01", NULL, 6 },
> +       { "pex02", NULL, 7 },
> +       { "pex03", NULL, 8 },
> +       { "pex10", NULL, 9 },
> +       { "pex11", NULL, 10 },
> +       { "pex12", NULL, 11 },
> +       { "pex13", NULL, 12 },
>         { "bp", NULL, 13 },
>         { "sata0lnk", NULL, 14 },
>         { "sata0", "sata0lnk", 15 },
> @@ -152,6 +156,8 @@ static const struct mvebu_soc_descr __initconst armada_xp_gating_descr[] = {
>         { "xor0", NULL, 22 },
>         { "crypto", NULL, 23 },
>         { "tdm", NULL, 25 },
> +       { "pex20", NULL, 26 },
> +       { "pex30", NULL, 27 },
>         { "xor1", NULL, 28 },
>         { "sata1lnk", NULL, 29 },
>         { "sata1", "sata1lnk", 30 },
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
