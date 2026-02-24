Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1C3396D05
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935662; cv=none; b=T+bxWs3Umly5gHVbqwOThANQxqIFpUlyxQVqjDsMjZt1j04kV3shToYktz2zP1tLtIW/P2XetlRwfh/7GcLfg8qtydqJrARPvK0hxtKpbbNHZftFQ5esPSNW63bGoJ676HmUdK2DbhYN+ezCpt/oESf+OJozhKhMzsfIBs4DerE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935662; c=relaxed/simple;
	bh=vdq7Dsr0HTGgGV/rEsq86YAWdmr1EZmBQyEUGPlpEFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEMDgsdpovFWEBUYMX8INJYBOBpbFnVwjuwomkIT2INpauZG5pE21ZHCIwA9Z4VfcF7HPfecsShzwYwjqwvS7lUgMUp+5HOtKBJhP3hqvpuap1NqDH2ue2CFBsfg84TlWKHl1PlaNb4pPQfTMlJganTyz9VcBIdDFo2MIsDfWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1dxB29A; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1dxB29A"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82311f4070cso3266398b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 04:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771935661; x=1772540461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNUhGN2cviXrsigAKa0wCXrDKZYvpfYbqun2EtH//ys=;
        b=k1dxB29AvqAqtwaO/pg/OWLc6yjxI3isb8lHTR+YzVrcr7GzNlO8BuQB80MT6MpjK/
         s+cn21f266cTNaCTgLC2azIofpGMn/h9r0OosVy+aZDwRX0do+ERspR7gFl2B7BNB9uK
         /bPi4Mzpnxeem4cQneLDmlEKd3HBum3Qk77yoyPJCPJYHN+fLRLeCIIkZoFOFEUL3fmV
         s96GPD8XEgdexLZBZdh3BX1kn66WpE4gyiyfkDXtz2+9HrnvHrgw6kolRMbluKMhZ0xT
         Cs2qn+efv+ZPFwp12LArkR4QlGPmZe4P4n1jVNoI7F6xRUfDxIUMqnk/7ZfuogrkEqAt
         cEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771935661; x=1772540461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZNUhGN2cviXrsigAKa0wCXrDKZYvpfYbqun2EtH//ys=;
        b=IK0N1j2dq8Rf1i6S6goNaXfp6Nf/MPvrq8M1gyWWW9hBWaoAdqhEvG2hYdx7Djte2Y
         2YoB4zhScIHraVTkbWgz1LhJax0d/0IFrtG81qfawAH3eC6l3iH9eXvcxO4YNovYodUz
         RPUThYyXStwT/Qy/R3wK3B9UgInpeF1yhsa+pGXhNw14QMkwn585oETcYzfDmOJy1S4v
         SsL1shdBTHhfCWlO0DYpkH6xaA7Lmu4Q1wiwolLFTr8LYyZE+LrxIWPXm0o7hh894CFf
         w4JDJaXvVUq5l/WwYMmmKFW1M1Fo95lAM/ihoUzf2mMbLxjUQfq/qid0oWjo9XQTPku/
         4PVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVHUlG9gik0JTSq93mpkDvBJNbIoU9b1sjoWNrRnJbglCrdxXOD+H+wcM+fZaSNGMWjvDMSZOXZsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+eofqrQ8QucJlq9S5wR8/6q/fhITVte22VsbhxUxtLvupCGHb
	MZLy7gNR5r1B2YBXnThNrGEZGu63d215Yvdzbt9dhA2V31bvZi/HemZe
X-Gm-Gg: ATEYQzyrw4KhvIW/qdko/MibvQr9ZvsvfYGLubJ9PFFUL6YmHH1W8Ki99BuMtXfsvKd
	C2cxl3GnGrC4LpOUY+Ty2HkTx+8oqU+XqQVX1KbRxWVVv4fK0DFPzrZc8iUsUHXQfWxATpOpZI+
	DzR4DWRHA7/vh/sSzmSEl+fbayGMZJA28R5V7wH3pIJ4ht+XdIXwbtwAf7KCzjTxjaj9CFwrdVm
	M51+cszCS5coI+Vt/PqpgHNGSYizw88MllA+aovk6uhosY82AWkQlHLwxe43AIs/GBELOz1C1wu
	ktSFPpC7Z7cnb4VjopLPNoW1OXqC/fsnzP/aKfOM14JUdGvIiMfL8Fv3WiqNM6wmxCMDXM7wVPQ
	XGmqVbrE5rihScw9BYjfDruYsb1Mmhf9jEZNdOktJo/nM+14pY87bWE9GNMagWjnxYiaoBdIW2v
	t9O6Dcq8uyRRDkXGFk8Aw=
X-Received: by 2002:a05:6a00:1150:b0:824:3d5b:3cd3 with SMTP id d2e1a72fcca58-826db59819bmr9505254b3a.0.1771935660653;
        Tue, 24 Feb 2026 04:21:00 -0800 (PST)
Received: from rockpi-5b ([45.112.0.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ba11bsm10613950b3a.50.2026.02.24.04.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 04:20:59 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <webgeek1234@gmail.com>,
	linux-tegra@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v3 5/5] PCI: tegra: Use BIT() and GENMASK() macros for register definitions
Date: Tue, 24 Feb 2026 17:49:01 +0530
Message-ID: <20260224121948.25218-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260224121948.25218-1-linux.amoon@gmail.com>
References: <20260224121948.25218-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual bit operations with standard BIT() and GENMASK() macros.
This eliminates magic numbers, enhances readability, improves
maintainability, and resolves checkpatch.pl warnings.

Cc: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: None
v2: improve the commit message
v1: New patch
---
 drivers/pci/controller/pci-tegra.c | 129 +++++++++++++++--------------
 1 file changed, 65 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 459a2bb1a065..2c806404f572 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -13,6 +13,7 @@
  * Author: Thierry Reding <treding@nvidia.com>
  */
 
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/cleanup.h>
 #include <linux/debugfs.h>
@@ -85,17 +86,17 @@
 #define AFI_MSI_EN_VEC(x)	(0x8c + ((x) * 4))
 
 #define AFI_CONFIGURATION		0xac
-#define  AFI_CONFIGURATION_EN_FPCI		(1 << 0)
-#define  AFI_CONFIGURATION_CLKEN_OVERRIDE	(1 << 31)
+#define  AFI_CONFIGURATION_EN_FPCI		BIT(0)
+#define  AFI_CONFIGURATION_CLKEN_OVERRIDE	BIT(31)
 
 #define AFI_FPCI_ERROR_MASKS	0xb0
 
 #define AFI_INTR_MASK		0xb4
-#define  AFI_INTR_MASK_INT_MASK	(1 << 0)
-#define  AFI_INTR_MASK_MSI_MASK	(1 << 8)
+#define  AFI_INTR_MASK_INT_MASK	BIT(0)
+#define  AFI_INTR_MASK_MSI_MASK	BIT(8)
 
 #define AFI_INTR_CODE			0xb8
-#define  AFI_INTR_CODE_MASK		0xf
+#define  AFI_INTR_CODE_MASK		GENMASK(3, 0)
 #define  AFI_INTR_INI_SLAVE_ERROR	1
 #define  AFI_INTR_INI_DECODE_ERROR	2
 #define  AFI_INTR_TARGET_ABORT		3
@@ -114,32 +115,32 @@
 #define AFI_INTR_SIGNATURE	0xbc
 #define AFI_UPPER_FPCI_ADDRESS	0xc0
 #define AFI_SM_INTR_ENABLE	0xc4
-#define  AFI_SM_INTR_INTA_ASSERT	(1 << 0)
-#define  AFI_SM_INTR_INTB_ASSERT	(1 << 1)
-#define  AFI_SM_INTR_INTC_ASSERT	(1 << 2)
-#define  AFI_SM_INTR_INTD_ASSERT	(1 << 3)
-#define  AFI_SM_INTR_INTA_DEASSERT	(1 << 4)
-#define  AFI_SM_INTR_INTB_DEASSERT	(1 << 5)
-#define  AFI_SM_INTR_INTC_DEASSERT	(1 << 6)
-#define  AFI_SM_INTR_INTD_DEASSERT	(1 << 7)
+#define  AFI_SM_INTR_INTA_ASSERT	BIT(0)
+#define  AFI_SM_INTR_INTB_ASSERT	BIT(1)
+#define  AFI_SM_INTR_INTC_ASSERT	BIT(2)
+#define  AFI_SM_INTR_INTD_ASSERT	BIT(3)
+#define  AFI_SM_INTR_INTA_DEASSERT	BIT(4)
+#define  AFI_SM_INTR_INTB_DEASSERT	BIT(5)
+#define  AFI_SM_INTR_INTC_DEASSERT	BIT(6)
+#define  AFI_SM_INTR_INTD_DEASSERT	BIT(7)
 
 #define AFI_AFI_INTR_ENABLE		0xc8
-#define  AFI_INTR_EN_INI_SLVERR		(1 << 0)
-#define  AFI_INTR_EN_INI_DECERR		(1 << 1)
-#define  AFI_INTR_EN_TGT_SLVERR		(1 << 2)
-#define  AFI_INTR_EN_TGT_DECERR		(1 << 3)
-#define  AFI_INTR_EN_TGT_WRERR		(1 << 4)
-#define  AFI_INTR_EN_DFPCI_DECERR	(1 << 5)
-#define  AFI_INTR_EN_AXI_DECERR		(1 << 6)
-#define  AFI_INTR_EN_FPCI_TIMEOUT	(1 << 7)
-#define  AFI_INTR_EN_PRSNT_SENSE	(1 << 8)
+#define  AFI_INTR_EN_INI_SLVERR		BIT(0)
+#define  AFI_INTR_EN_INI_DECERR		BIT(1)
+#define  AFI_INTR_EN_TGT_SLVERR		BIT(2)
+#define  AFI_INTR_EN_TGT_DECERR		BIT(3)
+#define  AFI_INTR_EN_TGT_WRERR		BIT(4)
+#define  AFI_INTR_EN_DFPCI_DECERR	BIT(5)
+#define  AFI_INTR_EN_AXI_DECERR		BIT(6)
+#define  AFI_INTR_EN_FPCI_TIMEOUT	BIT(7)
+#define  AFI_INTR_EN_PRSNT_SENSE	BIT(8)
 
 #define AFI_PCIE_PME		0xf0
 
 #define AFI_PCIE_CONFIG					0x0f8
-#define  AFI_PCIE_CONFIG_PCIE_DISABLE(x)		(1 << ((x) + 1))
-#define  AFI_PCIE_CONFIG_PCIE_DISABLE_ALL		0xe
-#define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_MASK	(0xf << 20)
+#define  AFI_PCIE_CONFIG_PCIE_DISABLE(x)		BIT((x) + 1)
+#define  AFI_PCIE_CONFIG_PCIE_DISABLE_ALL		GENMASK(3, 1)
+#define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_MASK	GENMASK(23, 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_SINGLE	(0x0 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_420	(0x0 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_X2_X1	(0x0 << 20)
@@ -150,79 +151,79 @@
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_211	(0x1 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_411	(0x2 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_111	(0x2 << 20)
-#define  AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO(x)		(1 << ((x) + 29))
-#define  AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO_ALL		(0x7 << 29)
+#define  AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO(x)		BIT((x) + 29)
+#define  AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO_ALL		GENMASK(31, 29)
 
 #define AFI_FUSE			0x104
-#define  AFI_FUSE_PCIE_T0_GEN2_DIS	(1 << 2)
+#define  AFI_FUSE_PCIE_T0_GEN2_DIS	BIT(2)
 
 #define AFI_PEX0_CTRL			0x110
 #define AFI_PEX1_CTRL			0x118
-#define  AFI_PEX_CTRL_RST		(1 << 0)
-#define  AFI_PEX_CTRL_CLKREQ_EN		(1 << 1)
-#define  AFI_PEX_CTRL_REFCLK_EN		(1 << 3)
-#define  AFI_PEX_CTRL_OVERRIDE_EN	(1 << 4)
+#define  AFI_PEX_CTRL_RST		BIT(0)
+#define  AFI_PEX_CTRL_CLKREQ_EN		BIT(1)
+#define  AFI_PEX_CTRL_REFCLK_EN		BIT(3)
+#define  AFI_PEX_CTRL_OVERRIDE_EN	BIT(4)
 
 #define AFI_PLLE_CONTROL		0x160
-#define  AFI_PLLE_CONTROL_BYPASS_PADS2PLLE_CONTROL (1 << 9)
-#define  AFI_PLLE_CONTROL_PADS2PLLE_CONTROL_EN (1 << 1)
+#define  AFI_PLLE_CONTROL_BYPASS_PADS2PLLE_CONTROL BIT(9)
+#define  AFI_PLLE_CONTROL_PADS2PLLE_CONTROL_EN BIT(1)
 
 #define AFI_PEXBIAS_CTRL_0		0x168
 
 #define RP_ECTL_2_R1	0x00000e84
-#define  RP_ECTL_2_R1_RX_CTLE_1C_MASK		0xffff
+#define  RP_ECTL_2_R1_RX_CTLE_1C_MASK		GENMASK(15, 0)
 
 #define RP_ECTL_4_R1	0x00000e8c
-#define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_MASK	(0xffff << 16)
+#define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_MASK	GENMASK(31, 16)
 #define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_SHIFT	16
 
 #define RP_ECTL_5_R1	0x00000e90
-#define  RP_ECTL_5_R1_RX_EQ_CTRL_L_1C_MASK	0xffffffff
+#define  RP_ECTL_5_R1_RX_EQ_CTRL_L_1C_MASK	GENMASK(31, 0)
 
 #define RP_ECTL_6_R1	0x00000e94
-#define  RP_ECTL_6_R1_RX_EQ_CTRL_H_1C_MASK	0xffffffff
+#define  RP_ECTL_6_R1_RX_EQ_CTRL_H_1C_MASK	GENMASK(31, 0)
 
 #define RP_ECTL_2_R2	0x00000ea4
 #define  RP_ECTL_2_R2_RX_CTLE_1C_MASK	0xffff
 
 #define RP_ECTL_4_R2	0x00000eac
-#define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_MASK	(0xffff << 16)
+#define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_MASK	GENMASK(31, 16)
 #define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_SHIFT	16
 
 #define RP_ECTL_5_R2	0x00000eb0
-#define  RP_ECTL_5_R2_RX_EQ_CTRL_L_1C_MASK	0xffffffff
+#define  RP_ECTL_5_R2_RX_EQ_CTRL_L_1C_MASK	GENMASK(31, 0)
 
 #define RP_ECTL_6_R2	0x00000eb4
-#define  RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK	0xffffffff
+#define  RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK	GENMASK(31, 0)
 
 #define RP_VEND_XP	0x00000f00
-#define  RP_VEND_XP_DL_UP			(1 << 30)
-#define  RP_VEND_XP_OPPORTUNISTIC_ACK		(1 << 27)
-#define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
-#define  RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK	(0xff << 18)
+#define  RP_VEND_XP_DL_UP			BIT(30)
+#define  RP_VEND_XP_OPPORTUNISTIC_ACK		BIT(27)
+#define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	BIT(28)
+#define  RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK	GENMASK(25, 18)
 
 #define RP_VEND_CTL0	0x00000f44
-#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	(0xf << 12)
+#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	GENMASK(15, 12)
 #define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH	(0x9 << 12)
 
 #define RP_VEND_CTL1	0x00000f48
-#define  RP_VEND_CTL1_ERPT	(1 << 13)
+#define  RP_VEND_CTL1_ERPT	BIT(13)
 
 #define RP_VEND_XP_BIST	0x00000f4c
-#define  RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE	(1 << 28)
+#define  RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE	BIT(28)
 
 #define RP_VEND_CTL2 0x00000fa8
-#define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
+#define  RP_VEND_CTL2_PCA_ENABLE BIT(7)
 
 #define RP_PRIV_MISC	0x00000fe0
-#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT		(0xe << 0)
-#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT		(0xf << 0)
-#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD_MASK	(0x7f << 16)
+#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT		GENMASK(3, 1)
+#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT		GENMASK(3, 0)
+#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD_MASK	GENMASK(22, 16)
 #define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD		(0xf << 16)
-#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_ENABLE		(1 << 23)
-#define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD_MASK	(0x7f << 24)
+#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_ENABLE		BIT(23)
+#define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD_MASK	GENMASK(30, 24)
 #define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD		(0xf << 24)
-#define  RP_PRIV_MISC_TMS_CLK_CLAMP_ENABLE		(1 << 31)
+#define  RP_PRIV_MISC_TMS_CLK_CLAMP_ENABLE		BIT(31)
 
 #define RP_LINK_CONTROL_STATUS			0x00000090
 #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
@@ -233,22 +234,22 @@
 #define PADS_CTL_SEL		0x0000009c
 
 #define PADS_CTL		0x000000a0
-#define  PADS_CTL_IDDQ_1L	(1 << 0)
-#define  PADS_CTL_TX_DATA_EN_1L	(1 << 6)
-#define  PADS_CTL_RX_DATA_EN_1L	(1 << 10)
+#define  PADS_CTL_IDDQ_1L	BIT(0)
+#define  PADS_CTL_TX_DATA_EN_1L	BIT(6)
+#define  PADS_CTL_RX_DATA_EN_1L	BIT(10)
 
 #define PADS_PLL_CTL_TEGRA20			0x000000b8
 #define PADS_PLL_CTL_TEGRA30			0x000000b4
-#define  PADS_PLL_CTL_RST_B4SM			(1 << 1)
-#define  PADS_PLL_CTL_LOCKDET			(1 << 8)
-#define  PADS_PLL_CTL_REFCLK_MASK		(0x3 << 16)
+#define  PADS_PLL_CTL_RST_B4SM			BIT(1)
+#define  PADS_PLL_CTL_LOCKDET			BIT(8)
+#define  PADS_PLL_CTL_REFCLK_MASK		GENMASK(17, 16)
 #define  PADS_PLL_CTL_REFCLK_INTERNAL_CML	(0 << 16)
-#define  PADS_PLL_CTL_REFCLK_INTERNAL_CMOS	(1 << 16)
+#define  PADS_PLL_CTL_REFCLK_INTERNAL_CMOS	BIT(16)
 #define  PADS_PLL_CTL_REFCLK_EXTERNAL		(2 << 16)
 #define  PADS_PLL_CTL_TXCLKREF_MASK		(0x1 << 20)
 #define  PADS_PLL_CTL_TXCLKREF_DIV10		(0 << 20)
-#define  PADS_PLL_CTL_TXCLKREF_DIV5		(1 << 20)
-#define  PADS_PLL_CTL_TXCLKREF_BUF_EN		(1 << 22)
+#define  PADS_PLL_CTL_TXCLKREF_DIV5		BIT(20)
+#define  PADS_PLL_CTL_TXCLKREF_BUF_EN		BIT(22)
 
 #define PADS_REFCLK_CFG0			0x000000c8
 #define PADS_REFCLK_CFG1			0x000000cc
-- 
2.50.1

