Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3FA40B6FC
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790288698; cv=none; b=Y5/RBHUBRiWQUBmSIeCnADgUSRfGn2hEeaRUbtKg/a2VtSOABmAqG7ZwP/53lpmeIRXuAAK7lgANpxtCUrsMnH3TVca0fSU83W/UNSZBpImIIDbvavJx5sIOcgg/9NaTe/J1ifxEL+B79qo2sVr+433nHjdPM42edQO07uLuZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790288698; c=relaxed/simple;
	bh=tKKgHTVj7sjK3uu9Bd1RURnxjzLdbEIr7XiNphJtbD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J67DffuFNa7lJClWa4u+KnNKSZpBzTIzo1eAcRyIEQ2KP03dNDMJfE36NCs31R8WmfURrGdCePJ3O+ZpgQXKuEfzv7lpQwAKael4bs817XztYk7yi377vPNVTdvlSQHtENu57a17C7YtbLWY1bc2VEhHtN8HYo22pbqhO//lhjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=OpLsj+hA; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="OpLsj+hA"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9123599f5e3so4044626d6.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790288691; x=1790893491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HnmZ0RUOTd+QntYtAvyxm4yxyuFcoMhdt2vyYIZdIuk=;
        b=OpLsj+hA7CZMVlvXHYMGufv4KOh+WuDxEOG4NRfQ50U4RBLZqhdNDM2QZ4dpwsCLTL
         A6iXz1FHe6yeCwFBKwt2LWDel6d+xf2FM/q0tXd29toJ1vVyc7754eYkV4fzAb7fL33q
         a+ziL2P9R3QFu55jbsZc0FEWKiRg105tgcMlcZq+E6VcXcnp4dplWKXYRZlb4J7ZyH0C
         tiGyrKhPCoM9499m0mEmcterqbaHwAK4lj7ggkZWdQY7MFm34oLFa+Z6WhBdvKvMsRnk
         nRiop5i7bfCjJuYSpdMWBHgoyZJVVnetA6wFeBocnipjiLdyPRY67T3puzEmJiyvhdd/
         qHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790288691; x=1790893491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HnmZ0RUOTd+QntYtAvyxm4yxyuFcoMhdt2vyYIZdIuk=;
        b=1ud1exkbDq5SSmNmhmhBLKaExhr3lKC9b45IgmA2/4fQGTKnjWjIVepYbb1X2LmEAp
         nu/1z1MOHMpX848SWUnB5zDli5s7qDUmc884Q2yHn6LfxIPJS+jgGChIIMlBD2+brDPC
         2huxjjBe6nvRgBxlOpbtn7d7M83M5EHZr9scO7YT9A9huvlt0KjISliSj+Np/dys6yro
         uvAOyF19FOhNOvYU+D/WSl0598WsrEAjl5H/ostFH9UN7tqnyYe6xBeRxVcrti8zjy7+
         ghFwcBOAzmMy9zIrglHiSER84mGEFycxEhdxTsOO1BvXraromz4Vyn0te8Yv8vM9IIY5
         LOSw==
X-Forwarded-Encrypted: i=1; AKwUvBwbJlWiSXq2xqhZvayuZCw1yMtm7UBdW+KHBNl+7TZFaN2X5HkK+c6L+Khhe3uvXRVtNwZqXZtX1SA=@vger.kernel.org
X-Gm-Message-State: AFuF++kdflMKZKS31rUZqg6pHnT3MHEwWjlYPXc+RpAEpsPdIw6n9vVR
	kX6+3f6ebZlTvd6+nkwXBmJ5k7pKzux87P/zJcFwKjmmsAYzPtcDmFDtMtF+aOLEcig=
X-Gm-Gg: AYBFou14blO9yGa2186AdxME8Q46BcPYDOgCCRXla3DIUfiXfDHJOy7C/Sr50yX0sMe
	Y+2ra8tUH9LmLvWjPAQtqP9v8oTq/PFEOyOumTyArVYYW41LmyHdufK0qPWAOa5srNH+HzWRq+T
	yfUk/Pg0fzdgN90Wzuss/UxmT9OPGvElA7CHfoFD/KMR1JFIZApMuHnHMYNSA6ga7sLZ4ax6lex
	fMdi5SOlPCLpfTF0nc876EOqf1Rzh+ON6QldUzOlyZX6jY7ds6QY7KcBQ3OnbXGyEn4SRirwn72
	oCVP1zShmLQklTsBHgzHxCL/NYCcF2ip5LQO+9dBF+unEL9VxdHh5Nq1IyeWVKjpd1EonCIvpOJ
	Be85xbqVCrfq8tthPOg7tSQQMo6OsHfc4f/Jj0Ff3TM8lpyigUpjVG7kXsjRNRZBRLUM8o9h1Gc
	+Am7JC5or5LUOUPJ3RxmtzbOPTo8rKy1I8Nl1drefvYx8CRIl9SX3rk+CB9jTbMYoUWfYNdy92F
	vE=
X-Received: by 2002:a05:6214:c24:b0:90e:9d05:b757 with SMTP id 6a1803df08f44-91431fa978bmr4959886d6.0.1790288691000;
        Thu, 24 Sep 2026 15:24:51 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430eaf5basm3516496d6.44.2026.09.24.15.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:24:50 -0700 (PDT)
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
Subject: [PATCH v3 3/3] PCI: of: introduce of_pci_update_endpoint_node_ranges()
Date: Thu, 24 Sep 2026 17:24:43 -0500
Message-ID: <20260924222444.1351466-4-elder@riscstar.com>
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
endpoint's devicetree node is created statically.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v3: - Don't update an existing non-empty ranges property

 drivers/pci/of.c          | 94 +++++++++++++++++++++++++++++++++++----
 drivers/pci/of_property.c |  2 +-
 drivers/pci/pci.h         |  1 +
 3 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 5a040ed836744..7fb5e0351719c 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -742,20 +742,98 @@ void of_pci_remove_node(struct pci_dev *pdev)
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
@@ -794,7 +872,7 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 
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

