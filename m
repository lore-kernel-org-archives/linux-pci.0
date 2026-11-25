Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581444;
	b=XwWjmCLAAQRFk2amFDxjVKKu8+vjbAhZ51xGTM0H5gjeGXzq8X/y1uj+MFBRlqQJE8cM
	 K3mLnnz21vgJ4xOT0iZNNoSbLnSBGXBNzIu8HQalGzOwrPBYxfsH/OhUhBdiApgg7dqOU
	 8VDxz4I0zJqz/EJBeae/RxIJ68SavcbQ+Wp/O5IzWXnbVVXLEJ5Lj97GmDVxjhNic/dN9
	 OEbXTggZPhDQy/z5HRM9L88IBmEsAM3iC6LnguM0VgMUWGiMAyIYFy/csockLfdubiYNP
	 COu+bIkAnrIuknZnF4GPxbeQyThDD3Q5SOv5Hs3Qkp8pBH/5ehpS1U+cyMnKMzZNmjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qTrL4/9jM8t7yAmF2IG8ye/8M/WX8AYVFJWYbaSsj7w=;
	b=drIOMXF0VQUX9KMOhkK+YXV8Fu82j4vpwv4RyriGxa5c6D1xVxsq3jEbNDXJGe/sFfXI
	 AssXu0GOodZinUC1iyGlmYyjr8+H0+RCzvxXlkjHCVfvH4Rz1djUvK1abKkMhGXhFw8hG
	 rrKApcMvgOC7u/eOsCPygbEIJ91RAJ9v6rV+20XFEj6825XJRnKffc3E16aC42qNazD5S
	 9Wzy1sx4yxMD3+0WXUmWFNttisFKBwbQUg4e+/5C+UBm5vzPoAODmqYYUx5sYyqgg/O4L
	 25NSLIb5ZeXmMVftGYb+S6k91XvHi9ehO63gKWn3bPdmZMOcsI9javhwsAS361Vk0Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zl2LdTZJ;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95B7606A32C
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 04:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C95B7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zl2LdTZJ
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b43d30822fso2733437a91.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 20:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581443; x=1796186243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qTrL4/9jM8t7yAmF2IG8ye/8M/WX8AYVFJWYbaSsj7w=;
        b=zl2LdTZJvzjYeXoBL11zTugaiOLJLEwcFS2St1GqlBwLIIg6g32uPC5zkdlTXb3BMt
         2YE+TaHhA9rYBHeHDF4pVtmumcMAtgq8SKAsyRJW4AkFiWuWMCm6SeCqH8zIOJw4ODFm
         1IUwVkIrx0y5RCVw0Pi2TL8dznaDGykq8P4uk64xFAF6zVtryvgXR605Y9fYGKOw39UB
         /zOjk49Krr+7YvtdG1YGcRhqqRO45eyM3p1TBCLN81NMnPCVbz+/2sNE6O7mrv91uPFg
         UkPfq0rFSr2FRsiY6gp4aSv9qzASxCGJXb6p/todkLnag2/d5IkUQ62WNyLiOY50tvfD
         +oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581443; x=1796186243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qTrL4/9jM8t7yAmF2IG8ye/8M/WX8AYVFJWYbaSsj7w=;
        b=HxkJYPZu+K02P+rBYq232Na0gSx0V0piZu48/cqPWG2oyke+yd4mqD6nA7jpbVxfkk
         B8gB504UtfWLr2wnJHxoRVen+OH3fZWOeETgLJE03Jymll6eBggX/2IIXTBE65ShCt78
         x8HJXg9b2LkJF4mnM2nDI5DP3J7pjQbQzUuQ36ROMPYOAvmITTXG6+raCyRrcyI2Lh1o
         gvXXuUfp8Lto6cys5lkpdNOvQGJivc0pShCV6dZRSiA9w+y9h2oSN72E7cksLicL1VlI
         hBLrdypJl6Qo6LERztJF3osNEfAOZqPAaeXjIGDmFoUEErJPZj3OUQ4UX8FXykzPxiAi
         8INg==
X-Forwarded-Encrypted: i=1; AL+hErHdr+RyuHDcZ1B2LOfAocf4INBUrfgUMsUaenXQAA7fsdk2W7EuhpQrtBW+t4kqoSszoAwTR/QE+J0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SrO0lpQlBYKM8ursnhL3KnM84m/dvLPc2jo5tnKCtBcNt/zZG
	TgiCPBoM9/e7KZKsXI8lh0tpctaTdOBi/sFRvN1mODm+vF9c7iNBMJES
X-Gm-Gg: AZFdTZc9xMSYex5r8q7n+QOXWKPqoVSLqRAlgWnHZaxWhpfcude7V9UnV0O1x7lWkfe
	zgBRQFjWpthMgLXgooGYFyKgB8tSPX1RRxX/pIDHpdNfLYNPa1dB06sEBuieDdMJjeyOwj5SH0v
	h5Oau0vIfpzcq1Q2+BpXg5nw3KYG/SUPbkFLfdWLjbUw7yhrr09Ud7DodawPnzC+GHbOjB92GQm
	hn/UH2WElrraQ7HkVPX04hIwrre4lx/BWQmFKGDlGv1qzTJ1DBuK7EIehZ115qheM2ZsVwKF3Sl
	3W+pj6T9faLJBWjjRJGE27m7qAfF4Q88XDux6KjEAoib9IIAXe8mLrd93wlXllBulDX88rU4KkL
	OxO1XHQDxj1bzvpe3A5oZ2wWvsCTDVMMzYKJ7rM2nS6dwBDbyfEeisokDMRGCxNpZ1KNpeNsqtf
	aiMljPyv/w+qNxpeuarOhAFJLgX2Lauj/h2/KOdpjp39oDXt7AhECFhkSo/wbMYoYjvFByhagtO
	IxKQe+sGlnr5NKaiiJ/gP++HOj+0w1dl5DzFQsgh9b20ye2hQFNjzg+oe6mPVXaKKQJhkdxpyyn
	gzBdERK2KYP8/tXx7RVIvITcEJGUUdyrL3b/VjV1uvQBUazd
X-Received: by 2002:a17:90b:4c0b:b0:3b4:12a9:2e1 with SMTP id 98e67ed59e1d1-3b41c931d36mr16931812a91.33.1795581443120;
        Tue, 24 Nov 2026 20:37:23 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm26615594a91.1.2026.11.24.20.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:37:22 -0800 (PST)
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
Subject: [PATCH v5 2/8] phy: core: Add common helper for get phy phandle by index
Date: Wed, 25 Nov 2026 12:36:33 +0800
Message-ID: <20261125043639.249525-3-inochiama@gmail.com>
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

Two phy helpers use index to get phy phandle of a device node,
add a common function for the future reuse.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-core.c | 57 ++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index b7550ca37e66..efbd7e139dce 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -697,38 +697,55 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 	return phy;
 }
 
+/**
+ * _of_phy_get_by_index() - lookup and obtain a reference to a phy using a
+ * device_node by index.
+ * @np: device_node for which to get the phy
+ * @index: index of the phy from device's point of view
+ *
+ * Returns: the phy device, after getting a refcount to it; or
+ * -ENODEV if there is no such phy. The caller is responsible for
+ * calling of_phy_put() to release that count.
+ */
+static struct phy *_of_phy_get_by_index(struct device_node *np, int index)
+{
+	struct phy *phy;
+
+	phy = _of_phy_get(np, index);
+	if (IS_ERR(phy))
+		return phy;
+
+	if (!try_module_get(phy->ops->owner)) {
+		phy = ERR_PTR(-EPROBE_DEFER);
+		return phy;
+	}
+
+	get_device(&phy->dev);
+
+	return phy;
+}
+
 /**
  * of_phy_get() - lookup and obtain a reference to a phy using a device_node.
  * @np: device_node for which to get the phy
  * @con_id: name of the phy from device's point of view
  *
- * Returns: the phy driver, after getting a refcount to it; or
+ * Returns: the phy device, after getting a refcount to it; or
  * -ENODEV if there is no such phy. The caller is responsible for
  * calling of_phy_put() to release that count.
  */
 struct phy *of_phy_get(struct device_node *np, const char *con_id)
 {
-	struct phy *phy = NULL;
+	struct phy *phy;
 	int index = 0;
 
 	if (con_id)
 		index = of_property_match_string(np, "phy-names", con_id);
 
 	mutex_lock(&phy_provider_mutex);
-
-	phy = _of_phy_get(np, index);
-	if (IS_ERR(phy))
-		goto out_unlock;
-
-	if (!try_module_get(phy->ops->owner)) {
-		phy = ERR_PTR(-EPROBE_DEFER);
-		goto out_unlock;
-	}
-
-	get_device(&phy->dev);
-
-out_unlock:
+	phy = _of_phy_get_by_index(np, index);
 	mutex_unlock(&phy_provider_mutex);
+
 	return phy;
 }
 EXPORT_SYMBOL_GPL(of_phy_get);
@@ -1001,20 +1018,12 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 		return ERR_PTR(-ENOMEM);
 
 	mutex_lock(&phy_provider_mutex);
-	phy = _of_phy_get(np, index);
+	phy = _of_phy_get_by_index(np, index);
 	if (IS_ERR(phy)) {
 		devres_free(ptr);
 		goto out_unlock;
 	}
 
-	if (!try_module_get(phy->ops->owner)) {
-		devres_free(ptr);
-		phy = ERR_PTR(-EPROBE_DEFER);
-		goto out_unlock;
-	}
-
-	get_device(&phy->dev);
-
 	*ptr = phy;
 	devres_add(dev, ptr);
 
-- 
2.56.1

