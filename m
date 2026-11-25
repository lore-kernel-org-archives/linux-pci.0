Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581451;
	b=IaI95PDgjXS4k5SDmIaZt2+AtEbF6szbQSUnuqJ0hw8xl5JhyeS/sKTPOshKoWiXm3+i
	 EdeLARQv0PWOrIV/vEKxF0QuK5X48Y38Q1EDTGP8x4vqJJcPHyohaQkVBJKaq6PUn21dw
	 ZqqC7QSIupU5Yoao5Abg4oo7znl6Plo+o8oF5FodcrkOkJ+YlCX9NlrTfqeQEso2MLdR2
	 UCIdx8706rCvetLYljpb+TOG+dS82fYgfGLIdKw5YGuXzVL9FBual6BKJ2/E7h7JkRXaH
	 4JptqVDJcCd436ypaR8AADrSyNm3V1rFL5cWSYlyG7PnNXN+mTwgqlBZZF+1KScZ/FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yC0KWfjZslDYmreM0nokc8PEJN6eo4m1n8xq79uDONU=;
	b=MzXij/jETzafbS7VQWhfEpO6BMPFma3nD4Ab7wig7FJzSpDCN5a2lMAupHjvswOcZ4D1
	 TiyZGIIC6Cb6fV1vgZavjXjNs3nfsA4jBFWU48cJkb3qcVTc7FqTIb+ivY+gaHabxiT6a
	 jtnkpuPmGEiBzN3PhMun54QEJKBBJCCCSG214TjM7/zQKgbG+hs8DQzpHmhsOj7fbzZ+4
	 v81JYd2RyvTs9A7lZj1q9U3gaZ57SxzCMcKVEIbs+J/qoSxAPkgs3Ma1nuRIdPj95+ubU
	 +ihwFI9pgENTggIEy3z9JB5lacZax6/VfRYcg4PY3isvaK9+9MqSgXgG/+6QgOShsiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CjRA8qJ7;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1206F606A336
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 04:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1206F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CjRA8qJ7
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so2527866b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 20:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581449; x=1796186249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yC0KWfjZslDYmreM0nokc8PEJN6eo4m1n8xq79uDONU=;
        b=CjRA8qJ7RYOWPXeIYjsJqOiBD695MOm3bxmT1B4tJEin370eoEN4vl60a2unAOB4h4
         d1eaag1o4FaFJfF50gDsloXKFTNrNcte5+mBY2MddHm0hMoqMbYa7RLZNBvYFkjmv3+5
         hVMu0tE9tS2IdfjcnXyvWjxOXpZIxQpqpiBgXP0Tnr5sHeG8WVc7pEZbMwIAYa76+T7x
         zm9lJyXL9QTcQFRTqYHn3NmFnwHvpWbxSbQ53AKXP78KEiZa6EWXBIf8f8r0TYGFdgZx
         uGM873hN1o5tKDRG2kjazwuD8gdR3nwuboLjUPREtSj+Hw6Tc3/5rXytNcTsz8mUW5Oh
         SDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581449; x=1796186249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yC0KWfjZslDYmreM0nokc8PEJN6eo4m1n8xq79uDONU=;
        b=f/G1yEMQxs2jm3zrjIvK7wzgMqYPFiM9+SYkMyLcxzypK/4xWvH7uhhhzaWmxN0ct1
         RbQPqPvTlJfr7xfPT/i0hUOg2LhRn6yAEEAmE0qwTB9jwXOGymROX7b+9H/qszH7ZJAO
         m68C2X1JyZhJfv1NcfqtWhK983wuiKNUoTpCnap2UIX8Le1gWsCuBNI13Kw9AOJ9t0Wh
         qHF3N1BbhJR5lYNKK4wsfUx+DFi6zwyLDXKRw7DL5Xsah9BQvYtbPEERg6UI73aE+HO4
         SW9PnZSZVW8XoaxJWgKU+rpdE8s8ZFr6mZgtGGr6WrkdmFGnmE9oDEL2wmhSEULm7VzH
         IM5w==
X-Forwarded-Encrypted: i=1; AL+hErE28leho4jIcKEMktwgyGPNSxSdANPhSz5LLruWXaXwXg/8bt83eThiHIoJUTx1+vqdejDUq7CFnjU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oBm0IKjF0cyWlL+NxHv7PFArPRz4fp2c78xWW9ZyiIOyZQC2H
	w5OZLd4iPu86bzFT/bi1GjUdcxAhY7+60VPlvZCzbiFk9Jy3tmE1+5Ml
X-Gm-Gg: AZFdTZeOncT0eohGWv0aqdNaUl81x3cYGLDucxU8qCGF8aqfFLLcrSXHSDCHhSN7tEM
	ZP5ZkiZs15fY+Secm1SYyKOKmrUOKSWvjsksrJhi+4cZ0tuuU1jmJ7Zw9gsED48j54LuhN8D1za
	8HHBd1n+QzATKxL7zFHcnt6S9uQWYBsYBOadyTgAq/dk1TGws5z+TTWWBh9MQkWo3KXqn8RvjRB
	pDdrEjHqvWWidY/Ey6svhxmoMuo2mI2xkH+RC/v+F9RMmkz2aZuWZLTVhzfJ/SQ0TuR5ghcgdcZ
	8qWLCnTxGwDTGIJpCp3FqgNnoAN/ZPJD1qLZNUacKEW+c4EItHhebi7dhBJOKdc+4kHD72IQM5D
	Si2NZnHaDt/GvsnSeQkAKNPALQ8VIOezshCtKQCy8FGD0NhdBj/QEvxttUGUZp51PEzpSg7MeyF
	1LduBk0KdgHoeDg44LdcYDVOjEy3hMy1zVYr8ekXWeDANY1rsbLuknKpx9jMawpuFvk9/iX0/69
	4VD8mLXtkPpMh7HMOTTz+vBynADt9V9G+/biGSeBz9ravOeawoGr1sMRffHd1IuyBgQrUUGr+Rh
	Eso/VUSR6qjXVq7zsU2ToSDtDaE=
X-Received: by 2002:a17:90a:d2cf:b0:3ac:9772:8da3 with SMTP id 98e67ed59e1d1-3b41c8fed4bmr13992683a91.31.1795581449240;
        Tue, 24 Nov 2026 20:37:29 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4b0f482bdsm9985129a91.14.2026.11.24.20.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:37:28 -0800 (PST)
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
Subject: [PATCH v5 4/8] phy: core: Add phy bulk data helper functions
Date: Wed, 25 Nov 2026 12:36:35 +0800
Message-ID: <20261125043639.249525-5-inochiama@gmail.com>
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

Add several helper functions that allow drivers to get several phy
consumers in one operation. If any of the phy cannot be acquired then
any phys that were got will be put before returning to the caller.

This can relieve the driver owners' life who needs to handle many phys,
as well as each phy error reporting.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/phy/phy-core.c  | 301 ++++++++++++++++++++++++++++++++++++++++
 include/linux/phy/phy.h |  38 +++++
 2 files changed, 339 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 5004d28b167a..87a317a144b4 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -1100,6 +1100,307 @@ struct phy *devm_phy_get_by_of_node(struct device *dev, struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(devm_phy_get_by_of_node);
 
+/**
+ * of_phy_get_count() - Get the number of phys of a device node
+ * @np: device_node for which to get the phy
+ *
+ * Return: the phy count if successful, %0 if no phy handle is found,
+ * negative error value if error occurs.
+ */
+static int of_phy_get_count(const struct device_node *np)
+{
+	int count;
+
+	count = of_count_phandle_with_args(np, "phys", "#phy-cells");
+
+	if (count == -ENOENT)
+		return 0;
+
+	return count;
+}
+
+/**
+ * phy_bulk_put() - release a set of PHYs
+ * @dev: device that acquired the PHYs
+ * @num_phys: number of entries in the phys array
+ * @phys: array of struct phy_bulk_data with PHYs set
+ *
+ * Releases the PHY references in reverse order and clears the PHY pointer in
+ * each entry. The caller owns the phys array and is responsible for freeing it
+ * if necessary.
+ */
+static void phy_bulk_put(struct device *dev, int num_phys,
+			 struct phy_bulk_data *phys)
+{
+	while (num_phys--) {
+		phy_put(dev, phys[num_phys].phy);
+		phys[num_phys].phy = NULL;
+	}
+}
+
+/**
+ * of_phy_bulk_put() - release a set of PHYs
+ * @num_phys: number of entries in the phys array
+ * @phys: array of struct phy_bulk_data with PHYs set
+ *
+ * Releases the PHY references in reverse order and clears the PHY pointer in
+ * each entry. The caller owns the phys array and is responsible for freeing it
+ * if necessary.
+ */
+static void of_phy_bulk_put(int num_phys, struct phy_bulk_data *phys)
+{
+	while (num_phys--) {
+		of_phy_put(phys[num_phys].phy);
+		phys[num_phys].phy = NULL;
+	}
+}
+
+static int of_phy_bulk_get_by_index(struct device_node *np, int num_phys,
+				    struct phy_bulk_data *phys)
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < num_phys; i++) {
+		phys[i].id = NULL;
+		phys[i].phy = NULL;
+	}
+
+	mutex_lock(&phy_provider_mutex);
+
+	for (i = 0; i < num_phys; i++) {
+		of_property_read_string_index(np, "phy-names", i, &phys[i].id);
+
+		phys[i].phy = _of_phy_get_by_index(np, i);
+
+		if (IS_ERR(phys[i].phy)) {
+			ret = PTR_ERR(phys[i].phy);
+			break;
+		}
+	}
+
+	mutex_unlock(&phy_provider_mutex);
+
+	if (ret)
+		of_phy_bulk_put(i, phys);
+
+	return ret;
+}
+
+/**
+ * phy_bulk_get() - lookup and obtain references to multiple PHYs
+ * @dev: device that requests the PHYs
+ * @num_phys: number of entries in the phys array
+ * @phys: array of struct phy_bulk_data with PHY names set
+ *
+ * Gets each PHY using phy_get(). This supports both device tree lookups and
+ * non-device-tree lookups registered with phy_create_lookup(). The caller must
+ * call phy_bulk_put() to release the PHY references.
+ *
+ * Return: %0 if successful, a negative error code otherwise
+ */
+static int phy_bulk_get(struct device *dev, int num_phys,
+			struct phy_bulk_data *phys)
+{
+	int ret, i;
+
+	for (i = 0; i < num_phys; i++)
+		phys[i].phy = NULL;
+
+	for (i = 0; i < num_phys; i++) {
+		phys[i].phy = phy_get(dev, phys[i].id);
+
+		ret = PTR_ERR_OR_ZERO(phys[i].phy);
+		if (ret) {
+			phys[i].phy = NULL;
+
+			dev_err_probe(dev, ret, "Failed to get phy: (%s)\n",
+				      phys[i].id);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	phy_bulk_put(dev, i, phys);
+
+	return ret;
+}
+
+/**
+ * of_phy_bulk_get_all() - obtain all PHYs from a device node
+ * @np: device node containing the PHY references
+ * @phys: pointer to store the allocated array of struct phy_bulk_data
+ *
+ * Gets every PHY referenced by the phys property in index order. PHY names are
+ * read from phy-names when present.
+ *
+ * Return: the number of PHYs on success, %0 if no PHYs are found, or a
+ * negative error code otherwise
+ */
+static int of_phy_bulk_get_all(struct device_node *np,
+			       struct phy_bulk_data **phys)
+{
+	struct phy_bulk_data *phy_bulk;
+	int num_phys;
+	int ret;
+
+	num_phys = of_phy_get_count(np);
+	if (num_phys <= 0)
+		return num_phys;
+
+	phy_bulk = kmalloc_objs(*phy_bulk, num_phys);
+	if (!phy_bulk)
+		return -ENOMEM;
+
+	ret = of_phy_bulk_get_by_index(np, num_phys, phy_bulk);
+	if (ret) {
+		kfree(phy_bulk);
+		return ret;
+	}
+
+	*phys = phy_bulk;
+
+	return num_phys;
+}
+
+/**
+ * phy_bulk_put_all() - release and free PHYs
+ * @dev: device that acquired the PHYs
+ * @num_phys: number of entries in the phys array
+ * @phys: array of struct phy_bulk_data to release and free
+ */
+static void phy_bulk_put_all(struct device *dev, int num_phys,
+			     struct phy_bulk_data *phys)
+{
+	if (IS_ERR_OR_NULL(phys))
+		return;
+
+	phy_bulk_put(dev, num_phys, phys);
+	kfree(phys);
+}
+
+/**
+ * phy_bulk_init() - initialize multiple PHYs
+ * @num_phys: number of entries in the phys array
+ * @phys: array of struct phy_bulk_data to initialize
+ *
+ * Initializes the PHYs in array order. If an initialization fails, all PHYs
+ * initialized by this call are exited in reverse order.
+ *
+ * Return: %0 if successful, a negative error code otherwise
+ */
+int phy_bulk_init(int num_phys, struct phy_bulk_data *phys)
+{
+	int ret, i;
+
+	for (i = 0; i < num_phys; i++) {
+		ret = phy_init(phys[i].phy);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	while (i--)
+		phy_exit(phys[i].phy);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_bulk_init);
+
+/**
+ * phy_bulk_exit() - exit multiple PHYs
+ * @num_phys: number of entries in the phys array
+ * @phys: array of struct phy_bulk_data to exit
+ *
+ * Exits the PHYs in reverse array order. If error occurs, all exited
+ * phys are inited again.
+ *
+ * Return: %0 if successful, or negative error code if one fails.
+ */
+int phy_bulk_exit(int num_phys, struct phy_bulk_data *phys)
+{
+	int ret, i;
+
+	for (i = num_phys - 1; i >= 0; i--) {
+		ret = phy_exit(phys[i].phy);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	while (++i < num_phys)
+		phy_init(phys[i].phy);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_bulk_exit);
+
+/**
+ * phy_bulk_power_on() - power on multiple PHYs
+ * @num_phys: number of entries in the phys array
+ * @phys: array of struct phy_bulk_data to power on
+ *
+ * Powers on the PHYs in array order. If a power-on operation fails, all PHYs
+ * powered on by this call are powered off in reverse order.
+ *
+ * Return: %0 if successful, or negative error code if one fails.
+ */
+int phy_bulk_power_on(int num_phys, struct phy_bulk_data *phys)
+{
+	int ret, i;
+
+	for (i = 0; i < num_phys; i++) {
+		ret = phy_power_on(phys[i].phy);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	while (i--)
+		phy_power_off(phys[i].phy);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_bulk_power_on);
+
+/**
+ * phy_bulk_power_off() - power off multiple PHYs
+ * @num_phys: number of entries in the phys array
+ * @phys: array of struct phy_bulk_data to power off
+ *
+ * Power off the PHYs in reverse order. If a powers off fails, already
+ * power-off phys are powered on again.
+ *
+ * Return: %0 if successful, the first negative error code otherwise
+ */
+int phy_bulk_power_off(int num_phys, struct phy_bulk_data *phys)
+{
+	int ret, i;
+
+	for (i = num_phys - 1; i >= 0; i--) {
+		ret = phy_power_off(phys[i].phy);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	while (++i < num_phys)
+		phy_power_on(phys[i].phy);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_bulk_power_off);
+
 /**
  * phy_create() - create a new phy
  * @dev: device that is creating the new phy
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index c480d6cb42c5..c170d9aeeeb4 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -83,6 +83,18 @@ union phy_configure_opts {
 	struct phy_configure_opts_hdmi		hdmi;
 };
 
+/**
+ * struct phy_bulk_data - Data used for bulk phy operations.
+ *
+ * @id: phy consumer ID
+ */
+struct phy_bulk_data {
+	const char	*id;
+
+	/* private: Internal use */
+	struct phy	*phy;
+};
+
 /**
  * struct phy_ops - set of function pointers for performing phy operations
  * @init: operation to be performed for initializing phy
@@ -313,6 +325,12 @@ void devm_of_phy_provider_unregister(struct device *dev,
 	struct phy_provider *phy_provider);
 int phy_create_lookup(struct phy *phy, const char *con_id, const char *dev_id);
 void phy_remove_lookup(struct phy *phy, const char *con_id, const char *dev_id);
+
+int phy_bulk_init(int num_phys, struct phy_bulk_data *phys);
+int phy_bulk_exit(int num_phys, struct phy_bulk_data *phys);
+int phy_bulk_power_on(int num_phys, struct phy_bulk_data *phys);
+int phy_bulk_power_off(int num_phys, struct phy_bulk_data *phys);
+
 #else
 static inline int phy_pm_runtime_get(struct phy *phy)
 {
@@ -584,6 +602,26 @@ phy_create_lookup(struct phy *phy, const char *con_id, const char *dev_id)
 }
 static inline void phy_remove_lookup(struct phy *phy, const char *con_id,
 				     const char *dev_id) { }
+
+static inline int phy_bulk_init(int num_phys, struct phy_bulk_data *phys)
+{
+	return 0;
+}
+
+static inline int phy_bulk_exit(int num_phys, struct phy_bulk_data *phys)
+{
+	return 0;
+}
+
+static inline int phy_bulk_power_on(int num_phys, struct phy_bulk_data *phys)
+{
+	return 0;
+}
+
+static inline int phy_bulk_power_off(int num_phys, struct phy_bulk_data *phys)
+{
+	return 0;
+}
 #endif
 
 #endif /* __DRIVERS_PHY_H */
-- 
2.56.1

