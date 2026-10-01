Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E5A51D521;
	Thu,  1 Oct 2026 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865010; cv=none; b=FuICZw2I1QGNlK00kYNhex/+2N3ISk63Uo8NQI0l1hs5RIr2Sfnx0iU6WRBEgx503+4mBu7Mhxw/nqtE4DFVS3Zw0Axiwm31B3aFNgTi9WrCKUUNvSmxJKoNexqLdVydSx3HkIDtq3ZjxY6eu3h7RHYGIoO/bC+zXlImNtk1jyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865010; c=relaxed/simple;
	bh=Jd7ZjyfT1Jy7sXz3l2TUFT7uAkdK6nTu3zC4BU9inpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKOKFIT4ZWNiMPKqj66qYJsc2YEMjdsI6pm1RU+Cx6OK3Kjr9/EiupLaWrf8mW01WeSW100hUC4VFY6QCh7J4ftgQvv/P4CliYimpBdWqKzq10Tu07/2nRnauknJGCQMCkOxc3rX5u91fqsFly8RhjYBkTJbL2Tw+DH/A0Sb8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VAVXhkvL; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VAVXhkvL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DFCA44E4136A;
	Thu,  1 Oct 2026 14:29:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B005F60341;
	Thu,  1 Oct 2026 14:29:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29BDF10328149;
	Thu,  1 Oct 2026 16:29:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790864984; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=0Y7Il35wh5W2YG7C50SKv6f4WUuvO6mAZrG/RT2vKJY=;
	b=VAVXhkvLIi4JU7+P1mVpWT6vungkXOOM93sH6mHyy1rY99a/g2WQ5NrRlT1H4qcZx7plbv
	iGGsIkxYK5oOQ/Uyw77WIOdW6A3qA4QPGXJtZSiJyFxB9/bAwZT5aUpdwR0kQGhDCzfRco
	fF/3B0/Q0coB4ekCSPB8LGMZKbY9XIXlyXYtX9NOfwmiftJtKaRkL2qbZbGnMy3V9/K9dv
	C31wBoLxoD6Dt3WId3Eu6lTIXppacN7zvcYTVwATp9C8KkDgL2+XJNFH+HNJENZz1d7uPY
	VG0YHjWYPluIuhRIErHrdvf46Eihp/Vy54vtJC3XqF1nfZSH1sA/qDXxTa4KoQ==
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
Subject: [PATCH v12 10/10] PCI: of: Avoid np->data usage for the node changeset
Date: Thu,  1 Oct 2026 16:28:10 +0200
Message-ID: <20261001142815.277550-11-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001142815.277550-1-herve.codina@bootlin.com>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
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
 drivers/pci/of.c    | 26 ++++++++++++++------------
 include/linux/pci.h | 11 +++++++++++
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 0a5797652e18..d6339720e710 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -733,14 +733,16 @@ void of_pci_remove_node(struct pci_dev *pdev)
 	struct device_node *np;
 
 	np = pci_device_to_OF_node(pdev);
-	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
+	if (!pdev->cset || !np)
 		return;
 
 	fw_devlink_set_device(&np->fwnode, NULL);
 	device_remove_of_node(&pdev->dev);
-	of_changeset_revert(np->data);
-	of_changeset_destroy(np->data);
+	of_changeset_revert(pdev->cset);
+	of_changeset_destroy(pdev->cset);
 	of_node_put(np);
+	kfree(pdev->cset);
+	pdev->cset = NULL;
 }
 
 void of_pci_make_dev_node(struct pci_dev *pdev)
@@ -800,18 +802,17 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
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
@@ -829,15 +830,17 @@ void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge)
 	struct device_node *np;
 
 	np = pci_bus_to_OF_node(bridge->bus);
-	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
+	if (!bridge->cset || !np)
 		return;
 
 	fw_devlink_set_device(&np->fwnode, NULL);
 	device_remove_of_node(&bridge->bus->dev);
 	device_remove_of_node(&bridge->dev);
-	of_changeset_revert(np->data);
-	of_changeset_destroy(np->data);
+	of_changeset_revert(bridge->cset);
+	of_changeset_destroy(bridge->cset);
 	of_node_put(np);
+	kfree(bridge->cset);
+	bridge->cset = NULL;
 }
 
 void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
@@ -899,8 +902,6 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 	if (ret)
 		goto out_clear_devlink_dev;
 
-	np->data = cset;
-
 	/* Add the of_node to host bridge and the root bus */
 	ret = device_add_of_node(&bridge->dev, np);
 	if (ret)
@@ -910,6 +911,8 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 	if (ret)
 		goto out_remove_bridge_dev_of_node;
 
+	bridge->cset = cset;
+
 	kfree(name);
 
 	return;
@@ -917,7 +920,6 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
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

