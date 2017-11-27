Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        intel-gfx@lists.freedesktop.org, Sinan Kaya <okaya@codeaurora.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS),
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3 10/29] drm/nouveau: deprecate pci_get_bus_and_slot()
Date: Mon, 27 Nov 2017 11:57:47 -0500
Message-Id: <1511801886-6753-11-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Replace pci_get_bus_and_slot() with pci_get_domain_bus_and_slot()
and extract the domain number from
1. struct pci_dev
2. struct pci_dev through drm_device->pdev
3. struct pci_dev through fb->subdev->drm_device->pdev

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/gpu/drm/nouveau/dispnv04/arb.c           |  4 +++-
 drivers/gpu/drm/nouveau/dispnv04/hw.c            | 10 +++++++---
 drivers/gpu/drm/nouveau/nouveau_drm.c            |  3 ++-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c | 10 +++++++++-
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/arb.c b/drivers/gpu/drm/nouveau/dispnv04/arb.c
index 90075b6..c79160c 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/arb.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/arb.c
@@ -213,8 +213,10 @@ struct nv_sim_state {
 	if ((dev->pdev->device & 0xffff) == 0x01a0 /*CHIPSET_NFORCE*/ ||
 	    (dev->pdev->device & 0xffff) == 0x01f0 /*CHIPSET_NFORCE2*/) {
 		uint32_t type;
+		int domain = pci_domain_nr(dev->pdev->bus);
 
-		pci_read_config_dword(pci_get_bus_and_slot(0, 1), 0x7c, &type);
+		pci_read_config_dword(pci_get_domain_bus_and_slot(domain, 0, 1),
+				      0x7c, &type);
 
 		sim_data.memory_type = (type >> 12) & 1;
 		sim_data.memory_width = 64;
diff --git a/drivers/gpu/drm/nouveau/dispnv04/hw.c b/drivers/gpu/drm/nouveau/dispnv04/hw.c
index b985990..0c9bdf0 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/hw.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/hw.c
@@ -216,12 +216,15 @@
 {
 	struct nvkm_pll_vals pllvals;
 	int ret;
+	int domain;
+
+	domain = pci_domain_nr(dev->pdev->bus);
 
 	if (plltype == PLL_MEMORY &&
 	    (dev->pdev->device & 0x0ff0) == CHIPSET_NFORCE) {
 		uint32_t mpllP;
-
-		pci_read_config_dword(pci_get_bus_and_slot(0, 3), 0x6c, &mpllP);
+		pci_read_config_dword(pci_get_domain_bus_and_slot(domain, 0, 3),
+				      0x6c, &mpllP);
 		mpllP = (mpllP >> 8) & 0xf;
 		if (!mpllP)
 			mpllP = 4;
@@ -232,7 +235,8 @@
 	    (dev->pdev->device & 0xff0) == CHIPSET_NFORCE2) {
 		uint32_t clock;
 
-		pci_read_config_dword(pci_get_bus_and_slot(0, 5), 0x4c, &clock);
+		pci_read_config_dword(pci_get_domain_bus_and_slot(domain, 0, 5),
+				      0x4c, &clock);
 		return clock / 1000;
 	}
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 595630d..0b6c639 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -406,7 +406,8 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 	}
 
 	/* subfunction one is a hdmi audio device? */
-	drm->hdmi_device = pci_get_bus_and_slot((unsigned int)pdev->bus->number,
+	drm->hdmi_device = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+						(unsigned int)pdev->bus->number,
 						PCI_DEVFN(PCI_SLOT(pdev->devfn), 1));
 
 	if (!drm->hdmi_device) {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
index 3c6a871..8849b71 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
@@ -28,8 +28,16 @@
 {
 	struct pci_dev *bridge;
 	u32 mem, mib;
+	int domain = 0;
+	struct pci_dev *pdev = NULL;
 
-	bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 1));
+	if (dev_is_pci(fb->subdev.device->dev))
+		pdev = to_pci_dev(fb->subdev.device->dev);
+
+	if (pdev)
+		domain = pci_domain_nr(pdev->bus);
+
+	bridge = pci_get_domain_bus_and_slot(domain, 0, PCI_DEVFN(0, 1));
 	if (!bridge) {
 		nvkm_error(&fb->subdev, "no bridge device\n");
 		return -ENODEV;
-- 
1.9.1
