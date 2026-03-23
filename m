Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF1E3932D8
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310356; cv=none; b=DKlDSYvEW/szzVSmPq/HMm5iyAInM1VAQvPyZMZDp9ckNv1ZPO4tMjWk9rhyVWhUNTQDS3V15s7O548/D02KAneRACpo/MtLAwXhBGeJ+NBCrKmJ6acB8IWzpguAqTZdglJFMLJBn0XU9Nj+fluZ3kGEpynlACNfavGVok2jbH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310356; c=relaxed/simple;
	bh=0srt54TVUaweZ/O58H7olAoGMtQIEEkzyNB+t5cltrc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V9by2NumQEaOryv5TC1xtr8bdJ1TPyOfo1QCJrT0lTSl9Xix4vNrXrXy4wvBVKFTgEi4k2RGo0NMuvmi2DfG4tKLryOL3tdTskVyL89NmwbN6nq71rztoqFwm4R5wStOvmffwJDiK71Sr2huv1xHCvt/gBMSBnf47q1GZQe6HN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ydxndrtg; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ydxndrtg"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35a1e725a8fso24246143a91.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 16:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310353; x=1774915153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IXP5xRG4iZUBSse1Xd5a8GnmNvg4u/BwNl26bCYdYz4=;
        b=YdxndrtguqXxAoH0MXC+eUfZh0H8+uraaV2+6fllN9EgSot7lfkQoAHcT3s8rtD088
         6jZCWy/K1DQXDID45pjWrAOIBe7JzEI+Cuk+Eqd75EfReeXBVZTbfP1d/mwho3ZxBRP9
         7rMNKR4BhdPRHOkIJ1TWqs+SPuu7xPpGp7EOwxexPHeaED+SY7ePoE5i1RvslAaOOAna
         Ksio76e+eiQ62JPyCbme4bqzYYDQPRlMatXZeQ3xlT+9dS3fwywTAhIte3LyAaoWGs6/
         2PKbhWfkdhla42KV8DUoNVHdvhfXsz9YCc+Pgz1b1vDir6vBDs10QeT+1s4IOII3QZJL
         56bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310353; x=1774915153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXP5xRG4iZUBSse1Xd5a8GnmNvg4u/BwNl26bCYdYz4=;
        b=WLgorcptJ295QRHtiDQMEBq/A9IimwvNL6KTeYmNUz+HUR3yWyWlT1WCjuM2BzJwfH
         QculUl/DZ7HaqYBLXL4O3VLIjmIsrXb3zV47DDt1FGkdWrW+jgUwUcnnvabZVffy+6po
         /7C20DgEFQ8zUGZhmJSqol7LyXocQ+aiIz5XQL7aHvq0bwc+qKmjKOSwKYAnESXpVyGi
         Xp3d8oZ0udYT5K6JPr3+iDt+bqIHET7bc4XBUxQTfEDDxcm4Fe4I2kx2kx4Rwolc1Xs+
         jUtkUibtZnZAjAqjNf38+VjM0DDLgRt9NiXNqbOy9h7sHc2Ezem+0AsS+6tb+0JC0dBq
         //8A==
X-Forwarded-Encrypted: i=1; AJvYcCXnUJk1BHu6qG4uKw3pSStmbH3StBlTujuhqjq3A1F8xhsRZHZ0GTs3a9dgCX2mx143JoqnRoT4f50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfl6mSZ/Lh2crGSP+sCQhqUCOMYsLXeEWKZrSoHKng65jxwOdU
	CN2aaysurO9OnRUVTg0WjihynfkzwEK8GO7XBYJJmA/yhnbh9BFe6Lavkv8MSRO18BHJq6Yrc3a
	2RoykRD0s/q09Yw==
X-Received: from pjbil12.prod.google.com ([2002:a17:90b:164c:b0:35b:9d0e:7821])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d406:b0:35b:9c13:30cc with SMTP id 98e67ed59e1d1-35bd2d3fbffmr11092911a91.23.1774310352922;
 Mon, 23 Mar 2026 16:59:12 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:12 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-21-dmatlack@google.com>
Subject: [PATCH v3 20/24] vfio: selftests: Add vfio_pci_liveupdate_kexec_test
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

From: Vipin Sharma <vipinsh@google.com>

Add a selftest to exercise preserving a vfio-pci device across a Live
Update. For now the test is extremely simple and just verifies that the
device file can be preserved and retrieved. In the future this test will
be extended to verify more parts about device preservation as they are
implemented.

This test is added to TEST_GEN_PROGS_EXTENDED since it must be run
manually along with a kexec.

To run this test manually:

 $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
 $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 1 0000:00:04.0

 $ kexec ...   # NOTE: Exact method will be distro-dependent

 $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
 $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 2 0000:00:04.0

The second call to setup.sh is necessary because preserved devices are
not bound to a driver after Live Update. Such devices must be manually
bound by userspace after Live Update via driver_override.

This test is considered passing if all commands exit with 0.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  4 +
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 89 +++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 5b6e79593555..792c4245d4f7 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -14,6 +14,10 @@ TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_GEN_PROGS += vfio_pci_liveupdate_uapi_test
 
+# This test must be run manually since it requires the user/automation to
+# perform a kexec during the test.
+TEST_GEN_PROGS_EXTENDED += vfio_pci_liveupdate_kexec_test
+
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
 TEST_FILES += scripts/run.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
new file mode 100644
index 000000000000..15b3e3af91d1
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <libliveupdate.h>
+#include <libvfio.h>
+
+static const char *device_bdf;
+
+static char state_session[LIVEUPDATE_SESSION_NAME_LENGTH];
+static char device_session[LIVEUPDATE_SESSION_NAME_LENGTH];
+
+enum {
+	STATE_TOKEN,
+	DEVICE_TOKEN,
+};
+
+static void before_kexec(int luo_fd)
+{
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	int session_fd;
+	int ret;
+
+	iommu = iommu_init("iommufd");
+	device = vfio_pci_device_init(device_bdf, iommu);
+
+	create_state_file(luo_fd, state_session, STATE_TOKEN, /*next_stage=*/2);
+
+	session_fd = luo_create_session(luo_fd, device_session);
+	VFIO_ASSERT_GE(session_fd, 0);
+
+	printf("Preserving device in session\n");
+	ret = luo_session_preserve_fd(session_fd, device->fd, DEVICE_TOKEN);
+	VFIO_ASSERT_EQ(ret, 0);
+
+	close(luo_fd);
+	daemonize_and_wait();
+}
+
+static void after_kexec(int luo_fd, int state_session_fd)
+{
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	int session_fd;
+	int device_fd;
+	int stage;
+
+	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
+	VFIO_ASSERT_EQ(stage, 2);
+
+	session_fd = luo_retrieve_session(luo_fd, device_session);
+	VFIO_ASSERT_GE(session_fd, 0);
+
+	printf("Finishing the session before retrieving the device (should fail)\n");
+	VFIO_ASSERT_NE(luo_session_finish(session_fd), 0);
+
+	printf("Retrieving the device FD from LUO\n");
+	device_fd = luo_session_retrieve_fd(session_fd, DEVICE_TOKEN);
+	VFIO_ASSERT_GE(device_fd, 0);
+
+	printf("Finishing the session before binding to iommufd (should fail)\n");
+	VFIO_ASSERT_NE(luo_session_finish(session_fd), 0);
+
+	printf("Binding the device to an iommufd and setting it up\n");
+	iommu = iommu_init("iommufd");
+
+	/*
+	 * This will invoke various ioctls on device_fd such as
+	 * VFIO_DEVICE_GET_INFO. So this is a decent sanity test
+	 * that LUO actually handed us back a valid VFIO device
+	 * file and not something else.
+	 */
+	device = __vfio_pci_device_init(device_bdf, iommu, device_fd);
+
+	printf("Finishing the session\n");
+	VFIO_ASSERT_EQ(luo_session_finish(session_fd), 0);
+
+	vfio_pci_device_cleanup(device);
+	iommu_cleanup(iommu);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+
+	sprintf(device_session, "device-%s", device_bdf);
+	sprintf(state_session, "state-%s", device_bdf);
+
+	return luo_test(argc, argv, state_session, before_kexec, after_kexec);
+}
-- 
2.53.0.983.g0bb29b3bc5-goog

