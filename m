Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:56518 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbbAEPbX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jan 2015 10:31:23 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Sean Cross <xobs@kosagi.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawn.guo@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Grant Likely <grant.likely@linaro.org>,
	linux-pci@vger.kernel.org, bunnie@kosagi.com
Subject: Re: [PATCH v2 3/4] PCI: imx6: Add power-supply support
Date: Mon, 05 Jan 2015 16:31:04 +0100
Message-ID: <1760521.28f6F6lDZm@wuerfel>
In-Reply-To: <1419237127-21763-4-git-send-email-xobs@kosagi.com>
References: <1419237127-21763-1-git-send-email-xobs@kosagi.com> <1419237127-21763-4-git-send-email-xobs@kosagi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 22 December 2014 16:32:06 Sean Cross wrote:
> Some PCIe ports gate power to the slot.  In order to prevent system lockup,
> these boards must enable power to the slot before attempting communication
> over the PCI bus.
> 
> Signed-off-by: Sean Cross <xobs@kosagi.com>

Could this be moved to the common pcie-designware driver? It doesn't seem
to be imx6 specific and other drivers might need the same thing.

	Arnd
