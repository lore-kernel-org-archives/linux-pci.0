Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB7351B197
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908744; cv=none; b=Opvc2tckXbtDf/LNThH0N+/0fRXpL6rWqpaoGGoctF+hiN+p3LjuNI6LvVz5qhrUiYIREC6avJ7J2gqsgBY3KGGChKJJW1BLHWge7EMbSFpPWtEA5cD/JrRxzESPe9CSs8iYh3gAk1KbKbFR3CiDVWqipjSixEKK+1JV+dRTWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908744; c=relaxed/simple;
	bh=NmOhM5Aq3jdvC3jY0YwCxZmkHw7m55l48tlT3k+uc7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kCqF7y4msogV7gY8MHNCijnlQWHHi6KOW2sdzJWb88PuQmgAr3KnXaWJtWwkQnyMVu1DSeqT9ylh8ubH7sXgG4vlDnzPDN3h+GZLV0L5bKmjD3OSHr5eVGb6p+E9njRRs7rUyAavJjiNPwxpMtIyeIHM+50YrOqoL8QKUjMcIZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DHENvl2O; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DHENvl2O"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfa4e4684bso1045135ad.2
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908741; x=1792513541; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yMN9BXHRpANo2zxDuLk7kDAodrYyScziqIAQD0PyUrY=;
        b=DHENvl2OWgM18EGaBADbPr3AvVELyeKrpC0xyOfjoWuA7cz4aujUFz0cHyejOIWCYO
         I2Repy3/01/nz1tt2f9UiZbIHdvzbeW9sCEmy8xvOA9M2mVKhCoWjzIjUk69WNt3lR24
         d0ytQghbe3rkaT5Ah6wJDgVJWQ4fokCKPH0COkMTDx+DzK1qphSk5OzKJ1e8ciXtZEzT
         Kf+5HQ6AoB8fn517s27DmbMs95ouNEmxbblMGLN/NmucGy0SlLehCH5kJwKCNwFJz3ml
         zyNMR1M2EJKvxr541B8dl9h0tOplDndP54g5INKUvTVMYZdoPlzRAqVSu9fJw8cz3PS6
         +1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908741; x=1792513541;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yMN9BXHRpANo2zxDuLk7kDAodrYyScziqIAQD0PyUrY=;
        b=tMbwRS0Trw67/hbxwCP1uSh2Zuu6pe4ECS3R9Xak9nkcjAFJBrHKL3hvVtVpG82UjL
         /u3RZ2WJtmJG1x3YF6H/aHm1a9BWrMoQj53E+g+Vz0mvF8KdYn9PKWVKrBT6HKnpKBr0
         hc2XR7ChTpzoleGwGiQFDZUEYOWv3vz/xB47D1n0Z83bz9GjzQM8eH4eM8p7hO/Gzya0
         yyDwYUBT1CRMctG0dnpRC4qVO332ISGfRvGzPF1ASA+cb17LyR2qW2QDP6aLmh5h51f3
         zY1WEyea3TxAHDdA8Y7K4b9l+KxMVdM37Y6b2fzciKQ8u6qESLQyOtKuNrRSqW+m1wrR
         y3QQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFU4MN8qcnpK7dVVEp+v398WOcxG5aCSfVZmW3s5HIYICwkZvZ69hXQJQccNL9PdmrTiTcPtUdOvg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIo4MwceDMPRNz46DnjZOw+AT6sV8PHqtcACnuIIrCg0/4Dy8EX
	sAQh0CRUdMBQuQHXL941EQxokz+QOj9odbjAXzRFoUaYfuI+1/q2hIgZJwz+fNrlA/D/eHh5SH9
	P/7J5gCaZeK/PEw==
X-Received: from plda4.prod.google.com ([2002:a17:902:ee84:b0:2e8:5201:ef23])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2305:b0:2e1:35f0:6822 with SMTP id d9443c01a7336-2e842820d14mr124713435ad.2.1791908740352;
 Tue, 13 Oct 2026 09:25:40 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:21 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-6-dmatlack@google.com>
Subject: [PATCH v10 05/13] PCI: liveupdate: Auto-preserve upstream bridges
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
 drivers/pci/liveupdate.c | 125 +++++++++++++++++++++++++++++----------
 include/linux/pci.h      |   3 +
 2 files changed, 96 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index d6b659b346bb..bffb3e1d8b2d 100644
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
@@ -425,55 +436,84 @@ static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoi
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
 
@@ -486,12 +526,16 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
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
 
@@ -499,7 +543,13 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
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
@@ -515,6 +565,9 @@ EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
  * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
  * unpreserve() callback to ensure the outgoing struct pci_ser is already set
  * up.
+ *
+ * pci_liveupdate_unpreserve() automatically unpreserves all bridges upstream of
+ * @dev.
  */
 void pci_liveupdate_unpreserve(struct pci_dev *dev)
 {
@@ -528,7 +581,7 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
 		return;
 	}
 
-	pci_liveupdate_unpreserve_device(outgoing, dev);
+	pci_liveupdate_unpreserve_path(outgoing, dev, /*end=*/NULL);
 	pci_liveupdate_flb_put_outgoing();
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
@@ -618,28 +671,30 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
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
@@ -651,6 +706,8 @@ static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *de
  * Update. Drivers must call pci_liveupdate_finish() from their struct
  * liveupdate_file_handler finish() callback to ensure the incoming struct
  * pci_ser is allocated.
+ *
+ * pci_liveupdate_finish() automatically finishes all bridges upstream of @dev.
  */
 void pci_liveupdate_finish(struct pci_dev *dev)
 {
@@ -664,7 +721,11 @@ void pci_liveupdate_finish(struct pci_dev *dev)
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
2.56.0.385.gd3acb90ef8-goog

