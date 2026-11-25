Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581462;
	b=hTFJ1ceyKYFPBL7eBb7sCsKkXUE0R/T3ZHeWh3dQtyvs5SXf/V4rlRFnkE4i6HHE8Nby
	 KucXwoi9GZY0g8VEa70aONlIA2yHm9aIs4TUJ+ucqHTTlrhcY2fNF2y9XUSJiWqq6vbpv
	 xmjjb3BtoCX9XYf72ciXhd4l4DrgONEi7FeSLAjGp0d8nwUdhPsO0E6rsXXMoyHzh0d7M
	 0N8oMGu1mYtnRG4h+kxqL2Z3fDikhvFiol2F3i2nJ0wFf3N9SVaByK4rfetyqJlkHVANX
	 KH0CAIv2unpMObgwm7r0MEuKsZOm0uPHlnWRFckGCCtMcR+JZfo9sZXC+qDhUl8Qhwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Th0U5TzJmX7EaDDFA+PHgDoYo8RCe0k6TY8cW8gRTLA=;
	b=nm2KCK2czqe4T1IbAXHNnHYckWufgIanvybdhUQvOsQaMFZ9TR9WGpq+DNZ7EcC2cs4G
	 xYu4Bw2M38Fltkay1KXAFgZdmMcnu+PsYx3eHqX9oq/gy6KQPjZkNbKJYjZBlmnlv0k+D
	 VB5X012iDUvtiWCWu7TLQQWXTESCu4p3FdoWJKubegocxH/uB+EtHrvZajhqdgUyOse3T
	 hWpacC3rGY6D66Kk2c5T0GDDOmk6ATQ9JqFsrt7Pz5+yGKZUzDvcRu5yx0Lhj6s/544gt
	 Tc28hiUrkswJEsBi5zl598v2kmlAcsVSu+mjjN6EmLXVQDpYzBs8LFuVZ4uJT9SI3iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ydZwfXs4;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC1606A336
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 04:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27BC1606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ydZwfXs4
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f05b465cd1so27562275ad.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 20:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581462; x=1796186262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Th0U5TzJmX7EaDDFA+PHgDoYo8RCe0k6TY8cW8gRTLA=;
        b=ydZwfXs4itqQiYJPjgaUOOO0SQIyr1DBTGTbktl7OG2/yC5Dblolhcn3IS42km/rf+
         tVkzDsddKnEt2tLiPCLnhOg/KKr6yW0dYeWYUUgzJl+Ubn1XLTHgYqH3xvldlSDKy2rA
         mD+BT3arUSXfXqCSlhE6qWm+2gP4E+jZ5pXeU9aQeWLR3wE4JdQZxV7uIxsB3wpYRzBa
         VYiMQTNNXsMnGgJYUeP9YCSVmibS06kpZzwaCLjiheizhm32L19Q8c0lXmlLsUeVVl9T
         Jt/d2ovu1QdMREbgiVNGZzR+No7PtC13I9Il5FbUY3Vu+/PQ+P1iBCilGgZUYlrjlKzo
         ZWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581462; x=1796186262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Th0U5TzJmX7EaDDFA+PHgDoYo8RCe0k6TY8cW8gRTLA=;
        b=usIu4eCFBiM9QdoBB+MzA8oX3TEvYjzevl93yUKv19iw9mtP58ZvjNodBbokzbJWfI
         g0Al8cpWOOm1Rx76jjXTWn0LI9+SOvs2Joy0YSYnv2G/Az0cyHTtF+L/dpLcJ3KCOQ2K
         ZCQ5LINXApdPI44a5O8p7GwjM/aTTdwdbUC7JEQbZOcjz53qWcXK27dvDhZelNliIK5P
         yh7hU63N2QuW5IGQlFa3UkzPIzDVgzQ3F/MG4kmUdzdmXwbyAo0PJqm8c6b+RXNwjM8b
         M0cBxNnt8MCNCfMP3Zbcddu0rvbxDEvE6mlcQBQRZlb9xghJYDhyqIcqnKU83W3R9h4Z
         YMxQ==
X-Forwarded-Encrypted: i=1; AL+hErEr8EP9JXBmwkXLdgGlRNZwld9U/5GkXWIffTVEmM2HK0RsaM613nwWUvjOeEp11BwA5/PtkA2eet4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mZl+vX3j7kUp6ePrj32RngWnjucTF6Cr1GHmxrAOEKR2sgajt
	Dee/qeqxYwN3VakWY0Dc39LD0wjZEt5/P6CQAvYl2cK5RNw2zv+xcty5
X-Gm-Gg: AZFdTZdRkML/wjmier5MYEgFwHt/xzgJF1+XJkTPER+a6Ipg+B6RhLezTNG0lUWJW1e
	rZlx0JUL5YFksQIa015rag5xzAdA7vwhov3/K6Gv/sq+YbFbpT2yecdLaG192ZtvNyXxHs1v/fh
	ss2CFTWFPYNZwQtPzDr2Blnfh7sg4LuOlxx5w7+0nLRw1Djyfe1H5rDmsyfE9xgKKGGD9+zccrj
	K5tS19NwO8rQN22WlIafqrxXvfON5UbApJ2OoFCgcdlwVxHtZSXi4vW+KbpmHNtYxTZhJNwxQyd
	F+88DysRV6VzpNtdYoQetxM51A6aKys3WG6JpQ4wwT9jRiSGNHe22OiX2980zROUQROpQ1d+Lkf
	Vz5qQ8LZ8PiPJOPkBBPVqITq4V36WBfYUFH1dmww03z4bpmD3OCMOvASi09DEjucWBsJtA+yrcD
	KKHIF/4SfKawM32olRFTsssgJUD8GiqV0IOC6FSCWymuSwh9tG4d1A+5WeywvXNpRl7K030SY2K
	hkP+vh97uM+rgnY9q/8AmmKMrZqsPxcdtCGnpWBGkVy3lZHDnA4b0MRp25ZQwRmSHKJOU9jMGLL
	wyg1/bvgYvC1AvTiRpZOR0BT2F5FEqNcwqmPXejt3wWCmcsI
X-Received: by 2002:a17:903:294f:b0:2ed:630:40ad with SMTP id d9443c01a7336-2f03f11826cmr93907705ad.19.1795581461579;
        Tue, 24 Nov 2026 20:37:41 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c2ad2sm78350235ad.16.2026.11.24.20.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:37:41 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aksh Garg <a-garg7@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Rhys Tumelty <rhys@tumelty.co.uk>,
	Manikandan K Pillai <mpillai@cadence.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Hans Zhang <18255117159@163.com>,
	Yao Zi <me@ziyao.cc>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 8/8] ata: ahci_imx: Use bulk PHY APIs for calibration PHYs
Date: Wed, 25 Nov 2026 12:36:39 +0800
Message-ID: <20261125043639.249525-9-inochiama@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125043639.249525-1-inochiama@gmail.com>
References: <20261125043639.249525-1-inochiama@gmail.com>
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

The i.MX8QM SATA PHY relies on the first two HSIO lanes for shared
impedance calibration. Store these calibration PHYs in a bulk array
and acquire them by name with devm_phy_bulk_get().

Initialize both calibration PHYs before powering them on in lane order,
then keep the SATA PHY initialization, mode selection and power-on
separate. Use the bulk helpers to release the calibration PHYs after
SATA startup and to unwind failures without repeating power-off after
a failed bulk power-on.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/ata/ahci_imx.c | 57 ++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 6aaa18e29abc..18faa033e44f 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -25,6 +25,8 @@
 
 #define DRV_NAME "ahci-imx"
 
+#define NUM_CALIPHY		2
+
 enum {
 	/* Timer 1-ms Register */
 	IMX_TIMER1MS				= 0x00e0,
@@ -66,8 +68,7 @@ struct imx_ahci_priv {
 	struct clk *ahb_clk;
 	struct regmap *gpr;
 	struct phy *sata_phy;
-	struct phy *cali_phy0;
-	struct phy *cali_phy1;
+	struct phy_bulk_data cali_phys[NUM_CALIPHY];
 	bool no_device;
 	bool first_time;
 	u32 phy_params;
@@ -428,30 +429,20 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
 	 * Initialize the first two lane PHYs here, although only the
 	 * third lane PHY is used by SATA.
 	 */
-	ret = phy_init(imxpriv->cali_phy0);
+	ret = phy_bulk_init(NUM_CALIPHY, imxpriv->cali_phys);
 	if (ret) {
 		dev_err(dev, "cali PHY init failed\n");
 		return ret;
 	}
-	ret = phy_power_on(imxpriv->cali_phy0);
+	ret = phy_bulk_power_on(NUM_CALIPHY, imxpriv->cali_phys);
 	if (ret) {
 		dev_err(dev, "cali PHY power on failed\n");
-		goto err_cali_phy0_exit;
-	}
-	ret = phy_init(imxpriv->cali_phy1);
-	if (ret) {
-		dev_err(dev, "cali PHY1 init failed\n");
-		goto err_cali_phy0_off;
-	}
-	ret = phy_power_on(imxpriv->cali_phy1);
-	if (ret) {
-		dev_err(dev, "cali PHY1 power on failed\n");
-		goto err_cali_phy1_exit;
+		goto err_cali_phy_exit;
 	}
 	ret = phy_init(imxpriv->sata_phy);
 	if (ret) {
 		dev_err(dev, "sata PHY init failed\n");
-		goto err_cali_phy1_off;
+		goto err_cali_phy_off;
 	}
 	ret = phy_set_mode(imxpriv->sata_phy, PHY_MODE_SATA);
 	if (ret) {
@@ -465,10 +456,8 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
 	}
 
 	/* The cali_phy# can be turned off after SATA PHY is initialized. */
-	phy_power_off(imxpriv->cali_phy1);
-	phy_exit(imxpriv->cali_phy1);
-	phy_power_off(imxpriv->cali_phy0);
-	phy_exit(imxpriv->cali_phy0);
+	phy_bulk_power_off(NUM_CALIPHY, imxpriv->cali_phys);
+	phy_bulk_exit(NUM_CALIPHY, imxpriv->cali_phys);
 
 	/* RxWaterMark setting */
 	val = readl(hpriv->mmio + IMX8QM_SATA_AHCI_PTC);
@@ -480,14 +469,10 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
 
 err_sata_phy_exit:
 	phy_exit(imxpriv->sata_phy);
-err_cali_phy1_off:
-	phy_power_off(imxpriv->cali_phy1);
-err_cali_phy1_exit:
-	phy_exit(imxpriv->cali_phy1);
-err_cali_phy0_off:
-	phy_power_off(imxpriv->cali_phy0);
-err_cali_phy0_exit:
-	phy_exit(imxpriv->cali_phy0);
+err_cali_phy_off:
+	phy_bulk_power_off(NUM_CALIPHY, imxpriv->cali_phys);
+err_cali_phy_exit:
+	phy_bulk_exit(NUM_CALIPHY, imxpriv->cali_phys);
 
 	return ret;
 }
@@ -839,19 +824,19 @@ static const struct scsi_host_template ahci_platform_sht = {
 
 static int imx8_sata_probe(struct device *dev, struct imx_ahci_priv *imxpriv)
 {
+	int ret;
+
 	imxpriv->sata_phy = devm_phy_get(dev, "sata-phy");
 	if (IS_ERR(imxpriv->sata_phy))
 		return dev_err_probe(dev, PTR_ERR(imxpriv->sata_phy),
 				     "Failed to get sata_phy\n");
 
-	imxpriv->cali_phy0 = devm_phy_get(dev, "cali-phy0");
-	if (IS_ERR(imxpriv->cali_phy0))
-		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy0),
-				     "Failed to get cali_phy0\n");
-	imxpriv->cali_phy1 = devm_phy_get(dev, "cali-phy1");
-	if (IS_ERR(imxpriv->cali_phy1))
-		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy1),
-				     "Failed to get cali_phy1\n");
+	imxpriv->cali_phys[0].id = "cali-phy0";
+	imxpriv->cali_phys[1].id = "cali-phy1";
+
+	ret = devm_phy_bulk_get(dev, NUM_CALIPHY, imxpriv->cali_phys);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get cali_phy\n");
 	return 0;
 }
 
-- 
2.56.1

