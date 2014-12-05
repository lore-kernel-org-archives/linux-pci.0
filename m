Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.lynxeye.de ([87.118.118.114]:53915 "EHLO lynxeye.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750893AbaLETNs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Dec 2014 14:13:48 -0500
Message-ID: <1417806384.2353.1.camel@lynxeye.de>
Subject: Re: [PATCH 0/2] Tegra PCI multiplatform fixes
From: Lucas Stach <dev@lynxeye.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 05 Dec 2014 20:06:24 +0100
In-Reply-To: <1415907457-3147-1-git-send-email-l.stach@pengutronix.de>
References: <1415907457-3147-1-git-send-email-l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thierry,

could you please have a look at this series? It is needed for Tegra PCI
to be good citizen in a multiplatform kernel configuration and I would
really like to see this going in.

Thanks,
Lucas

Am Donnerstag, den 13.11.2014, 20:37 +0100 schrieb Lucas Stach:
> Two of the registered fixups in the Tegra PCI driver
> would be executed unconditionally and potentially
> harm PCI support on other platforms than Tegra when
> running a multiplatform kernel.
> 
> I've tested that this doesn't alter PCI behavior on both
> T30 Beaver and T124 Jetson-TK1.
> 
> Lucas Stach (2):
>   PCI: tegra: apply relaxed ordering fixup only on Tegra
>   PCI: tegra: remove bogus bridge setup fixup
> 
>  drivers/pci/host/pci-tegra.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
> 


