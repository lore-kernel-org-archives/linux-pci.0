Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8437107E
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289311; cv=none; b=V+o5sEsDgzFG11HWq2+iKonwbWLVxtLgP+MGhp5rTEZaLl9btLave1hDF+bNgXRUi8+PW+q0Fxfm8vGPX4oVPIyx11UChkJH3iCErDRqkBk+eVBATA2p13bCHj5vS87SbFA3moXJ5T8v1JoNmheNG0u02mLuxtvMCwYn7Qgh7bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289311; c=relaxed/simple;
	bh=ZV4Sa593unXZPr5d3ovgHpcidHVCjeWufa5NT1dQlis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zly+0gQ0VB6Nn0w1xolo3quC5uf52Brk26ddOiHZq+mMoEWUFimxTJl3ekLItC6GMYv1JEhIqRCU3LA/3sKZ/7Tm3C7M5Z4A/rB95wyoZ7DictQoic8YlTOMd5st8dYsMn2DTG7JCVYdPh3fFrViyvya2gqk1pXLCfsxleWgdWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQBfJzdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQBfJzdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BFC1F000E9;
	Sun,  5 Jul 2026 22:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289308;
	bh=mk+1go5M9cBXzVzu/5kpaVJ+gMv1+XYmTzDeuEOEdt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JQBfJzdEfL2ydcy5ijSFjMNQVtB4CvagHVlD/GtX22fXCk09FMotw/q2P3oYWo85t
	 8Y2qz8LUIX6fv3REEV4OiEXXQ0K+tNy6gwG5o0pQPoGOc1Orowdb1iMLFRX6C9O8k7
	 RQn60Dtq/F4ubIA5bJEjba7oppLGUZTIYZGz4E4j+RiLpQL2L9uOhKLzHMqSL3oGRe
	 0E6KGdZiGfRLQKReo7+3cw0hyHNDwwtcY1UmRC84sheddleVvrIz/SqV4/hw62JhOO
	 icc9D4Of5Zy4aX3Nhmcd42KK8qdX/rt+qoYX9WY0C7md36ps8U2heAoXJeOtkonc+h
	 ZUrsTRzRvxOOQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id EAC58F40068;
	Sun,  5 Jul 2026 18:08:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 05 Jul 2026 18:08:26 -0400
X-ME-Sender: <xms:2tVKan1DU8vdYbf0Dl8_iasZoUVXE2NaXew9ro-7SbfKvx3aBtz0xw>
    <xme:2tVKatVXycWZSplxhsLomo0eihD-cFiVQDqpamk4U7UWx8PL8ZKqxOGexhFnYFQOP
    M3WcQwUnQJff0SWMou0GMX-u3I1mgBfC6lg69si9bS3GIjTtJGD7_A>
X-ME-Received: <xmr:2tVKaiwLgPqU8XcrMnu1pWSTQ6GHW7RsgSghXzAlTT8U7Q4Wfx7fZQ607h1YPILaDFTn9FDWPHmZYkVkAE7Z9YPd5abLPBz6V7A>
X-ME-Proxy-Cause: dmFkZTEmt/Kj8ncE865BrN88qFMkiY1KH0NSjpKadX6khYXyz1PQ5UmqUspXtj1I8OmFRK
    D/sP2uwDpD198GujAn6g12+G/JjcpQVA9oqoaIZfA85+PZSZ7oQ30rL5fwZv6mi6dXc+jS
    lpq4OapjHVvol080W4pG0+fMxnvDyvKQ8sctkTN40CYhtmc6imiMbqfW+0tSajsnxyunvc
    3wySrn8visu24P4DJm6axOCT4bWzadChaPYCQOYwSH0SuGStCNXAXj+vjU5wykro0LKfHd
    tffFryee0/fUK4m1B/wK4jWJ8HQL22VG1+ZpPLCoBD97r6kFbq6hi4JCTL9D1pez5ugLgU
    ohvDQ4t8oZs8MdfRzaqA0pep26rNrsroUXMnnKA44NQRpILDYgsxHD9NMl8lyQiahwoOl4
    GfexMDik4YosSYMfi20JBAdhyq3QLZcrLS3CSrUpk8l+ZC1064Y87YVWOeg3dsdtdgJozY
    gBgLyoBBO3XqJ9+D4IQw4TZ/d17EghCTYMRIKUOdajhjCiTE2B4V9C9SmBjsp36PZhZ0WA
    E3M5u0dgA+loSCTzMjDc0dhW4ioIAeMMbz9IVSODkZI/lv9brfVzMsLudXmc14NVU28QEp
    /Z4YXJclK5L/noCdRjM6GGjeuQCPu0LMY+BiTpU6f25NRUdqWUcSt6DMPk7A
X-ME-Proxy: <xmx:2tVKaszRiEZlYMDacMcCIMqbrdd9H6D7KKx_Fk3se-K4fCeQf5RVKw>
    <xmx:2tVKav3a7OKeMFXwgU8yDtuEJ-DTmO0GAvBrmjRikpJIu6ED5sgcDQ>
    <xmx:2tVKaiofUJV2R-Noq9cirg8Mv5nOoP-PLM16ihGTX5Ma0ipAVSVMNw>
    <xmx:2tVKatCAtfbH_PG_z12ipFvi-4WNrGQ09ki6FQppwvYlfnHJ5eq9qw>
    <xmx:2tVKarpJfn_Qjw3OdC5OlzHUYfkDBj_Fv7uXOdQ4zwDJcRfsmWP1D-gR>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:08:26 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Alistair Francis <alistair.francis@wdc.com>,
	Lukas Wunner <lukas@wunner.de>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH 04/15] device core: Introduce "device evidence" over netlink
Date: Sun,  5 Jul 2026 15:08:08 -0700
Message-ID: <20260705220819.2472765-5-djbw@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705220819.2472765-1-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple device security mechanisms are built on top of the SPDM protocol
from the DMTF. The protocol arranges for devices to verify their identity
and establish secure sessions between requesters and responders. In turn,
device security protocols like PCIe IDE use SPDM sessions to program link
encryption keys, and protocols like PCIe TDISP use exclusive secure
sessions for managing the device's security state.

All of these uses share a need to retrieve the device's installed
certificates, its measurements, and other protocol specific objects like
interface reports. Unify all of those object retrieval and regeneration
cases into a device-scoped ABI that buses can leverage.

When PCI CMA was presented at Linux Plumbers the consensus reaction was
that it was not suitable to be driven via sysfs. Given the varied use
cases of the same fundamental objects the consensus converged on
netlink. With the new 'blob' extensions to netlink, it can support up to
the 16MB signed transcripts that SPDM generates.

A bus opts in to evidence gathering via device_evidence_register() and
passing device_evidence_ops. The ops resolve a device handle to its
corresponding 'struct device_evidence' context.

See inline documentation in
Documentation/netlink/specs/device-evidence.yaml for the object types and
options. This includes objects like TDISP interface reports and options
like digests instead of full blobs.

Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Donald Hunter <donald.hunter@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 drivers/base/Kconfig                          |   4 +
 drivers/base/Makefile                         |   1 +
 .../netlink/specs/device-evidence.yaml        | 186 +++++++
 drivers/base/device-evidence-netlink.h        |  23 +
 include/linux/device/evidence.h               |  85 ++++
 include/uapi/linux/device-evidence.h          | 110 +++++
 drivers/base/device-evidence-netlink.c        |  44 ++
 drivers/base/evidence.c                       | 453 ++++++++++++++++++
 MAINTAINERS                                   |   4 +
 9 files changed, 910 insertions(+)
 create mode 100644 Documentation/netlink/specs/device-evidence.yaml
 create mode 100644 drivers/base/device-evidence-netlink.h
 create mode 100644 include/linux/device/evidence.h
 create mode 100644 include/uapi/linux/device-evidence.h
 create mode 100644 drivers/base/device-evidence-netlink.c
 create mode 100644 drivers/base/evidence.c

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index f7d385cbd3ba..e3929fe6b240 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -190,6 +190,10 @@ config HMEM_REPORTING
 	  Enable reporting for heterogeneous memory access attributes under
 	  their non-uniform memory nodes.
 
+config DEVICE_EVIDENCE
+	bool
+	depends on NET
+
 source "drivers/base/test/Kconfig"
 
 config SYS_HYPERVISOR
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 8074a10183dc..02bdc4f74019 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
 obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
 obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
+obj-$(CONFIG_DEVICE_EVIDENCE) += evidence.o device-evidence-netlink.o
 obj-$(CONFIG_ACPI) += physical_location.o
 
 obj-y			+= test/
diff --git a/Documentation/netlink/specs/device-evidence.yaml b/Documentation/netlink/specs/device-evidence.yaml
new file mode 100644
index 000000000000..44b278bc20e1
--- /dev/null
+++ b/Documentation/netlink/specs/device-evidence.yaml
@@ -0,0 +1,186 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+---
+name: device-evidence
+protocol: genetlink
+uapi-header: linux/device-evidence.h
+doc: Device evidence retrieval over generic netlink
+
+definitions:
+  -
+    type: const
+    name: max-object-size
+    value: 0x01000000
+  -
+    type: const
+    name: max-nonce-size
+    value: 32
+  -
+    name: type
+    type: enum
+    doc: Device security evidence objects
+    render-max: true
+    entries:
+      -
+        name: cert0
+        doc: SPDM certificate chain from device slot0
+      -
+        name: cert1
+        doc: SPDM certificate chain from device slot1
+      -
+        name: cert2
+        doc: SPDM certificate chain from device slot2
+      -
+        name: cert3
+        doc: SPDM certificate chain from device slot3
+      -
+        name: cert4
+        doc: SPDM certificate chain from device slot4
+      -
+        name: cert5
+        doc: SPDM certificate chain from device slot5
+      -
+        name: cert6
+        doc: SPDM certificate chain from device slot6
+      -
+        name: cert7
+        doc: SPDM certificate chain from device slot7
+      -
+        name: vca
+        doc: |
+          SPDM version, capabilities, and algorithms transcript
+          negotiated at session establishment. An implementation may not
+          provide this separately and instead include it in the
+          measurements transcript.
+      -
+        name: measurements
+        doc: SPDM GET_MEASUREMENTS response
+      -
+        name: report
+        doc: |
+          A bus that implements a device interface security protocol
+          like TDISP may convey an interface report that details
+          interface settings and capabilities.
+  -
+    name: type-flag
+    type: flags
+    doc: Device security evidence request flags
+    render-max: true
+    # NOTE! these values must match the type enum name and order
+    entries:
+      -
+        name: cert0
+      -
+        name: cert1
+      -
+        name: cert2
+      -
+        name: cert3
+      -
+        name: cert4
+      -
+        name: cert5
+      -
+        name: cert6
+      -
+        name: cert7
+      -
+        name: vca
+      -
+        name: measurements
+      -
+        name: report
+  -
+    name: flag
+    type: flags
+    render-max: true
+    doc: Flags to control evidence retrieval
+    entries:
+      -
+        name: digest
+        doc: |
+          Request a secure hash of objects like vca and measurements.
+          The expectation is that this digest is produced by a responder
+          within the TCB like a platform TSM. It validates a blob that
+          may have traversed a transport without integrity protections.
+
+attribute-sets:
+  -
+    name: object
+    attributes:
+      -
+        name: type
+        type: u32
+        doc: evidence type-id
+      -
+        name: type-mask
+        type: u32
+        doc: evidence types as a flag mask
+      -
+        name: flags
+        type: u32
+        doc: evidence modifier flags like 'request object digest'
+      -
+        name: subsys
+        type: string
+        doc: device subsystem name (e.g. bus or class name)
+      -
+        name: dev-name
+        type: string
+        doc: device name
+      -
+        name: nonce
+        type: binary
+        checks:
+          max-len: max-nonce-size
+      -
+        name: generation
+        type: u32
+        doc: detect local threads racing evidence refresh
+      -
+        name: count
+        type: u64
+        doc: TSM, if present, observed count of evidence refresh events
+      -
+        name: length
+        type: u32
+        checks:
+          max: max-object-size
+        doc: |
+          Final size of 'val' blob after all messages received.
+      -
+        name: val
+        type: binary
+        multi-attr: true
+        bloblen: length
+        doc: |
+          Ordered evidence object value chunk. Large evidence objects
+          may be split over several dump reply messages up to 'length'.
+          'length' is transmitted before the first chunk.
+
+operations:
+  list:
+    -
+      name: read
+      doc: |
+        Read device evidence objects of a given type mask. The dump reply
+        reports the total value length before val attributes fill the evidence
+        object, possibly across multiple messages.
+      attribute-set: object
+      flags: [admin-perm]
+      dump:
+        pre: device-evidence-nl-read-pre
+        post: device-evidence-nl-read-post
+        request:
+          attributes:
+            - type-mask
+            - flags
+            - subsys
+            - dev-name
+            - nonce
+        reply:
+          attributes:
+            - type
+            - generation
+            - length
+            - val
diff --git a/drivers/base/device-evidence-netlink.h b/drivers/base/device-evidence-netlink.h
new file mode 100644
index 000000000000..a7a3110630a6
--- /dev/null
+++ b/drivers/base/device-evidence-netlink.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/device-evidence.yaml */
+/* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _LINUX_DEVICE_EVIDENCE_GEN_H
+#define _LINUX_DEVICE_EVIDENCE_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/device-evidence.h>
+
+int device_evidence_nl_read_pre(struct netlink_callback *cb);
+int device_evidence_nl_read_post(struct netlink_callback *cb);
+
+int device_evidence_nl_read_dumpit(struct sk_buff *skb,
+				   struct netlink_callback *cb);
+
+extern struct genl_family device_evidence_nl_family;
+
+#endif /* _LINUX_DEVICE_EVIDENCE_GEN_H */
diff --git a/include/linux/device/evidence.h b/include/linux/device/evidence.h
new file mode 100644
index 000000000000..5036fbe63e30
--- /dev/null
+++ b/include/linux/device/evidence.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2026 Intel Corporation */
+/* Copyright (C) 2026, NVIDIA Corporation & Affiliates */
+#ifndef __DEVICE_EVIDENCE_H
+#define __DEVICE_EVIDENCE_H
+
+#include <linux/errno.h>
+#include <linux/rwsem.h>
+#include <linux/types.h>
+#include <uapi/linux/device-evidence.h>
+#include <uapi/linux/hash_info.h>
+
+struct device;
+struct module;
+
+/**
+ * struct device_evidence_object - General device evidence blob descriptor
+ * @data: pointer to the evidence data blob
+ * @len: length of the evidence data blob
+ * @digest: TSM generated digest of the data blob
+ */
+struct device_evidence_object {
+	void *data;
+	size_t len;
+	void *digest;
+};
+
+/**
+ * struct device_evidence - Retrieved device evidence
+ * @slot: certificate slot used by a link TSM for connect
+ * @generation: refresh_evidence() invocation detection
+ * @digest_algo: payload size of DEVICE_EVIDENCE_FLAG_DIGEST requests
+ * @lock: synchronize dumps vs refresh_evidence()
+ * @obj: array of evidence objects a TSM might populate
+ *
+ * An increment of @generation causes in flight dumps to fail with -EAGAIN.
+ */
+struct device_evidence {
+	int slot;
+	u32 generation;
+	enum hash_algo digest_algo;
+	struct rw_semaphore lock;
+	struct device_evidence_object obj[DEVICE_EVIDENCE_TYPE_MAX + 1];
+};
+
+/**
+ * struct device_evidence_ops - subsys-specific evidence lookup operations
+ * @subsys_name: /sys/{bus,class}/@subsys_name
+ * @find_device: fetch device object for ../@subsys_name/devices/@name
+ * @evidence_read_begin: hold evidence stable over read
+ * @evidence_read_end: hold evidence stable over read
+ * @refresh_evidence: generate fresh device evidence
+ *
+ * Connect the generic "device-evidence" netlink transport to a source
+ * of device evidence that conveys SPDM collateral and its extensions
+ * like PCIe TDISP interface reports
+ */
+struct device_evidence_ops {
+	const char *subsys_name;
+	struct device *(*find_device)(const char *name);
+	struct device_evidence *(*evidence_read_begin)(struct device *dev);
+	void (*evidence_read_end)(struct device_evidence *evidence);
+	int (*refresh_evidence)(struct device *dev, const void *nonce,
+				size_t nonce_len);
+};
+
+#ifdef CONFIG_DEVICE_EVIDENCE
+struct device_evidence *device_evidence_create(int slot,
+					       enum hash_algo digest_algo);
+int device_evidence_register(const struct device_evidence_ops *ops);
+void device_evidence_unregister(const struct device_evidence_ops *ops);
+#else
+static inline int
+device_evidence_register(const struct device_evidence_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void
+device_evidence_unregister(const struct device_evidence_ops *ops)
+{
+}
+#endif
+
+#endif /* __DEVICE_EVIDENCE_H */
diff --git a/include/uapi/linux/device-evidence.h b/include/uapi/linux/device-evidence.h
new file mode 100644
index 000000000000..b184174a695d
--- /dev/null
+++ b/include/uapi/linux/device-evidence.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/device-evidence.yaml */
+/* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _UAPI_LINUX_DEVICE_EVIDENCE_H
+#define _UAPI_LINUX_DEVICE_EVIDENCE_H
+
+#define DEVICE_EVIDENCE_FAMILY_NAME	"device-evidence"
+#define DEVICE_EVIDENCE_FAMILY_VERSION	1
+
+#define DEVICE_EVIDENCE_MAX_OBJECT_SIZE	16777216
+#define DEVICE_EVIDENCE_MAX_NONCE_SIZE	32
+
+/**
+ * enum device_evidence_type - Device security evidence objects
+ * @DEVICE_EVIDENCE_TYPE_CERT0: SPDM certificate chain from device slot0
+ * @DEVICE_EVIDENCE_TYPE_CERT1: SPDM certificate chain from device slot1
+ * @DEVICE_EVIDENCE_TYPE_CERT2: SPDM certificate chain from device slot2
+ * @DEVICE_EVIDENCE_TYPE_CERT3: SPDM certificate chain from device slot3
+ * @DEVICE_EVIDENCE_TYPE_CERT4: SPDM certificate chain from device slot4
+ * @DEVICE_EVIDENCE_TYPE_CERT5: SPDM certificate chain from device slot5
+ * @DEVICE_EVIDENCE_TYPE_CERT6: SPDM certificate chain from device slot6
+ * @DEVICE_EVIDENCE_TYPE_CERT7: SPDM certificate chain from device slot7
+ * @DEVICE_EVIDENCE_TYPE_VCA: SPDM version, capabilities, and algorithms
+ *   transcript negotiated at session establishment. An implementation may not
+ *   provide this separately and instead include it in the measurements
+ *   transcript.
+ * @DEVICE_EVIDENCE_TYPE_MEASUREMENTS: SPDM GET_MEASUREMENTS response
+ * @DEVICE_EVIDENCE_TYPE_REPORT: A bus that implements a device interface
+ *   security protocol like TDISP may convey an interface report that details
+ *   interface settings and capabilities.
+ */
+enum device_evidence_type {
+	DEVICE_EVIDENCE_TYPE_CERT0,
+	DEVICE_EVIDENCE_TYPE_CERT1,
+	DEVICE_EVIDENCE_TYPE_CERT2,
+	DEVICE_EVIDENCE_TYPE_CERT3,
+	DEVICE_EVIDENCE_TYPE_CERT4,
+	DEVICE_EVIDENCE_TYPE_CERT5,
+	DEVICE_EVIDENCE_TYPE_CERT6,
+	DEVICE_EVIDENCE_TYPE_CERT7,
+	DEVICE_EVIDENCE_TYPE_VCA,
+	DEVICE_EVIDENCE_TYPE_MEASUREMENTS,
+	DEVICE_EVIDENCE_TYPE_REPORT,
+
+	/* private: */
+	__DEVICE_EVIDENCE_TYPE_MAX,
+	DEVICE_EVIDENCE_TYPE_MAX = (__DEVICE_EVIDENCE_TYPE_MAX - 1)
+};
+
+/*
+ * Device security evidence request flags
+ */
+enum device_evidence_type_flag {
+	DEVICE_EVIDENCE_TYPE_FLAG_CERT0 = 1,
+	DEVICE_EVIDENCE_TYPE_FLAG_CERT1 = 2,
+	DEVICE_EVIDENCE_TYPE_FLAG_CERT2 = 4,
+	DEVICE_EVIDENCE_TYPE_FLAG_CERT3 = 8,
+	DEVICE_EVIDENCE_TYPE_FLAG_CERT4 = 16,
+	DEVICE_EVIDENCE_TYPE_FLAG_CERT5 = 32,
+	DEVICE_EVIDENCE_TYPE_FLAG_CERT6 = 64,
+	DEVICE_EVIDENCE_TYPE_FLAG_CERT7 = 128,
+	DEVICE_EVIDENCE_TYPE_FLAG_VCA = 256,
+	DEVICE_EVIDENCE_TYPE_FLAG_MEASUREMENTS = 512,
+	DEVICE_EVIDENCE_TYPE_FLAG_REPORT = 1024,
+
+	/* private: */
+	DEVICE_EVIDENCE_TYPE_FLAG_MASK = 2047,
+};
+
+/**
+ * enum device_evidence_flag - Flags to control evidence retrieval
+ * @DEVICE_EVIDENCE_FLAG_DIGEST: Request a secure hash of objects like vca and
+ *   measurements. The expectation is that this digest is produced by a
+ *   responder within the TCB like a platform TSM. It validates a blob that may
+ *   have traversed a transport without integrity protections.
+ */
+enum device_evidence_flag {
+	DEVICE_EVIDENCE_FLAG_DIGEST = 1,
+
+	/* private: */
+	DEVICE_EVIDENCE_FLAG_MASK = 1,
+};
+
+enum {
+	DEVICE_EVIDENCE_A_OBJECT_TYPE = 1,
+	DEVICE_EVIDENCE_A_OBJECT_TYPE_MASK,
+	DEVICE_EVIDENCE_A_OBJECT_FLAGS,
+	DEVICE_EVIDENCE_A_OBJECT_SUBSYS,
+	DEVICE_EVIDENCE_A_OBJECT_DEV_NAME,
+	DEVICE_EVIDENCE_A_OBJECT_NONCE,
+	DEVICE_EVIDENCE_A_OBJECT_GENERATION,
+	DEVICE_EVIDENCE_A_OBJECT_COUNT,
+	DEVICE_EVIDENCE_A_OBJECT_LENGTH,
+	DEVICE_EVIDENCE_A_OBJECT_VAL,
+
+	__DEVICE_EVIDENCE_A_OBJECT_MAX,
+	DEVICE_EVIDENCE_A_OBJECT_MAX = (__DEVICE_EVIDENCE_A_OBJECT_MAX - 1)
+};
+
+enum {
+	DEVICE_EVIDENCE_CMD_READ = 1,
+
+	__DEVICE_EVIDENCE_CMD_MAX,
+	DEVICE_EVIDENCE_CMD_MAX = (__DEVICE_EVIDENCE_CMD_MAX - 1)
+};
+
+#endif /* _UAPI_LINUX_DEVICE_EVIDENCE_H */
diff --git a/drivers/base/device-evidence-netlink.c b/drivers/base/device-evidence-netlink.c
new file mode 100644
index 000000000000..3a739601f107
--- /dev/null
+++ b/drivers/base/device-evidence-netlink.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/device-evidence.yaml */
+/* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "device-evidence-netlink.h"
+
+#include <uapi/linux/device-evidence.h>
+
+/* DEVICE_EVIDENCE_CMD_READ - dump */
+static const struct nla_policy device_evidence_read_nl_policy[DEVICE_EVIDENCE_A_OBJECT_NONCE + 1] = {
+	[DEVICE_EVIDENCE_A_OBJECT_TYPE_MASK] = { .type = NLA_U32, },
+	[DEVICE_EVIDENCE_A_OBJECT_FLAGS] = { .type = NLA_U32, },
+	[DEVICE_EVIDENCE_A_OBJECT_SUBSYS] = { .type = NLA_NUL_STRING, },
+	[DEVICE_EVIDENCE_A_OBJECT_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVICE_EVIDENCE_A_OBJECT_NONCE] = NLA_POLICY_MAX_LEN(DEVICE_EVIDENCE_MAX_NONCE_SIZE),
+};
+
+/* Ops table for device_evidence */
+static const struct genl_split_ops device_evidence_nl_ops[] = {
+	{
+		.cmd		= DEVICE_EVIDENCE_CMD_READ,
+		.start		= device_evidence_nl_read_pre,
+		.dumpit		= device_evidence_nl_read_dumpit,
+		.done		= device_evidence_nl_read_post,
+		.policy		= device_evidence_read_nl_policy,
+		.maxattr	= DEVICE_EVIDENCE_A_OBJECT_NONCE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
+};
+
+struct genl_family device_evidence_nl_family __ro_after_init = {
+	.name		= DEVICE_EVIDENCE_FAMILY_NAME,
+	.version	= DEVICE_EVIDENCE_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= device_evidence_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(device_evidence_nl_ops),
+};
diff --git a/drivers/base/evidence.c b/drivers/base/evidence.c
new file mode 100644
index 000000000000..8e019669db07
--- /dev/null
+++ b/drivers/base/evidence.c
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2026 NVIDIA Corporation & Affiliates */
+
+#include <crypto/hash_info.h>
+#include <linux/cleanup.h>
+#include <linux/device/evidence.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/find.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/netlink.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
+#include "device-evidence-netlink.h"
+
+#define DEVICE_EVIDENCE_NAME_LEN 32
+#define DEVICE_EVIDENCE_START U32_MAX
+#define DEVICE_EVIDENCE_OBJECT_START (U32_MAX - 1)
+
+struct device_evidence_subsys {
+	const struct device_evidence_ops *ops;
+	struct list_head list;
+	atomic_t busy;
+};
+
+static LIST_HEAD(device_evidence_subsystems);
+static DEFINE_MUTEX(device_evidence_lock);
+static DECLARE_WAIT_QUEUE_HEAD(device_evidence_waitqueue);
+
+struct device_evidence_ctx {
+	struct device_evidence_subsys *subsys;
+	struct device *dev;
+	void *nonce;
+	u64 generation;
+	u32 type_mask;
+	u32 flags;
+	u32 offset;
+	u16 nonce_len;
+};
+
+struct device_evidence *device_evidence_create(int slot,
+					       enum hash_algo digest_algo)
+{
+	struct device_evidence *evidence = kzalloc_obj(*evidence);
+
+	if (!evidence)
+		return NULL;
+
+	evidence->slot = slot;
+	evidence->generation = 1;
+	evidence->digest_algo = digest_algo;
+	init_rwsem(&evidence->lock);
+	return evidence;
+}
+EXPORT_SYMBOL_GPL(device_evidence_create);
+
+int device_evidence_register(const struct device_evidence_ops *ops)
+{
+	struct device_evidence_subsys *subsys;
+
+	if (!ops || !ops->subsys_name || !ops->find_device ||
+	    !ops->evidence_read_begin || !ops->evidence_read_end)
+		return -EINVAL;
+
+	struct device_evidence_subsys *new_subsys __free(kfree) =
+		kzalloc_obj(*new_subsys);
+	if (!new_subsys)
+		return -ENOMEM;
+
+	guard(mutex)(&device_evidence_lock);
+	list_for_each_entry(subsys, &device_evidence_subsystems, list)
+		if (subsys->ops == ops)
+			return -EEXIST;
+
+	new_subsys->ops = ops;
+	list_add_tail(&no_free_ptr(new_subsys)->list, &device_evidence_subsystems);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(device_evidence_register);
+
+static struct device_evidence_subsys *
+block_subsys(const struct device_evidence_ops *ops)
+{
+	struct device_evidence_subsys *subsys;
+
+	/* trusts callers do not re-register @ops while awaiting unregistration */
+	guard(mutex)(&device_evidence_lock);
+	list_for_each_entry(subsys, &device_evidence_subsystems, list) {
+		if (subsys->ops == ops) {
+			list_del(&subsys->list);
+			return subsys;
+		}
+	}
+	return NULL;
+}
+
+void device_evidence_unregister(const struct device_evidence_ops *ops)
+{
+	/* stop new requests */
+	struct device_evidence_subsys *subsys = block_subsys(ops);
+
+	if (!subsys)
+		return;
+
+	/* flush all usage of @ops */
+	wait_event(device_evidence_waitqueue, atomic_read(&subsys->busy) == 0);
+	kfree(subsys);
+}
+EXPORT_SYMBOL_GPL(device_evidence_unregister);
+
+static struct device_evidence_subsys *
+device_evidence_subsys(const char *subsys_name)
+{
+	struct device_evidence_subsys *subsys;
+
+	list_for_each_entry(subsys, &device_evidence_subsystems, list) {
+		const struct device_evidence_ops *ops = subsys->ops;
+
+		if (!strcmp(subsys_name, ops->subsys_name))
+			return subsys;
+	}
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static void device_evidence_ctx_teardown(struct device_evidence_ctx *ctx)
+{
+	put_device(ctx->dev);
+	kfree(ctx->nonce);
+}
+
+DEFINE_FREE(put_ctx, struct device_evidence_ctx *,
+	    if (!IS_ERR_OR_NULL(_T)) device_evidence_ctx_teardown(_T))
+
+static struct device_evidence_ctx *
+device_evidence_ctx_setup(const struct genl_info *info,
+			  struct device_evidence_ctx *ctx)
+{
+	char subsys[DEVICE_EVIDENCE_NAME_LEN];
+	char name[DEVICE_EVIDENCE_NAME_LEN];
+	struct nlattr *attr;
+
+	*ctx = (struct device_evidence_ctx) { };
+
+	if (GENL_REQ_ATTR_CHECK(info, DEVICE_EVIDENCE_A_OBJECT_SUBSYS)) {
+		NL_SET_ERR_MSG(info->extack, "missing subsys name");
+		return ERR_PTR(-EINVAL);
+	}
+
+	attr = info->attrs[DEVICE_EVIDENCE_A_OBJECT_SUBSYS];
+	if (nla_strscpy(subsys, attr, sizeof(subsys)) < 0) {
+		NL_SET_BAD_ATTR(info->extack, attr);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (GENL_REQ_ATTR_CHECK(info, DEVICE_EVIDENCE_A_OBJECT_DEV_NAME)) {
+		NL_SET_ERR_MSG(info->extack, "missing device name");
+		return ERR_PTR(-EINVAL);
+	}
+
+	attr = info->attrs[DEVICE_EVIDENCE_A_OBJECT_DEV_NAME];
+	if (nla_strscpy(name, attr, sizeof(name)) < 0) {
+		NL_SET_BAD_ATTR(info->extack, attr);
+		return ERR_PTR(-EINVAL);
+	}
+
+	ctx->subsys = device_evidence_subsys(subsys);
+	if (IS_ERR(ctx->subsys)) {
+		NL_SET_ERR_MSG_FMT(info->extack,
+				   "no evidence provider for subsys '%s'", subsys);
+		return ERR_CAST(ctx->subsys);
+	}
+
+	ctx->dev = ctx->subsys->ops->find_device(name);
+	if (!ctx->dev) {
+		NL_SET_ERR_MSG_FMT(info->extack,
+				   "device '%s:%s' evidence not found", subsys,
+				   name);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return ctx;
+}
+
+static struct device_evidence_ctx *to_ctx(struct netlink_callback *cb)
+{
+	return (struct device_evidence_ctx *)cb->ctx;
+}
+
+int device_evidence_nl_read_pre(struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct nlattr *attr;
+	u32 unknown_types;
+	int rc;
+
+	NL_ASSERT_CTX_FITS(struct device_evidence_ctx);
+
+	ACQUIRE(mutex_intr, lock)(&device_evidence_lock);
+	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
+		return rc;
+
+	struct device_evidence_ctx *ctx __free(put_ctx) =
+		device_evidence_ctx_setup(info, to_ctx(cb));
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	if (GENL_REQ_ATTR_CHECK(info,
+				DEVICE_EVIDENCE_A_OBJECT_TYPE_MASK)) {
+		NL_SET_ERR_MSG(info->extack, "missing object request mask");
+		return -EINVAL;
+	}
+
+	attr = info->attrs[DEVICE_EVIDENCE_A_OBJECT_TYPE_MASK];
+	ctx->type_mask = nla_get_u32(attr);
+	unknown_types = ctx->type_mask & ~DEVICE_EVIDENCE_TYPE_FLAG_MASK;
+	if (unknown_types) {
+		NL_SET_ERR_MSG_FMT(info->extack,
+				   "unsupported object request %#x",
+				   unknown_types);
+		return -EINVAL;
+	}
+
+	if (!ctx->type_mask) {
+		NL_SET_ERR_MSG(info->extack, "no evidence type requested");
+		return -EINVAL;
+	}
+
+	attr = info->attrs[DEVICE_EVIDENCE_A_OBJECT_FLAGS];
+	if (attr) {
+		ctx->flags = nla_get_u32(attr);
+		if (ctx->flags & ~DEVICE_EVIDENCE_FLAG_MASK) {
+			NL_SET_BAD_ATTR(info->extack, attr);
+			return -EINVAL;
+		}
+	}
+
+	attr = info->attrs[DEVICE_EVIDENCE_A_OBJECT_NONCE];
+	if (attr) {
+		ctx->nonce = nla_memdup(attr, GFP_KERNEL);
+		if (!ctx->nonce) {
+			NL_SET_BAD_ATTR(info->extack, attr);
+			return -ENOMEM;
+		}
+		ctx->nonce_len = nla_len(attr);
+	}
+
+	ctx->offset = DEVICE_EVIDENCE_START;
+	atomic_inc(&ctx->subsys->busy);
+	retain_and_null_ptr(ctx);
+
+	return 0;
+}
+
+int device_evidence_nl_read_post(struct netlink_callback *cb)
+{
+	struct device_evidence_ctx *ctx = to_ctx(cb);
+
+	device_evidence_ctx_teardown(ctx);
+
+	guard(mutex)(&device_evidence_lock);
+	if (atomic_dec_and_test(&ctx->subsys->busy))
+		wake_up_all(&device_evidence_waitqueue);
+
+	return 0;
+}
+
+static size_t evidence_len(struct device_evidence *evidence,
+			   struct device_evidence_object *obj,
+			   unsigned long flags)
+{
+	if (flags & DEVICE_EVIDENCE_FLAG_DIGEST) {
+		if (obj->digest)
+			return hash_digest_size[evidence->digest_algo];
+		return 0;
+	}
+	return obj->len;
+}
+
+static void *evidence_data(struct device_evidence_object *obj,
+			   unsigned long flags)
+{
+	if (flags & DEVICE_EVIDENCE_FLAG_DIGEST)
+		return obj->digest;
+	return obj->data;
+}
+
+static int current_type(struct device_evidence_ctx *ctx)
+{
+	return __ffs(ctx->type_mask);
+}
+
+static struct device_evidence_object *
+current_obj(struct device_evidence_ctx *ctx, struct device_evidence *evidence)
+{
+	return &evidence->obj[current_type(ctx)];
+}
+
+static int __device_evidence_read(struct sk_buff *skb,
+				  struct netlink_callback *cb,
+				  struct device_evidence *evidence)
+{
+	struct device_evidence_ctx *ctx = (struct device_evidence_ctx *)cb->ctx;
+	struct device_evidence_object *obj = current_obj(ctx, evidence);
+	size_t object_len = evidence_len(evidence, obj, ctx->flags);
+	void *object_data = evidence_data(obj, ctx->flags);
+	size_t available, overhead, len;
+	void *hdr;
+	void *val;
+	int rc;
+
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &device_evidence_nl_family, NLM_F_MULTI,
+			  DEVICE_EVIDENCE_CMD_READ);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (ctx->offset == DEVICE_EVIDENCE_OBJECT_START) {
+		if (nla_put_u32(skb, DEVICE_EVIDENCE_A_OBJECT_TYPE,
+				current_type(ctx)) ||
+		    nla_put_u32(skb, DEVICE_EVIDENCE_A_OBJECT_GENERATION,
+				ctx->generation) ||
+		    nla_put_u32(skb, DEVICE_EVIDENCE_A_OBJECT_LENGTH,
+				object_len))
+			goto out_cancel;
+
+		ctx->offset = 0;
+	}
+
+	available = skb_tailroom(skb);
+	overhead = nla_total_size(0) + NLA_ALIGNTO;
+	if (available <= overhead) {
+		rc = -EMSGSIZE;
+		goto out_cancel;
+	}
+
+	if (object_len)
+		len = min(available - overhead, object_len - ctx->offset);
+	else
+		len = 0;
+
+	val = len ? object_data + ctx->offset : NULL;
+	rc = nla_put(skb, DEVICE_EVIDENCE_A_OBJECT_VAL, len, val);
+	if (rc)
+		goto out_end;
+
+	ctx->offset += len;
+	if (ctx->offset < object_len) {
+		rc = 1;
+		goto out_end;
+	}
+
+	/* Move to the next bit in the request mask */
+	ctx->type_mask ^= 1U << current_type(ctx);
+
+	/* no more evidence types requested */
+	if (!ctx->type_mask) {
+		rc = 0;
+		goto out_end;
+	}
+	ctx->offset = DEVICE_EVIDENCE_OBJECT_START;
+	rc = 1;
+
+out_end:
+	genlmsg_end(skb, hdr);
+	if (rc > 0)
+		return skb->len;
+	return rc;
+
+out_cancel:
+	genlmsg_cancel(skb, hdr);
+	return -EMSGSIZE;
+}
+
+static int device_evidence_read(struct sk_buff *skb,
+				struct netlink_callback *cb)
+{
+	struct device_evidence_ctx *ctx = (struct device_evidence_ctx *)cb->ctx;
+	const struct device_evidence_ops *ops = ctx->subsys->ops;
+	const struct genl_info *info = genl_info_dump(cb);
+	struct device_evidence *evidence;
+	int rc;
+
+	/* Sync against provider removing device evidence */
+	evidence = ops->evidence_read_begin(ctx->dev);
+	if (IS_ERR(evidence)) {
+		NL_SET_ERR_MSG(info->extack,
+			       "failed to acquire evidence context");
+		return PTR_ERR(evidence);
+	}
+
+	/* Check that evidence stays consistent over multi-message dumps */
+	if (ctx->offset == DEVICE_EVIDENCE_START) {
+		ctx->generation = evidence->generation;
+		ctx->offset = DEVICE_EVIDENCE_OBJECT_START;
+	}
+
+	if (ctx->generation == evidence->generation)
+		rc = __device_evidence_read(skb, cb, evidence);
+	else {
+		NL_SET_ERR_MSG(info->extack, "evidence updated during read");
+		rc = -EAGAIN;
+	}
+
+	ops->evidence_read_end(evidence);
+	return rc;
+}
+
+static int device_evidence_refresh(struct device_evidence_ctx *ctx)
+{
+	const struct device_evidence_ops *ops = ctx->subsys->ops;
+
+	if (!ops->refresh_evidence)
+		return -EOPNOTSUPP;
+
+	return ops->refresh_evidence(ctx->dev, ctx->nonce, ctx->nonce_len);
+}
+
+int device_evidence_nl_read_dumpit(struct sk_buff *skb,
+				   struct netlink_callback *cb)
+{
+	struct device_evidence_ctx *ctx = (struct device_evidence_ctx *)cb->ctx;
+	const struct genl_info *info = genl_info_dump(cb);
+
+	/*
+	 * When a nonce is provided, refresh the dynamic evidence, if
+	 * specified by @ctx, before the dump operation.
+	 */
+	if (ctx->offset == DEVICE_EVIDENCE_START && ctx->nonce) {
+		int rc = device_evidence_refresh(ctx);
+
+		if (rc) {
+			NL_SET_ERR_MSG_FMT(info->extack,
+					   "evidence refresh failed: %pe", ERR_PTR(rc));
+			return rc;
+		}
+		kfree(ctx->nonce);
+		ctx->nonce = NULL;
+	}
+	return device_evidence_read(skb, cb);
+}
+
+static int __init device_evidence_nl_init(void)
+{
+	return genl_register_family(&device_evidence_nl_family);
+}
+subsys_initcall(device_evidence_nl_init);
diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..cb4f74957f69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27470,8 +27470,12 @@ S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm-report
 F:	Documentation/driver-api/coco/
 F:	Documentation/driver-api/pci/tsm.rst
+F:	Documentation/netlink/specs/device-evidence.yaml
+F:	drivers/base/*evidence*
 F:	drivers/pci/tsm.c
 F:	drivers/virt/coco/guest/
+F:	include/uapi/linux/device-evidence.h
+F:	include/linux/device/evidence.h
 F:	include/linux/*tsm*.h
 F:	samples/tsm-mr/
 
-- 
2.54.0

