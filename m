Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286944;
	b=qzaWVIlvgXLMibT3tiEoA2E5+qshFIUYUOe1PRfC8Y4Wlf6zk5Jcwl4PxsI8MwwiKG5Q
	 Q3yd9fgz2CM9F4yz2OBVqVgmtyGScCni6jgh6V0hesiHCvm9bWyZmSPrdD/0w94bt9n/L
	 59dsIFPtcnLgPJyahxNmT4maK9eBjd52zNzaaM3S3RJuUYgSDNVr6ufaKUw6xNLuNr5my
	 zoO3X2XifD8ff25PsOnEd29eHmQJ/UT6W+KLVZyWujAK73moRdrlzwVbpfZhwjEDGO9C1
	 jEQKnmxEwW/+D2MBQulZ/p9lsoYwAQDzA/aIb2mCZvc/Raw26BMMh3+UCO2WAYIDZIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=vA8W8np9fXaskA2k2ROSy6+asR0jHvCl6wOsZYrc5lM=;
	b=zXsiKg915XqWvOLMYn05Or/gAqWMphd/iGFa3JGWMtBr808F/GHvtmvf3xNAVUfH+EJG
	 Fgxdd39luYpKlk9jpE2ALWj6nl+UddjMAX9NtMIYqw2Y4AOfzZm/gTod/KS9vFo9MYC+H
	 5OubUB6s9XsfUAz1J1ApZdPAh8mJH9Ze5cvnjwsqlORezzeyzpx35INx1pSw7rPVx3zug
	 80AwKmFzlE6UcwUW753qT0FBj7asjCIvrcD/oLqR1IaD6wTyBJJQTXbe52C27XDerDpQ4
	 s9HSKxn13eK1dcV2UJ3jrfbGR79p7Fp6lCCbel4JKq4hWOKqolUw0goVzjZwp6gkc2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J11IQvut;
	arc=none smtp.remote-ip=209.85.208.71
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8105606D689
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 05:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8105606D689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J11IQvut
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b706aec65bso1580510a12.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 21:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286942; x=1794891742; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vA8W8np9fXaskA2k2ROSy6+asR0jHvCl6wOsZYrc5lM=;
        b=J11IQvutznv7alHSYW+ileIdcaJle7tPBTMQ3BmvDs25hAAFgzAsxSJz0rnNQWr0E2
         dmX5W3yk11lDE4EqaJ8vZcNx+UOxFFOEoMTK/1JaGySqUbetFhOwUADDs0uDcewIxLor
         gwZRQ/HbWyM/6lMltejznhpQEEv7cKm3Kjy0eVbsvSCNmskTwbQpckrb5wTsTzluxDDz
         Isu1m49ruIhvMecyF3xVIUKz/upK6MWZR+UaT3YQEiedou74ngO+Aa4wEZB+l7f6jCDB
         9oEqAU+TwMLKayXJJeB6uz6lfyeJpROUNNZBxe+pb4KKHfIY9+FX8ZEj7getkREkF4/h
         SnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286942; x=1794891742;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vA8W8np9fXaskA2k2ROSy6+asR0jHvCl6wOsZYrc5lM=;
        b=0wG1dun+LNleNeTC+ymCEwVXkKPJ5pmybELrP7rGLlFkDMqp4mQyv9Xwvk3TggUxVq
         NXvSaabAcLaQu2XxPXherIxiipS/FFhpkrHqslEw0t23fPMky5C/m0MZZSFNvui5B87w
         Pf2KScu03rl6sr9gYp+Jk1CtdifFSztrss9Wi0wSD7XASz8qgHhKiLfTgMU/5qkhP9/x
         kakvAliVXKViY5RjShTx5OMU+5C2rpwUCexUgbOFoMy1Z/aUnBKHO4y5qrc0NQq975h4
         6y3tN9II33oQTzRZDeTLeXPHP7Cz8ywFjHGeBLNw7DWKowHiBPc447fJd0DrcrLpB0iW
         sIjQ==
X-Forwarded-Encrypted: i=1; AL+hErFn+P3l78E+0X7DG5Yx0mumLu9Bo5EFqYlJ6peQi/e0+ZBduSw0f2rGdFMSQ7cGsyJeWqu4rDkI3Zk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BBliQKUs1nOmxEPNIUA+dnCnNwXwNR8e60YrdO6Es4NKfkKgm
	9NlSrB8d0I82L7vl4Jza0jMxsIGLrUQaScFyGTVvsozLnxNh22mYC6ums+xIJyW2ia8qaIVEDzf
	STH/pAbz63qp8wUgtUw==
X-Received: from edty17.prod.google.com ([2002:aa7:ccd1:0:b0:6b5:5ee4:9030])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5516:b0:6b4:87b8:1348 with SMTP id 4fb4d7f45d1cf-6b756ae845cmr1164654a12.27.1794286941928;
 Mon, 09 Nov 2026 21:02:21 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:58 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-16-tarunsahu@google.com>
Subject: [PATCH v4 15/19] PCI: liveupdate: Add feature header to struct pci_ser
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

struct pci_ser currently defines its own PCI-specific required_flags and
optional_flags bitmasks (capped at 64 bits without recorded structure
size) and stores dev_ser_size in the parent structure even though KHO
block headers now record entry_size directly. In addition, struct
pci_ser and struct pci_dev_ser still carry __packed despite having
naturally aligned fields on 64-bit architectures.

Precede struct pci_ser with struct kho_ser_hdr via DECLARE_KHO_SER,
removing required_flags, optional_flags, and
PCI_SER_REQUIRED_FLAGS_SUPPORTED. Remove dev_ser_size and
PCI_DEV_SER_MIN_SIZE so restoration derives the struct pci_dev_ser stride
from the KHO block header entry_size. Drop __packed from struct pci_ser
and struct pci_dev_ser, adding an explicit u32 reserved field to struct
pci_ser for 8-byte alignment, and bump PCI_LUO_FLB_COMPATIBLE from pci to
pci-v2.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 drivers/pci/liveupdate.c    | 74 +++++++++++++++++--------------------
 include/linux/kho/abi/pci.h | 63 +++++++++++--------------------
 2 files changed, 55 insertions(+), 82 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 6f92d4ddca2b..0bda94f4a7e4 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -233,7 +233,7 @@ static struct pci_liveupdate_global pci_liveupdate = {
 
 /**
  * struct pci_flb_outgoing - Outgoing PCI FLB object
- * @ser: Pointer to the preserved struct pci_ser.
+ * @fhdr: Pointer to the serialization feature header.
  * @block_set: The KHO block set holding the outgoing devices.
  *
  * This structure holds the runtime state for the outgoing PCI Live Update
@@ -241,14 +241,14 @@ static struct pci_liveupdate_global pci_liveupdate = {
  * the serialized entries.
  */
 struct pci_flb_outgoing {
-	struct pci_ser *ser;
+	DECLARE_KHO_SER_HDR(pci_ser, *fhdr);
 	struct kho_block_set block_set;
 };
 
 /**
  * struct pci_flb_incoming - Incoming PCI FLB object
- * @ser: The incoming struct pci_ser from the previous kernel.
- * @xa: Xarray used to quickly lookup devices in @ser.
+ * @fhdr: Pointer to the serialization feature header.
+ * @xa: Xarray used to quickly lookup preserved devices.
  * @block_set: The KHO block set holding the incoming devices.
  *
  * This structure holds the runtime state for the incoming PCI Live Update
@@ -256,17 +256,11 @@ struct pci_flb_outgoing {
  * the serialized entries, and an xarray for fast lookups.
  */
 struct pci_flb_incoming {
-	struct pci_ser *ser;
+	DECLARE_KHO_SER_HDR(pci_ser, *fhdr);
 	struct xarray xa;
 	struct kho_block_set block_set;
 };
 
-/*
- * Bits in struct pci_ser::required_flags that this kernel knows how to handle.
- * No flags are currently defined.
- */
-#define PCI_SER_REQUIRED_FLAGS_SUPPORTED	0ULL
-
 /* PCI_LIVEUPDATE depends on 64BIT, so domain and bdf always fit. */
 static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
 {
@@ -276,27 +270,28 @@ static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
 static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 {
 	struct pci_flb_outgoing *outgoing __free(kfree) = NULL;
+	DECLARE_KHO_SER_HDR(pci_ser, *fhdr);
 	struct pci_ser *ser;
 
 	outgoing = kzalloc_obj(*outgoing);
 	if (!outgoing)
 		return -ENOMEM;
 
-	ser = kho_alloc_preserve(sizeof(*ser));
-	if (IS_ERR(ser))
-		return PTR_ERR(ser);
+	fhdr = kho_alloc_preserve(kho_ser_size(pci_ser));
+	if (IS_ERR(fhdr))
+		return PTR_ERR(fhdr);
 
-	ser->required_flags = 0;
-	ser->optional_flags = 0;
-	ser->dev_ser_size = sizeof(struct pci_dev_ser);
+	kho_ser_init(fhdr, pci_ser);
+	ser = kho_ser_payload(fhdr, pci_ser);
 	ser->nr_devices = 0;
+	ser->reserved = 0;
 	ser->devices = 0;
 
-	outgoing->ser = ser;
+	outgoing->fhdr = fhdr;
 	kho_block_set_init(&outgoing->block_set, sizeof(struct pci_dev_ser));
 
 	args->obj = no_free_ptr(outgoing);
-	args->data = virt_to_phys(ser);
+	args->data = virt_to_phys(fhdr);
 	pr_debug("Preserved struct pci_ser (0x%llx)\n", args->data);
 	return 0;
 }
@@ -307,9 +302,9 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
 
 	pr_debug("Unpreserving struct pci_ser (0x%llx)\n", args->data);
 
-	WARN_ON(outgoing->ser->nr_devices);
+	WARN_ON(kho_ser_payload(outgoing->fhdr, pci_ser)->nr_devices);
 	kho_block_set_destroy(&outgoing->block_set);
-	kho_unpreserve_free(outgoing->ser);
+	kho_unpreserve_free(outgoing->fhdr);
 	kfree(outgoing);
 }
 
@@ -321,35 +316,29 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
  */
 static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 {
-	struct pci_ser *ser = phys_to_virt(args->data);
+	DECLARE_KHO_SER_HDR(pci_ser, *fhdr) = phys_to_virt(args->data);
 	struct pci_flb_incoming *incoming;
 	struct pci_dev_ser *dev_ser;
 	struct kho_block_set_it it;
+	struct pci_ser *ser;
 	int ret;
 
 	pr_debug("Retrieving struct pci_ser (0x%llx)\n", args->data);
 
-	if (ser->required_flags & ~PCI_SER_REQUIRED_FLAGS_SUPPORTED)
-		panic("Incoming PCI FLB requires unsupported features (0x%llx)\n",
-		      ser->required_flags & ~PCI_SER_REQUIRED_FLAGS_SUPPORTED);
+	ret = kho_ser_validate(fhdr, pci_ser);
+	if (ret)
+		panic("Failed to validate incoming PCI FLB feature header (%d)\n", ret);
 
-	/*
-	 * The previous kernel may have appended fields to struct pci_dev_ser,
-	 * which this kernel ignores, but every entry must be at least the
-	 * minimum size.
-	 */
-	if (ser->dev_ser_size < PCI_DEV_SER_MIN_SIZE)
-		panic("Incoming PCI FLB has unsupported struct pci_dev_ser size (%u)\n",
-		      ser->dev_ser_size);
+	ser = kho_ser_payload(fhdr, pci_ser);
 
 	incoming = kzalloc_obj(*incoming);
 	if (!incoming)
 		panic("Failed to allocate struct pci_flb_incoming\n");
 
-	incoming->ser = ser;
+	incoming->fhdr = fhdr;
 	xa_init(&incoming->xa);
 
-	kho_block_set_init(&incoming->block_set, ser->dev_ser_size);
+	kho_block_set_init(&incoming->block_set, sizeof(struct pci_dev_ser));
 	ret = kho_block_set_restore(&incoming->block_set, ser->devices);
 	if (ret)
 		panic("Failed to restore devices KHO block set (%d)\n", ret);
@@ -393,7 +382,7 @@ static void pci_check_all_devices_finished(struct pci_flb_incoming *incoming)
 	 * This runs once the last reference to the incoming FLB is dropped, so
 	 * there are no finishers left in flight.
 	 */
-	nr_devices = incoming->ser->nr_devices;
+	nr_devices = kho_ser_payload(incoming->fhdr, pci_ser)->nr_devices;
 	if (nr_devices == 0)
 		return;
 
@@ -428,7 +417,7 @@ static void pci_flb_finish(struct liveupdate_flb_op_args *args)
 
 	xa_destroy(&incoming->xa);
 	kho_block_set_destroy(&incoming->block_set);
-	kho_restore_free(incoming->ser);
+	kho_restore_free(incoming->fhdr);
 	kfree(incoming);
 }
 
@@ -522,7 +511,7 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
 		return 0;
 
 	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
-	outgoing->ser->nr_devices--;
+	kho_ser_payload(outgoing->fhdr, pci_ser)->nr_devices--;
 	memset(dev_ser, 0, sizeof(*dev_ser));
 	dev->liveupdate.outgoing = NULL;
 	return 0;
@@ -580,6 +569,7 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 	}
 
 	if (!dev->liveupdate.outgoing) {
+		struct pci_ser *ser = kho_ser_payload(outgoing->fhdr, pci_ser);
 		struct pci_dev_ser *dev_ser;
 
 		dev_ser = pci_flb_alloc_dev_ser(outgoing);
@@ -587,8 +577,8 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 			return PTR_ERR(dev_ser);
 
 		pci_info(dev, "Device will be preserved across next Live Update\n");
-		outgoing->ser->nr_devices++;
-		outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
+		ser->nr_devices++;
+		ser->devices = kho_block_set_head_pa(&outgoing->block_set);
 
 		dev_ser->domain = pci_domain_nr(dev->bus);
 		dev_ser->bdf = pci_dev_id(dev);
@@ -876,6 +866,7 @@ static int pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev
 void pci_liveupdate_finish(struct pci_dev *dev)
 {
 	struct pci_flb_incoming *incoming;
+	struct pci_ser *ser;
 
 	guard(rwsem_write)(&pci_liveupdate.rwsem);
 
@@ -885,8 +876,9 @@ void pci_liveupdate_finish(struct pci_dev *dev)
 		return;
 	}
 
+	ser = kho_ser_payload(incoming->fhdr, pci_ser);
 	for_each_pci_dev_in_path(dev) {
-		if (pci_liveupdate_finish_device(incoming->ser, dev))
+		if (pci_liveupdate_finish_device(ser, dev))
 			break;
 	}
 
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index c2e3a5949f73..f53f6350e53d 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -8,9 +8,8 @@
 #ifndef _LINUX_KHO_ABI_PCI_H
 #define _LINUX_KHO_ABI_PCI_H
 
-#include <linux/bug.h>
-#include <linux/compiler.h>
-#include <linux/stddef.h>
+#include <linux/build_bug.h>
+#include <linux/kho/abi/feature.h>
 #include <linux/types.h>
 
 /**
@@ -18,33 +17,20 @@
  *
  * The PCI core preserves its state across kexec as Live Update
  * File-Lifecycle Bound (FLB) data, identified by the compatible string
- * ``"pci"`` and laid out as described by the structs below.
+ * ``"pci-v2"`` and laid out as described by the structs below.
  *
- * This layout is a contract between kernels. Rather than being versioned, it
- * is extended according to the following rules:
+ * struct pci_ser is preceded by &struct kho_ser_hdr, which records the
+ * total size of the serialization and feature flags. See
+ * include/linux/kho/abi/feature.h for the feature header layout, feature
+ * rules, and validation.
  *
- *  * Existing fields must never be moved, resized, removed, or have their
- *    meaning changed. New fields may only be appended to the end of a struct.
- *
- *  * A bit set in ``pci_ser.required_flags`` marks a feature that the next
- *    kernel must understand to safely take over the preserved devices. The
- *    next kernel panics if it finds a bit it does not know how to handle.
- *
- *  * A bit set in ``pci_ser.optional_flags`` marks a feature that the next
- *    kernel can safely ignore if it does not understand it.
- *
- *  * Fields appended to struct pci_ser must be accompanied by a flag that
- *    indicates they are present, since the size of struct pci_ser is not
- *    recorded.
- *
- *  * The size of each struct pci_dev_ser is recorded in
- *    ``pci_ser.dev_ser_size`` and is never smaller than
- *    ``PCI_DEV_SER_MIN_SIZE``. The next kernel ignores any fields beyond the
- *    ones it knows about, and must handle entries that are smaller than its
- *    own struct pci_dev_ser.
+ * Preserved devices are serialized as struct pci_dev_ser entries stored in
+ * a KHO block set. The block header records the entry size, allowing the
+ * next kernel to step through entries using the source kernel's stride
+ * even if fields are added in later versions.
  */
 
-#define PCI_LUO_FLB_COMPATIBLE "pci"
+#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
 
 /**
  * struct pci_dev_ser - Serialized state about a single PCI device.
@@ -61,13 +47,9 @@ struct pci_dev_ser {
 	u32 domain;
 	u16 bdf;
 	u16 refcount;
-} __packed;
+};
 
-/*
- * The size of struct pci_dev_ser when this ABI was introduced. Since fields
- * can only be appended, every struct pci_dev_ser is at least this large.
- */
-#define PCI_DEV_SER_MIN_SIZE offsetofend(struct pci_dev_ser, refcount)
+static_assert(sizeof(struct pci_dev_ser) == 8);
 
 /**
  * struct pci_ser - PCI Subsystem Live Update State
@@ -77,20 +59,19 @@ struct pci_dev_ser {
  * core; the state a driver needs to resume its device is preserved separately
  * by that driver.
  *
- * @required_flags: Features that the next kernel must support to take over
- *                  the preserved devices. No flags are currently defined.
- * @optional_flags: Features that the next kernel may ignore if it does not
- *                  support them. No flags are currently defined.
- * @dev_ser_size: The size in bytes of each struct pci_dev_ser in @devices.
+ * Preceded by &struct kho_ser_hdr.
+ *
  * @nr_devices: The number of devices that were preserved.
+ * @reserved: Reserved for alignment.
  * @devices: Physical address of the first KHO block containing pci_dev_ser.
  */
 struct pci_ser {
-	u64 required_flags;
-	u64 optional_flags;
-	u32 dev_ser_size;
 	u32 nr_devices;
+	u32 reserved;
 	u64 devices;
-} __packed;
+};
+
+/* Register pci_ser with KHO serialization accessors */
+DECLARE_KHO_SER(pci_ser, 16, 0, 0);
 
 #endif /* _LINUX_KHO_ABI_PCI_H */
-- 
2.56.0.506.g506a7eabc5-goog

