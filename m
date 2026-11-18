Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041432;
	b=l0n/u2HyoZriXhLnbiHnqqxtsgurHx2427gL0ImufPoVINqtbobxA1TcqZ1QnH+44BLw
	 nH2MwIViAdiDweG/I7GCD4UcT9NN5iaraNazTMM1VoghUR5yil0uY49PB6C97bvBuGDo1
	 SthOA2Zhb+kuul75O0ES1PM4s8rEjn6OW1HsaKEC1jwpS17t1PgvhLW/JmGS4RQmw6Q4t
	 rtvxcg0ILZ5HE/zM/3VLEB6hpE8CulptUb87Pyzrp+5WrM7O0k7Vt8CtymFHvJ2YsTgd4
	 ZXeYOV/gxZt8UyU1TUTH5x5KKJFAzzlI0UXYoq8dQnemsRNPxC5wkwM/sDiEnDB61vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+taJEcx0HgGHe7DJeX0vXHzT5xK/DXPvks4/EBL5fBw=;
	b=1oL/2ST/wjWqKb4KU/VlCcVyRD/OaS8LMqIqyHVxtZcaS2gv/K2Wj/FYHh9iEyGA4xDk
	 1GC+ejTOGDzmf8J5xv8OabikizEreiuaKZ2qtIgoknDGsGE8p9An4jmgEOgdzQOJahGA4
	 O3PsxpmMKfUrDhUSNFK7IFqVn9V8YJxRDgiPSYd51IpymM0AbfJhrbipZcFm18b2cE+YL
	 TFdBLMXZ6Ql+uSu4DMuc5qv7Ue5T6GwlXJ0VLgITvWGy+6kX6f5KKfsDaSStregwrDmU7
	 7PoxFW1I/zzrbPzQQ5ZRzYk3kgkYKmP9QX+BiftsCw+UsYdREoyrWpAyw8VkxriGkTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TqN3l6at;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566160A2609
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 22:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3566160A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TqN3l6at
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-862cfd7092bso1173199a34.1
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 14:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041430; x=1795646230; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+taJEcx0HgGHe7DJeX0vXHzT5xK/DXPvks4/EBL5fBw=;
        b=TqN3l6atL5U7OyDFjcs12hntwGywETIz0k1DuqzYAmdi9rMTaBZheVmkpnSwdx3+hB
         Lkx5g3Gc63G4lXcb8Rglt4U0iP1dttYkevmG3BYuM6VDqvUZC3oHJWrj9wwwbRdp+E4n
         4k+gJx4LacQCgUDnA6bPQvFP4U+aHnGN3XRQ1675dF1k2qAiIlUatsA9GPyJHK3nza0Z
         f5qGhkqDZsRILPO+QcXUHGKTRpER3iSvIXGkLBBExMWdiPPOjI2adlZAgIhwQJIxJFiC
         lMNKs39fe6xoH1Jc48ebbRfl7tH9IpIMNzc//jvUslEo1qlASUQXUFQgN+O1QtbWrQ1B
         7gAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041430; x=1795646230;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+taJEcx0HgGHe7DJeX0vXHzT5xK/DXPvks4/EBL5fBw=;
        b=SsKw2KTHV48y5g0XceByq06NmvvtpUANypvbcQjzyQL69f1KjtjVDzj+N2Hl7Q0cyq
         97awuWQwxJjqRyKJ2Nmdf/rqozFW+xhUg6DTlvLC43eeTPImM1hTp2zExNy2iOTPdm1m
         oFu2pgjsACv0ERQDnT/d1E9bAodUgqyib5lE0BtkfWoxf9glxK5ulNRi0tc/WVc5pJsE
         pfTHuJ+RxMF7z0ZBZn8+uCOREgkWsux4TOfeMpnSZYwlbmLnrTJC8R+ZQvpzoXxaIrP6
         WjD52PRhBcyZh9C1sFRc/muZ6wPUI078gihYQYBu9jZol9TbG9dhP7Ja1ezIb7icMQg8
         wItA==
X-Forwarded-Encrypted: i=1; AL+hErEapY0YSfZQ9ma1xaEl8gM9/WOMSxDJ/5LBE6d5iR/A5jERe+5+GfGkbu8/u1uJGkPae3mUCkSJfxg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wnGZRZK++1ZXI3YlcDE8JqmiT1l4tDNTuLvNEEQL/0F3rxHha
	xb/y0Ng7cLbdFV7+tujkPfIWkhvoo7mzxDPXqdDKhCV/xA4JXHmKt2D8nkRmXnFJymOide/dCoT
	RvPzlcmTsS6x1YA==
X-Received: from japu25.prod.google.com ([2002:a02:cb99:0:b0:601:e61d:c88c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1927:b0:4af:5d69:1cb4 with SMTP id 5614622812f47-5773cd2176emr5139451b6e.15.1795041429780;
 Wed, 18 Nov 2026 14:37:09 -0800 (PST)
Date: Wed, 18 Nov 2026 22:36:53 +0000
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
Message-ID: <20261118223704.3286085-3-dmatlack@google.com>
Subject: [PATCH v11 02/13] PCI: liveupdate: Track outgoing preserved PCI devices
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

Add APIs to allow drivers to notify the PCI core of which devices are
being preserved across a Live Update for the next kernel, i.e.
"outgoing" devices.

Drivers must notify the PCI core when devices are preserved so that the
PCI core can update its FLB data (struct pci_ser) and track the list of
outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
device must be preserved across Live Update. pci_liveupdate_unpreserve()
reverses this (cancels the preservation of the device).

Later patches use this to leave preserved devices running during
shutdown and kexec, and the list of preserved devices is handed off to
the next kernel.

Warn if a device is released while it is still preserved.

Panic if any device is still preserved when the outgoing FLB is freed,
i.e. some driver failed to call pci_liveupdate_unpreserve(). Freeing the
outgoing state would otherwise leave dangling dev->liveupdate.outgoing
pointers behind.

For now, the API only supports preserving non-VF devices on a root bus
(not behind a PCI-to-PCI bridge).

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
---
 MAINTAINERS                    |   1 +
 drivers/pci/liveupdate.c       | 267 ++++++++++++++++++++++++++++++++-
 drivers/pci/liveupdate.h       |  21 +++
 drivers/pci/probe.c            |   2 +
 include/linux/pci.h            |   3 +
 include/linux/pci_liveupdate.h |  21 +++
 6 files changed, 314 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/liveupdate.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 639db5d00a80..6b7c5f3a64d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21555,6 +21555,7 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
 F:	drivers/pci/liveupdate.c
+F:	drivers/pci/liveupdate.h
 F:	include/linux/kho/abi/pci.h
 F:	include/linux/pci_liveupdate.h
 
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 173433f64d00..d6f2ea4c23ce 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -59,6 +59,7 @@
  *       luo_flb_file_preserve_one()      # first preserved file only
  *         pci_flb_preserve()             # alloc and preserve struct pci_ser
  *     fh->ops->preserve()                # driver callback
+ *       pci_liveupdate_preserve(dev)     # record this device in struct pci_ser
  *
  *   # Userspace: preservation cancelled or session torn down
  *   luo_file_unpreserve_files()
@@ -79,6 +80,27 @@
  *     luo_flb_file_finish()
  *       liveupdate_flb_put_incoming()    # last incoming file only
  *         pci_flb_finish()               # free struct pci_ser
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
+ * This allows the PCI core to keep its FLB data (struct pci_ser) up to date
+ * with the list of **outgoing** preserved devices for the next kernel.
+ *
+ * Restrictions
+ * ============
+ *
+ * The PCI core enforces the following restrictions on which devices can be
+ * preserved. These may be relaxed in the future:
+ *
+ *  * The device cannot be a Virtual Function (VF).
+ *  * The device cannot be behind a PCI-to-PCI bridge.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -93,6 +115,21 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 
+#include "liveupdate.h"
+
+/**
+ * struct pci_liveupdate_global - Global state for PCI Live Update support
+ * @rwsem: Reader/writer semaphore used to protect the incoming and outgoing
+ *         FLBs, and the references to them in struct pci_dev.
+ */
+struct pci_liveupdate_global {
+	struct rw_semaphore rwsem;
+};
+
+static struct pci_liveupdate_global pci_liveupdate = {
+	.rwsem = __RWSEM_INITIALIZER(pci_liveupdate.rwsem),
+};
+
 /**
  * struct pci_flb_outgoing - Outgoing PCI FLB object
  * @ser: Pointer to the preserved struct pci_ser.
@@ -103,6 +140,37 @@ struct pci_flb_outgoing {
 	struct kho_block_set block_set;
 };
 
+/*
+ * Panic if any struct pci_dev_ser in @block_set is still in use, i.e. some
+ * driver failed to call pci_liveupdate_unpreserve(). This runs once the last
+ * reference to the FLB is dropped, so no unpreserve can be in flight.
+ *
+ * Report the devices from the FLB rather than by walking struct pci_dev, so
+ * that devices that were destroyed while preserved are identified as well.
+ */
+static void pci_check_all_devices_released(struct pci_ser *ser,
+					   struct kho_block_set *block_set)
+{
+	struct pci_dev_ser *dev_ser;
+	struct kho_block_set_it it;
+
+	if (!ser->nr_devices)
+		return;
+
+	kho_block_set_it_init(&it, block_set);
+	while ((dev_ser = kho_block_set_it_read_entry(&it))) {
+		if (!dev_ser->refcount)
+			continue;
+
+		pr_emerg("%04x:%02x:%02x.%d was never released!\n",
+			 dev_ser->domain, PCI_BUS_NUM(dev_ser->bdf),
+			 PCI_SLOT(dev_ser->bdf), PCI_FUNC(dev_ser->bdf));
+	}
+
+	panic("%u preserved device(s) were never released!\n",
+	      ser->nr_devices);
+}
+
 static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 {
 	struct pci_flb_outgoing *outgoing __free(kfree) = NULL;
@@ -137,7 +205,7 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
 
 	pr_debug("Unpreserving struct pci_ser (0x%llx)\n", args->data);
 
-	WARN_ON(outgoing->ser->nr_devices);
+	pci_check_all_devices_released(outgoing->ser, &outgoing->block_set);
 	kho_block_set_destroy(&outgoing->block_set);
 	kho_unpreserve_free(outgoing->ser);
 	kfree(outgoing);
@@ -169,6 +237,203 @@ static struct liveupdate_flb pci_liveupdate_flb = {
 	.compatible = PCI_LUO_FLB_COMPATIBLE,
 };
 
+static void pci_liveupdate_flb_put_outgoing(void)
+{
+	liveupdate_flb_put_outgoing(&pci_liveupdate_flb);
+}
+
+static struct pci_flb_outgoing *pci_liveupdate_flb_get_outgoing(void)
+{
+	struct pci_flb_outgoing *outgoing = NULL;
+	int ret;
+
+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&outgoing);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!outgoing)
+		return ERR_PTR(-ENOENT);
+
+	return outgoing;
+}
+
+static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoing)
+{
+	struct pci_dev_ser *dev_ser;
+	struct kho_block_set_it it;
+	u64 count = 0;
+	int err;
+
+	kho_block_set_it_init(&it, &outgoing->block_set);
+
+	/* Try to find an existing, previously unpreserved, entry. */
+	while ((dev_ser = kho_block_set_it_read_entry(&it))) {
+		if (!dev_ser->refcount)
+			return dev_ser;
+
+		count++;
+	}
+
+	/* Otherwise grow the block set and reserve a new entry. */
+	err = kho_block_set_grow(&outgoing->block_set, count + 1);
+	if (err)
+		return ERR_PTR(err);
+
+	if (!count)
+		kho_block_set_it_init(&it, &outgoing->block_set);
+
+	/* This should always succeed since kho_block_set_grow() succeeded. */
+	dev_ser = kho_block_set_it_reserve_entry(&it);
+	if (WARN_ON_ONCE(!dev_ser))
+		return ERR_PTR(-ENOSPC);
+
+	return dev_ser;
+}
+
+/*
+ * Start preserving @dev by allocating its struct pci_dev_ser. The caller is
+ * responsible for taking a reference on it.
+ */
+static struct pci_dev_ser *pci_liveupdate_alloc_dev_ser(
+		struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser;
+
+	dev_ser = pci_flb_alloc_dev_ser(outgoing);
+	if (IS_ERR(dev_ser))
+		return dev_ser;
+
+	pci_info(dev, "Device will be preserved across next Live Update\n");
+	outgoing->ser->nr_devices++;
+	outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
+
+	dev_ser->domain = pci_domain_nr(dev->bus);
+	dev_ser->bdf = pci_dev_id(dev);
+	dev->liveupdate.outgoing = dev_ser;
+	return dev_ser;
+}
+
+/*
+ * Stop preserving @dev by releasing its struct pci_dev_ser.
+ */
+static void pci_liveupdate_free_dev_ser(struct pci_flb_outgoing *outgoing,
+					struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
+
+	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
+	outgoing->ser->nr_devices--;
+	memset(dev_ser, 0, sizeof(*dev_ser));
+	dev->liveupdate.outgoing = NULL;
+}
+
+static void pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
+					     struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
+
+	if (!dev_ser) {
+		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
+		return;
+	}
+
+	pci_liveupdate_free_dev_ser(outgoing, dev);
+}
+
+static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
+					  struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser;
+
+	if (dev->is_virtfn) {
+		pci_warn(dev, "Cannot preserve Virtual Functions\n");
+		return -EINVAL;
+	}
+
+	if (dev->liveupdate.outgoing) {
+		pci_warn(dev, "Device is already preserved\n");
+		return -EBUSY;
+	}
+
+	if (!pci_is_root_bus(dev->bus)) {
+		pci_warn(dev, "Cannot preserve devices behind bridges\n");
+		return -EINVAL;
+	}
+
+	dev_ser = pci_liveupdate_alloc_dev_ser(outgoing, dev);
+	if (IS_ERR(dev_ser))
+		return PTR_ERR(dev_ser);
+
+	dev_ser->refcount++;
+	return 0;
+}
+
+/**
+ * pci_liveupdate_preserve() - Preserve a PCI device across Live Update
+ * @dev: The PCI device to preserve.
+ *
+ * pci_liveupdate_preserve() notifies the PCI core that a PCI device should be
+ * preserved across the next Live Update. Drivers are expected to call
+ * pci_liveupdate_preserve() from their struct liveupdate_file_handler
+ * preserve() callback to ensure the outgoing struct pci_ser is already set up.
+ *
+ * Return: 0 on success, <0 on failure.
+ */
+int pci_liveupdate_preserve(struct pci_dev *dev)
+{
+	struct pci_flb_outgoing *outgoing = NULL;
+	int ret;
+
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+
+	outgoing = pci_liveupdate_flb_get_outgoing();
+	if (IS_ERR(outgoing))
+		return PTR_ERR(outgoing);
+
+	ret = pci_liveupdate_preserve_device(outgoing, dev);
+
+	pci_liveupdate_flb_put_outgoing();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
+
+/**
+ * pci_liveupdate_unpreserve() - Cancel preservation of a PCI device
+ * @dev: The PCI device to unpreserve.
+ *
+ * pci_liveupdate_unpreserve() notifies the PCI core that a PCI device should no
+ * longer be preserved across the next Live Update. Drivers are expected to call
+ * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
+ * unpreserve() callback, while the outgoing struct pci_ser still exists.
+ */
+void pci_liveupdate_unpreserve(struct pci_dev *dev)
+{
+	struct pci_flb_outgoing *outgoing = NULL;
+
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+
+	outgoing = pci_liveupdate_flb_get_outgoing();
+	if (IS_ERR(outgoing)) {
+		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update state\n");
+		return;
+	}
+
+	pci_liveupdate_unpreserve_device(outgoing, dev);
+	pci_liveupdate_flb_put_outgoing();
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
+
+void pci_liveupdate_cleanup_device(struct pci_dev *dev)
+{
+	/*
+	 * No other references to @dev remain, so READ_ONCE() without the rwsem
+	 * is sufficient. Drivers must block removal of preserved devices, so a
+	 * warning here indicates a driver bug.
+	 */
+	if (READ_ONCE(dev->liveupdate.outgoing))
+		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
+}
+
 /**
  * pci_liveupdate_register_flb() - Register a file handler with the PCI core
  * @fh: The file handler to register.
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
new file mode 100644
index 000000000000..b2335581f8d0
--- /dev/null
+++ b/drivers/pci/liveupdate.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Live Update support (core API)
+ *
+ * Copyright (c) 2026, Google LLC.
+ * David Matlack <dmatlack@google.com>
+ */
+#ifndef DRIVERS_PCI_LIVEUPDATE_H
+#define DRIVERS_PCI_LIVEUPDATE_H
+
+#include <linux/pci.h>
+
+#ifdef CONFIG_PCI_LIVEUPDATE
+void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+#else
+static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
+{
+}
+#endif
+
+#endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f..5c90383873a1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -24,6 +24,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/bitfield.h>
 #include <trace/events/pci.h>
+#include "liveupdate.h"
 #include "pci.h"
 
 static struct resource busn_resource = {
@@ -2492,6 +2493,7 @@ static void pci_release_dev(struct device *dev)
 
 	pci_dev = to_pci_dev(dev);
 	pci_release_capabilities(pci_dev);
+	pci_liveupdate_cleanup_device(pci_dev);
 	pci_release_of_node(pci_dev);
 	pcibios_release_device(pci_dev);
 	pci_bus_put(pci_dev->bus);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c15c2666970..bb500623ca3e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -600,6 +600,9 @@ struct pci_dev {
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
 #endif
+#ifdef CONFIG_PCI_LIVEUPDATE
+	struct pci_liveupdate liveupdate;
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index 8ec98beefcb4..894052ad6961 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -8,14 +8,26 @@
 #ifndef LINUX_PCI_LIVEUPDATE_H
 #define LINUX_PCI_LIVEUPDATE_H
 
+#include <linux/kho/abi/pci.h>
 #include <linux/liveupdate.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
 
+/**
+ * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
+ * @outgoing: State preserved for the next kernel.
+ */
+struct pci_liveupdate {
+	struct pci_dev_ser *outgoing;
+};
+
 struct pci_dev;
 
 #ifdef CONFIG_PCI_LIVEUPDATE
 int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
 void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
+int pci_liveupdate_preserve(struct pci_dev *dev);
+void pci_liveupdate_unpreserve(struct pci_dev *dev);
 #else
 static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
 {
@@ -25,6 +37,15 @@ static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh
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
 #endif
 
 #endif /* LINUX_PCI_LIVEUPDATE_H */
-- 
2.56.1.703.gf848ed807c-goog

