Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Govindarajulu Varadarajan <gvaradar@cisco.com>
To: benve@cisco.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlbec@evilplan.org, hch@lst.de,
        mingo@redhat.com, peterz@infradead.org
Cc: Govindarajulu Varadarajan <gvaradar@cisco.com>
Subject: [PATCH 1/4] pci: introduce __pci_walk_bus for caller with pci_bus_sem held
Date: Wed, 27 Sep 2017 14:42:17 -0700
Message-Id: <20170927214220.41216-2-gvaradar@cisco.com>
In-Reply-To: <20170927214220.41216-1-gvaradar@cisco.com>
References: <20170927214220.41216-1-gvaradar@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move pci_bus_sem down/up out of pci_walk_bus and rename it to
__pci_walk_bus. Caller who already hold pci_bus_sem can call
__pci_walk_bus.

Signed-off-by: Govindarajulu Varadarajan <gvaradar@cisco.com>
---
 drivers/pci/bus.c   | 13 +++++++++++--
 include/linux/pci.h |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index bc56cf19afd3..3cababe74af0 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -376,8 +376,10 @@ EXPORT_SYMBOL(pci_bus_add_devices);
  *  We check the return of @cb each time. If it returns anything
  *  other than 0, we break out.
  *
+ *  Should be called with read pci_bus_sem held.
+ *
  */
-void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata)
 {
 	struct pci_dev *dev;
@@ -386,7 +388,6 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 	int retval;
 
 	bus = top;
-	down_read(&pci_bus_sem);
 	next = top->devices.next;
 	for (;;) {
 		if (next == &bus->devices) {
@@ -409,6 +410,14 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		if (retval)
 			break;
 	}
+}
+EXPORT_SYMBOL_GPL(__pci_walk_bus);
+
+void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+		  void *userdata)
+{
+	down_read(&pci_bus_sem);
+	__pci_walk_bus(top, cb, userdata);
 	up_read(&pci_bus_sem);
 }
 EXPORT_SYMBOL_GPL(pci_walk_bus);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f68c58a93dd0..b4b1a8a164c0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1297,6 +1297,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
+void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+		    void *userdata);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
-- 
2.14.1
