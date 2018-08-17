Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Message-ID: <b8a55827a5e574900628f5b718e52e259b32acd9.camel@kernel.crashing.org>
Subject: [RFC PATCH v2 3/6] pci: Remove priv_flags and use dev->error_state
 for "disconnected" status
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Hari Vyas <hari.vyas@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck
 <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
        Lukas Wunner
 <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta
 Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>, linux-kernel@vger.kernel.org
Date: Fri, 17 Aug 2018 15:13:49 +1000
In-Reply-To: <20180817044902.31420-4-benh@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
	 <20180817044902.31420-4-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

This already represents whether a device is accessible or not,
creating a new flag isn't particularly helpful.

dev->error_state being an int, assigning it doesn't require
an atomic operation per-se. The existing atomic bitop only
protects the field, not anything else anyway.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2. Initialize the io channel state before we try to read the header

 drivers/pci/access.c | 12 ++++++------
 drivers/pci/msi.c    |  4 ++--
 drivers/pci/pci.c    |  2 +-
 drivers/pci/pci.h    | 11 ++---------
 drivers/pci/probe.c  |  4 +++-
 include/linux/pci.h  |  2 --
 6 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index a3ad2fe185b9..ad97a3544636 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -535,7 +535,7 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
 
 int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
 {
-	if (pci_dev_is_disconnected(dev)) {
+	if (pci_channel_offline(dev)) {
 		*val = ~0;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -545,7 +545,7 @@ EXPORT_SYMBOL(pci_read_config_byte);
 
 int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
 {
-	if (pci_dev_is_disconnected(dev)) {
+	if (pci_channel_offline(dev)) {
 		*val = ~0;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -556,7 +556,7 @@ EXPORT_SYMBOL(pci_read_config_word);
 int pci_read_config_dword(const struct pci_dev *dev, int where,
 					u32 *val)
 {
-	if (pci_dev_is_disconnected(dev)) {
+	if (pci_channel_offline(dev)) {
 		*val = ~0;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -566,7 +566,7 @@ EXPORT_SYMBOL(pci_read_config_dword);
 
 int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val)
 {
-	if (pci_dev_is_disconnected(dev))
+	if (pci_channel_offline(dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	return pci_bus_write_config_byte(dev->bus, dev->devfn, where, val);
 }
@@ -574,7 +574,7 @@ EXPORT_SYMBOL(pci_write_config_byte);
 
 int pci_write_config_word(const struct pci_dev *dev, int where, u16 val)
 {
-	if (pci_dev_is_disconnected(dev))
+	if (pci_channel_offline(dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	return pci_bus_write_config_word(dev->bus, dev->devfn, where, val);
 }
@@ -583,7 +583,7 @@ EXPORT_SYMBOL(pci_write_config_word);
 int pci_write_config_dword(const struct pci_dev *dev, int where,
 					 u32 val)
 {
-	if (pci_dev_is_disconnected(dev))
+	if (pci_channel_offline(dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
 }
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index f2ef896464b3..2f872db40042 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -298,7 +298,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
 
-	if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
+	if (dev->current_state != PCI_D0 || pci_channel_offline(dev)) {
 		/* Don't touch the hardware now */
 	} else if (entry->msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
@@ -975,7 +975,7 @@ static void pci_msix_shutdown(struct pci_dev *dev)
 	if (!pci_msi_enable || !dev || !dev->msix_enabled)
 		return;
 
-	if (pci_dev_is_disconnected(dev)) {
+	if (pci_channel_offline(dev)) {
 		dev->msix_enabled = 0;
 		return;
 	}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29ff9619b5fa..62591c153999 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5713,7 +5713,7 @@ bool pci_device_is_present(struct pci_dev *pdev)
 {
 	u32 v;
 
-	if (pci_dev_is_disconnected(pdev))
+	if (pci_channel_offline(pdev))
 		return false;
 	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 473aa10a5dbf..f7704333e6a1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -293,18 +293,11 @@ struct pci_sriov {
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
 
-/* pci_dev priv_flags */
-#define PCI_DEV_DISCONNECTED 0
-
 static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 {
-	set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
-	return 0;
-}
+	dev->error_state = pci_channel_io_perm_failure;
 
-static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
-{
-	return test_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
+	return 0;
 }
 
 #ifdef CONFIG_PCIEAER
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 440445ac7dfa..5cf982b3031b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1581,6 +1581,9 @@ int pci_setup_device(struct pci_dev *dev)
 	struct pci_bus_region region;
 	struct resource *res;
 
+	/* This must be set before any config space access */
+	dev->error_state = pci_channel_io_normal;
+
 	hdr_type = pci_hdr_type(dev);
 
 	dev->sysdata = dev->bus->sysdata;
@@ -1588,7 +1591,6 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->dev.bus = &pci_bus_type;
 	dev->hdr_type = hdr_type & 0x7f;
 	dev->multifunction = !!(hdr_type & 0x80);
-	dev->error_state = pci_channel_io_normal;
 	set_pcie_port_type(dev);
 
 	pci_dev_assign_slot(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9799109c5e25..f58bda204f09 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -443,8 +443,6 @@ struct pci_dev {
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */
 	char		*driver_override; /* Driver name to force a match */
-
-	unsigned long	priv_flags;	/* Private flags for the PCI driver */
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
