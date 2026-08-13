Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498F3B992A
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658845; cv=none; b=tuTZmEPgD9g5xXVo4DzEnMj/3BueccH0vXm/DEGr1AYkSGeQEFVmt/8Bdxg5maCb3+eCqTc0YYSt4/YMrQRwfkI9zlsIfAEcgsWqWhDZPoeJid037nGoRvmPuRC6szbCVptReasttJdAsEexkEZls77F/3mqgsyfucu3m1Dkx7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658845; c=relaxed/simple;
	bh=Mkby2ZZjOjlDv3MHtDaj4gswaNICXPXgslWkaE8ZqMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REaKP6CMCxdMkUuNJzqs9Yaf7Q8jlrMKMYjyiL6QDaGBd4DN/o/aTDltQ45VfELOn7l1OaTswi0DRvk1avga4eLI4Wqua/OIpfAQfq6wOnNjCdu9agrtzBfhFZoV+44wgkFrws82dG1p10F+78/cePnJrgeSp2RN/2UBMj3gw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=x85iwUXo; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="x85iwUXo"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-934a3d14924so39811985a.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786658842; x=1787263642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EbJCpDF5CkgJflqIXKMCvmyQaQddY52+uArgjdbnoDc=;
        b=x85iwUXoGKkpoSLBE+SSrmZOqvYgneG1MZi5pOx3kLtYkAItbvYcWrqfdKFf2Tvd22
         yKLSoJ8q5iPS7hr9scP5z0kkfbAvEI+rWpp8K+q8ynvfXkOY6fReAe3XlI/goM6iAHbs
         tIyBRsJz+wqdBlMFTNHLEfsLiVTxVd4D6SvNZhYSrLxboeCZXIXAWXg3jR3zy549zjlx
         eRIeAypvDyolsraEsVKamjWFpyyxAox5RnT3m4+1c6AdiU7f/UH1VndoOlKkuT2QdEmt
         wQ1IHcQ3gYsUhPaAcLVaoeBi7dcNQIZkI0q5LCqEzDgQaKYxRZxKI8+Bh6X42g0zhfv9
         I6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786658842; x=1787263642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EbJCpDF5CkgJflqIXKMCvmyQaQddY52+uArgjdbnoDc=;
        b=LkCU2Nvp1qgJ32/mDcFOix4dn60IUA8ho4r/vdyX6OYSSkqKNDqBYE/3AUOThzandF
         rNk5yiskihp1nnAh7UUngiCv/H3hHS1cnI83Q3+AI6Bd5mMrMskQMO+e77bK/MZVjaiz
         FlTaiLbOkUJKpzotZGX/Zti80Mz2w8lHjp84Toh7pffUP/UhL60iD02PAQ0EM7QtqVZH
         Wwa4ecdYVBLH0rRiGbuFf1BmN6NyU6bD9UqmDq4B5b2vfkjztqxBTC9c2ewPzCjqRsx9
         z7pdugBsk1b0UNTpTn+2y8C+DlgCOQJInm1/gh1VvM3a1Nwsb91Hs8BWhih0tRBfcJh3
         2aTQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAQ03qZh4uthtppAbBzH9VRdk4qnerxEuZZFnz8yziN/Uftly8aqVK26cGSde684ERA2NJX/WlaUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK2RK7nEW6oLrwNQHk8odtwhMZVlnH2FMYlxYoyz1XnuetYFFX
	EzELpD5V5hubbV4SDfefyxq7iwMeb8b7tja7Pizu2AsMRQT2ety2pYopqGeIu8/jB5Q=
X-Gm-Gg: AR+sD11CFECUHrXjaD9OEzlvH3jqBfwqgkowiISvknmvBjnjo/2m789z5fdL6H3oSrh
	kvKa5w4AdQftnpZdXfGyuAyTvkz807SlxoIbfeRup1ACH/vtnXns1ulS01q383yaZRH0iOgkpFF
	RE867K/QvyYSqkmm+cUCthuMCzH3kpj+ZQDm/XBi/E44EFBxb/3u2KSHSRKA3M2l7wEMLSR72Fs
	sV9soAsf0Sv4d9xQ8bJaGS6pcB2JMt3OylOQd0KIjD45yvca5AEhim2AMznC9bdN/I1P5S40EVj
	dclaokYWDpAqZYZ+gK5ZyRi4Y/B7FDbwNHsQzkqg+J4AuYvpxR9lREIufbVtZjFMgYAmf0pzmyG
	gW1cbVSIiTfsVwqCEQli2Y8JZezcYdX8TbiC2rbjpiAA/rIB0A8ay0cmki/m1LfKOInxALm/nXe
	RCaO6Wqs9FPfXSXkJ4nsb2lHixRLlum967/Nc1FfchZWlsHSmV+7T9AOmRn5bsdX+Q
X-Received: by 2002:a05:620a:36f3:b0:92e:dddc:6588 with SMTP id af79cd13be357-936d232fe69mr93837085a.42.1786658842343;
        Thu, 13 Aug 2026 15:07:22 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce22e990sm86776985a.38.2026.08.13.15.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 15:07:21 -0700 (PDT)
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
Subject: [PATCH 1/2] PCI: of: introduce of_pci_build_prop_ranges()
Date: Thu, 13 Aug 2026 17:07:15 -0500
Message-ID: <20260813220717.1394644-2-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813220717.1394644-1-elder@riscstar.com>
References: <20260813220717.1394644-1-elder@riscstar.com>
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

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/pci/of_property.c | 129 +++++++++++++++++++++++++-------------
 1 file changed, 86 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 5e1820b8bb79b..48ce467e7e966 100644
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

