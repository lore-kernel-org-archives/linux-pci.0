Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794821747;
	b=jaKS5rcVGh7rh73wPiDQqSrKDLVamfHLKjK4b2MrzaXkKvcg3STW0e1yDiq/APOECUf0
	 v4KrzyVvJ10vNG6k8MGDVFVbrLL19NtVRlNWO5FKUn+XPMn5VDzvztw6bN3FJabxln0Tv
	 RW6M0JyEQVoz0dWCsRn+zYaDcMNqZGEhEg0pbHaLrkDcxxuR1IvacLKNjyTmFyP5S3lVs
	 K0RtLqYwtYi2C6kRCLLmRLkRxSCcd2JpQe6egvrdrn1/uKRvT2BY7HNpvBHB+YYsK7IcD
	 B0V0gY+qP97FK4z8ZIs9nVQ29Xex4lKWXeVh+5PX1KXDfj5+BKr65pNAT3G4XifiKYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821747;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OOcLabl5ezZ1UkzwIkQf5ogcQm5sNSJAbcdcVxctfRc=;
	b=p+oEs6ppc0/+Gw2pVQ6rlCRjF8xOluc+5DfMN0grDOyrCWMtwLVP6Yc1/km8nwNBr6fa
	 XscK7NOkmPFE4ove0LrSolYTazsWcqnpLGvCGmbO1n85qVTCVaa6SIuObtAoLUMSAbTRx
	 YIhLZEROuO/758BBTCDs9+5tS1genNq4+3mC7cVuRxzcbPGQl6fZCeGpSfAx8tuyXE0x/
	 33GVcDZ/VwowF550MbQ1s2gk9NcWL5SGEcBRDo2ktT+KcLsf11LRNN6ZZGK+SvQzpMJy7
	 12pllR4PVgl55y1BQuZP0W59zqS0HGudyLO9ORaQ+kyA9Vg2FrMpQLIDCIoSiyyTeQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRLOv1uS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51085606A338;
	Mon, 16 Nov 2026 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRLOv1uS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794821747;
	b=urM/kOmB3J7+gMAKEBOXPzsw1Ps4yPAW2CR2csrFtTwNozoozRu3Yy7s68BUpXG+Nljs
	 PD8OdVXPvSMSQoAJ5L1WJiWEwmbYZuWkg/LYZpgN7SUYAXzINlX7zr9P/rpdik5E6uJIb
	 ZGMk9hnUQLPBnH8YwwyRgADUOoI5eDsJVtqpEcOy0aILp998WOk7civa41UW3zJ6z0fRm
	 C+xM7mRG2AG5n4RC9Y2dPB2G5QJ9bPYrKIiFDVcm3ucfsHWyU1aG3nEsXMixBkENwkDUT
	 OwbKyhAVgmWDsXrUBw069uTCylrnT0mNekfKxgpRRTs+IlS81zeXcZEhG1t/lBXW8iQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794821747;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OOcLabl5ezZ1UkzwIkQf5ogcQm5sNSJAbcdcVxctfRc=;
	b=AN8nayaHP6a1TmU0YwzHAd0kLlPbWC7kOTiRqAl2+kDNaw66RclxIHYzPOl1V8XM8Gbj
	 ese/p9faoWodwZbwh7GYDZEUWi6KJVe/kjsj8X8IQ47V1LbPFe2G8s5pFdb1MurJDDJaO
	 Ygfh9pDsyu813s5G/4OFFY0ahEwzUJm3pdT7a8AeWX7wyNnwop94JMQY+iRRwaQANhptw
	 qrqK8IzuD+RkkQnH0OPtfZtXWVXpJnnYRRBVcEPWTVPjKDh/S8A6z7ccSXbWEs3opq2eq
	 q/rYzULlOgmihmY0EuyUC4TrLHaNOVi1CHYBx82V4gwypbmcuaCiYwfNSFNvJa6DOpw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E87F71F000C7;
	Mon, 16 Nov 2026 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794821747;
	bh=OOcLabl5ezZ1UkzwIkQf5ogcQm5sNSJAbcdcVxctfRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WRLOv1uSdSbZFTwVFFWPGCGBL1HfY/7vFePsewkla6SuM3zFz4tnsEVuw/HqyMPtZ
	 lffVNhQMMwuLSqMkrWEdNeBY33AGA4AxhGufKsGaGbOPtrue/MuxJWUPTjkQKgTTiG
	 c7uZsExAiRzABWWUiqZEC1O8SkmmvsW5BjgIKsmEZYEg5mkZXcdC8/gKYVWrGlb1FF
	 2nYMYWuqetzPfUHvj5I+/HL/qFG6j70BKg3ae/FWTYYnK8SDIddWkARXN8TwkoGC+4
	 CNP4ApNggFWioGVbWIdIb2I3K58Sk7VA9MjI11LdJoOSs3EvCpQwjejxKOmTp7eYqN
	 M8fHItzqdv6DA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 745EA4A406;
	Mon, 16 Nov 2026 09:35:45 +0000 (UTC)
From: Matt Thompson via B4 Relay <devnull+matt.boondocker.io@kernel.org>
Date: Mon, 16 Nov 2026 02:35:45 -0700
Subject: [PATCH RFC v3 3/6] PCI: rockchip-host: Recover downstream
 configuration access
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-rfc-b4-v3-3-0bf052b68f2a@boondocker.io>
References: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
In-Reply-To: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794821744; l=4966;
 i=matt@boondocker.io; s=rk3399-rfc-20261113; h=from:subject:message-id;
 bh=t7P6yz1ZPt577IkVoaPXVx7wOD2MZniq6qTtpmWpQv0=;
 b=BnKbzR8+U/NVEHw0lN+x9zQOZ26TegMsjXzgJThVUDaAmKioqOd2YPUmM15W5G/Frro19sTKP
 voN91EOgr2vAkKaHiiQYK9AnhG7gGHpbrC04uvt8/d4MSuZlKp8NdqU
X-Developer-Key: i=matt@boondocker.io; a=ed25519;
 pk=WMnh3kwFFRkrqamL/FbDcdl1/9rBF2uT03VdvGGP40k=
X-Endpoint-Received: by B4 Relay for matt@boondocker.io/rk3399-rfc-20261113
 with auth_id=1517
X-Original-From: Matt Thompson <matt@boondocker.io>
Reply-To: matt@boondocker.io
Content-Transfer-Encoding: 7bit

From: Matt Thompson <matt@boondocker.io>

The link status can change between the readiness check and a downstream
PCI configuration read. A link that reports up can also fail to return
a usable completion.

On arm64, annotate downstream loads for all three access widths so a
synchronous external abort returns PCIBIOS_DEVICE_NOT_FOUND with all-ones
data. Keep little-endian conversion and I/O read ordering on success.

After retraining, the controller can continue to block configuration
traffic until its AXI link-down latch is cleared. Clear the latch before
downstream config reads and writes once the link readiness checks pass.

Link: https://lore.kernel.org/linux-pci/20261024-rockchip-pcie-resume-v1-2-58e54a5cf5f1@iav.lv/

Signed-off-by: Matt Thompson <matt@boondocker.io>
---
 drivers/pci/controller/pcie-rockchip-host.c | 62 +++++++++++++++++++++++++++--
 drivers/pci/controller/pcie-rockchip.h      |  1 +
 2 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 35105c1..64ac6f4 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -29,6 +29,10 @@
 #include "../pci.h"
 #include "pcie-rockchip.h"
 
+#ifdef CONFIG_ARM64
+#include <asm/asm-extable.h>
+#endif
+
 static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
@@ -149,16 +153,36 @@ static bool rockchip_pcie_downstream_ready(struct rockchip_pcie *rockchip)
 	       PCIE_LINK_TRAINING_DONE(rockchip_pcie_read(rockchip, PCIE_CORE_CTRL));
 }
 
+#ifdef CONFIG_ARM64
+/*
+ * An absent completion can raise a synchronous external abort even when
+ * the link status indicated up immediately before the config transaction.
+ */
+#define rockchip_pcie_cfg_load(insn, addr, val)			\
+	({								\
+		int err = 0;					\
+		asm volatile("1: " #insn " %w0, [%2]\n"			\
+			     "2:\n"					\
+			     _ASM_EXTABLE_MMIO_READ_ERR_ZERO(1b, 2b,	\
+							    %w1, %w0)	\
+			     : "=&r" (val), "+r" (err)			\
+			     : "r" (addr) : "memory");			\
+		err;							\
+	})
+#endif
+
 static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
 				       struct pci_bus *bus, u32 devfn,
 				       int where, int size, u32 *val)
 {
 	void __iomem *addr;
+#ifdef CONFIG_ARM64
+	u32 data;
+	int err;
+#endif
 
-	if (!rockchip_pcie_downstream_ready(rockchip)) {
-		*val = ~0U;
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
+	if (!rockchip_pcie_downstream_ready(rockchip))
+		goto absent;
 
 	addr = rockchip->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
 
@@ -174,6 +198,28 @@ static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
 		rockchip_pcie_cfg_configuration_accesses(rockchip,
 						AXI_WRAPPER_TYPE1_CFG);
 
+	/* Clear the AXI link-down latch before downstream config traffic. */
+	rockchip_pcie_write(rockchip, 0, PCIE_CORE_AXI_LINK_DOWN);
+
+#ifdef CONFIG_ARM64
+	if (size == 4) {
+		err = rockchip_pcie_cfg_load(ldr, addr, data);
+		*val = le32_to_cpu((__force __le32)data);
+	} else if (size == 2) {
+		err = rockchip_pcie_cfg_load(ldrh, addr, data);
+		*val = le16_to_cpu((__force __le16)data);
+	} else if (size == 1) {
+		err = rockchip_pcie_cfg_load(ldrb, addr, data);
+		*val = data;
+	} else {
+		*val = 0;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+	if (err)
+		goto absent;
+	/* Preserve the I/O read ordering of readl/readw/readb. */
+	__io_ar(*val);
+#else
 	if (size == 4) {
 		*val = readl(addr);
 	} else if (size == 2) {
@@ -184,7 +230,12 @@ static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
 		*val = 0;
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
+#endif
 	return PCIBIOS_SUCCESSFUL;
+
+absent:
+	*val = ~0U;
+	return PCIBIOS_DEVICE_NOT_FOUND;
 }
 
 static int rockchip_pcie_wr_other_conf(struct rockchip_pcie *rockchip,
@@ -208,6 +259,9 @@ static int rockchip_pcie_wr_other_conf(struct rockchip_pcie *rockchip,
 		rockchip_pcie_cfg_configuration_accesses(rockchip,
 						AXI_WRAPPER_TYPE1_CFG);
 
+	/* Clear the AXI link-down latch before downstream config traffic. */
+	rockchip_pcie_write(rockchip, 0, PCIE_CORE_AXI_LINK_DOWN);
+
 	if (size == 4)
 		writel(val, addr);
 	else if (size == 2)
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index b5da156..1cc3621 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -164,6 +164,7 @@
 #define MIN_AXI_ADDR_BITS_PASSED		8
 #define PCIE_ADDR_MASK			GENMASK_ULL(63, MIN_AXI_ADDR_BITS_PASSED)
 #define PCIE_CORE_AXI_CONF_BASE		0xc00000
+#define PCIE_CORE_AXI_LINK_DOWN		(PCIE_CORE_AXI_CONF_BASE + 0x824)
 #define PCIE_CORE_OB_REGION_ADDR0	(PCIE_CORE_AXI_CONF_BASE + 0x0)
 #define   PCIE_CORE_OB_REGION_ADDR0_NUM_BITS	0x3f
 #define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR	PCIE_ADDR_MASK

-- 
Git-155)


