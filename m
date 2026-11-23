Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459436;
	b=RQEBRSyXH7Rbawpq07cUiTrz7ukxQpcCj5UDdrO86DINDvUBo72tmXzToxeFTODCuIt8
	 4/h9wA2N8upbIoOOI7uCRj3ZuT1hCkhP8dNMjTGXuWh5IPoVGiS4yH+snONml3b6ll3s0
	 y9894i/+1xjS2ItPLkwqtTqtzdDwGOmvWSbNc6yI7JWjyDhvmHDS0n3Nf+ifLbWVFnZel
	 Pa+au2Z9orIqT0OX5JFpzSbF5IpiKvF4bnKwChcGbCSJFE+Opvvr5tfZB38jrwe1fMjs7
	 eW2r3c0eqvCVug710jvcMFYJ76b710unkssgFsP+p0C8BmmyhLEE8gY3kSTmE2QSmVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459436;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Zz6L92ZDSFMnlI2YQdsV7kK/kM96g1+mYDq69MPiFmU=;
	b=TOPkMS/HueZPmZkGggisC1AJ3H0KzCGiDJ+HZqe1epgFaFiqs2+ZBo+HLg6kx1pccwKr
	 dtPkEmchekX6ohVHOBDOB/xiPIAr9pSDIh7wpPoGMd4utF5oCbWxzhZawcnDJHjNMU3N6
	 g2ia0MVTat4hND6f0ZmJAfbqg6+5iRrEuf/0UB01N2+pXsElWEzM3D71eRGnEfKYNG/VU
	 dEfNgn/879b7eGW/pPH+LwiJ+MvanRlVrJDPx3p7gNE95TXnmRm6pmZFctp4xQJThGtXh
	 ngwVbjutwIfqBXuwy0dyauOacQ6I/a3loIC/ucOUwhuAqeITdhuQ2G4Sq2jFkxbyTrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsmhC1xI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F6A606A31F;
	Mon, 23 Nov 2026 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsmhC1xI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795459436;
	b=O9XgfmgaAqGaqgWPTMlhCEDYmWd/n6R4CMuvIg02txGqFIFpxPSEfMruf33T+5SPpVhU
	 Whrk671Vvb6nUaWVcpfyGNSSglaIQhdHEbm7DxjHoBNVnMGc9f/8FyB9QlQdqFXNfYxm8
	 mTGoTKV4/IVES4F+rp1nms6z1ylenL04aAvPvJ05zQ2d2QEjyanBug71+IQnkFMtsQPq5
	 dIPL00tDHcoFGXcmoN23+zJQm849vJkwQ0mM30IaLRw+UWQh7ODOSKbH0hFVAdAsO/TPO
	 Q/A3a9ZnwtfDN8GPu3IOJ2qjqmD+itX0vXcYJMnj7WVM8qKaNyWFpSkfyskCFfD/B7g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459436;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Zz6L92ZDSFMnlI2YQdsV7kK/kM96g1+mYDq69MPiFmU=;
	b=uQMbRZx84R8KMxaeHPGLcOoNEet2zC0ZuQQm6UVCWsKh23ahuyJQ1H7Bh9qd0NLHUr1J
	 GmNUVE5ziB+IMb93qRTxK6GqDttL4cEzisK++INBiuSrAZsjvlZqA+ukRYc3t4WhwUwdp
	 HOnuplag/TKs3//sW4pE8QRtNA55nxj9q8a/+2p51mV2e2OJeZ75q9unGe7sSTN6rg3Tj
	 wW0takPHL4kXLwfJh4frZtT1xBiDMi/OHlj11D9s1O6E5RfkzqugVC6GGw0a4tUMQJ5l4
	 lCuZ8YfFi3qSQirNQbSHbEWabDPkMx7dpLnnoqdBzK/VicSqWo2q6q2dz89LcbflU6w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5C7431F000F4;
	Mon, 23 Nov 2026 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459436;
	bh=Zz6L92ZDSFMnlI2YQdsV7kK/kM96g1+mYDq69MPiFmU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hsmhC1xIgxnY8A91iySaz0uK0wbbFQnGvuv3WvgzY5gijcSBPQwX2HEZx5tlc8U/p
	 mARtf9QvJmG707ASOrjm+npsHCAGjUyoDYnpb0He+C8ChcFVMgwi24CRCb0kjkbLZX
	 YsMbgz70D3QhTRnhFL9nCBZ2Qa28MQyd1plGeRKyFbO3sYqPGkb7IkEIpVXiMxXwMH
	 7feWKYzstj36rl38qGQSP0ZQGIogUdV4CkPqtEdtWvAte1hYs5o0MbyRxQhDjYSTEo
	 Dv/k9GZvUfxCbn92buZB9nUBmEAtJChiM712lDdMDiO/XFDSQZzeMnxhFYBaZmhyVa
	 HeVR+YxIkafzQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 621DA4C607;
	Mon, 23 Nov 2026 18:43:34 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 21:43:33 +0300
Subject: [PATCH 5/8] phy: Add CS7542 PCIe SerDes support
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
Message-Id: <20261123-b4-cs7542-pcie-v1-5-4cde5201d404@gmail.com>
References: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
In-Reply-To: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459409; l=9297;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=xbqhgVGjORFnQ5gPtfVS3sFJz4weZ5kVBK/LGnXuSak=;
 b=QNVgNlvbBW934POdhUTwDtWsSN8OBXryNPi7DhDOOM/dEJnB3LmSOCUmXp0FW0JjbcvIJPfR2
 c458jFRiOygB7kW6ewdsWtpFux7pV8liLuO2eTYcgVb0W05tzeH1dxn
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Provide per-lane generic PHYs using the vendor 24 MHz programming table
and revision-dependent value. Sequence power and reset through the shared
global regmap and fail on CMU lock timeout with balanced power cleanup.
Use the shared PHY status bank without overlapping PCIe wrapper resources.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 drivers/phy/Kconfig           |  11 ++
 drivers/phy/Makefile          |   2 +
 drivers/phy/phy-cs7542-pcie.c | 232 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 245 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 105fbe408..77cff94fe 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -204,4 +204,15 @@ source "drivers/phy/tegra/Kconfig"
 source "drivers/phy/ti/Kconfig"
 source "drivers/phy/xilinx/Kconfig"
 
+config PHY_CS7542_PCIE
+	tristate "Cortina Systems CS7542 PCIe SerDes"
+	depends on OF && HAS_IOMEM && COMMON_CLK
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Support the three CS7542 Snow Bush SerDes lanes in PCIe mode
+	  with a 24 MHz reference clock. Lane resets share the global syscon.
+	  SATA mode and other reference frequencies are not supported.
+	  The module is called phy-cs7542-pcie.
+
 endmenu
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index c6dd02003..54df29e74 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -55,3 +55,5 @@ obj-$(CONFIG_GENERIC_PHY)		+= allwinner/	\
 					   tegra/	\
 					   ti/		\
 					   xilinx/
+
+obj-$(CONFIG_PHY_CS7542_PCIE) += phy-cs7542-pcie.o
diff --git a/drivers/phy/phy-cs7542-pcie.c b/drivers/phy/phy-cs7542-pcie.c
new file mode 100644
index 000000000..d027baa93
--- /dev/null
+++ b/drivers/phy/phy-cs7542-pcie.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* CS7542 Snow Bush SerDes, PCIe mode with a 24 MHz reference clock. */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define GLOBAL_JTAG_ID	0x00
+#define GLOBAL_PHY_CONTROL 0x14
+#define PHY_REFCLK_MASK(p) (3U << ((p) * 2))
+#define PHY_REFCLK_24MHZ(p) (2U << ((p) * 2))
+#define PHY_PD(p)	BIT(8 + (p))
+#define PHY_CMU_RESETN(p) BIT(16 + (p) * 4)
+#define PHY_LN0_RESETN(p) BIT(17 + (p) * 4)
+#define PHY_POR_N(p)	BIT(19 + (p) * 4)
+#define PHY_CMU_OK	BIT(18)
+#define PHY_STATUS_STRIDE 0x80
+#define SNOW_COM_REG0	0x00
+#define SNOW_REG0_CFG	0x00090006
+#define SNOW_REG0_AHB_RESETN BIT(0)
+#define SNOW_REV_REG	96
+#define SNOW_REV_REG_A0	0x5e082e00
+#define SNOW_REV_REG_A1	0x5e080600
+#define SNOW_COM_LANE_REG0 0xc8
+#define SNOW_LANE_REG0_CFG 0x400290c0
+#define SNOW_LANE_REG0_MASTER_RESETN BIT(1)
+#define CS7542_PORTS	3
+
+struct cs7542_serdes;
+struct cs7542_lane {
+	struct cs7542_serdes *serdes;
+	void __iomem *base;
+	struct phy *phy;
+	unsigned int id;
+};
+
+struct cs7542_serdes {
+	struct device *dev;
+	struct regmap *global;
+	void __iomem *status;
+	struct clk *ref;
+	struct cs7542_lane lanes[CS7542_PORTS];
+	u32 revision_value;
+};
+
+struct snow_reg {
+	u16 off;
+	u32 val;
+};
+
+static const struct snow_reg snow_phy_24mhz[] = {
+	{ 0,   SNOW_REG0_CFG }, { 4,   0x000e0960 }, { 32,  0x68a00000 },
+	{ 44,  0x50040000 }, { 48,  0x40250270 }, { 52,  0x00004001 },
+	{ 100, 0xf0914200 }, { 104, 0x4c0c9048 }, { 108, 0x00000373 },
+	{ 124, 0x04841000 }, { 128, 0x000000e0 }, { 132, 0x04000023 },
+	{ 136, 0x68001038 }, { 140, 0x0d181ea2 }, { 144, 0x0000000c },
+	{ 196, 0x0f600000 }, { 200, SNOW_LANE_REG0_CFG }, { 204, 0x0000003c },
+	{ 208, 0xc68b8300 }, { 212, 0x98280301 }, { 216, 0xe1782819 },
+	{ 220, 0x00f410f0 }, { 232, 0xa0a0a000 }, { 236, 0xa0a0a0a0 },
+	{ 240, 0x9fc00068 }, { 244, 0x00000001 }, { 248, 0x00000000 },
+	{ 252, 0xd07e4130 }, { 256, 0x935285cc }, { 260, 0xb0dd49e0 },
+	{ 264, 0x0000020b }, { 300, 0xd8000000 }, { 304, 0x0001ff1a },
+	{ 308, 0xf0000000 }, { 312, 0xffffffff }, { 316, 0x3fc3c21c },
+	{ 320, 0x0000000a }, { 324, 0x00f80000 },
+};
+
+static int cs7542_phy_power_off(struct phy *phy)
+{
+	struct cs7542_lane *lane = phy_get_drvdata(phy);
+	unsigned int p = lane->id;
+	u32 mask = PHY_PD(p) | PHY_CMU_RESETN(p) | PHY_LN0_RESETN(p) | PHY_POR_N(p);
+	int ret;
+
+	ret = regmap_update_bits(lane->serdes->global, GLOBAL_PHY_CONTROL, mask, PHY_PD(p));
+	clk_disable_unprepare(lane->serdes->ref);
+	return ret;
+}
+
+static int cs7542_phy_power_on(struct phy *phy)
+{
+	struct cs7542_lane *lane = phy_get_drvdata(phy);
+	struct cs7542_serdes *sd = lane->serdes;
+	unsigned int p = lane->id;
+	u32 mask, value;
+	int ret, i;
+
+	ret = clk_prepare_enable(sd->ref);
+	if (ret)
+		return ret;
+	mask = PHY_PD(p) | PHY_CMU_RESETN(p) | PHY_LN0_RESETN(p) | PHY_POR_N(p) |
+	       PHY_REFCLK_MASK(p);
+	ret = regmap_update_bits(sd->global, GLOBAL_PHY_CONTROL, mask,
+				 PHY_PD(p) | PHY_REFCLK_24MHZ(p));
+	if (ret)
+		goto power_off;
+	msleep(100);
+	ret = regmap_update_bits(sd->global, GLOBAL_PHY_CONTROL, PHY_PD(p) | PHY_POR_N(p),
+				 PHY_POR_N(p));
+	if (ret)
+		goto power_off;
+	usleep_range(10, 20);
+	for (i = 0; i < ARRAY_SIZE(snow_phy_24mhz); i++) {
+		if (snow_phy_24mhz[i].off == SNOW_REV_REG + 4)
+			writel(sd->revision_value, lane->base + SNOW_REV_REG);
+		writel(snow_phy_24mhz[i].val, lane->base + snow_phy_24mhz[i].off);
+	}
+	writel(SNOW_REG0_CFG | SNOW_REG0_AHB_RESETN, lane->base + SNOW_COM_REG0);
+	ret = regmap_update_bits(sd->global, GLOBAL_PHY_CONTROL, PHY_CMU_RESETN(p),
+				 PHY_CMU_RESETN(p));
+	if (ret)
+		goto power_off;
+	ret = readl_poll_timeout(sd->status + p * PHY_STATUS_STRIDE, value,
+				 value & PHY_CMU_OK, 100, 100000);
+	if (ret) {
+		dev_err(sd->dev, "lane %u CMU did not lock\n", p);
+		goto power_off;
+	}
+	writel(SNOW_LANE_REG0_CFG | SNOW_LANE_REG0_MASTER_RESETN,
+	       lane->base + SNOW_COM_LANE_REG0);
+	ret = regmap_update_bits(sd->global, GLOBAL_PHY_CONTROL, PHY_LN0_RESETN(p),
+				 PHY_LN0_RESETN(p));
+	if (ret)
+		goto power_off;
+	msleep(100);
+	return 0;
+
+power_off:
+	cs7542_phy_power_off(phy);
+	return ret;
+}
+
+static int cs7542_phy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	return mode == PHY_MODE_PCIE && !submode ? 0 : -EINVAL;
+}
+
+static const struct phy_ops cs7542_phy_ops = {
+	.power_on = cs7542_phy_power_on,
+	.power_off = cs7542_phy_power_off,
+	.set_mode = cs7542_phy_set_mode,
+	.owner = THIS_MODULE,
+};
+
+static struct phy *cs7542_phy_xlate(struct device *dev, const struct of_phandle_args *args)
+{
+	struct cs7542_serdes *sd = dev_get_drvdata(dev);
+
+	if (args->args_count != 1 || args->args[0] >= CS7542_PORTS)
+		return ERR_PTR(-EINVAL);
+	return sd->lanes[args->args[0]].phy;
+}
+
+static int cs7542_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct phy_provider *provider;
+	struct cs7542_serdes *sd;
+	unsigned int id;
+	int ret, i;
+
+	sd = devm_kzalloc(dev, sizeof(*sd), GFP_KERNEL);
+	if (!sd)
+		return -ENOMEM;
+	sd->dev = dev;
+	sd->global = syscon_regmap_lookup_by_phandle(dev->of_node, "cortina,global-syscon");
+	if (IS_ERR(sd->global))
+		return dev_err_probe(dev, PTR_ERR(sd->global), "global register map\n");
+	sd->ref = devm_clk_get(dev, NULL);
+	if (IS_ERR(sd->ref))
+		return dev_err_probe(dev, PTR_ERR(sd->ref), "reference clock\n");
+	if (clk_get_rate(sd->ref) != 24000000)
+		return dev_err_probe(dev, -EINVAL, "only 24 MHz reference supported\n");
+	ret = regmap_read(sd->global, GLOBAL_JTAG_ID, &id);
+	if (ret)
+		return ret;
+	switch (FIELD_GET(GENMASK(15, 12), id)) {
+	case 0:
+	case 1:
+		sd->revision_value = SNOW_REV_REG_A0;
+		break;
+	case 8:
+	case 9:
+		sd->revision_value = SNOW_REV_REG_A1;
+		break;
+	default:
+		return dev_err_probe(dev, -ENODEV, "unsupported silicon revision %#x\n", id);
+	}
+	sd->status = devm_platform_ioremap_resource(pdev, CS7542_PORTS);
+	if (IS_ERR(sd->status))
+		return PTR_ERR(sd->status);
+	for (i = 0; i < CS7542_PORTS; i++) {
+		struct cs7542_lane *lane = &sd->lanes[i];
+
+		lane->id = i;
+		lane->serdes = sd;
+		lane->base = devm_platform_ioremap_resource(pdev, i);
+		if (IS_ERR(lane->base))
+			return PTR_ERR(lane->base);
+		lane->phy = devm_phy_create(dev, NULL, &cs7542_phy_ops);
+		if (IS_ERR(lane->phy))
+			return PTR_ERR(lane->phy);
+		phy_set_drvdata(lane->phy, lane);
+	}
+	platform_set_drvdata(pdev, sd);
+	provider = devm_of_phy_provider_register(dev, cs7542_phy_xlate);
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static const struct of_device_id cs7542_phy_match[] = {
+	{ .compatible = "cortina,cs7542-pcie-phy" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs7542_phy_match);
+
+static struct platform_driver cs7542_phy_driver = {
+	.probe = cs7542_phy_probe,
+	.driver = {
+		.name = "cs7542-pcie-phy",
+		.of_match_table = cs7542_phy_match,
+	},
+};
+module_platform_driver(cs7542_phy_driver);
+
+MODULE_DESCRIPTION("Cortina Systems CS7542 PCIe SerDes");
+MODULE_LICENSE("GPL");

-- 
2.53.0


