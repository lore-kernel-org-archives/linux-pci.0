Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:36055 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933075Ab3CHPTx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Mar 2013 10:19:53 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Olof Johansson <olof@lixom.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Eran Ben-Avi <benavi@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v4 18/18] arm: mvebu: update defconfig with PCI and USB support
Date: Fri,  8 Mar 2013 16:19:20 +0100
Message-Id: <1362755960-30791-19-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1362755960-30791-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362755960-30791-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we have the necessary drivers and Device Tree informations to
support PCIe on Armada 370 and Armada XP, enable the CONFIG_PCI
option.

Also, since the Armada 370 Mirabox has a built-in USB XHCI controller
connected on the PCIe bus, enable the corresponding options as well.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 2ec8119..071a5b1 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -13,6 +13,8 @@ CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_XP=y
 # CONFIG_CACHE_L2X0 is not set
 # CONFIG_SWP_EMULATE is not set
+CONFIG_PCI=y
+CONFIG_PCI_MVEBU=y
 CONFIG_SMP=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
@@ -53,6 +55,7 @@ CONFIG_USB_SUPPORT=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_XHCI_HCD=y
 CONFIG_MMC=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_NEW_LEDS=y
-- 
1.7.9.5

