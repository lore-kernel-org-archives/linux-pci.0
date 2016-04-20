Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37265 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbcDTPp4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2016 11:45:56 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	gary.bisson@boundarydevices.com
Subject: [PATCH v3 3/3] ARM: dts: imx6qp: Specify imx6qp version of PCIe core
Date: Wed, 20 Apr 2016 08:45:31 -0700
Message-Id: <1461167131-26025-3-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1461167131-26025-1-git-send-email-andrew.smirnov@gmail.com>
References: <1461167131-26025-1-git-send-email-andrew.smirnov@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I.MX6Quad Plus has a slightly different version of PCIe core than
reqular i.MX6Quad.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---


Changes since v2:
	- Removed default clause in all introduced switch statements
	- Switched to using of_device_get_match_data instead of
          explicit of_device_is_compatible checks
	- Added a mention of the new DT compatibility string in the documentation

Changes since v1:

	- Patchset is rebased against
          https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-imx6
	- DTS files changes moved into a separate patch


 arch/arm/boot/dts/imx6qp.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index 1ada714..886dbf2 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -82,5 +82,8 @@
 				      "ldb_di0", "ldb_di1", "prg";
 		};
 
+		pcie: pcie@0x01000000 {
+			compatible = "fsl,imx6qp-pcie", "snps,dw-pcie";
+		};
 	};
 };
-- 
2.5.5

