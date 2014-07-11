Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:49783 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbaGKNuo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jul 2014 09:50:44 -0400
Received: by mail-pd0-f169.google.com with SMTP id ft15so1438033pdb.14
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2014 06:50:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>, arnd@linaro.org,
	olof@lixom.net
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <08c2b017de1d545e42d97ce911ed913aeba46ca9.1404976058.git.viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com,
	b.zolnierkie@samsung.com, bhelgaas@google.com, mark@nicholnet.com,
	linux-pci@vger.kernel.org,
	"Pratyush Anand" <pratyush.anand@st.com>,
	"Viresh Kumar" <viresh.kumar@linaro.org>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
 <08c2b017de1d545e42d97ce911ed913aeba46ca9.1404976058.git.viresh.kumar@linaro.org>
Message-ID: <20140711135038.9850.6196@quantum>
Subject: Re: [PATCH V9 3/7] ARM: SPEAr13xx: Fix pcie clock name
Date: Fri, 11 Jul 2014 06:50:38 -0700
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Quoting Viresh Kumar (2014-07-10 00:26:34)
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> Follow dt clock naming convention for PCIe clocks.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Mike Turquette <mturquette@linaro.org>
> [viresh: fixed logs/cclist]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to clk-next.

Regards,
Mike

> ---
>  drivers/clk/spear/spear1310_clock.c | 6 +++---
>  drivers/clk/spear/spear1340_clock.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
> index 65894f7..4daa597 100644
> --- a/drivers/clk/spear/spear1310_clock.c
> +++ b/drivers/clk/spear/spear1310_clock.c
> @@ -742,19 +742,19 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
>         clk = clk_register_gate(NULL, "pcie_sata_0_clk", "ahb_clk", 0,
>                         SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_PCIE_SATA_0_CLK_ENB,
>                         0, &_lock);
> -       clk_register_clkdev(clk, NULL, "dw_pcie.0");
> +       clk_register_clkdev(clk, NULL, "b1000000.pcie");
>         clk_register_clkdev(clk, NULL, "b1000000.ahci");
>  
>         clk = clk_register_gate(NULL, "pcie_sata_1_clk", "ahb_clk", 0,
>                         SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_PCIE_SATA_1_CLK_ENB,
>                         0, &_lock);
> -       clk_register_clkdev(clk, NULL, "dw_pcie.1");
> +       clk_register_clkdev(clk, NULL, "b1800000.pcie");
>         clk_register_clkdev(clk, NULL, "b1800000.ahci");
>  
>         clk = clk_register_gate(NULL, "pcie_sata_2_clk", "ahb_clk", 0,
>                         SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_PCIE_SATA_2_CLK_ENB,
>                         0, &_lock);
> -       clk_register_clkdev(clk, NULL, "dw_pcie.2");
> +       clk_register_clkdev(clk, NULL, "b4000000.pcie");
>         clk_register_clkdev(clk, NULL, "b4000000.ahci");
>  
>         clk = clk_register_gate(NULL, "sysram0_clk", "ahb_clk", 0,
> diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
> index fe835c1..5a5c664 100644
> --- a/drivers/clk/spear/spear1340_clock.c
> +++ b/drivers/clk/spear/spear1340_clock.c
> @@ -839,7 +839,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
>         clk = clk_register_gate(NULL, "pcie_sata_clk", "ahb_clk", 0,
>                         SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_PCIE_SATA_CLK_ENB,
>                         0, &_lock);
> -       clk_register_clkdev(clk, NULL, "dw_pcie");
> +       clk_register_clkdev(clk, NULL, "b1000000.pcie");
>         clk_register_clkdev(clk, NULL, "b1000000.ahci");
>  
>         clk = clk_register_gate(NULL, "sysram0_clk", "ahb_clk", 0,
> -- 
> 2.0.0.rc2
> 
