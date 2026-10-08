Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EA93C061D;
	Thu,  8 Oct 2026 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439290; cv=none; b=sww+KovfhPZV4K3DgECzFvtCwBpulbAIEEkHei6MQXR47AIc3PkPEsbmehecgj5uB+id9N0NkVutn7Rz+g9GzSjqlRc8pw9DnJDjjN3CZ9M7zbD8sJMrNLQmrzYXaH8FHzKN9uxtGavaINt/B1FApJ2znZvnplaZZHYqVqvycsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439290; c=relaxed/simple;
	bh=lv1VD47TR83ANxL6grxUYeRrE2VELzrj4qGWuOcforE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IX3hdc+hRV8feS6/ULl1pmi4OeAiHS6/ZMx2PXMl5IzoMfdzS7/ok9n/TNTNAzRxF1S8TtdTXw8mmacDzTBHqj0h4SwsF7ePsR3zxpzEceaQ5mkh1/OJZNp9FbK2qxHdv0Rd7L/L0WQBz5UBOKht4fnh6y2uYsAazbg5RayyD+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRAhwlSA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRAhwlSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8361F0089A;
	Thu,  8 Oct 2026 06:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439289;
	bh=q++wsWtVbwXkEf71+CgUoMe/MxicdoF4EDB7F0Rp1rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KRAhwlSAONJX2U/yDNASgdvntqtI3qacT3zhQQ0xU0IpW4Mbz8Ev7QzdzVkdfXLhM
	 gW3N8z97HqXtyeiMCr6SG9IVpz/iNGz+HGPFk/tMxK0HPuVFdlySwrtOqo8xb85/R3
	 rZdwnRtHkPIZ4GxrYwYJ0zugeg2LjA9Q4lGRPvrrNbLhuxYQ5yDT1ekT0h4FBr0roE
	 ay+lXJf1FbwKMAOOEzrZQj3QVHtmqno/lp8DpE9kCrVKlpU1axPjUKddVl9VlS1Js/
	 /qEPSj0cmFEkXus4NaQvI0zuXpGxZgORArPtPRvsqeXLeLkf24A+eqh4u1uksESTDA
	 XT4mDbzyq62cw==
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
	linux-tegra@vger.kernel.org
Subject: [PATCH v7 08/16] iommufd/viommu: Keep a reference to the KVM file
Date: Thu,  8 Oct 2026 11:29:47 +0530
Message-ID: <20261008055955.4014342-9-aneesh.kumar@kernel.org>
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

From: Nicolin Chen <nicolinc@nvidia.com>

The TSM vDevice operations need access to the KVM associated with the
device's vIOMMU. Save the device's KVM file in the iommufd_viommu when the
vIOMMU is allocated, and take a file reference so it remains valid for the
lifetime of the vIOMMU.

Release the reference when the vIOMMU is destroyed.

Based on an original patch by
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

[nicolinc: hold kvm's users_count]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
[aneesh.kumar: Switch to use kvm_file]
Cc: jgg@ziepe.ca
Cc: kevin.tian@intel.com
Cc: joro@8bytes.org
Cc: will@kernel.org
Cc: robin.murphy@arm.com
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/viommu.c | 5 +++++
 include/linux/iommufd.h        | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index f7951057a1e5..b7489ed259bd 100644
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
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 0a0bb4abfbd2..3267717f676d 100644
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

