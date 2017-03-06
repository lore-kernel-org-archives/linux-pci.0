Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/amdgpu: resize VRAM BAR for CPU access
Date: Mon,  6 Mar 2017 12:40:28 +0100
Message-Id: <1488800428-2854-5-git-send-email-deathsimple@vodafone.de>
In-Reply-To: <1488800428-2854-1-git-send-email-deathsimple@vodafone.de>
References: <1488800428-2854-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Christian König <christian.koenig@amd.com>

Try to resize BAR0 to let CPU access all of VRAM.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 +++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  8 +++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  8 +++++---
 4 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8a5f8cb..1e888d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1754,6 +1754,7 @@ uint32_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
 				 struct ttm_mem_reg *mem);
 void amdgpu_vram_location(struct amdgpu_device *adev, struct amdgpu_mc *mc, u64 base);
 void amdgpu_gtt_location(struct amdgpu_device *adev, struct amdgpu_mc *mc);
+void amdgpu_resize_bar0(struct amdgpu_device *adev);
 void amdgpu_ttm_set_active_vram_size(struct amdgpu_device *adev, u64 size);
 int amdgpu_ttm_init(struct amdgpu_device *adev);
 void amdgpu_ttm_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a470869..f038195 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -616,6 +616,35 @@ void amdgpu_gtt_location(struct amdgpu_device *adev, struct amdgpu_mc *mc)
 			mc->gtt_size >> 20, mc->gtt_start, mc->gtt_end);
 }
 
+/**
+ * amdgpu_resize_bar0 - try to resize BAR0
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Try to resize BAR0 to make all VRAM CPU accessible.
+ */
+void amdgpu_resize_bar0(struct amdgpu_device *adev)
+{
+	u32 size = max(ilog2(adev->mc.real_vram_size - 1) + 1, 20) - 20;
+	int r;
+
+	r = pci_resize_resource(adev->pdev, 0, size);
+
+	if (r == -ENOTSUPP) {
+		/* The hardware don't support the extension. */
+		return;
+
+	} else if (r == -ENOSPC) {
+		DRM_INFO("Not enoigh PCI address space for a large BAR.");
+	} else if (r) {
+		DRM_ERROR("Problem resizing BAR0 (%d).", r);
+	}
+
+	/* Reinit the doorbell mapping, it is most likely moved as well */
+	amdgpu_doorbell_fini(adev);
+	BUG_ON(amdgpu_doorbell_init(adev));
+}
+
 /*
  * GPU helpers function.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 552bf6b..cd5828c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -367,13 +367,15 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 		break;
 	}
 	adev->mc.vram_width = numchan * chansize;
-	/* Could aper size report 0 ? */
-	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
 	/* size in MB on si */
 	adev->mc.mc_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
 	adev->mc.real_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
 
+	if (!(adev->flags & AMD_IS_APU))
+		amdgpu_resize_bar0(adev);
+	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
+	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
+
 #ifdef CONFIG_X86_64
 	if (adev->flags & AMD_IS_APU) {
 		adev->mc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index f2bd016..e277130 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -459,13 +459,15 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 		break;
 	}
 	adev->mc.vram_width = numchan * chansize;
-	/* Could aper size report 0 ? */
-	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
 	/* size in MB on si */
 	adev->mc.mc_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
 	adev->mc.real_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
 
+	if (!(adev->flags & AMD_IS_APU))
+		amdgpu_resize_bar0(adev);
+	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
+	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
+
 #ifdef CONFIG_X86_64
 	if (adev->flags & AMD_IS_APU) {
 		adev->mc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
-- 
2.7.4
