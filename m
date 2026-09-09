Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8A94915AE;
	Wed,  9 Sep 2026 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940974; cv=none; b=bVETyLE8Bn4/uyt/MLrKXCuWgiSUFBKTAwfX+eQpLrzsBiNpWyr4Gzs4dTNGq89eQ/eIBcHLcE0k/BzaK0eJdUg1MPLIxyL6HGCyNFAmb+JGAUSQP4U3FqEbT03KTGST5cIai9l9j03yVKg5Jcz0b76yXMfPAar+JW6XH1c9IQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940974; c=relaxed/simple;
	bh=AZf0hTGanZoBX9juw8A4Hkcbr/03el49J34+Wj833zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDtUnDprMUKiWunSuJw+cLdgbp8HFUOa7Xx/beKv1BVWg7Jmk1Ti3IfsaqCwckSxnSR3rltK/lC679Fop9kP9eHgeFrWK0FhXaJjOYrFDHrEfBm12rnCM87ETd0ldVaDblqBBQtmyO16JbPmtDM27IEOawzdxAfyv7RiFG8ZhlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RIraTNUr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RIraTNUr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 36B904E415A9;
	Wed,  9 Sep 2026 08:02:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0732F60448;
	Wed,  9 Sep 2026 08:02:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0BF711C7AF61;
	Wed,  9 Sep 2026 10:02:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788940966; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=eCEDZNLNxkg3C8C9bAECCcFaN+XP6VaQ0+RYJcLH1V4=;
	b=RIraTNUrkx8rCgnGMdZIZgTAmId6aTvpFsKskmRr8sg58vyK+nsLZw+IEBJ/WApunHb/X8
	kXXLsF/GCIY7yWlgLuQ1dLYx4qDXo5z3PainBnBqpGjZC9r4sZaUYSm9alaRpm+2RmlaRu
	lKFOoY5Th4hY02UleIwruKfgCzgUmV1nVSlZKkfIl9QtoePCzkCWZm7RUh9AmyxjdQiCA8
	zNiQeW4LbncfeogkF85WKGhEA/Nmw/TYjgjiPeocqbZ2x3VGbN+6v/R1FLYbIfVXdS3vC/
	buGYg/XJLb2IJBYAkx0Xzv0C1QpqFxMk5hvR/nMdJ4e0Ab6CGDzrnrHm8i3Kmg==
From: Herve Codina <herve.codina@bootlin.com>
To: Richard Cheng <icheng@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable+noautosel@kernel.org
Subject: [PATCH v11 10/10] PCI: of: Avoid np->data usage for the node changeset
Date: Wed,  9 Sep 2026 10:01:09 +0200
Message-ID: <20260909080114.591938-11-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909080114.591938-1-herve.codina@bootlin.com>
References: <20260909080114.591938-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

of_pci_remove_node() and of_pci_remove_host_bridge_node() check
whether the node is dynamic but not whether it has valid private data.

During the node creation, an OF changeset is used and this changeset is
stored in np->data to be available for removal functions.

If, for instance, a PCI host bridge is created using a device-tree
overlay, the related node will have the dynamic flag set but np->data
will be NULL. This leads to NULL pointer dereferences.

Checking for a non-NULL np->data pointer to determine if the node has
been created by the PCI node creation process is not enough. Indeed,
on some platforms like PowerPC, the OF_RECONFIG_ATTACH_NODE notifier
(e.g., in the pci_dn_reconfig_notifier() function) intercepts node
additions and populates np->data with its own structure, such as a
struct pci_dn. In that case, np->data is not NULL but it is not related
to our changeset stored during the PCI node process creation.

Avoid the usage of np->data to store the changeset used during the PCI
node creation. Store our changeset in a more relevant structure: either
struct pci_dev when the node is created for a PCI device or struct
pci_host_bridge when the node is created for the PCI host bridge.

With that done, no ambiguity remains on removal. Indeed, this changeset,
if non-NULL, is the one used during PCI node creation. Check and use
this changeset on the removal process.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
Cc: <stable+noautosel@kernel.org> # Issue not triggered but could be a problem
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/of.c    | 28 ++++++++++++++--------------
 include/linux/pci.h | 11 +++++++++++
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 0a5797652e18..cd87128c71dd 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -732,15 +732,16 @@ void of_pci_remove_node(struct pci_dev *pdev)
 {
 	struct device_node *np;
 
-	np = pci_device_to_OF_node(pdev);
-	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
+	if (!pdev->cset)
 		return;
 
+	np = pci_device_to_OF_node(pdev);
 	fw_devlink_set_device(&np->fwnode, NULL);
 	device_remove_of_node(&pdev->dev);
-	of_changeset_revert(np->data);
-	of_changeset_destroy(np->data);
+	of_changeset_revert(pdev->cset);
+	of_changeset_destroy(pdev->cset);
 	of_node_put(np);
+	kfree(pdev->cset);
 }
 
 void of_pci_make_dev_node(struct pci_dev *pdev)
@@ -800,18 +801,17 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 	if (ret)
 		goto out_clear_devlink_dev;
 
-	np->data = cset;
-
 	ret = device_add_of_node(&pdev->dev, np);
 	if (ret)
 		goto out_revert_cset;
 
+	pdev->cset = cset;
+
 	kfree(name);
 
 	return;
 
 out_revert_cset:
-	np->data = NULL;
 	of_changeset_revert(cset);
 out_clear_devlink_dev:
 	fw_devlink_set_device(&np->fwnode, NULL);
@@ -828,16 +828,17 @@ void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge)
 {
 	struct device_node *np;
 
-	np = pci_bus_to_OF_node(bridge->bus);
-	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
+	if (!bridge->cset)
 		return;
 
+	np = pci_bus_to_OF_node(bridge->bus);
 	fw_devlink_set_device(&np->fwnode, NULL);
 	device_remove_of_node(&bridge->bus->dev);
 	device_remove_of_node(&bridge->dev);
-	of_changeset_revert(np->data);
-	of_changeset_destroy(np->data);
+	of_changeset_revert(bridge->cset);
+	of_changeset_destroy(bridge->cset);
 	of_node_put(np);
+	kfree(bridge->cset);
 }
 
 void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
@@ -899,8 +900,6 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 	if (ret)
 		goto out_clear_devlink_dev;
 
-	np->data = cset;
-
 	/* Add the of_node to host bridge and the root bus */
 	ret = device_add_of_node(&bridge->dev, np);
 	if (ret)
@@ -910,6 +909,8 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 	if (ret)
 		goto out_remove_bridge_dev_of_node;
 
+	bridge->cset = cset;
+
 	kfree(name);
 
 	return;
@@ -917,7 +918,6 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 out_remove_bridge_dev_of_node:
 	device_remove_of_node(&bridge->dev);
 out_revert_cset:
-	np->data = NULL;
 	of_changeset_revert(cset);
 out_clear_devlink_dev:
 	fw_devlink_set_device(&np->fwnode, NULL);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..7b0ba9ec7b5c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -339,6 +339,9 @@ struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+struct of_changeset;
+#endif
 
 /* struct pci_dev - describes a PCI device
  *
@@ -598,6 +601,10 @@ struct pci_dev {
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
 #endif
+
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+	struct of_changeset *cset; /* Changeset used for OF node creation */
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
@@ -670,6 +677,10 @@ struct pci_host_bridge {
 	unsigned int	broken_l1ss_resume:1;	/* Resuming from L1SS during
 						   system suspend is broken */
 
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+	struct of_changeset *cset; /* Changeset used for OF node creation */
+#endif
+
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,
-- 
2.55.0

