Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36710 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab3DJIJI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Apr 2013 04:09:08 -0400
Received: by mail-pd0-f175.google.com with SMTP id g10so132519pdj.20
        for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2013 01:09:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1364395234-11195-7-git-send-email-thomas.petazzoni@free-electrons.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364395234-11195-7-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130410080900.14359.97128@quantum>
Subject: Re: [PATCHv7 06/17] clk: mvebu: create parent-child relation for PCIe clocks
 on Armada 370
Date: Wed, 10 Apr 2013 01:09:00 -0700
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Quoting Thomas Petazzoni (2013-03-27 07:40:23)
> The Armada 370 has two gatable clocks for each PCIe interface, and we
> want both of them to be enabled. We therefore make one of the two
> clocks a child of the other, as we did for the sataX and sataXlnk
> clocks on Armada XP.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Mike Turquette <mturquette@linaro.org>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
>  drivers/clk/mvebu/clk-gating-ctrl.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
> index ebf141d..b35785a 100644
> --- a/drivers/clk/mvebu/clk-gating-ctrl.c
> +++ b/drivers/clk/mvebu/clk-gating-ctrl.c
> @@ -119,8 +119,8 @@ static const struct mvebu_soc_descr __initconst armada_370_gating_descr[] = {
>         { "pex1_en", NULL,  2 },
>         { "ge1", NULL, 3 },
>         { "ge0", NULL, 4 },
> -       { "pex0", NULL, 5 },
> -       { "pex1", NULL, 9 },
> +       { "pex0", "pex0_en", 5 },
> +       { "pex1", "pex1_en", 9 },
>         { "sata0", NULL, 15 },
>         { "sdio", NULL, 17 },
>         { "tdm", NULL, 25 },
> -- 
> 1.7.9.5
