Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581440;
	b=sDaJvcrq1xSDtiCv+wLRYPykpMy4fchgKHJpjO0VSkjVNaay9I2K0+aVNEuPKH6IeyHT
	 LyVMP3/gAnTslXs9c0hSHscv0cngdUb8E6MR0t915aS7+R3SL8fDGsxTi/KMGpHUaqXcP
	 CuEnPsSSH6J1padJase8DQhXVcEpdEo7ZksunvjS5QrkUBtIUpUHthpIByFnjwYK9YbLA
	 s/iDazhN2eATScACBCVL7dft/yWp2PAAIEGeyo4wrDQTBEdD2KN9mmMfB+FBq+RCaTUVS
	 4mG65senHG4rL37DeLhxq4dbXOmkeulnrsM8s6qSf8XzU71VxbWE91c3vIlvBswGESg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=v73lnBxXLvBxSu7XkVP0pFYU3Balrjs//m2fQ2pstrU=;
	b=oUGqy3P/acpcMw4eqTw+o5QgGH7faWSUS2AkOcPQOG1j2puQsrG6l+wo76ogWAUncwrw
	 30gBtdcg6E1QGaAcs3oiAFyZ7L+Kw1K9e/mCDsBRwmGjJMAVEypUeLyHEmUPQgeZp13KA
	 s+SMedLfg9WAxlTj0ufN34XeaKzXnDtLVwg2Spe2u50Y++Rz/SP4Bxof0Reae3onIzKNm
	 w+DXFBpqkZbsHgGU/pdfCpDNzQKVsZEj33HR7Az+JpwbpMB+afpkPMI1c3+2jSE1XHhwi
	 BbGeJBo4Ac4P7ML1Ma8iFBbTMSTSe4L/OUsjhE4zcT+zB+XsJiSp0s/t4bCQZeAOcdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hoAvfN9g;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90A606A32E
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 04:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C90A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hoAvfN9g
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f04e3bf46dso37909035ad.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 20:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581439; x=1796186239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v73lnBxXLvBxSu7XkVP0pFYU3Balrjs//m2fQ2pstrU=;
        b=hoAvfN9gzx2LyLk/gEV2pCQQvL2eHN7Ybl9S9sseLNfnxe3TLOcWzkEHsO7H6i52Z8
         ITIu0vs7T0b8u7ysTdtMP3BWhjQlfdDNdds8EuQtokuuaolNc47LQgMP5JHrlNBrvvNY
         q9gGurHUD/mXM8g3m3m4nnxtcS3ZNNq1GBaQ7k8tfmyG0pdFAYOWPER24dpLCCp52kf3
         DDrkI4f/Kew96kmDkgo7bik5bil4SFvJCzb0Eipy3PVqHi4pPc4ymxRehHa7UcOcivEg
         4C0+klwghxMs7IUhkeI6brCl6T5Hh7pBcL0nbKwnipb1PZLIUD0kE2x12R/M4CRr3dYs
         M4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581439; x=1796186239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v73lnBxXLvBxSu7XkVP0pFYU3Balrjs//m2fQ2pstrU=;
        b=knys5urBdJsHfTV5G+wEBlstZZLlUoM+JpZbGlZIW8kUcFsOZ2Rgx1vLHuB3qyWni2
         m1ckg0ue14NnBAArWbN+EUepPgPuYRRmcodNvDMkJOyrSbNCFITqp9DjJAaGSpgOzZg9
         QdaAHVT/0KVV95WrQHhYmA0c0FQJ8uUQSSsl6xfsAXUjFL9zHNyOLwbvgp1KyT7f1MY4
         bbvrefFBxMenXPj8EQc7eZOSS4UKMnx0WI4u5wPbCtdiWJI4+TrsYKD50wX+qsGQN8kB
         pnYmPBwW1ls7esSpHNydTVzpePggtrnz3sVhxjrizqMqLbx4g41VUkD0ZDqEpW/GDExT
         XvRA==
X-Forwarded-Encrypted: i=1; AL+hErHS/WPCVd/peWuwsIBbUVWCqvDNylB/cbVnYnj9NNxqwWos+/MsI/vTxaiVen2aN4QAtwwyGonF90E=@vger.kernel.org
X-Gm-Message-State: APuU4Z97vLDybFLJaiMxfFRb3qUWKO/kwyytJaaHLEMDOfZ7/KhH46Om
	UeVoLmC0A+yaiDF9Uz/FASTw5pvy3HGhof787/UDQDo2LiiwNf8e9Jcq
X-Gm-Gg: AZFdTZd5wz0tqXnXtSBV2T7X+s/4DMkJTca2+JR0Wgz5PEIxm+49pVdIjGlWnMlkQ1J
	QrqpNq47xQ/j5ZjjZXYoRhOtrG2hjpFjQOc/JWZC1VgDfoHeI1OU9xDUCGGBwnxDJTZIQeuCaUi
	qOzVqSntjekQjalme+ovyufNOSGvDZuBMK/QJUDbrrK4X+jFVtp2dCIvpS25qwZOOgQpe/57+aB
	LXuVJzgBfa5TXIHwkdml4jO4Y4AIFkXsDKnN6gsGygLlcHJUJODfaGNX0QCypn2gbPvSWbNYp5a
	LfTEd4i1Bczw+iYR6O02jxR1uzyxCVEa3YxeQ+L8ekh6Uz5Tk+h0/d3ILNXzebFYAcwJ9OxuXyy
	vQ3arV2Rq5EPUQrN9epQL5wSUEBN3NBanTsys67nLkbsAUDJnmX8e0l29z5AJmI0AlnxBG3mSJL
	gOdMRysDHKmr812ihczwfxyHaAuJGlcDIOkT4d7ntSQoCYso88DAz8mrRC7THaWRvRU2jke/4yu
	6i2ZJj5zj9mM2aDlpwm+5GrYhD1XBrxLS0vU0UvSUWdAwDXtEiwsdueZowkky8NY7nV/+lZAcDl
	EpR2QClW/0u8tTsXDrjbu3+6Q1E=
X-Received: by 2002:a17:902:dacc:b0:2ed:472:b9d6 with SMTP id d9443c01a7336-2f03efb1397mr182475285ad.2.1795581439561;
        Tue, 24 Nov 2026 20:37:19 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c72sm78614345ad.54.2026.11.24.20.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:37:19 -0800 (PST)
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
Subject: [PATCH v5 1/8] phy: core: Add common helper to add phy phandle device link
Date: Wed, 25 Nov 2026 12:36:32 +0800
Message-ID: <20261125043639.249525-2-inochiama@gmail.com>
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

It is very common for adding a device link for phy phandle
for device managed phy helper functions. So add a common
helper for future reuse.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-core.c | 46 ++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 597e6b234f5e..b7550ca37e66 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -606,6 +606,27 @@ int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 }
 EXPORT_SYMBOL_GPL(phy_validate);
 
+/**
+ * phy_add_device_link() - Associate the phy with the device
+ * @dev: the device consuming the PHY
+ * @phy: the PHY supplied to @dev
+ *
+ * Add a device link with @dev as the consumer and @phy as the
+ * PHY supplier.
+ */
+static void phy_add_device_link(struct device *dev, struct phy *phy)
+{
+	struct device_link *link;
+
+	if (!phy)
+		return;
+
+	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
+	if (!link)
+		dev_dbg(dev, "failed to create device link to %s\n",
+			dev_name(phy->dev.parent));
+}
+
 /**
  * _of_phy_get_with_args() - lookup and obtain a reference to a phy by of_phandle_args
  * @args: of_phandle_args to the phy
@@ -805,7 +826,6 @@ struct phy *phy_get(struct device *dev, const char *string)
 {
 	int index = 0;
 	struct phy *phy;
-	struct device_link *link;
 
 	mutex_lock(&phy_provider_mutex);
 	if (dev->of_node) {
@@ -833,10 +853,7 @@ struct phy *phy_get(struct device *dev, const char *string)
 
 	get_device(&phy->dev);
 
-	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
-	if (!link)
-		dev_dbg(dev, "failed to create device link to %s\n",
-			dev_name(phy->dev.parent));
+	phy_add_device_link(dev, phy);
 
 out_unlock:
 	mutex_unlock(&phy_provider_mutex);
@@ -912,7 +929,6 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 			    const char *con_id)
 {
 	struct phy **ptr, *phy;
-	struct device_link *link;
 
 	ptr = devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
@@ -927,10 +943,7 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 		return phy;
 	}
 
-	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
-	if (!link)
-		dev_dbg(dev, "failed to create device link to %s\n",
-			dev_name(phy->dev.parent));
+	phy_add_device_link(dev, phy);
 
 	return phy;
 }
@@ -982,7 +995,6 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 				     int index)
 {
 	struct phy **ptr, *phy;
-	struct device_link *link;
 
 	ptr = devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
@@ -1006,10 +1018,7 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 	*ptr = phy;
 	devres_add(dev, ptr);
 
-	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
-	if (!link)
-		dev_dbg(dev, "failed to create device link to %s\n",
-			dev_name(phy->dev.parent));
+	phy_add_device_link(dev, phy);
 
 out_unlock:
 	mutex_unlock(&phy_provider_mutex);
@@ -1059,7 +1068,6 @@ EXPORT_SYMBOL_GPL(phy_get_by_of_node);
 struct phy *devm_phy_get_by_of_node(struct device *dev, struct device_node *np)
 {
 	struct phy **ptr, *phy;
-	struct device_link *link;
 
 	ptr = devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
@@ -1073,10 +1081,8 @@ struct phy *devm_phy_get_by_of_node(struct device *dev, struct device_node *np)
 
 	*ptr = phy;
 	devres_add(dev, ptr);
-	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
-	if (!link)
-		dev_dbg(dev, "failed to create device link to %s\n",
-			dev_name(phy->dev.parent));
+
+	phy_add_device_link(dev, phy);
 
 	return phy;
 }
-- 
2.56.1

