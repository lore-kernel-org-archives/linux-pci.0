Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0078.outbound.protection.outlook.com ([104.47.42.78]:32395
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753262AbeADWR6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jan 2018 17:17:58 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org, oded.gabbay@gmail.com
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, linux-pci@vger.kernel.org
Subject: [PATCH 2/9] drm/amdkfd: Conditionally enable PCIe atomics
Date: Thu,  4 Jan 2018 17:17:41 -0500
Message-Id: <1515104268-25087-3-git-send-email-Felix.Kuehling@amd.com>
In-Reply-To: <1515104268-25087-1-git-send-email-Felix.Kuehling@amd.com>
References: <1515104268-25087-1-git-send-email-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This will be needed for most dGPUs.

CC: linux-pci@vger.kernel.org
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index a8fa33a..fafe971 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -41,6 +41,7 @@ static const struct kfd_device_info kaveri_device_info = {
 	.num_of_watch_points = 4,
 	.mqd_size_aligned = MQD_SIZE_ALIGNED,
 	.supports_cwsr = false,
+	.needs_pci_atomics = false,
 };
 
 static const struct kfd_device_info carrizo_device_info = {
@@ -53,6 +54,7 @@ static const struct kfd_device_info carrizo_device_info = {
 	.num_of_watch_points = 4,
 	.mqd_size_aligned = MQD_SIZE_ALIGNED,
 	.supports_cwsr = true,
+	.needs_pci_atomics = false,
 };
 
 struct kfd_deviceid {
@@ -127,6 +129,21 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
 		return NULL;
 	}
 
+	if (device_info->needs_pci_atomics) {
+		/* Allow BIF to recode atomics to PCIe 3.0
+		 * AtomicOps. 32 and 64-bit requests are possible and
+		 * must be supported.
+		 */
+		if (pci_enable_atomic_ops_to_root(pdev,
+				PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+				PCI_EXP_DEVCAP2_ATOMIC_COMP64) < 0) {
+			dev_info(kfd_device,
+				"skipped device %x:%x, PCI rejects atomics",
+				 pdev->vendor, pdev->device);
+			return NULL;
+		}
+	}
+
 	kfd = kzalloc(sizeof(*kfd), GFP_KERNEL);
 	if (!kfd)
 		return NULL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 6a48d29..eebfb1e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -158,6 +158,7 @@ struct kfd_device_info {
 	uint8_t num_of_watch_points;
 	uint16_t mqd_size_aligned;
 	bool supports_cwsr;
+	bool needs_pci_atomics;
 };
 
 struct kfd_mem_obj {
-- 
2.7.4
