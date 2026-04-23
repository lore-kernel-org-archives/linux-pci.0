Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16263AEF2E
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979409; cv=none; b=HegJsWmJsbrMgPgyPSTY0ouG6qNtI20P+hcPyQCHKaQTnb3eD/BmOAWhzwar2hSFmncg62WXK4eKDZIOCwLFzCJyrZR9hMcMQpiVtE9TUoAB0G4REV/KzRkdYMFzpirYzL302dn71d1Shi6o/rFiNtgRd69G5fSWM2cun6sVNmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979409; c=relaxed/simple;
	bh=wvsl+lqCx3435FNXLJ3KqBDnB6oUV04ymFGLbModbqM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IcVRQMkdg1DyStEdN226BKsjT7iCiKaR3M7He/LFFE14RCJQmxeUH13eANLyILQz3UCk/PweynfeVgi1fv0dshMWBXqRjAT9TmXr2lYZrdlA4RSL3RxWAUJiUPgumoOQNzi468AdJUwO1MNjnaFTOwDvXx8c66SUUTnvlAkSlO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXw1eTm1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXw1eTm1"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso63416155ad.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979403; x=1777584203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LW56WQ/GxI9kfbfGRUP82x0Orz5k50krThArcWSM6yc=;
        b=ZXw1eTm1GkaSUJBpbeGOgR1rZBpPCCkIVCDrclpF6t26EmHwoJvyeOcm0aPN59CRtd
         WmqKhLD8ZGBCx2PSAPOrVXLSo6D26/VXcW8/iNOmuyk5/12Jvc9ntaeEJnSLjPV6lw7s
         CjEHNPdws/jhhgE9CSRkS5xOA1EU1Y6FlqCjly5wsO/Hbn7ff/+1ZQ+QWLqsVqrXHxmJ
         f4AeRP8AHjcJ6vAW23FRHyP270+MHrlrVfSjlUWRpsZhmqFeQgKWslIw4XzVwScUqnDw
         enAKqFyyCykwQCm5uwS5A9y+RijlUbVKPW/bGYphbTcnikkMwzgLbsQgVPYi4IwhALfd
         NSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979403; x=1777584203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LW56WQ/GxI9kfbfGRUP82x0Orz5k50krThArcWSM6yc=;
        b=RgysmYRjrGRGuB3DHUhQZhSnhsQ7n5PeDV8JVos15SHb7fc4SUY5J4dvetVF1Sw5jy
         zb00j1BfARx8xRcpRll/ru3lFz8Fyeidshe2qPoIGTVCgogkx/JaWCaSth/ZrjF51JKP
         afgDK8JrnvGwQNahrj8pGcfo+5oBNCyB1cug4Ap+hzhBraEjZiXY2UZwos6Dh0+qhVOw
         O6YjcXHvWpjZf3bnQn6nafxwYRbH1CaISGrD7p02ULBuBBCFoEz8YzxtCfhQ2Dee9FRX
         F4eLfIbKhlm3H+TGx/x1R1RvL5i2lRQb9zbT7exAhn+umtz3FWPGDfR28I+8+XKRkXJ3
         TomQ==
X-Forwarded-Encrypted: i=1; AFNElJ/uA1wA3Ymg6KK4tJ789z0pBzd/ERzHPh7qhh2fbQBfsogCo64G4JYa7akBDVXKYzQ698wnXChjnSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xoxBk6nqqY83oOOGfc4X0XII7Vi/63DZHF6oSZ8YZ6yAyGCu
	mjNtbgD2kUJn9FCb8xRAxDGVz9f5a4nMWJPeddRRJX7s6x+Z4dygej4JYMxWuD7Mjxpb2Zdv1JN
	SM2MJSy4BoYW0EA==
X-Received: from plai2.prod.google.com ([2002:a17:902:c942:b0:2b3:2649:c9c1])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:930b:b0:2b2:67ca:5fff with SMTP id d9443c01a7336-2b5f9fd24b7mr208541215ad.28.1776979403289;
 Thu, 23 Apr 2026 14:23:23 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:06 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-3-dmatlack@google.com>
Subject: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI devices
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add APIs to allow drivers to notify the PCI core of which devices are
being preserved across a Live Update for the next kernel, i.e.
"outgoing" devices.

Drivers must notify the PCI core when devices are preserved so that the
PCI core can update its FLB data (struct pci_ser) and track the list of
outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
device must be preserved across Live Update. pci_liveupdate_unpreserve()
reverses this (cancels the preservation of the device).

This tracking ensures the PCI core is fully aware of which devices may
need special handling during shutdown and kexec, and so that it can be
handed off to the next kernel.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c    | 101 ++++++++++++++++++++++++++++++++++++
 include/linux/kho/abi/pci.h |   7 +--
 include/linux/pci.h         |  26 ++++++++++
 3 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index d4fa61625d56..2dd8daa2f17c 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -43,6 +43,26 @@
  *
  *  * ``pci_liveupdate_register_flb(driver_file_handler)``
  *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
+ *
+ * Device Tracking
+ * ===============
+ *
+ * Drivers must notify the PCI core when specific devices are preserved or
+ * unpreserved with the following APIs:
+ *
+ *  * ``pci_liveupdate_preserve(pci_dev)``
+ *  * ``pci_liveupdate_unpreserve(pci_dev)``
+ *
+ * This allows the PCI core to keep it's FLB data (struct pci_ser) up to date
+ * with the list of **outgoing** preserved devices for the next kernel.
+ *
+ * Restrictions
+ * ============
+ *
+ * The PCI core enforces the following restrictions on which devices can be
+ * preserved. These may be relaxed in the future:
+ *
+ *  * The device cannot be a Virtual Function (VF).
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -57,6 +77,8 @@
 #include <linux/pci.h>
 #include <linux/sort.h>
 
+static DEFINE_MUTEX(pci_flb_outgoing_lock);
+
 static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 {
 	struct pci_dev *dev = NULL;
@@ -124,6 +146,85 @@ static struct liveupdate_flb pci_liveupdate_flb = {
 	.compatible = PCI_LUO_FLB_COMPATIBLE,
 };
 
+int pci_liveupdate_preserve(struct pci_dev *dev)
+{
+	struct pci_ser *ser;
+	int i, ret;
+
+	guard(mutex)(&pci_flb_outgoing_lock);
+
+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
+	if (ret)
+		return ret;
+
+	if (!ser)
+		return -ENOENT;
+
+	if (dev->is_virtfn)
+		return -EINVAL;
+
+	if (dev->liveupdate_outgoing)
+		return -EBUSY;
+
+	if (ser->nr_devices == ser->max_nr_devices)
+		return -ENOSPC;
+
+	for (i = 0; i < ser->max_nr_devices; i++) {
+		/*
+		 * Start searching at index ser->nr_devices. This should result
+		 * in a constant time search under expected conditions (devices
+		 * are not getting unpreserved).
+		 */
+		int index = (ser->nr_devices + i) % ser->max_nr_devices;
+		struct pci_dev_ser *dev_ser = &ser->devices[index];
+
+		if (dev_ser->refcount)
+			continue;
+
+		pci_info(dev, "Device will be preserved across next Live Update\n");
+		ser->nr_devices++;
+
+		dev_ser->domain = pci_domain_nr(dev->bus);
+		dev_ser->bdf = pci_dev_id(dev);
+		dev_ser->refcount = 1;
+
+		dev->liveupdate_outgoing = dev_ser;
+		return 0;
+	}
+
+	return -ENOSPC;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
+
+void pci_liveupdate_unpreserve(struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser;
+	struct pci_ser *ser = NULL;
+	int ret;
+
+	guard(mutex)(&pci_flb_outgoing_lock);
+
+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
+
+	if (ret || !ser) {
+		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update state\n");
+		return;
+
+	}
+
+	dev_ser = dev->liveupdate_outgoing;
+	if (!dev_ser) {
+		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
+		return;
+	}
+
+	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
+	ser->nr_devices--;
+	memset(dev_ser, 0, sizeof(*dev_ser));
+	dev->liveupdate_outgoing = NULL;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
+
 int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
 {
 	pr_debug("Registering file handler \"%s\"\n", fh->compatible);
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index 5c0e92588c00..5b4c8d9e462c 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -23,19 +23,20 @@
  * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
  */
 
-#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
+#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
 
 /**
  * struct pci_dev_ser - Serialized state about a single PCI device.
  *
  * @domain: The device's PCI domain number (segment).
  * @bdf: The device's PCI bus, device, and function number.
- * @reserved: Reserved (to naturally align struct pci_dev_ser).
+ * @refcount: Reference count used by the PCI core to keep track of whether it
+ *            is done using a device's struct pci_dev_ser.
  */
 struct pci_dev_ser {
 	u32 domain;
 	u16 bdf;
-	u16 reserved;
+	u16 refcount;
 } __packed;
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d70080babd52..eb94cbd8ab9d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -41,6 +41,7 @@
 #include <linux/msi_api.h>
 #include <uapi/linux/pci.h>
 #include <linux/liveupdate.h>
+#include <linux/kho/abi/pci.h>
 
 #include <linux/pci_ids.h>
 
@@ -594,6 +595,9 @@ struct pci_dev {
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
 #endif
+#ifdef CONFIG_PCI_LIVEUPDATE
+	struct pci_dev_ser *liveupdate_outgoing; /* State preserved for next kernel */
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
@@ -2880,6 +2884,14 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #ifdef CONFIG_PCI_LIVEUPDATE
 int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
 void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
+
+int pci_liveupdate_preserve(struct pci_dev *dev);
+void pci_liveupdate_unpreserve(struct pci_dev *dev);
+
+static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
+{
+	return dev->liveupdate_outgoing;
+}
 #else
 static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
 {
@@ -2889,6 +2901,20 @@ static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh
 static inline void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
 {
 }
+
+static inline int pci_liveupdate_preserve(struct pci_dev *dev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void pci_liveupdate_unpreserve(struct pci_dev *dev)
+{
+}
+
+static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
+{
+	return NULL;
+}
 #endif
 
 #endif /* LINUX_PCI_H */
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

