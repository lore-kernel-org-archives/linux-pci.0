Return-Path: <SRS0=31GW=6N=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=31GW=6N=vodafone.de=deathsimple@kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH v8 5/6] drm/amdgpu: move hw generation check into amdgpu_doorbell_init v2
Date: Mon, 10 Jul 2017 16:59:53 +0200
Message-Id: <1499698794-1718-6-git-send-email-deathsimple@vodafone.de>
In-Reply-To: <1499698794-1718-1-git-send-email-deathsimple@vodafone.de>
References: <1499698794-1718-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

From: Christian König <christian.koenig@amd.com>

This way we can safely call it on SI as well.

v2: fix type in commit message

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4a8fc15..7d1a04a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -419,6 +419,15 @@ void amdgpu_pci_config_reset(struct amdgpu_device *adev)
  */
 static int amdgpu_doorbell_init(struct amdgpu_device *adev)
 {
+	/* No doorbell on SI hardware generation */
+	if (adev->asic_type < CHIP_BONAIRE) {
+		adev->doorbell.base = 0;
+		adev->doorbell.size = 0;
+		adev->doorbell.num_doorbells = 0;
+		adev->doorbell.ptr = NULL;
+		return 0;
+	}
+
 	/* doorbell bar mapping */
 	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
 	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
@@ -2099,9 +2108,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
 	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
 
-	if (adev->asic_type >= CHIP_BONAIRE)
-		/* doorbell bar mapping */
-		amdgpu_doorbell_init(adev);
+	/* doorbell bar mapping */
+	amdgpu_doorbell_init(adev);
 
 	/* io port mapping */
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
@@ -2307,8 +2315,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	adev->rio_mem = NULL;
 	iounmap(adev->rmmio);
 	adev->rmmio = NULL;
-	if (adev->asic_type >= CHIP_BONAIRE)
-		amdgpu_doorbell_fini(adev);
+	amdgpu_doorbell_fini(adev);
 	amdgpu_debugfs_regs_cleanup(adev);
 }
 
-- 
2.7.4
