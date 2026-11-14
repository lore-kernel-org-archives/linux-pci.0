Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794616132;
	b=Oaldgkg7OxFtobmL/P/nVwBnI+x+yfgSg7vKSasBDlSnt6KBLtrIpvqIiaQyjxXmGcne
	 P1V6pja9I4mukNt6XBIB7uIdu6dCnEETI5LQXLomXfMlmH/T66fy7szCdnTHte2jxh/QN
	 d4IF31xNiNv4bs20w8sAtwIvdkuXwsQn0GF27cu7/6WUvcXm42Y+qPbR4LALcHnQVzQAd
	 vXkDSRtBsVrdzrD7qsiU+X137FeSZMdZCfldLAGSmzbqY8gBZsEEkKyvbI3RNlhJOHr1S
	 OYObNqRTcC4lr5ZRubgVN56dgczsN2uOkWeEwHt4iqywlsYdFOoI5oIR82BMSXZV72g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616132;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=B2KcrWYKTRE4i/vFMrfbXozpFQ/JG2UMZcSJpNU6Qwo=;
	b=RXdI42x1bIXJOeN93oK4hLUVT0+TUM0FTDSuyB7UZ59c1ZsZKO6zzsz0QZx9IzxzTCCN
	 hKB9pPMxWbyQA31YbIrJJw629Nqt1MS3ESLjNcycAzzeK+pdTEzbVkib4ZHM8lAXzyP88
	 qZwpPTdc8wQWDe2X4e2v+fLOImC6W0F5mZDn8ONLkBtLz9Uu3P8a2SulEotmVtd5eUJjz
	 gdV75TIOva5V0/TFZAEzvNRvnbp4kkCvXZqr5wVie/geuJFddtvKxv/eKhlLmbP+PbQU9
	 10v2ROKQ0GgO9XqUh64ZolXqX4n57BVbn3zb2usQw30DZq43tEQd/peHmTIx0Lij7Sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TUuRpryj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3741606A337;
	Sat, 14 Nov 2026 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TUuRpryj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794616131;
	b=pIUK9oU1cuxYZRVCkYOuzavC82kz1+a+pkDrdxJaIGF+pAGK54zlXRVetg7WoTQTma6x
	 e8Ibxk09UEQyB44YLGEK8BQZ1LWfvaQC8qFDWjJylsHkrKFgvbz+nVXT19dFoRoY1xxjc
	 nb0KkxjOUh+NEHYnrpmnG/lYLWvVvrcgbqxYtymwaMNDsg/dAYn42gr/bv5l+WdgGftYY
	 kNtbe1Y9FbS1KYu2pdnqQ+JozIhnZLM/oWNT5H8yDN+gl+XklBZ32UPWb0DyhHC3z8LfC
	 YFEJ8QYbWEyFKcbefqubaFnu7Tyh4spe0w3zaUWYTz1XQF7LCLzLrF+7PqEo0MBJzMg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794616131;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=B2KcrWYKTRE4i/vFMrfbXozpFQ/JG2UMZcSJpNU6Qwo=;
	b=WyU6OqXnceGMAS0tF6eEUB5PwuESNGBoeP+eHICq+WXq3xZR2OsFsL1MAqdbMjUNwPkV
	 G6aC8x4yqB3fbZmw3GDZbBKu/9FIPc8oH3itAAYCRcGgR009vMTh1rmRr9wK3uOZkLazH
	 QjbbiNfdSRcu428esgH0LDb6ahqqkD5CpTst+ANcHd+FDpOjm6hB/PBaBN+AAm0AtnZmb
	 Mm8thgcOMekx6ykjGXDmZpt+lXPz+UjS6uNHFImtWzSsTQz+8qzyMRyIUuu/zMK2aaePF
	 E8rwrJCsd64td0ViaPfPst4qtgO6W/RlhZmeegU/yYUcOi1434rA9R6E2xaZUhbO7KA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E79A01F000C7;
	Sat, 14 Nov 2026 00:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616131;
	bh=B2KcrWYKTRE4i/vFMrfbXozpFQ/JG2UMZcSJpNU6Qwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TUuRpryjwXZVyxMBOe8SOsF+uFCN0nCTQEu5XCMMxnpRrtEMMdsw7am2aWwQxDWLJ
	 GojpVpAARSApIBNvaL6n8ttkT2ydRRoAYg+SURQzJEj69sgpIwt+50AAkqyWgLrKaH
	 Fz3b+KR645GvqIhXpu22WXhGdJSjl7EQ/2gUcxuBdzDtuMkT2PY4vhbRMCb5EXJLim
	 Lz8RhcfolXni7tCGWEPLwnBLnPtSA6Q6h0GQnEX5+Yn/ZGVBHKVqVRoS8s/KJBBEC2
	 pFBKmZm2qZ8Z7OkL6GtFZeVk0tjTSvjQR0eDkj9b4mhOMhdBhv3oZjjooQU7oKSKvL
	 vbCadgTr72CPA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6EA2E49BE7;
	Sat, 14 Nov 2026 00:28:50 +0000 (UTC)
From: Matt Thompson via B4 Relay <devnull+matt.boondocker.io@kernel.org>
Date: Fri, 13 Nov 2026 17:28:51 -0700
Subject: [PATCH RFC 3/3] PCI: rockchip-host: Recover downstream
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
Message-Id: <20261113-rfc-b4-v1-3-b91dcb502250@boondocker.io>
References: <20261113-rfc-b4-v1-0-b91dcb502250@boondocker.io>
In-Reply-To: <20261113-rfc-b4-v1-0-b91dcb502250@boondocker.io>
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794616129; l=5010;
 i=matt@boondocker.io; s=rk3399-rfc-20261113; h=from:subject:message-id;
 bh=wf8dMR8QRs/deeBcDxOpgy/o2/ItJSjrMfmmN+jiJf4=;
 b=YWXdzf81bKPE8glX2Xr4f/8+pdN5eFimU1YqRjUDLikrUAaAjQN9/8SimiKGpNYl33QZ+WXq5
 XvFWHdFWPOfBpkvBPBPH2OYS7cix7Em95CMHKNSQMhGFrKSDIiBoWSq
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
 drivers/pci/controller/pcie-rockchip-host.c | 63 +++++++++++++++++++++++++++--
 drivers/pci/controller/pcie-rockchip.h      |  1 +
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 35105c1..64c7da5 100644
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
@@ -149,16 +153,37 @@ static bool rockchip_pcie_downstream_ready(struct rockchip_pcie *rockchip)
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
+		asm volatile(__DEFINE_ASM_GPR_NUMS			\
+			     "1: " #insn " %w0, [%2]\n"			\
+			     "2:\n"					\
+			     _ASM_EXTABLE_MMIO_READ_ERR_ZERO("1b", "2b",	\
+							    "%w1", "%w0")	\
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
 
@@ -174,6 +199,28 @@ static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
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
@@ -184,7 +231,12 @@ static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
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
@@ -208,6 +260,9 @@ static int rockchip_pcie_wr_other_conf(struct rockchip_pcie *rockchip,
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


