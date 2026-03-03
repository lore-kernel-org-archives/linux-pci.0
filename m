Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C048135F5EC
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496070; cv=none; b=n2iDmXBrJj8oqlHWKJ0KX/PvslfGJBuMhrS6OaLBqTIlQd8LxQ+aYpx+5KOn4ITYCZStVRr87RQn7G35WTLjZwcF+/QcQO8Hte0ULrWKqu2m/4dmLF7tzSBOjKJBFmQclGS4BAaqug23rS6nnslEdE0LhkABnvvD/CQM4c6t2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496070; c=relaxed/simple;
	bh=z6Dn+57KRgM7GH6TOtVPML7D0q4RCM/SoI7H/B8kLRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAkxl2GdtC2fm4Y9p5/Zwd8Ch4X+KXJab1OjQbmVeeZn/0p7p4qKtkVuXp/TU3BjfIsH4hzJnVu1C8INJruHa36YSUkrJ/r6SbUEn6vfEYJ10D1szKuEGxzSdboInpHVuShPPePGme6aebbI2bymEXqzBg5ad+U0bUQx1YwBHLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LO30PJ15; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LO30PJ15"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496069; x=1804032069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z6Dn+57KRgM7GH6TOtVPML7D0q4RCM/SoI7H/B8kLRM=;
  b=LO30PJ15Qmd4LvhhOe+bLOMo6z+n0HN8Z8PccsbSP3oec3/hdbhNkCtZ
   adApiLlb9DHuklXt8NFHHsn/MgqOMQ96ey8zuCx2+CEBGonO4Kd9p62OQ
   Ys9kHweAg/4LOrXJsxTuyW3Vk0NdshnmdjPRChDPyQauncidksXllsiAG
   6LPDmAXFQpWKsn9eNZnfvRMr2vXblecdroVv0ZGXbG1xkeInZ/N1NsiV3
   BBY43VZN9oIC8aFsl2rWV177NlsNvvL5YRF54CIn35LlOFu4l/EG3NsT6
   XtezUDQS3SmVSs9XxkirT29cgvtbuwH5PCzrDs176t/2TYktgEqHEy11s
   A==;
X-CSE-ConnectionGUID: yxRtbwgpTbS1rao3QfFGSQ==
X-CSE-MsgGUID: D2KHYVt0R3ijdcjH9Isxtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73483058"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73483058"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:01:01 -0800
X-CSE-ConnectionGUID: +DriW8VBRcC1dW6bFg4LHA==
X-CSE-MsgGUID: kgwkpqOVQJqDwcmAK9sYyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967136"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 16:01:00 -0800
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
	jgg@nvidia.com
Subject: [PATCH v2 18/19] samples/devsec: Add evidence support
Date: Mon,  2 Mar 2026 16:02:06 -0800
Message-ID: <20260303000207.1836586-19-dan.j.williams@intel.com>
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

For testing purposes add "certs" and "transcript" attributes to the devsec
faux devices. Both the link_tsm and devsec_tsm reference the same shared
data. The flow is:

- generate cert chain
- sign simulated evidence
- write blobs to "certs" and "transcript"
- trigger tsm/connect or tsm/lock to consume that evidence

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 samples/devsec/devsec.h   |   5 ++
 samples/devsec/common.c   | 134 +++++++++++++++++++++++++++++++++++++-
 samples/devsec/link_tsm.c |  21 +++++-
 samples/devsec/tsm.c      |   9 ++-
 4 files changed, 166 insertions(+), 3 deletions(-)

diff --git a/samples/devsec/devsec.h b/samples/devsec/devsec.h
index e0ea9c6bb5e9..a89ce587cb3b 100644
--- a/samples/devsec/devsec.h
+++ b/samples/devsec/devsec.h
@@ -40,4 +40,9 @@ static inline int devsec_get_domain_nr(struct devsec_sysdata *sd)
 }
 #endif
 extern struct devsec_sysdata *devsec_sysdata[NR_DEVSEC_HOST_BRIDGES];
+extern const struct attribute_group devsec_evidence_group;
+void devsec_evidence_busy(void);
+void devsec_evidence_idle(void);
+struct pci_tsm_evidence;
+void devsec_init_evidence(struct pci_tsm_evidence *evidence);
 #endif /* __DEVSEC_H__ */
diff --git a/samples/devsec/common.c b/samples/devsec/common.c
index d0e8648dfe98..5dc4152e8b99 100644
--- a/samples/devsec/common.c
+++ b/samples/devsec/common.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2024 - 2026 Intel Corporation */
 
-#include <linux/pci.h>
 #include <linux/export.h>
+#include <linux/pci.h>
+#include <linux/pci-tsm.h>
+#include <linux/vmalloc.h>
+#include <uapi/linux/pci-tsm-netlink.h>
 
 #include "devsec.h"
 
@@ -13,14 +16,143 @@
 struct devsec_sysdata *devsec_sysdata[NR_DEVSEC_HOST_BRIDGES];
 EXPORT_SYMBOL_FOR_MODULES(devsec_sysdata, "devsec*");
 
+static struct {
+	void *certs;
+	size_t certs_size;
+	void *transcript;
+	size_t transcript_size;
+	int busy;
+	struct mutex lock;
+} devsec_evidence;
+
+void devsec_init_evidence(struct pci_tsm_evidence *evidence)
+{
+	struct pci_tsm_evidence_object *obj;
+
+	obj = &evidence->obj[PCI_TSM_EVIDENCE_TYPE_CERT0];
+	obj->data = devsec_evidence.certs;
+	obj->len = devsec_evidence.certs_size;
+
+	obj = &evidence->obj[PCI_TSM_EVIDENCE_TYPE_MEASUREMENTS];
+	obj->data = devsec_evidence.transcript;
+	obj->len = devsec_evidence.transcript_size;
+}
+EXPORT_SYMBOL_FOR_MODULES(devsec_init_evidence, "devsec*");
+
+static ssize_t certs_read(struct file *file, struct kobject *kobj,
+			  const struct bin_attribute *bin_attr, char *buf,
+			  loff_t off, size_t count)
+{
+	guard(mutex)(&devsec_evidence.lock);
+	return memory_read_from_buffer(buf, count, &off, devsec_evidence.certs,
+				       devsec_evidence.certs_size);
+}
+
+#define EVIDENCE_MAX_SIZE SZ_16M
+
+static ssize_t evidence_write(char *buf, loff_t off, size_t count, void **data,
+			      size_t *data_size)
+{
+	loff_t in_off = 0;
+
+	if (off + count > EVIDENCE_MAX_SIZE)
+		return -EFBIG;
+
+	guard(mutex)(&devsec_evidence.lock);
+	if (devsec_evidence.busy)
+		return -EBUSY;
+	if (off + count > *data_size) {
+		void *new_data = kvrealloc(*data, off + count, GFP_KERNEL);
+
+		if (!new_data)
+			return -ENOMEM;
+		*data = new_data;
+		*data_size = off + count;
+	}
+
+	/* reset the buffer on a single byte write */
+	if (off + count == 1) {
+		kvfree(*data);
+		*data = NULL;
+		*data_size = 0;
+		return 1;
+	}
+
+	return memory_read_from_buffer(*data + off, count, &in_off, buf, count);
+}
+
+static ssize_t certs_write(struct file *file, struct kobject *kobj,
+			   const struct bin_attribute *bin_attr, char *buf,
+			   loff_t off, size_t count)
+{
+	return evidence_write(buf, off, count, &devsec_evidence.certs,
+			      &devsec_evidence.certs_size);
+}
+
+static ssize_t transcript_read(struct file *file, struct kobject *kobj,
+			       const struct bin_attribute *bin_attr, char *buf,
+			       loff_t off, size_t count)
+{
+	guard(mutex)(&devsec_evidence.lock);
+	return memory_read_from_buffer(buf, count, &off,
+				       devsec_evidence.transcript,
+				       devsec_evidence.transcript_size);
+}
+
+static ssize_t transcript_write(struct file *file, struct kobject *kobj,
+				const struct bin_attribute *bin_attr, char *buf,
+				loff_t off, size_t count)
+{
+	return evidence_write(buf, off, count, &devsec_evidence.transcript,
+			      &devsec_evidence.transcript_size);
+}
+
+static const BIN_ATTR_RW(certs, 0);
+static const BIN_ATTR_RW(transcript, 0);
+
+static const struct bin_attribute *devsec_evidence_attrs[] = {
+	&bin_attr_certs,
+	&bin_attr_transcript,
+	NULL,
+};
+
+/*
+ * Prevent evidence from changing while any sample device is connected or locked
+ */
+void devsec_evidence_busy(void)
+{
+	guard(mutex)(&devsec_evidence.lock);
+	devsec_evidence.busy++;
+}
+EXPORT_SYMBOL_FOR_MODULES(devsec_evidence_busy, "devsec*");
+
+void devsec_evidence_idle(void)
+{
+	guard(mutex)(&devsec_evidence.lock);
+	if (devsec_evidence.busy-- <= 0) {
+		WARN_ON_ONCE(1);
+		devsec_evidence.busy = 0;
+	}
+}
+EXPORT_SYMBOL_FOR_MODULES(devsec_evidence_idle, "devsec*");
+
+const struct attribute_group devsec_evidence_group = {
+	.bin_attrs = devsec_evidence_attrs,
+};
+EXPORT_SYMBOL_FOR_MODULES(devsec_evidence_group, "devsec*");
+
 static int __init common_init(void)
 {
+	mutex_init(&devsec_evidence.lock);
 	return 0;
 }
 module_init(common_init);
 
 static void __exit common_exit(void)
 {
+	kvfree(devsec_evidence.certs);
+	kvfree(devsec_evidence.transcript);
+	mutex_destroy(&devsec_evidence.lock);
 }
 module_exit(common_exit);
 
diff --git a/samples/devsec/link_tsm.c b/samples/devsec/link_tsm.c
index 2e4c1234bdee..21b6c3c7ea52 100644
--- a/samples/devsec/link_tsm.c
+++ b/samples/devsec/link_tsm.c
@@ -3,6 +3,7 @@
 
 #define dev_fmt(fmt) "devsec: " fmt
 #include <linux/device/faux.h>
+#include <crypto/hash_info.h>
 #include <linux/pci-tsm.h>
 #include <linux/pci-ide.h>
 #include <linux/module.h>
@@ -51,6 +52,8 @@ static struct device *pci_tsm_host(struct pci_dev *pdev)
 static struct pci_tsm *devsec_tsm_pf0_probe(struct tsm_dev *tsm_dev,
 					    struct pci_dev *pdev)
 {
+	struct pci_tsm_evidence *evidence;
+	struct pci_tsm *tsm;
 	int rc;
 
 	dev_dbg(tsm_dev->dev.parent, "%s\n", pci_name(pdev));
@@ -60,10 +63,16 @@ static struct pci_tsm *devsec_tsm_pf0_probe(struct tsm_dev *tsm_dev,
 	if (!devsec_tsm)
 		return NULL;
 
+	tsm = &devsec_tsm->pci.base_tsm;
 	rc = pci_tsm_pf0_constructor(pdev, &devsec_tsm->pci, tsm_dev);
 	if (rc)
 		return NULL;
 
+	devsec_evidence_busy();
+	evidence = &tsm->evidence;
+	pci_tsm_init_evidence(evidence, 0, HASH_ALGO_SHA384);
+	devsec_init_evidence(evidence);
+
 	pci_dbg(pdev, "TSM enabled\n");
 	return &no_free_ptr(devsec_tsm)->pci.base_tsm;
 }
@@ -113,6 +122,7 @@ static void devsec_link_tsm_pci_remove(struct pci_tsm *tsm)
 	if (is_pci_tsm_pf0(pdev)) {
 		struct devsec_tsm_pf0 *devsec_tsm = to_devsec_tsm_pf0(tsm);
 
+		devsec_evidence_idle();
 		pci_tsm_pf0_destructor(&devsec_tsm->pci);
 		kfree(devsec_tsm);
 	} else {
@@ -390,7 +400,16 @@ static struct attribute *devsec_link_attrs[] = {
 	&dev_attr_tsm_request.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(devsec_link);
+
+static const struct attribute_group devsec_link_group = {
+	.attrs = devsec_link_attrs,
+};
+
+static const struct attribute_group *devsec_link_groups[] = {
+	&devsec_link_group,
+	&devsec_evidence_group,
+	NULL,
+};
 
 static int __init devsec_link_tsm_init(void)
 {
diff --git a/samples/devsec/tsm.c b/samples/devsec/tsm.c
index 46dbe668945a..4a62e05ecf35 100644
--- a/samples/devsec/tsm.c
+++ b/samples/devsec/tsm.c
@@ -6,6 +6,7 @@
 #include <linux/pci-tsm.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/sysfs.h>
 #include <linux/tsm.h>
 #include "devsec.h"
 
@@ -105,9 +106,15 @@ static const struct faux_device_ops devsec_device_ops = {
 	.probe = devsec_tsm_probe,
 };
 
+static const struct attribute_group *devsec_evidence_groups[] = {
+	&devsec_evidence_group,
+	NULL,
+};
+
 static int __init devsec_tsm_init(void)
 {
-	devsec_tsm = faux_device_create("devsec_tsm", NULL, &devsec_device_ops);
+	devsec_tsm = faux_device_create_with_groups(
+		"devsec_tsm", NULL, &devsec_device_ops, devsec_evidence_groups);
 	if (!devsec_tsm)
 		return -ENOMEM;
 	return 0;
-- 
2.52.0

