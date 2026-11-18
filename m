Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041435;
	b=JwfEA5SCJkPzBWBKHIMU2GYFq69opF6o7nxqHJE02rWJGcDRnvL74EoeCITp/HzjoWHR
	 /gwOFAnZltmjcG0Qxw3HVWueS46KvKYtdpz2Jj5rZbNyDJn0hIeD+F+ecIl6nYYW0Lzze
	 vTIQU6u08dEhdJWu+ehSnYauEfCViKGSZ32BQW35HX8MyjSBA2lk3WivpzRGURz9LJPLH
	 Y5qpfAPkNlDgGrcAmCi5ppmkW34McgIOWvch9ba1B63aMhAJZOye4SlEgsNVKu94WR6/U
	 pEt26+0upsofBt/mi+340pK9muG36szUBHN2ab1IgFcj2RPKPxKEJXTv3tUbpwynfJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=dseap2a1tzzPeaoigzCviLoXjiETn3csEuQBuadnT6s=;
	b=GmduP4PuSjFSPhFI3Hjth8Uu4tRVjAEDi+zn/asDV1O6Ouxh9BTbTmAhq8+0pfPalpED
	 oS1Hvss7aa4kWhgq0YDN+KQEOe00ShzsIuwIe0BhngtJfSSVUt9+Rg+WDSihY/fYBqG29
	 h2bsn5QIwmqwkdjxtYdJvKdrkMlcm/x4sEWM7Lc6NO/Or5PqGmghu87wYirYEd17UWfpn
	 f8qH998qB0FppX3rL5BPj3ZHq2He/lo26w7zIGP9EyUvRaS6TiUo5M9HSMko3O8qsO9fX
	 /JiQ4QA/a322rMQPc8CR6SGzKXblzucRDcutX87Zz0t21rF8xP1Qthf51Z4JCNonNhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LtF6mgKx;
	arc=none smtp.remote-ip=209.85.160.70
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C960A3807
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 22:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA7C960A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LtF6mgKx
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4ba0e4ca606so165981fac.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 14:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041434; x=1795646234; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dseap2a1tzzPeaoigzCviLoXjiETn3csEuQBuadnT6s=;
        b=LtF6mgKxiVsx3w8QD9oxEwvI3eCVgxKVN+YPUQRZTK6jHgj8HlMJbn62tVYX3rI7+z
         1wXSIUB0ghNXQE9bqnZp3ZGDhthbt5SgT8pG4ac6/BZfvaaf3eJwbSLTEaZ5icA6tD1V
         IWmC2JVeN6hyzdoedNjs1kqNw0NvRwvmV8RAM6gaaMPucjf+dr/JhrZDiq0513TI3CCy
         twg27ytTb8EsIfRDCP5asiHz1gKGdCp2cccoOZcWFfKSyWo4AaABrMYP2hAvgKDwqvgg
         bstrOwekqoeEpRZtS69hGGLXGAq4oKY3X94DhvS5SAljGQoSlQIdxIO4vbL26kVXq1w2
         WLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041434; x=1795646234;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dseap2a1tzzPeaoigzCviLoXjiETn3csEuQBuadnT6s=;
        b=u4x4oYLm/1Moeap56UXAZ5HXNXYrdrEjYdZcMPAWhuwPNRtm29BhWXthxo9zFaAywB
         lMp0PPSADlKO/m2CRKyaQSguHsMtKqSa45gMUGgSHD0wuNcJX5WjNwUuANPOtpRBDdTR
         HNB5/U8wpHiu8LSrELzPmqYGfcSFuvfKx9CDdq8pQTvyjnjy7Xp+i+Euy/8P7Gnn4VJ9
         Q7ytUaM1No+RhsRdwTLo4E6zZ6xaIgUFguGcg2v83FWvlHaJ13I06wPkcd6gWpIJDvbU
         BPU/tFdVxokGcep9MTmwWflvXzDQ5n3p8vkmfQDZ2XJIAJrhhu9rQmPw4UcFMvOWwF2J
         l2IQ==
X-Forwarded-Encrypted: i=1; AL+hErFgLvlXcFgy/JdmDZ1mCM46pgtqdZhvre2tc8jfI/mMCsZDjFiBwTaKfI2cAPDL2pBN9YvdHnZL42s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yUf1pZgvGQf9iI9+sMYADe8l/ogHRE5aLP1MwZwrekuHQNg9S
	yBN+X+tOKNp+J9IL5xAlYUOhB5uZrEoiDSOBduJ0Jt4TKeVi+TridPuFKD0Q7aUjfcmZYBy94U7
	++E1Bfvz5DZAL7A==
X-Received: from jaan16-n1.prod.google.com ([2002:a05:6638:aad0:10b0:620:20bd:b624])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6809:703:10b0:567:f627:67eb with SMTP id 5614622812f47-5775a1dbdf5mr3136425b6e.25.1795041433518;
 Wed, 18 Nov 2026 14:37:13 -0800 (PST)
Date: Wed, 18 Nov 2026 22:36:56 +0000
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118223704.3286085-6-dmatlack@google.com>
Subject: [PATCH v11 05/13] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>, 
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

Automatically preserve every bridge between a preserved device and its
root port when the device is preserved.

Subsequent commits use this to ensure that preserved devices can
continue performing memory transactions without a disruption or change
in routing.

Track the number of preserved devices at or below each bridge with a
reference count in struct pci_dev_ser. A bridge stays preserved until
all of its downstream preserved devices are unpreserved or finish their
participation in the Live Update.

struct pci_ser::nr_devices counts the struct pci_dev_ser entries that are
in use, so it only changes when a device's entry is allocated or
released, i.e. when its reference count goes from 0 to 1 or from 1 to 0,
not on every preserve and unpreserve.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/liveupdate.c | 125 +++++++++++++++++++++++++++++----------
 include/linux/pci.h      |   3 +
 2 files changed, 97 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index d1b4000c3e78..ad2bb73e1d05 100644
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
+ * This lets the PCI core keep the bridges above preserved devices forwarding
+ * their memory transactions, without changes in routing, throughout the Live
+ * Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -437,7 +448,8 @@ static struct pci_dev_ser *pci_liveupdate_alloc_dev_ser(
 }
 
 /*
- * Stop preserving @dev by releasing its struct pci_dev_ser.
+ * Stop preserving @dev by releasing its struct pci_dev_ser. The caller must
+ * have dropped the last reference on it.
  */
 static void pci_liveupdate_free_dev_ser(struct pci_flb_outgoing *outgoing,
 					struct pci_dev *dev)
@@ -450,43 +462,71 @@ static void pci_liveupdate_free_dev_ser(struct pci_flb_outgoing *outgoing,
 	dev->liveupdate.outgoing = NULL;
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
 	pci_liveupdate_free_dev_ser(outgoing, dev);
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
+	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
 
 	if (dev->is_virtfn) {
 		pci_warn(dev, "Cannot preserve Virtual Functions\n");
 		return -EINVAL;
 	}
 
-	if (dev->liveupdate.outgoing) {
-		pci_warn(dev, "Device is already preserved\n");
-		return -EBUSY;
+	if (dev_ser) {
+		/*
+		 * Endpoint devices can only be preserved once. Bridges are
+		 * preserved once for every preserved device below them.
+		 */
+		if (!dev->subordinate) {
+			pci_warn(dev, "Device is already preserved\n");
+			return -EBUSY;
+		}
+
+		if (!dev_ser->refcount) {
+			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
+			return -EINVAL;
+		}
+	} else {
+		dev_ser = pci_liveupdate_alloc_dev_ser(outgoing, dev);
+		if (IS_ERR(dev_ser))
+			return PTR_ERR(dev_ser);
 	}
 
-	if (!pci_is_root_bus(dev->bus)) {
-		pci_warn(dev, "Cannot preserve devices behind bridges\n");
-		return -EINVAL;
-	}
-
-	dev_ser = pci_liveupdate_alloc_dev_ser(outgoing, dev);
-	if (IS_ERR(dev_ser))
-		return PTR_ERR(dev_ser);
-
 	dev_ser->refcount++;
 	return 0;
 }
@@ -500,12 +540,16 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
  * pci_liveupdate_preserve() from their struct liveupdate_file_handler
  * preserve() callback to ensure the outgoing struct pci_ser is already set up.
  *
+ * pci_liveupdate_preserve() automatically preserves all bridges upstream of
+ * @dev.
+ *
  * Return: 0 on success, <0 on failure.
  */
 int pci_liveupdate_preserve(struct pci_dev *dev)
 {
 	struct pci_flb_outgoing *outgoing = NULL;
-	int ret;
+	struct pci_dev *start = dev;
+	int ret = -ENODEV;
 
 	guard(rwsem_write)(&pci_liveupdate.rwsem);
 
@@ -513,7 +557,13 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
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
@@ -528,6 +578,9 @@ EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
  * longer be preserved across the next Live Update. Drivers are expected to call
  * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
  * unpreserve() callback, while the outgoing struct pci_ser still exists.
+ *
+ * pci_liveupdate_unpreserve() drops @dev's reference on each bridge upstream of
+ * @dev, unpreserving bridges that have no other preserved devices below them.
  */
 void pci_liveupdate_unpreserve(struct pci_dev *dev)
 {
@@ -541,7 +594,7 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
 		return;
 	}
 
-	pci_liveupdate_unpreserve_device(outgoing, dev);
+	pci_liveupdate_unpreserve_path(outgoing, dev, /*end=*/NULL);
 	pci_liveupdate_flb_put_outgoing();
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
@@ -621,28 +674,30 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
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
+	 * Once the refcount reaches 0 the device is no longer treated as
+	 * incoming, e.g. if pci_liveupdate_setup_device() gets called again
+	 * because the device is hot-plugged.
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
@@ -654,6 +709,10 @@ static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *de
  * Update. Drivers must call pci_liveupdate_finish() from their struct
  * liveupdate_file_handler finish() callback, while the incoming struct pci_ser
  * is still available.
+ *
+ * pci_liveupdate_finish() drops @dev's reference on each bridge upstream of
+ * @dev, finishing bridges that have no other incoming preserved devices below
+ * them.
  */
 void pci_liveupdate_finish(struct pci_dev *dev)
 {
@@ -667,7 +726,11 @@ void pci_liveupdate_finish(struct pci_dev *dev)
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
index bb500623ca3e..6482549a8417 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -840,6 +840,9 @@ static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 	return dev->bus->self;
 }
 
+#define for_each_pci_dev_in_path(dev) \
+	for (; dev; dev = pci_upstream_bridge(dev))
+
 #ifdef CONFIG_PCI_MSI
 static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev)
 {
-- 
2.56.1.703.gf848ed807c-goog

