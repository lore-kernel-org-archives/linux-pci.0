Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C3492E26
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762021; cv=none; b=MMPO5PD+RWOKQdlJVb7vB+cHk6NqndPswHdlaE9v9y7KQ7pVQCpAczagrWZO7EbJ4Pm32Z7J81g/ojvioUfM4otGY4+VssMRYcOxZMQvADiVx/L+O+ocYlkCP37MjvcXxSnWYHMPDs/In3XHUfjQK96zHJTv0rjeDnRbRzZkdmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762021; c=relaxed/simple;
	bh=zWFlXN9OGp6An+xWtdjWA3hJp9SS26McmEz7RkrDzIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mwuasAAH/oskOhRXdzj5WwrFVTAPPRkfUJ1e8i9L6tAt7TwuFTBpRv/fnW/IVxKuL9hLGPmK4KXyv2rCD4rgOHh+AzVGr99Xw9FCgqiQGYnVuhsI/QTUsqja3MByd1spzpdl5/vAPg7HOcNmYCATVIX/OUipBTjwUmLX3F6qyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/eTdbBU; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/eTdbBU"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db3d832827so14515815ad.2
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 13:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789762018; x=1790366818; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YSbW92ll6VraodQnupXl7opG78OubPyViHFwv8TLCbk=;
        b=H/eTdbBUmfWlqe61AyyzifkSwCAmCcIkJj5ZmPeNuSMpClCwIvvnw47aY00gvl0CvI
         Ect9G8CTrp59iBGHunk3B1eGT/pveoHTNRGb7BA5Q2UJYP1euPeu8cXUmpQk3x3+Pyfn
         S5QBMBKQe+2NYjJ18jfWxmLGKA8KL85r8wtY7O/5cEhVqG9CHm5qKCYQC5y+In5oEIpF
         +N0dqq6RZF5W7BAAf3/Qf103ZSmmJItMlsy/HnZdClD2Hb4WRRxWh8uoTTO6m+4F2nQJ
         Rpa+h6iqWIzE5GzIGLCZoTNhbEcK4QZXWD7QAyPkRjkvg6c9goDMVlaoA8QYncwLWvqE
         owRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789762018; x=1790366818;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YSbW92ll6VraodQnupXl7opG78OubPyViHFwv8TLCbk=;
        b=BzXIbZSSz1XhMhwqOktFTBvi26x71uf1rKoRcfAO6/AqIEtziaEusRLE/URbY54iA2
         ttvUIwbo+jQ4sDL02Ot0z5ijqriPg/6AoSNv2n4rqNQjMM5P5ANMMU+DnWypiujqc1qs
         GolF80JpKPGRcqH6YZom9+IINwvLeXcNLYzwg4n/cqoBXDo4AGPaA/aamRhDKMxOyPhX
         v6SQVVD2omKX241UJKQHEpww4Uh1wydCnw7zFFFUYNbAu7HHvTFa5zPZMibInKZ8LRVN
         C9ewkFTO+hXmWgf5hibPavKFqbMC20kGi0sFbCZJ3L4pc77M1/MKi0kpC2hnbKtUzre0
         gNxg==
X-Forwarded-Encrypted: i=1; AKwUvByfhvOB/TRewEUlFLbXZMh549zA+GhuE5rJ7Biuy+m7X4ewPa9VvaIfrxfFwfiB2+Vf0ZqyjNUmzp0=@vger.kernel.org
X-Gm-Message-State: AFuF++nRlTiPDVQpVRl4rgEFvMSzuueLmxZsdGRRS0gB5Pv85uBsXqDp
	0VJviES74FpKc1Fp851j34z2lOJyJLm4sOcQRqL7s5fmOICQtk6TMNcwtx4dlAYtmihqlZpRtRQ
	BTIlhOonbEsP36A==
X-Received: from pgbcn9.prod.google.com ([2002:a05:6a02:a89:b0:cc1:be9e:35ef])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4b28:b0:2dd:c100:a5e7 with SMTP id d9443c01a7336-2ddc100a6e5mr8872815ad.59.1789762018048;
 Fri, 18 Sep 2026 13:06:58 -0700 (PDT)
Date: Fri, 18 Sep 2026 20:06:31 +0000
In-Reply-To: <20260918200640.887030-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918200640.887030-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918200640.887030-6-dmatlack@google.com>
Subject: [PATCH v9 05/13] PCI: liveupdate: Auto-preserve upstream bridges
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
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
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

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c    | 125 +++++++++++++++++++++++++++---------
 include/linux/kho/abi/pci.h |   5 +-
 include/linux/pci.h         |   3 +
 3 files changed, 99 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index ec8db86ed66d..825df024eec4 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -122,7 +122,6 @@
  * preserved. These may be relaxed in the future:
  *
  *  * The device cannot be a Virtual Function (VF).
- *  * The device cannot be behind a PCI-to-PCI bridge.
  *
  * Driver Binding
  * ==============
@@ -137,6 +136,18 @@
  * bound to the correct driver. The PCI core does not protect against a device
  * getting preserved by driver A in the outgoing kernel and then getting bound
  * to driver B in the incoming kernel.
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
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -407,55 +418,84 @@ static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoi
 	return dev_ser;
 }
 
-static void pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
-					     struct pci_dev *dev)
+static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
+					    struct pci_dev *dev)
 {
 	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
 
 	if (!dev_ser) {
 		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
-		return;
+		return -EINVAL;
 	}
 
+	if (!dev_ser->refcount) {
+		pci_WARN(dev, 1, "Preserved device has a 0 refcount!\n");
+		return -EINVAL;
+	}
+
+	if (--dev_ser->refcount)
+		return 0;
+
 	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
 	outgoing->ser->nr_devices--;
 	memset(dev_ser, 0, sizeof(*dev_ser));
 	dev->liveupdate.outgoing = NULL;
+	return 0;
+}
+
+static void pci_liveupdate_unpreserve_path(struct pci_flb_outgoing *outgoing,
+					   struct pci_dev *dev,
+					   struct pci_dev *end)
+{
+	for_each_pci_dev_in_path(dev) {
+		if (dev == end)
+			break;
+
+		if (pci_liveupdate_unpreserve_device(outgoing, dev))
+			return;
+	}
 }
 
 static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 					  struct pci_dev *dev)
 {
-	struct pci_dev_ser *dev_ser;
-
 	if (dev->is_virtfn) {
 		pci_warn(dev, "Cannot preserve Virtual Functions\n");
 		return -EINVAL;
 	}
 
-	if (dev->liveupdate.outgoing) {
+	/*
+	 * Endpoint devices should not be preserved more than once.
+	 * Bridges are preserved once for every downstream device that
+	 * is preserved.
+	 */
+	if (dev->liveupdate.outgoing && !dev->subordinate) {
 		pci_warn(dev, "Device is already preserved\n");
 		return -EBUSY;
 	}
 
-	if (!pci_is_root_bus(dev->bus)) {
-		pci_warn(dev, "Cannot preserve devices behind bridges\n");
+	if (dev->liveupdate.outgoing && !dev->liveupdate.outgoing->refcount) {
+		pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
 		return -EINVAL;
 	}
 
-	dev_ser = pci_flb_alloc_dev_ser(outgoing);
-	if (IS_ERR(dev_ser))
-		return PTR_ERR(dev_ser);
+	if (!dev->liveupdate.outgoing) {
+		struct pci_dev_ser *dev_ser;
 
-	pci_info(dev, "Device will be preserved across next Live Update\n");
-	outgoing->ser->nr_devices++;
-	outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
+		dev_ser = pci_flb_alloc_dev_ser(outgoing);
+		if (IS_ERR(dev_ser))
+			return PTR_ERR(dev_ser);
 
-	dev_ser->domain = pci_domain_nr(dev->bus);
-	dev_ser->bdf = pci_dev_id(dev);
-	dev_ser->refcount++;
+		pci_info(dev, "Device will be preserved across next Live Update\n");
+		outgoing->ser->nr_devices++;
+		outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
+
+		dev_ser->domain = pci_domain_nr(dev->bus);
+		dev_ser->bdf = pci_dev_id(dev);
+		dev->liveupdate.outgoing = dev_ser;
+	}
 
-	dev->liveupdate.outgoing = dev_ser;
+	dev->liveupdate.outgoing->refcount++;
 	return 0;
 }
 
@@ -468,12 +508,16 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
  * pci_liveupdate_preserve() from their struct liveupdate_file_handler
  * preserve() callback to ensure the outgoing struct pci_ser is already set up.
  *
+ * pci_liveupdate_preserve() automatically preserves all bridges upstream of
+ * @dev.
+ *
  * Returns: 0 on success, <0 on failure.
  */
 int pci_liveupdate_preserve(struct pci_dev *dev)
 {
 	struct pci_flb_outgoing *outgoing = NULL;
-	int ret;
+	struct pci_dev *start = dev;
+	int ret = -ENODEV;
 
 	guard(rwsem_write)(&pci_liveupdate.rwsem);
 
@@ -481,7 +525,13 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
 	if (IS_ERR(outgoing))
 		return PTR_ERR(outgoing);
 
-	ret = pci_liveupdate_preserve_device(outgoing, dev);
+	for_each_pci_dev_in_path(dev) {
+		ret = pci_liveupdate_preserve_device(outgoing, dev);
+		if (ret) {
+			pci_liveupdate_unpreserve_path(outgoing, start, dev);
+			break;
+		}
+	}
 
 	pci_liveupdate_flb_put_outgoing();
 	return ret;
@@ -497,6 +547,9 @@ EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
  * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
  * unpreserve() callback to ensure the outgoing struct pci_ser is already set
  * up.
+ *
+ * pci_liveupdate_unpreserve() automatically unpreserves all bridges upstream of
+ * @dev.
  */
 void pci_liveupdate_unpreserve(struct pci_dev *dev)
 {
@@ -510,7 +563,7 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
 		return;
 	}
 
-	pci_liveupdate_unpreserve_device(outgoing, dev);
+	pci_liveupdate_unpreserve_path(outgoing, dev, /*end=*/NULL);
 	pci_liveupdate_flb_put_outgoing();
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
@@ -600,28 +653,30 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
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
+	return 0;
 }
 
 /**
@@ -633,6 +688,8 @@ static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *de
  * Update. Drivers must call pci_liveupdate_finish() from their struct
  * liveupdate_file_handler finish() callback to ensure the incoming struct
  * pci_ser is allocated.
+ *
+ * pci_liveupdate_finish() automatically finishes all bridges upstream of @dev.
  */
 void pci_liveupdate_finish(struct pci_dev *dev)
 {
@@ -646,7 +703,11 @@ void pci_liveupdate_finish(struct pci_dev *dev)
 		return;
 	}
 
-	pci_liveupdate_finish_device(incoming->ser, dev);
+	for_each_pci_dev_in_path(dev) {
+		if (pci_liveupdate_finish_device(incoming->ser, dev))
+			break;
+	}
+
 	pci_liveupdate_flb_put_incoming();
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index 4096e3cd3324..9485ed73c351 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -24,7 +24,7 @@
  */
 
 #define PCI_LUO_FLB_COMPATIBLE "pci"
-#define PCI_LUO_FLB_VERSION 1
+#define PCI_LUO_FLB_VERSION 2
 
 /**
  * struct pci_dev_ser - Serialized state about a single PCI device.
@@ -33,7 +33,8 @@
  * @bdf: The device's PCI bus, device, and function number.
  * @refcount: Reference count used by the PCI core to keep track of whether it
  *            is done using a device's struct pci_dev_ser. The value of the
- *            refcount is equal to 1 when the struct pci_dev_ser is in use, and
+ *            refcount is equal to the number of preserved devices at or below
+ *            it in the PCI hierarchy when the struct pci_dev_ser is in use, and
  *            0 otherwise.
  */
 struct pci_dev_ser {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 76abe884e3dc..b35ac263c451 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -836,6 +836,9 @@ static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 	return dev->bus->self;
 }
 
+#define for_each_pci_dev_in_path(dev) \
+	for (; dev; dev = pci_upstream_bridge(dev))
+
 #ifdef CONFIG_PCI_MSI
 static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev)
 {
-- 
2.55.0.1082.g2b9226bbc0-goog

