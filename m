Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:26033 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754230AbaC0J1O (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Mar 2014 05:27:14 -0400
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
In-Reply-To: <1395912416-20087-1-git-send-email-phil.edworthy@renesas.com>
References: <1395912416-20087-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1395912416-20087-11-git-send-email-phil.edworthy@renesas.com>
Date: Thu, 27 Mar 2014 09:26:56 +0000
Subject: [PATCH v6 10/10] ARM: shmobile: koelsch: Add PCIe to defconfig
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

v6:
 - Add shmobile to subject
---
 arch/arm/configs/koelsch_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index 86faab5..ec14547 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -15,6 +15,9 @@ CONFIG_MACH_KOELSCH=y
 CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_RCAR_GEN2_PCIE=y
 CONFIG_SMP=y
 CONFIG_SCHED_MC=y
 CONFIG_NR_CPUS=8
-- 
1.9.0

