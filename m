Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8F93D413C
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 23:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543330; cv=none; b=hLeWtkWta3gBjpuQ9mo5UJvGNhye12jGycqMkIcqxBwUvQ/wEP8MsnSNYGVRxu69EQZMPVdcZ/qazv7Z6zfbP6kX5j5afr7hujaERD7KPeM6CCVzwavdkq4obrrwAO+NVWQYtNI54iiw/vUZXpYv9nfNhbO+bx1QuV2LEIcCTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543330; c=relaxed/simple;
	bh=mKQBR0rz/05lEuaw8S69iIUy1w9TkuyP0iz8peUQ0d4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uGxCqIiz2aU4r5PiMJ8Xd/s6cQaWR1GOlO9mqy5Vo3fnsuhJwg2czBPF6rRUaQISVpuUSFFzMeDzttcJtXMRKCordALGvnRHTS+UcQ4a1Z01chJdQCE9PdniIjqB42PhEmR3HGkXeXq3S902JDv0DqL//u2ySY3YlJGrPUsEvi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qaFSvuqj; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qaFSvuqj"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8353b042152so4966903b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 16:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543326; x=1779148126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJTGo5XDHXx2rcanjBQwin8Y3adz33qUp8/b4RzzHOA=;
        b=qaFSvuqjWnR6BZkGbdqWj+zWZsWNwPCIjibQIKb00aJ+3wn6qkBCGLWkjgBwFMDcIL
         FcE0f4gWQEF1qSECD/hWnjwmmbQMvdOcxmWWHe+eHPf17AR8z+w9mG/UEFyQLAgKuIzM
         HGS7kR16vdpqd18Re2AxjY7K/R0YrV8y1MbONd8U62absEkMX0thcB8Wloe3I7MCbmYX
         s47oYQ9vElj+Ov+lEztQ0bbpH6jFDRza7Ow5z1qEE5YUQzw5V3CubHaE6eGARFAuHeZP
         SqNBpkQIXZksNjMKmj2mp5zsaUNKC0D4PegVZPdj6h6r+lXNiEOqzCpLWKUJ3mRW5qlb
         FqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543326; x=1779148126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJTGo5XDHXx2rcanjBQwin8Y3adz33qUp8/b4RzzHOA=;
        b=lpimsDs7jwz65gsyVPw4Ds2kLilb4Y6MvdvFuO62GV+17bjAVR7kodbKW+4lEnY37H
         q08wKZBXm2T12K7jRZi3PtU1p3/tFNMmwTtTyaAVcA9ESocezEvNvoj4u47a5esfssV7
         hSozQkM1hbWOLeJI/NYzpcQ3KA+Gd0gJw5sl/V6yFCrqcrgiS5VHBU04BEvd4lBGGpQh
         9MaVYye23XgQD+t+aYb/jyIgtax4UPtZfIrl968gc6nmc3J28wtYZtxfyb46EC1oSD53
         tN0YT68nRXlOP06ZC44OwGL18LqtxU4I06i9xvbGUCau/7i+Ebzph/eF6HcEpDrWE7qP
         +vKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6uoR2fEbUygnkXvaB0GduUnVPOHZ9WKJ3IvzVjnfX3nngmMVmy+NQaE0I/h7iqTgPaAW8QNa4Bvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVcTJKIULQ+Hfnvx/bhW5bgGYzYkYragQ8aIlsuY8cyJNTZb8e
	HYFmElEiF2gK3s+RR7KbPbCFX34HWIKlnknfCE/brIKieFRAtwgk/ndzGdSUImMgr5twUvq5aQj
	sWRv3V61VHA==
X-Received: from pfoo17.prod.google.com ([2002:a05:6a00:1a11:b0:82f:8e5d:a777])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8014:b0:82c:dfea:9e2a
 with SMTP id d2e1a72fcca58-83a5b6d0adamr27939299b3a.2.1778543325352; Mon, 11
 May 2026 16:48:45 -0700 (PDT)
Date: Mon, 11 May 2026 16:48:02 -0700
In-Reply-To: <20260511234802.2280368-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-17-vipinsh@google.com>
Subject: [PATCH v4 16/16] vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, 
	jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, 
	praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add a long-running DMA memcpy operation to
vfio_pci_liveupdate_kexec_test so that the device attempts to perform
DMAs continuously during the Live Update.

At this point iommufd preservation is not supported and bus mastering is
not kept enabled on the device during across the kexec, so most of these
DMAs will be dropped. However this test ensures that the current device
preservation support does not lead to system instability or crashes if
the device is active. And once iommufd and bus mastering are preserved,
this test can be relaxed to check that the DMA operations completed
successfully.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
index 65c48196e44e..36bddfbb88ed 100644
--- a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -1,8 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/sizes.h>
+#include <sys/mman.h>
+
 #include <libliveupdate.h>
 #include <libvfio.h>
 
+#define MEMCPY_SIZE SZ_1G
+#define DRIVER_SIZE SZ_1M
+#define MEMFD_SIZE (MEMCPY_SIZE + DRIVER_SIZE)
+
+static struct dma_region memcpy_region;
 static const char *device_bdf;
 
 static char state_session[LIVEUPDATE_SESSION_NAME_LENGTH];
@@ -11,8 +19,89 @@ static char device_session[LIVEUPDATE_SESSION_NAME_LENGTH];
 enum {
 	STATE_TOKEN,
 	DEVICE_TOKEN,
+	MEMFD_TOKEN,
 };
 
+static void dma_memcpy_one(struct vfio_pci_device *device)
+{
+	void *src = memcpy_region.vaddr, *dst;
+	u64 size;
+
+	size = min_t(u64, memcpy_region.size / 2, device->driver.max_memcpy_size);
+	dst = src + size;
+
+	memset(src, 1, size);
+	memset(dst, 0, size);
+
+	printf("Kicking off 1 DMA memcpy operations of size 0x%lx...\n", size);
+	vfio_pci_driver_memcpy(device,
+			       to_iova(device, src),
+			       to_iova(device, dst),
+			       size);
+
+	VFIO_ASSERT_EQ(memcmp(src, dst, size), 0);
+}
+
+static void dma_memcpy_start(struct vfio_pci_device *device)
+{
+	void *src = memcpy_region.vaddr, *dst;
+	u64 count, size;
+
+	size = min_t(u64, memcpy_region.size / 2, device->driver.max_memcpy_size);
+	dst = src + size;
+
+	/*
+	 * Rough Math: If we assume the device will perform memcpy at a rate of
+	 * 30GB/s then 7200GB of transfers will run for about 4 minutes.
+	 */
+	count = (u64)7200 * SZ_1G / size;
+	count = min_t(u64, count, device->driver.max_memcpy_count);
+
+	memset(src, 1, size / 2);
+	memset(dst, 0, size / 2);
+
+	printf("Kicking off %lu DMA memcpy operations of size 0x%lx...\n", count, size);
+	vfio_pci_driver_memcpy_start(device,
+				     to_iova(device, src),
+				     to_iova(device, dst),
+				     size, count);
+}
+
+static void dma_memfd_map(struct vfio_pci_device *device, int fd)
+{
+	void *vaddr;
+
+	vaddr = mmap(NULL, MEMFD_SIZE, PROT_WRITE, MAP_SHARED, fd, 0);
+	VFIO_ASSERT_NE(vaddr, MAP_FAILED);
+
+	memcpy_region.iova = SZ_4G;
+	memcpy_region.size = MEMCPY_SIZE;
+	memcpy_region.vaddr = vaddr;
+	iommu_map(device->iommu, &memcpy_region);
+
+	device->driver.region.iova = memcpy_region.iova + memcpy_region.size;
+	device->driver.region.size = DRIVER_SIZE;
+	device->driver.region.vaddr = vaddr + memcpy_region.size;
+	iommu_map(device->iommu, &device->driver.region);
+}
+
+static void dma_memfd_setup(struct vfio_pci_device *device, int session_fd)
+{
+	int fd, ret;
+
+	fd = memfd_create("dma-buffer", 0);
+	VFIO_ASSERT_GE(fd, 0);
+
+	ret = fallocate(fd, 0, 0, MEMFD_SIZE);
+	VFIO_ASSERT_EQ(ret, 0);
+
+	printf("Preserving memfd of size 0x%x in session\n", MEMFD_SIZE);
+	ret = luo_session_preserve_fd(session_fd, fd, MEMFD_TOKEN);
+	VFIO_ASSERT_EQ(ret, 0);
+
+	dma_memfd_map(device, fd);
+}
+
 static void before_kexec(int luo_fd)
 {
 	struct vfio_pci_device *device;
@@ -32,6 +121,27 @@ static void before_kexec(int luo_fd)
 	ret = luo_session_preserve_fd(session_fd, device->fd, DEVICE_TOKEN);
 	VFIO_ASSERT_EQ(ret, 0);
 
+	dma_memfd_setup(device, session_fd);
+
+	/*
+	 * If the device has a selftests driver, kick off a long-running DMA
+	 * operation to exercise the device trying to DMA during a Live Update.
+	 * Since iommufd preservation is not supported yet, these DMAs should be
+	 * dropped. So this is just looking to verify that the system does not
+	 * fall over and crash as a result of a busy device being preserved.
+	 */
+	if (device->driver.ops) {
+		vfio_pci_driver_init(device);
+		dma_memcpy_start(device);
+
+		/*
+		 * Disable interrupts on the device or freeze() will fail.
+		 * Unfortunately there isn't a way to easily have a test for
+		 * that here since the check happens during shutdown.
+		 */
+		vfio_pci_msix_disable(device);
+	}
+
 	close(luo_fd);
 	daemonize_and_wait();
 }
@@ -78,6 +188,7 @@ static void after_kexec(int luo_fd, int state_session_fd)
 	struct iommu *iommu;
 	int session_fd;
 	int device_fd;
+	int memfd;
 	int stage;
 
 	check_open_vfio_device_fails();
@@ -88,6 +199,10 @@ static void after_kexec(int luo_fd, int state_session_fd)
 	session_fd = luo_retrieve_session(luo_fd, device_session);
 	VFIO_ASSERT_GE(session_fd, 0);
 
+	printf("Retrieving memfd from LUO\n");
+	memfd = luo_session_retrieve_fd(session_fd, MEMFD_TOKEN);
+	VFIO_ASSERT_GE(memfd, 0);
+
 	printf("Finishing the session before retrieving the device (should fail)\n");
 	VFIO_ASSERT_NE(luo_session_finish(session_fd), 0);
 
@@ -109,9 +224,23 @@ static void after_kexec(int luo_fd, int state_session_fd)
 	 */
 	device = __vfio_pci_device_init(device_bdf, iommu, device_fd);
 
+	dma_memfd_map(device, memfd);
+
 	printf("Finishing the session\n");
 	VFIO_ASSERT_EQ(luo_session_finish(session_fd), 0);
 
+	/*
+	 * Once iommufd preservation is supported and the device is kept fully
+	 * running across the Live Update, this should wait for the long-
+	 * running DMA memcpy operation kicked off in before_kexec() to
+	 * complete. But for now we expect the device to be reset so just
+	 * trigger a single memcpy to make sure it's still functional.
+	 */
+	if (device->driver.ops) {
+		vfio_pci_driver_init(device);
+		dma_memcpy_one(device);
+	}
+
 	vfio_pci_device_cleanup(device);
 	iommu_cleanup(iommu);
 }
-- 
2.54.0.563.g4f69b47b94-goog

