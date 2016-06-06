Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH v1 01/25] PCI: Add devm_request_pci_bus_resources()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 06 Jun 2016 18:04:52 -0500
Message-ID: <20160606230452.20936.28937.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jason Cooper <jason@lakedaemon.net>, Scott Branden <sbranden@broadcom.com>,
 Jon Mason <jonmason@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>,
 Pratyush Anand <pratyush.anand@gmail.com>, linux-kernel@vger.kernel.org,
 rfi@lists.rocketboards.org, linux-renesas-soc@vger.kernel.org,
 Simon Horman <horms@verge.net.au>, Thierry Reding <thierry.reding@gmail.com>,
 Tanmay Inamdar <tinamdar@apm.com>, Ray Jui <rjui@broadcom.com>,
 linux-tegra@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
 Michal Simek <michal.simek@xilinx.com>,
 =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Several host bridge drivers iterate through the list of bridge windows to
request resources.  Several others don't request the window resources at
all.

Add a devm_request_pci_bus_resources() interface to make it easier for
drivers to request all the window resources.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/bus.c   |   29 ++++++++++++++++++++++++++++-
 include/linux/pci.h |    5 ++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index dd7cdbe..78b90c7 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -91,6 +91,34 @@ void pci_bus_remove_resources(struct pci_bus *bus)
 	}
 }
 
+int devm_request_pci_bus_resources(struct device *dev,
+				   struct list_head *resources)
+{
+	struct resource_entry *win;
+	struct resource *parent, *res;
+	int err;
+
+	resource_list_for_each_entry(win, resources) {
+		res = win->res;
+		switch (resource_type(res)) {
+		case IORESOURCE_IO:
+			parent = &ioport_resource;
+			break;
+		case IORESOURCE_MEM:
+			parent = &iomem_resource;
+			break;
+		default:
+			continue;
+		}
+
+		err = devm_request_resource(dev, parent, res);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static struct pci_bus_region pci_32_bit = {0, 0xffffffffULL};
 #ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
 static struct pci_bus_region pci_64_bit = {0,
@@ -397,4 +425,3 @@ void pci_bus_put(struct pci_bus *bus)
 		put_device(&bus->dev);
 }
 EXPORT_SYMBOL(pci_bus_put);
-
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b67e4df..6ac8360 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1143,9 +1143,12 @@ void pci_add_resource(struct list_head *resources, struct resource *res);
 void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 			     resource_size_t offset);
 void pci_free_resource_list(struct list_head *resources);
-void pci_bus_add_resource(struct pci_bus *bus, struct resource *res, unsigned int flags);
+void pci_bus_add_resource(struct pci_bus *bus, struct resource *res,
+			  unsigned int flags);
 struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n);
 void pci_bus_remove_resources(struct pci_bus *bus);
+int devm_request_pci_bus_resources(struct device *dev,
+				   struct list_head *resources);
 
 #define pci_bus_for_each_resource(bus, res, i)				\
 	for (i = 0;							\


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
