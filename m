Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809072;
	b=0n4Kj2P9nRtRzWtJusBzHOJixUvSWa8uprmYclw6+FT7zK5InunyQZY3cUVkpe74NMKM
	 wxNw0HGFmURzccKs8y9kXysTIdqBBgag8eEEk+IORusBIumo41IDAWgSdlNoqRB/G3qQj
	 Xu/0Y7VFvy7M0ZJoci89qm/qtUzBerJA83F352Y4QQS0A7i4Ilmu5KM/jnPio6GburntL
	 5RGEUzM0nG7Kg40QyEDdHVpskNt0j4lmeWE9tIA29Vp86EXaIPnXF/qx6LB5L+TXUd4ta
	 KL9aQqiBBSUnGQo+bp6B+MdwcST0wZT/LcIX2AGFTvsFLW96gBFWOEGOTZbrdajM5zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809072;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VGKK2dwD8JErHY7gJcu4ftdMWMNAKpXhVOt2LCLmgU4=;
	b=LbmFmIF4fQUZNVLKjYJIuBKvlTl/IbjGO1tDhX9sFwKdPWXABAd6KrIjhwu+/pUisCG8
	 EKulzwQlGskGy/nCVK0Uf/GyvuYFZgkTuZyRjBDxR5G4IGxgS0jG4UvhE71/+qXij8KZX
	 oT6AwknqrNCNaHTnDuX80S9ZAGCzjlITWUyzXILLAYF1ZUpKFjzFLZfrvuFX5xDylaSNG
	 9oRYTzLaENF6qP5BhqXu7WfeeAQGAKNdSoC0qQl/oArn7eOwCbTo55Wus1mavsG8LEa9g
	 mZp1fL/P4vuR6UbDZR1fPZG5FhVzhahyghLrjjejeaNQzSZA783Q/fn4bcCH9u2THXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oP08gSAg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016E3606D83D;
	Wed,  4 Nov 2026 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oP08gSAg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965731F000C1;
	Wed,  4 Nov 2026 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809071;
	bh=VGKK2dwD8JErHY7gJcu4ftdMWMNAKpXhVOt2LCLmgU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oP08gSAgNqQs4+z0Z/ic597TFyebKNExzmblVKBV201uyjllm8kaMQmqa///ddNIo
	 CfcoYbtcE7MFftJ9KmT83HCNZM5H+BsDJrjFC59Y7jkBDPRwnyUmJZdZLXrOT2JQtn
	 IxoLFuybcDThsMNBhA4sDE1riUv121s+ZFSqYD4d0XglW8IHknIeDu0lYX7PhmCLLN
	 C6I0oFWX4LPOHy32lv3CQk2CHA43hbRAB49oCuDFr/glIP3y+MXAri42VMNldNiR3W
	 rqs4XK0AhkqfwB9Kz/goqMYKQ2oIi7NdoMUztp03ueIVkEBtiHP+lbojWI+suWPeDX
	 +DYWwXiB/Efaw==
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
Subject: [PATCH v8 06/15] iommufd/device: Hold a KVM file reference for the device lifetime
Date: Wed,  4 Nov 2026 21:46:23 +0530
Message-ID: <20261104161632.3547423-7-aneesh.kumar@kernel.org>
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

The KVM file stored in an iommufd_device currently relies on the
reference held by VFIO while the device is open. Normally, unbind waits
for outstanding device references before VFIO drops its KVM reference.
However, REMOVE_WAIT only waits for 60 seconds. If that timeout expires,
the device object remains in the iommufd xarray.

For example, an IOMMU_GET_HW_INFO ioctl can hold a device reference while
blocked on a userspace buffer fault:

  iommufd_fops_ioctl()
    iommufd_get_hw_info()
      iommufd_get_device()
        iommufd_get_object()
          iommufd_lock_obj()       /* takes users and wait_cnt refs */
      copy_to_user() / clear_user() /* may block before putting refs */

A concurrent final release of the VFIO device file takes this path:

  vfio_device_fops_release()
    vfio_df_unbind_iommufd()
      vfio_df_close()
        vfio_df_device_last_close()
          vfio_df_iommufd_unbind()
            vfio_iommufd_physical_unbind()
              iommufd_device_unbind()
                iommufd_object_destroy_user()
                  iommufd_object_remove(..., REMOVE_WAIT)
                    iommufd_object_dec_wait() /* timeout: -EBUSY */
                  WARN_ON(ret)
      vfio_device_put_kvm()
        fput(device->kvm)

iommufd_object_destroy_user() warns on -EBUSY but does not propagate it:
iommufd_device_unbind() returns void. Thus VFIO close effectively ignores
the unbind failure and proceeds to drop its KVM file reference even
though the iommufd_device is still alive and its ID remains usable.

Once the remaining KVM file references are released, a later ioctl on
the still-open iommufd can access the stale pointer:

  iommufd_fops_ioctl()
    iommufd_viommu_alloc_ioctl()
      iommufd_get_device()         /* finds the surviving device ID */
      get_file(idev->kvm_file)     /* accesses the freed KVM file */

Take a KVM file reference when binding the device and release it when
the iommufd_device is actually destroyed. Release it before the igroup
check in the destructor so that bind failure cleanup is covered too.
Document the ownership in the bind API and device structure.

Fixes: d8bb80c8f0e5 ("iommufd/device: Associate KVM file pointer with iommufd_device")
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/device.c          | 11 +++++++++--
 drivers/iommu/iommufd/iommufd_private.h |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 935f42616a65..cd49acf5bd3f 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
+#include <linux/file.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/pci-ats.h>
@@ -212,6 +213,9 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
+	if (idev->kvm_file)
+		fput(idev->kvm_file);
+
 	/* igroup is NULL when destroy called during bind error cleanup */
 	if (!idev->igroup)
 		return;
@@ -306,6 +310,9 @@ static int iommufd_bind_noiommu(struct iommufd_device *idev)
  *
  * Binding a PCI device places the entire RID under iommufd control.
  *
+ * If @kvm_file is provided, a reference is held until the device object is
+ * destroyed.
+ *
  * The caller must undo this with iommufd_device_unbind()
  */
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
@@ -322,8 +329,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 
 	idev->ictx = ictx;
 	idev->dev = dev;
-	/* VFIO holds the file reference while the device is open. */
-	idev->kvm_file = kvm_file;
+	/* Hold the VM file for the lifetime of this object. */
+	idev->kvm_file = kvm_file ? get_file(kvm_file) : NULL;
 
 	if (!iommufd_device_is_noiommu(idev))
 		rc = iommufd_bind_iommu(idev);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 2560b4faa6f9..63a6dcee21dc 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -509,7 +509,7 @@ struct iommufd_device {
 	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
-	/* ..and the VM file if available */
+	/* Owned reference to the VM file, if available */
 	struct file *kvm_file;
 	bool enforce_cache_coherency;
 	struct iommufd_vdevice *vdev;
-- 
2.43.0

