Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E484078F4
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790288692; cv=none; b=up+nvQyPG2hvdJUzxOqu7LpopyygpahLZ9eqHFODyAtF8Nd28kjxDvsSpSxZWUgtBdeUudbQcU2yp8YiyHQ8CBpu0l59KLKThlHiv3ZZzUnwoq7JVlm5H5ABA0cxBoqSAHeibS8/GCXWgk78GVGCFJbqlTj3thoUSuKQbzfK/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790288692; c=relaxed/simple;
	bh=0CIVmuZgnNf8YV7SFFeCJfSGG6AnPk/hZxzAYsVAg94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSLmR778ryrMHaEz7J7Xca6KTQgNPuwy/wOOcI9kVLC+4VR53Yj8zl0E/1LtBWhRUuYllWYOC91F/bMqb1QmOAF7Zo/OhpxWuk1CrEnT9iYEhQw5yKDetEV3Lg8zumJVX5fVk68FnONr3kJcYDwfArIMYIf9iDHbzjUaWhFo/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=aYfqdwNz; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="aYfqdwNz"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6eeso3565406d6.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790288690; x=1790893490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6KPtyojyWu8c8G12DM6+VdUpBOs3905ZK16r2yXTzMY=;
        b=aYfqdwNzmrhK/ZT8hwr78Pg/K66I4hGu9UH21yCQmCiShVzUvFNIB19fICI+/ssccE
         n+lLcj4YaXunSlTUg8AN+QVO8eVvvPcTary57wQD7jB9PRYsQ+CmfAWlVCa51sA72Ml7
         b4V4Exqt9D4T6t4hYqrwwP79h3kpUXg8vMFvl8rNFTU5bnNBIYMwK2lYzIrrPjt2hf4D
         uyBsYWNVkjVWLRhDKK5E3NroWcH7raq0yWvyovdpowY4dn+vT2iY6ht/yIj5edKDKyqW
         /haTs2mmkdwhOGpaAPbhHhB+LuIENjyJWHCI6DUkn0ZEIPPYkmf+4XoWLkJ462KQZh6Z
         9Dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790288690; x=1790893490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6KPtyojyWu8c8G12DM6+VdUpBOs3905ZK16r2yXTzMY=;
        b=XRsG3r0x3PA7fwQoWXdE7OLJY+jp75N6Uf0tPwES1zpXzvvWdruTe2PZRHaTVaNHXk
         z2bsgaATUQZ26sczXkCvBkHanJ3sYBRxiG1LtHpq9JzrKFHbzvcKzVmIBy87WNgtagZ9
         zYslzaWW4Fc/u0J6Ux4XSnvAo5bKhozBiKim0iWRQawKUzby15GQMnYyLEstehDckcn6
         Jv6GLS5K7+SNNYAMaRofxPBHdBa+MTWXUtSf72KgmNuJEEfImrnTHC2yFtH4vo99zaBF
         8YIWlOmRpIEqkhGvulH8RWPxMkANSUiwCyBlWeFGLYe4CZz12OMUxbvP9YGfDBEqHHA6
         Meyw==
X-Forwarded-Encrypted: i=1; AKwUvBydYpI5IxU0WKxoZltselztWI0EAeHmdhaJuboTMEDKe7c9d3QyPTzdASo7PrHwoUkUhaHL50R4tlM=@vger.kernel.org
X-Gm-Message-State: AFuF++mDCaNmp9gO90GGGEQY1eiK9oOkR6AgqC2ZXzNab/SD/LwIbX4D
	CcS7jZpFuqQ72zRSmaID1jCAcJsSRrf0wJvmKSbssYYj0Fmu9C28B9PgqaKtmS+RuSM=
X-Gm-Gg: AYBFou3JjUu6cIJlkdSX7qgplFqjBKGRwa+QZRI5aQok0Jzx6AD4r34euy+/MOq5X9g
	ZjbZHxoJ2aAZ2J1EQbTKf4vN26wW1tVQOc8aFmf+oH8VSPXuaujC4dPeEM1wUw5TM53gVvtkIbV
	H+dnUU+WnUfpPzJQU+nM/8izul+kJ6n4AQlUDH4lLx2KgLFLb6lscjTFdRALLIGbR22qRu7mM9z
	XRHky/aN0etY5nNIM68ILX38Xng56cXoFkxp3qCBg1lEGCnd79MSeZdEhNbpwDzF/1BwkovJsZc
	VLJlamkiKmJh5nQUbFQLftU511P7p+70FmaxJFfA1DBaUfpfMt/2XPGQBJyVs3y2yFDxK4vNDxI
	W8ka2haZNQxwdIuthsjzbI5jm2RkFPKimQAjjNhaz/qTCz8VTBtCYHrE0i7P5z9Sb9Dvu/Q3ey8
	YZYQgkK2+DZANR06lalrubSqYdOWbJFvlxfDTLU0xP4Y/RYZFt6vChlETpUVN2h36UwKGRDhdS5
	2GemtEOMaaLsg==
X-Received: by 2002:ad4:5ec6:0:b0:912:15a8:bd9f with SMTP id 6a1803df08f44-9142f6a130dmr13977176d6.7.1790288689912;
        Thu, 24 Sep 2026 15:24:49 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430eaf5basm3516496d6.44.2026.09.24.15.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:24:49 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com
Cc: lizhi.hou@amd.com,
	herve.codina@bootlin.com,
	andrea.porta@suse.com,
	daniel@riscstar.com,
	mohdayaa@qti.qualcomm.com,
	lbiancon@qti.qualcomm.com,
	mani@kernel.org,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] PCI: of: introduce of_pci_build_prop_ranges()
Date: Thu, 24 Sep 2026 17:24:42 -0500
Message-ID: <20260924222444.1351466-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924222444.1351466-1-elder@riscstar.com>
References: <20260924222444.1351466-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the bulk of what happens inside of_pci_prop_ranges() into
a helper function that builds up the value to be passed to
of_changeset_add_prop_u32_array().

This helper will be used in the next commit to build the ranges
property for a statically-defined PCI endpoint devicetree node
when it has a "pci-ep-bus" sub-node.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/pci/of_property.c | 129 +++++++++++++++++++++++++-------------
 1 file changed, 86 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index a6c0cca986bdc..9f30b3c09a730 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -102,57 +102,100 @@ static int of_pci_prop_bus_range(struct pci_dev *pdev,
 					       ARRAY_SIZE(bus_range));
 }
 
+/*
+ * Build a "ranges" property value that defines the mapping between
+ * child and parent PCI address space for each of the given PCI
+ * device's resources.
+ *
+ * Returns a dynamically allocated array of u32 devicetree cells, or
+ * a null pointer if allocation fails.  The cell array is built as a
+ * of_pci_prop_ranges structure consisting of 8 32-bit cells in host
+ * byte order.  It is suitable for use as the value of a PCI device
+ * node "ranges" property passed to of_changeset_add_prop_u32_array().
+ * The total number of cells in the array is returned in *count.
+ *
+ * Caller is responsible for ensuring the returned pointer gets freed.
+ */
+static u32 *of_pci_build_prop_ranges(struct pci_dev *pdev, u32 *count)
+{
+	bool bridge_device = pci_is_bridge(pdev);
+	struct of_pci_range_entry *entries;
+	struct of_pci_range_entry *ep;
+	u32 resource_count = 0;
+	struct resource *res;
+	u32 first;
+	u32 num;
+	u32 i;
+
+	if (bridge_device) {
+		first = PCI_BRIDGE_RESOURCES;
+		num = PCI_BRIDGE_RESOURCE_NUM;
+	} else {
+		first = PCI_STD_RESOURCES;
+		num = PCI_STD_NUM_BARS;
+	}
+
+	/* First count how many resources will get a range property */
+	res = &pdev->resource[first];
+	for (i = 0; i < num; i++, res++)
+		if (resource_size(res) && !of_pci_get_addr_flags(res, NULL))
+			resource_count++;
+
+	entries = kzalloc_objs(*entries, resource_count);
+	if (!entries)
+		return NULL;
+
+	ep = entries;
+	res = &pdev->resource[first];
+	for (i = 0; i < num; i++, res++) {
+		u64 size = resource_size(res);
+		u32 flags;
+
+		if (!size || of_pci_get_addr_flags(res, &flags))
+			continue;
+
+		/* Record the size in the range entry */
+		ep->size[0] = upper_32_bits(size);
+		ep->size[1] = lower_32_bits(size);
+
+		/* Record the parent bus address from the resource */
+		of_pci_set_address(pdev, ep->parent_addr,
+				   pci_bus_address(pdev, first + i),
+				   flags, false);
+
+		/*
+		 * For a bridge device, the child address matches the
+		 * parent address (including its flags cell).  For an
+		 * endpoint device, the (flags) cell contains the BAR
+		 * number, and the two address cells are zero.
+		 */
+		if (bridge_device)
+			memcpy(ep->child_addr, ep->parent_addr,
+			       sizeof(ep->child_addr));
+		else
+			ep->child_addr[0] = i;
+
+		ep++;
+	}
+	*count = resource_count * sizeof(*ep) / sizeof(u32);
+
+	return (u32 *)entries;
+}
+
 static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
 			      struct device_node *np)
 {
 	struct of_pci_range_entry *rp;
-	struct resource *res;
-	int i, j, ret;
-	u32 flags, num;
-	u64 val64;
+	u32 *value;
+	u32 count;
+	int ret;
 
-	if (pci_is_bridge(pdev)) {
-		num = PCI_BRIDGE_RESOURCE_NUM;
-		res = &pdev->resource[PCI_BRIDGE_RESOURCES];
-	} else {
-		num = PCI_STD_NUM_BARS;
-		res = &pdev->resource[PCI_STD_RESOURCES];
-	}
-
-	rp = kzalloc_objs(*rp, num);
-	if (!rp)
+	value = of_pci_build_prop_ranges(pdev, &count);
+	if (!value)
 		return -ENOMEM;
 
-	for (i = 0, j = 0; j < num; j++) {
-		if (!resource_size(&res[j]))
-			continue;
+	ret = of_changeset_add_prop_u32_array(ocs, np, "ranges", value, count);
 
-		if (of_pci_get_addr_flags(&res[j], &flags))
-			continue;
-
-		val64 = pci_bus_address(pdev, &res[j] - pdev->resource);
-		of_pci_set_address(pdev, rp[i].parent_addr, val64, flags,
-				   false);
-		if (pci_is_bridge(pdev)) {
-			memcpy(rp[i].child_addr, rp[i].parent_addr,
-			       sizeof(rp[i].child_addr));
-		} else {
-			/*
-			 * For endpoint device, the lower 64-bits of child
-			 * address is always zero.
-			 */
-			rp[i].child_addr[0] = j;
-		}
-
-		val64 = resource_size(&res[j]);
-		rp[i].size[0] = upper_32_bits(val64);
-		rp[i].size[1] = lower_32_bits(val64);
-
-		i++;
-	}
-
-	ret = of_changeset_add_prop_u32_array(ocs, np, "ranges", (u32 *)rp,
-					      i * sizeof(*rp) / sizeof(u32));
 	kfree(rp);
 
 	return ret;
-- 
2.53.0

