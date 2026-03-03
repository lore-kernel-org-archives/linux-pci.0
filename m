Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B891A304A
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496063; cv=none; b=knjbw9NlSRUmE/MrXSpUJqXrMDkFm5BvqnAqzWzP6WhtF/6iuvh3nS9dy8NNvs118pU7RhlFQ5zskDkCBmEa34khUdMUWXw5N4qZeLEcmEgRNia/atS1EJ93LHJh3qtZVxpaoE1P2Ko1vyrZbrzbg0FP4izbIW+z/z1PRBec6po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496063; c=relaxed/simple;
	bh=oL7ni+DNFauKtZQmrh/AoOSNjeyKg2ToZotzZBsH0xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yr2xY18Ak9X/eZgWeR6UQuKtV2zSx/TA6reWy5rmW+4gDIAXT101sDZb0mPVlaTKyHuQww6+mOkKmnGQypaVTVj++dF2mnm4QrDSqbIJjHsDK4fyFADcryw6JcPMPtvKsUjeVx2DrHl8eGpWdutsMH7nO7f1PXppu9gurmniGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4gFEqAF; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4gFEqAF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496061; x=1804032061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oL7ni+DNFauKtZQmrh/AoOSNjeyKg2ToZotzZBsH0xo=;
  b=d4gFEqAFgndyRE9NlHnSHBznCyFcJn870IPnZ6XGGHyfUNVKSIKkLVwG
   xmiDx7M+tAv18HwwLQdbTSukidYeZogNEG65QTA2FBAUnFEvlvE1YwFLM
   Pk/IH80yYIG8bNKKTzPwumOi14ma951nLy8dataNZ2BkLBddiXwq47/nv
   ZpIUEjWbtDBTP8gN4NERIofW92NdCdy+1FsIEEYRi56NQPS0A1/acHK2g
   RembjsTtMDnjKdyWigyjnZizqFuC9c4i1fZ/hSvXsPRQPvf0yoXXZKQV8
   8d94H3GPswrx8UtxY3TEb0nltPzJ6lWr8TB4tvF4Pnq2YAUb3pgXwEimB
   g==;
X-CSE-ConnectionGUID: 3/LpPWuJTAOgsEQPJkVbYQ==
X-CSE-MsgGUID: L1rD3K7NQaSFEwsQ5rP/tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73482916"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73482916"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:00:57 -0800
X-CSE-ConnectionGUID: tkGEEIq+S8KZd7PXmbMVVw==
X-CSE-MsgGUID: /tvDSpr7SpmlBiLoaixc/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967101"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 16:00:56 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	aik@amd.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	bhelgaas@google.com,
	alistair23@gmail.com,
	lukas@wunner.de,
	jgg@nvidia.com,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Date: Mon,  2 Mar 2026 16:01:56 -0800
Message-ID: <20260303000207.1836586-9-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303000207.1836586-1-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once one accepts the threat model that devices may be adversarial the
process of establishing trust in the device identity, the integrity +
confidentiality of its link, and the integrity + confidentiality of its
MMIO interface requires multiple evidence objects from the device. The
device's certificate chain, measurements and interface report need to be
retrieved by the host, validated by the TSM and transmitted to the guest
all while mitigating TOCTOU races.

All TSM implementations share the same fundamental objects, but vary in how
the TSM conveys its trust in the objects. Some TSM implementations expect
the full documents to be conveyed over untrustworthy channels while the TSM
securely conveys a digest. Others transmit full objects with signed SPDM
transcripts of requester provided nonces. Some offer a single transcript
to convey the version, capabilities, and algorithms (VCA) data and
measurements in one blob while others split VCA as a separate signed blob.

Introduce a netlink interface to dump all these objects in a common way
across TSM implementations and across host and guest environments.
Userspace is responsible for handling the variance of "TSM provides combo
measurements + VCA + nonce + signature, vs TSM provides a digest over a
secure channel of the same".

The implementation adheres to the guideline from:
Documentation/userspace-api/netlink/genetlink-legacy.rst

    New Netlink families should never respond to a DO operation with
    multiple replies, with ``NLM_F_MULTI`` set. Use a filtered dump
    instead.

Per SPDM, transcripts may grow to be 16MB in size. Large PCI/TSM netlink
blobs are handled via a sequence of dump messages that userspace must
concatenate.

Cc: Donald Hunter <donald.hunter@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/Makefile                     |   2 +-
 drivers/pci/tsm/Makefile                 |   9 +
 Documentation/netlink/specs/pci-tsm.yaml | 151 +++++++++++++
 drivers/pci/tsm/netlink.h                |  23 ++
 include/linux/pci-tsm.h                  |  63 ++++++
 include/uapi/linux/pci-tsm-netlink.h     | 101 +++++++++
 drivers/pci/{tsm.c => tsm/core.c}        |  17 +-
 drivers/pci/tsm/evidence.c               | 274 +++++++++++++++++++++++
 drivers/pci/tsm/netlink.c                |  43 ++++
 MAINTAINERS                              |   4 +-
 10 files changed, 682 insertions(+), 5 deletions(-)
 create mode 100644 drivers/pci/tsm/Makefile
 create mode 100644 Documentation/netlink/specs/pci-tsm.yaml
 create mode 100644 drivers/pci/tsm/netlink.h
 create mode 100644 include/uapi/linux/pci-tsm-netlink.h
 rename drivers/pci/{tsm.c => tsm/core.c} (98%)
 create mode 100644 drivers/pci/tsm/evidence.c
 create mode 100644 drivers/pci/tsm/netlink.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index e10cfe5a280b..31f5095360af 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_IDE)		+= ide.o
-obj-$(CONFIG_PCI_TSM)		+= tsm.o
+obj-$(CONFIG_PCI_TSM)		+= tsm/
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
diff --git a/drivers/pci/tsm/Makefile b/drivers/pci/tsm/Makefile
new file mode 100644
index 000000000000..afa775224b8d
--- /dev/null
+++ b/drivers/pci/tsm/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the PCI/TSM infrastructure
+
+obj-$(CONFIG_PCI_TSM) += tsm.o
+
+tsm-y := core.o
+tsm-$(CONFIG_NET) += netlink.o
+tsm-$(CONFIG_NET) += evidence.o
diff --git a/Documentation/netlink/specs/pci-tsm.yaml b/Documentation/netlink/specs/pci-tsm.yaml
new file mode 100644
index 000000000000..eb7fc03bd705
--- /dev/null
+++ b/Documentation/netlink/specs/pci-tsm.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+---
+name: pci-tsm
+protocol: genetlink
+uapi-header: linux/pci-tsm-netlink.h
+doc: PCI TSM Evidence retrieval over generic netlink
+
+definitions:
+  -
+    type: const
+    name: max-object-size
+    value: 0x01000000
+  -
+    type: const
+    name: max-nonce-size
+    value: 256
+  -
+    type: const
+    name: max-obj-type
+    value: 4
+  -
+    name: evidence-type
+    type: enum
+    doc: PCI device security evidence objects
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
+        doc: SPDM transcript of version, capabilities, and algorithms negotiation
+      -
+        name: measurements
+        doc: SPDM GET_MEASUREMENTS response
+      -
+        name: report
+        doc: TDISP GET_DEVICE_INTERFACE_REPORT response
+
+    render-max: true
+  -
+    name: evidence-type-flag
+    type: flags
+    doc: PCI device security evidence request flags
+    render-max: true
+    # NOTE! these values must match the name and order of evidence-type
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
+    name: evidence-flag
+    type: flags
+    render-max: true
+    doc: Flags to control evidence retrieval
+    entries:
+      -
+        name: digest
+        doc: Request the TSM's private digest of an evidence object
+
+attribute-sets:
+  -
+    name: evidence-object
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
+        doc: evidence modifier flags like 'request TSM digest'
+      -
+        name: dev-name
+        type: string
+        doc: PCI device name
+      -
+        name: nonce
+        type: binary
+        checks:
+          max-len: max-nonce-size
+      -
+        name: val
+        type: binary
+        checks:
+          max-len: max-obj-size
+
+operations:
+  list:
+    -
+      name: evidence-read
+      doc: Read the PCI TSM objects of a given type mask
+      attribute-set: evidence-object
+      flags: [admin-perm]
+      dump:
+        pre: pci-tsm-nl-evidence-read-pre
+        post: pci-tsm-nl-evidence-read-post
+        request:
+          attributes:
+            - type-mask
+            - flags
+            - dev-name
+            - nonce
+        reply:
+          attributes:
+            - type
+            - val
diff --git a/drivers/pci/tsm/netlink.h b/drivers/pci/tsm/netlink.h
new file mode 100644
index 000000000000..34f3fb6ba2b7
--- /dev/null
+++ b/drivers/pci/tsm/netlink.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/pci-tsm.yaml */
+/* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _LINUX_PCI_TSM_GEN_H
+#define _LINUX_PCI_TSM_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/pci-tsm-netlink.h>
+
+int pci_tsm_nl_evidence_read_pre(struct netlink_callback *cb);
+int pci_tsm_nl_evidence_read_post(struct netlink_callback *cb);
+
+int pci_tsm_nl_evidence_read_dumpit(struct sk_buff *skb,
+				    struct netlink_callback *cb);
+
+extern struct genl_family pci_tsm_nl_family;
+
+#endif /* _LINUX_PCI_TSM_GEN_H */
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 176d214cd0da..b70b4c0457c4 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -3,7 +3,10 @@
 #define __PCI_TSM_H
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/rwsem.h>
 #include <linux/sockptr.h>
+#include <uapi/linux/hash_info.h>
+#include <uapi/linux/pci-tsm-netlink.h>
 
 struct pci_tsm;
 struct tsm_dev;
@@ -79,6 +82,11 @@ struct pci_tsm_ops {
 		void (*unlock)(struct pci_tsm *tsm);
 		int (*accept)(struct pci_dev *pdev);
 	);
+
+	int (*refresh_evidence)(struct pci_tsm *tsm,
+				enum pci_tsm_evidence_type type,
+				unsigned long flags, void *nonce,
+				size_t nonce_len);
 };
 
 /**
@@ -93,6 +101,52 @@ struct pci_tdi {
 	u32 tdi_id;
 };
 
+/**
+ * struct pci_tsm_evidence_object - General PCI/TSM blob descriptor
+ * @data: pointer to the evidence data blob
+ * @len: length of the evidence data blob
+ * @digest: TSM expected digest of the data blob
+ *
+ * There are multiple population and verification models for these blobs
+ * depending on TSM policy. Some examples:
+ * 1/ Host (link) TSM: populates certs and provides a device signed measurement
+ *    transcript PCI_TSM_EVIDENCE_TYPE_MEASUREMENTS
+ * 2/ Guest (devsec) TSM: receives untrusted blobs via guest-to-host shared
+ *    memory protocol and then requests digests of the same via guest-to-host
+ *    encrypted protocol.
+ * The expectation is that all of these blobs are received in an SPDM session
+ * with a signed transcript, however not all TSMs provide the full transcript of
+ * these objects' retrieval and instead require asking the TSM for cached
+ * digests of the blobs over trusted TSM channels.
+ */
+struct pci_tsm_evidence_object {
+	void *data;
+	size_t len;
+	void *digest;
+};
+
+/**
+ * struct pci_tsm_evidence - Retrieved evidence for SPDM session GET commands
+ * @slot: certificate slot used by a link TSM for connect.
+ * @generation: refresh_evidence() invocation detection
+ * @digest_algo: payload size of PCI_TSM_EVIDENCE_FLAG_DIGEST requests
+ * @lock: synchronize dumps vs refresh_evidence()
+ * @obj: array of evidence objects a TSM might populate
+ *
+ * Note @slot selection not applicable for devsec TSMs. By the time the guest is
+ * retrieving the device's certificates the choice of slot was long since
+ * decided by the corresponding link TSM.
+ *
+ * An increment of @generation causes in flight dumps to fail with -EAGAIN.
+ */
+struct pci_tsm_evidence {
+	int slot;
+	int generation;
+	enum hash_algo digest_algo;
+	struct rw_semaphore lock;
+	struct pci_tsm_evidence_object obj[PCI_TSM_EVIDENCE_TYPE_MAX + 1];
+};
+
 /**
  * struct pci_tsm - Core TSM context for a given PCIe endpoint
  * @pdev: Back ref to device function, distinguishes type of pci_tsm context
@@ -100,6 +154,8 @@ struct pci_tdi {
  * @tsm_dev: PCI TEE Security Manager device for Link Confidentiality or Device
  *	     Function Security operations
  * @tdi: TDI context established by the @bind link operation
+ * @evidence: cached evidence from SPDM session establishment (connect), or
+ *	      TDISP bind (lock)
  *
  * This structure is wrapped by low level TSM driver data and returned by
  * probe()/lock(), it is freed by the corresponding remove()/unlock().
@@ -123,6 +179,7 @@ struct pci_tsm {
 	struct pci_dev *dsm_dev;
 	struct tsm_dev *tsm_dev;
 	struct pci_tdi *tdi;
+	struct pci_tsm_evidence evidence;
 };
 
 /**
@@ -238,6 +295,8 @@ ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
 			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
 			  size_t out_len, u64 *tsm_code);
 struct pci_tsm_devsec *to_pci_tsm_devsec(struct pci_tsm *tsm);
+void pci_tsm_init_evidence(struct pci_tsm_evidence *evidence, int slot,
+			   enum hash_algo digest_algo);
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
@@ -262,4 +321,8 @@ static inline ssize_t pci_tsm_guest_req(struct pci_dev *pdev,
 	return -ENXIO;
 }
 #endif
+
+/* private: */
+extern struct rw_semaphore pci_tsm_rwsem;
+
 #endif /*__PCI_TSM_H */
diff --git a/include/uapi/linux/pci-tsm-netlink.h b/include/uapi/linux/pci-tsm-netlink.h
new file mode 100644
index 000000000000..a0e8b044e1b8
--- /dev/null
+++ b/include/uapi/linux/pci-tsm-netlink.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/pci-tsm.yaml */
+/* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _UAPI_LINUX_PCI_TSM_NETLINK_H
+#define _UAPI_LINUX_PCI_TSM_NETLINK_H
+
+#define PCI_TSM_FAMILY_NAME	"pci-tsm"
+#define PCI_TSM_FAMILY_VERSION	1
+
+#define PCI_TSM_MAX_OBJECT_SIZE	16777216
+#define PCI_TSM_MAX_NONCE_SIZE	256
+#define PCI_TSM_MAX_OBJ_TYPE	4
+
+/**
+ * enum pci_tsm_evidence_type - PCI device security evidence objects
+ * @PCI_TSM_EVIDENCE_TYPE_CERT0: SPDM certificate chain from device slot0
+ * @PCI_TSM_EVIDENCE_TYPE_CERT1: SPDM certificate chain from device slot1
+ * @PCI_TSM_EVIDENCE_TYPE_CERT2: SPDM certificate chain from device slot2
+ * @PCI_TSM_EVIDENCE_TYPE_CERT3: SPDM certificate chain from device slot3
+ * @PCI_TSM_EVIDENCE_TYPE_CERT4: SPDM certificate chain from device slot4
+ * @PCI_TSM_EVIDENCE_TYPE_CERT5: SPDM certificate chain from device slot5
+ * @PCI_TSM_EVIDENCE_TYPE_CERT6: SPDM certificate chain from device slot6
+ * @PCI_TSM_EVIDENCE_TYPE_CERT7: SPDM certificate chain from device slot7
+ * @PCI_TSM_EVIDENCE_TYPE_VCA: SPDM transcript of version, capabilities, and
+ *   algorithms negotiation
+ * @PCI_TSM_EVIDENCE_TYPE_MEASUREMENTS: SPDM GET_MEASUREMENTS response
+ * @PCI_TSM_EVIDENCE_TYPE_REPORT: TDISP GET_DEVICE_INTERFACE_REPORT response
+ */
+enum pci_tsm_evidence_type {
+	PCI_TSM_EVIDENCE_TYPE_CERT0,
+	PCI_TSM_EVIDENCE_TYPE_CERT1,
+	PCI_TSM_EVIDENCE_TYPE_CERT2,
+	PCI_TSM_EVIDENCE_TYPE_CERT3,
+	PCI_TSM_EVIDENCE_TYPE_CERT4,
+	PCI_TSM_EVIDENCE_TYPE_CERT5,
+	PCI_TSM_EVIDENCE_TYPE_CERT6,
+	PCI_TSM_EVIDENCE_TYPE_CERT7,
+	PCI_TSM_EVIDENCE_TYPE_VCA,
+	PCI_TSM_EVIDENCE_TYPE_MEASUREMENTS,
+	PCI_TSM_EVIDENCE_TYPE_REPORT,
+
+	/* private: */
+	__PCI_TSM_EVIDENCE_TYPE_MAX,
+	PCI_TSM_EVIDENCE_TYPE_MAX = (__PCI_TSM_EVIDENCE_TYPE_MAX - 1)
+};
+
+/*
+ * PCI device security evidence request flags
+ */
+enum pci_tsm_evidence_type_flag {
+	PCI_TSM_EVIDENCE_TYPE_FLAG_CERT0 = 1,
+	PCI_TSM_EVIDENCE_TYPE_FLAG_CERT1 = 2,
+	PCI_TSM_EVIDENCE_TYPE_FLAG_CERT2 = 4,
+	PCI_TSM_EVIDENCE_TYPE_FLAG_CERT3 = 8,
+	PCI_TSM_EVIDENCE_TYPE_FLAG_CERT4 = 16,
+	PCI_TSM_EVIDENCE_TYPE_FLAG_CERT5 = 32,
+	PCI_TSM_EVIDENCE_TYPE_FLAG_CERT6 = 64,
+	PCI_TSM_EVIDENCE_TYPE_FLAG_CERT7 = 128,
+	PCI_TSM_EVIDENCE_TYPE_FLAG_VCA = 256,
+	PCI_TSM_EVIDENCE_TYPE_FLAG_MEASUREMENTS = 512,
+	PCI_TSM_EVIDENCE_TYPE_FLAG_REPORT = 1024,
+
+	/* private: */
+	PCI_TSM_EVIDENCE_TYPE_FLAG_MASK = 2047,
+};
+
+/**
+ * enum pci_tsm_evidence_flag - Flags to control evidence retrieval
+ * @PCI_TSM_EVIDENCE_FLAG_DIGEST: Request the TSM's private digest of an
+ *   evidence object
+ */
+enum pci_tsm_evidence_flag {
+	PCI_TSM_EVIDENCE_FLAG_DIGEST = 1,
+
+	/* private: */
+	PCI_TSM_EVIDENCE_FLAG_MASK = 1,
+};
+
+enum {
+	PCI_TSM_A_EVIDENCE_OBJECT_TYPE = 1,
+	PCI_TSM_A_EVIDENCE_OBJECT_TYPE_MASK,
+	PCI_TSM_A_EVIDENCE_OBJECT_FLAGS,
+	PCI_TSM_A_EVIDENCE_OBJECT_DEV_NAME,
+	PCI_TSM_A_EVIDENCE_OBJECT_NONCE,
+	PCI_TSM_A_EVIDENCE_OBJECT_VAL,
+
+	__PCI_TSM_A_EVIDENCE_OBJECT_MAX,
+	PCI_TSM_A_EVIDENCE_OBJECT_MAX = (__PCI_TSM_A_EVIDENCE_OBJECT_MAX - 1)
+};
+
+enum {
+	PCI_TSM_CMD_EVIDENCE_READ = 1,
+
+	__PCI_TSM_CMD_MAX,
+	PCI_TSM_CMD_MAX = (__PCI_TSM_CMD_MAX - 1)
+};
+
+#endif /* _UAPI_LINUX_PCI_TSM_NETLINK_H */
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm/core.c
similarity index 98%
rename from drivers/pci/tsm.c
rename to drivers/pci/tsm/core.c
index aa93a59d2720..039733fd19b1 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm/core.c
@@ -3,7 +3,7 @@
  * Interface with platform TEE Security Manager (TSM) objects as defined by
  * PCIe r7.0 section 11 TEE Device Interface Security Protocol (TDISP)
  *
- * Copyright(c) 2024-2025 Intel Corporation. All rights reserved.
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 
 #define dev_fmt(fmt) "PCI/TSM: " fmt
@@ -16,13 +16,13 @@
 #include <linux/sysfs.h>
 #include <linux/tsm.h>
 #include <linux/xarray.h>
-#include "pci.h"
+#include "../pci.h"
 
 /*
  * Provide a read/write lock against the init / exit of pdev tsm
  * capabilities and arrival/departure of a TSM instance
  */
-static DECLARE_RWSEM(pci_tsm_rwsem);
+DECLARE_RWSEM(pci_tsm_rwsem);
 
 /*
  * Count of TSMs registered that support physical link operations vs device
@@ -302,6 +302,7 @@ static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
 	rc = pci_tsm_connect(pdev, tsm_dev);
 	if (rc)
 		return rc;
+
 	return len;
 }
 static DEVICE_ATTR_RW(connect);
@@ -933,6 +934,16 @@ void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
 }
 EXPORT_SYMBOL_GPL(pci_tsm_tdi_constructor);
 
+void pci_tsm_init_evidence(struct pci_tsm_evidence *evidence, int slot,
+			   enum hash_algo digest_algo)
+{
+	evidence->slot = slot;
+	evidence->generation = 1;
+	evidence->digest_algo = digest_algo;
+	init_rwsem(&evidence->lock);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_init_evidence);
+
 /**
  * pci_tsm_link_constructor() - base 'struct pci_tsm' initialization for link TSMs
  * @pdev: The PCI device
diff --git a/drivers/pci/tsm/evidence.c b/drivers/pci/tsm/evidence.c
new file mode 100644
index 000000000000..4d475b3dd6f6
--- /dev/null
+++ b/drivers/pci/tsm/evidence.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2026 Intel Corporation */
+
+#include <crypto/hash_info.h>
+#include <linux/bitfield.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netlink.h>
+#include <linux/pci.h>
+#include <linux/pci-tsm.h>
+#include <linux/slab.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
+
+#include "netlink.h"
+
+struct pci_tsm_evidence_ctx {
+	struct pci_dev *pdev;
+	unsigned long type_mask;
+	unsigned long flags;
+	void *nonce;
+	int generation;
+	int type;
+	u32 offset;
+	u16 nonce_len;
+};
+
+#define PCI_TSM_EVIDENCE_START U32_MAX
+#define PCI_TSM_EVIDENCE_OBJECT_START (U32_MAX - 1)
+int pci_tsm_nl_evidence_read_pre(struct netlink_callback *cb)
+{
+	struct pci_tsm_evidence_ctx *ctx = (struct pci_tsm_evidence_ctx *)cb->ctx;
+	const struct genl_info *info = genl_info_dump(cb);
+	unsigned long type_mask_unknown;
+	struct nlattr *attr;
+	struct device *dev;
+	char name[32];
+
+	NL_ASSERT_CTX_FITS(struct pci_tsm_evidence_ctx);
+
+	if (GENL_REQ_ATTR_CHECK(info, PCI_TSM_A_EVIDENCE_OBJECT_TYPE_MASK)) {
+		NL_SET_ERR_MSG(info->extack, "missing object request mask");
+		return -EINVAL;
+	}
+
+	attr = info->attrs[PCI_TSM_A_EVIDENCE_OBJECT_TYPE_MASK];
+	ctx->type_mask = nla_get_u32(attr);
+	type_mask_unknown = ctx->type_mask & ~PCI_TSM_EVIDENCE_TYPE_FLAG_MASK;
+	if (type_mask_unknown) {
+		NL_SET_ERR_MSG_FMT(info->extack,
+				   "unsupported object request %#lx",
+				   type_mask_unknown);
+		return -EINVAL;
+	}
+
+	attr = info->attrs[PCI_TSM_A_EVIDENCE_OBJECT_FLAGS];
+	if (attr) {
+		ctx->flags = nla_get_u32(attr);
+		if (ctx->flags & ~PCI_TSM_EVIDENCE_FLAG_MASK) {
+			NL_SET_BAD_ATTR(info->extack, attr);
+			return -EINVAL;
+		}
+	}
+
+	if (GENL_REQ_ATTR_CHECK(info, PCI_TSM_A_EVIDENCE_OBJECT_DEV_NAME)) {
+		NL_SET_ERR_MSG(info->extack, "missing device name");
+		return -EINVAL;
+	}
+
+	attr = info->attrs[PCI_TSM_A_EVIDENCE_OBJECT_DEV_NAME];
+	if (nla_strscpy(name, attr, sizeof(name)) < 0) {
+		NL_SET_BAD_ATTR(info->extack, attr);
+		return -EINVAL;
+	}
+
+	dev = bus_find_device_by_name(&pci_bus_type, NULL, name);
+	if (!dev) {
+		NL_SET_ERR_MSG_FMT(info->extack, "device '%s' not found", name);
+		return -ENODEV;
+	}
+	ctx->pdev = to_pci_dev(dev);
+
+	ctx->type =
+		find_first_bit(&ctx->type_mask, PCI_TSM_EVIDENCE_TYPE_MAX + 1);
+	if (ctx->type > PCI_TSM_EVIDENCE_TYPE_MAX) {
+		NL_SET_ERR_MSG(info->extack, "no evidence type requested");
+		return -EINVAL;
+	}
+	ctx->offset = PCI_TSM_EVIDENCE_START;
+
+	return 0;
+}
+
+int pci_tsm_nl_evidence_read_post(struct netlink_callback *cb)
+{
+	struct pci_tsm_evidence_ctx *ctx =
+		(struct pci_tsm_evidence_ctx *)cb->ctx;
+
+	pci_dev_put(ctx->pdev);
+	return 0;
+}
+
+static size_t evidence_len(struct pci_tsm_evidence *evidence,
+			   struct pci_tsm_evidence_object *obj,
+			   unsigned long flags)
+{
+	if (flags & PCI_TSM_EVIDENCE_FLAG_DIGEST) {
+		if (obj->digest)
+			return hash_digest_size[evidence->digest_algo];
+		return 0;
+	}
+	return obj->len;
+}
+
+static void *evidence_data(struct pci_tsm_evidence_object *obj,
+			   unsigned long flags)
+{
+	if (flags & PCI_TSM_EVIDENCE_FLAG_DIGEST)
+		return obj->digest;
+	return obj->data;
+}
+
+static int __pci_tsm_evidence_read(struct sk_buff *skb,
+				   struct netlink_callback *cb)
+{
+	struct pci_tsm_evidence_ctx *ctx =
+		(struct pci_tsm_evidence_ctx *)cb->ctx;
+	struct pci_dev *pdev = ctx->pdev;
+	struct pci_tsm_evidence *evidence = &pdev->tsm->evidence;
+	struct pci_tsm_evidence_object *obj = &evidence->obj[ctx->type];
+	size_t object_len = evidence_len(evidence, obj, ctx->flags);
+	void *object_data = evidence_data(obj, ctx->flags);
+	size_t available, overhead, len;
+	void *hdr;
+	int rc;
+
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &pci_tsm_nl_family, NLM_F_MULTI,
+			  PCI_TSM_CMD_EVIDENCE_READ);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (ctx->offset == PCI_TSM_EVIDENCE_OBJECT_START) {
+		rc = nla_put_u32(skb, PCI_TSM_A_EVIDENCE_OBJECT_TYPE,
+				 ctx->type);
+		if (rc)
+			goto out_cancel;
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
+	rc = nla_put(skb, PCI_TSM_A_EVIDENCE_OBJECT_VAL, len,
+		     object_data + ctx->offset);
+	if (rc)
+		goto out_end;
+
+	ctx->offset += len;
+	if (ctx->offset < object_len) {
+		rc = 1;
+		goto out_end;
+	}
+
+	ctx->type = find_next_bit(&ctx->type_mask,
+				  PCI_TSM_EVIDENCE_TYPE_MAX + 1, ctx->type + 1);
+	/* no more evidence types requested */
+	if (ctx->type > PCI_TSM_EVIDENCE_TYPE_MAX) {
+		rc = 0;
+		goto out_end;
+	}
+	ctx->offset = PCI_TSM_EVIDENCE_OBJECT_START;
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
+	return rc;
+}
+
+static int pci_tsm_evidence_read(struct sk_buff *skb,
+				 struct netlink_callback *cb)
+{
+	struct pci_tsm_evidence_ctx *ctx =
+		(struct pci_tsm_evidence_ctx *)cb->ctx;
+	const struct genl_info *info = genl_info_dump(cb);
+	struct pci_tsm_evidence *evidence;
+	struct pci_dev *pdev = ctx->pdev;
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, tsm_lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &tsm_lock))) {
+		NL_SET_ERR_MSG(info->extack,
+			       "interrupted acquiring TSM context");
+		return rc;
+	}
+
+	if (!pdev->tsm) {
+		NL_SET_ERR_MSG(info->extack, "no TSM context");
+		return -ENXIO;
+	}
+
+	evidence = &pdev->tsm->evidence;
+	ACQUIRE(rwsem_read_intr, evidence_lock)(&evidence->lock);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &evidence_lock))) {
+		NL_SET_ERR_MSG(info->extack, "interrupted acquiring evidence");
+		return rc;
+	}
+
+	/* generation is only valid when non-zero */
+	if (ctx->offset == PCI_TSM_EVIDENCE_START) {
+		if (!evidence->generation) {
+			NL_SET_ERR_MSG(info->extack, "no evidence available");
+			return -ENXIO;
+		}
+		ctx->generation = evidence->generation;
+		ctx->offset = PCI_TSM_EVIDENCE_OBJECT_START;
+	}
+
+	if (ctx->generation != evidence->generation) {
+		NL_SET_ERR_MSG(info->extack, "evidence updated during read");
+		return -EAGAIN;
+	}
+
+	return __pci_tsm_evidence_read(skb, cb);
+}
+
+static int pci_tsm_evidence_refresh(struct pci_tsm_evidence_ctx *ctx)
+{
+	return -EOPNOTSUPP;
+}
+
+int pci_tsm_nl_evidence_read_dumpit(struct sk_buff *skb,
+				    struct netlink_callback *cb)
+{
+	struct pci_tsm_evidence_ctx *ctx =
+		(struct pci_tsm_evidence_ctx *)cb->ctx;
+	const struct genl_info *info = genl_info_dump(cb);
+
+	/* Attempt one refresh per dump request before reading */
+	if (ctx->offset == PCI_TSM_EVIDENCE_START && ctx->nonce) {
+		int rc = pci_tsm_evidence_refresh(ctx);
+
+		if (rc) {
+			NL_SET_ERR_MSG_FMT(info->extack,
+					   "evidence refresh failed: %d", rc);
+			return rc;
+		}
+		ctx->nonce = NULL;
+	}
+	return pci_tsm_evidence_read(skb, cb);
+}
+
+static int __init pci_tsm_nl_init(void)
+{
+	return genl_register_family(&pci_tsm_nl_family);
+}
+
+subsys_initcall(pci_tsm_nl_init);
diff --git a/drivers/pci/tsm/netlink.c b/drivers/pci/tsm/netlink.c
new file mode 100644
index 000000000000..26fadb727666
--- /dev/null
+++ b/drivers/pci/tsm/netlink.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/pci-tsm.yaml */
+/* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "netlink.h"
+
+#include <uapi/linux/pci-tsm-netlink.h>
+
+/* PCI_TSM_CMD_EVIDENCE_READ - dump */
+static const struct nla_policy pci_tsm_evidence_read_nl_policy[PCI_TSM_A_EVIDENCE_OBJECT_NONCE + 1] = {
+	[PCI_TSM_A_EVIDENCE_OBJECT_TYPE_MASK] = { .type = NLA_U32, },
+	[PCI_TSM_A_EVIDENCE_OBJECT_FLAGS] = { .type = NLA_U32, },
+	[PCI_TSM_A_EVIDENCE_OBJECT_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[PCI_TSM_A_EVIDENCE_OBJECT_NONCE] = NLA_POLICY_MAX_LEN(PCI_TSM_MAX_NONCE_SIZE),
+};
+
+/* Ops table for pci_tsm */
+static const struct genl_split_ops pci_tsm_nl_ops[] = {
+	{
+		.cmd		= PCI_TSM_CMD_EVIDENCE_READ,
+		.start		= pci_tsm_nl_evidence_read_pre,
+		.dumpit		= pci_tsm_nl_evidence_read_dumpit,
+		.done		= pci_tsm_nl_evidence_read_post,
+		.policy		= pci_tsm_evidence_read_nl_policy,
+		.maxattr	= PCI_TSM_A_EVIDENCE_OBJECT_NONCE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
+};
+
+struct genl_family pci_tsm_nl_family __ro_after_init = {
+	.name		= PCI_TSM_FAMILY_NAME,
+	.version	= PCI_TSM_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= pci_tsm_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(pci_tsm_nl_ops),
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index da9dbc1a4019..3d5e2cbef71e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26534,9 +26534,11 @@ S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm-report
 F:	Documentation/driver-api/coco/
 F:	Documentation/driver-api/pci/tsm.rst
-F:	drivers/pci/tsm.c
+F:	Documentation/netlink/specs/pci-tsm.yaml
+F:	drivers/pci/tsm/
 F:	drivers/virt/coco/guest/
 F:	include/linux/*tsm*.h
+F:	include/uapi/linux/pci-tsm-netlink.h
 F:	samples/tsm-mr/
 
 TRUSTED SERVICES TEE DRIVER
-- 
2.52.0

