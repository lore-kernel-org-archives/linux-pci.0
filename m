Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633850;
	b=3nMYqY3upPGfo1eMfPJ4uvoBX/JzG2dgGBwHlwnduOf8Gfu6uTjp0IfTNmWjKxB5rQrV
	 rIEqrxl9Q5sgq0nUJ1TN3gAbAQykYfo/ucb9887dpZAvDHvsF9GpgeT1NxwYATtdCFhnp
	 NQ9JhhvfczH+00+ql1VkAQAON3E5yBgZcgUBiWRAt6yAKb0ZCsYoLv2mvo1LcqC9gdbR5
	 sjKJJPJQw2U4DXAQSZRoJAyxu9pt3rSEqlCae4RCkrIutYpTYJzbw9KwqDd3ToLqa1VSk
	 ugEJPB72zjnxqRHLJucr5ZR8R25vLVZ/eJD3szF4t9D6pNgC91ZVQCKvOm1CrYxK2rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=PQb3q6R6QngEoe3ekBduEqXoGdMTuhEwA2ttf4WySgI=;
	b=Ks7O7y4Vz4RLr7idkyKpK9ZfCspK+ukRSHzr0zuZ0sWww1oUoNnHz5ttZ3hO+dkaFgU7
	 +NGnQf4EcvHNdWI5B4aX87UJGhEf9ui3fuSjMMG5rgcll9C+BLBvQ3418gTC1fmM4Y1QU
	 eaQpKKmqr1039kRdsmpKq4jmAX8GznxzJ5mieLaWCMlVmx/+zINh9sqmzpzxRq13hRXrF
	 fQwiQS+13UzNOiqObbHYcTqybVdt7Ki3SPTeAFboaHE4cpNwKGBeO34qf6YS3mgVRh6KB
	 fT1grKimcUNYo/f0M/b18Z4GPbWAthk1HyHwaf0Yuyy4nLkeqX9IHcma6zPu683SCrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B9YggvqK;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED3160EB618
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 15:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AED3160EB618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B9YggvqK
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e93f67358eso35406235ad.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2026 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633849; x=1794238649; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PQb3q6R6QngEoe3ekBduEqXoGdMTuhEwA2ttf4WySgI=;
        b=B9YggvqK1b6/ndmOkslCwgJVAP+YGiso7ePHposRJDtPfk+ybU6XyHllaIDcX1HIif
         P97GZ4E+QuRC2cycyTSRtTO2YvqRfIpzNTs4wsPbwz4Fpi89pyN+vMVoWzNL3uRVEEPj
         4Rhkl3DaifwVPlQEesNkxF+9gwVZPdThZAhn8Jl8R8+eSsEWSgc5cevHIWCHeaDZb6OE
         IU2UtrqEn5ZaquCYPuP27CVfpLfg11cmepE4WlVQSfbEZ2MlAxdGPohHH5EyungZSQhl
         sh///uBWwWqdaLUP0fyk5gaAgXqQjTS3v4EJBauOi0Zs47V/DsFSIc7yITgG3qr5tPtJ
         DIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633849; x=1794238649;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PQb3q6R6QngEoe3ekBduEqXoGdMTuhEwA2ttf4WySgI=;
        b=RvM992NMBhnihyW4CneU0AvL1h+q9D2DtgqQ2DMBAo8js3YVTnnWfpShiFPNdZINdv
         DxyTNBaNrF1FyV0dD6rY4G3l196aFGfu+jHC1693tLEyyJUhPU0ILys08KZfSHnikrEk
         MNt7vBFv0Q/mW7N21v42+XnpUo+I291aD9KHnj0G0uc8V0pTcUvAJsQted6UT4da7mhZ
         FdgaIvjDeQrGIevxFSYqlXoVHSNm4iaHoG1UkKZRvo5Q9fN89oXaCjsLE1JT2OeX9d+5
         TUyVMHfWzwOpQjoi75AFUic5DtHsaLIUBknPce5DnACDIOMlwVg5r2Uf3mwyHAlNy9v8
         rGwg==
X-Forwarded-Encrypted: i=1; AKwUvBx/o2PDmW/pcVCPWVrU5rOYiKENJXlRinT7F4J+BimFK2RJVDJQvqy6EpGcMOeqWJJvnD5syXjBUmM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+E+nM9AZ2E4zih17fWzlr6YFppE+hNQUFUsLcZPja2RRcCjJOf
	T1aBV41wcHh3igEE8ojqzXDran/RbgotiM9lICkqZhasdeI1Gpl0UXL/5STnkVi7oFRrXQzfoPV
	+45REST4U0g==
X-Received: from plbjf11.prod.google.com ([2002:a17:903:268b:b0:2e8:7c73:6eb4])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ecc:b0:2e9:9c65:1aff
 with SMTP id d9443c01a7336-2eb364d70e3mr109468515ad.45.1793633848882; Mon, 02
 Nov 2026 07:37:28 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:56 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-28-vipinsh@google.com>
Subject: [PATCH v6 27/27] vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Extend vfio_pci_liveupdate_kexec_test to exercise continuous DMA across
a Live Update when the device is in noiommu mode.

Allocate a shmem memfd backed by three 2MB THP folios (for the driver
region, source buffer, and destination buffer), map each folio at
IOVA == PA via iommu_map_identity(), and preserve the memfd in the same
Live Update session before the device so that LUO's LIFO finish order
keeps the memory alive until after the device is finished.

Before kexec, initialize the selftest driver, run a sanity memcpy, kick
off a long-running DMA memcpy, and disable MSI-X so freeze() succeeds.
After kexec, take over the device via __vfio_pci_device_init(), retrieve
and map the preserved memfd verifying that all three 2MB folios stayed
at the exact same physical addresses, attach the driver without resetting
the device, wait for the pre-kexec memcpy to complete, and run another
memcpy without reinitializing the device.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 266 +++++++++++++++++-
 1 file changed, 257 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
index 9610fe593cf6..c33b62118523 100644
--- a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -1,22 +1,120 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+
 #include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/sizes.h>
 #include <linux/vfio.h>
+
 #include <libliveupdate.h>
 #include <libvfio.h>
 
+#define DRIVER_REGION_SIZE	SZ_2M
+#define MEMCPY_FOLIO_SIZE	SZ_2M
+#define NR_MEMFD_FOLIOS		3
+#define MEMFD_SIZE		(NR_MEMFD_FOLIOS * SZ_2M)
+
+#define MEMCPY_TIMEOUT_S	(30 * 60)
+
+static struct dma_region src_region;
+static struct dma_region dst_region;
+static void *memfd_vaddr;
+static u64 folio_pa[NR_MEMFD_FOLIOS];
+
 static const char *device_bdf;
 
 static char state_session[LIVEUPDATE_SESSION_NAME_LENGTH];
+static char data_session[LIVEUPDATE_SESSION_NAME_LENGTH];
 static char device_session[LIVEUPDATE_SESSION_NAME_LENGTH];
 
 enum {
 	STATE_TOKEN,
 	DEVICE_TOKEN,
+	MEMFD_TOKEN,
+	DATA_TOKEN,
 };
 
+static u64 memcpy_size(struct vfio_pci_device *device)
+{
+	return min_t(u64, src_region.size, device->driver.max_memcpy_size);
+}
+
+static bool is_filled(const char *buf, u64 size, char c)
+{
+	return buf[0] == c && !memcmp(buf, buf + 1, size - 1);
+}
+
+static void dma_memcpy_one(struct vfio_pci_device *device, char c)
+{
+	u64 size = memcpy_size(device);
+	void *src = src_region.vaddr;
+	void *dst = dst_region.vaddr;
+
+	memset(src, c, size);
+	memset(dst, 0, size);
+
+	VFIO_ASSERT_EQ(vfio_pci_driver_memcpy(device, to_iova(device, src),
+					      to_iova(device, dst), size), 0);
+	VFIO_ASSERT_TRUE(is_filled(dst, size, c));
+}
+
+static void dma_memcpy_start(struct vfio_pci_device *device)
+{
+	u64 size = memcpy_size(device);
+	void *src = src_region.vaddr;
+	void *dst = dst_region.vaddr;
+	u64 count;
+
+	/*
+	 * Rough Math: If we assume the device will perform memcpy at a rate of
+	 * 30GB/s then 7200GB of transfers will run for about 4 minutes.
+	 */
+	count = (u64)7200 * SZ_1G / size;
+	count = min_t(u64, count, device->driver.max_memcpy_count);
+
+	memset(src, 'x', size);
+	memset(dst, 0, size);
+
+	ksft_print_msg("Starting %lu DMA memcpy operations of size 0x%lx\n",
+		       count, size);
+	vfio_pci_driver_memcpy_start(device, to_iova(device, src),
+				     to_iova(device, dst), size, count);
+}
+
+static void dma_memcpy_wait(struct vfio_pci_device *device)
+{
+	u64 size = memcpy_size(device);
+	void *src = src_region.vaddr;
+	void *dst = dst_region.vaddr;
+	struct timespec start, end;
+	long ms;
+
+	VFIO_ASSERT_EQ(clock_gettime(CLOCK_MONOTONIC, &start), 0);
+
+	/* Fail rather than hang if the device stopped, e.g. as it was reset. */
+	alarm(MEMCPY_TIMEOUT_S);
+	VFIO_ASSERT_EQ(vfio_pci_driver_memcpy_wait(device), 0);
+	alarm(0);
+
+	VFIO_ASSERT_EQ(clock_gettime(CLOCK_MONOTONIC, &end), 0);
+	ms = (end.tv_sec - start.tv_sec) * 1000 +
+	     (end.tv_nsec - start.tv_nsec) / 1000000;
+
+	VFIO_ASSERT_TRUE(is_filled(src, size, 'x'));
+	VFIO_ASSERT_TRUE(is_filled(dst, size, 'x'));
+
+	ksft_print_msg("Pre-kexec DMA memcpy operations completed after %ld ms\n",
+		       ms);
+}
+
 static void check_noiommu(const char *bdf)
 {
 	const char *cdev_path = __vfio_pci_get_cdev_path(bdf, true);
@@ -35,26 +133,162 @@ static void check_noiommu(const char *bdf)
 	free((void *)cdev_path);
 }
 
+static void dma_memfd_regions_map(struct vfio_pci_device *device, int fd,
+				  bool before_kexec)
+{
+	struct dma_region *regions[NR_MEMFD_FOLIOS] = {
+		&device->driver.region,
+		&src_region,
+		&dst_region,
+	};
+	int i;
+
+	memfd_vaddr = vfio_memfd_mmap_aligned(fd, MEMFD_SIZE, SZ_2M);
+
+	for (i = 0; i < NR_MEMFD_FOLIOS; i++) {
+		struct dma_region *r = regions[i];
+
+		r->vaddr = memfd_vaddr + (u64)i * SZ_2M;
+		r->size = SZ_2M;
+		iommu_map_identity(device->iommu, r);
+
+		if (before_kexec)
+			folio_pa[i] = r->iova;
+		else
+			VFIO_ASSERT_EQ(r->iova, folio_pa[i],
+				       "Folio %d moved across kexec (0x%lx != 0x%lx)\n",
+				       i, r->iova, folio_pa[i]);
+	}
+}
+
+static void dma_memfd_recheck_pa(struct vfio_pci_device *device)
+{
+	struct dma_region *regions[NR_MEMFD_FOLIOS] = {
+		&device->driver.region,
+		&src_region,
+		&dst_region,
+	};
+	int i;
+
+	for (i = 0; i < NR_MEMFD_FOLIOS; i++) {
+		u64 pa, len;
+
+		VFIO_ASSERT_EQ(__iommu_noiommu_get_pa(device->iommu,
+						      regions[i]->iova, SZ_2M,
+						      &pa, &len), 0);
+		VFIO_ASSERT_EQ(pa, folio_pa[i]);
+		VFIO_ASSERT_EQ(len, (u64)SZ_2M);
+	}
+}
+
+static void dma_memfd_regions_unmap(struct vfio_pci_device *device)
+{
+	iommu_unmap(device->iommu, &dst_region);
+	iommu_unmap(device->iommu, &src_region);
+	iommu_unmap(device->iommu, &device->driver.region);
+	VFIO_ASSERT_EQ(munmap(memfd_vaddr, MEMFD_SIZE), 0);
+	memfd_vaddr = NULL;
+}
+
+static void save_data_session(int luo_fd)
+{
+	char buf[256];
+	int data_fd;
+
+	data_fd = luo_create_session(luo_fd, data_session);
+	VFIO_ASSERT_GE(data_fd, 0);
+
+	snprintf_assert(buf, sizeof(buf), "0x%lx 0x%lx 0x%lx",
+			folio_pa[0], folio_pa[1], folio_pa[2]);
+	VFIO_ASSERT_EQ(create_and_preserve_memfd(data_fd, DATA_TOKEN, buf), 0);
+}
+
+static void load_data_session(int luo_fd)
+{
+	char buf[256] = {};
+	char *end, *cur;
+	int data_fd;
+	int mfd;
+	int i;
+
+	data_fd = luo_retrieve_session(luo_fd, data_session);
+	VFIO_ASSERT_GE(data_fd, 0);
+
+	mfd = luo_session_retrieve_fd(data_fd, DATA_TOKEN);
+	VFIO_ASSERT_GE(mfd, 0);
+	VFIO_ASSERT_GT(pread(mfd, buf, sizeof(buf) - 1, 0), 0);
+	VFIO_ASSERT_EQ(close(mfd), 0);
+
+	cur = buf;
+	for (i = 0; i < NR_MEMFD_FOLIOS; i++) {
+		errno = 0;
+		folio_pa[i] = strtoull(cur, &end, 0);
+		VFIO_ASSERT_EQ(errno, 0);
+		VFIO_ASSERT_NE(end, cur);
+		cur = end;
+	}
+
+	VFIO_ASSERT_EQ(luo_session_finish(data_fd), 0);
+	VFIO_ASSERT_EQ(close(data_fd), 0);
+}
+
 static void before_kexec(int luo_fd)
 {
 	struct vfio_pci_device *device;
 	struct iommu *iommu;
+	void *init_vaddr = NULL;
 	int session_fd;
+	int memfd;
 	int ret;
 
 	check_noiommu(device_bdf);
 
+	memfd = vfio_thp_memfd_alloc(MEMFD_SIZE, &init_vaddr);
+	if (memfd < 0)
+		ksft_exit_skip("Failed to allocate 2MB THP memfd: %s\n",
+			       strerror(-memfd));
+	VFIO_ASSERT_EQ(munmap(init_vaddr, MEMFD_SIZE), 0);
+
 	iommu = iommu_init(MODE_IOMMUFD_NOIOMMU);
 	device = vfio_pci_device_init(device_bdf, iommu);
 
+	if (!device->driver.ops || !device->driver.ops->attach)
+		ksft_exit_skip("No driver that supports attach() found for %s\n",
+			       device_bdf);
+
+	dma_memfd_regions_map(device, memfd, true);
+
 	create_state_file(luo_fd, state_session, STATE_TOKEN, /*next_stage=*/2);
 
 	session_fd = luo_create_session(luo_fd, device_session);
 	VFIO_ASSERT_GE(session_fd, 0);
 
+	/*
+	 * Preserve the DMA memfd in the same session before the device so that
+	 * LUO's LIFO finish order resets an unclaimed device before freeing
+	 * the memfd folios.
+	 */
+	ret = luo_session_preserve_fd(session_fd, memfd, MEMFD_TOKEN);
+	VFIO_ASSERT_EQ(ret, 0);
+
+	dma_memfd_recheck_pa(device);
+
 	ret = luo_session_preserve_fd(session_fd, device->fd, DEVICE_TOKEN);
 	VFIO_ASSERT_EQ(ret, 0);
 
+	vfio_pci_driver_init(device);
+	dma_memcpy_one(device, 'a');
+
+	dma_memcpy_start(device);
+
+	/*
+	 * Disable interrupts on the device or freeze() will fail. The memcpy
+	 * operations do not generate any.
+	 */
+	vfio_pci_msix_disable(device);
+
+	save_data_session(luo_fd);
+
 	close(luo_fd);
 	daemonize_and_wait();
 }
@@ -98,13 +332,16 @@ static void after_kexec(int luo_fd, int state_session_fd)
 	struct iommu *iommu;
 	int session_fd;
 	int device_fd;
+	int memfd;
 	int stage;
 
-	check_open_vfio_device_fails();
-
 	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
 	VFIO_ASSERT_EQ(stage, 2);
 
+	load_data_session(luo_fd);
+
+	check_open_vfio_device_fails();
+
 	session_fd = luo_retrieve_session(luo_fd, device_session);
 	VFIO_ASSERT_GE(session_fd, 0);
 
@@ -112,16 +349,25 @@ static void after_kexec(int luo_fd, int state_session_fd)
 	VFIO_ASSERT_GE(device_fd, 0);
 
 	iommu = iommu_init(MODE_IOMMUFD_NOIOMMU);
-
-	/*
-	 * This will invoke various ioctls on device_fd such as
-	 * VFIO_DEVICE_GET_INFO. So this is a decent sanity test
-	 * that LUO actually handed us back a valid VFIO device
-	 * file and not something else.
-	 */
 	device = __vfio_pci_device_init(device_bdf, iommu, device_fd);
 
+	memfd = luo_session_retrieve_fd(session_fd, MEMFD_TOKEN);
+	VFIO_ASSERT_GE(memfd, 0);
+
+	dma_memfd_regions_map(device, memfd, false);
+
+	vfio_pci_driver_attach(device, /*memcpy_in_progress=*/true);
+	dma_memcpy_wait(device);
+
+	/* The device was not reset, so it can be used without reinitializing it. */
+	dma_memcpy_one(device, 'y');
+
 	VFIO_ASSERT_EQ(luo_session_finish(session_fd), 0);
+	VFIO_ASSERT_EQ(close(session_fd), 0);
+
+	vfio_pci_driver_remove(device);
+	dma_memfd_regions_unmap(device);
+	VFIO_ASSERT_EQ(close(memfd), 0);
 
 	vfio_pci_device_cleanup(device);
 	iommu_cleanup(iommu);
@@ -133,6 +379,8 @@ int main(int argc, char *argv[])
 
 	snprintf_assert(device_session, sizeof(device_session),
 			"vfio-lu-device-%s", device_bdf);
+	snprintf_assert(data_session, sizeof(data_session),
+			"vfio-lu-data-%s", device_bdf);
 	snprintf_assert(state_session, sizeof(state_session),
 			"vfio-lu-state-%s", device_bdf);
 
-- 
2.56.0.317.g454f8302e1-goog

