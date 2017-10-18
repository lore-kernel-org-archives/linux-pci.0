Return-Path: <SRS0=alSj=BR=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=alSj=BR=gmail.com=ckoenig.leichtzumerken@kernel.org>
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH v9 5/5] drm/amdgpu: resize VRAM BAR for CPU access v5
Date: Wed, 18 Oct 2017 15:58:21 +0200
Message-Id: <20171018135821.3248-6-deathsimple@vodafone.de>
In-Reply-To: <20171018135821.3248-1-deathsimple@vodafone.de>
References: <20171018135821.3248-1-deathsimple@vodafone.de>
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
v5: reorder resource release, return -ENODEV instead of BUG_ON().

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 48 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 12 ++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 13 ++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 13 ++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 14 ++++++---
 6 files changed, 88 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7ecfc5303f4f..ac4e6f6fb6d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1850,6 +1850,7 @@ void amdgpu_ttm_placement_from_domain(struct amdgpu_bo *abo, u32 domain);
 bool amdgpu_ttm_bo_is_amdgpu_bo(struct ttm_buffer_object *bo);
 void amdgpu_vram_location(struct amdgpu_device *adev, struct amdgpu_mc *mc, u64 base);
 void amdgpu_gart_location(struct amdgpu_device *adev, struct amdgpu_mc *mc);
+int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev);
 void amdgpu_ttm_set_active_vram_size(struct amdgpu_device *adev, u64 size);
 int amdgpu_ttm_init(struct amdgpu_device *adev);
 void amdgpu_ttm_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 57addfe9e89b..8f2be5a36625 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -414,6 +414,9 @@ static int amdgpu_doorbell_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
+	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
+		return -EINVAL;
+
 	/* doorbell bar mapping */
 	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
 	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
@@ -732,6 +735,51 @@ int amdgpu_fw_reserve_vram_init(struct amdgpu_device *adev)
 	return r;
 }
 
+/**
+ * amdgpu_device_resize_fb_bar - try to resize FB BAR
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Try to resize FB BAR to make all VRAM CPU accessible. We try very hard not
+ * to fail, but if any of the BARs is not accessible after the size we abort
+ * driver loading by returning -ENODEV.
+ */
+int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
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
+	if (adev->asic_type >= CHIP_BONAIRE)
+		pci_release_resource(adev->pdev, 2);
+
+	pci_release_resource(adev->pdev, 0);
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
+	if (r || (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET))
+		return -ENODEV;
+
+	pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
+}
 
 /*
  * GPU helpers function.
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index f4603a7c8ef3..d2a43db22cff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -283,6 +283,7 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
 
 	u32 tmp;
 	int chansize, numchan;
+	int r;
 
 	tmp = RREG32(mmMC_ARB_RAMCFG);
 	if (tmp & (1 << 11)) {
@@ -324,12 +325,17 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
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
+	if (!(adev->flags & AMD_IS_APU)) {
+		r = amdgpu_device_resize_fb_bar(adev);
+		if (r)
+			return r;
+	}
+	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
+	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
 	adev->mc.visible_vram_size = adev->mc.aper_size;
 
 	/* set the gart size */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index b0528ca9207b..583d87792820 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -322,6 +322,8 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
  */
 static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 {
+	int r;
+
 	adev->mc.vram_width = amdgpu_atombios_get_vram_width(adev);
 	if (!adev->mc.vram_width) {
 		u32 tmp;
@@ -367,13 +369,18 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 		}
 		adev->mc.vram_width = numchan * chansize;
 	}
-	/* Could aper size report 0 ? */
-	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
 	/* size in MB on si */
 	adev->mc.mc_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
 	adev->mc.real_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
 
+	if (!(adev->flags & AMD_IS_APU)) {
+		r = amdgpu_device_resize_fb_bar(adev);
+		if (r)
+			return r;
+	}
+	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
+	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
+
 #ifdef CONFIG_X86_64
 	if (adev->flags & AMD_IS_APU) {
 		adev->mc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index f368cfe2f585..9ca5fea93ebc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -498,6 +498,8 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
  */
 static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 {
+	int r;
+
 	adev->mc.vram_width = amdgpu_atombios_get_vram_width(adev);
 	if (!adev->mc.vram_width) {
 		u32 tmp;
@@ -543,13 +545,18 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 		}
 		adev->mc.vram_width = numchan * chansize;
 	}
-	/* Could aper size report 0 ? */
-	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
 	/* size in MB on si */
 	adev->mc.mc_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
 	adev->mc.real_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
 
+	if (!(adev->flags & AMD_IS_APU)) {
+		r = amdgpu_device_resize_fb_bar(adev);
+		if (r)
+			return r;
+	}
+	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
+	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
+
 #ifdef CONFIG_X86_64
 	if (adev->flags & AMD_IS_APU) {
 		adev->mc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 621699331e09..0de4dc068516 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -440,6 +440,7 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 {
 	u32 tmp;
 	int chansize, numchan;
+	int r;
 
 	adev->mc.vram_width = amdgpu_atomfirmware_get_vram_width(adev);
 	if (!adev->mc.vram_width) {
@@ -482,17 +483,22 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 		adev->mc.vram_width = numchan * chansize;
 	}
 
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
+	if (!(adev->flags & AMD_IS_APU)) {
+		r = amdgpu_device_resize_fb_bar(adev);
+		if (r)
+			return r;
+	}
+	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
+	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
 
 	/* In case the PCI BAR is larger than the actual amount of vram */
+	adev->mc.visible_vram_size = adev->mc.aper_size;
 	if (adev->mc.visible_vram_size > adev->mc.real_vram_size)
 		adev->mc.visible_vram_size = adev->mc.real_vram_size;
 
-- 
2.11.0
