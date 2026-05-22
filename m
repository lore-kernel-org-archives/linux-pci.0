Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB11382F35
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779481460; cv=none; b=CeyozOYK2ciafVvLNvtjbLBc8vXgweiMxXa8tVoCCo76Q3PAcZK3VTF4UJ+q3uEYvataxAmfFGDh1LLO4ahtjip7670wwXv1WFIabXPcym8xOnaxcE/JOdx6LcYKG6n53Vl7tiyCwinE9MJZFZHCqxGz9CTVpE3VS+UFjemDhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779481460; c=relaxed/simple;
	bh=LLtHwG/AB1l6x9gZfQ/XR9thSnzbkmf56r9Jcx8CKGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QEzCeEuX3OTwHkV8+znv/Ji9vOSQtTuHlBqi2ey8g/HarmF+iHmeo5HaxLr6gSa5CatIufpvFm0kyM/Ja0Nm21YefL2vpetEuZL1nce6T1E+cMCYn8caueH+ZVpHS7AL0HGDd+bqUmKBWOveq3OjPplRLrQXaVZAqDQ0HcdE92E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YmuRoNze; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YmuRoNze"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc6899bfb1so77857805ad.2
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 13:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779481457; x=1780086257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa/nUEfOKJ1QR8NF3ghsapnMDPgIBL9du7ZKGarbXoM=;
        b=YmuRoNzef2LpSkNd/LFW2o3JlYEsCaJj92Y2E4lBnHFpg2LzzT6ojU+3/nmx+tPhPv
         Pd05W+cLxKWKi/4k7wySEhZYb4Ynx8xsDhVTwkxLorbQ+FKOoiq/d/y4WhbKQp0urONq
         Eo4d81KM63FV9x7TaJ2Iyt8KJfrEU90qgT0JTj45mi8VFHUmGjIDp3FHnnBbbZKxYHfl
         uTUUmrKfxp7xa/rckKmhBTIoQwv4Df5LnnWLvU+1NKa5qD0dAsGUuJ+ciuvHf1z2mr/p
         6fV/LXnsCw7HO/7jbJBFifiN0I8wXFKuKSyhHrFAdv2AbMs3wApvF4kpWLBZ8MTvCGPO
         R8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481457; x=1780086257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa/nUEfOKJ1QR8NF3ghsapnMDPgIBL9du7ZKGarbXoM=;
        b=iuxDcL79sNJ9djgzApGvJZDE25FgN3PqzxVx8CfwCBiFqXeTY0vEWN0+eOLlPWZt6j
         8AXah3WpJBto6qEBvFmFAPCcOwirFFXrH8VRa3kDo3+as5LMvKSgjtSLW62d1HTqdAIe
         wBwa1/vr859g7Y8yP0vnIg7WsyaGToMQUA5QAXztM3yyYZhwiQHHmwIOqRenRWb6OSsA
         EBhjwWU3hlmj7C9OfRZWHTlTCriAEJ+2YSrs+VgW8CKv7TVrog9MenSCIycyakHMUAKQ
         SSyySlr2PROj2DMoZ4KQLC2k1rXyFotAAhGz3zQeaECzJcfLq0Yqd8exlckCRgYqZLwz
         0IXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LWM4X9Bt2PkcQ7q/JVIM2o/5I/Dj5ZIwKEsWHuhxu0iA6Mj7hoIflfKrtWBxhv25KNbhZkyoGCrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGM6F8VkuqcggEkcy6RTljnHrr9C+cbWJQ7QEbkNj3gxsaB4GL
	7P5BMiU39wkX4ZpvQUnASRhy1KIxHbwGCyPmNfAqq9xg0xJQzC2wVnR7IRHqNEFixodnrLjWGiP
	9wDMhkHKkH1dXtw==
X-Received: from plfh15.prod.google.com ([2002:a17:902:f54f:b0:2b0:ba5a:1fe])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2381:b0:2bc:7486:21cf with SMTP id d9443c01a7336-2beb06423d4mr52826275ad.36.1779481457319;
 Fri, 22 May 2026 13:24:17 -0700 (PDT)
Date: Fri, 22 May 2026 20:24:04 +0000
In-Reply-To: <20260522202410.3104264-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522202410.3104264-7-dmatlack@google.com>
Subject: [PATCH v6 06/12] PCI: liveupdate: Auto-preserve upstream bridges
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
index 2421bc218916..4c79e19b7f98 100644
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
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -261,28 +273,52 @@ static struct pci_ser *pci_liveupdate_flb_get_outgoing(void)
 	return ser;
 }
 
-static void pci_liveupdate_unpreserve_device(struct pci_ser *ser, struct pci_dev *dev)
+static int pci_liveupdate_unpreserve_device(struct pci_ser *ser, struct pci_dev *dev)
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
 	ser->nr_devices--;
 	memset(dev_ser, 0, sizeof(*dev_ser));
 	dev->liveupdate.outgoing = NULL;
+	return 0;
 }
 
-static int pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *dev)
+static int pci_liveupdate_preserve_device_again(struct pci_dev *dev)
 {
-	int i;
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
+static int __pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *dev)
+{
+	int i;
+
 	if (ser->nr_devices == ser->max_nr_devices)
 		return -ENOSPC;
 
@@ -312,6 +348,52 @@ static int pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *d
 	return -ENOSPC;
 }
 
+static int pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *dev)
+{
+	if (dev->liveupdate.outgoing)
+		return pci_liveupdate_preserve_device_again(dev);
+
+	return __pci_liveupdate_preserve_device(ser, dev);
+}
+
+#define for_each_pci_dev_in_path(_d, _start, _end) \
+	for ((_d) = (_start); (_d) != (_end); (_d) = (_d)->bus->self)
+
+static void __pci_liveupdate_unpreserve_path(struct pci_ser *ser,
+					     struct pci_dev *start,
+					     struct pci_dev *end)
+{
+	struct pci_dev *dev;
+
+	for_each_pci_dev_in_path(dev, start, end) {
+		if (pci_liveupdate_unpreserve_device(ser, dev))
+			return;
+	}
+}
+
+static void pci_liveupdate_unpreserve_path(struct pci_ser *ser,
+					   struct pci_dev *start)
+{
+	__pci_liveupdate_unpreserve_path(ser, start, /*end=*/NULL);
+}
+
+static int pci_liveupdate_preserve_path(struct pci_ser *ser,
+					struct pci_dev *start)
+{
+	struct pci_dev *dev;
+	int ret;
+
+	for_each_pci_dev_in_path(dev, start, NULL) {
+		ret = pci_liveupdate_preserve_device(ser, dev);
+		if (ret) {
+			__pci_liveupdate_unpreserve_path(ser, start, dev);
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
@@ -321,6 +403,9 @@ static int pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *d
  * pci_liveupdate_preserve() from their struct liveupdate_file_handler
  * preserve() callback to ensure the outgoing struct pci_ser is already set up.
  *
+ * pci_liveupdate_preserve() automatically preserves all bridges upstream of
+ * @dev.
+ *
  * Returns: 0 on success, <0 on failure.
  */
 int pci_liveupdate_preserve(struct pci_dev *dev)
@@ -336,7 +421,7 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
 	if (IS_ERR(ser))
 		return PTR_ERR(ser);
 
-	return pci_liveupdate_preserve_device(ser, dev);
+	return pci_liveupdate_preserve_path(ser, dev);
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
 
@@ -349,6 +434,9 @@ EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
  * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
  * unpreserve() callback to ensure the outgoing struct pci_ser is already set
  * up.
+ *
+ * pci_liveupdate_unpreserve() automatically unpreserves all bridges upstream of
+ * @dev.
  */
 void pci_liveupdate_unpreserve(struct pci_dev *dev)
 {
@@ -362,7 +450,7 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
 		return;
 	}
 
-	pci_liveupdate_unpreserve_device(ser, dev);
+	pci_liveupdate_unpreserve_path(ser, dev);
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
 
@@ -534,29 +622,41 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
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
@@ -568,6 +668,8 @@ static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *de
  * Update. Drivers must call pci_liveupdate_finish() from their struct
  * liveupdate_file_handler finish() callback to ensure the incoming struct
  * pci_ser is allocated.
+ *
+ * pci_liveupdate_finish() automatically finishes all bridges upstream of @dev.
  */
 void pci_liveupdate_finish(struct pci_dev *dev)
 {
@@ -581,7 +683,7 @@ void pci_liveupdate_finish(struct pci_dev *dev)
 		return;
 	}
 
-	pci_liveupdate_finish_device(incoming->ser, dev);
+	pci_liveupdate_finish_path(incoming->ser, dev);
 	pci_liveupdate_flb_put_incoming();
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index 85def616703d..c86518be4ce7 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -23,7 +23,7 @@
  * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
  */
 
-#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
+#define PCI_LUO_FLB_COMPATIBLE "pci-v3"
 
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
2.54.0.746.g67dd491aae-goog

