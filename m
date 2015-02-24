Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56093 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851AbbBXUMv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Feb 2015 15:12:51 -0500
Subject: [PATCH 2/2] nouveau/radeon: Un-ignore hotplug on resume
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org, airlied@linux.ie,
	alexander.deucher@amd.com, dri-devel@lists.freedesktop.org
Cc: alex.williamson@redhat.com, linux-kernel@vger.kernel.org
Date: Tue, 24 Feb 2015 13:12:40 -0700
Message-ID: <20150224201240.14443.6308.stgit@gimli.home>
In-Reply-To: <20150224200603.14443.68971.stgit@gimli.home>
References: <20150224200603.14443.68971.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit b440bde74f04 enabled drivers to be able to set an ignore
hotplug flag on the device and used it in the suspend routine for
nouveau and radeon to prevent hotplug when the device is powered off.
However, there was no undo function provided, so once set, the ignore
hotplug flag lives on for the life of the pci_dev.  I think the
intention was only to ignore hotplug across the power event for the
device, so we should be able to clear the flag on resume.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c |    1 +
 drivers/gpu/drm/radeon/radeon_drv.c   |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 8763deb..b168c3a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -749,6 +749,7 @@ nouveau_pmops_runtime_resume(struct device *dev)
 		return -EINVAL;
 
 	pci_set_power_state(pdev, PCI_D0);
+	pci_unignore_hotplug(pdev);
 	pci_restore_state(pdev);
 	ret = pci_enable_device(pdev);
 	if (ret)
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 5d684be..1c7c79b 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -472,6 +472,7 @@ static int radeon_pmops_runtime_resume(struct device *dev)
 	drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 	pci_set_power_state(pdev, PCI_D0);
+	pci_unignore_hotplug(pdev);
 	pci_restore_state(pdev);
 	ret = pci_enable_device(pdev);
 	if (ret)

