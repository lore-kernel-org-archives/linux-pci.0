Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754460AbdA3UlD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jan 2017 15:41:03 -0500
Subject: [PATCH v1 1/2] drm/amdgpu: remove unnecessary save/restore of
 pdev->d3_delay
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?b?S8O2bmln?= <christian.koenig@amd.com>
Cc: linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@canonical.com>
Date: Mon, 30 Jan 2017 14:40:59 -0600
Message-ID: <20170130204059.31891.74930.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170130203822.31891.22461.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170130203822.31891.22461.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove unnecessary save/restore of pdev->d3_delay.

The only assignments to pdev->d3_delay are in radeon_switcheroo_set_state()
and some quirks, none of which should be relevant in the
amdgpu_switcheroo_set_state() path.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 60bd4afe45c8..3a403a87ec62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1042,16 +1042,12 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev, enum vga_switchero
 		return;
 
 	if (state == VGA_SWITCHEROO_ON) {
-		unsigned d3_delay = dev->pdev->d3_delay;
-
 		printk(KERN_INFO "amdgpu: switched on\n");
 		/* don't suspend or resume card normally */
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 		amdgpu_device_resume(dev, true, true);
 
-		dev->pdev->d3_delay = d3_delay;
-
 		dev->switch_power_state = DRM_SWITCH_POWER_ON;
 		drm_kms_helper_poll_enable(dev);
 	} else {

