Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:27830 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752476AbaBZSMS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 13:12:18 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <1393438283-10542-1-git-send-email-phil.edworthy@renesas.com>
References: <1393438283-10542-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1393438283-10542-6-git-send-email-phil.edworthy@renesas.com>
Date: Wed, 26 Feb 2014 18:11:23 +0000
Subject: [PATCH 5/5 v2 RFC] ARM: koelsch: Add PCIe to defconfig
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/configs/koelsch_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index c59768e..adb67d5 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -20,6 +20,9 @@ CONFIG_MACH_KOELSCH=y
 CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
+CONFIG_PCI=y
+CONFIG_PCI_RCAR_GEN2_PCIE=y
+CONFIG_PCIEPORTBUS=y
 CONFIG_SMP=y
 CONFIG_SCHED_MC=y
 CONFIG_NR_CPUS=8
-- 
1.7.9.5

