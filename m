Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D337DAA6
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006768; cv=none; b=hYHEERQWh5ODqsWKDHmAixPMIt7Gd38iiMqd2Wecgc1kWFn1mUYcf/vD5ty0baIMolMDST+a96o/WBN5wy6Pmm6gq6kKHw55zV3d3H/ocdWV8w5uSxK4+EBRqopCtAkDnnAbaHMxyCYL4/dmtSFn+pxMldCb8kh5cOlu2O9akMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006768; c=relaxed/simple;
	bh=0CIVmuZgnNf8YV7SFFeCJfSGG6AnPk/hZxzAYsVAg94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQhLFVJOMblVicHe3uuRHaU5sVBIApgDS7wqXMxjajS91Ls3A9g5b8z6WqfHLuEpbWUpl1hpXAUXqqxBQCwkj3gS3BK0CRMol6mY+PsLJ0xP2teWDK10OU0RTuTHsG+JrjSS0jR7eT/G81wlx0UVC05UEg0T2cBUu65qQqGwbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=c4bQ5Vdd; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="c4bQ5Vdd"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9399798cdd2so328940285a.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 19:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789006765; x=1789611565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6KPtyojyWu8c8G12DM6+VdUpBOs3905ZK16r2yXTzMY=;
        b=c4bQ5Vdd86XR4KEjWwEXwBRZz3sg0Fq7Ae+u/WWk9/bHtQM7N/cYj9wylH9hKuc6lQ
         /Oo+zC7huDlTwbykwV+gq+Iw2xr4ZZL4LeNRGH2kzJMUnX/hpa5KdshkiLgddXXOf+zQ
         HDlQ10X/JPyN/l9FRbrguzTTSdmtoLpocY4/ZiDGr8l0iOwO2qmKnLFpO+saerSbap66
         v9NyWVlWxXFv1mfmxaF0lHZsaJQWN2KEOzjEM5bcI5KPyPZSm+byC/+dNiMhjbqWDhAX
         N81aP0IZW3b0yKp/In/WHadiuW51JPoKA6Hs0XL+3aCkHoayQZKd62mfjwBc5tj14/KT
         XvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789006765; x=1789611565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6KPtyojyWu8c8G12DM6+VdUpBOs3905ZK16r2yXTzMY=;
        b=tWG6748WRJ0HZf7eORrDFyKHOAOycFoop/sKmfg5dfSTkjzBYF8TD8Cug8JFllMPl9
         8s+bm3+3XF1s7yRvZ3DqrUrvzuCnjI6L7YSzfUuFv8HVXvbYrN5d7iADgqwGWH0TP6KO
         aFbJ8q95dJ4weNPDuHQMnPjj7oqs6tTFN+yTX2Azc4gfPMGNDlge7j4f/J2ohynNdZGu
         AJWIpAfjG4b/tZ8cTHFaLZ8Y5Du/FCSvFz07SkUoZ43ppHnjQKj4O0TV2NhsbMCC5h+3
         iUI7a96UYi+H1LfcpcIbROahTjMNrSFnDUobPk9h5cIqot/adj4ca48cArs0cbmKD4xC
         tqhA==
X-Forwarded-Encrypted: i=1; AKwUvBwviuoB+3JL8F7sni3uWZB2xgp7gU7FjqXq/FNWq2OOV98qgxKwBhiT4hNWjC+CJdEBX2mAbZaMFeM=@vger.kernel.org
X-Gm-Message-State: AFuF++k7/Suj8BSOnRyL/O8d2cCCae5rS/CDJvEVm7ov1RE1a2ecQmvk
	RT3Ep0WaMVF681+KPuy+JuA/DLlWRyoo0yogJ5Kmb7i7Di2Y1DrYTR5kagc8r/p+Zp8=
X-Gm-Gg: AYBFou0YpVBWbLrT1QlhE8hwDlBzv6ZQKHhQCuBDmWTxzna3EYRXN5RjnxFkf7XlIKh
	1vLmqZb2XRsaQ2kfbB9qD0HTkVW4E31fukV0i1TQDuOz9KTDjKYWq3Q9JOIZivF84+jh4wG9jNs
	TwSYJZUd+pbAFkK6UctAc5C6V+BxCzr2Qw4Rk9Wq59hkbCFztWz8rIYQIaGNuW+3avNy/NG9igC
	iYgsqIT/CiOHLtoevr0mBVVqQIYYcME+ADNGYC6ETBCRHfeRoH4pvsDTusJ5zEu3jNyQGoulP0Z
	TsZWkt70XkPGGdjOCOS7BeJZHSxoh9QiOjBR1AgBJbxdvbex2MwBMnnCj6t8ziCN92rQrz4Zega
	6OpvgrMqnWfUNDS42nzRQMRnuKnD6ZxVuLQ0KcRSMx51cy3+a9wM5gkjZjGEfu2q+duntQ6hakC
	Tm9oCYauvTVA9PF89TWoPVFwSgVUaMJTs84la7rRJSA4tFDP/d7kZtm3XvefOQYQwAV6D6w8LAw
	cw=
X-Received: by 2002:a05:620a:298a:b0:936:623e:2603 with SMTP id af79cd13be357-93980371472mr4079820985a.17.1789006765265;
        Wed, 09 Sep 2026 19:19:25 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb70fbdsm1561375585a.32.2026.09.09.19.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 19:19:24 -0700 (PDT)
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
Subject: [PATCH v2 2/3] PCI: of: introduce of_pci_build_prop_ranges()
Date: Wed,  9 Sep 2026 21:19:17 -0500
Message-ID: <20260910021919.3421449-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910021919.3421449-1-elder@riscstar.com>
References: <20260910021919.3421449-1-elder@riscstar.com>
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

