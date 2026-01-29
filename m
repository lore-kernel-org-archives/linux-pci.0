Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E3E369212
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769721973; cv=none; b=s7Hxj7geaAYMimn3KjfHNMUHKaV7zKfpPglrnBRZeKHxmwDAZDwCD0Qdz2YcafSZ29avIEAExrMfMrt5shDKIWdBIIaVnW6P1NU4m04giF45Qntn1tDseSuQOFg/H+EZgCCfVYqSe5bP0+pE3mgNt39CNFqPn6iQwHv2mBvFEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769721973; c=relaxed/simple;
	bh=7CV7PbEQub3WXnBX9axHLCIJCl0ibvYACGkaoVQCNpM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u9RKm2tObb4ch4u8Dxnb78qj1xw+ywgxX82zib+jlx31cLfwcZGGT9IfQD7spkOvsvqGfKIzEucn9QADXEAMjMkn2K5ukA0OPrjPN5SfpiIATA5sXKCo/W6rk22b3EKuFCDN1GElygISuQL+q/d5s/NuU081Yq8fm3uy9aS8La4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6bUtr4L; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6bUtr4L"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34ab459c051so2564103a91.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 13:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721971; x=1770326771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jY83qjLDePi9A6Rw0FeAVcPg0HBWAQ4uS6Od5NUhNZI=;
        b=a6bUtr4LQLPVmTGTCdRqa2YItvKeOVNo3zDOTZUcwzqinJ5M3ErVlUlq66OvNKqmIU
         yajYRrvJSBhTwM3RGdpPKol4NzGeD48zOJocDjKOgEm6f3e4ivXZpJ9bD+2zVUWkOlHW
         JdfFsnmNgwOxB7urfWp8YB088+qzMdyBYIZ6xql7W/FydX+aH4G2tk2MUlC4dUGbJppW
         DEUG85PrHmaTDcqxrE7RetIiXnhC8Wf6prS0DUecOPKbWMNrSxHVVPtsPG6gL5j8/wUM
         zsfeLCIdegKU7JkL8N1YL3TrciFSDqdtPUXSmjVuMDcYE4UZ6ruUB4TZ47s7fCjlGLv+
         vF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721971; x=1770326771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jY83qjLDePi9A6Rw0FeAVcPg0HBWAQ4uS6Od5NUhNZI=;
        b=aub2Fi34n6pMWtRTZHvK+XZWeTm+DP+H+qtKPOexJbaLM7zl61ZFLMqsXiQlh4jFl1
         CbF+OYUIlUKXa88dE2U5HhqJN2itcC4Wa6EqilxXU8Re/oSZPAGg9j65ZSFMAsjg5BSk
         8isfO9Hw1autd12rF5osoOQb2RnfeUc6RgjM/I0fyADKJWiAvSeHTviK1EGF57/+2oTO
         yoQUe/hmE41wli8203whgxVXEd5KoCsGi2d0lo6fgMQoMjrG+vyIV0aRO7sXR0j3ryPh
         ylEyOX4jwaHVdwZnWhgWXOfPShgxiPDUbOuc8noQe1HVmWxQDIwZNOt4eyA/L3RzPiFb
         TrRg==
X-Forwarded-Encrypted: i=1; AJvYcCUIGWnR1TAOBrVfdSGUI35PFmxKIRWLoU4ZJ3DWwRjR7TgPijLbFSI7/uz1JJfv3hJqGHC9iKpRVIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7R32BcTTaXLhhvo2GhBH3byTQNKMfiuaPp3eELx70SHpkpf6E
	4w4w4BUrTR/h3rdb2UMscOpXt2qGPZFJj1uDD88uE17YravvmQ5MOKChtAhA+YUKAfkMwR1my2+
	C8OOh3pmnfy9vkg==
X-Received: from pjvf5.prod.google.com ([2002:a17:90a:da85:b0:352:d19a:6739])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:510b:b0:340:a1a8:eb87 with SMTP id 98e67ed59e1d1-3543b3ba97dmr804461a91.35.1769721970642;
 Thu, 29 Jan 2026 13:26:10 -0800 (PST)
Date: Thu, 29 Jan 2026 21:25:07 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-21-dmatlack@google.com>
Subject: [PATCH v2 20/22] vfio: selftests: Expose low-level helper routines
 for setting up struct vfio_pci_device
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Expose a few low-level helper routings for setting up vfio_pci_device
structs. These routines will be used in a subsequent commit to assert
that VFIO_GROUP_GET_DEVICE_FD fails under certain conditions.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  5 +++
 .../selftests/vfio/lib/vfio_pci_device.c      | 33 +++++++++++++------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 896dfde88118..2389c7698335 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -125,4 +125,9 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 
 const char *vfio_pci_get_cdev_path(const char *bdf);
 
+/* Low-level routines for setting up a struct vfio_pci_device */
+struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu);
+void vfio_pci_group_setup(struct vfio_pci_device *device);
+void vfio_pci_iommu_setup(struct vfio_pci_device *device);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DEVICE_H */
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 08bb582eaa8f..76597c84e956 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -198,7 +198,7 @@ static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
 	return group;
 }
 
-static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf)
+void vfio_pci_group_setup(struct vfio_pci_device *device)
 {
 	struct vfio_group_status group_status = {
 		.argsz = sizeof(group_status),
@@ -206,7 +206,7 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	char group_path[32];
 	int group;
 
-	group = vfio_pci_get_group_from_dev(bdf);
+	group = vfio_pci_get_group_from_dev(device->bdf);
 	snprintf(group_path, sizeof(group_path), "/dev/vfio/%d", group);
 
 	device->group_fd = open(group_path, O_RDWR);
@@ -218,14 +218,12 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->iommu->container_fd);
 }
 
-static void vfio_pci_container_setup(struct vfio_pci_device *device, const char *bdf)
+void vfio_pci_iommu_setup(struct vfio_pci_device *device)
 {
 	struct iommu *iommu = device->iommu;
 	unsigned long iommu_type = iommu->mode->iommu_type;
 	int ret;
 
-	vfio_pci_group_setup(device, bdf);
-
 	ret = ioctl(iommu->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
 	VFIO_ASSERT_GT(ret, 0, "VFIO IOMMU type %lu not supported\n", iommu_type);
 
@@ -235,8 +233,14 @@ static void vfio_pci_container_setup(struct vfio_pci_device *device, const char
 	 * because the IOMMU type is already set.
 	 */
 	(void)ioctl(iommu->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
+}
 
-	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, bdf);
+static void vfio_pci_container_setup(struct vfio_pci_device *device)
+{
+	vfio_pci_group_setup(device);
+	vfio_pci_iommu_setup(device);
+
+	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, device->bdf);
 	VFIO_ASSERT_GE(device->fd, 0);
 }
 
@@ -336,9 +340,7 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
 
-struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
-					       struct iommu *iommu,
-					       int device_fd)
+struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu)
 {
 	struct vfio_pci_device *device;
 
@@ -349,9 +351,20 @@ struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
 	device->iommu = iommu;
 	device->bdf = bdf;
 
+	return device;
+}
+
+struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
+					       struct iommu *iommu,
+					       int device_fd)
+{
+	struct vfio_pci_device *device;
+
+	device = vfio_pci_device_alloc(bdf, iommu);
+
 	if (iommu->mode->container_path) {
 		VFIO_ASSERT_EQ(device_fd, -1);
-		vfio_pci_container_setup(device, bdf);
+		vfio_pci_container_setup(device);
 	} else {
 		vfio_pci_iommufd_setup(device, bdf, device_fd);
 	}
-- 
2.53.0.rc1.225.gd81095ad13-goog

