Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61033 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab3CZQyI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 12:54:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [RFCv1 01/11] arm: mvebu: move L2 cache initialization in init_early()
Date: Tue, 26 Mar 2013 16:53:48 +0000
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com> <1364316746-8702-2-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364316746-8702-2-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201303261653.48998.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 26 March 2013, Thomas Petazzoni wrote:
> @@ -72,6 +73,10 @@ void __init armada_370_xp_init_early(void)
>                         ARMADA_370_XP_MBUS_WINS_SIZE,
>                         ARMADA_370_XP_SDRAM_WINS_BASE,
>                         ARMADA_370_XP_SDRAM_WINS_SIZE);
> +
> +#ifdef CONFIG_CACHE_L2X0
> +       l2x0_of_init(0, ~0UL);
> +#endif

I guess you should remove the #ifdef as well here, it's not needed.

	Arnd
