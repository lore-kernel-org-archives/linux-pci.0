Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CE3BADA9
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718789; cv=none; b=AI6JqoL1Uf31m5r5zutUYZQaMmLb07/9yEyaU1qNvb7sLzism3qcZRzGoBoH/Y8W9pVEyBlp9TSevLRgEL0c1V9CfnNB+GEMueVxELzlB1IK1OH12Otp619iafAY5qjxxNfSlK+JjICHOw0HpPd+neBlHSY5U5rrE7RGktn5tzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718789; c=relaxed/simple;
	bh=wDK96R3B273CLNejo5khL7j/0MEwgmuxB/Cn16PAsUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bcSg432C+C8Z8PpDq4RYgotKO/rJMo/WE2+rRyrzIntYUNkSjqCV+YnXnSeAIhha0cOUT5UD5Q2eXGt47MZ1k7gvrm8l9pa4QqgnwD3wZL6oZG7J85TNYPvoGYl4Cv2/9iV9iSrHZ0Y80g+Y2zm9iFZWwaLbplMhbjnyuvksAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BPNlz5/S; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPNlz5/S"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ccd1958e8fso16273315ad.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 14:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718786; x=1784323586; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQrpvHKyfewFed1C96fmigU0fqx5g50RgiJpnH3PBzY=;
        b=BPNlz5/STxqC3XkmQt/0JsRMCgppTI/OMTjbKg5dcgGLqYbovZgpNgjHB0psT4XU0y
         Lql3l8zGYbtsgTcddlU8tvuX4W1IIEQaaIqwhPMN36RqWX6wc4XpDpq4eaQYS9hsQi99
         fTPejP7Zdebe7CJ5t3fPnbVgv0weafe6jDfiX6rlxi4yGyrk+zgtOOl4FWDaL8TXcXsz
         rCXau96W/waA5IaJ7pCkGF1SleDeHRK7dUH/76Cdm+W1nPGBQhw19WAtp3bxiGeGny8D
         P6AE3s0MDSpd2K6NmcP+u6mRoF0Suc+zkSBBxHy9WoWjThfZgFRE2e9X9NZOUX/n0SDE
         q0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718786; x=1784323586;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OQrpvHKyfewFed1C96fmigU0fqx5g50RgiJpnH3PBzY=;
        b=bzLfycH2iPzdSysOltuwCYx5as4VnykuL4TEQ/24gIps0JkvlbIlBDTpe61bZbL+zl
         KFRaMalDn400SbRYiWnQPpcTvXDp/eWho30PHrH+znpqkASdP1XtV0sCp8GZnKgONa/8
         9SqMmIvluwgi51kKCjWI+4G8OU+wfLyOVz6ZQmBm6ZkuCYmamDgXp4EIygcirY8hkFZl
         wD8Gw7FR2tiVpcBlR9jWYRGoJFdnKJXowbn3Noh5gP+ymKXGHJ1f7dPz+D8DBkekUBMe
         vHyUwbC9DzgTeUbFj1ztcVRxoz7XFeNtzkXVYw09Tmp/M4B1ABoVNRrMn6b3PLzR3zBQ
         TT4w==
X-Forwarded-Encrypted: i=1; AHgh+Rrmsa+anAVHE0WA0hMAVQTZZ2jC1NpHu3vP/9yxPEYaDr5kzNSc1Ffb0o2LTOLbUzsmAWTC35I+Bpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3g1l6eDrQhLyqlcdQcjybvIBg05Fd0OsHjoYz6zAcIZu3WCB
	yJ3wGMdm+DNKbKMUvcFTck6VsfOh/Qmwlb3U2AG7edFaUiKvmqdCttfy7ZIpu8/oA4QpacSfzYY
	YK2feW9LPujuI7g==
X-Received: from plrf24.prod.google.com ([2002:a17:902:ab98:b0:2cc:622b:5b52])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:120f:b0:2c9:97a7:f540 with SMTP id d9443c01a7336-2ce9f059398mr6625505ad.38.1783718785688;
 Fri, 10 Jul 2026 14:26:25 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:06 +0000
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-4-dmatlack@google.com>
Subject: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI devices
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

During PCI enumeration, the previous kernel might have passed state about
devices that were preserved across kexec. The PCI core needs to fetch
this state to identify which devices are "incoming" and require special
handling.

Add pci_liveupdate_setup_device() which is called during device setup
to fetch the serialized state (struct pci_ser) from the Live Update
Orchestrator. The first time this happens, pci_flb_retrieve() will run
and convert the array of pci_dev_ser structs into an xarray so that it
can be looked up efficiently.

If a device is found in the xarray, the PCI core stores a pointer to its
state in dev->liveupdate_incoming and holds a reference to the incoming
FLB until pci_liveupdate_finish() is called by the driver.

This ensures proper lifecycle management for incoming preserved devices
and allows the PCI core and drivers to apply specific Live Update
logic to them in subsequent commits.

Drivers can check if a device is an incoming preserved device (e.g.
during probe) by calling pci_liveupdate_is_incoming().

CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that the
domain and bdf can be guaranteed to fit in an unsigned long and be used
as the xarray key.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 MAINTAINERS                    |   1 +
 drivers/pci/Kconfig            |   2 +-
 drivers/pci/liveupdate.c       | 240 ++++++++++++++++++++++++++++++++-
 drivers/pci/liveupdate.h       |   5 +
 drivers/pci/probe.c            |   3 +
 include/linux/pci_liveupdate.h |  13 ++
 6 files changed, 261 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9cc7b9291ace..08a724b860dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20834,6 +20834,7 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
 F:	drivers/pci/liveupdate.c
+F:	drivers/pci/liveupdate.h
 F:	include/linux/kho/abi/pci.h
 F:	include/linux/pci_liveupdate.h
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 3781e2b5f095..8af20f558086 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -273,7 +273,7 @@ config VGA_ARB_MAX_GPUS
 
 config PCI_LIVEUPDATE
 	bool "PCI Live Update Support"
-	depends on PCI && LIVEUPDATE
+	depends on PCI && LIVEUPDATE && 64BIT
 	help
 	  Enable PCI core support for preserving PCI devices across Live
 	  Update. This, in combination with support in a device's driver,
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 03075ce06ac9..df6a02240aa4 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -49,6 +49,20 @@
  * This allows the PCI core to keep its FLB data (struct pci_ser) up to date
  * with the list of **outgoing** preserved devices for the next kernel.
  *
+ * After kexec, whenever a device is enumerated, the PCI core will check if it
+ * is an **incoming** preserved device (i.e. preserved by the previous kernel)
+ * by checking the incoming FLB data (struct pci_ser).
+ *
+ * Drivers must notify the PCI core when an **incoming** device is done
+ * participating in the incoming Live Update with the following API:
+ *
+ *  * ``pci_liveupdate_finish(pci_dev)``
+ *
+ * The PCI core does not enforce any ordering of ``pci_liveupdate_finish()`` and
+ * ``pci_liveupdate_preserve()``. i.e. A PCI device can be **outgoing**
+ * (preserved for next kernel) and **incoming** (preserved by previous kernel)
+ * at the same time.
+ *
  * Restrictions
  * ============
  *
@@ -99,6 +113,26 @@ struct pci_flb_outgoing {
 	struct kho_block_set block_set;
 };
 
+/**
+ * struct pci_flb_incoming - Incoming PCI FLB object
+ * @ser: The incoming struct pci_ser from the previous kernel.
+ * @xa: Xarray used to quickly lookup devices in @ser.
+ * @block_set: The KHO block set holding the incoming devices.
+ *
+ * This structure holds the runtime state for the incoming PCI Live Update
+ * state. It wraps the serialized pci_ser, the block_set used to restore
+ * the serialized entries, and an xarray for fast lookups.
+ */
+struct pci_flb_incoming {
+	struct pci_ser *ser;
+	struct xarray xa;
+	struct kho_block_set block_set;
+};
+
+static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
+{
+	return (unsigned long)domain << 16 | bdf;
+}
 static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 {
 	struct pci_flb_outgoing *outgoing;
@@ -138,13 +172,58 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
 
 static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 {
-	args->obj = phys_to_virt(args->data);
+	struct pci_ser *ser = phys_to_virt(args->data);
+	struct pci_flb_incoming *incoming;
+	struct pci_dev_ser *dev_ser;
+	struct kho_block_set_it it;
+	int ret = -ENOMEM;
+
+	incoming = kzalloc_obj(*incoming);
+	if (!incoming)
+		goto err_restore_free;
+
+	incoming->ser = ser;
+	xa_init(&incoming->xa);
+
+	kho_block_set_init(&incoming->block_set, sizeof(struct pci_dev_ser));
+	ret = kho_block_set_restore(&incoming->block_set, ser->devices);
+	if (ret)
+		goto err_free_incoming;
+
+	kho_block_set_it_init(&it, &incoming->block_set);
+	while ((dev_ser = kho_block_set_it_read_entry(&it))) {
+		unsigned long key;
+
+		if (!dev_ser->refcount)
+			continue;
+
+		key = pci_ser_xa_key(dev_ser->domain, dev_ser->bdf);
+		ret = xa_insert(&incoming->xa, key, dev_ser, GFP_KERNEL);
+		if (ret)
+			goto err_block_set_destroy;
+	}
+
+	args->obj = incoming;
 	return 0;
+
+err_block_set_destroy:
+	kho_block_set_destroy(&incoming->block_set);
+err_free_incoming:
+	xa_destroy(&incoming->xa);
+	kfree(incoming);
+err_restore_free:
+	kho_restore_free(ser);
+	return ret;
 }
 
 static void pci_flb_finish(struct liveupdate_flb_op_args *args)
 {
-	kho_restore_free(args->obj);
+	struct pci_flb_incoming *incoming = args->obj;
+
+	xa_destroy(&incoming->xa);
+	kho_block_set_destroy(&incoming->block_set);
+	kho_restore_free(incoming->ser);
+	kfree(incoming);
 }
 
 static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
@@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
 
+static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
+{
+	struct pci_flb_incoming *incoming = NULL;
+	int ret;
+
+	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&incoming);
+
+	/* Live Update is not enabled. */
+	if (ret == -EOPNOTSUPP)
+		return NULL;
+
+	/* Live Update is enabled, but there is no incoming FLB data. */
+	if (ret == -ENODATA)
+		return NULL;
+
+	/*
+	 * Live Update is enabled and there is incoming FLB data, but none of it
+	 * matches pci_liveupdate_flb.compatible.
+	 *
+	 * This could mean that no PCI FLB data was passed by the previous
+	 * kernel, but it could also mean the previous kernel used a different
+	 * compatibility string (i.e. a different ABI).
+	 */
+	if (ret == -ENOENT) {
+		pr_info_once("No incoming FLB matched %s\n", pci_liveupdate_flb.compatible);
+		return NULL;
+	}
+
+	/*
+	 * There is incoming FLB data that matches pci_liveupdate_flb.compatible
+	 * but it cannot be retrieved.
+	 */
+	if (ret)
+		panic("Failed to retrieve incoming FLB data (%d)\n", ret);
+
+	return incoming;
+}
+
+static void pci_liveupdate_flb_put_incoming(void)
+{
+	liveupdate_flb_put_incoming(&pci_liveupdate_flb);
+}
+
+void pci_liveupdate_setup_device(struct pci_dev *dev)
+{
+	struct pci_flb_incoming *incoming;
+	struct pci_dev_ser *dev_ser;
+	unsigned long key;
+
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+
+	incoming = pci_liveupdate_flb_get_incoming();
+	if (!incoming)
+		return;
+
+	key = pci_ser_xa_key(pci_domain_nr(dev->bus), pci_dev_id(dev));
+	dev_ser = xa_load(&incoming->xa, key);
+
+	/*
+	 * This device was not preserved across Live Update, or it was preserved
+	 * but has already been probed and gone through pci_liveupdate_finish(),
+	 * e.g. due to removing and re-adding the device. Either way, it's not
+	 * treated as incoming-preserved.
+	 */
+	if (!dev_ser || !dev_ser->refcount) {
+		pci_liveupdate_flb_put_incoming();
+		return;
+	}
+
+
+	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
+	dev->liveupdate.incoming = dev_ser;
+
+	/*
+	 * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
+	 * that dev->liveupdate.incoming cannot get freed while the PCI core
+	 * has a pointer to it. It's better to leak the incoming FLB than do a
+	 * use-after-free if driver does not call pci_liveupdate_finish().
+	 */
+}
+
 void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 	/*
@@ -309,7 +469,83 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 	 */
 	if (READ_ONCE(dev->liveupdate.outgoing))
 		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
+
+	if (READ_ONCE(dev->liveupdate.incoming)) {
+		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
+		pci_liveupdate_flb_put_incoming();
+	}
+}
+
+static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
+{
+	if (!dev->liveupdate.incoming) {
+		pci_warn(dev, "Cannot finish preserving an unpreserved device\n");
+		return;
+	}
+
+	if (dev->liveupdate.incoming->refcount != 1) {
+		pci_WARN(dev, 1, "Preserved device has a corrupted refcount!\n");
+		return;
+	}
+
+	/*
+	 * Drop the refcount so this device does not get treated as an incoming
+	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
+	 * again because the device is hot-plugged.
+	 */
+	dev->liveupdate.incoming->refcount = 0;
+
+	pci_info(dev, "Device is finished participating in Live Update\n");
+	dev->liveupdate.incoming = NULL;
+	ser->nr_devices--;
+	pci_liveupdate_flb_put_incoming();
+}
+
+/**
+ * pci_liveupdate_finish() - Finish the preservation of a PCI device
+ * @dev: The PCI device
+ *
+ * pci_liveupdate_finish() notifies the PCI core that a PCI device that was
+ * preserved across the previous Live Update has finished participating in Live
+ * Update. Drivers must call pci_liveupdate_finish() from their struct
+ * liveupdate_file_handler finish() callback to ensure the incoming struct
+ * pci_ser is allocated.
+ */
+void pci_liveupdate_finish(struct pci_dev *dev)
+{
+	struct pci_flb_incoming *incoming;
+
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+
+	incoming = pci_liveupdate_flb_get_incoming();
+	if (!incoming) {
+		pci_warn(dev, "Cannot finish preserving device without incoming FLB\n");
+		return;
+	}
+
+	pci_liveupdate_finish_device(incoming->ser, dev);
+	pci_liveupdate_flb_put_incoming();
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
+
+/**
+ * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
+ * @dev: The PCI device to check
+ *
+ * Check if a device was preserved across Live Update by the previous kernel,
+ * i.e. the device is incoming-preserved. Note that a device is only considered
+ * incoming-preserved prior to pci_liveupdate_finish(). It is up to drivers to
+ * synchronize usage of pci_liveupdate_is_incoming() with their own call to
+ * pci_liveupdate_finish() to avoid acting on stale data.
+ *
+ * Returns: True if the device is incoming-preserved, false otherwise.
+ */
+bool pci_liveupdate_is_incoming(struct pci_dev *dev)
+{
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+	return dev->liveupdate.incoming;
 }
+EXPORT_SYMBOL_GPL(pci_liveupdate_is_incoming);
 
 /**
  * pci_liveupdate_register_flb() - Register a file handler with the PCI core
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index b2335581f8d0..eaaa3559fd77 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -11,8 +11,13 @@
 #include <linux/pci.h>
 
 #ifdef CONFIG_PCI_LIVEUPDATE
+void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
 #else
+static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
+{
+}
+
 static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 14b66acbdb15..5dc9d86e3597 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2065,6 +2065,8 @@ int pci_setup_device(struct pci_dev *dev)
 	if (pci_early_dump)
 		early_dump_pci_device(dev);
 
+	pci_liveupdate_setup_device(dev);
+
 	/* Need to have dev->class ready */
 	dev->cfg_size = pci_cfg_space_size(dev);
 
@@ -2188,6 +2190,7 @@ int pci_setup_device(struct pci_dev *dev)
 	default:				    /* unknown header */
 		pci_err(dev, "unknown header type %02x, ignoring device\n",
 			dev->hdr_type);
+		pci_liveupdate_cleanup_device(dev);
 		pci_release_of_node(dev);
 		return -EIO;
 
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index cfcfbfa73af7..cfdc3d62ec02 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -16,9 +16,11 @@
 /**
  * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
  * @outgoing: State preserved for the next kernel.
+ * @incoming: State preserved by the previous kernel.
  */
 struct pci_liveupdate {
 	struct pci_dev_ser *outgoing;
+	struct pci_dev_ser *incoming;
 };
 
 struct pci_dev;
@@ -28,6 +30,8 @@ int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
 void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
 int pci_liveupdate_preserve(struct pci_dev *dev);
 void pci_liveupdate_unpreserve(struct pci_dev *dev);
+void pci_liveupdate_finish(struct pci_dev *dev);
+bool pci_liveupdate_is_incoming(struct pci_dev *dev);
 #else
 static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
 {
@@ -46,6 +50,15 @@ static inline int pci_liveupdate_preserve(struct pci_dev *dev)
 static inline void pci_liveupdate_unpreserve(struct pci_dev *dev)
 {
 }
+
+static inline void pci_liveupdate_finish(struct pci_dev *dev)
+{
+}
+
+static inline bool pci_liveupdate_is_incoming(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 #endif /* LINUX_PCI_LIVEUPDATE_H */
-- 
2.55.0.795.g602f6c329a-goog

