Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:51856 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753548Ab3C0Sf7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Mar 2013 14:35:59 -0400
Date: Wed, 27 Mar 2013 12:35:34 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [RFC PATCHv1 3/5] arm: mach-kirkwood: seperate PCIe window init
 from other windows
Message-ID: <20130327183534.GA9643@obsidianresearch.com>
References: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364407504-13524-4-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364407504-13524-4-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 27, 2013 at 07:05:02PM +0100, Thomas Petazzoni wrote:

This all looks really great to me, I hope to try it as well when I get
time. But just one small suggestion:

> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index ea49476..1b4675f 100644
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -72,6 +72,8 @@ static void __init kirkwood_of_clk_init(void)
>  
>  static void __init kirkwood_dt_init(void)
>  {
> +	int needs_pcie_wins = 1;
> +
>  	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
>  
>  	/*
> @@ -144,6 +146,9 @@ static void __init kirkwood_dt_init(void)
>  	if (of_machine_is_compatible("usi,topkick"))
>  		usi_topkick_init();
>  
> +	if (needs_pcie_wins)
> +		kirkwood_setup_pcie_wins();
> +
>  	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
>  }

Moving the window setup into mach-kirkwood/pcie.c:kirkwood_pcie_init
would avoid this needs_pcie_wins thing since kirkwood_pcie_init will
naturally never be called once the other patches are applied.

Cheers,
Jason
