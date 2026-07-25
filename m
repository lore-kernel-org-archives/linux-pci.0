Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A2B3932D1;
	Sat, 25 Jul 2026 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969983; cv=none; b=FNa+qKOsUrECarZJikmjLEv9y3I9vdt2YTMa+cbGnqZ2Scusodk+I61cYiX3+rhV4AGo7ryUx7l38wc0/GFbXOO+DArpRJ7pOF98jCu2zqkkIpVTjE5tbIajWqhchRWmvJWkGMQ5OQMalLxTNwU/pqO0GkxzuAxsKcGxHemzARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969983; c=relaxed/simple;
	bh=KbJXhFNK6fCzZiWsD5KU2LNGzJ4GllfjYKwg8DYWEew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3ySPibHY3ZraN0dvUIGYHw2CT4AxE7a+Nn8qaAoLR+FmZKYYAB7d+XoNhlktS+yxYiwD2zQNEm4oOTma2/0ffLZNZaujtaSnTjyyQrpbL4K+g3a12cwlIOxSq64O8xBoxh+6ZuZmmtaknAiupLyLOv1vKCUOtnMDDtdNHicrb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxsBR4SH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxsBR4SH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37C5DC2BD01;
	Sat, 25 Jul 2026 08:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784969983;
	bh=KbJXhFNK6fCzZiWsD5KU2LNGzJ4GllfjYKwg8DYWEew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pxsBR4SHVSV2IHC/w9cdracZknQ0h/AAT+Gvnb4HEyTRCT2FSN8pc0Gx2fXSKjYbL
	 pkrQEwyIXgrtpqMfdhLwjPehECJrTal/NTtSDyc47wPQ1nSJwESvcgXJnCvi1PcZgs
	 QWF5cLQwZg3+gk/NSDMAMxIoeEu8/6HUeQXG1We0h8QSzaCVVxG3wZcooMwXRWReO/
	 dM+VQJ4WpUr+XB7pvM/0LxHe3COGMeYyOstD0zYUgpmYJ/hbkVTv12YykEbuXdozuh
	 XyIU7TPtwaEJmxrkaaUNifWIHIeRVLKiPqgKw0BRIL+VznRBDAwffac8R0Ge//iOx6
	 e7c1vpJKBAWwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B73C53209;
	Sat, 25 Jul 2026 08:59:43 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Sat, 25 Jul 2026 10:59:18 +0200
Subject: [PATCH 6/6] PCI/pwrctrl: tc9563: Move Integrated MAC Endpoint out
 of 'tc9563_pwrctrl_ports' enum
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-tc9563-fix-v1-6-ec4286e31331@oss.qualcomm.com>
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
In-Reply-To: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alex Elder <elder@riscstar.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6643;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=CH/BiOhOO4aBwUSd3plwuQwd+JfSFw0fL8YxX/BX6wI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqZHr8znYrpwja1Ob6QuVajyytmN9Zus82VyKhp
 Pg+U9isLUaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCamR6/AAKCRBVnxHm/pHO
 9Z2OB/4rGUqpdh/GnlXVyqKLRFvsMfTNUF68HnFqgusyHiv4H/tuLxyLThXXJRuK52VeIE+GzqJ
 ok5xb3pH0kPe1sDXv1BSIY/mcqpXrPzYoVXtq9Q5J6vEoi2pS21MfnU4YPgkUHEW6/npSPiYbjU
 H1CeP1X0S/EFNKA07PoPAb418YGjK8Rn+5PkJLz+15R+wTs6q2pytSP5uPSeOAdD7UJ5gE1RUOI
 93iZPPyA2SKMn5e2m3LVsvYZttxVBn20DLfFTmBEQSkAE0E/itJFjkt6cYeFL281ZHO4OnFyKY5
 DLXpcwlkMlvz+xWQEMVm1GFvd1ylhB9rwE214eJvxePPtGuv
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

'tc9563_pwrctrl_ports' is supposed to list only the internal ports of the
switch. But it currently lists the integrated MAC Endpoint as well, which
is wrong.

Hence, move it to a separate 'ep_cfg' struct and also configure/parse the
ports and the MAC Endpoint separately.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 96 ++++++++++++++++++++------------
 1 file changed, 60 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index f1179737f221..9d869483b6b3 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -81,7 +81,6 @@ enum tc9563_pwrctrl_ports {
 	TC9563_DSP1,
 	TC9563_DSP2,
 	TC9563_VDSP,
-	TC9563_ETHERNET,
 	TC9563_MAX
 };
 
@@ -109,6 +108,7 @@ struct tc9563_pwrctrl {
 	struct pci_pwrctrl pwrctrl;
 	struct regulator_bulk_data supplies[TC9563_PWRCTL_MAX_SUPPLY];
 	struct tc9563_pwrctrl_cfg cfg[TC9563_MAX];
+	struct tc9563_pwrctrl_cfg ep_cfg;
 	struct gpio_desc *reset_gpio;
 	struct i2c_adapter *adapter;
 	struct i2c_client *client;
@@ -263,11 +263,11 @@ static int tc9563_pwrctrl_disable_port(struct tc9563_pwrctrl *tc9563,
 					     ARRAY_SIZE(common_pwroff_seq));
 }
 
-static int tc9563_pwrctrl_set_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc9563,
-						 enum tc9563_pwrctrl_ports port,
-						 bool is_l1, u32 ns)
+static int tc9563_pwrctrl_set_port_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc9563,
+						      enum tc9563_pwrctrl_ports port,
+						      bool is_l1, u32 ns)
 {
-	u32 rd_val, units;
+	u32 units;
 	int ret;
 
 	if (ns < TC9563_L0S_L1_DELAY_UNIT_NS)
@@ -276,25 +276,6 @@ static int tc9563_pwrctrl_set_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc9563,
 	/* convert to units of 256ns */
 	units = ns / TC9563_L0S_L1_DELAY_UNIT_NS;
 
-	if (port == TC9563_ETHERNET) {
-		ret = tc9563_pwrctrl_i2c_read(tc9563->client,
-					      TC9563_EMBEDDED_ETH_DELAY,
-					      &rd_val);
-		if (ret)
-			return ret;
-
-		if (is_l1)
-			rd_val = u32_replace_bits(rd_val, units,
-						  TC9563_ETH_L1_DELAY_MASK);
-		else
-			rd_val = u32_replace_bits(rd_val, units,
-						  TC9563_ETH_L0S_DELAY_MASK);
-
-		return tc9563_pwrctrl_i2c_write(tc9563->client,
-						TC9563_EMBEDDED_ETH_DELAY,
-						rd_val);
-	}
-
 	ret = tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_PORT_SELECT,
 				       BIT(port));
 	if (ret)
@@ -305,6 +286,34 @@ static int tc9563_pwrctrl_set_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc9563,
 			units);
 }
 
+static int tc9563_pwrctrl_set_eth_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc9563,
+						     bool is_l1, u32 ns)
+{
+	u32 rd_val, units;
+	int ret;
+
+	if (ns < TC9563_L0S_L1_DELAY_UNIT_NS)
+		return 0;
+
+	/* convert to units of 256ns */
+	units = ns / TC9563_L0S_L1_DELAY_UNIT_NS;
+
+	ret = tc9563_pwrctrl_i2c_read(tc9563->client, TC9563_EMBEDDED_ETH_DELAY,
+				      &rd_val);
+	if (ret)
+		return ret;
+
+	if (is_l1)
+		rd_val = u32_replace_bits(rd_val, units,
+					  TC9563_ETH_L1_DELAY_MASK);
+	else
+		rd_val = u32_replace_bits(rd_val, units,
+					  TC9563_ETH_L0S_DELAY_MASK);
+
+	return tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_EMBEDDED_ETH_DELAY,
+					rd_val);
+}
+
 static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl *tc9563,
 					   enum tc9563_pwrctrl_ports port)
 {
@@ -430,11 +439,9 @@ static int tc9563_pwrctrl_assert_deassert_reset(struct tc9563_pwrctrl *tc9563,
 	return tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_RESET_GPIO, val);
 }
 
-static int tc9563_pwrctrl_parse_device_dt(struct tc9563_pwrctrl *tc9563,
-					  struct device_node *node,
-					  enum tc9563_pwrctrl_ports port)
+static int tc9563_pwrctrl_parse_device_dt(struct device_node *node,
+					  struct tc9563_pwrctrl_cfg *cfg)
 {
-	struct tc9563_pwrctrl_cfg *cfg = &tc9563->cfg[port];
 	int ret;
 
 	/* Disable port if the status of the port is disabled. */
@@ -505,13 +512,13 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 			goto power_off;
 		}
 
-		ret = tc9563_pwrctrl_set_l0s_l1_entry_delay(tc9563, i, false, cfg->l0s_delay);
+		ret = tc9563_pwrctrl_set_port_l0s_l1_entry_delay(tc9563, i, false, cfg->l0s_delay);
 		if (ret) {
 			dev_err(dev, "Setting L0s entry delay failed\n");
 			goto power_off;
 		}
 
-		ret = tc9563_pwrctrl_set_l0s_l1_entry_delay(tc9563, i, true, cfg->l1_delay);
+		ret = tc9563_pwrctrl_set_port_l0s_l1_entry_delay(tc9563, i, true, cfg->l1_delay);
 		if (ret) {
 			dev_err(dev, "Setting L1 entry delay failed\n");
 			goto power_off;
@@ -536,6 +543,21 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 		}
 	}
 
+	/* Configure the integrated Ethernet MAC endpoint */
+	ret = tc9563_pwrctrl_set_eth_l0s_l1_entry_delay(tc9563, false,
+							tc9563->ep_cfg.l0s_delay);
+	if (ret) {
+		dev_err(dev, "Setting Ethernet L0s entry delay failed\n");
+		goto power_off;
+	}
+
+	ret = tc9563_pwrctrl_set_eth_l0s_l1_entry_delay(tc9563, true,
+							tc9563->ep_cfg.l1_delay);
+	if (ret) {
+		dev_err(dev, "Setting Ethernet L1 entry delay failed\n");
+		goto power_off;
+	}
+
 	ret = tc9563_pwrctrl_assert_deassert_reset(tc9563, true);
 	if (!ret)
 		return 0;
@@ -593,8 +615,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 
 	pci_pwrctrl_init(&tc9563->pwrctrl, dev);
 
-	port = TC9563_USP;
-	ret = tc9563_pwrctrl_parse_device_dt(tc9563, node, port);
+	ret = tc9563_pwrctrl_parse_device_dt(node, &tc9563->cfg[TC9563_USP]);
 	if (ret) {
 		dev_err(dev, "failed to parse device tree properties: %d\n", ret);
 		goto remove_i2c;
@@ -605,9 +626,12 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	 * The first node represents DSP1, the second node represents DSP2,
 	 * and so on.
 	 */
+	port = TC9563_USP;
 	for_each_child_of_node_scoped(node, child) {
-		port++;
-		ret = tc9563_pwrctrl_parse_device_dt(tc9563, child, port);
+		if (++port >= TC9563_MAX)
+			break;
+
+		ret = tc9563_pwrctrl_parse_device_dt(child, &tc9563->cfg[port]);
 		if (ret)
 			break;
 
@@ -619,8 +643,8 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 			struct device_node *eth __free(device_node) =
 					of_get_next_available_child(child, NULL);
 			if (eth) {
-				ret = tc9563_pwrctrl_parse_device_dt(tc9563,
-								eth, TC9563_ETHERNET);
+				ret = tc9563_pwrctrl_parse_device_dt(eth,
+							&tc9563->ep_cfg);
 				if (ret)
 					break;
 			}

-- 
2.43.0


