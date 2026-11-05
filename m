Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913859;
	b=ispFJ8khkIUBJjgpL53aJBIpo9VptqSIHtrPsjevrmx+2eklg3q9XJjaCiUa9daSHZvA
	 b9Sgj9d61ljxnDY8mEh+EtJI42DtDb3sdr3o8otq7VnixAAVj2F9b+1zICTcxbk9ErSOI
	 rd0SIErMtqjLlHq3Svj7FFbdk1Erpkm5PCoaem4keESbKdL5JXq1gp4qj4AKariafsoYx
	 3dpj0mip4kghfA9hPC2nhu5lLo8JkVnW+tTVuXkwA+9WvGwmaUU5c0275BMNsIx2KmAa6
	 Zf1VDkxHnLwleYdTcZSnK67Kbz+6mFasfVScW2fKyU3PdHnAMi3PDDgBXo3HyVumSTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=647ljXCJztGicp7YV3FS/mcGU5fzbToeSjHEko7ri7o=;
	b=1vXjJpMArVkH/RDIyCoXsKkUz54OQa85fUO07VxKxi1HJEFobTHjcSVvnoWYtCZ4y5cm
	 Y5xXfbBqH5ayvSCx84AXY/MGn9WlnFVtOaulAFxzOZ6iG3lMGAC1pklBBmpisGS0Ad1nO
	 3QCJOaQqvFGt/Ut8JyUgavCMoRC8obtK+N7F1qB1IANIsZA8q/F7tvRGqwQX39iJmcd3Y
	 vrS2wiX6VfVr3AG8BX0PWkgjLpVz+DJvj5W+/GFWOfB36jDf99qJl1JCrvQRnhjFu4XKy
	 GvH6PraYg1ejz25BuQwHMQuh5y/n5iacB6T3/dvraObZX/zzDRSrbdMcdeC1NQLfh9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riscstar.com;
	spf=pass smtp.mailfrom=riscstar.com;
	dkim=pass header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=3tixUHaC;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA3606D812
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 21:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19AA3606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=3tixUHaC
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-48ed0b68895so1446327fac.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 13:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar.com; s=google; t=1793913858; x=1794518658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=647ljXCJztGicp7YV3FS/mcGU5fzbToeSjHEko7ri7o=;
        b=3tixUHaCUkrk9WS78wwur2uKuD+nh8UofCPfmONePQb1e545u7gspVfjUByNQsDtcs
         5P9/y5AtsfVxU19INadG09sT5oSuMRFFc6pnECgDuV6SRMyGnudpVhLdf5YW1VR7qqSW
         Slej3GUUy5vbd+z52OIUdYqVPcfzdWQtRpJ7jv6XnQxQZNxbjwSxg7UFDugz0eQY612d
         SDpe3QwRW7bFxMBxGUuG9Hoa2ZDj4AnQCERnj3nGSKrAxbgtPXGf0z3OM6nTBnDwHeeB
         bn9PqfCikqyhAeqw2Xo/ZQGCgIxyxgIf30VThPjyzecZ2sYtEdNIj/eeSCoMHCqZYGGU
         4E+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793913858; x=1794518658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=647ljXCJztGicp7YV3FS/mcGU5fzbToeSjHEko7ri7o=;
        b=Q5N5Dy29fcOP/7UzUcK5kH8bwe0pzOPodrkycqbt3lhFemauNrJBgqQlxuqHbJj9ZC
         YY9co1PYTUxtpe37CyXb2Q2T7BQK0fx/L+nZXp/+RYx1YyAFzaEDMA7I5x8x085Q6HA8
         T0eIMLL4kIeDGuZFK+k1z+h2XBjRLUVxcjTu37jyA1Ih7E1S5k505gFGtN9w0iu/uOc3
         hdnXWKogqBf93WOdZDPyqPI6t2FcnWfiGg2KFbcNUnQZdNvN9m32ZBvXQ8H9+3gRbDbh
         gDtqllBp5K4yxFGFLf2G7PhdCZ2+J6Qu1Yy6p5UcF+AwaAGzbVXVp8RceBNsMIRpwhg+
         xcwg==
X-Forwarded-Encrypted: i=1; AKwUvBw8rMkM64Ro6ix33auGshMMbnK/RcaU1EsjhERNb+sZB0gqHGdAgyd9+qjB1SGgvSBUZ0CHh533Uyg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uKltuXb9ZzxGRvjgtQTI5P9kRZTpEGI67peXds4ELR1vXsffX
	B6mP4Ntqk39IFFdsDmC1QoM4mMlKdCAhZnMADRcwFogo6/3zn8yX3WZMqDZa9z0huV4=
X-Gm-Gg: AYBFou0dlVgrPJiOkixFZ7w8AOawJ1uGUWGQmwnfKY2lVPkrgqPVLqkgO+NV7jFfu3z
	TEQxP/zumbHtN+I8H4pFFYJ6Z7zR129t9Cgd6SU03AZU8DW351Fm6yibpXiK9yV/qA6PLTVn5Sa
	j61/SBpH17xgV8PD3efNZ87tNt+1VduqsCQmSVcKLhyio+7f0r0Nq3AgtKPtTIiw/hgv1oi59Qq
	KdHtyfUM5jelfjOA7RTq3PlcmJdvJ+R+yg4AOsIgUMSxXRiHqnJxjR+1CqSvQ/kgwpZiiMcQpUP
	4CwHqebjFjscap85/28K24e0zhQu8J7zGXjqI2ni+YVN+KE6CsolVnH1lbmi1K+hsPGR90ysERC
	tYRqEGKTVxI3dxRyODvIyuy3Ark8beLMkOEc9KjEkJr86U5TeJoOQkw39zPc7IarqAke84P+Hsx
	6a4dqUpifxlzjeKtbIBfUMnP2W3t3bCO4YsXt4hZrwAg+9SbLALgQvp0xk2otogIO/UsakTW7YV
	5F7niYKnafzhYB5vxDWp2ckiABdp6LmE1vIAUi8tylCzEECNzkITE1LyOEeUrygPrkOd4c33V/P
	Mntyoe/HJb2USSa/818rsOG4fkz6bS0pInvcV9gJSi/NAOi2nLmrK6w=
X-Received: by 2002:a05:6808:4f6c:b0:4f5:e13:95e2 with SMTP id 5614622812f47-567e0f327abmr531990b6e.9.1793913857962;
        Thu, 05 Nov 2026 13:24:17 -0800 (PST)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm5349897b6e.3.2026.11.05.13.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 13:24:17 -0800 (PST)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v4 2/2] PCI: of: introduce of_pci_update_endpoint_node_ranges()
Date: Thu,  5 Nov 2026 15:24:12 -0600
Message-ID: <20261105212412.591931-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105212412.591931-1-elder@riscstar.com>
References: <20261105212412.591931-1-elder@riscstar.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
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
a "ranges" property even if the device already has a devicetree
node--just as is done when the endpoint has none.  A few conditions:
  - A PCI bridge node's ranges property is never updated
  - If a PCI endpoint node defines a ranges property with a
    non-empty value (i.e., it's not just "ranges;"), that
    ranges property is preserved

Otherwise a new ranges property is created using assigned addresses,
and it replaces (or adds) that property to the PCI endpoint node.

As a result, "BAR number" addresses work correctly even when the
endpoint's devicetree node is created statically.  This has been
verified by Andrea della Porta (with both static and dynamic ranges
properties) on the Raspberry Pi 5 RP1.

Tested-by: Andrea della Porta <andrea.porta@suse.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/pci/of.c          | 97 +++++++++++++++++++++++++++++++++++----
 drivers/pci/of_property.c |  2 +-
 drivers/pci/pci.h         |  1 +
 3 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 5a040ed836744..fa9e9377c3eb9 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -17,6 +17,9 @@
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_wakeirq.h>
+
+#include <asm/byteorder.h>
+
 #include "pci.h"
 
 #ifdef CONFIG_PCI
@@ -742,20 +745,98 @@ void of_pci_remove_node(struct pci_dev *pdev)
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
+		unsigned int rlen = 0;
+
+		/* Nothing further needed for a bridge */
+		if (pci_is_bridge(pdev))
+			return;
+
+		/*
+		 * A ranges property is only needed if the endpoint's
+		 * devicetree node includes a "pci-ep-bus" sub-node.
+		 */
+		child = of_get_child_by_name(np, "pci-ep-bus");
+		if (!child)
+			return;
+		of_node_put(child);
+
+		/* If the ranges property is non-empty, just keep it.*/
+		if (of_get_property(np, "ranges", &rlen) && rlen)
+			return;
+
+		/*
+		 * Otherwise create a ranges property, defining an entry for
+		 * each BAR, and map BAR offsets to the PCI bus address based
+		 * on the BAR's assigned range.
+		 */
+		if (!of_pci_update_endpoint_node_ranges(pdev))
+			dev_err(dev, "failed to update ranges property\n");
+
 		return;
+	}
 
 	/* Check if there is device tree node for parent device */
 	if (!pdev->bus->self)
@@ -794,7 +875,7 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 
 	np->data = cset;
 
-	ret = device_add_of_node(&pdev->dev, np);
+	ret = device_add_of_node(dev, np);
 	if (ret)
 		goto out_revert_cset;
 
diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index b202f45b3660b..44e169f4fbf4d 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -122,7 +122,7 @@ static int of_pci_prop_bus_range(struct pci_dev *pdev,
  *
  * Caller is responsible for ensuring the returned pointer gets freed.
  */
-static u32 *of_pci_build_prop_ranges(struct pci_dev *pdev, u32 *count)
+u32 *of_pci_build_prop_ranges(struct pci_dev *pdev, u32 *count)
 {
 	bool bridge_device = pci_is_bridge(pdev);
 	struct of_pci_range_entry *entries;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e93f602b9ca48..af21a46cfdb3c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1324,6 +1324,7 @@ struct of_changeset;
 #ifdef CONFIG_PCI_DYNAMIC_OF_NODES
 void of_pci_make_dev_node(struct pci_dev *pdev);
 void of_pci_remove_node(struct pci_dev *pdev);
+u32 *of_pci_build_prop_ranges(struct pci_dev *pdev, u32 *count);
 int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
 			  struct device_node *np);
 void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge);
-- 
2.53.0

