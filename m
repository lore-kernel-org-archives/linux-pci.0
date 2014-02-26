Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:63447 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751747AbaBZQOO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 11:14:14 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <1393430893-2466-1-git-send-email-phil.edworthy@renesas.com>
References: <1393430893-2466-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1393430893-2466-4-git-send-email-phil.edworthy@renesas.com>
Date: Wed, 26 Feb 2014 16:08:11 +0000
Subject: [PATCH 3/5] ARM: shmobile: Add PCIe resources to r8a7791 device
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/mach-shmobile/setup-r8a7791.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index d9393d6..7751aae 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -136,6 +136,16 @@ static struct resource irqc0_resources[] = {
 					  &irqc##idx##_data,		\
 					  sizeof(struct renesas_irqc_config))
 
+/* PCI Express */
+static struct resource pcie_resources[] = {
+	DEFINE_RES_MEM(0xfe000000, SZ_512K),
+	DEFINE_RES_MEM(0xfe100000, SZ_1M),
+	DEFINE_RES_MEM(0xfe200000, SZ_2M),
+	DEFINE_RES_MEM(0x30000000, SZ_128M),
+	DEFINE_RES_MEM(0x38000000, SZ_128M),
+	DEFINE_RES_IRQ(gic_spi(116)),
+};
+
 void __init r8a7791_add_dt_devices(void)
 {
 	r8a7791_register_scif(SCIFA0);
@@ -160,6 +170,9 @@ void __init r8a7791_add_standard_devices(void)
 {
 	r8a7791_add_dt_devices();
 	r8a7791_register_irqc(0);
+	platform_device_register_simple("r8a7791-pcie", -1,
+					pcie_resources,
+					ARRAY_SIZE(pcie_resources));
 }
 
 void __init r8a7791_init_early(void)
-- 
1.7.9.5

