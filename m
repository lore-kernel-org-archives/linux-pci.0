Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795465961;
	b=ySue6Yjf8HE+tAPI44ZqDCDXGjVyQ8yYOgS7oEFckrjjvVF4+t3d5ArbGdca67eULg3t
	 5gwY6YNwrQhhPTKNAQDJ1sqz/ESLKkpNyaoLowwAxipctFr4blF40QdUkSPxxL5x4wNiN
	 NhBryVaf2q6s/VoXuSqpSAQu2eqgGNX2XSt5dgdN2EnPaFAn4lpCovwAGzIQjqA2IYqrV
	 a7uIBshsUysazYMycBSlbj2DJdmMX54QYoO3KAi1nrFfgcS2+5HKbnHu3fNVZwQyIMJVO
	 bBDeypy0K1LRqWurtpMuuZI9Ks2Y+MJR9w8D2933ZBBNYBZHyPd9H/QWtX8G7haC4tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465961;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zvxd9dARkZhllOfsvOtfG9Epi2HmWipiIYRGTUsDCJw=;
	b=J/8zpKImX/pYjjhdH89YdfguHhV9dydqEBn3wl2z1Cqy4uTCgRVgtJwvi10jhMh1+0gI
	 zas07NG1RoNiBgqlZ5hBoehPZi+jnJrU4gjjcJ90tORTlXXYjLDnqj1YkfV4hlIaTPVOX
	 wSUftaaDbNBH/775GQbg9Q3Nr84UtXgTxVP+EuQaLVDxeuHMMGxZx5ksxZ3Y+KyUx3PTz
	 3jdmCleQAw0lxf13oE9xFzXfSfp8FmJghzpCcb+Dc9jd6Zv+kuTYcI5r/E3U5QISYxO1y
	 2PP61HqVDM7fQZGpidUfPwVG7RCDhAUW213EgIwCD3bTdNj5YQQMbNYFqlbVSXtc8gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TQnk4T/g";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38A606A690;
	Mon, 23 Nov 2026 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQnk4T/g
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795465960;
	b=q+/5PvYnFQe60dArcwUXOraV8MnXCMlNdaUTYGSxwQTs/mF/rRIQHq/mrwB+MOjPyWLv
	 jtZr/pFnSPtPZUdODpUtXS65hA01syzYbI209HyeinrxjPBsD0hdOLsauBD9gQtPteVUW
	 uc2J51TYJ2riYIJV3NMcdClpmzy/ueTNeSwKJdQDq/zBRI6/d+uF3g9Xv8JASPPPbs3le
	 QJLvCGITHl+DBOBf18mdI/uVvuE1Xcu8FFJ5fZZCctVdglmi3o3BlGjOIhmEmFQLeBPYS
	 iqjmDjHvRwHrNVzOrXh0CSEFG8y1cTgOSrsXGnSQA0R+Wg9ckrx7LdT85bHS86CSKKw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795465960;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zvxd9dARkZhllOfsvOtfG9Epi2HmWipiIYRGTUsDCJw=;
	b=MSVqzgCOfysHAy6HbLWS3xkZ+PjEq+pAQV4dA7N1ba4MFNmMKL/8wf+zeYRjruAm5k+A
	 49VVqcL1aZSVMx748PRhtNemfB8qLbgcrEXO9UNrZAJzYB735aYYJ8YmDKcFFOvmz3Ld4
	 EK27wQ8khaXeuDnD3HHxqVkRGDOPhZSpS0x4y0jJ/s9S9xw06hOj68pwcyok9aWzPXfi+
	 P3Y5bO2ZyjVW26aaRHA1Xc9ud/zaTVpky1aLCad9+YUpuRRIbiO7RJLLJyH7sEx2QE6Ts
	 eCeAkUy1R74ljSkJ9RS/txzdjn1nGF2cv4ZxfJDK8MEU6D1PwSpgFlfclkMCXWK1Wow==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 165561F000EF;
	Mon, 23 Nov 2026 20:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795465960;
	bh=zvxd9dARkZhllOfsvOtfG9Epi2HmWipiIYRGTUsDCJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TQnk4T/g2M/XspQOYlU6DS3sPuCQd8AjTew4bdpEjy+fPgb8xBTDTzjimHIwaPbhL
	 xBd3mlI0v9LLnCtWh8WvfYA7IVfGGGm4OqBZEIgo3VCNOIruhCJGNhRpRFkruKh3tP
	 /Uw4xBJTnzLCw4nUf7lLBH42pbOdkN9sxRBARoOMjnV219k9RPNz2BP1CK0+0DyOun
	 KwAWzlABcK5KGSGirlEy3/YNghQ6ruoBCwNFZecOEhtOXpGYMTr6P2i6Unzkx0cX0Y
	 VH+U73T83SqphRSGyzP26OcRLualACzOba/6qUzr8iHKIkxZZzmExhm9zcyN2Raa1f
	 rF1DPkrNC8mWg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 949AC4C706;
	Mon, 23 Nov 2026 20:32:17 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 23:32:17 +0300
Subject: [PATCH v2 3/8] clk: cs7542: Add PCIe gates and resets to the
 global provider
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
Message-Id: <20261123-b4-cs7542-pcie-v2-3-f589a9cd0bef@gmail.com>
References: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
In-Reply-To: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795465935; l=8596;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=wxPmwU/hDwsNVP5PJfG+P4N3ss/7sNIINtDOJjhHa0o=;
 b=ZJTbQ/sULq7QjHr8zIbPK9QgGbx1VxtG9MD1hMnVjq5cTMZvYO9zSuS1nDiBuKu2UAQZuNRgD
 ZrzFvW22cJlA1L8EEBHEvjzyVtQg/5BPOYPWNFcaB2cTTIlt0u9xolY
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Register the three PCIe gate clocks and controller resets from the global
syscon node. Preserve the early strap clocks used by the ARM timers and
the shared regmap updates that protect unrelated reset and gate bits.

The driver is built in because APB is needed during timer discovery. The
PCIe host and PHY consumers remain independently modular. Unwind all
registered clocks and the reset provider on initialization failures.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 drivers/clk/Kconfig      |   6 +-
 drivers/clk/clk-cs7542.c | 183 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 166 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 47b5265fe..4dcc60979 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -59,13 +59,15 @@ config LMK04832
 	  Low-Noise JESD204B Compliant Clock Jitter Cleaner With Dual Loop PLLs
 
 config COMMON_CLK_CS7542
-	bool "Cortina Systems CS7542 strap-selected clocks"
+	bool "Cortina Systems CS7542 global clocks and resets"
 	depends on OF && HAS_IOMEM
 	select MFD_SYSCON
+	select RESET_CONTROLLER
 	help
 	  Read the boot straps of the CS7542 global control block to provide
 	  its APB, CPU and AXI clocks. This driver does not change PLLs or
-	  dividers. It is built in because the APB clock is needed by timers.
+	  dividers. It also provides the three PCIe clock gates and resets.
+	  It is built in because the APB clock is needed by timers.
 
 config COMMON_CLK_APPLE_NCO
 	tristate "Clock driver for Apple SoC NCOs"
diff --git a/drivers/clk/clk-cs7542.c b/drivers/clk/clk-cs7542.c
index 4e6c1e98a..e4bb1bb70 100644
--- a/drivers/clk/clk-cs7542.c
+++ b/drivers/clk/clk-cs7542.c
@@ -1,24 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Cortina Systems CS7542 strap-selected clocks */
+/* Cortina Systems CS7542 global clocks and PCIe resets. */
 
 #include <linux/bitfield.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/printk.h>
 #include <linux/regmap.h>
+#include <linux/reset-controller.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/clock/cortina,cs7542-clock.h>
 
 #define CS7542_GLOBAL_STRAP	0x0c
 #define CS7542_STRAP_SPEED	GENMASK(3, 1)
-#define CS7542_NUM_CLKS		3
+#define CS7542_NUM_FIXED_CLKS	3
+#define CS7542_NUM_CLKS		6
 
 /* Rates from the GPL vendor kernel's get_platform_clk(). */
-static const unsigned long cs7542_rates[][CS7542_NUM_CLKS] = {
+static const unsigned long cs7542_rates[][CS7542_NUM_FIXED_CLKS] = {
 	/* APB, CPU, AXI */
 	{ 100000000, 400000000, 133333333 },
 	{ 100000000, 600000000, 150000000 },
@@ -33,14 +37,115 @@ static const char * const cs7542_clock_names[] = {
 	[CS7542_CLK_APB] = "cs7542-apb",
 	[CS7542_CLK_CPU] = "cs7542-cpu",
 	[CS7542_CLK_AXI] = "cs7542-axi",
+	[CS7542_CLK_PCIE0] = "cs7542-pcie0",
+	[CS7542_CLK_PCIE1] = "cs7542-pcie1",
+	[CS7542_CLK_PCIE2] = "cs7542-pcie2",
+};
+
+#define CS7542_PORTS	3
+#define GLOBAL_RESET	0x04
+#define GLOBAL_CONFIG	0x10
+
+struct cs7542_gate {
+	struct clk_hw hw;
+	struct regmap *map;
+	u32 mask;
+};
+
+struct cs7542_control {
+	struct reset_controller_dev rcdev;
+	struct regmap *map;
+	struct cs7542_gate gates[CS7542_PORTS];
+	struct clk_hw_onecell_data *clks;
+};
+
+static int cs7542_gate_prepare(struct clk_hw *hw)
+{
+	struct cs7542_gate *gate = container_of(hw, struct cs7542_gate, hw);
+
+	return regmap_update_bits(gate->map, GLOBAL_CONFIG, gate->mask, gate->mask);
+}
+
+static void cs7542_gate_unprepare(struct clk_hw *hw)
+{
+	struct cs7542_gate *gate = container_of(hw, struct cs7542_gate, hw);
+
+	regmap_update_bits(gate->map, GLOBAL_CONFIG, gate->mask, 0);
+}
+
+static int cs7542_gate_is_prepared(struct clk_hw *hw)
+{
+	struct cs7542_gate *gate = container_of(hw, struct cs7542_gate, hw);
+	unsigned int value;
+	int ret;
+
+	ret = regmap_read(gate->map, GLOBAL_CONFIG, &value);
+	return ret ? ret : !!(value & gate->mask);
+}
+
+static const struct clk_ops cs7542_gate_ops = {
+	.prepare = cs7542_gate_prepare,
+	.unprepare = cs7542_gate_unprepare,
+	.is_prepared = cs7542_gate_is_prepared,
+};
+
+static int cs7542_reset_update(struct reset_controller_dev *rcdev,
+			       unsigned long id, bool assert)
+{
+	struct cs7542_control *ctl = container_of(rcdev, struct cs7542_control, rcdev);
+	u32 mask = BIT(6 + id);
+
+	return regmap_update_bits(ctl->map, GLOBAL_RESET, mask, assert ? mask : 0);
+}
+
+static int cs7542_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return cs7542_reset_update(rcdev, id, true);
+}
+
+static int cs7542_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return cs7542_reset_update(rcdev, id, false);
+}
+
+static int cs7542_reset_status(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct cs7542_control *ctl = container_of(rcdev, struct cs7542_control, rcdev);
+	unsigned int value;
+	int ret;
+
+	ret = regmap_read(ctl->map, GLOBAL_RESET, &value);
+	return ret ? ret : !!(value & BIT(6 + id));
+}
+
+static int cs7542_reset_pulse(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	int ret;
+
+	ret = cs7542_reset_assert(rcdev, id);
+	if (ret)
+		return ret;
+	usleep_range(10000, 12000);
+	ret = cs7542_reset_deassert(rcdev, id);
+	if (ret)
+		return ret;
+	usleep_range(10000, 12000);
+	return 0;
+}
+
+static const struct reset_control_ops cs7542_reset_ops = {
+	.assert = cs7542_reset_assert,
+	.deassert = cs7542_reset_deassert,
+	.status = cs7542_reset_status,
+	.reset = cs7542_reset_pulse,
 };
 
 static void __init cs7542_clk_init(struct device_node *np)
 {
-	struct clk_hw_onecell_data *data;
+	struct cs7542_control *ctl;
 	struct regmap *map;
 	unsigned int strap, speed;
-	int i, ret;
+	int i, j, ret;
 
 	map = syscon_node_to_regmap(np);
 	if (IS_ERR(map)) {
@@ -60,30 +165,66 @@ static void __init cs7542_clk_init(struct device_node *np)
 		return;
 	}
 
-	data = kzalloc_flex(*data, hws, CS7542_NUM_CLKS);
-	if (!data)
+	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
+	if (!ctl)
+		return;
+	ctl->map = map;
+	ctl->clks = kzalloc_flex(*ctl->clks, hws, CS7542_NUM_CLKS);
+	if (!ctl->clks) {
+		kfree(ctl);
 		return;
-	data->num = CS7542_NUM_CLKS;
-
-	for (i = 0; i < CS7542_NUM_CLKS; i++) {
-		data->hws[i] = clk_hw_register_fixed_rate(NULL,
-							  cs7542_clock_names[i], NULL,
-							  0, cs7542_rates[speed][i]);
-		if (IS_ERR(data->hws[i])) {
-			ret = PTR_ERR(data->hws[i]);
-			goto err_unregister;
+	}
+	ctl->clks->num = CS7542_NUM_CLKS;
+
+	for (i = 0; i < CS7542_NUM_FIXED_CLKS; i++) {
+		ctl->clks->hws[i] = clk_hw_register_fixed_rate(NULL,
+							       cs7542_clock_names[i], NULL,
+							       0, cs7542_rates[speed][i]);
+		if (IS_ERR(ctl->clks->hws[i])) {
+			ret = PTR_ERR(ctl->clks->hws[i]);
+			goto err_unregister_fixed;
 		}
 	}
 
-	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, data);
+	for (j = 0; j < CS7542_PORTS; j++) {
+		struct cs7542_gate *gate = &ctl->gates[j];
+		struct clk_init_data init = {
+			.name = cs7542_clock_names[CS7542_CLK_PCIE0 + j],
+			.ops = &cs7542_gate_ops,
+		};
+
+		/* Gate-only controls: no source frequency is assumed. */
+		gate->map = map;
+		gate->mask = BIT(10 + 2 * j);
+		gate->hw.init = &init;
+		ret = clk_hw_register(NULL, &gate->hw);
+		if (ret)
+			goto err_unregister_gates;
+		ctl->clks->hws[CS7542_CLK_PCIE0 + j] = &gate->hw;
+	}
+
+	ctl->rcdev.owner = THIS_MODULE;
+	ctl->rcdev.ops = &cs7542_reset_ops;
+	ctl->rcdev.of_node = np;
+	ctl->rcdev.nr_resets = CS7542_PORTS;
+	ret = reset_controller_register(&ctl->rcdev);
+	if (ret)
+		goto err_unregister_gates;
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, ctl->clks);
 	if (!ret)
 		return;
 
-err_unregister:
+	reset_controller_unregister(&ctl->rcdev);
+err_unregister_gates:
+	while (j--)
+		clk_hw_unregister(&ctl->gates[j].hw);
+err_unregister_fixed:
 	while (i--)
-		clk_hw_unregister_fixed_rate(data->hws[i]);
-	kfree(data);
-	pr_err("%pOF: cannot register clocks: %d\n", np, ret);
+		clk_hw_unregister_fixed_rate(ctl->clks->hws[i]);
+	kfree(ctl->clks);
+	kfree(ctl);
+	pr_err("%pOF: cannot register global controls: %d\n", np, ret);
 }
 
 /* Timers need APB before platform devices, but the pinctrl child must probe. */

-- 
2.53.0


