Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152943B7B84
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718793; cv=none; b=MdDefc5NgRTd+sxcWb5k+SJGiFnDgB7YJBOTV0/jMydZnup7gmwRZe0eQok+98HVLmHg3q/fLhmOTrcxpmCJl8O+OzmoqMDXvD3xp1AgZg8Qh9IETTJoYBpACPK+5mN7Tb+ef32bHPwXheEzlWU3qz6ggzpiHcx+J2ksXlRmm1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718793; c=relaxed/simple;
	bh=8ha6HCuXvqr/g+nFcZIjj8vXsbPeH/dzz3F2cknWwG0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jU4v4Yq9nxjLMQPPKI1HvVqCCOZ08ECyhbUpIGe3ci6VbzsKwg2+vAuNSygSsRQAT41wX/9qzgbXXwtsmHYGCE65ki9B09G86GGUDLKKm5oNKkt/2QPsFk9IRXRGrmUwyEelecesBe0tJGW9TGudTYMCn22z7XHahCHSoixM2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fs+/N9/W; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fs+/N9/W"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-848860def2cso474413b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718788; x=1784323588; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=57QfbJnRLtEgyk7xuyEyKOzrYVcCZwar9BStEh/xugM=;
        b=fs+/N9/Wpm8mUn70rLOJvP0k6xqlIwlUzqH5Bk1FRF3vxK4599AH+ioytasO6f6SKr
         2GK8kVZhtL53lE2asmNftM2mRa3nhEf1F+lYtRnPjVK/k9cjWytqWuVrrEwCwqbG/RYH
         y/KERnzMleqPYRFqCQZKY8NjG+qWvC2wSfd68KSTZwrAU00CpjfwPrMouZQ54LH2czLu
         2HYmrgmfcxzb2i9EF+Le8O7Xz3RWj2/vXFqCQJYasxp+lbwEIttyNIf5BtlNyuisQmAU
         AiXH+0Ft2FPMCb5vao3Sg1Z1OxKI42MGsVQn7Id+5wDgvMzCN0F8YUFGEMX5C75Es0xA
         w1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718788; x=1784323588;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=57QfbJnRLtEgyk7xuyEyKOzrYVcCZwar9BStEh/xugM=;
        b=UOftBMo/WlIoGLGbIVhQcWLG5HjzApoMvfklk6eKIIS2dzcsUAAbCWBf6O9KqfYWGx
         GZHN/KVeMgDjAqRMjVHAmlpulzOdmW7giROiE+LzlUSfaM5vFbFMjeBbmjNorRS0CTUA
         tB0T5BPb0q8iJY+Itx7/f63znh5sb1ov++S1EQbJrodnDyWMa1360wEm4V6sG9FBcRkO
         DAeqN5d/kQDgDhsu8rw9WEb9XkKZ09CBWRnL7jtNZTuT2qnPQEJdBl0M2tCzDMm1UhZq
         zGtmsVlBPU2YvTkr9v4DUR22R08ZP9w/PRQUhISl9BtQvkWHQzIufRJRZMXUklS83oKL
         Htzg==
X-Forwarded-Encrypted: i=1; AHgh+RpexxU7ELcyGwkD7cCJtAfNrzAAG8SZskSZmb5LVJ+BQ0ywMzeVj++xJ5uAU3QZS8QLAcFpFk04OLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp9Cj5Xmf6nFuUduZb7RXPTV9csaeugaoerFrD3+9/r5BJOlZa
	btnjKHKaVkn/AuDm7iT4Veh9WnA6cyjE5UzoOriV/WhuibiKD67i6uyJlGkDKvRZoxbtH5wE9FF
	HauwPPMqkX5TepQ==
X-Received: from pfbhm2.prod.google.com ([2002:a05:6a00:6702:b0:847:9cc9:a40d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:450f:b0:848:2f71:b65b with SMTP id d2e1a72fcca58-848897d5cc1mr570948b3a.70.1783718788088;
 Fri, 10 Jul 2026 14:26:28 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:09 +0000
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-7-dmatlack@google.com>
Subject: [PATCH v7 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

When a PCI device is preserved across a Live Update, all of its upstream
bridges up to the root port must also be preserved. This enables the PCI
core and any drivers bound to the bridges to manage bridges correctly
across a Live Update.

Notably, this will be used in subsequent commits to ensure that
preserved devices can continue performing memory transactions without a
disruption or change in routing.

To preserve bridges, the PCI core tracks the number of downstream
devices preserved under each bridge using a reference count in struct
pci_dev_ser. This allows a bridge to remain preserved until all its
downstream preserved devices are unpreserved or finish their
participation in the Live Update.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c    | 136 +++++++++++++++++++++++++++++++-----
 include/linux/kho/abi/pci.h |   5 +-
 2 files changed, 122 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index b2b950d71657..7f7710cb1da0 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -101,6 +101,18 @@
  * If a misconfigured or unconfigured bridge is encountered during enumeration
  * while there are preserved devices, its secondary and subordinate bus numbers
  * will be cleared and devices below it will not be enumerated.
+ *
+ * PCI-to-PCI Bridges
+ * ==================
+ *
+ * Any PCI-to-PCI bridges upstream of a preserved device are automatically
+ * preserved when the device is preserved. The PCI core keeps track of the
+ * number of downstream devices that are preserved under a bridge so that the
+ * bridge is only unpreserved once all downstream devices are unpreserved.
+ *
+ * This enables the PCI core and any drivers bound to the bridge to participate
+ * in the Live Update so that preserved endpoints can continue issuing memory
+ * transactions during the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
@@ -316,28 +328,52 @@ static struct pci_dev_ser *pci_get_empty_or_append(struct pci_flb_outgoing *outg
 	return dev_ser;
 }
 
-static void pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
+static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
 {
 	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
 
 	if (!dev_ser) {
 		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
-		return;
+		return -EINVAL;
+	}
+
+	if (!dev_ser->refcount) {
+		pci_WARN(dev, 1, "Preserved device has a 0 refcount!\n");
+		return -EINVAL;
 	}
 
+	if (--dev_ser->refcount)
+		return 0;
+
 	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
 	outgoing->ser->nr_devices--;
 	memset(dev_ser, 0, sizeof(*dev_ser));
 	dev->liveupdate.outgoing = NULL;
+	return 0;
 }
 
-static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
+static int pci_liveupdate_preserve_device_again(struct pci_dev *dev)
 {
-	struct pci_dev_ser *dev_ser;
+	if (!dev->liveupdate.outgoing->refcount) {
+		pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
+		return -EINVAL;
+	}
 
-	if (dev->liveupdate.outgoing)
+	/*
+	 * Endpoint devices should not be preserved more than once. Bridges are
+	 * preserved once for every downstream device that is preserved.
+	 */
+	if (!dev->subordinate)
 		return -EBUSY;
 
+	dev->liveupdate.outgoing->refcount++;
+	return 0;
+}
+
+static int __pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser;
+
 	dev_ser = pci_get_empty_or_append(outgoing);
 	if (IS_ERR(dev_ser))
 		return PTR_ERR(dev_ser);
@@ -354,6 +390,52 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, str
 	return 0;
 }
 
+static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
+{
+	if (dev->liveupdate.outgoing)
+		return pci_liveupdate_preserve_device_again(dev);
+
+	return __pci_liveupdate_preserve_device(outgoing, dev);
+}
+
+#define for_each_pci_dev_in_path(_d, _start, _end) \
+	for ((_d) = (_start); (_d) != (_end); (_d) = (_d)->bus->self)
+
+static void __pci_liveupdate_unpreserve_path(struct pci_flb_outgoing *outgoing,
+					     struct pci_dev *start,
+					     struct pci_dev *end)
+{
+	struct pci_dev *dev;
+
+	for_each_pci_dev_in_path(dev, start, end) {
+		if (pci_liveupdate_unpreserve_device(outgoing, dev))
+			return;
+	}
+}
+
+static void pci_liveupdate_unpreserve_path(struct pci_flb_outgoing *outgoing,
+					   struct pci_dev *start)
+{
+	__pci_liveupdate_unpreserve_path(outgoing, start, /*end=*/NULL);
+}
+
+static int pci_liveupdate_preserve_path(struct pci_flb_outgoing *outgoing,
+					struct pci_dev *start)
+{
+	struct pci_dev *dev;
+	int ret;
+
+	for_each_pci_dev_in_path(dev, start, NULL) {
+		ret = pci_liveupdate_preserve_device(outgoing, dev);
+		if (ret) {
+			__pci_liveupdate_unpreserve_path(outgoing, start, dev);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * pci_liveupdate_preserve() - Preserve a PCI device across Live Update
  * @dev: The PCI device to preserve.
@@ -363,6 +445,9 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, str
  * pci_liveupdate_preserve() from their struct liveupdate_file_handler
  * preserve() callback to ensure the outgoing struct pci_ser is already set up.
  *
+ * pci_liveupdate_preserve() automatically preserves all bridges upstream of
+ * @dev.
+ *
  * Returns: 0 on success, <0 on failure.
  */
 int pci_liveupdate_preserve(struct pci_dev *dev)
@@ -378,7 +463,7 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
 	if (IS_ERR(outgoing))
 		return PTR_ERR(outgoing);
 
-	return pci_liveupdate_preserve_device(outgoing, dev);
+	return pci_liveupdate_preserve_path(outgoing, dev);
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
 
@@ -391,6 +476,9 @@ EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
  * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
  * unpreserve() callback to ensure the outgoing struct pci_ser is already set
  * up.
+ *
+ * pci_liveupdate_unpreserve() automatically unpreserves all bridges upstream of
+ * @dev.
  */
 void pci_liveupdate_unpreserve(struct pci_dev *dev)
 {
@@ -404,7 +492,7 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
 		return;
 	}
 
-	pci_liveupdate_unpreserve_device(outgoing, dev);
+	pci_liveupdate_unpreserve_path(outgoing, dev);
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
 
@@ -594,29 +682,41 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 	}
 }
 
-static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
+static int pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
 {
 	if (!dev->liveupdate.incoming) {
 		pci_warn(dev, "Cannot finish preserving an unpreserved device\n");
-		return;
+		return -EINVAL;
 	}
 
-	if (dev->liveupdate.incoming->refcount != 1) {
-		pci_WARN(dev, 1, "Preserved device has a corrupted refcount!\n");
-		return;
+	if (!dev->liveupdate.incoming->refcount) {
+		pci_WARN(dev, 1, "Preserved device has a 0 refcount!\n");
+		return -EINVAL;
 	}
 
 	/*
-	 * Drop the refcount so this device does not get treated as an incoming
-	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
-	 * again because the device is hot-plugged.
+	 * Decrement the refcount so this device does not get treated as an
+	 * incoming device again, e.g. in case pci_liveupdate_setup_device()
+	 * gets called again because the device is hot-plugged.
 	 */
-	dev->liveupdate.incoming->refcount = 0;
+	if (--dev->liveupdate.incoming->refcount)
+		return 0;
 
 	pci_info(dev, "Device is finished participating in Live Update\n");
 	dev->liveupdate.incoming = NULL;
 	ser->nr_devices--;
 	pci_liveupdate_flb_put_incoming();
+	return 0;
+}
+
+static void pci_liveupdate_finish_path(struct pci_ser *ser, struct pci_dev *start)
+{
+	struct pci_dev *dev;
+
+	for_each_pci_dev_in_path(dev, start, NULL) {
+		if (pci_liveupdate_finish_device(ser, dev))
+			return;
+	}
 }
 
 /**
@@ -628,6 +728,8 @@ static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *de
  * Update. Drivers must call pci_liveupdate_finish() from their struct
  * liveupdate_file_handler finish() callback to ensure the incoming struct
  * pci_ser is allocated.
+ *
+ * pci_liveupdate_finish() automatically finishes all bridges upstream of @dev.
  */
 void pci_liveupdate_finish(struct pci_dev *dev)
 {
@@ -641,7 +743,7 @@ void pci_liveupdate_finish(struct pci_dev *dev)
 		return;
 	}
 
-	pci_liveupdate_finish_device(incoming->ser, dev);
+	pci_liveupdate_finish_path(incoming->ser, dev);
 	pci_liveupdate_flb_put_incoming();
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index de549016807a..acf1b38dff02 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -23,7 +23,7 @@
  * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
  */
 
-#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
+#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
 
 /**
  * struct pci_dev_ser - Serialized state about a single PCI device.
@@ -32,7 +32,8 @@
  * @bdf: The device's PCI bus, device, and function number.
  * @refcount: Reference count used by the PCI core to keep track of whether it
  *            is done using a device's struct pci_dev_ser. The value of the
- *            refcount is equal to 1 when the struct pci_dev_ser is in use, and
+ *            refcount is equal to the number of preserved devices at or below
+ *            it in the PCI hierarchy when the struct pci_dev_ser is in use, and
  *            0 otherwise.
  */
 struct pci_dev_ser {
-- 
2.55.0.795.g602f6c329a-goog

