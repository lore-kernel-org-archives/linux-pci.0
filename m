Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1A481FD9
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764246; cv=none; b=hSWo58OcjLH5oAe39r7Js0vSGhQTseBVsjPkdljjzDsr2Z90LkoLICBAfR1OPgxrrhxLCABbfIBuw/Bn3bwlGvkzwJrY0OmqOZGGamODoxvbdD+JUNSXDtu6W7i6icsWS56FnGwylSUlfzUMij5e/jkCfn6Y5YrE8C9NCZS1HRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764246; c=relaxed/simple;
	bh=8JXMc7lICiY4imhp8T3WyvJjIwFnQZv+iq3xdFWp5HE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TkngaPgs8L4RQD9dE8JtTLD2dZDxSF7pQE5QhmrrZbad15eaMnOMkRBaHcmjm7gwzd21nHUgLgywn6RB8lFUQ0f7Q8TerZrCGTcXqHvUkMWYZtdGOeQlzV+/Qh3jjR7iOcjlH647A5dHaew49YT+/lbZBscXNX2byJZP3LR/mLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o77TXyhy; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o77TXyhy"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e6422198fso34460505e9.1
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 03:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790764241; x=1791369041; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+NnPTIfhJPHcozdp8orOSYYcaDHqwBt50sr0C7OxxaU=;
        b=o77TXyhyXCKo5bXxCRNlHUcIcSkco70rETJc1FPh8G9/eUVBHYr8owZcO55Mf2vvBu
         aoo8a62t2cmfVbDaiMf/IcblBQuVwidXLwfN90SPqiEdwKfZdNqM9Iho6U3BZvvBa0KC
         gUOeGrZH87glDxjziYqLRD0tefosLP7kh1A/yH2P/aCx6PESIIF1EtoNBdpnY/sMIW6z
         lF/imDaYu5KJQJXi13lKTbCnUL4WO2EQbyyN1zTCNlCbg+vBJI3inN5U6enxATjj0chR
         HGkOF5a5shJme/fpJf2QVD37F36paf/6C/t9Qt1wOO/ouQfg+nij1FnRPZqkJo1OQ6ds
         u7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790764241; x=1791369041;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+NnPTIfhJPHcozdp8orOSYYcaDHqwBt50sr0C7OxxaU=;
        b=f0WM5gGkDzXuO5OzWRdB03A9NmdyUlELdEYwiGHhgVRNasjdpv92WzN/HhIRhX4tss
         o5B9ItA1g5x3Gft2h1MFzbnpHE5w2v+Kvez+4umKdqIGDjuUpiapJ1Yaj2EQ0OdmmuAN
         EbdR1fCZW96be9R+FuvlIyzQjHk2pbgsO4r2h+TGUEMBFzCd/BZtJnRXszWxPXzaplIy
         HlF2TTXwzc2x98xXjcscKykSFCk8vGy6NPg7nmCAwGFd5hgO2BkKcO+pwkXymd8oedEr
         T61p0UCvKEA0/fmpj2d62Hq+TEfJ9vlWkzDU8NwqdcNMVTZzbz4KpWSMEiNPQWGOjA04
         +Vzg==
X-Gm-Message-State: AFuF++kmpdyKBKbiH8nq2Pqx+spqi5CuAQfhIyrRBiJUe9bD9E7PoLNj
	Lcvo7suqMb1qatSrPfoHzRqHi3K1SxEUG6qDFE9lsoOcztGVeWDwH1luDK4YQcPo9CrZwUUrLf1
	kBWPNM3EHXavk+txLNb3CndpZ2PycDhRL0sFgX3Qq37NfhUVDyRtacDFK505p+glr4hqoxKnqkl
	ufrxoyZw9KyYIa/RCZcg6qrIoUpRUA9g==
X-Received: from wmcv6.prod.google.com ([2002:a05:600c:4286:b0:4a0:5ed:a8e5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a43:b0:49f:e69d:9df9
 with SMTP id 5b1f17b1804b1-4a01aff0776mr14225345e9.10.1790764241251; Wed, 30
 Sep 2026 03:30:41 -0700 (PDT)
Date: Wed, 30 Sep 2026 12:30:31 +0200
In-Reply-To: <20260930103036.248989-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930103036.248989-4-ardb+git@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930103036.248989-5-ardb+git@google.com>
Subject: [PATCH v3 1/2] PCI: Add __pci_bus_alloc_resource() to allocate with
 explicit flags
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

pci_bus_alloc_resource() decides which bus resources a resource may be
allocated from based on the flags of that resource: the type bits
selected by @type_mask must match, a non-prefetchable resource is never
allocated from a prefetchable bus resource, and only a 64-bit resource
may be placed above 4 GB.

In preparation for placing some non-prefetchable BARs in prefetchable
bridge windows, factor out __pci_bus_alloc_resource(), which takes the
flags to match against the bus resources as a separate argument, and
implement pci_bus_alloc_resource() on top of it by passing the flags of
the resource itself.

No functional change intended.

Assisted-by: LLM
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/pci/bus.c | 70 ++++++++++++++------
 drivers/pci/pci.h |  6 ++
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 655ed53436d3..65a54d6e049e 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -188,9 +188,9 @@ static void pci_clip_resource_to_region(struct pci_bus *bus,
 }
 
 static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
-		resource_size_t size, resource_size_t align,
-		resource_size_t min, unsigned long type_mask,
-		resource_alignf alignf,
+		unsigned long flags, resource_size_t size,
+		resource_size_t align, resource_size_t min,
+		unsigned long type_mask, resource_alignf alignf,
 		void *alignf_data,
 		struct pci_bus_region *region)
 {
@@ -210,13 +210,13 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 			continue;
 
 		/* type_mask must match */
-		if ((res->flags ^ r->flags) & type_mask)
+		if ((flags ^ r->flags) & type_mask)
 			continue;
 
 		/* We cannot allocate a non-prefetching resource
 		   from a pre-fetching area */
 		if ((r->flags & IORESOURCE_PREFETCH) &&
-		    !(res->flags & IORESOURCE_PREFETCH))
+		    !(flags & IORESOURCE_PREFETCH))
 			continue;
 
 		avail = *r;
@@ -247,9 +247,10 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 }
 
 /**
- * pci_bus_alloc_resource - allocate a resource from a parent bus
+ * __pci_bus_alloc_resource - allocate a resource from a parent bus
  * @bus: PCI bus
  * @res: resource to allocate
+ * @flags: resource flags to match against the bus resources
  * @size: size of resource to allocate
  * @align: alignment of resource to allocate
  * @min: minimum /proc/iomem address to allocate
@@ -257,36 +258,61 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
  * @alignf: resource alignment function
  * @alignf_data: data argument for resource alignment function
  *
- * Given the PCI bus a device resides on, the size, minimum address,
- * alignment and type, try to find an acceptable resource allocation
- * for a specific device resource.
+ * Like pci_bus_alloc_resource(), but match the bus resources against @flags
+ * rather than @res->flags. This permits allocating a non-prefetchable
+ * resource from a prefetchable bus resource by passing @flags with
+ * IORESOURCE_PREFETCH set, which the caller must have established to be safe.
  */
-int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
-		resource_size_t size, resource_size_t align,
-		resource_size_t min, unsigned long type_mask,
-		resource_alignf alignf,
-		void *alignf_data)
+int __pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
+			     unsigned long flags, resource_size_t size,
+			     resource_size_t align, resource_size_t min,
+			     unsigned long type_mask, resource_alignf alignf,
+			     void *alignf_data)
 {
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	int rc;
 
-	if (res->flags & IORESOURCE_MEM_64) {
-		rc = pci_bus_alloc_from_region(bus, res, size, align, min,
-					       type_mask, alignf, alignf_data,
-					       &pci_high);
+	if (flags & IORESOURCE_MEM_64) {
+		rc = pci_bus_alloc_from_region(bus, res, flags, size, align,
+					       min, type_mask, alignf,
+					       alignf_data, &pci_high);
 		if (rc == 0)
 			return 0;
 
-		return pci_bus_alloc_from_region(bus, res, size, align, min,
-						 type_mask, alignf, alignf_data,
-						 &pci_64_bit);
+		return pci_bus_alloc_from_region(bus, res, flags, size, align,
+						 min, type_mask, alignf,
+						 alignf_data, &pci_64_bit);
 	}
 #endif
 
-	return pci_bus_alloc_from_region(bus, res, size, align, min,
+	return pci_bus_alloc_from_region(bus, res, flags, size, align, min,
 					 type_mask, alignf, alignf_data,
 					 &pci_32_bit);
 }
+
+/**
+ * pci_bus_alloc_resource - allocate a resource from a parent bus
+ * @bus: PCI bus
+ * @res: resource to allocate
+ * @size: size of resource to allocate
+ * @align: alignment of resource to allocate
+ * @min: minimum /proc/iomem address to allocate
+ * @type_mask: IORESOURCE_* type flags
+ * @alignf: resource alignment function
+ * @alignf_data: data argument for resource alignment function
+ *
+ * Given the PCI bus a device resides on, the size, minimum address,
+ * alignment and type, try to find an acceptable resource allocation
+ * for a specific device resource.
+ */
+int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
+			   resource_size_t size, resource_size_t align,
+			   resource_size_t min, unsigned long type_mask,
+			   resource_alignf alignf, void *alignf_data)
+{
+	return __pci_bus_alloc_resource(bus, res, res->flags, size, align, min,
+					type_mask, alignf, alignf_data);
+}
 EXPORT_SYMBOL(pci_bus_alloc_resource);
 
 /*
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..8297cfb5dcd5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -567,6 +567,12 @@ static inline int pci_resource_num(const struct pci_dev *dev,
 	return resno;
 }
 
+int __pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
+			     unsigned long flags, resource_size_t size,
+			     resource_size_t align, resource_size_t min,
+			     unsigned long type_mask, resource_alignf alignf,
+			     void *alignf_data);
+
 void pbus_validate_busn(struct pci_bus *bus);
 struct resource *pbus_select_window(struct pci_bus *bus,
 				    const struct resource *res);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

