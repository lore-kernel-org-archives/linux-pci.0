Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:46920 "HELO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751076AbbAFQYJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jan 2015 11:24:09 -0500
Received: by mail-pd0-f179.google.com with SMTP id fp1so30810562pdb.10
        for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2015 08:24:08 -0800 (PST)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Tanmay Inamdar <tinamdar@apm.com>, Loc Ho <lho@apm.com>,
	Feng Kan <fkan@apm.com>, Duc Dang <dhdang@apm.com>
Subject: [PATCH 2/4] arm64: dts: Add the device tree entry for the APM X-Gene PCIe MSI node.
Date: Tue,  6 Jan 2015 08:15:42 -0800
Message-Id: <62ab7c42fb400d38eae837b9e090d39b6cc95932.1420499393.git.dhdang@apm.com>
In-Reply-To: <cover.1420499393.git.dhdang@apm.com>
References: <cover.1420499393.git.dhdang@apm.com>
In-Reply-To: <cover.1420499393.git.dhdang@apm.com>
References: <cover.1420499393.git.dhdang@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports.

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
Signed-off-by: Duc Dang <dhdang@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index f1ad9c2..70ba721 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -469,6 +469,27 @@
 			clocks = <&pcie4clk 0>;
 		};
 
+		msi: msi@79000000 {
+			compatible = "apm,xgene-storm-pcie-msi", "apm,xgene-pcie-msi";
+			reg = <0x00 0x79000000 0x0 0x900000>;
+			interrupts = <  0x0 0x10 0x4
+					0x0 0x11 0x4
+					0x0 0x12 0x4
+					0x0 0x13 0x4
+					0x0 0x14 0x4
+					0x0 0x15 0x4
+					0x0 0x16 0x4
+					0x0 0x17 0x4
+					0x0 0x18 0x4
+					0x0 0x19 0x4
+					0x0 0x1a 0x4
+					0x0 0x1b 0x4
+					0x0 0x1c 0x4
+					0x0 0x1d 0x4
+					0x0 0x1e 0x4
+					0x0 0x1f 0x4>;
+		};
+
 		serial0: serial@1c020000 {
 			status = "disabled";
 			device_type = "serial";
-- 
1.9.1

