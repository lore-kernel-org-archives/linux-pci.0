Return-Path: <SRS0=31GW=6N=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=31GW=6N=vodafone.de=deathsimple@kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH v8 6/6] drm/amdgpu: resize VRAM BAR for CPU access v4
Date: Mon, 10 Jul 2017 16:59:54 +0200
Message-Id: <1499698794-1718-7-git-send-email-deathsimple@vodafone.de>
In-Reply-To: <1499698794-1718-1-git-send-email-deathsimple@vodafone.de>
References: <1499698794-1718-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

From: Christian König <christian.koenig@amd.com>

Try to resize BAR0 to let CPU access all of VRAM.

v2: rebased, style cleanups, disable mem decode before resize,
    handle gmc_v9 as well, round size up to power of two.
v3: handle gmc_v6 as well, release and reassign all BARs in the driver.
v4: rename new function to amdgpu_device_resize_fb_bar,
    reenable mem decoding only if all resources are assigned.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 46 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  8 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  8 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  8 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 10 ++++---
 6 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ff7bf1a..5809e0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1944,6 +1944,7 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
 				 struct ttm_mem_reg *mem);
 void amdgpu_vram_location(struct amdgpu_device *adev, struct amdgpu_mc *mc, u64 base);
 void amdgpu_gtt_location(struct amdgpu_device *adev, struct amdgpu_mc *mc);
+void amdgpu_device_resize_fb_bar(struct amdgpu_device *adev);
 void amdgpu_ttm_set_active_vram_size(struct amdgpu_device *adev, u64 size);
 int amdgpu_ttm_init(struct amdgpu_device *adev);
 void amdgpu_ttm_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7d1a04a..a5123f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -428,6 +428,9 @@ static int amdgpu_doorbell_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
+	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
+		return -EINVAL;
+
 	/* doorbell bar mapping */
 	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
 	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
@@ -709,6 +712,49 @@ void amdgpu_gtt_location(struct amdgpu_device *adev, struct amdgpu_mc *mc)
 			mc->gtt_size >> 20, mc->gtt_start, mc->gtt_end);
 }
 
+/**
+ * amdgpu_device_resize_fb_bar - try to resize FB BAR
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Try to resize FB BAR to make all VRAM CPU accessible.
+ */
+void amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
+{
+	u64 space_needed = roundup_pow_of_two(adev->mc.real_vram_size);
+	u32 rbar_size = order_base_2(((space_needed >> 20) | 1)) - 1;
+	u16 cmd;
+	int r;
+
+	/* Disable memory decoding while we change the BAR addresses and size */
+	pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
+	pci_write_config_word(adev->pdev, PCI_COMMAND,
+			      cmd & ~PCI_COMMAND_MEMORY);
+
+	/* Free the VRAM and doorbell BAR, we most likely need to move both. */
+	amdgpu_doorbell_fini(adev);
+	pci_release_resource(adev->pdev, 0);
+	if (adev->asic_type >= CHIP_BONAIRE)
+		pci_release_resource(adev->pdev, 2);
+
+	r = pci_resize_resource(adev->pdev, 0, rbar_size);
+	if (r == -ENOSPC)
+		DRM_INFO("Not enough PCI address space for a large BAR.");
+	else if (r && r != -ENOTSUPP)
+		DRM_ERROR("Problem resizing BAR0 (%d).", r);
+
+	pci_assign_unassigned_bus_resources(adev->pdev->bus);
+
+	/* When the doorbell or fb BAR isn't available we have no chance of
+	 * using the device.
+	 */
+	r = amdgpu_doorbell_init(adev);
+	if ((pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET) || r)
+		BUG();
+	else
+		pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
+}
+
 /*
  * GPU helpers function.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index d0214d9..89bb2e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -334,12 +334,14 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
 		break;
 	}
 	adev->mc.vram_width = numchan * chansize;
-	/* Could aper size report 0 ? */
-	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
 	/* size in MB on si */
 	adev->mc.mc_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
 	adev->mc.real_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
+
+	if (!(adev->flags & AMD_IS_APU))
+		amdgpu_device_resize_fb_bar(adev);
+	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
+	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
 	adev->mc.visible_vram_size = adev->mc.aper_size;
 
 	/* unless the user had overridden it, set the gart
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 7e9ea53..91d1b0c 100644
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
+		amdgpu_device_resize_fb_bar(adev);
+	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
+	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
+
 #ifdef CONFIG_X86_64
 	if (adev->flags & AMD_IS_APU) {
 		adev->mc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index cc9f880..cd04d59 100644
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
+		amdgpu_device_resize_fb_bar(adev);
+	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
+	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
+
 #ifdef CONFIG_X86_64
 	if (adev->flags & AMD_IS_APU) {
 		adev->mc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 175ba5f..99fb632 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -480,17 +480,19 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 	}
 	adev->mc.vram_width = numchan * chansize;
 
-	/* Could aper size report 0 ? */
-	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
 	/* size in MB on si */
 	adev->mc.mc_vram_size =
 		((adev->flags & AMD_IS_APU) ? nbio_v7_0_get_memsize(adev) :
 		 nbio_v6_1_get_memsize(adev)) * 1024ULL * 1024ULL;
 	adev->mc.real_vram_size = adev->mc.mc_vram_size;
-	adev->mc.visible_vram_size = adev->mc.aper_size;
+
+	if (!(adev->flags & AMD_IS_APU))
+		amdgpu_device_resize_fb_bar(adev);
+	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
+	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
 
 	/* In case the PCI BAR is larger than the actual amount of vram */
+	adev->mc.visible_vram_size = adev->mc.aper_size;
 	if (adev->mc.visible_vram_size > adev->mc.real_vram_size)
 		adev->mc.visible_vram_size = adev->mc.real_vram_size;
 
-- 
2.7.4
