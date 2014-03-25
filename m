Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:21937 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754022AbaCYQ4z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Mar 2014 12:56:55 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com>
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1395766604-30926-10-git-send-email-phil.edworthy@renesas.com>
Date: Tue, 25 Mar 2014 16:56:44 +0000
Subject: [PATCH v5 9/9] ARM: koelsch: Add HAVE_ARM_ARCH_TIMER to defconfig
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is fixes a boot problem when the R-Car PCIe driver is enabled.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/configs/koelsch_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index ec14547..67666b6 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -15,6 +15,7 @@ CONFIG_MACH_KOELSCH=y
 CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
+CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_RCAR_GEN2_PCIE=y
-- 
1.9.0

