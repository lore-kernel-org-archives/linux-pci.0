Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580140;
	b=dYP2EcskeqZaG0QuwOzE/zioq6GYDaextu5x64+LuZ4o7qKrFspjklMsrMRqLqwIdWwx
	 aU4qifyo0t97/mkR/nypLs/qDd2npUYvziZdMZeLIL/5Xkt6eoPqO1JDPrDBJOyoLvmMN
	 P+x4qrKvAAzjHq2qtiQz8wF3J7gkVTdy364f1bXe6u8LGc58qFUWrq00W71IATwkfCeAj
	 KQBIWrFBUHBElDvb7FqCzaJNWaifrB7jYbBXh5+5hAnEMiBT3UgnrjZW54H5DVN7M5nzK
	 rUbqP6bD2Zs8oqS5i2ub0hxY47VX+dEnX/BPuXUYsM5da7ai4w+WWGZazWjyrjgZRCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+lnP5N8d/GW3QDCKYsZCJCZ0aJwXzBKVnMHodRhbiOc=;
	b=L27azL+JTeZx2VBAzxfY6xcPDqcCDXZRFady0EZHfeNY+OIYSSkUo6Ry7hxr2TOhEaaQ
	 RusZ9itRALpJh2kN5yGf/WkNKV5dRJq4ni0yidkib0E2EOsWWPC45n0SNiGGNkzuzAMsA
	 +ECwNQshAu9LaghSdK4nwMlJOCphwq1DAgVgDz36K97K7mjzj7jL09Hx40CXNZG7R3Nay
	 bZZOlsr2V5zct+GT81PGq0RbdS230S0HcMSKatZK43xy7ZYvjCM6/wmM+00YK7yOTeG7Y
	 qFFFh141e5GKd+RpDf7sId+qfs7bIQZTi4e84opDaOmIl+VPitKvUZqTRkvVBPeXbXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dnp2udsN;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D989606A332
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 04:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D989606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dnp2udsN
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso3682861a91.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 20:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795580140; x=1796184940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+lnP5N8d/GW3QDCKYsZCJCZ0aJwXzBKVnMHodRhbiOc=;
        b=Dnp2udsNUtexVWceWNpdwrKsFgONJxChDclniNCZvlS4eeO1Yi/wdiiPivBECvEhhf
         eVe7Vwjsueo/wVpVH29/+PDlrlgf6tOlyub0nSQKFo9dZB+h87gEmLuuz9vBiYCrQLcA
         /UsC4MFFvKVm4MGEdB2bk5Pa51jAuLSpfgV14f9kD5LdkQ5f7Yh7rmS0InS3X1EH4ndn
         OxllEk+4r9ouPvVr18J7Bp7GwWE/3KkNNcRn36B9h/SptrJ6DdrRCQR7/MT8hjuE7HgT
         jFUPocVKEfM4CoxFs8yka/vMm7vIxViEPo2owLEpbhjA0rJ703o1tjcZsokfLfU2fTbF
         d5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795580140; x=1796184940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+lnP5N8d/GW3QDCKYsZCJCZ0aJwXzBKVnMHodRhbiOc=;
        b=q5qFv/RnkjoVfzcPzUyweGtKrOwTW3Bl6/vi/GpSV8q/pL8xCl9NEEsuWj7FQd5Lnv
         5r70nQEBBBTRbpOotNlPdNlFhpUR0Baa6xwbHJfVmpoq4cS+8a9OrWC7kwXHqp+kjGYk
         SyFVrzvojRasueTbh/GPqN3LBnx4QYq7hBdN/SGwhXV+u0vbIafIEFwyu6DKpSGCgmMT
         Ov84R+ToTGkiySk6w3OZ0oBNl/qGiPv+g3TMvvDgCEpoe0Omld5/Kw6MLO4+yOrCYgXs
         vXmwGYnlOErbSHWGY7gnPHBwYfMixBmeJQ//9Pgb2VPVb/ILmCbfKcxas8WChajffxGy
         7jJw==
X-Gm-Message-State: APuU4Z8TvAci/1oou7RONcbKkIZJbUd06XRCK/U3IusnWmJF6xDuFHjz
	WWEngk2nSg3Gz4hUWyJEpXwjW2r0Jq2u6UTyGMpNi1Ha6p2cHttE8Vnc
X-Gm-Gg: AZFdTZdf+CBDNA3XqAPeI8B9n2PtJ0+oIHRO4fVQ60NEZY1qrBYijCWgBecCUgid2tz
	V6JcYNRf2NqhpWpDpKu6357ej9AAImfh46MAinV5H0TGhOO/5gx35wuhUldavpZrXuYcZMoPoZE
	Y16zdOnWREJWLvV7maEsGXgRpNfbsPjUjoNZ7+CxNxoTE9AzE1dtX8urSr97gqhIiF3SjKoRRHR
	3Qj20CXxdXSaEiUMg0wwxyXAtRi6uvqcA+M9O4LoIa3N3zzAfk/ah2kYmOIh+PUM+W0wyQ1My+S
	npq/XpTWrQ/yeMrRfa40iHsSG3i4BR0KYr07DD6h7Iwsh84QzD9V9wtnnyJ8CkIiQOVjwYFTF8M
	9lp1EnZOtqkldi/j4/Eyd9XkcbQvTewABnrfsq59u4owegl1+f4xeYczBMJ/qlkmK52nCeNufta
	HD6cOEQedEPrDDZIBbQ6eNSyfPS5dxN9e8dK+pQZ7fZp7lWo/pSf35uGQEEDdonIZYo1iGrNpcz
	yThT9+RUtfhQ1k7vjkzGfiKrEOnF4YNqEBt/h3cPxF6NwX2Mx2F+hdeXU4DDAADRvug0SllwGT/
	LrDp76Ouz/zAjAMtKLQiH3UzSiA=
X-Received: by 2002:a17:90b:2f8c:b0:3ac:9c37:9426 with SMTP id 98e67ed59e1d1-3b41c92a2c1mr16021471a91.31.1795580139611;
        Tue, 24 Nov 2026 20:15:39 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41aab4729sm25258203a91.0.2026.11.24.20.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:15:38 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Frank Li <Frank.Li@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Randolph Lin <randolph@andestech.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Alex Elder <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v8 2/6] PCI: spacemit-k1: Add multiple PHY handles support
Date: Wed, 25 Nov 2026 12:15:16 +0800
Message-ID: <20261125041523.242588-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125041523.242588-1-inochiama@gmail.com>
References: <20261125041523.242588-1-inochiama@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe controller on Spacemit K3 may use multiple PHYs at the
same time. The feature is not supported by the current driver.
So extend the PHY definition to support multiple PHY handles.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 57 ++++++++++++++-----
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index 658ad2fa87b2..8a3cae32609f 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -54,12 +54,14 @@ struct k1_pcie_device_data {
 	const struct dw_pcie_host_ops *host_ops;
 	const struct dw_pcie_ops *ops;
 	int (*parse_port)(struct k1_pcie *k1);
+	unsigned int max_phy_count;
 };
 
 struct k1_pcie {
 	struct dw_pcie pci;
 	const struct k1_pcie_device_data *data;
-	struct phy *phy;
+	struct phy_bulk_data *phys;
+	unsigned int phy_count;
 	void __iomem *link;
 	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
 	u32 pmu_off;
@@ -118,6 +120,25 @@ static void k1_pcie_disable_resources(struct k1_pcie *k1)
 	clk_bulk_disable_unprepare(ARRAY_SIZE(pci->app_clks), pci->app_clks);
 }
 
+static int k1_pcie_get_phy_handle(struct k1_pcie *k1, struct device_node *node)
+{
+	const struct k1_pcie_device_data *data = k1->data;
+	struct device *dev = k1->pci.dev;
+	int count;
+
+	count = devm_of_phy_bulk_get_all(dev, node, &k1->phys);
+	if (count < 0)
+		return count;
+	if (!count)
+		return -ENOENT;
+	if (count > data->max_phy_count)
+		return -EINVAL;
+
+	k1->phy_count = count;
+
+	return 0;
+}
+
 /* FIXME: Disable ASPM L1 to avoid errors reported on some NVMe drives */
 static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)
 {
@@ -173,12 +194,13 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
 	 */
 	regmap_set_bits(k1->pmu, reset_ctrl, DEVICE_TYPE_RC | PCIE_AUX_PWR_DET);
 
-	ret = phy_init(k1->phy);
-	if (ret) {
-		k1_pcie_disable_resources(k1);
+	ret = phy_bulk_init(k1->phy_count, k1->phys);
+	if (ret)
+		goto failed_phy_init;
 
-		return ret;
-	}
+	ret = phy_bulk_power_on(k1->phy_count, k1->phys);
+	if (ret)
+		goto failed_phy_power_on;
 
 	/* Deassert fundamental reset (drive PERST# high) */
 	regmap_clear_bits(k1->pmu, reset_ctrl, PCIE_RC_PERST);
@@ -187,6 +209,14 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
 	k1_pcie_disable_aspm_l1(k1);
 
 	return 0;
+
+failed_phy_power_on:
+	phy_bulk_exit(k1->phy_count, k1->phys);
+failed_phy_init:
+	k1_pcie_disable_resources(k1);
+
+	return ret;
+
 }
 
 static void k1_pcie_deinit(struct dw_pcie_rp *pp)
@@ -198,7 +228,8 @@ static void k1_pcie_deinit(struct dw_pcie_rp *pp)
 	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
 			PCIE_RC_PERST);
 
-	phy_exit(k1->phy);
+	phy_bulk_power_off(k1->phy_count, k1->phys);
+	phy_bulk_exit(k1->phy_count, k1->phys);
 
 	k1_pcie_disable_resources(k1);
 }
@@ -265,23 +296,18 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
 {
 	struct device *dev = k1->pci.dev;
 	struct device_node *root_port;
-	struct phy *phy;
+	int ret;
 
 	/* We assume only one root port */
 	root_port = of_get_next_available_child(dev_of_node(dev), NULL);
 	if (!root_port)
 		return -EINVAL;
 
-	phy = devm_of_phy_get(dev, root_port, NULL);
+	ret = k1_pcie_get_phy_handle(k1, root_port);
 
 	of_node_put(root_port);
 
-	if (IS_ERR(phy))
-		return PTR_ERR(phy);
-
-	k1->phy = phy;
-
-	return 0;
+	return ret;
 }
 
 static int k1_pcie_probe(struct platform_device *pdev)
@@ -357,6 +383,7 @@ static const struct k1_pcie_device_data k1_pcie_device_data = {
 	.host_ops	= &k1_pcie_host_ops,
 	.ops		= &k1_pcie_ops,
 	.parse_port	= k1_pcie_parse_port,
+	.max_phy_count	= 1,
 };
 
 static const struct of_device_id k1_pcie_of_match_table[] = {
-- 
2.56.1

