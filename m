Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC79B42EEC7;
	Mon, 11 May 2026 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515238; cv=none; b=l+uiE16WvYX5xArSicg9lZ2dQiIdO7BaY3J/Uh9hCSqMbgfPzPGLygv67aVreBFBhKKrK8FOq6xwYQmhxBvlGKijXkNZWV8CKSkiMLy7fjwIVtBS4Ks5lI7Xrq8ivRc3VPWj9mJxIG2LRjHSC7JG8kmGEX+gOtzOlILIxzs2u2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515238; c=relaxed/simple;
	bh=F4pEZ1/XVHnWejS6Od1WQ2h5iEBbHLjyrGkDVyYvduc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvAj920N77vO8tF/QF7dnRhJLl4pV50Focz502ORi7aHnBKDGf2Wl9o/LH4p/BxOazA8ie6g6WqBjvCywkmar8a2Ip9Hd9CmFK1zd/RKI0GcVLZfhIPtZogUg4ua1iyh0+bp3psyGp+KQik/aBQbqsZotsrcyV/dq4eMlBJ0ZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CGUm/7BD; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CGUm/7BD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8B1781A1DD5;
	Mon, 11 May 2026 16:00:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D19560646;
	Mon, 11 May 2026 16:00:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79DA011AF9F2C;
	Mon, 11 May 2026 18:00:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778515233; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=0p0X12GPV0QC8874WBu62G78WkRnfPHdgW0KNFhpaek=;
	b=CGUm/7BDfZqSunm9R7f1+qtveI0WGsgYVxcuPjxJaTkxv6oeGUO5zPYR46HDyNrPQ+frU4
	ZG6T/wwveqaqLEAEGJJDLtK6OtJOKFeWTgPZiDq905Hzz5hsnI7PeZGxGkPWvHZzUBCyAA
	qGPbTOOIk0cAQ3bwsTEBiMYDikYAVnEmFFFhmSFJ8axoi26GZ05yI52Qn3BQbrCjCOcBOL
	2oH5AKvmx6oIKtZlfR1Q2c6GaSQ18s5DjhDCL0zx9GO8FSeVVSO61E1Udb2760inugmGru
	PkFTkRai10UlwwP6ebtJy5ahqQ4Gr2mach+P+gdU2iKiBMZ+M/yZjtxBTbXkTQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
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
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Herve Codina <herve.codina@bootlin.com>
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
	stable@vger.kernel.org
Subject: [PATCH v7 7/8] PCI: of: Set fwnode device of newly created PCI device nodes
Date: Mon, 11 May 2026 17:59:27 +0200
Message-ID: <20260511155930.34604-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511155930.34604-1-herve.codina@bootlin.com>
References: <20260511155930.34604-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Device-tree node can be created when CONFIG_PCI_DYNAMIC_OF_NODES. Those
nodes are created and filled based on PCI core information but the
fwnode device field is not set.

When later an overlay is applied, this confuses fw_devlink. Indeed,
without any device attached to the node, fw_devlink considers that this
node will never become a device. When this node is pointed as a
supplier, devlink looks at its ancestors in order to find a node with a
device that could be used as the supplier.

In the PCI use case, this leads to links that wrongly use the PCI root
bridge device as the supplier instead of the expected PCI device.

Setting the fwnode device to the device of the PCI device allows devlink
to use this device as a supplier and so, correct links are created.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/of.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 7506208815a4..25fb02c3dc72 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -709,6 +709,13 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 	if (ret)
 		goto out_free_node;
 
+	/*
+	 * Set the fwnode device in order to have fw_devlink creating links
+	 * pointing to this PCI device instead of walking up to the PCI host
+	 * bridge.
+	 */
+	fw_devlink_set_device(&np->fwnode, &pdev->dev);
+
 	ret = of_changeset_apply(cset);
 	if (ret)
 		goto out_free_node;
-- 
2.54.0

