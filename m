Return-Path: <SRS0=EjUq=4K=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=EjUq=4K=vodafone.de=deathsimple@kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	helgaas@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/amdgpu: resize VRAM BAR for CPU access v2
Date: Thu,  4 May 2017 11:31:10 +0200
Message-Id: <1493890270-1188-6-git-send-email-deathsimple@vodafone.de>
In-Reply-To: <1493890270-1188-1-git-send-email-deathsimple@vodafone.de>
References: <1493890270-1188-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

From: Christian König <christian.koenig@amd.com>

Try to resize BAR0 to let CPU access all of VRAM.

v2: rebased, style cleanups, disable mem decode before resize,
    handle gmc_v9 as well, round size up to power of two.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  8 ++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  8 ++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 10 ++++----
 5 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0ee4d87..ed49e92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1884,6 +1884,7 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
 				 struct ttm_mem_reg *mem);
 void amdgpu_vram_location(struct amdgpu_device *adev, struct amdgpu_mc *mc, u64 base);
 void amdgpu_gtt_location(struct amdgpu_device *adev, struct amdgpu_mc *mc);
+void amdgpu_resize_bar0(struct amdgpu_device *adev);
 void amdgpu_ttm_set_active_vram_size(struct amdgpu_device *adev, u64 size);
 int amdgpu_ttm_init(struct amdgpu_device *adev);
 void amdgpu_ttm_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e685ca9..523936a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -695,6 +695,43 @@ void amdgpu_gtt_location(struct amdgpu_device *adev, struct amdgpu_mc *mc)
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
+	u64 space_needed = roundup_pow_of_two(adev->mc.real_vram_size);
+	u32 rbar_size = order_base_2(((space_needed >> 20) | 1)) -1;
+	u16 cmd;
+	int r;
+
+	/* Free the doorbell mapping, it most likely needs to move as well */
+	amdgpu_doorbell_fini(adev);
+	pci_release_resource(adev->pdev, 2);
+
+	/* Disable memory decoding while we change the BAR addresses and size */
+	pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
+	pci_write_config_word(adev->pdev, PCI_COMMAND,
+			      cmd & ~PCI_COMMAND_MEMORY);
+
+	r = pci_resize_resource(adev->pdev, 0, rbar_size);
+	if (r == -ENOSPC)
+		DRM_INFO("Not enough PCI address space for a large BAR.");
+	else if (r && r != -ENOTSUPP)
+		DRM_ERROR("Problem resizing BAR0 (%d).", r);
+
+	pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
+
+	/* When the doorbell BAR isn't available we have no chance of
+	 * using the device.
+	 */
+	BUG_ON(amdgpu_doorbell_init(adev));
+}
+
 /*
  * GPU helpers function.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index a9083a1..ae71524 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -372,13 +372,15 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 		}
 		adev->mc.vram_width = numchan * chansize;
 	}
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
index 4ac9978..1655de2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -534,13 +534,15 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 		}
 		adev->mc.vram_width = numchan * chansize;
 	}
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
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b9f11fa..d65728a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -469,16 +469,18 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 	}
 	adev->mc.vram_width = numchan * chansize;
 
-	/* Could aper size report 0 ? */
-	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
 	/* size in MB on si */
 	adev->mc.mc_vram_size =
 		nbio_v6_1_get_memsize(adev) * 1024ULL * 1024ULL;
 	adev->mc.real_vram_size = adev->mc.mc_vram_size;
-	adev->mc.visible_vram_size = adev->mc.aper_size;
+
+	if (!(adev->flags & AMD_IS_APU))
+		amdgpu_resize_bar0(adev);
+	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
+	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
 
 	/* In case the PCI BAR is larger than the actual amount of vram */
+	adev->mc.visible_vram_size = adev->mc.aper_size;
 	if (adev->mc.visible_vram_size > adev->mc.real_vram_size)
 		adev->mc.visible_vram_size = adev->mc.real_vram_size;
 
-- 
2.7.4
