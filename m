Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0076.outbound.protection.outlook.com ([104.47.42.76]:32062
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753262AbeADWSB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jan 2018 17:18:01 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org, oded.gabbay@gmail.com
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, linux-pci@vger.kernel.org
Subject: [PATCH 8/9] drm/amdkfd: Add dGPU device IDs and device info
Date: Thu,  4 Jan 2018 17:17:47 -0500
Message-Id: <1515104268-25087-9-git-send-email-Felix.Kuehling@amd.com>
In-Reply-To: <1515104268-25087-1-git-send-email-Felix.Kuehling@amd.com>
References: <1515104268-25087-1-git-send-email-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CC: linux-pci@vger.kernel.org
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 153 +++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 6dd50cc..612afaf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -63,12 +63,118 @@ static const struct kfd_device_info carrizo_device_info = {
 };
 #endif
 
+static const struct kfd_device_info hawaii_device_info = {
+	.asic_family = CHIP_HAWAII,
+	.max_pasid_bits = 16,
+	/* max num of queues for KV.TODO should be a dynamic value */
+	.max_no_of_hqd	= 24,
+	.ih_ring_entry_size = 4 * sizeof(uint32_t),
+	.event_interrupt_class = &event_interrupt_class_cik,
+	.num_of_watch_points = 4,
+	.mqd_size_aligned = MQD_SIZE_ALIGNED,
+	.supports_cwsr = false,
+	.needs_iommu_device = false,
+	.needs_pci_atomics = false,
+};
+
+static const struct kfd_device_info tonga_device_info = {
+	.asic_family = CHIP_TONGA,
+	.max_pasid_bits = 16,
+	.max_no_of_hqd  = 24,
+	.ih_ring_entry_size = 4 * sizeof(uint32_t),
+	.event_interrupt_class = &event_interrupt_class_cik,
+	.num_of_watch_points = 4,
+	.mqd_size_aligned = MQD_SIZE_ALIGNED,
+	.supports_cwsr = false,
+	.needs_iommu_device = false,
+	.needs_pci_atomics = true,
+};
+
+static const struct kfd_device_info tonga_vf_device_info = {
+	.asic_family = CHIP_TONGA,
+	.max_pasid_bits = 16,
+	.max_no_of_hqd  = 24,
+	.ih_ring_entry_size = 4 * sizeof(uint32_t),
+	.event_interrupt_class = &event_interrupt_class_cik,
+	.num_of_watch_points = 4,
+	.mqd_size_aligned = MQD_SIZE_ALIGNED,
+	.supports_cwsr = false,
+	.needs_iommu_device = false,
+	.needs_pci_atomics = false,
+};
+
+static const struct kfd_device_info fiji_device_info = {
+	.asic_family = CHIP_FIJI,
+	.max_pasid_bits = 16,
+	.max_no_of_hqd  = 24,
+	.ih_ring_entry_size = 4 * sizeof(uint32_t),
+	.event_interrupt_class = &event_interrupt_class_cik,
+	.num_of_watch_points = 4,
+	.mqd_size_aligned = MQD_SIZE_ALIGNED,
+	.supports_cwsr = true,
+	.needs_iommu_device = false,
+	.needs_pci_atomics = true,
+};
+
+static const struct kfd_device_info fiji_vf_device_info = {
+	.asic_family = CHIP_FIJI,
+	.max_pasid_bits = 16,
+	.max_no_of_hqd  = 24,
+	.ih_ring_entry_size = 4 * sizeof(uint32_t),
+	.event_interrupt_class = &event_interrupt_class_cik,
+	.num_of_watch_points = 4,
+	.mqd_size_aligned = MQD_SIZE_ALIGNED,
+	.supports_cwsr = true,
+	.needs_iommu_device = false,
+	.needs_pci_atomics = false,
+};
+
+
+static const struct kfd_device_info polaris10_device_info = {
+	.asic_family = CHIP_POLARIS10,
+	.max_pasid_bits = 16,
+	.max_no_of_hqd  = 24,
+	.ih_ring_entry_size = 4 * sizeof(uint32_t),
+	.event_interrupt_class = &event_interrupt_class_cik,
+	.num_of_watch_points = 4,
+	.mqd_size_aligned = MQD_SIZE_ALIGNED,
+	.supports_cwsr = true,
+	.needs_iommu_device = false,
+	.needs_pci_atomics = true,
+};
+
+static const struct kfd_device_info polaris10_vf_device_info = {
+	.asic_family = CHIP_POLARIS10,
+	.max_pasid_bits = 16,
+	.max_no_of_hqd  = 24,
+	.ih_ring_entry_size = 4 * sizeof(uint32_t),
+	.event_interrupt_class = &event_interrupt_class_cik,
+	.num_of_watch_points = 4,
+	.mqd_size_aligned = MQD_SIZE_ALIGNED,
+	.supports_cwsr = true,
+	.needs_iommu_device = false,
+	.needs_pci_atomics = false,
+};
+
+static const struct kfd_device_info polaris11_device_info = {
+	.asic_family = CHIP_POLARIS11,
+	.max_pasid_bits = 16,
+	.max_no_of_hqd  = 24,
+	.ih_ring_entry_size = 4 * sizeof(uint32_t),
+	.event_interrupt_class = &event_interrupt_class_cik,
+	.num_of_watch_points = 4,
+	.mqd_size_aligned = MQD_SIZE_ALIGNED,
+	.supports_cwsr = true,
+	.needs_iommu_device = false,
+	.needs_pci_atomics = true,
+};
+
+
 struct kfd_deviceid {
 	unsigned short did;
 	const struct kfd_device_info *device_info;
 };
 
-/* Please keep this sorted by increasing device id. */
 static const struct kfd_deviceid supported_devices[] = {
 #if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
 	{ 0x1304, &kaveri_device_info },	/* Kaveri */
@@ -97,8 +203,51 @@ static const struct kfd_deviceid supported_devices[] = {
 	{ 0x9874, &carrizo_device_info },	/* Carrizo */
 	{ 0x9875, &carrizo_device_info },	/* Carrizo */
 	{ 0x9876, &carrizo_device_info },	/* Carrizo */
-	{ 0x9877, &carrizo_device_info }	/* Carrizo */
+	{ 0x9877, &carrizo_device_info },	/* Carrizo */
 #endif
+	{ 0x67A0, &hawaii_device_info },	/* Hawaii */
+	{ 0x67A1, &hawaii_device_info },	/* Hawaii */
+	{ 0x67A2, &hawaii_device_info },	/* Hawaii */
+	{ 0x67A8, &hawaii_device_info },	/* Hawaii */
+	{ 0x67A9, &hawaii_device_info },	/* Hawaii */
+	{ 0x67AA, &hawaii_device_info },	/* Hawaii */
+	{ 0x67B0, &hawaii_device_info },	/* Hawaii */
+	{ 0x67B1, &hawaii_device_info },	/* Hawaii */
+	{ 0x67B8, &hawaii_device_info },	/* Hawaii */
+	{ 0x67B9, &hawaii_device_info },	/* Hawaii */
+	{ 0x67BA, &hawaii_device_info },	/* Hawaii */
+	{ 0x67BE, &hawaii_device_info },	/* Hawaii */
+	{ 0x6920, &tonga_device_info },		/* Tonga */
+	{ 0x6921, &tonga_device_info },		/* Tonga */
+	{ 0x6928, &tonga_device_info },		/* Tonga */
+	{ 0x6929, &tonga_device_info },		/* Tonga */
+	{ 0x692B, &tonga_device_info },		/* Tonga */
+	{ 0x692F, &tonga_vf_device_info },	/* Tonga vf */
+	{ 0x6938, &tonga_device_info },		/* Tonga */
+	{ 0x6939, &tonga_device_info },		/* Tonga */
+	{ 0x7300, &fiji_device_info },		/* Fiji */
+	{ 0x730F, &fiji_vf_device_info },	/* Fiji vf*/
+	{ 0x67C0, &polaris10_device_info },	/* Polaris10 */
+	{ 0x67C1, &polaris10_device_info },	/* Polaris10 */
+	{ 0x67C2, &polaris10_device_info },	/* Polaris10 */
+	{ 0x67C4, &polaris10_device_info },	/* Polaris10 */
+	{ 0x67C7, &polaris10_device_info },	/* Polaris10 */
+	{ 0x67C8, &polaris10_device_info },	/* Polaris10 */
+	{ 0x67C9, &polaris10_device_info },	/* Polaris10 */
+	{ 0x67CA, &polaris10_device_info },	/* Polaris10 */
+	{ 0x67CC, &polaris10_device_info },	/* Polaris10 */
+	{ 0x67CF, &polaris10_device_info },	/* Polaris10 */
+	{ 0x67D0, &polaris10_vf_device_info },	/* Polaris10 vf*/
+	{ 0x67DF, &polaris10_device_info },	/* Polaris10 */
+	{ 0x67E0, &polaris11_device_info },	/* Polaris11 */
+	{ 0x67E1, &polaris11_device_info },	/* Polaris11 */
+	{ 0x67E3, &polaris11_device_info },	/* Polaris11 */
+	{ 0x67E7, &polaris11_device_info },	/* Polaris11 */
+	{ 0x67E8, &polaris11_device_info },	/* Polaris11 */
+	{ 0x67E9, &polaris11_device_info },	/* Polaris11 */
+	{ 0x67EB, &polaris11_device_info },	/* Polaris11 */
+	{ 0x67EF, &polaris11_device_info },	/* Polaris11 */
+	{ 0x67FF, &polaris11_device_info },	/* Polaris11 */
 };
 
 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
-- 
2.7.4
