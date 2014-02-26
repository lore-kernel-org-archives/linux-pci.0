Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:63447 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752610AbaBZQOP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 11:14:15 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <1393430893-2466-1-git-send-email-phil.edworthy@renesas.com>
References: <1393430893-2466-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1393430893-2466-5-git-send-email-phil.edworthy@renesas.com>
Date: Wed, 26 Feb 2014 16:08:12 +0000
Subject: [PATCH 4/5] ARM: shmobile: Add PCIe to r8a7791 device Kconfig
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index a4a4b75..c623633 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -100,6 +100,8 @@ config ARCH_R8A7791
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
+	select MIGHT_HAVE_PCI
+	select PCI_QUIRKS if PCI
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
-- 
1.7.9.5

