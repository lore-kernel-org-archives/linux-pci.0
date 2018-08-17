Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Hari Vyas <hari.vyas@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
        Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH 4/6] pci: Add a mutex to pci_dev to protect device state
Date: Fri, 17 Aug 2018 14:49:00 +1000
Message-Id: <20180817044902.31420-5-benh@kernel.crashing.org>
In-Reply-To: <20180817044902.31420-1-benh@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
List-ID: <linux-pci.vger.kernel.org>

This adds a pci_dev mutex which will be used to fix a number
of races related to the various state bits maintained in
that structure.

We call it "state_lock" with similarly named accessors to avoid
confusion with the pci_dev_lock() which uses the device_lock().

This is a low level mutex meant to protect the mapping between
the state fields and the hardware state, for example enabling
disabling, setting/clearing bus master etc...

These operations can happen while the device_lock() is already
held (but don't have to) so a separate mutex is preferable.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/pci/probe.c |  1 +
 include/linux/pci.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 440445ac7dfa..3ce287ab6150 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2155,6 +2155,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
+	mutex_init(&dev->state_lock);
 
 	return dev;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f58bda204f09..0d4fc22df190 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -33,6 +33,7 @@
 #include <linux/io.h>
 #include <linux/resource_ext.h>
 #include <uapi/linux/pci.h>
+#include <linux/mutex.h>
 
 #include <linux/pci_ids.h>
 
@@ -443,8 +444,24 @@ struct pci_dev {
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */
 	char		*driver_override; /* Driver name to force a match */
+
+	unsigned long	priv_flags;	/* Private flags for the PCI driver */
+
+	struct mutex	state_lock;	/* Protect local state bits */
+
+	/* --- Fields below this line are protected by the state_lock mutex */
 };
 
+static inline void pci_dev_state_lock(struct pci_dev *dev)
+{
+	mutex_lock(&dev->state_lock);
+}
+
+static inline void pci_dev_state_unlock(struct pci_dev *dev)
+{
+	mutex_unlock(&dev->state_lock);
+}
+
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 {
 #ifdef CONFIG_PCI_IOV
-- 
2.17.1
