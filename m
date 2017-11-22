Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH 08/30] drm/gma500: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 00:30:53 -0500
Message-Id: <1511328675-21981-9-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Sinan Kaya <okaya@codeaurora.org>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/gpu/drm/gma500/cdv_device.c | 4 ++--
 drivers/gpu/drm/gma500/gma_device.c | 2 +-
 drivers/gpu/drm/gma500/mid_bios.c   | 8 +++++---
 drivers/gpu/drm/gma500/psb_drv.c    | 7 +++++--
 drivers/gpu/drm/gma500/psb_drv.h    | 8 ++++----
 5 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_device.c b/drivers/gpu/drm/gma500/cdv_device.c
index 8745971..da9630f 100644
--- a/drivers/gpu/drm/gma500/cdv_device.c
+++ b/drivers/gpu/drm/gma500/cdv_device.c
@@ -189,7 +189,7 @@ static inline u32 CDV_MSG_READ32(uint port, uint offset)
 {
 	int mcr = (0x10<<24) | (port << 16) | (offset << 8);
 	uint32_t ret_val = 0;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(0, 0, 0);
 	pci_write_config_dword(pci_root, 0xD0, mcr);
 	pci_read_config_dword(pci_root, 0xD4, &ret_val);
 	pci_dev_put(pci_root);
@@ -199,7 +199,7 @@ static inline u32 CDV_MSG_READ32(uint port, uint offset)
 static inline void CDV_MSG_WRITE32(uint port, uint offset, u32 value)
 {
 	int mcr = (0x11<<24) | (port << 16) | (offset << 8) | 0xF0;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(0, 0, 0);
 	pci_write_config_dword(pci_root, 0xD4, value);
 	pci_write_config_dword(pci_root, 0xD0, mcr);
 	pci_dev_put(pci_root);
diff --git a/drivers/gpu/drm/gma500/gma_device.c b/drivers/gpu/drm/gma500/gma_device.c
index 4a295f9..5dd5335 100644
--- a/drivers/gpu/drm/gma500/gma_device.c
+++ b/drivers/gpu/drm/gma500/gma_device.c
@@ -19,7 +19,7 @@
 void gma_get_core_freq(struct drm_device *dev)
 {
 	uint32_t clock;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(0, 0, 0);
 	struct drm_psb_private *dev_priv = dev->dev_private;
 
 	/*pci_write_config_dword(pci_root, 0xD4, 0x00C32004);*/
diff --git a/drivers/gpu/drm/gma500/mid_bios.c b/drivers/gpu/drm/gma500/mid_bios.c
index d75ecb3..fed2c7a 100644
--- a/drivers/gpu/drm/gma500/mid_bios.c
+++ b/drivers/gpu/drm/gma500/mid_bios.c
@@ -32,7 +32,7 @@
 static void mid_get_fuse_settings(struct drm_device *dev)
 {
 	struct drm_psb_private *dev_priv = dev->dev_private;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(0, 0, 0);
 	uint32_t fuse_value = 0;
 	uint32_t fuse_value_tmp = 0;
 
@@ -104,7 +104,8 @@ static void mid_get_fuse_settings(struct drm_device *dev)
 static void mid_get_pci_revID(struct drm_psb_private *dev_priv)
 {
 	uint32_t platform_rev_id = 0;
-	struct pci_dev *pci_gfx_root = pci_get_bus_and_slot(0, PCI_DEVFN(2, 0));
+	uint16_t devfn = PCI_DEVFN(2, 0);
+	struct pci_dev *pci_gfx_root = pci_get_domain_bus_and_slot(0, 0, devfn);
 
 	if (pci_gfx_root == NULL) {
 		WARN_ON(1);
@@ -281,7 +282,8 @@ static void mid_get_vbt_data(struct drm_psb_private *dev_priv)
 	u32 addr;
 	u8 __iomem *vbt_virtual;
 	struct mid_vbt_header vbt_header;
-	struct pci_dev *pci_gfx_root = pci_get_bus_and_slot(0, PCI_DEVFN(2, 0));
+	uint16_t devfn = PCI_DEVFN(2, 0);
+	struct pci_dev *pci_gfx_root = pci_get_domain_bus_and_slot(0, 0, devfn);
 	int ret = -1;
 
 	/* Get the address of the platform config vbt */
diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 37a3be7..5327729 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -261,7 +261,9 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 		goto out_err;
 
 	if (IS_MRST(dev)) {
-		dev_priv->aux_pdev = pci_get_bus_and_slot(0, PCI_DEVFN(3, 0));
+		uint16_t devfn = PCI_DEVFN(3, 0);
+
+		dev_priv->aux_pdev = pci_get_domain_bus_and_slot(0, 0, devfn);
 
 		if (dev_priv->aux_pdev) {
 			resource_start = pci_resource_start(dev_priv->aux_pdev,
@@ -281,7 +283,8 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 		}
 		dev_priv->gmbus_reg = dev_priv->aux_reg;
 
-		dev_priv->lpc_pdev = pci_get_bus_and_slot(0, PCI_DEVFN(31, 0));
+		devfn = PCI_DEVFN(31, 0);
+		dev_priv->lpc_pdev = pci_get_domain_bus_and_slot(0, 0, devfn);
 		if (dev_priv->lpc_pdev) {
 			pci_read_config_word(dev_priv->lpc_pdev, PSB_LPC_GBA,
 				&dev_priv->lpc_gpio_base);
diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index 821497d..0959191 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -785,7 +785,7 @@ static inline u32 MRST_MSG_READ32(uint port, uint offset)
 {
 	int mcr = (0xD0<<24) | (port << 16) | (offset << 8);
 	uint32_t ret_val = 0;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(0, 0, 0);
 	pci_write_config_dword(pci_root, 0xD0, mcr);
 	pci_read_config_dword(pci_root, 0xD4, &ret_val);
 	pci_dev_put(pci_root);
@@ -794,7 +794,7 @@ static inline u32 MRST_MSG_READ32(uint port, uint offset)
 static inline void MRST_MSG_WRITE32(uint port, uint offset, u32 value)
 {
 	int mcr = (0xE0<<24) | (port << 16) | (offset << 8) | 0xF0;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(0, 0, 0);
 	pci_write_config_dword(pci_root, 0xD4, value);
 	pci_write_config_dword(pci_root, 0xD0, mcr);
 	pci_dev_put(pci_root);
@@ -803,7 +803,7 @@ static inline u32 MDFLD_MSG_READ32(uint port, uint offset)
 {
 	int mcr = (0x10<<24) | (port << 16) | (offset << 8);
 	uint32_t ret_val = 0;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(0, 0, 0);
 	pci_write_config_dword(pci_root, 0xD0, mcr);
 	pci_read_config_dword(pci_root, 0xD4, &ret_val);
 	pci_dev_put(pci_root);
@@ -812,7 +812,7 @@ static inline u32 MDFLD_MSG_READ32(uint port, uint offset)
 static inline void MDFLD_MSG_WRITE32(uint port, uint offset, u32 value)
 {
 	int mcr = (0x11<<24) | (port << 16) | (offset << 8) | 0xF0;
-	struct pci_dev *pci_root = pci_get_bus_and_slot(0, 0);
+	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(0, 0, 0);
 	pci_write_config_dword(pci_root, 0xD4, value);
 	pci_write_config_dword(pci_root, 0xD0, mcr);
 	pci_dev_put(pci_root);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
