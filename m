Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v2 01/18] PCI: don't publish new root bus until it's fully
	initialized
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org
Date: Thu, 09 Feb 2012 19:36:26 -0700
Message-ID: <20120210023626.10311.44633.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When pci_create_root_bus() adds the new struct pci_bus to the global
pci_root_buses list, the bus becomes visible to other parts of the
kernel, so it should be fully initialized.

This patch delays adding the bus to the pci_root_buses list until after
all the struct pci_bus initialization is finished.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7cc9e2f..da0d655 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1551,10 +1551,6 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		goto err_out;
 	}
 
-	down_write(&pci_bus_sem);
-	list_add_tail(&b->node, &pci_root_buses);
-	up_write(&pci_bus_sem);
-
 	dev->parent = parent;
 	dev->release = pci_release_bus_bridge_dev;
 	dev_set_name(dev, "pci%04x:%02x", pci_domain_nr(b), bus);
@@ -1594,6 +1590,10 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 			dev_info(&b->dev, "root bus resource %pR\n", res);
 	}
 
+	down_write(&pci_bus_sem);
+	list_add_tail(&b->node, &pci_root_buses);
+	up_write(&pci_bus_sem);
+
 	return b;
 
 class_dev_reg_err:

