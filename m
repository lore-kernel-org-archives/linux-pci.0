Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/amdgpu: fix printing the doorbell BAR info
Date: Mon,  6 Mar 2017 12:40:27 +0100
Message-Id: <1488800428-2854-4-git-send-email-deathsimple@vodafone.de>
In-Reply-To: <1488800428-2854-1-git-send-email-deathsimple@vodafone.de>
References: <1488800428-2854-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Christian König <christian.koenig@amd.com>

The address is 64bit, not 32bit.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bf31aaf..a470869 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -385,7 +385,7 @@ static int amdgpu_doorbell_init(struct amdgpu_device *adev)
 	if (adev->doorbell.ptr == NULL) {
 		return -ENOMEM;
 	}
-	DRM_INFO("doorbell mmio base: 0x%08X\n", (uint32_t)adev->doorbell.base);
+	DRM_INFO("doorbell mmio base: 0x%llX\n", (uint64_t)adev->doorbell.base);
 	DRM_INFO("doorbell mmio size: %u\n", (unsigned)adev->doorbell.size);
 
 	return 0;
-- 
2.7.4
