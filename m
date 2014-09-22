Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:55287 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752943AbaIVJvU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 05:51:20 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <1411379470-20639-1-git-send-email-phil.edworthy@renesas.com>
References: <1411379470-20639-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1411379470-20639-4-git-send-email-phil.edworthy@renesas.com>
Date: Mon, 22 Sep 2014 10:51:10 +0100
Subject: [RFC PATCH 3/3] ARM: Enable PCI domains
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since there are ARM devices with multiple independant PCI controllers, enable
PCI domains for all ARM devices.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
Marked as RFC as I am not sure of the impact of enabling PCI domains for all
ARM devices. In the march to 'one kernel to rule them all', I steered clear of
mach specific changes.

 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 32cbbd5..8741d3d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1274,6 +1274,7 @@ config ISA_DMA_API
 
 config PCI
 	bool "PCI support" if MIGHT_HAVE_PCI
+	select PCI_DOMAINS
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
@@ -1282,7 +1283,6 @@ config PCI
 
 config PCI_DOMAINS
 	bool
-	depends on PCI
 
 config PCI_NANOENGINE
 	bool "BSE nanoEngine PCI support"
-- 
2.1.0

