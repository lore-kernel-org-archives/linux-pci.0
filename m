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
Subject: [RFC PATCH 6/6] pci: Protect is_busmaster using the state lock
Date: Fri, 17 Aug 2018 14:49:02 +1000
Message-Id: <20180817044902.31420-7-benh@kernel.crashing.org>
In-Reply-To: <20180817044902.31420-1-benh@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
List-ID: <linux-pci.vger.kernel.org>

This wraps pci_set_master() and pci_clear_master() with the pci_dev
state lock. The clearing of is_busmaster in pci_disable_device()
is already covered.

This also adds a comment explaining why is_busmaster must not be
checked in pci_set_master() due to how the power management code
uses it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/pci/pci.c   | 9 +++++++++
 include/linux/pci.h | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 68152de2b5a0..13d988d5b2a3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4052,11 +4052,18 @@ void __weak pcibios_set_master(struct pci_dev *dev)
  *
  * Enables bus-mastering on the device and calls pcibios_set_master()
  * to do the needed arch specific settings.
+ *
+ * Note: This must not check dev->is_busmaster because the power management
+ *       code will call this in order to restore the config space to the
+ *       state of is_busmaster, thus is_busmaster might be set but the
+ *       config space bit cleared.
  */
 void pci_set_master(struct pci_dev *dev)
 {
+	pci_dev_state_lock(dev);
 	__pci_set_master(dev, true);
 	pcibios_set_master(dev);
+	pci_dev_state_unlock(dev);
 }
 EXPORT_SYMBOL(pci_set_master);
 
@@ -4066,7 +4073,9 @@ EXPORT_SYMBOL(pci_set_master);
  */
 void pci_clear_master(struct pci_dev *dev)
 {
+	pci_dev_state_lock(dev);
 	__pci_set_master(dev, false);
+	pci_dev_state_unlock(dev);
 }
 EXPORT_SYMBOL(pci_clear_master);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0d4fc22df190..a5bac5b21454 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -375,7 +375,6 @@ struct pci_dev {
 	unsigned int	multifunction:1;	/* Multi-function device */
 
 	unsigned int	is_added:1;
-	unsigned int	is_busmaster:1;		/* Is busmaster */
 	unsigned int	no_msi:1;		/* May not use MSI */
 	unsigned int	no_64bit_msi:1; 	/* May only use 32-bit MSIs */
 	unsigned int	block_cfg_access:1;	/* Config space access blocked */
@@ -450,6 +449,7 @@ struct pci_dev {
 	struct mutex	state_lock;	/* Protect local state bits */
 
 	/* --- Fields below this line are protected by the state_lock mutex */
+	unsigned int	is_busmaster:1;		/* Is busmaster */
 };
 
 static inline void pci_dev_state_lock(struct pci_dev *dev)
-- 
2.17.1
