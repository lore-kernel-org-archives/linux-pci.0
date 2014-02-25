Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36254 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbaBYRra (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2014 12:47:30 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <r65037@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 0/2] PCI: imx6: MSI support
Date: Tue, 25 Feb 2014 18:47:22 +0100
Message-Id: <1393350444-29784-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Those two simple patches add support for MSI to the
i.MX6 PCIe host controller driver.

The first patch should probably go through Shawns tree, while
the second one should go through the PCI tree. I'm only posting
them together to get you the whole picture.

Juergen Beisert (2):
  ARM: dts: imx6: adjust the interrupt list in order to support MSI
  PCI: imx6: add support for MSI

 arch/arm/boot/dts/imx6qdl.dtsi |  3 ++-
 drivers/pci/host/pci-imx6.c    | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

-- 
1.8.5.3

