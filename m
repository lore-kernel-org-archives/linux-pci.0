Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42166 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753071AbdKVWt5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 17:49:57 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 08/29] drm/gma500: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 17:49:03 -0500
Message-Id: <1511390964-9979-9-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Add domain parameter to CDV_MSG_READ32, CDV_MSG_WRITE32, MRST_MSG_READ32,
MRST_MSG_WRITE32, MDFLD_MSG_READ32, MDFLD_MSG_WRITE32.

Extract pci_dev from struct drm_device and use pdev to find the domain
number while calling pci_get_domain_bus_and_slot().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/gpu/drm/gma500/cdv_device.c | 16 +++++++++-------
 drivers/gpu/drm/gma500/gma_device.c |  3 ++-
 drivers/gpu/drm/gma500/mid_bios.c   | 11 ++++++++---
 drivers/gpu/drm/gma500/psb_drv.c    | 10 ++++++++--
 drivers/gpu/drm/gma500/psb_drv.h    | 18 ++++++++++--------
 5 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_device.c b/drivers/gpu/drm/gma500/cdv_device.c
index 8745971..e967924 100644
--- a/drivers/gpu/drm/gma500/cdv_device.c
+++ b/drivers/gpu/drm/gma500/cdv_device.c
@@ -185,21 +185,22 @@ static int cdv_backlight_init(struct drm_device *dev)
  *	for this and the MID devices.
  */
 
-static inline u32 CDV_MSG_READ32(uint port, uint offset)
+static inline u32 CDV_MSG_READ32(uint domain, uint port, uint offset)
 {
 	int mcr = (0x10<<24) | (port << 16) | (offset << 8);
 	uint32_t ret_val = 0;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(domain, 0, 0);
 	pci_write_config_dword(pci_root, 0xD0, mcr);
 	pci_read_config_dword(pci_root, 0xD4, &ret_val);
 	pci_dev_put(pci_root);
 	return ret_val;
 }
 
-static inline void CDV_MSG_WRITE32(uint port, uint offset, u32 value)
+static inline void CDV_MSG_WRITE32(uint domain, uint port, uint offset,
+				   u32 value)
 {
 	int mcr = (0x11<<24) | (port << 16) | (offset << 8) | 0xF0;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(domain, 0, 0);
 	pci_write_config_dword(pci_root, 0xD4, value);
 	pci_write_config_dword(pci_root, 0xD0, mcr);
 	pci_dev_put(pci_root);
@@ -216,11 +217,12 @@ static void cdv_init_pm(struct drm_device *dev)
 {
 	struct drm_psb_private *dev_priv = dev->dev_private;
 	u32 pwr_cnt;
+	u32 domain = pci_domain_nr(dev->pdev->bus);
 	int i;
 
-	dev_priv->apm_base = CDV_MSG_READ32(PSB_PUNIT_PORT,
+	dev_priv->apm_base = CDV_MSG_READ32(domain, PSB_PUNIT_PORT,
 							PSB_APMBA) & 0xFFFF;
-	dev_priv->ospm_base = CDV_MSG_READ32(PSB_PUNIT_PORT,
+	dev_priv->ospm_base = CDV_MSG_READ32(domain, PSB_PUNIT_PORT,
 							PSB_OSPMBA) & 0xFFFF;
 
 	/* Power status */
@@ -251,7 +253,7 @@ static void cdv_errata(struct drm_device *dev)
 	 *	Bonus Launch to work around the issue, by degrading
 	 *	performance.
 	 */
-	 CDV_MSG_WRITE32(3, 0x30, 0x08027108);
+	 CDV_MSG_WRITE32(pci_domain_nr(dev->pdev->bus), 3, 0x30, 0x08027108);
 }
 
 /**
diff --git a/drivers/gpu/drm/gma500/gma_device.c b/drivers/gpu/drm/gma500/gma_device.c
index 4a295f9..30255b3 100644
--- a/drivers/gpu/drm/gma500/gma_device.c
+++ b/drivers/gpu/drm/gma500/gma_device.c
@@ -19,7 +19,8 @@
 void gma_get_core_freq(struct drm_device *dev)
 {
 	uint32_t clock;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	u32 domain = pci_domain_nr(dev->pdev->bus);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(domain, 0, 0);
 	struct drm_psb_private *dev_priv = dev->dev_private;
 
 	/*pci_write_config_dword(pci_root, 0xD4, 0x00C32004);*/
diff --git a/drivers/gpu/drm/gma500/mid_bios.c b/drivers/gpu/drm/gma500/mid_bios.c
index d75ecb3..65cdbed 100644
--- a/drivers/gpu/drm/gma500/mid_bios.c
+++ b/drivers/gpu/drm/gma500/mid_bios.c
@@ -32,7 +32,8 @@
 static void mid_get_fuse_settings(struct drm_device *dev)
 {
 	struct drm_psb_private *dev_priv = dev->dev_private;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	u32 domain = pci_domain_nr(dev->pdev->bus);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(domain, 0, 0);
 	uint32_t fuse_value = 0;
 	uint32_t fuse_value_tmp = 0;
 
@@ -104,7 +105,9 @@ static void mid_get_fuse_settings(struct drm_device *dev)
 static void mid_get_pci_revID(struct drm_psb_private *dev_priv)
 {
 	uint32_t platform_rev_id = 0;
-	struct pci_dev *pci_gfx_root = pci_get_bus_and_slot(0, PCI_DEVFN(2, 0));
+	u32 domain = pci_domain_nr(dev_priv->dev->pdev->bus);
+	struct pci_dev *pci_gfx_root =
+		pci_get_domain_bus_and_slot(domain, 0, PCI_DEVFN(2, 0));
 
 	if (pci_gfx_root == NULL) {
 		WARN_ON(1);
@@ -281,7 +284,9 @@ static void mid_get_vbt_data(struct drm_psb_private *dev_priv)
 	u32 addr;
 	u8 __iomem *vbt_virtual;
 	struct mid_vbt_header vbt_header;
-	struct pci_dev *pci_gfx_root = pci_get_bus_and_slot(0, PCI_DEVFN(2, 0));
+	u32 domain = pci_domain_nr(dev->pdev->bus);
+	struct pci_dev *pci_gfx_root =
+		pci_get_domain_bus_and_slot(domain, 0, PCI_DEVFN(2, 0));
 	int ret = -1;
 
 	/* Get the address of the platform config vbt */
diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 37a3be7..9d848fd 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -261,7 +261,11 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 		goto out_err;
 
 	if (IS_MRST(dev)) {
-		dev_priv->aux_pdev = pci_get_bus_and_slot(0, PCI_DEVFN(3, 0));
+		u32 domain = pci_domain_nr(dev->pdev->bus);
+
+		dev_priv->aux_pdev =
+			pci_get_domain_bus_and_slot(domain, 0,
+						    PCI_DEVFN(3, 0));
 
 		if (dev_priv->aux_pdev) {
 			resource_start = pci_resource_start(dev_priv->aux_pdev,
@@ -281,7 +285,9 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 		}
 		dev_priv->gmbus_reg = dev_priv->aux_reg;
 
-		dev_priv->lpc_pdev = pci_get_bus_and_slot(0, PCI_DEVFN(31, 0));
+		dev_priv->lpc_pdev =
+			pci_get_domain_bus_and_slot(domain, 0,
+						    PCI_DEVFN(31, 0));
 		if (dev_priv->lpc_pdev) {
 			pci_read_config_word(dev_priv->lpc_pdev, PSB_LPC_GBA,
 				&dev_priv->lpc_gpio_base);
diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index 821497d..fb3ea1d 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -781,38 +781,40 @@ extern int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 extern int drm_idle_check_interval;
 
 /* Utilities */
-static inline u32 MRST_MSG_READ32(uint port, uint offset)
+static inline u32 MRST_MSG_READ32(uint domain, uint port, uint offset)
 {
 	int mcr = (0xD0<<24) | (port << 16) | (offset << 8);
 	uint32_t ret_val = 0;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(domain, 0, 0);
 	pci_write_config_dword(pci_root, 0xD0, mcr);
 	pci_read_config_dword(pci_root, 0xD4, &ret_val);
 	pci_dev_put(pci_root);
 	return ret_val;
 }
-static inline void MRST_MSG_WRITE32(uint port, uint offset, u32 value)
+static inline void MRST_MSG_WRITE32(uint domain, uint port, uint offset,
+				    u32 value)
 {
 	int mcr = (0xE0<<24) | (port << 16) | (offset << 8) | 0xF0;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(domain, 0, 0);
 	pci_write_config_dword(pci_root, 0xD4, value);
 	pci_write_config_dword(pci_root, 0xD0, mcr);
 	pci_dev_put(pci_root);
 }
-static inline u32 MDFLD_MSG_READ32(uint port, uint offset)
+static inline u32 MDFLD_MSG_READ32(uint domain, uint port, uint offset)
 {
 	int mcr = (0x10<<24) | (port << 16) | (offset << 8);
 	uint32_t ret_val = 0;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(domain, 0, 0);
 	pci_write_config_dword(pci_root, 0xD0, mcr);
 	pci_read_config_dword(pci_root, 0xD4, &ret_val);
 	pci_dev_put(pci_root);
 	return ret_val;
 }
-static inline void MDFLD_MSG_WRITE32(uint port, uint offset, u32 value)
+static inline void MDFLD_MSG_WRITE32(uint domain, uint port, uint offset,
+				     u32 value)
 {
 	int mcr = (0x11<<24) | (port << 16) | (offset << 8) | 0xF0;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(domain, 0, 0);
 	pci_write_config_dword(pci_root, 0xD4, value);
 	pci_write_config_dword(pci_root, 0xD0, mcr);
 	pci_dev_put(pci_root);
-- 
1.9.1
