Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44372 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933571AbaKMTho (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 14:37:44 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/2] Tegra PCI multiplatform fixes
Date: Thu, 13 Nov 2014 20:37:35 +0100
Message-Id: <1415907457-3147-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Two of the registered fixups in the Tegra PCI driver
would be executed unconditionally and potentially
harm PCI support on other platforms than Tegra when
running a multiplatform kernel.

I've tested that this doesn't alter PCI behavior on both
T30 Beaver and T124 Jetson-TK1.

Lucas Stach (2):
  PCI: tegra: apply relaxed ordering fixup only on Tegra
  PCI: tegra: remove bogus bridge setup fixup

 drivers/pci/host/pci-tegra.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

-- 
2.1.1

