Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621823C4546
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543322; cv=none; b=oskUmrgJPDYuXTL/9/pmCOjmPGCn4aneaPGhgUYNOrWgCPDctP84XPDQ6YtLZXa5azbnlHeCkruepkL8X7dzpINgYD9QPZ2A65Ky33ZwNGbp6QMOkl0x5AjEJSf1xBIQ7cixVvMwa/Ih6caVl2afZEYbvPOIPzp773u5RLb71qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543322; c=relaxed/simple;
	bh=xXmk5pZJDMgIjU18pL7UFgkHN+p/KhwkXx8qVOwhLq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sl1mDKhrwule+XUDl42/D6fqkC0rvKZC+VI5hq3o/ds/u6ikwxeeR750irvzsAdUxb70m3qwRTiIIBZq46shsBrJn+WVDBe4OBQ6uW4ruW7Ff2lyCb5oBH8zgNLmWIc2mTC/qGhkFaBoEVHigyrQYe2ABuj7Q6d82nuOnNcb0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tx/te94p; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tx/te94p"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-366ded3bed0so2180197a91.0
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 16:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543318; x=1779148118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MVGH18xW5LW+rwJCXWUBd4c2GaIpMJfCuXBDhFQuypI=;
        b=Tx/te94pjs2tHeUjndCYmfeoxFd2wE7IkAP7ThGVuqtOCmmZkIWJRiWWurj+dBCgcj
         wfrzeVeEmPdvxhVL4ziT45d6Q5IEdSXWTfhwdKDVpOeGNMG0bP/MpgQCFTYaQ3aS/apk
         /w5WoFbdH63GJ3VUZol2sjzrnP2rTGRYDZmuqaXVo0bukG1UMgk96NQOk7fQDnUvIXFu
         i2wdZgvGTn1CIo8ybuSgjhU8MLKH7nQQHX2XpuSJOdraRwjxceML90+tGGleSVJY1RUA
         2ZT+2UrISQbarakfIkvypM0Jb4KP81Nz+lhdoQcQxTO0RQPHI4JKFE51Cc1WgMRvYBbq
         QWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543318; x=1779148118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVGH18xW5LW+rwJCXWUBd4c2GaIpMJfCuXBDhFQuypI=;
        b=popI1Agh0IVvruF8K08nXYETUnp0dxJK6A83+UBJuBFrN5y0mpRlhPqbKB2KG8DOpY
         0Weca2OSMogWtY5kK8GsDGWRJ66u5w3sl68vj9PwJ67cZ5AkMP9kx+OXo14PtXDCGYmX
         10OFT4SljU2lvwVBOk1Ts4LxkIluu70kLVpMIzwC9GABuYBeQfBoL+rsWsEMQRfRS6hP
         FgjTltJQ3LtIXppLmUkiUBIJmWsvwRz8IH5RjJhSTOCPsKORqk5sQHhhpvIaOxp/hEBF
         LdKF52pFe2kFtfSCbDedbnvTyw+ar7jT42G8UikhfXDixzqaLvhzTxKsZO5TtSSkz3cC
         GhIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9eRUnAVlyJMwjtx0Qs7/iBk82Swz2DVbL2u5LTewAD2z3kacF6/WrGMbII8TzS1+1jMZxPHN4xYy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7pOn8w7I5EkzD+I7fKSwwP5+/5+WjP2WsdAHzV0gyJ+TMrz6T
	6z9peyk72wP6fp/mBxdbJfAfZceSA2JpGkJtxeKumFhaJRtt52BjrCd1ouRupzOJ/FHWWkhiNWL
	roUKB+SIFZA==
X-Received: from pjbsk11.prod.google.com ([2002:a17:90b:2dcb:b0:35e:58a0:798e])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a0d:b0:368:2ba0:5e8a
 with SMTP id 98e67ed59e1d1-368ab863a90mr1167614a91.6.1778543318040; Mon, 11
 May 2026 16:48:38 -0700 (PDT)
Date: Mon, 11 May 2026 16:47:55 -0700
In-Reply-To: <20260511234802.2280368-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-10-vipinsh@google.com>
Subject: [PATCH v4 09/16] vfio: selftests: Add vfio_pci_liveupdate_uapi_test
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

Add a selftest to exercise preserving a various VFIO files through
/dev/liveupdate. Ensure that VFIO cdev device files can be preserved and
everything else (group-based device files, group files, and container
files) all fail.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  1 +
 .../vfio/vfio_pci_liveupdate_uapi_test.c      | 93 +++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 7865b2aa011c..df3e44660bd0 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -12,6 +12,7 @@ TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
+TEST_GEN_PROGS += vfio_pci_liveupdate_uapi_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
new file mode 100644
index 000000000000..1d89b08ab0a4
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <libliveupdate.h>
+#include <libvfio.h>
+#include <kselftest_harness.h>
+
+static const char *device_bdf;
+
+FIXTURE(vfio_pci_liveupdate_uapi_test) {
+	int luo_fd;
+	int session_fd;
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_VARIANT(vfio_pci_liveupdate_uapi_test) {
+	const char *iommu_mode;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode)			\
+FIXTURE_VARIANT_ADD(vfio_pci_liveupdate_uapi_test, _iommu_mode) {	\
+	.iommu_mode = #_iommu_mode,					\
+}
+
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
+#undef FIXTURE_VARIANT_ADD_IOMMU_MODE
+
+FIXTURE_SETUP(vfio_pci_liveupdate_uapi_test)
+{
+	self->luo_fd = luo_open_device();
+	ASSERT_GE(self->luo_fd, 0);
+
+	self->session_fd = luo_create_session(self->luo_fd, "session");
+	ASSERT_GE(self->session_fd, 0);
+
+	self->iommu = iommu_init(variant->iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_liveupdate_uapi_test)
+{
+	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
+	close(self->session_fd);
+	close(self->luo_fd);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_device)
+{
+	int ret;
+
+	ret = luo_session_preserve_fd(self->session_fd, self->device->fd, 0);
+
+	/* Preservation should only be supported for VFIO cdev files. */
+	ASSERT_EQ(ret, self->iommu->iommufd ? 0 : -ENOENT);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_group_fails)
+{
+	int ret;
+
+	if (self->iommu->iommufd)
+		SKIP(return, "iommufd-mode does not have group files");
+
+	ret = luo_session_preserve_fd(self->session_fd, self->device->group_fd, 0);
+	ASSERT_EQ(ret, -ENOENT);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_container_fails)
+{
+	int ret;
+
+	if (self->iommu->iommufd)
+		SKIP(return, "iommufd-mode does not have container files");
+
+	ret = luo_session_preserve_fd(self->session_fd, self->iommu->container_fd, 0);
+	ASSERT_EQ(ret, -ENOENT);
+}
+
+int main(int argc, char *argv[])
+{
+	int fd;
+
+	fd = luo_open_device();
+	if (fd < 0)
+		ksft_exit_skip("open(%s) failed: %s, skipping\n",
+			       LUO_DEVICE, strerror(errno));
+
+	close(fd);
+
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.54.0.563.g4f69b47b94-goog

