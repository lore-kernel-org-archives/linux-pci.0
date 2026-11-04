Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809082;
	b=KI+CWR/g6k71HxtoqTgXMQi7UZ4L1fltaEg5RyPeqnpGr9dkXEEtQtLvlNcodBv9yq6Q
	 jk/8uZcq4Gy+ZeI0WQwl0xKo7MtJGCTma7qWikB4IZqzsg5zgkTW9QtwjfxbvNld96IoE
	 KTw0P7NlHGiOTlLrOCHwssJSW5sRGx8y76fAer7/7+QEtuHItorzYAsiGPUXlvc+RqJfC
	 gX61hH1e2bWggQN0ZHVFElI/9r5PSNZoqhqXHn5XU09VKe/s0UNE0JtTajl8vKNDSKEIe
	 QD6ArQg1yNRLwthpjV3KHyeA5G/EIGxSGzQpWQe4dCcWLWQ67zuZC4J3FgWVOoY3I8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809082;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/f1LcAxGZ5k1BEQm6UZwU+tsAlnjik5nw5Pm2FDN7hg=;
	b=2tt3D9tVGkofIeA2EoSE4XDMVitnrJNFFRA50RqsK42+HecpTE3KldvdbAhBv0joAs7E
	 N8p9JE0CzK3fEjlTN+cBSQa+TcWeJCopMuioN5V6XeGqVRjjYlWQI42vr4zXemW4wctXa
	 nXdzELBnHarUY51cX/Y6Wl5zcgOhDd1kABGznuGR05ob2On+eCj1tTWwzPYQxdeCM+JRg
	 3NmdtXRsYG/q2XDB0zQzdGV6kdII4xYQDM77ZFX0ZcUAEOj8u4lDtwjoAp/UoN6UvIXV0
	 4Df/Mcoh8WAqHgjK4PUGJi7vpWyzLC/PcHcoB2S11nr3yaZgnHkti7YNAg352O/VMaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6Y6Owlb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2BC606D809;
	Wed,  4 Nov 2026 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6Y6Owlb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F4D1F00A15;
	Wed,  4 Nov 2026 16:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809081;
	bh=/f1LcAxGZ5k1BEQm6UZwU+tsAlnjik5nw5Pm2FDN7hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c6Y6OwlboTn+mTB9qvAVKe0sIDapv7oSyuynqmDIbzugR+GnSyxwrkgR1bp445XIa
	 WRz0q4vjTAnvgyy/rn0kEB49xRTFaWWi8UF+5ag5itjxmAd96n0jCW5ui8qcJE8yNC
	 65tkqxVGDtt3n3ORY2YooiwldyhFVlEVlHgx8wCmD9m+6UIENgvZ50xEQG1odjkLfG
	 iHx/E3WjmvJj9ffCvuCKazhhm1BjDY7gMf+jTwefDLz3xyhXAQ3Ld0tquiYjMdG1C4
	 TP+TL6Bz+bW9AX7Q5X2LKx41dgXewvuPzYWN29XHJmCy+TrQ73eqb92o3nZi1t9tFm
	 yqqT69LR6xnQQ==
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
Subject: [PATCH v8 07/15] iommufd/viommu: Keep a reference to the KVM file
Date: Wed,  4 Nov 2026 21:46:24 +0530
Message-ID: <20261104161632.3547423-8-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

The TSM vDevice operations need access to the KVM associated with the
device's vIOMMU. Save the device's KVM file in the iommufd_viommu when the
vIOMMU is allocated, and take a file reference so it remains valid for the
lifetime of the vIOMMU.

Release the reference when the vIOMMU is destroyed.

Reject vdevice allocation when the device's KVM association differs from
the vIOMMU's, including when only one has a KVM association. Allow
allocation when both associations are NULL.

Based on an original patch by
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

[nicolinc: hold kvm's users_count]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
[aneesh.kumar: Switch to use kvm_file]
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/viommu.c | 10 ++++++++++
 include/linux/iommufd.h        |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index f7951057a1e5..0dbd382eeb98 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
  */
+#include <linux/file.h>
 #include "iommufd_private.h"
 
 void iommufd_viommu_destroy(struct iommufd_object *obj)
@@ -11,6 +12,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 	if (viommu->ops && viommu->ops->destroy)
 		viommu->ops->destroy(viommu);
 	refcount_dec(&viommu->hwpt->common.obj.users);
+	if (viommu->kvm_file)
+		fput(viommu->kvm_file);
 	xa_destroy(&viommu->vdevs);
 }
 
@@ -82,6 +85,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	}
 
 	xa_init(&viommu->vdevs);
+	if (idev->kvm_file)
+		viommu->kvm_file = get_file(idev->kvm_file);
 	viommu->type = cmd->type;
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
@@ -171,6 +176,11 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_viommu;
 	}
 
+	if (idev->kvm_file != viommu->kvm_file) {
+		rc = -EINVAL;
+		goto out_put_idev;
+	}
+
 	iommu_dev = iommufd_device_get_iommu_dev(idev);
 	if (!iommu_dev || viommu->iommu_dev != iommu_dev) {
 		rc = -EINVAL;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index b03ce0187454..c15d80f611b9 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -103,6 +103,7 @@ struct iommufd_viommu {
 	struct iommufd_ctx *ictx;
 	struct iommu_device *iommu_dev;
 	struct iommufd_hwpt_paging *hwpt;
+	struct file *kvm_file;
 
 	const struct iommufd_viommu_ops *ops;
 
-- 
2.43.0

