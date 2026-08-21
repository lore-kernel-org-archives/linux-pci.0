Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9B40B398
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787340911; cv=none; b=HeYJFc4ZoEODMW57CTnoQS0ZZhXSWhTUnYaRnMF2cdyGv3UNE61xsmxGevrk6ouGtnlGb0W5nZ6/pJuD3HCNKds06FcxVO7FuhPFWiy9sFU71hvdVQRv0qmI8a08ROoNfXFCyU95XRRt31IC0EwxfABGdJrhqZvmLRmGu4LPoNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787340911; c=relaxed/simple;
	bh=bRSJ89K8K73/lfPTmQjl/e3hiGKByMp4oSrMZ6XtBYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KM8sXuQw+QUuDmaqw84fikbb8TrgQ5fKSibHeCJpThtGzNv8etruJagl9EGXQU4YMrwXm8svl6nIOkr2uL8hhvrzzjXJRr4FazsPL9vG+V6OhHVC3wtfeisQ5imLGvpe9/pDl7m8BUHn6Mht8EbQ6hiZBZ14LBgtv5eFbcxYqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nqlrWugl; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqlrWugl"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so1641261a12.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787340909; x=1787945709; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4GMXnvq7D8YucUDG8E30c7kSwAfsqFKmqAniOaqKEfc=;
        b=nqlrWugljYr6lqgH4qdchuu/wf3qL/5OAmL9vKLfnVsPErIucPlqe1+k9nU8k8bcvy
         mV8THsIIVhsUcMBUY1cqCn+2vDAe15yvX3ejbt5SG0l7wApbzzl0m6zkiVB5vrMb+nMD
         B/B9FRJNOiwKA7EVOEHgdSb2/OoeirPhFkrj+/l2nkeesndzIicmDzgrzAUl26RXgAmg
         WC8C29QZp1UuuVGhaOdIvpIH9Z3vmMi2p34NzgkRGAmn/2H4tD/x7Idm9OK/p8Vq/DHS
         oJBbnXz/5CqSgSgoiVG2a0Erj8HYDEZUUCl0OOOC8O1pqACPJuu3QJah+ZLAdz4Cz1oy
         pj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787340909; x=1787945709;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4GMXnvq7D8YucUDG8E30c7kSwAfsqFKmqAniOaqKEfc=;
        b=BIJuUVhLAPE+sp69/lfDpSgrRHtgbQspmqpDY6oFvfcyrKl+utoj5EXqZPGjcnOKlY
         PSv18Ix+B/jmS3ZqRbL86vb8Gn1bCddiXmOgUqaFeFJjM5+IzYQAwA6Nh91r2c9e55e9
         Xt+oClg04VejF6oVT16eGTIyxPYderYLizO+T1YK4WEPlLvc+ra1S6O0f87e8Zgb9FV6
         mf/WzaVBu42zLL408dVjE6TpFh049SJXHa7RKTifA+qtgOoOzqHCRkVNhZikVFcqoN2E
         XWE6SSqyRrjRRbXZxgr1eof3wLHQSW7Ysvdi6npE1Wk9xgScMUsrkWaW3cTKOLtuCKi6
         nF5Q==
X-Forwarded-Encrypted: i=1; AHgh+RpfdiIXtsCMH/47JL1/ymMvaHSOaQP/bMS4pykhGyzHz5SoihdSR4RcZh5YI3IjSBM7TDK4PM3f06g=@vger.kernel.org
X-Gm-Message-State: AFuF++kFibwkNNgv+KcgofxCLI4eATMBa7QhFIsRo1Be0xPV9QK8VMno
	H7J84iLDsWzStQhxV+L+vPy8rjpwLQ6q3t3KXZ33Zt0jlz6WIPCFemeXBkm2C3h3ITYY+rUdq7C
	bud40PnwH5A==
X-Received: from plks10.prod.google.com ([2002:a17:903:2ca:b0:2cb:d8fb:3da3])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec86:b0:2c6:9f66:d573
 with SMTP id d9443c01a7336-2d64ae3ac9emr164652355ad.2.1787340909050; Fri, 21
 Aug 2026 12:35:09 -0700 (PDT)
Date: Fri, 21 Aug 2026 12:35:01 -0700
In-Reply-To: <20260821193502.92431-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260821193502.92431-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260821193502.92431-2-vipinsh@google.com>
Subject: [RFC PATCH 1/1] selftests: vfio: Add mmap fault and device reset test
From: Vipin Sharma <vipinsh@google.com>
To: Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>
Cc: jrhilke@google.com, skhawaja@google.com, tatashin@google.com, 
	Will Deacon <will@kernel.org>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a selftest to verify VFIO PCI device reset on an mmapped and faulted
device. The test maps all available BARs on the device, faults them,
and triggers a device reset via the VFIO_DEVICE_RESET ioctl.

This exercise uncovers a circular locking dependency introduced in
commit f5b16b802174 ("PCI: Suspend iommu function prior to resetting a
device"), where pci_dev_reset_iommu_prepare() acquires group->mutex
under vfio's vdev->memory_lock.

Assisted-by: Jetski:gemini-3.1-pro
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  1 +
 .../selftests/vfio/vfio_pci_mmap_reset_test.c | 60 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_mmap_reset_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..17b3a2fe215c 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -13,6 +13,7 @@ TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
+TEST_GEN_PROGS += vfio_pci_mmap_reset_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_mmap_reset_test.c b/tools/testing/selftests/vfio/vfio_pci_mmap_reset_test.c
new file mode 100644
index 000000000000..b004867905de
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_mmap_reset_test.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/pci_regs.h>
+#include <linux/vfio.h>
+
+#include <libvfio.h>
+
+#include "kselftest_harness.h"
+
+static const char *device_bdf;
+
+FIXTURE(vfio_pci_mmap_reset_test) {
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_SETUP(vfio_pci_mmap_reset_test)
+{
+	self->iommu = iommu_init(MODE_IOMMUFD);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_mmap_reset_test)
+{
+	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
+}
+
+TEST_F(vfio_pci_mmap_reset_test, mmap_fault_and_reset)
+{
+	volatile char dummy;
+	bool has_mmap = false;
+	int i;
+
+	if (!(self->device->info.flags & VFIO_DEVICE_FLAGS_RESET))
+		SKIP(return, "Device does not support reset\n");
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		struct vfio_pci_bar *bar = &self->device->bars[i];
+
+		if (!bar->vaddr)
+			continue;
+
+		/* Touch BAR to trigger page fault under mmap_lock */
+		dummy = *(volatile char *)bar->vaddr;
+		(void)dummy;
+		has_mmap = true;
+	}
+
+	if (!has_mmap)
+		SKIP(return, "No mmapable BAR found on device\n");
+
+	/* Trigger device reset under memory_lock */
+	vfio_pci_device_reset(self->device);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.55.0.766.g2966f0265a-goog

