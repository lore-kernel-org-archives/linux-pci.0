Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581454;
	b=cVWpvpaoukJDoXVi/HSehRM7z2ZBRmnuii1NVGcymzw/og0DatNGsUG6Aktf1fR7Po0s
	 XE/zCyIQz8ATLTTQ2poXnKurbq6w6hUahN5xb5huXIJijKFK9GUL1TL6XwjsDkYSOkWcQ
	 qOqlupLmEx2FqpKlmriuCPORR97PHkz9DhA/1gBox8BpP5jHQV/fIhkkDSVrgM+jayx9V
	 Xoac3wHU7LcFus+Iv9D3IJd5EoutGkRNB6ljZ7We1l2ugYPOdYH1VBInuVeLzBjqHqxYA
	 f9TFk7HS+LnK3nFAFfUV10K7LkH+Mp42E2SrX1lFyG8vZHSrR132+t4yT6zanbN1bIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rkE7p4aQLSp2kYV7vRBIkJ3P+8n0i8bdfYVP4ePHIkQ=;
	b=jgg9kNtWlhHTkC3Rhq2gUGe3/OBXE6ziQfooi0QlNoNZeUXFrde+iboZ42boJl85AKWn
	 92CYZ5rQXQSgtYIjMh5Pj7tsKcNWcPhiwsR6euC8ridfqvjOHKkN6jTP8rlFgBpHyVDHa
	 B15Y3rqo+dvon+NEh9lVtmtMxENepviuujLHShBAtGxx2B+QKtgFoB97687ZXnLrtscqO
	 SvmrTC4UlDynh6M/i3uV2KNIyqjoj0cxbRc0gHlQ4+zileUJdCuaPSmDS49G+krdvgrTM
	 W/i8GGvvg1rgefIQyhYbArg9zq1wxZmdORa8EGUDE0ashpbTXaiYe3RCRv3EabNrsEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xTXrqdTe;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2BD606A33F
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 04:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B2BD606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xTXrqdTe
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so3183960b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 20:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581452; x=1796186252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rkE7p4aQLSp2kYV7vRBIkJ3P+8n0i8bdfYVP4ePHIkQ=;
        b=xTXrqdTe+k1Bcn1+GxFlxR2ebQqsRT1M6j+6aYNb9r7mHlRo1fwWLDw4IySXue6Dcl
         KBC1LPnqdZpfI/A+9xmUzotNvieDwV3SMZ4p8tIm9TdJ8zO6mwFBwH3pm3xWXrevrabk
         K2w07uepa6D84x7VWDXgxWsceiGrwKmT0aobivANPe75XkwyR4R4xCcK1XmFWgM9LT2m
         x73zYmJNUkyLBfdibwDMgg04dO2Cn7IXlVfBYXZu8tF152ii0uqWAh3Mhxg0ey3JmFg4
         1fIS8fEaOY7anibxyTO+n5sgar3Ls0+2rGe3zJpPeCBNZofGyNj3rnccEVzZB4wgIeUh
         iCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581452; x=1796186252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rkE7p4aQLSp2kYV7vRBIkJ3P+8n0i8bdfYVP4ePHIkQ=;
        b=m01XCYzu1wIWGuFe2CbrZRCfy6tayrx1DUYfSBedwKgF+SMbhPaxm/vd0RglFePsCP
         mRRLKwSZM0EHIUVznyMD5Q8fLbwOfIvN5/DFgzkbPIgbf5KVOwWm0wJWKuyKircnFPNR
         rFtsd01N9IeyOR+mG9I3MtEIRb2dkqn7/omQzCBTb/mKmpi39P6XwihV+E9pRvJoB3nJ
         z+QbOy7OUKt8Dvxkyl5WCjlKpCg98AGZgeUC6d3k6S34disTlw2Yz2RUyMHvlDsCyEmu
         UNF28XSH4Z77v3R3q8I8aBaOXPeclB7W+So1m+G++n7BMqDQRdTCCLDu7iW2MiyzNZnN
         TfdQ==
X-Forwarded-Encrypted: i=1; AL+hErEaTdfZVJzAZqeLCsMZGt3pkS97kCqpALoBEF5JvOpo3QHXtWdKpIlWSVidnHaDl3dKxMxB7KTiDAc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uADODb6zLHp5ZwZpxej4lU1IAIyw34Qxa7zLg+dgLzbFj6VGm
	QVtaMFl7fghnTP3xfB7XoqRAOatDQioSyo8oyGECpqQfBggUmSH3VaNr
X-Gm-Gg: AZFdTZdvESGM+Dnx+7dfKOzRvfrJ9plj3hUYuiXytMtYHd505o86Uepk4+5gWHE77tA
	PbVr/GDYL12FKhlOSjzP2MdjOLntgAq2GKyYFhKKkQdxGD5cVK26ibG37+sD1JNEgxFQHL9vNhr
	66YjNjqcwE20So00ECJebRzfdqgEVpsYpZGCKZB1BmR7q5Nb0pb1muPrqW3i6RAf5qrUdX3ZEa2
	ZMvSd4KmRJQVWG1vjMz16+lovDjjtNUc86y50280d1g0a4+AXRPbwPJ1hNODvEXv2bUI03PwGH9
	zZR0OIpQd3z3x2jnjZGsY457DwhkFKeFYGobJ/hMy1kUpcbHowU35+wxJaBKgq2NRmFHrrYhQgp
	IHJK/q8QPdfYasZtRUXQYRgfGJFIFOLMOFAL01M77Br5bAD/tfMvV82jKYkzTKCwgeqe1s3pPvi
	BUG8qbnb3snzgmzcJ9yr3PLMQW7LnNpp/9Hl6hDMI8mq1rqkeTPCmInCP4a65n5CBtYso9ZIkGZ
	YpyEioEleZtmzZH8TXaonYBOJosAo9S9z7dWVvbwSG11tFeQ1tU4puzUZcsrsME5tbFazIRJY33
	2IQHVz/Guz8TBmLaW5HWKNDWV0NsZ3DjReVjsbTJ4OyPKpWk
X-Received: by 2002:a05:6a00:4107:b0:89f:ed19:f0ba with SMTP id d2e1a72fcca58-8c7dd9d67bbmr11654419b3a.23.1795581452525;
        Tue, 24 Nov 2026 20:37:32 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1e2f3sm7882825b3a.54.2026.11.24.20.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:37:32 -0800 (PST)
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
Subject: [PATCH v5 5/8] phy: core: Add managed phy bulk data helper functions
Date: Wed, 25 Nov 2026 12:36:36 +0800
Message-ID: <20261125043639.249525-6-inochiama@gmail.com>
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

Add device managed variants of the phy bulk helper functions. So
the driver can benefit from automatically managed phy handles.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/phy/phy-core.c  | 139 ++++++++++++++++++++++++++++++++++++++++
 include/linux/phy/phy.h |  31 +++++++++
 2 files changed, 170 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 87a317a144b4..eeba1b899c20 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -1281,6 +1281,145 @@ static void phy_bulk_put_all(struct device *dev, int num_phys,
 	kfree(phys);
 }
 
+struct phy_bulk_devres {
+	struct phy_bulk_data *phys;
+	int num_phys;
+};
+
+static void devm_phy_bulk_release(struct device *dev, void *res)
+{
+	struct phy_bulk_devres *devres = res;
+
+	phy_bulk_put(dev, devres->num_phys, devres->phys);
+}
+
+/**
+ * devm_phy_bulk_get() - managed lookup of multiple PHYs
+ * @dev: device that requests the PHYs
+ * @num_phys: number of entries in the phys array
+ * @phys: array of struct phy_bulk_data with PHY names set
+ *
+ * Gets the PHYs using phy_bulk_get() and associates the references with
+ * @dev. The references are automatically released on driver detach.
+ *
+ * Return: %0 if successful, a negative error code otherwise
+ */
+int devm_phy_bulk_get(struct device *dev, int num_phys,
+		      struct phy_bulk_data *phys)
+{
+	struct phy_bulk_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_phy_bulk_release, sizeof(*devres),
+			      GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret = phy_bulk_get(dev, num_phys, phys);
+	if (ret) {
+		devres_free(devres);
+		return ret;
+	}
+
+	devres->phys = phys;
+	devres->num_phys = num_phys;
+	devres_add(dev, devres);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_phy_bulk_get);
+
+static int devm_phy_bulk_match(struct device *dev, void *res, void *match_data)
+{
+	struct phy_bulk_devres *devres = res;
+
+	return devres->phys == match_data;
+}
+
+static void devm_phy_bulk_release_all(struct device *dev, void *res)
+{
+	struct phy_bulk_devres *devres = res;
+
+	phy_bulk_put_all(dev, devres->num_phys, devres->phys);
+}
+
+/**
+ * devm_phy_bulk_get_all() - managed lookup of all PHYs requested by a device
+ * @dev: device that requests the PHYs
+ * @phys: pointer to store the allocated array of struct phy_bulk_data
+ *
+ * The function calls devm_of_phy_bulk_get_all() directly, but sets the
+ * @np parameter to dev_of_node(dev).
+ *
+ * Return: the number of PHYs on success, %0 if no PHYs are found, or a
+ * negative error code otherwise
+ */
+int devm_phy_bulk_get_all(struct device *dev, struct phy_bulk_data **phys)
+{
+	return devm_of_phy_bulk_get_all(dev, dev_of_node(dev), phys);
+}
+EXPORT_SYMBOL_GPL(devm_phy_bulk_get_all);
+
+/**
+ * devm_of_phy_bulk_get_all() - managed lookup of all PHYs from a device node
+ * @dev: device that requests the PHYs
+ * @np: device node containing the PHY references
+ * @phys: pointer to store the allocated array of struct phy_bulk_data
+ *
+ * Gets all PHYs from the specified device node, associates the allocated array
+ * and PHY references with @dev, and creates a device link for each PHY. They
+ * are automatically released on driver detach.
+ *
+ * Return: the number of PHYs on success, %0 if no PHYs are found, or a
+ * negative error code otherwise
+ */
+int devm_of_phy_bulk_get_all(struct device *dev, struct device_node *np,
+			     struct phy_bulk_data **phys)
+{
+	struct phy_bulk_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_phy_bulk_release_all, sizeof(*devres),
+			      GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret = of_phy_bulk_get_all(np, &devres->phys);
+	if (ret > 0) {
+		for (int i = 0; i < ret; i++)
+			phy_add_device_link(dev, devres->phys[i].phy);
+		*phys = devres->phys;
+		devres->num_phys = ret;
+		devres_add(dev, devres);
+	} else {
+		devres_free(devres);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_of_phy_bulk_get_all);
+
+/**
+ * devm_phy_bulk_put_all() - release the multiple PHY
+ * @dev: device that wants to release this phy
+ * @phy: the phy bulk data returned by devm_phy_bulk_get_all()
+ *
+ * destroys the devres associated with this phy bulk data and invokes
+ * phy_bulk_put to release the phy.
+ */
+void devm_phy_bulk_put_all(struct device *dev, struct phy_bulk_data *phy)
+{
+	int r;
+
+	if (!phy)
+		return;
+
+	r = devres_release(dev, devm_phy_bulk_release_all,
+			   devm_phy_bulk_match, phy);
+	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
+}
+EXPORT_SYMBOL_GPL(devm_phy_bulk_put_all);
+
 /**
  * phy_bulk_init() - initialize multiple PHYs
  * @num_phys: number of entries in the phys array
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index c170d9aeeeb4..a51b3c283efd 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -326,6 +326,13 @@ void devm_of_phy_provider_unregister(struct device *dev,
 int phy_create_lookup(struct phy *phy, const char *con_id, const char *dev_id);
 void phy_remove_lookup(struct phy *phy, const char *con_id, const char *dev_id);
 
+int devm_phy_bulk_get(struct device *dev, int num_phys,
+		      struct phy_bulk_data *phys);
+int devm_phy_bulk_get_all(struct device *dev, struct phy_bulk_data **phys);
+int devm_of_phy_bulk_get_all(struct device *dev, struct device_node *np,
+			     struct phy_bulk_data **phys);
+void devm_phy_bulk_put_all(struct device *dev, struct phy_bulk_data *phy);
+
 int phy_bulk_init(int num_phys, struct phy_bulk_data *phys);
 int phy_bulk_exit(int num_phys, struct phy_bulk_data *phys);
 int phy_bulk_power_on(int num_phys, struct phy_bulk_data *phys);
@@ -603,6 +610,30 @@ phy_create_lookup(struct phy *phy, const char *con_id, const char *dev_id)
 static inline void phy_remove_lookup(struct phy *phy, const char *con_id,
 				     const char *dev_id) { }
 
+static inline int devm_phy_bulk_get(struct device *dev, int num_phys,
+				    struct phy_bulk_data *phys)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int devm_of_phy_bulk_get_all(struct device *dev,
+					   struct device_node *np,
+					   struct phy_bulk_data **phys)
+{
+	return 0;
+}
+
+static inline int devm_phy_bulk_get_all(struct device *dev,
+					struct phy_bulk_data **phys)
+{
+	return 0;
+}
+
+static inline void devm_phy_bulk_put_all(struct device *dev,
+					 struct phy_bulk_data *phy)
+{
+}
+
 static inline int phy_bulk_init(int num_phys, struct phy_bulk_data *phys)
 {
 	return 0;
-- 
2.56.1

