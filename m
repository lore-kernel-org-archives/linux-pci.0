Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932D34B185;
	Fri, 20 Feb 2026 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771597568; cv=none; b=jTexO7ZuQzraJRu1Dfvjm1+b66umv+jvMZv59C74WyHPtwH/X81Mr+J55i/k/AYM61Tkedf6KQbHkh44dgkObXx5HtnPC4wesiBVC2OF3Dw74i+B2GtNi8/xKLxsAcn1yLOp7yrU3+7CYQzgkMbnGHIm2hCydCib6XVcfvHut18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771597568; c=relaxed/simple;
	bh=ob2ahUBmzpFAaA88qATgl1L+GdLDEcD8y3XJ8ZN6kUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=roI4H/16H7ERTVLoY/J6liBaJfniLXTtmAJEftKgOOsOZO/XT0PO3gWv0jNO+JrcNyj6Yc9+aReIJjDUgHuPBI5MF7OP7T99ylLf+Y0AooXy8/6OxbOoGj6tbPDC+JZPI/pmdj4Oxi7F0K7OIwkVq4DtEo44binxXK+VVI+Uh1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CoRQO1/W; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CoRQO1/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771597566; x=1803133566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ob2ahUBmzpFAaA88qATgl1L+GdLDEcD8y3XJ8ZN6kUI=;
  b=CoRQO1/Wzwfb2GRyU1qpLsLibZ/sEZztwGAkkmPbP4EEi/DQFZ5NOHXK
   MDFUnJ48Ls22luF7dnBUUbhZC+zFahhRu0UamQCHuITbH+5qxQd9/Sj7u
   ZbIY3mKIReaDFjX0/1c/bZPSn1a7PFYyxrhFMGURKka8EHPeKbfLDgOJV
   DfQWm8sAXiwEZsWKCsINzhC2yUAGE+6fPmKYTBx6YiW+RihEprRwlKmIL
   EEEUgowK0Nx7hSmpbEPJD4gM1EqX/S+rwuywUE/uRfa7bTRJ2AZsWHilO
   LTqiC+LI8cjnGZTO/QDoAipyZQA+BdTXBumZ+3PauvcyMXB85AEfQZU9m
   A==;
X-CSE-ConnectionGUID: z6XrNZ40TsOvhAahM8wLWg==
X-CSE-MsgGUID: f19ZklOgQU+aGTNf8GkxIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="76303325"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="76303325"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:26:06 -0800
X-CSE-ConnectionGUID: XEa5LnnFSbafyGRTmz5VEQ==
X-CSE-MsgGUID: 1Ey6sb5mTwipX3PuYZB6cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="213407119"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 20 Feb 2026 06:26:02 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 83A0F95; Fri, 20 Feb 2026 15:26:01 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 1/1] PCI: dwc: Remove not-going-to-be-supported code for Baikal SoC
Date: Fri, 20 Feb 2026 15:21:12 +0100
Message-ID: <20260220142600.2397070-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As noticed in the discussion [1] the Baikal SoC and platforms
are not going to be finalized, hence remove stale code.

Link: https://lore.kernel.org/lkml/22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org/ [1]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: removed YAML file

 .../bindings/pci/baikal,bt1-pcie.yaml         | 168 -----
 drivers/pci/controller/dwc/Kconfig            |   9 -
 drivers/pci/controller/dwc/Makefile           |   1 -
 drivers/pci/controller/dwc/pcie-bt1.c         | 645 ------------------
 4 files changed, 823 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
 delete mode 100644 drivers/pci/controller/dwc/pcie-bt1.c

diff --git a/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
deleted file mode 100644
index 8eaa07ae9774..000000000000
--- a/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
+++ /dev/null
@@ -1,168 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/pci/baikal,bt1-pcie.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Baikal-T1 PCIe Root Port Controller
-
-maintainers:
-  - Serge Semin <fancer.lancer@gmail.com>
-
-description:
-  Embedded into Baikal-T1 SoC Root Complex controller with a single port
-  activated. It's based on the DWC RC PCIe v4.60a IP-core, which is configured
-  to have just a single Root Port function and is capable of establishing the
-  link up to Gen.3 speed on x4 lanes. It doesn't have embedded clock and reset
-  control module, so the proper interface initialization is supposed to be
-  performed by software. There four in- and four outbound iATU regions
-  which can be used to emit all required TLP types on the PCIe bus.
-
-allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
-
-properties:
-  compatible:
-    const: baikal,bt1-pcie
-
-  reg:
-    description:
-      DBI, DBI2 and at least 4KB outbound iATU-capable region for the
-      peripheral devices CFG-space access.
-    maxItems: 3
-
-  reg-names:
-    items:
-      - const: dbi
-      - const: dbi2
-      - const: config
-
-  interrupts:
-    description:
-      MSI, AER, PME, Hot-plug, Link Bandwidth Management, Link Equalization
-      request and eight Read/Write eDMA IRQ lines are available.
-    maxItems: 14
-
-  interrupt-names:
-    items:
-      - const: dma0
-      - const: dma1
-      - const: dma2
-      - const: dma3
-      - const: dma4
-      - const: dma5
-      - const: dma6
-      - const: dma7
-      - const: msi
-      - const: aer
-      - const: pme
-      - const: hp
-      - const: bw_mg
-      - const: l_eq
-
-  clocks:
-    description:
-      DBI (attached to the APB bus), AXI-bus master and slave interfaces
-      are fed up by the dedicated application clocks. A common reference
-      clock signal is supposed to be attached to the corresponding Ref-pad
-      of the SoC. It will be redistributed amongst the controller core
-      sub-modules (pipe, core, aux, etc).
-    maxItems: 4
-
-  clock-names:
-    items:
-      - const: dbi
-      - const: mstr
-      - const: slv
-      - const: ref
-
-  resets:
-    description:
-      A comprehensive controller reset logic is supposed to be implemented
-      by software, so almost all the possible application and core reset
-      signals are exposed via the system CCU module.
-    maxItems: 9
-
-  reset-names:
-    items:
-      - const: mstr
-      - const: slv
-      - const: pwr
-      - const: hot
-      - const: phy
-      - const: core
-      - const: pipe
-      - const: sticky
-      - const: non-sticky
-
-  baikal,bt1-syscon:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description:
-      Phandle to the Baikal-T1 System Controller DT node. It's required to
-      access some additional PM, Reset-related and LTSSM signals.
-
-  num-lanes:
-    maximum: 4
-
-  max-link-speed:
-    maximum: 3
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - interrupts
-  - interrupt-names
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/mips-gic.h>
-    #include <dt-bindings/gpio/gpio.h>
-
-    pcie@1f052000 {
-      compatible = "baikal,bt1-pcie";
-      device_type = "pci";
-      reg = <0x1f052000 0x1000>, <0x1f053000 0x1000>, <0x1bdbf000 0x1000>;
-      reg-names = "dbi", "dbi2", "config";
-      #address-cells = <3>;
-      #size-cells = <2>;
-      ranges = <0x81000000 0 0x00000000 0x1bdb0000 0 0x00008000>,
-               <0x82000000 0 0x20000000 0x08000000 0 0x13db0000>;
-      bus-range = <0x0 0xff>;
-
-      interrupts = <GIC_SHARED 80 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SHARED 81 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SHARED 82 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SHARED 83 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SHARED 84 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SHARED 85 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SHARED 86 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SHARED 87 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SHARED 88 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SHARED 89 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SHARED 90 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SHARED 91 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SHARED 92 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SHARED 93 IRQ_TYPE_LEVEL_HIGH>;
-      interrupt-names = "dma0", "dma1", "dma2", "dma3",
-                        "dma4", "dma5", "dma6", "dma7",
-                        "msi", "aer", "pme", "hp", "bw_mg",
-                        "l_eq";
-
-      clocks = <&ccu_sys 1>, <&ccu_axi 6>, <&ccu_axi 7>, <&clk_pcie>;
-      clock-names = "dbi", "mstr", "slv", "ref";
-
-      resets = <&ccu_axi 6>, <&ccu_axi 7>, <&ccu_sys 7>, <&ccu_sys 10>,
-               <&ccu_sys 4>, <&ccu_sys 6>, <&ccu_sys 5>, <&ccu_sys 8>,
-               <&ccu_sys 9>;
-      reset-names = "mstr", "slv", "pwr", "hot", "phy", "core", "pipe",
-                    "sticky", "non-sticky";
-
-      reset-gpios = <&port0 0 GPIO_ACTIVE_LOW>;
-
-      num-lanes = <4>;
-      max-link-speed = <3>;
-    };
-...
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 6c7e726d1909..3c1136a92e88 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -84,15 +84,6 @@ config PCIE_ARTPEC6_EP
 	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
 	  endpoint mode. This uses the DesignWare core.
 
-config PCIE_BT1
-	tristate "Baikal-T1 PCIe controller"
-	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
-	depends on PCI_MSI
-	select PCIE_DW_HOST
-	help
-	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
-	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
-
 config PCI_IMX6
 	bool
 
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 67ba59c02038..4867f30ab7c3 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -5,7 +5,6 @@ obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
 obj-$(CONFIG_PCIE_AMD_MDB) += pcie-amd-mdb.o
-obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
 obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
deleted file mode 100644
index 1340edc18d12..000000000000
--- a/drivers/pci/controller/dwc/pcie-bt1.c
+++ /dev/null
@@ -1,645 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
- *
- * Authors:
- *   Vadim Vlasov <Vadim.Vlasov@baikalelectronics.ru>
- *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
- *
- * Baikal-T1 PCIe controller driver
- */
-
-#include <linux/bitfield.h>
-#include <linux/bits.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/gpio/consumer.h>
-#include <linux/kernel.h>
-#include <linux/mfd/syscon.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
-#include <linux/reset.h>
-#include <linux/types.h>
-
-#include "pcie-designware.h"
-
-/* Baikal-T1 System CCU control registers */
-#define BT1_CCU_PCIE_CLKC			0x140
-#define BT1_CCU_PCIE_REQ_PCS_CLK		BIT(16)
-#define BT1_CCU_PCIE_REQ_MAC_CLK		BIT(17)
-#define BT1_CCU_PCIE_REQ_PIPE_CLK		BIT(18)
-
-#define BT1_CCU_PCIE_RSTC			0x144
-#define BT1_CCU_PCIE_REQ_LINK_RST		BIT(13)
-#define BT1_CCU_PCIE_REQ_SMLH_RST		BIT(14)
-#define BT1_CCU_PCIE_REQ_PHY_RST		BIT(16)
-#define BT1_CCU_PCIE_REQ_CORE_RST		BIT(24)
-#define BT1_CCU_PCIE_REQ_STICKY_RST		BIT(26)
-#define BT1_CCU_PCIE_REQ_NSTICKY_RST		BIT(27)
-
-#define BT1_CCU_PCIE_PMSC			0x148
-#define BT1_CCU_PCIE_LTSSM_STATE_MASK		GENMASK(5, 0)
-#define BT1_CCU_PCIE_LTSSM_DET_QUIET		0x00
-#define BT1_CCU_PCIE_LTSSM_DET_ACT		0x01
-#define BT1_CCU_PCIE_LTSSM_POLL_ACT		0x02
-#define BT1_CCU_PCIE_LTSSM_POLL_COMP		0x03
-#define BT1_CCU_PCIE_LTSSM_POLL_CONF		0x04
-#define BT1_CCU_PCIE_LTSSM_PRE_DET_QUIET	0x05
-#define BT1_CCU_PCIE_LTSSM_DET_WAIT		0x06
-#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_START	0x07
-#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_ACEPT	0x08
-#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_WAIT	0x09
-#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_ACEPT	0x0a
-#define BT1_CCU_PCIE_LTSSM_CFG_COMPLETE		0x0b
-#define BT1_CCU_PCIE_LTSSM_CFG_IDLE		0x0c
-#define BT1_CCU_PCIE_LTSSM_RCVR_LOCK		0x0d
-#define BT1_CCU_PCIE_LTSSM_RCVR_SPEED		0x0e
-#define BT1_CCU_PCIE_LTSSM_RCVR_RCVRCFG		0x0f
-#define BT1_CCU_PCIE_LTSSM_RCVR_IDLE		0x10
-#define BT1_CCU_PCIE_LTSSM_L0			0x11
-#define BT1_CCU_PCIE_LTSSM_L0S			0x12
-#define BT1_CCU_PCIE_LTSSM_L123_SEND_IDLE	0x13
-#define BT1_CCU_PCIE_LTSSM_L1_IDLE		0x14
-#define BT1_CCU_PCIE_LTSSM_L2_IDLE		0x15
-#define BT1_CCU_PCIE_LTSSM_L2_WAKE		0x16
-#define BT1_CCU_PCIE_LTSSM_DIS_ENTRY		0x17
-#define BT1_CCU_PCIE_LTSSM_DIS_IDLE		0x18
-#define BT1_CCU_PCIE_LTSSM_DISABLE		0x19
-#define BT1_CCU_PCIE_LTSSM_LPBK_ENTRY		0x1a
-#define BT1_CCU_PCIE_LTSSM_LPBK_ACTIVE		0x1b
-#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT		0x1c
-#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT_TOUT	0x1d
-#define BT1_CCU_PCIE_LTSSM_HOT_RST_ENTRY	0x1e
-#define BT1_CCU_PCIE_LTSSM_HOT_RST		0x1f
-#define BT1_CCU_PCIE_LTSSM_RCVR_EQ0		0x20
-#define BT1_CCU_PCIE_LTSSM_RCVR_EQ1		0x21
-#define BT1_CCU_PCIE_LTSSM_RCVR_EQ2		0x22
-#define BT1_CCU_PCIE_LTSSM_RCVR_EQ3		0x23
-#define BT1_CCU_PCIE_SMLH_LINKUP		BIT(6)
-#define BT1_CCU_PCIE_RDLH_LINKUP		BIT(7)
-#define BT1_CCU_PCIE_PM_LINKSTATE_L0S		BIT(8)
-#define BT1_CCU_PCIE_PM_LINKSTATE_L1		BIT(9)
-#define BT1_CCU_PCIE_PM_LINKSTATE_L2		BIT(10)
-#define BT1_CCU_PCIE_L1_PENDING			BIT(12)
-#define BT1_CCU_PCIE_REQ_EXIT_L1		BIT(14)
-#define BT1_CCU_PCIE_LTSSM_RCVR_EQ		BIT(15)
-#define BT1_CCU_PCIE_PM_DSTAT_MASK		GENMASK(18, 16)
-#define BT1_CCU_PCIE_PM_PME_EN			BIT(20)
-#define BT1_CCU_PCIE_PM_PME_STATUS		BIT(21)
-#define BT1_CCU_PCIE_AUX_PM_EN			BIT(22)
-#define BT1_CCU_PCIE_AUX_PWR_DET		BIT(23)
-#define BT1_CCU_PCIE_WAKE_DET			BIT(24)
-#define BT1_CCU_PCIE_TURNOFF_REQ		BIT(30)
-#define BT1_CCU_PCIE_TURNOFF_ACK		BIT(31)
-
-#define BT1_CCU_PCIE_GENC			0x14c
-#define BT1_CCU_PCIE_LTSSM_EN			BIT(1)
-#define BT1_CCU_PCIE_DBI2_MODE			BIT(2)
-#define BT1_CCU_PCIE_MGMT_EN			BIT(3)
-#define BT1_CCU_PCIE_RXLANE_FLIP_EN		BIT(16)
-#define BT1_CCU_PCIE_TXLANE_FLIP_EN		BIT(17)
-#define BT1_CCU_PCIE_SLV_XFER_PEND		BIT(24)
-#define BT1_CCU_PCIE_RCV_XFER_PEND		BIT(25)
-#define BT1_CCU_PCIE_DBI_XFER_PEND		BIT(26)
-#define BT1_CCU_PCIE_DMA_XFER_PEND		BIT(27)
-
-#define BT1_CCU_PCIE_LTSSM_LINKUP(_pmsc) \
-({ \
-	int __state = FIELD_GET(BT1_CCU_PCIE_LTSSM_STATE_MASK, _pmsc); \
-	__state >= BT1_CCU_PCIE_LTSSM_L0 && __state <= BT1_CCU_PCIE_LTSSM_L2_WAKE; \
-})
-
-/* Baikal-T1 PCIe specific control registers */
-#define BT1_PCIE_AXI2MGM_LANENUM		0xd04
-#define BT1_PCIE_AXI2MGM_LANESEL_MASK		GENMASK(3, 0)
-
-#define BT1_PCIE_AXI2MGM_ADDRCTL		0xd08
-#define BT1_PCIE_AXI2MGM_PHYREG_ADDR_MASK	GENMASK(20, 0)
-#define BT1_PCIE_AXI2MGM_READ_FLAG		BIT(29)
-#define BT1_PCIE_AXI2MGM_DONE			BIT(30)
-#define BT1_PCIE_AXI2MGM_BUSY			BIT(31)
-
-#define BT1_PCIE_AXI2MGM_WRITEDATA		0xd0c
-#define BT1_PCIE_AXI2MGM_WDATA			GENMASK(15, 0)
-
-#define BT1_PCIE_AXI2MGM_READDATA		0xd10
-#define BT1_PCIE_AXI2MGM_RDATA			GENMASK(15, 0)
-
-/* Generic Baikal-T1 PCIe interface resources */
-#define BT1_PCIE_NUM_APP_CLKS			ARRAY_SIZE(bt1_pcie_app_clks)
-#define BT1_PCIE_NUM_CORE_CLKS			ARRAY_SIZE(bt1_pcie_core_clks)
-#define BT1_PCIE_NUM_APP_RSTS			ARRAY_SIZE(bt1_pcie_app_rsts)
-#define BT1_PCIE_NUM_CORE_RSTS			ARRAY_SIZE(bt1_pcie_core_rsts)
-
-/* PCIe bus setup delays and timeouts */
-#define BT1_PCIE_RST_DELAY_MS			100
-#define BT1_PCIE_RUN_DELAY_US			100
-#define BT1_PCIE_REQ_DELAY_US			1
-#define BT1_PCIE_REQ_TIMEOUT_US			1000
-#define BT1_PCIE_LNK_DELAY_US			1000
-#define BT1_PCIE_LNK_TIMEOUT_US			1000000
-
-static const enum dw_pcie_app_clk bt1_pcie_app_clks[] = {
-	DW_PCIE_DBI_CLK, DW_PCIE_MSTR_CLK, DW_PCIE_SLV_CLK,
-};
-
-static const enum dw_pcie_core_clk bt1_pcie_core_clks[] = {
-	DW_PCIE_REF_CLK,
-};
-
-static const enum dw_pcie_app_rst bt1_pcie_app_rsts[] = {
-	DW_PCIE_MSTR_RST, DW_PCIE_SLV_RST,
-};
-
-static const enum dw_pcie_core_rst bt1_pcie_core_rsts[] = {
-	DW_PCIE_NON_STICKY_RST, DW_PCIE_STICKY_RST, DW_PCIE_CORE_RST,
-	DW_PCIE_PIPE_RST, DW_PCIE_PHY_RST, DW_PCIE_HOT_RST, DW_PCIE_PWR_RST,
-};
-
-struct bt1_pcie {
-	struct dw_pcie dw;
-	struct platform_device *pdev;
-	struct regmap *sys_regs;
-};
-#define to_bt1_pcie(_dw) container_of(_dw, struct bt1_pcie, dw)
-
-/*
- * Baikal-T1 MMIO space must be read/written by the dword-aligned
- * instructions. Note the methods are optimized to have the dword operations
- * performed with minimum overhead as the most frequently used ones.
- */
-static int bt1_pcie_read_mmio(void __iomem *addr, int size, u32 *val)
-{
-	unsigned int ofs = (uintptr_t)addr & 0x3;
-
-	if (!IS_ALIGNED((uintptr_t)addr, size))
-		return -EINVAL;
-
-	*val = readl(addr - ofs) >> ofs * BITS_PER_BYTE;
-	if (size == 4) {
-		return 0;
-	} else if (size == 2) {
-		*val &= 0xffff;
-		return 0;
-	} else if (size == 1) {
-		*val &= 0xff;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static int bt1_pcie_write_mmio(void __iomem *addr, int size, u32 val)
-{
-	unsigned int ofs = (uintptr_t)addr & 0x3;
-	u32 tmp, mask;
-
-	if (!IS_ALIGNED((uintptr_t)addr, size))
-		return -EINVAL;
-
-	if (size == 4) {
-		writel(val, addr);
-		return 0;
-	} else if (size == 2 || size == 1) {
-		mask = GENMASK(size * BITS_PER_BYTE - 1, 0);
-		tmp = readl(addr - ofs) & ~(mask << ofs * BITS_PER_BYTE);
-		tmp |= (val & mask) << ofs * BITS_PER_BYTE;
-		writel(tmp, addr - ofs);
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static u32 bt1_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
-			     size_t size)
-{
-	int ret;
-	u32 val;
-
-	ret = bt1_pcie_read_mmio(base + reg, size, &val);
-	if (ret) {
-		dev_err(pci->dev, "Read DBI address failed\n");
-		return ~0U;
-	}
-
-	return val;
-}
-
-static void bt1_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
-			       size_t size, u32 val)
-{
-	int ret;
-
-	ret = bt1_pcie_write_mmio(base + reg, size, val);
-	if (ret)
-		dev_err(pci->dev, "Write DBI address failed\n");
-}
-
-static void bt1_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
-				size_t size, u32 val)
-{
-	struct bt1_pcie *btpci = to_bt1_pcie(pci);
-	int ret;
-
-	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
-			   BT1_CCU_PCIE_DBI2_MODE, BT1_CCU_PCIE_DBI2_MODE);
-
-	ret = bt1_pcie_write_mmio(base + reg, size, val);
-	if (ret)
-		dev_err(pci->dev, "Write DBI2 address failed\n");
-
-	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
-			   BT1_CCU_PCIE_DBI2_MODE, 0);
-}
-
-static int bt1_pcie_start_link(struct dw_pcie *pci)
-{
-	struct bt1_pcie *btpci = to_bt1_pcie(pci);
-	u32 val;
-	int ret;
-
-	/*
-	 * Enable LTSSM and make sure it was able to establish both PHY and
-	 * data links. This procedure shall work fine to reach 2.5 GT/s speed.
-	 */
-	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
-			   BT1_CCU_PCIE_LTSSM_EN, BT1_CCU_PCIE_LTSSM_EN);
-
-	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_PMSC, val,
-				       (val & BT1_CCU_PCIE_SMLH_LINKUP),
-				       BT1_PCIE_LNK_DELAY_US, BT1_PCIE_LNK_TIMEOUT_US);
-	if (ret) {
-		dev_err(pci->dev, "LTSSM failed to set PHY link up\n");
-		return ret;
-	}
-
-	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_PMSC, val,
-				       (val & BT1_CCU_PCIE_RDLH_LINKUP),
-				       BT1_PCIE_LNK_DELAY_US, BT1_PCIE_LNK_TIMEOUT_US);
-	if (ret) {
-		dev_err(pci->dev, "LTSSM failed to set data link up\n");
-		return ret;
-	}
-
-	/*
-	 * Activate direct speed change after the link is established in an
-	 * attempt to reach a higher bus performance (up to Gen.3 - 8.0 GT/s).
-	 * This is required at least to get 8.0 GT/s speed.
-	 */
-	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
-
-	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_PMSC, val,
-				       BT1_CCU_PCIE_LTSSM_LINKUP(val),
-				       BT1_PCIE_LNK_DELAY_US, BT1_PCIE_LNK_TIMEOUT_US);
-	if (ret)
-		dev_err(pci->dev, "LTSSM failed to get into L0 state\n");
-
-	return ret;
-}
-
-static void bt1_pcie_stop_link(struct dw_pcie *pci)
-{
-	struct bt1_pcie *btpci = to_bt1_pcie(pci);
-
-	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
-			   BT1_CCU_PCIE_LTSSM_EN, 0);
-}
-
-static const struct dw_pcie_ops bt1_pcie_ops = {
-	.read_dbi = bt1_pcie_read_dbi,
-	.write_dbi = bt1_pcie_write_dbi,
-	.write_dbi2 = bt1_pcie_write_dbi2,
-	.start_link = bt1_pcie_start_link,
-	.stop_link = bt1_pcie_stop_link,
-};
-
-static struct pci_ops bt1_pci_ops = {
-	.map_bus = dw_pcie_own_conf_map_bus,
-	.read = pci_generic_config_read32,
-	.write = pci_generic_config_write32,
-};
-
-static int bt1_pcie_get_resources(struct bt1_pcie *btpci)
-{
-	struct device *dev = btpci->dw.dev;
-	int i;
-
-	/* DBI access is supposed to be performed by the dword-aligned IOs */
-	btpci->dw.pp.bridge->ops = &bt1_pci_ops;
-
-	/* These CSRs are in MMIO so we won't check the regmap-methods status */
-	btpci->sys_regs =
-		syscon_regmap_lookup_by_phandle(dev->of_node, "baikal,bt1-syscon");
-	if (IS_ERR(btpci->sys_regs))
-		return dev_err_probe(dev, PTR_ERR(btpci->sys_regs),
-				     "Failed to get syscon\n");
-
-	/* Make sure all the required resources have been specified */
-	for (i = 0; i < BT1_PCIE_NUM_APP_CLKS; i++) {
-		if (!btpci->dw.app_clks[bt1_pcie_app_clks[i]].clk) {
-			dev_err(dev, "App clocks set is incomplete\n");
-			return -ENOENT;
-		}
-	}
-
-	for (i = 0; i < BT1_PCIE_NUM_CORE_CLKS; i++) {
-		if (!btpci->dw.core_clks[bt1_pcie_core_clks[i]].clk) {
-			dev_err(dev, "Core clocks set is incomplete\n");
-			return -ENOENT;
-		}
-	}
-
-	for (i = 0; i < BT1_PCIE_NUM_APP_RSTS; i++) {
-		if (!btpci->dw.app_rsts[bt1_pcie_app_rsts[i]].rstc) {
-			dev_err(dev, "App resets set is incomplete\n");
-			return -ENOENT;
-		}
-	}
-
-	for (i = 0; i < BT1_PCIE_NUM_CORE_RSTS; i++) {
-		if (!btpci->dw.core_rsts[bt1_pcie_core_rsts[i]].rstc) {
-			dev_err(dev, "Core resets set is incomplete\n");
-			return -ENOENT;
-		}
-	}
-
-	return 0;
-}
-
-static void bt1_pcie_full_stop_bus(struct bt1_pcie *btpci, bool init)
-{
-	struct device *dev = btpci->dw.dev;
-	struct dw_pcie *pci = &btpci->dw;
-	int ret;
-
-	/* Disable LTSSM for sure */
-	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
-			   BT1_CCU_PCIE_LTSSM_EN, 0);
-
-	/*
-	 * Application reset controls are trigger-based so assert the core
-	 * resets only.
-	 */
-	ret = reset_control_bulk_assert(DW_PCIE_NUM_CORE_RSTS, pci->core_rsts);
-	if (ret)
-		dev_err(dev, "Failed to assert core resets\n");
-
-	/*
-	 * Clocks are disabled by default at least in accordance with the clk
-	 * enable counter value on init stage.
-	 */
-	if (!init) {
-		clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, pci->core_clks);
-
-		clk_bulk_disable_unprepare(DW_PCIE_NUM_APP_CLKS, pci->app_clks);
-	}
-
-	/* The peripheral devices are unavailable anyway so reset them too */
-	gpiod_set_value_cansleep(pci->pe_rst, 1);
-
-	/* Make sure all the resets are settled */
-	msleep(BT1_PCIE_RST_DELAY_MS);
-}
-
-/*
- * Implements the cold reset procedure in accordance with the reference manual
- * and available PM signals.
- */
-static int bt1_pcie_cold_start_bus(struct bt1_pcie *btpci)
-{
-	struct device *dev = btpci->dw.dev;
-	struct dw_pcie *pci = &btpci->dw;
-	u32 val;
-	int ret;
-
-	/* First get out of the Power/Hot reset state */
-	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_PWR_RST].rstc);
-	if (ret) {
-		dev_err(dev, "Failed to deassert PHY reset\n");
-		return ret;
-	}
-
-	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_HOT_RST].rstc);
-	if (ret) {
-		dev_err(dev, "Failed to deassert hot reset\n");
-		goto err_assert_pwr_rst;
-	}
-
-	/* Wait for the PM-core to stop requesting the PHY reset */
-	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_RSTC, val,
-				       !(val & BT1_CCU_PCIE_REQ_PHY_RST),
-				       BT1_PCIE_REQ_DELAY_US, BT1_PCIE_REQ_TIMEOUT_US);
-	if (ret) {
-		dev_err(dev, "Timed out waiting for PM to stop PHY resetting\n");
-		goto err_assert_hot_rst;
-	}
-
-	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_PHY_RST].rstc);
-	if (ret) {
-		dev_err(dev, "Failed to deassert PHY reset\n");
-		goto err_assert_hot_rst;
-	}
-
-	/* Clocks can be now enabled, but the ref one is crucial at this stage */
-	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_APP_CLKS, pci->app_clks);
-	if (ret) {
-		dev_err(dev, "Failed to enable app clocks\n");
-		goto err_assert_phy_rst;
-	}
-
-	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, pci->core_clks);
-	if (ret) {
-		dev_err(dev, "Failed to enable ref clocks\n");
-		goto err_disable_app_clk;
-	}
-
-	/* Wait for the PM to stop requesting the controller core reset */
-	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_RSTC, val,
-				       !(val & BT1_CCU_PCIE_REQ_CORE_RST),
-				       BT1_PCIE_REQ_DELAY_US, BT1_PCIE_REQ_TIMEOUT_US);
-	if (ret) {
-		dev_err(dev, "Timed out waiting for PM to stop core resetting\n");
-		goto err_disable_core_clk;
-	}
-
-	/* PCS-PIPE interface and controller core can be now activated */
-	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_PIPE_RST].rstc);
-	if (ret) {
-		dev_err(dev, "Failed to deassert PIPE reset\n");
-		goto err_disable_core_clk;
-	}
-
-	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_CORE_RST].rstc);
-	if (ret) {
-		dev_err(dev, "Failed to deassert core reset\n");
-		goto err_assert_pipe_rst;
-	}
-
-	/* It's recommended to reset the core and application logic together */
-	ret = reset_control_bulk_reset(DW_PCIE_NUM_APP_RSTS, pci->app_rsts);
-	if (ret) {
-		dev_err(dev, "Failed to reset app domain\n");
-		goto err_assert_core_rst;
-	}
-
-	/* Sticky/Non-sticky CSR flags can be now unreset too */
-	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_STICKY_RST].rstc);
-	if (ret) {
-		dev_err(dev, "Failed to deassert sticky reset\n");
-		goto err_assert_core_rst;
-	}
-
-	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_NON_STICKY_RST].rstc);
-	if (ret) {
-		dev_err(dev, "Failed to deassert non-sticky reset\n");
-		goto err_assert_sticky_rst;
-	}
-
-	/* Activate the PCIe bus peripheral devices */
-	gpiod_set_value_cansleep(pci->pe_rst, 0);
-
-	/* Make sure the state is settled (LTSSM is still disabled though) */
-	usleep_range(BT1_PCIE_RUN_DELAY_US, BT1_PCIE_RUN_DELAY_US + 100);
-
-	return 0;
-
-err_assert_sticky_rst:
-	reset_control_assert(pci->core_rsts[DW_PCIE_STICKY_RST].rstc);
-
-err_assert_core_rst:
-	reset_control_assert(pci->core_rsts[DW_PCIE_CORE_RST].rstc);
-
-err_assert_pipe_rst:
-	reset_control_assert(pci->core_rsts[DW_PCIE_PIPE_RST].rstc);
-
-err_disable_core_clk:
-	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, pci->core_clks);
-
-err_disable_app_clk:
-	clk_bulk_disable_unprepare(DW_PCIE_NUM_APP_CLKS, pci->app_clks);
-
-err_assert_phy_rst:
-	reset_control_assert(pci->core_rsts[DW_PCIE_PHY_RST].rstc);
-
-err_assert_hot_rst:
-	reset_control_assert(pci->core_rsts[DW_PCIE_HOT_RST].rstc);
-
-err_assert_pwr_rst:
-	reset_control_assert(pci->core_rsts[DW_PCIE_PWR_RST].rstc);
-
-	return ret;
-}
-
-static int bt1_pcie_host_init(struct dw_pcie_rp *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct bt1_pcie *btpci = to_bt1_pcie(pci);
-	int ret;
-
-	ret = bt1_pcie_get_resources(btpci);
-	if (ret)
-		return ret;
-
-	bt1_pcie_full_stop_bus(btpci, true);
-
-	return bt1_pcie_cold_start_bus(btpci);
-}
-
-static void bt1_pcie_host_deinit(struct dw_pcie_rp *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct bt1_pcie *btpci = to_bt1_pcie(pci);
-
-	bt1_pcie_full_stop_bus(btpci, false);
-}
-
-static const struct dw_pcie_host_ops bt1_pcie_host_ops = {
-	.init = bt1_pcie_host_init,
-	.deinit = bt1_pcie_host_deinit,
-};
-
-static struct bt1_pcie *bt1_pcie_create_data(struct platform_device *pdev)
-{
-	struct bt1_pcie *btpci;
-
-	btpci = devm_kzalloc(&pdev->dev, sizeof(*btpci), GFP_KERNEL);
-	if (!btpci)
-		return ERR_PTR(-ENOMEM);
-
-	btpci->pdev = pdev;
-
-	platform_set_drvdata(pdev, btpci);
-
-	return btpci;
-}
-
-static int bt1_pcie_add_port(struct bt1_pcie *btpci)
-{
-	struct device *dev = &btpci->pdev->dev;
-	int ret;
-
-	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
-	if (ret)
-		return ret;
-
-	btpci->dw.version = DW_PCIE_VER_460A;
-	btpci->dw.dev = dev;
-	btpci->dw.ops = &bt1_pcie_ops;
-
-	btpci->dw.pp.num_vectors = MAX_MSI_IRQS;
-	btpci->dw.pp.ops = &bt1_pcie_host_ops;
-
-	dw_pcie_cap_set(&btpci->dw, REQ_RES);
-
-	ret = dw_pcie_host_init(&btpci->dw.pp);
-
-	return dev_err_probe(dev, ret, "Failed to initialize DWC PCIe host\n");
-}
-
-static void bt1_pcie_del_port(struct bt1_pcie *btpci)
-{
-	dw_pcie_host_deinit(&btpci->dw.pp);
-}
-
-static int bt1_pcie_probe(struct platform_device *pdev)
-{
-	struct bt1_pcie *btpci;
-
-	btpci = bt1_pcie_create_data(pdev);
-	if (IS_ERR(btpci))
-		return PTR_ERR(btpci);
-
-	return bt1_pcie_add_port(btpci);
-}
-
-static void bt1_pcie_remove(struct platform_device *pdev)
-{
-	struct bt1_pcie *btpci = platform_get_drvdata(pdev);
-
-	bt1_pcie_del_port(btpci);
-}
-
-static const struct of_device_id bt1_pcie_of_match[] = {
-	{ .compatible = "baikal,bt1-pcie" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, bt1_pcie_of_match);
-
-static struct platform_driver bt1_pcie_driver = {
-	.probe = bt1_pcie_probe,
-	.remove = bt1_pcie_remove,
-	.driver = {
-		.name	= "bt1-pcie",
-		.of_match_table = bt1_pcie_of_match,
-	},
-};
-module_platform_driver(bt1_pcie_driver);
-
-MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
-MODULE_DESCRIPTION("Baikal-T1 PCIe driver");
-MODULE_LICENSE("GPL");
-- 
2.50.1

