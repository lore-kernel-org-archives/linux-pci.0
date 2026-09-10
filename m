Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D0380FD7
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006769; cv=none; b=MEcb6IOXPDtgRL56Fmcceofeto2Ix35opOh6h07VbIsm2mAtqxemFQf/81w7BM41rMYVTwRor3nR3MSJ1zb8btcM603m7kWpiJT0onpwp8P9e9q0zJ4G90wWLfWoHlo7wIUcZpJgwD9zVtHdNBV1kB/G0obYbCY1oLYHZdcAcvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006769; c=relaxed/simple;
	bh=5MOq8eSAsAE1DEdUWJh2bKxyRUZPAevKcw96z8w2iCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpOWtT/P3lydA4YUHunM1pxRAyFVGuRbf/zMu8Oxu/PkYi1CpzLM+8okZ9WieUunRuDd4mlUB9ArmqkeR5m0yHDSEE5/k0kt9Q5/2RE2k0q82dUcKYS21MH7VWDxO4Fr42OwJbf9TcrQMcKFAU4h6A7F+MkZ9r4zgNWzFOYCsOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=VADHFCCJ; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="VADHFCCJ"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cadeb7so224190585a.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 19:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789006766; x=1789611566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1h1SxGwHKtv/DLXLoTD1RLT1c1zDSUlNRXfN66S2tYs=;
        b=VADHFCCJ0oMrwyAuV+gq3S3T1vEDl2068lC9d2rFTjxV00vafkCriJ0gYPqJdvDM6E
         QmmnW5muT5H9dfORXzw0D1tFA6EpTp733t9c4d2pmigtX2S9ixfRK7cvQSTAUdKrmEP8
         SbVmWLhJ328ydZ7CkTcBv7xk4+K2xH8V9KkgLahojgkmC3r/TCle0zVlmvfYU+erW25g
         yzBxgarKDad2iMh992oYoZ+Y9tzLHlzamAqtcut/2CYJjZsZBJ5MeOYl+hF2igkA9bPS
         8cUAG5jtJI++8k9yQPSA8ZdnqU6x8SxMskzPqtIDQpeF66m6Q56wnGKocP5R9m+dODGL
         w4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789006766; x=1789611566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1h1SxGwHKtv/DLXLoTD1RLT1c1zDSUlNRXfN66S2tYs=;
        b=kfm2nyUPrse04mZNagGBKQw2S65TfdbvjY+g6tDLkcAhgUpuPiB3W9uep57idbNczq
         psbSyhlWX5vL61vpZW2cVQpm2C8kgZX9d9AUKDGcFKqkW6UN+BVUA8FFLSk/n7VPg58H
         EyvVE7c9T3i+0QRv6WTvWw++IxRy9gK9ouGRhDmkYUR7NhoAQSOnr0u5xbyGUcgiXe99
         OZOPvcOJitkwMP2iB4HAMpuSEcs9zqaH/Y6N/XHkfm8hurKRM6/mAM8N5mXyKsOE2Xyo
         o531GWzHeq8Iib0dhvDUv39kGN4sAhZxqPgFVfa29DovY/ENSJKPSAe/2yTXfJbGWksG
         O5nQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBJXMo9CBfwBP4C+bMFs2Cq1qWdlU9zJj1JxwXt14j2dH9ZlUgOp1pi3POhdc7hccn9wLrf1K50s4=@vger.kernel.org
X-Gm-Message-State: AFuF++nt8JYMdWXOxxY/lZ/jEpe07Co4h0Dh5cEBBL91W43mThV73G5R
	an2BJSTJM0F4QK7Tyk3RtkVZjx0bKVnt0hwQzRkcGkmNDqLisubmei1HA0oaUYrW2z8=
X-Gm-Gg: AYBFou0FizSMo5+FqOAFFo4Hnr8BmmKRj+M2X8eXdfF6xuKerZr0lGMvtG8kmCGnXzk
	w1kQjfHlzWGRWUgPSNXYKzkHSXGIRnDRaSrf0JWTdw40Y1vdsyaB28Qzz21e48jwB+3g8Xec52h
	asmDKFfzk8mhRkdxL8vzdMaCkQDU9RnSJLuJdi5ND1yyV1GdpUXrVvqk840Ql8h37QjTppVkKAb
	KwhCsMMwGjfztYb78Qt+EGzGjM4q1aUV5bgL5HkSjb98qku076UGKzT7nz00XzOy4foOfAkjvXr
	TrEkLkXfrr53wC7mvdTgmio/tS4x9+DWwrlWc/Db5mXifkh/OW9Sx1/JBERrdfrg6Gf+Pcn1+5Q
	QtPrjrew6vWuftkFzQ8jQ8fJ3acJpYgLjJAs4JfE1nQ+KOpZGneXyy3IgeV6lFi545pS7KA3CKD
	6rjeXIykPTd7TCgBc1Y9XfvqnSXxrGvDeBXUYw3p9a4i7rfKzr7YQWNE1ZsH1uLf1veS4/xNpim
	4I=
X-Received: by 2002:a05:620a:4089:b0:937:2e9f:70a8 with SMTP id af79cd13be357-939c94ef495mr1377322485a.39.1789006766432;
        Wed, 09 Sep 2026 19:19:26 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb70fbdsm1561375585a.32.2026.09.09.19.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 19:19:26 -0700 (PDT)
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
Subject: [PATCH v2 3/3] PCI: of: introduce of_pci_update_endpoint_node_ranges()
Date: Wed,  9 Sep 2026 21:19:18 -0500
Message-ID: <20260910021919.3421449-4-elder@riscstar.com>
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

Commit 407d1a51921e9 ("PCI: Create device tree node for bridge")
introduced the PCI_DYNAMIC_OF_NODES Kconfig option, which creates
a devicetree node for a PCI bridge as part of pci_bus_add_device().
Its successor commit ae9813db1dc5a ("PCI: Add quirks to generate
device tree node for Xilinx Alveo U50") shows how to use a PCI final
fixup quirk to also create a devicetree node for a non-bridge PCI
device.  In both cases, of_pci_make_dev_node() uses an OF changeset
to dynamically create a node populated with appropriate properties
and apply it to the live devicetree.

The dynamic devicetree node for a PCI device will include a "ranges"
property, and a new type of 3-cell address is introduced for use
within an endpoint.  The endpoint's ranges property will contain a
range entry for each of the endpoint's BARs.  The "child address"
portion of each range will use the BAR number in the "flags" (first)
cell in the address.  This allows addresses within the endpoint to
be expressed relative to whatever address gets assigned to each BAR.

Unfortunately, if a PCI endpoint device had a devicetree node set
up statically, its "ranges" property (if present) will be static,
and it cannot contain the addresses assigned to the endpoint's BARs
during enumeration.

This means that the "BAR number" based addressing scheme doesn't
work for PCI endpoints whose devicetree nodes are created statically.

To remedy this, modify of_pci_make_dev_node() to dynamically create
a "ranges" property just as is done when the endpoint has a null
devicetree node pointer.  The device node will be updated to add
the new "ranges" property (or replace it if one exists).

This allows "BAR number" addresses to work correctly even when the
endpoint's devicetree node is created statically.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - Only update ranges property if there is a pci-ep-bus node

 drivers/pci/of.c          | 89 +++++++++++++++++++++++++++++++++++----
 drivers/pci/of_property.c |  2 +-
 drivers/pci/pci.h         |  1 +
 3 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 5a040ed836744..d9c215a3bfae5 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -742,20 +742,93 @@ void of_pci_remove_node(struct pci_dev *pdev)
 	of_node_put(np);
 }
 
+/* Returns true if the ranges property was added or updated successfully */
+static bool of_pci_update_endpoint_node_ranges(struct pci_dev *pdev)
+{
+	struct device_node *np = pci_device_to_OF_node(pdev);
+	struct property *prop;
+	u32 *value;
+	u32 size;
+
+	prop = kzalloc_obj(*prop);
+	if (!prop)
+		return false;
+
+	value = of_pci_build_prop_ranges(pdev, &size);
+	if (!value) {
+		kfree(prop);
+		return false;
+	}
+
+	prop->name = "ranges";
+	prop->length = size * sizeof(u32);
+	prop->value = value;
+
+	/* The property value needs to be in big-endian byte order */
+	while (size--)
+		cpu_to_be32s(value++);
+
+	/* of_update_property() consumes the allocated property */
+	of_update_property(np, prop);
+
+	return true;
+}
+
+/*
+ * Create a devicetree node for a PCI device.  If the device is a bridge
+ * and it already has a devicetree node, there's nothing further to do.
+ * If it is a bridge without an existing devicetree node, one is created
+ * dynamically.
+ *
+ * This function can also be called (via PCI quirk) for a PCI endpoint
+ * (function) that implements a PCI endpoint bus.  As with a PCI bridge,
+ * if the endpoint has no existing devicetree node, one is created
+ * dynamically.  The node will include a ranges property that maps
+ * BAR-relative addresses in the child to the PCI address ranges
+ * assigned to the PCI endpoint BARs.
+ *
+ * If an endpoint already has a devicetree node, and it includes a
+ * "pci-ep-bus" sub-node, its ranges property must still be dynamically
+ * populated so that it can take into account the BAR ranges assigned
+ * during PCI enumeration.
+ */
 void of_pci_make_dev_node(struct pci_dev *pdev)
 {
-	struct device_node *ppnode, *np = NULL;
+	struct device_node *np = pci_device_to_OF_node(pdev);
+	struct device *dev = &pdev->dev;
+	struct device_node *ppnode;
+	struct of_changeset *cset;
 	const char *pci_type;
-	struct of_changeset *cset;
 	const char *name;
 	int ret;
 
-	/*
-	 * If there is already a device tree node linked to this device,
-	 * return immediately.
-	 */
-	if (pci_device_to_OF_node(pdev))
+	/* See if the PCI device already has a devicetree node */
+	if (np) {
+		struct device_node *child;
+
+		/* Nothing further needed for a bridge */
+		if (pci_is_bridge(pdev))
+			return;
+
+		/*
+		 * We only update the ranges property if the endpoint's
+		 * devicetree node includes a "pci-ep-bus" sub-node.
+		 */
+		child = of_get_child_by_name(np, "pci-ep-bus");
+		if (!child)
+			return;
+		of_node_put(child);
+
+		/*
+		 * Update the ranges property, defining an entry for each
+		 * BAR, mapping BAR offsets to the PCI bus address based
+		 * on the BAR's assigned range.
+		 */
+		if (!of_pci_update_endpoint_node_ranges(pdev))
+			dev_err(dev, "failed to update ranges property\n");
+
 		return;
+	}
 
 	/* Check if there is device tree node for parent device */
 	if (!pdev->bus->self)
@@ -794,7 +867,7 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 
 	np->data = cset;
 
-	ret = device_add_of_node(&pdev->dev, np);
+	ret = device_add_of_node(dev, np);
 	if (ret)
 		goto out_revert_cset;
 
diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 9f30b3c09a730..8e1548c4aac3c 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -116,7 +116,7 @@ static int of_pci_prop_bus_range(struct pci_dev *pdev,
  *
  * Caller is responsible for ensuring the returned pointer gets freed.
  */
-static u32 *of_pci_build_prop_ranges(struct pci_dev *pdev, u32 *count)
+u32 *of_pci_build_prop_ranges(struct pci_dev *pdev, u32 *count)
 {
 	bool bridge_device = pci_is_bridge(pdev);
 	struct of_pci_range_entry *entries;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e33d3bd4b0ba..1461e52777532 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1318,6 +1318,7 @@ struct of_changeset;
 #ifdef CONFIG_PCI_DYNAMIC_OF_NODES
 void of_pci_make_dev_node(struct pci_dev *pdev);
 void of_pci_remove_node(struct pci_dev *pdev);
+u32 *of_pci_build_prop_ranges(struct pci_dev *pdev, u32 *count);
 int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
 			  struct device_node *np);
 void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge);
-- 
2.53.0

