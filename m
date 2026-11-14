Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794694384;
	b=SYpQCdshhChul7JfW4RzdT9U+6zJsyfGqn9NO52ikASbsdPdDDcgYrp9Xu4MfM0qXaz3
	 D/KYGYxarjSMZ2QdUB5lV1YQjhAmugQrQYqKnTRGjg2AGM9Skk9Y5KGzY3wvgfs1aZmxl
	 CaJ7q+pqTxJDZqnAvo+A0VfJ0nz2EdGLtJ8mdLy+EBPbo9XBn15oUfAx7H2QevzHVlCNK
	 64FT+EssGYlvHSt6FFpZG9ygX1FlV35J9G6wZ1WaI/XkFDrUYNtetqj4W+IKtyV/ZrSgr
	 skj/Q9f0/mfzVrtHQk8rh6iE7Wsj4yzeCXfKfFs6/WCIEDiTIuYv576CckVpj5WUR5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794694384;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JZYytunKML3y7PA1IDzFlQnkI0F6TBG/gdk3jD0lV4Y=;
	b=DA3jr9Aw31qYAifXaUfzm1Wm1/yRaigyJhOvo8NrqRPs3GapemhjCyuWhoRlRwRyIpss
	 rpRmVSoRVtlWQN6QoPl5wkZb3WH+oGMjvcISOTHXXcMLt+y88CSeaJQJGCQ80YcOdmg2z
	 Q36e4uWgdMIvTbxBhBP22dC9up3UGvt2QfAnQgSf2JUgp5MbuplTPWvMAD61Nvywat/re
	 9dYTrndZ+VIpnS3WRhMnEauOD7DRjk7ltj2peCM7ANX51PIJ//M8vRH5OdMqLnjmkqxhj
	 O0C16n6k2s3rJECKCTwEId55y6ocH8GNbiyIoKzRiArXdZMW3QdmjT6WQnpTosoKbBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqSzYkdA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA55606A335;
	Sat, 14 Nov 2026 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqSzYkdA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794694384;
	b=sHWlb4juzpxFpZKl4VWkH+1YxfHRUrBgpROCqIFdC59EdOnK9gdoFWI/LSkTYqGZvO5u
	 0c/0yDdnDorno3KySml9HShdzQWS8E61JH/yHgzZYWh+Ip30BaDBQz2WIFiiqek+9/Piq
	 3ICHzqcEITS8szwPiiVRnlMqJ4Z2Ak9UBVtlEMEjqr0uUYOfrMIVRxMn+GQQHWYMlwl5e
	 75DSUoRcGCQu4o0RR7AZO3uw9xheR3eWDiCAochU8ULqEBBVvj8Ewg29tKKVlBnYu4P3S
	 R3zyKePDr4/Bi3r8ZLplHixInHga3wfi+gOIoLwqHgDwaAXsc9DgxERqCYz+cd1LijA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794694384;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JZYytunKML3y7PA1IDzFlQnkI0F6TBG/gdk3jD0lV4Y=;
	b=H40o4TZ9pzT8h03QFENMIGZzjIIQnLytrph2ahqbMKcoxf+pWbBmFgFvvj15vJMdEDFm
	 D5ehVD1VREAtJYD2zmn1M4Lg4uZ8X4Cvoc9De0IC0CXiIkJ181sysrt4vEjbiH/1GeO33
	 5r0mMBUO0c3GpMhkNYrFt9PJEV4CSRLfbMIiIsl0pFptw9Qgp5WM37GryKh77iuI8W7fa
	 YMecAjiglZJNml2aHbloMtKW0L+eLno6LxGBxRjuElN3TLlaO7RfWfj4NK4muX+cjSC8q
	 q4a5NyUTuievk8GWdyOjMlP7B2s+4XhZHeYQ04yOH45OlmmdnwJqFY4Z7SbVS5zdRQQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6850F1F000C7;
	Sat, 14 Nov 2026 22:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794694384;
	bh=JZYytunKML3y7PA1IDzFlQnkI0F6TBG/gdk3jD0lV4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LqSzYkdAGBJzfV/U9emY+CTs8KHhXW6+KtbvUEUn6x8dBfYskSnkA5uj8BsKLNIf1
	 PMUFx5XdZNXMl75KuW6dx/36TU2B/hRZcDX8pE6+87thA227x17kBY9ID09xEMX+P4
	 rkajep+H+gPeJIQFlj5jyfIINFKEyYNtqLk9FnHYJ5EyE9KssqTFiwOb3A8Dg5j2Gx
	 wmJhNSIVGmclZFWW4WSeaxg5cn1rxGB7T0KmUh5xwqrJJDoz/I2Nzk9V6SADeVVZuc
	 qXvfvlGKhkCN5Nxb9SUx8u0hUOTxTLuGBg+v9cFlt6Ijtke2f5vgDnTOuMMyywNhFC
	 pYFG2eDnNeJ6Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E97A749EAC;
	Sat, 14 Nov 2026 22:13:02 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sat, 14 Nov 2026 22:12:59 +0000
Subject: [PATCH 2/2] PCI: meson: Add system suspend/resume support
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
Message-Id: <20261114-b4-pci-meson-suspend-v1-2-be3d04a13304@iav.lv>
References: <20261114-b4-pci-meson-suspend-v1-0-be3d04a13304@iav.lv>
In-Reply-To: <20261114-b4-pci-meson-suspend-v1-0-be3d04a13304@iav.lv>
To: Yue Wang <yue.wang@Amlogic.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5260; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=MeM+aGdPJAWmnUmNJwf7DDqjZs0SyCzmsgJmymZ7zbo=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFk/7rwVPihZuTDPPzQ7h/9pz5wzbadeZUprzjDMYJg/0
 VUie8rCjlIWBjEuBlkxRZYJhzRuZSy5+tffw/wBzBxWJpAhDFycAjCRFUyMDJtM+jp9o/ZMtxLR
 Fw/S/ayTdeZLxbx7vS/+TTXNFp5h95eRYVZKguzmtvi6M/Y3pIIuZXxkua/z38m+YnGmhuK2r2F
 SjAA=
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

On SM1 the controller sits in the PCIE power domain, which genpd
switches off in the noirq suspend phase.  The driver has no PM
callbacks, so the controller comes back unprogrammed and the first
config access to the Root Port after resume hangs the CPU.  On
ODROID-HC4 (ASM1061 SATA behind the port) s2idle never returns.

Add noirq PM callbacks that call dw_pcie_suspend_noirq() and
dw_pcie_resume_noirq(): suspend broadcasts PME_Turn_Off and waits for
L2 if the link is up, then calls .deinit; resume calls .init, programs
the Root Complex, MSI and iATU registers and restarts the link.  Set
suspend_poweroff, so that suspend enters L2 even when D3cold is not
possible.

Send PME_Turn_Off through the apps_pm_xmt_turnoff bit of PCIE_CFG0
in a .pme_turn_off callback, so that no outbound iATU window is needed
for the Msg TLP.  Bit 12 is apps_pm_xmt_turnoff in the description of
this wrapper in the Amlogic A311D (G12B) datasheet, where bit 7 is the
app_ltssm_enable the driver already uses.

Do this only when the controller has a power domain, as on SM1.  G12A,
G12B and AXG have none; entering L2 and powering the PHY off in
suspend is untested there, so the callbacks return at once.

A resume that fails to start the link or times out waiting for it
calls .deinit itself, and the next suspend calls it again.  A second
phy_power_off() and phy_exit() would unbalance the PHY counts, and the
next .init would not power the PHY on, so .deinit leaves a controller
that is already off alone.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/pci/controller/dwc/pci-meson.c | 53 ++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 627470c83bb5..5ef7369bb21b 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
@@ -27,6 +28,7 @@
 /* PCIe specific config registers */
 #define PCIE_CFG0			0x0
 #define APP_LTSSM_ENABLE		BIT(7)
+#define APPS_PM_XMT_TURNOFF		BIT(12)
 
 #define PCIE_CFG_STATUS12		0x30
 #define IS_SMLH_LINK_UP(x)		((x) & (1 << 6))
@@ -68,6 +70,8 @@ struct meson_pcie {
 	struct meson_pcie_rc_reset mrst;
 	struct gpio_desc *reset_gpio;
 	struct phy *phy;
+	bool power_domain;
+	bool powered;
 };
 
 static struct reset_control *meson_pcie_get_reset(struct meson_pcie *mp,
@@ -385,6 +389,8 @@ static int meson_pcie_host_init(struct dw_pcie_rp *pp)
 		return ret;
 	}
 
+	mp->powered = true;
+
 	pp->bridge->ops = &meson_pci_ops;
 
 	meson_set_max_payload(mp, MAX_PAYLOAD_SIZE);
@@ -397,13 +403,29 @@ static void meson_pcie_host_deinit(struct dw_pcie_rp *pp)
 {
 	struct meson_pcie *mp = to_meson_pcie(to_dw_pcie_from_pp(pp));
 
+	/* After a failed resume the next suspend calls .deinit once more */
+	if (!mp->powered)
+		return;
+
 	gpiod_set_value_cansleep(mp->reset_gpio, 1);
 	meson_pcie_power_off(mp);
+	mp->powered = false;
+}
+
+static void meson_pcie_pme_turn_off(struct dw_pcie_rp *pp)
+{
+	struct meson_pcie *mp = to_meson_pcie(to_dw_pcie_from_pp(pp));
+	u32 val;
+
+	val = meson_cfg_readl(mp, PCIE_CFG0);
+	meson_cfg_writel(mp, val | APPS_PM_XMT_TURNOFF, PCIE_CFG0);
+	meson_cfg_writel(mp, val, PCIE_CFG0);
 }
 
 static const struct dw_pcie_host_ops meson_pcie_host_ops = {
 	.init = meson_pcie_host_init,
 	.deinit = meson_pcie_host_deinit,
+	.pme_turn_off = meson_pcie_pme_turn_off,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -429,6 +451,13 @@ static int meson_pcie_probe(struct platform_device *pdev)
 	pci->pp.ops = &meson_pcie_host_ops;
 	pci->num_lanes = 1;
 
+	/*
+	 * Genpd switches the controller's power domain off in suspend.  Only
+	 * SM1 has one, and only SM1 gets suspend support.
+	 */
+	mp->power_domain = of_property_present(dev->of_node, "power-domains");
+	pci->pp.suspend_poweroff = mp->power_domain;
+
 	mp->phy = devm_phy_get(dev, "pcie");
 	if (IS_ERR(mp->phy)) {
 		dev_err(dev, "get phy failed, %pe\n", mp->phy);
@@ -477,6 +506,29 @@ static void meson_pcie_remove(struct platform_device *pdev)
 	dw_pcie_host_deinit(&mp->pci.pp);
 }
 
+static int meson_pcie_suspend_noirq(struct device *dev)
+{
+	struct meson_pcie *mp = dev_get_drvdata(dev);
+
+	if (!mp->power_domain)
+		return 0;
+
+	return dw_pcie_suspend_noirq(&mp->pci);
+}
+
+static int meson_pcie_resume_noirq(struct device *dev)
+{
+	struct meson_pcie *mp = dev_get_drvdata(dev);
+
+	if (!mp->power_domain)
+		return 0;
+
+	return dw_pcie_resume_noirq(&mp->pci);
+}
+
+static DEFINE_NOIRQ_DEV_PM_OPS(meson_pcie_pm_ops, meson_pcie_suspend_noirq,
+			       meson_pcie_resume_noirq);
+
 static const struct of_device_id meson_pcie_of_match[] = {
 	{
 		.compatible = "amlogic,axg-pcie",
@@ -494,6 +546,7 @@ static struct platform_driver meson_pcie_driver = {
 	.driver = {
 		.name = "meson-pcie",
 		.of_match_table = meson_pcie_of_match,
+		.pm = pm_sleep_ptr(&meson_pcie_pm_ops),
 	},
 };
 

-- 
2.43.0


