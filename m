Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795599329;
	b=y81xYnDW+hUX3mUrKT0iBoLd+UtqiczQHek34oFrmPmXxxseQoV9L//ezYKXaWjoPrDY
	 SpUJC3tbxb85vllSsDg1/HCDuaavEIUqpwSkb5P4HiX+eb1NIkKeKxpx8FeSSRSc+LfNX
	 ElnARTJVN6k9jWa08JqRavwzuQ57ZPproE+L7cx+gDBrWVoh7EQqi+Gb3RvDwRBxy9m5q
	 xPdDNEH04opkDVt++6Z7uzxZDTDxzmovBi68Nd5OLFFSQo5lqgHLpi9UZ8NSkfX/llQDt
	 xBsNCzpbT9yJrQhPkwkREYNFr+Hbep53t6Vb2ek0sUclFyM/CdUnMywmhk7VZ76rPdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599329;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0yUkBGKmBoC6GhNX7wcbNe62PEHvACOAwQiXFUd2RPI=;
	b=vfzetvyxSjIGPqc6RPUvKeV0UVpUpkmfuc30eQ7pdr5/1tojrgMJ+JMrWa5dqA8jYB6j
	 IlBpcyTW4iYZwXoOaXxeCkDthkx1heIA6k71NcAkqyCJjdTOVRn1lLYqIPs6DmwpRSjS2
	 TIKVv1+h13NmaO60ibAMiwKS0FjYAfh2ULwnA/OrGBS8lVlFy1jCokZpqmVfKBch+BGnX
	 ZHt9iaO7wL8YzlKX/1ZIX1fcxYasII5rkM6pxbK2r8SUC7H/Ud93BoLdoWKdlc5OfPaUz
	 3aXzX3tK6y2QhM9k07WbThfvBXXKIfW9wFg6Rh9BwDB8jI4q9bXcQ366C4u3Ux7MOgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zex+jN/+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF1606A686;
	Wed, 25 Nov 2026 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zex+jN/+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795599328;
	b=ZzB6lleHf7a0HXp5DpV3ipNNvEO8o0onl47+OMH+SJODVRo79gGnqn6Lhoq+Nb0CmncP
	 52fZOomUL8667LoeH0ZgCw5iQAMxNZy3qFwsp/Gt3bj8A5YmK735DUYEOqckreV/Knk4i
	 D1uZMlAGtblSRVUr3FNUzLvCoKzykdpPNGKj5sG95KoslKuOrajx9AOWIazL0cXN39Ck2
	 rOSoJZvjqKZoiwaGRjbkoEuJ6EJ/KciZfV5eB8EalCOVRiuef5HD9lPQhoInELNXIrsgM
	 N/2zrJKFuJjzhwzzIzx6rDCARk+IzEGPYxwDpQhgG10YeoIx2OrVC+dlhD1QEorURFA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795599328;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0yUkBGKmBoC6GhNX7wcbNe62PEHvACOAwQiXFUd2RPI=;
	b=3PNh2NfTImGH73IFpmemJDBSXqTphzfqW9SgZszDqRUdSr5IewWB0Zb9W0oLxlv/MRWL
	 y58PK3Jx0rKrxmT41vq6+G8V09O5+4UWDvFBr5H8EzzaLpBb3F+R26UXcVzdy6O7+exLK
	 8Tq4zkVIfuGXOuD1euePfGh4oPr3W4Ix72m3TruOV9ng5lNwluUFfaZjluQ9dzLRaBus5
	 a7A3BOpT41Jjb9miO3VpH5oj07hYhK33X9D4NN05Px56FvGWwNnFGEhnatwy+O1biMV/V
	 nBZcuCFLeW+uyiR7XIb6g2X2hNnklRB3pXqKFWum1zqtLmuy7LHcYfSOWteKUsV3L1Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6E4BE1F000F0;
	Wed, 25 Nov 2026 09:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795599328;
	bh=0yUkBGKmBoC6GhNX7wcbNe62PEHvACOAwQiXFUd2RPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Zex+jN/+37HMvNaBECWdUKjnUlubol4xzfXc7I3G3u1Iy2zSoZMMpUSnUMXjVBWjV
	 2qp8mNfop9TM/bn80ojjR8p2wZSJIeFKLCQGxhYJWznnRK1JIop4EtRFit1LIJrEZ6
	 mxhGIN624A+pfx6R57Bu+FaYzMAI7VnaI0tc4BigbCSLC/Rtx4fd3ajO5Tt5YJP6J2
	 JJYWjasA03W/b4mKRLIwz3P9HNyT2Oc4b8PV9dGEfZx548JQOhQ4hygvBi7REXr1jt
	 wg2FJ9z0QwQUhLHvCf9qDH12IullaBfoEIBhKTeoMqFmXHlQOaeHAiDl++ydAQkj1A
	 6TrzeN7A7SMJw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2FD814CE2A;
	Wed, 25 Nov 2026 09:34:38 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Wed, 25 Nov 2026 10:33:57 +0100
Subject: [PATCH RFC v4 15/15] arm64: dts: s32g: Add S32G3-RDB3 SerDes
 routing variants
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
Message-Id: <20261125-s32g_serdes-v4-15-3bfe0589be8d@oss.nxp.com>
References: <20261125-s32g_serdes-v4-0-3bfe0589be8d@oss.nxp.com>
In-Reply-To: <20261125-s32g_serdes-v4-0-3bfe0589be8d@oss.nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bogdan Hamciuc <bogdan.hamciuc@nxp.com>, 
 Ionut Vicovan <ionut.vicovan@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795599274; l=5200;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=ey+259q8NVdz+nmA6w91HlJzOAXDIhQhflExVQ+Y8o0=;
 b=O0br6DpDGuG00R9/Celm9Vz7oEv9fLtAFCfkd5v/N6CHAZKEdn/Imv4bxMILlCtnoOJSiljUK
 aZxBB69RSipClJeod4fr8tGUD+wbk0T49UrIEPVkvvKgfIFgP0hgD4B
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
Content-Transfer-Encoding: 7bit

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

The S32G3-VNP-RDB3 wires GMAC0 to an on-board KSZ9031 RGMII PHY by
default. Add two board variants which route GMAC0 over SerDes_0 for
SGMII instead:

  - mode 1: PCIe x1 on lane 0, GMAC0 SGMII (XPCS0) on lane 1;
  - mode 3: GMAC0 SGMII (XPCS0) on lane 0. Lane 1 (XPCS1, PFE_MAC2)
    has no consumer, as there is no PFE driver, and is not described.

The variants are full .dts files that include s32g399a-rdb3.dts, not
overlays: they drop the phy-handle of GMAC0, and /delete-property/ has
no effect in an overlay.

The routing is described by the consumers: the PCIe root ports
reference lane 0 with PHY_TYPE_PCIE, GMAC0 references its lane with
PHY_TYPE_SGMII and XPCS0, and takes the PCS from the SerDes through
pcs-handle.

The mode 1 variant also enables both PCIe root complexes: PCIe_0
reaches the M.2 slots when board switch SW17-2 is ON, PCIe_1 the PCIe
card slot. SerDes_1 carries only PCIe_1 on lane 0, as there is no PFE
driver to reference lane 1, and runs the first matching mode, PCIe x2,
with an x1 link.

The SGMII lane goes to the on-board SJA1110 switch, which the variants
do not describe, so the MAC side is a fixed 1G link.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile             |  2 +
 .../dts/freescale/s32g399a-rdb3-serdes-mode1.dts   | 65 ++++++++++++++++++++++
 .../dts/freescale/s32g399a-rdb3-serdes-mode3.dts   | 40 +++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a80cccf34eb5..f92670254c6a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -1047,5 +1047,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-phygate-tauri-l-rs232-rs485.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g399a-rdb3.dtb
+dtb-$(CONFIG_ARCH_S32) += s32g399a-rdb3-serdes-mode1.dtb
+dtb-$(CONFIG_ARCH_S32) += s32g399a-rdb3-serdes-mode3.dtb
 dtb-$(CONFIG_ARCH_S32) += s32n79-rdb.dtb
 dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3-serdes-mode1.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3-serdes-mode1.dts
new file mode 100644
index 000000000000..c881376db27a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3-serdes-mode1.dts
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2021-2026 NXP
+ *
+ * NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3),
+ * SerDes_0 Mode 1: PCIe x1 (lane 0) + 1G SGMII via GMAC0 (XPCS0, lane 1).
+ */
+
+#include <dt-bindings/phy/phy.h>
+#include "s32g399a-rdb3.dts"
+
+/ {
+	model = "NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3), SerDes_0 Mode 1";
+};
+
+&serdes0 {
+	status = "okay";
+};
+
+/*
+ * SerDes_1: PCIe_1 on lane 0. Lane 1 (PFE) has no consumer, so the first
+ * matching mode, PCIe x2, is used.
+ */
+&serdes1 {
+	status = "okay";
+};
+
+/*
+ * PCIe_0 reaches the M.2 slots (M-key or E-key) when board switch SW17-2 is
+ * ON, PCIe_1 the PCIe card slot.
+ */
+&pcie0 {
+	status = "okay";
+};
+
+&pcie0_rp {
+	num-lanes = <1>;
+	phys = <&serdes0 0 PHY_TYPE_PCIE 0 0>;
+};
+
+&pcie1 {
+	status = "okay";
+};
+
+&pcie1_rp {
+	num-lanes = <1>;
+	phys = <&serdes1 0 PHY_TYPE_PCIE 0 0>;
+};
+
+&gmac0 {
+	/delete-property/ phy-handle;
+	clocks = <&clks 24>, <&clks 17>, <&clks 16>, <&clks 15>;
+	clock-names = "stmmaceth", "tx", "rx", "ptp_ref";
+	phy-mode = "sgmii";
+	phys = <&serdes0 1 PHY_TYPE_SGMII 0 1000>;
+	pcs-handle = <&serdes0>;
+	status = "okay";
+
+	/* The lane goes to the on-board SJA1110 switch, not described here */
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+		pause;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3-serdes-mode3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3-serdes-mode3.dts
new file mode 100644
index 000000000000..8b90d5f14d2a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3-serdes-mode3.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2021-2026 NXP
+ *
+ * NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3),
+ * SerDes_0 Mode 3: 1G SGMII via GMAC0 (XPCS0, lane 0). Lane 1 (XPCS1,
+ * PFE_MAC2) is not described.
+ */
+
+#include <dt-bindings/phy/phy.h>
+#include "s32g399a-rdb3.dts"
+
+/ {
+	model = "NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3), SerDes_0 Mode 3";
+};
+
+/*
+ * SerDes_0 mode 3: GMAC0 via XPCS0 on lane 0. Lane 1, PFE_MAC2 via XPCS1,
+ * has no consumer, as there is no PFE driver.
+ */
+&serdes0 {
+	status = "okay";
+};
+
+&gmac0 {
+	/delete-property/ phy-handle;
+	clocks = <&clks 24>, <&clks 17>, <&clks 16>, <&clks 15>;
+	clock-names = "stmmaceth", "tx", "rx", "ptp_ref";
+	phy-mode = "sgmii";
+	phys = <&serdes0 0 PHY_TYPE_SGMII 0 1000>;
+	pcs-handle = <&serdes0>;
+	status = "okay";
+
+	/* The lane goes to the on-board SJA1110 switch, not described here */
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+		pause;
+	};
+};

-- 
2.55.0


