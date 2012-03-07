Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v3 14/34] PCI: don't publish new root bus until it's fully
	initialized
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 07 Mar 2012 15:33:15 -0700
Message-ID: <20120307223315.25669.79304.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
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
index dc904bd..e4c0d1c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1569,10 +1569,6 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		goto err_out;
 	}
 
-	down_write(&pci_bus_sem);
-	list_add_tail(&b->node, &pci_root_buses);
-	up_write(&pci_bus_sem);
-
 	dev->parent = parent;
 	dev->release = pci_release_bus_bridge_dev;
 	dev_set_name(dev, "pci%04x:%02x", pci_domain_nr(b), bus);
@@ -1612,6 +1608,10 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 			dev_info(&b->dev, "root bus resource %pR\n", res);
 	}
 
+	down_write(&pci_bus_sem);
+	list_add_tail(&b->node, &pci_root_buses);
+	up_write(&pci_bus_sem);
+
 	return b;
 
 class_dev_reg_err:

