Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6537B37E316;
	Thu,  8 Oct 2026 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439215; cv=none; b=fgEEI3N1JardZoD4FfjuETRWxKqrl1WthVHNd+7Yjb1bIcwA8GvzxnqXrZAW4yh0I4TmA+rW5MPhjVvKiksnQoZsFc1tjfqNgdOlqhnxViH0HvoHc/lSRGOsPXF8h1qmnMZ42Sr5zcUUcDTyMwXLcgRNBhp5KFqIlbruRuk8ogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439215; c=relaxed/simple;
	bh=CWXwUoC8C3Vk139oKSzyQMaY69RG3Wg9yXa0Eecy3Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2C7cij5KO8Sa8iJimuVdDZcx1g2O6lEsJZe+9XkQM25Jum8qGl9zBSxN/210C00guRfg2y0K5fUyZs276GnRjYcvbnb+NJ5OzfqPrYJzph8++PPz6J/ASm+6aFYbSRYaMdTuEqRcwhd7b+xh6ygjhFWs6m8+gMqaKQv//eD2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XecI8/3Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XecI8/3Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E511F000FF;
	Thu,  8 Oct 2026 06:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439214;
	bh=/bHTGZMzM4w6xwig+RjqaHBwjvdE8aY9v1cTkEXLvIA=;
	h=From:To:Cc:Subject:Date;
	b=XecI8/3ZQU3h+nwgEgT8B163FnicZXb5taygrZgyqNxVgYnIX4dOYfOJLIS/BF/BY
	 fo7Tdo7rqHWJwVZPqgpY4EITNaQyRvtUytleMo6+eQ3Pngjq3Rz/kKdy68Tyzl9hwt
	 kdSQ1ymBca46zPz+539vrPXicNregsaP2vBA+ZmiAb6YeiLwUpTgmr6CZNfPDr6Ixx
	 WhXTuoP4f0jVp45a0YQ0BFU3CkkgJpB48KE/w3S3bqSUPljENxrSDi3crSwIWhW0d1
	 WYuEI+DL33qAHDCaS8K2qny9sZzoMPq7//HcMo/EK557E78ccM/N8zyny2EEaQdefU
	 EQfxHQ7qPK+SA==
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
Subject: [PATCH v7 00/16] iommufd: vIOMMUs and TSM guest requests for confidential guests
Date: Thu,  8 Oct 2026 11:29:39 +0530
Message-ID: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds IOMMUFD and PCI/TSM infrastructure for assigning PCI
devices to confidential guests. It includes the IOMMU_VDEVICE_TSM_REQ
ioctl. The Arm CCA host backend is supplied in a separate series; this
series provides the interfaces it uses.

Physical IOMMU drivers and PCI TSM backends now provide vIOMMU ops before
IOMMUFD validates the parent HWPT. These ops provide callbacks for
determining the allocation size and initializing the vIOMMU, along with
flags specifying whether a parent HWPT is required. A nesting parent is
required by default. When the selected ops set IOMMUFD_VIOMMU_NO_HWPT,
userspace must supply a zero hwpt_id, and IOMMUFD passes NULL as the parent
domain to the initialization callback. Nested HWPT and hardware queue
allocation are rejected for a vIOMMU without a parent.

IOMMUFD first queries the TSM attached to the selected PCI device. Lookup
pins the backend module before using its vIOMMU ops, and that
reference is released after the backend's vIOMMU destruction callback.
The backend must keep its TSM registered while the module is pinned.
When no TSM provides ops for the requested type, IOMMUFD falls back
to the physical IOMMU driver. An error from TSM lookup or querying its ops is
returned without falling back.

Vdevice contexts replace the legacy PCI/TSM bind and unbind interface.
Context acquisition verifies that the device's current TSM matches the
vIOMMU's TSM. An explicit sysfs disconnect returns EBUSY while contexts
remain active. Guest requests are dispatched through the vIOMMU ops.

IOMMU_VDEVICE_TSM_REQ checks the guest architecture and the vdevice's
supported-operation mask before forwarding userspace buffers to the
backend. Request and response lengths are limited to INT_MAX so a
successful residue fits in the ioctl return value. The backend supplies
the architecture-specific request handling and TSM result code.

Notes:
* Codex was used to assist with commit message formatting and code
  rearrangement.
* This series also includes patches from the following series to provide
  the dependencies needed for Sashiko to review the combined changes:
  https://lore.kernel.org/all/20260928-vfio-v4-0-e32e226d5932@linux.ibm.com

Changes from v6:
https://lore.kernel.org/all/20260917140159.1163281-1-aneesh.kumar@kernel.org
* Replace the IOMMUFD provider registry with per-device TSM operation lookup.
* Move vIOMMU allocation size and initialization into the selected vIOMMU ops.
* Select parent HWPT policy from the vIOMMU ops flags.
* Pin a vIOMMU's TSM backend module through vIOMMU destruction.

Changes from v5:
https://lore.kernel.org/all/20260525154816.1029642-1-aneesh.kumar@kernel.org
* Replace the TSM bind/unbind interface with reference-counted contexts.
* Add the IOMMUFD vIOMMU provider abstraction.
* Route TSM guest requests through vIOMMU ops.

Changes from v4:
https://lore.kernel.org/all/20260427061005.901854-1-aneesh.kumar@kernel.org
* Switch VFIO/iommufd to use struct file *kvm_file instead of relying on
  kvm->users_count references.
* Define TSM request scope values globally in iommufd.
* Rename the ioctl to IOMMU_VDEVICE_TSM_REQ.
* Address other review feedback.

Changes from v2:
https://lore.kernel.org/all/20260309111704.2330479-1-aneesh.kumar@kernel.org
* Bump the series revision to v4 to keep it in sync with the dependent CCA DA
  patchsets. There was no v3 posting.
* Drop [PATCH v2 1/3] iommufd/viommu: Allow associating a KVM VM fd with a
  vIOMMU
* Add two new patches to associate a struct kvm * with iommufd objects:
  iommufd/device: Associate a kvm pointer to iommufd_device
  iommufd/viommu: Associate a kvm pointer to iommufd_viommu
* Address review feedback

Changes from v1:
https://lore.kernel.org/all/20250728135216.48084-8-aneesh.kumar@kernel.org
* Rebase onto the latest kernel
* Address review feedback
* Drop the TSM map ioctl; the KVM prefault patch will be used instead to
  ensure that private memory is preallocated

Cc: Alex Williamson <alex@shazbot.org>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com> 
CC: Jacob Pan <jacob.pan@linux.microsoft.com> 
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Krishna Reddy <vdumpa@nvidia.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Thierry Reding <thierry.reding@kernel.org>
Cc: Vasant Hegde <vasant.hegde@amd.com>
Cc: Will Deacon <will@kernel.org>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-coco@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-tegra@vger.kernel.org

Aneesh Kumar K.V (Arm) (8):
  tsm: Remove the device from lookup before PCI teardown
  iommufd: Add the vdevice TSM request ioctl
  PCI/TSM: Remove the legacy guest request interface
  PCI/TSM: Add vIOMMU-bound contexts for vdevices
  iommufd/viommu: Select vIOMMU operations before allocation
  iommufd/viommu: Allow PCI TSM backends to provide vIOMMU operations
  iommufd: Allow vIOMMUs without a parent HWPT
  PCI/TSM: wait for vdevice contexts before removing a DSM

Nicolin Chen (1):
  iommufd/viommu: Keep a reference to the KVM file

Shameer Kolothum (1):
  iommufd/device: Associate KVM file pointer with iommufd_device

Steffen Eiden (6):
  KVM: Introduce file_to_kvm_<arch>() infrastructure
  KVM: Add file back-pointer to struct kvm
  KVM: x86: Use file_to_kvm_x86() in SEV
  KVM/vfio: Use file-based reference counting for KVM
  KVM: Restrict kvm_get_kvm/kvm_put_kvm export to internal KVM modules
  KVM: Remove unused file_is_kvm

 Documentation/ABI/testing/sysfs-bus-pci       |  17 +-
 Documentation/userspace-api/iommufd.rst       |  44 ++-
 arch/s390/include/asm/kvm_host_s390.h         |   4 +-
 arch/s390/kvm/s390/pci.c                      |   9 +-
 arch/x86/include/asm/kvm_host.h               |   2 +
 arch/x86/include/asm/kvm_page_track.h         |  10 +-
 arch/x86/kvm/Makefile                         |   4 +-
 arch/x86/kvm/mmu/page_track.c                 |  22 +-
 arch/x86/kvm/svm/sev.c                        |   8 +-
 drivers/iommu/amd/iommu.c                     |   3 +-
 drivers/iommu/amd/iommufd.c                   |  18 +-
 drivers/iommu/amd/iommufd.h                   |  11 +-
 drivers/iommu/amd/nested.c                    |   4 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  37 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   7 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  16 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  24 +-
 drivers/iommu/iommufd/Makefile                |   2 +
 drivers/iommu/iommufd/device.c                |   7 +-
 drivers/iommu/iommufd/hw_pagetable.c          |  14 +-
 drivers/iommu/iommufd/iommufd_private.h       |  10 +
 drivers/iommu/iommufd/main.c                  |   3 +
 drivers/iommu/iommufd/selftest.c              |  33 +-
 drivers/iommu/iommufd/tsm.c                   |  80 ++++
 drivers/iommu/iommufd/viommu.c                | 117 ++++--
 drivers/pci/tsm.c                             | 362 ++++++++----------
 drivers/s390/crypto/vfio_ap_ops.c             |  20 +-
 drivers/vfio/group.c                          |  11 +-
 drivers/vfio/iommufd.c                        |   3 +-
 drivers/vfio/vfio.h                           |  12 +-
 drivers/vfio/vfio_main.c                      |  57 +--
 drivers/virt/coco/tsm-core.c                  |  55 ++-
 include/linux/iommu.h                         |  20 +-
 include/linux/iommufd.h                       |  35 +-
 include/linux/kvm_host.h                      |  19 +-
 include/linux/pci-tsm.h                       | 153 ++++----
 include/linux/tsm.h                           |  46 +++
 include/linux/vfio.h                          |   5 +-
 include/uapi/linux/iommufd.h                  |  85 +++-
 virt/kvm/kvm_main.c                           |  21 +-
 virt/kvm/vfio.c                               |  13 +-
 41 files changed, 893 insertions(+), 530 deletions(-)
 create mode 100644 drivers/iommu/iommufd/tsm.c


base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.43.0

