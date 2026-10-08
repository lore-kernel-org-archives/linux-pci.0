Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F83016E0;
	Thu,  8 Oct 2026 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439281; cv=none; b=Pq3wCG1jNJNE0exzQiPMMw+o6837MaMGU4ojxfOn8VS3A2uTBoUUaqRvkdlcRwSNFs67/qYfUlShIYowo6Kys1G3IAcg0yIwB4jW5wawHbjgE+9aDBam5zJi4oRhECHSrwQWs/c8EL55PQ4vNGFLpbuMHxKlxpeOqJmP/27o94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439281; c=relaxed/simple;
	bh=USTXthyMaP/CDRvw9KxWZzJImNZVCc4PiFiQW1vCp7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHVF6L7x8m8WSkIujBStfbqhJRzDydzhztXlJSllAmh6LfO9YxW3/Mm129zfjX08zFzGaHaO60Xde+jEQ2RiR0TjWQ+OzmTUmeefXv9xwajw6RhtB76LlczpCaFqQBedl7/pYODIFR4cZpa8T0GSGwfRODDzuXSyTxmaE6RGNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euY2KXDg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euY2KXDg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D858F1F000FF;
	Thu,  8 Oct 2026 06:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439280;
	bh=mh+jpZoeOEbwSudvZpsjxgMif54AcOxI9//qlJRK0SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=euY2KXDg2JXzUSXQigTRcGUOgwpn6CXlswhELUDkM+6RSwlASEA+tol7lH171GHTV
	 NhlCgCehT9DoIu5SNT1kC3qwmCJjW+Dkpz2Cw6HIWuKshJI8b6IvV+axNXTADj//3L
	 +PzQoVAjpQ7Ql7jxKDzxtTkENmsaa0YfMLlrJwY2Evr3ss1CJkXvUjPv0Ltibq8y56
	 6GZinTv3qd4daaT0BQ3arWjM6SpqGkuZinQi6Zh/Mr+KtpCHfKrflaR1wB2KaIYDxx
	 jqvJNL3sj3MPxfCxRBM98n8jI2BON4ZGxFBxe/xCdsLLTsElMzPidVFMo9aZUP0rHH
	 o5mDG1FODwHHA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 07/16] iommufd/device: Associate KVM file pointer with iommufd_device
Date: Thu,  8 Oct 2026 11:29:46 +0530
Message-ID: <20261008055955.4014342-8-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

TSM vDevice support needs access to the KVM associated with a VFIO device
after the device has been bound to iommufd.

Extend iommufd_device_bind() to accept the device's KVM file and store it
in the iommufd_device. The KVM file reference is owned by VFIO and is
already held for the duration of the device open path.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
[nicolinc: fix build error in iommufd_test_mock_domain()]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
[aneesh.kumar: Switch to use kvm_file]
Cc: jgg@ziepe.ca
Cc: kevin.tian@intel.com
Cc: joro@8bytes.org
Cc: will@kernel.org
Cc: robin.murphy@arm.com
Cc: alex@shazbot.org
Cc: kvm@vger.kernel.org
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/device.c          | 7 ++++++-
 drivers/iommu/iommufd/iommufd_private.h | 2 ++
 drivers/iommu/iommufd/selftest.c        | 2 +-
 drivers/vfio/iommufd.c                  | 3 ++-
 include/linux/iommufd.h                 | 4 +++-
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a664c70a6fe7..f99f7bee2e77 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -295,6 +295,7 @@ static int iommufd_bind_noiommu(struct iommufd_device *idev)
  * iommufd_device_bind - Bind a physical device to an iommu fd
  * @ictx: iommufd file descriptor
  * @dev: Pointer to a physical device struct
+ * @kvm_file: VM file if device belongs to a KVM VM
  * @id: Output ID number to return to userspace for this device
  *
  * A successful bind establishes an ownership over the device and returns
@@ -308,7 +309,9 @@ static int iommufd_bind_noiommu(struct iommufd_device *idev)
  * The caller must undo this with iommufd_device_unbind()
  */
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
-					   struct device *dev, u32 *id)
+					   struct device *dev,
+					   struct file *kvm_file,
+					   u32 *id)
 {
 	struct iommufd_device *idev;
 	int rc;
@@ -319,6 +322,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 
 	idev->ictx = ictx;
 	idev->dev = dev;
+	/* VFIO holds the file reference while the device is open. */
+	idev->kvm_file = kvm_file;
 
 	if (!iommufd_device_is_noiommu(idev))
 		rc = iommufd_bind_iommu(idev);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index eb2e85b27e42..2560b4faa6f9 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -509,6 +509,8 @@ struct iommufd_device {
 	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
+	/* ..and the VM file if available */
+	struct file *kvm_file;
 	bool enforce_cache_coherency;
 	struct iommufd_vdevice *vdev;
 	bool destroying;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index ee706f18f7e9..e9c825b24356 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1074,7 +1074,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 		goto out_sobj;
 	}
 
-	idev = iommufd_device_bind(ucmd->ictx, &sobj->idev.mock_dev->dev,
+	idev = iommufd_device_bind(ucmd->ictx, &sobj->idev.mock_dev->dev, NULL,
 				   &idev_id);
 	if (IS_ERR(idev)) {
 		rc = PTR_ERR(idev);
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index e9893d34d07b..3beb1b1bae36 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -123,7 +123,8 @@ int vfio_iommufd_physical_bind(struct vfio_device *vdev,
 {
 	struct iommufd_device *idev;
 
-	idev = iommufd_device_bind(ictx, vdev->dev, out_device_id);
+	idev = iommufd_device_bind(ictx, vdev->dev, vdev->kvm,
+				   out_device_id);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 	vdev->iommufd_device = idev;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d..0a0bb4abfbd2 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -59,7 +59,9 @@ struct iommufd_object {
 };
 
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
-					   struct device *dev, u32 *id);
+					   struct device *dev,
+					   struct file *kvm_file,
+					   u32 *id);
 void iommufd_device_unbind(struct iommufd_device *idev);
 
 int iommufd_device_attach(struct iommufd_device *idev, ioasid_t pasid,
-- 
2.43.0

