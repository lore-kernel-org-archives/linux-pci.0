Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAFE64
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496068; cv=none; b=NL2uU6FXfIOmnHlp8+0Q9dmkiB0xvrIPYtNXhWK1HdQgDyyakTBqGUDLF6OIHoLypeGrDYi+BAcfV3Kyhkl5CMoeQAckrJSkEulR7pTmEHn7WjgCQ9lzKVkG7U2is6+7iCWCEu3aV6a/V9iL+ZpmmdGSjy342Ia4q8h6feYe0eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496068; c=relaxed/simple;
	bh=o6x+XItsG8PXQr4PDu1m5ZLawCijg11Offkp+Bc45yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gv/PnJEFaJu65DTGbpvfwGd4X/HChafpl1upVx/2Qase3S+1M4sdzWqWroOnDrxoHJo/eFLeAAa2sMbcYCqTBo71wWNmrJUCNmSLrSyC9zWlqD01ilYQ8svJWVJ1sG07VmxJrG0JYt4aCl2i+Hscpq7sSMMxQI8uX1vg+tuYjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0IfISV2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0IfISV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496066; x=1804032066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o6x+XItsG8PXQr4PDu1m5ZLawCijg11Offkp+Bc45yc=;
  b=D0IfISV2ZAJqDsU0F/gCMddtdl2630ZDZRU9v+r2o5eYWDmV1w150pzE
   7PJP+MHxPNqEOLKPdlYSXyF2ZJoQqJUQsnWRFwJNBH2bGBgYgBQMo2yu2
   DYAkh6LE1W8J2nRgb8zxpyvVHP1FFWJsCab54XRfTd7IRfLA9K53H5pg3
   QUx6MVYeplZHmWPn/QZ2cNR5FpjEKRYZvyx3H8olHZKZfTCC//vFN1Pns
   8s7plyJBo1szFa2FP3RzOfKFdBSEienC/Xixj7wp9Hkdt49DvDXNX4L19
   wTdCCs089pEHZnO4Ynx8ApIcJZewmL5QFXtjURqnNOrMUwwGqRo0bA5BU
   w==;
X-CSE-ConnectionGUID: aeOvCVg7QweClZwIQE/76g==
X-CSE-MsgGUID: fus7nbT7QamqT3y97GCFTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73483020"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73483020"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:01:00 -0800
X-CSE-ConnectionGUID: ifeO3uWOQw6lQ8vFNbjLGA==
X-CSE-MsgGUID: CjmnG9WjT/O67lbdgeWjyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967126"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 16:00:59 -0800
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
	Samuel Ortiz <sameo@rivosinc.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 15/19] samples/devsec: Add sample TSM bind and guest_request flows
Date: Mon,  2 Mar 2026 16:02:03 -0800
Message-ID: <20260303000207.1836586-16-dan.j.williams@intel.com>
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

Provide a method to test the basic object lifetime mechanics of 'struct
pci_tdi', and passthrough sysfs message to simulate pci_tsm_guest_req().
Arrange for pci_tsm_bind() and pci_tsm_guest_req() to be invoked via
devsec_link_tsm faux-device sysfs attributes.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-faux-devsec |  15 ++
 samples/devsec/link_tsm.c                   | 157 +++++++++++++++++++-
 2 files changed, 170 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-faux-devsec

diff --git a/Documentation/ABI/testing/sysfs-faux-devsec b/Documentation/ABI/testing/sysfs-faux-devsec
new file mode 100644
index 000000000000..29da17bfa720
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-faux-devsec
@@ -0,0 +1,15 @@
+What:		/sys/bus/faux/devices/{devsec_link_tsm,devsec_tsm}
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(DIR) The devsec_link_tsm and devsec_tsm faux devices test the
+		kernel's ABIs and flows that support PCIe Trusted Device
+		Interface Security Protocol (TDISP). The devsec_link_tsm device
+		simulates a "host" TSM that establishes an SPDM session and link
+		security (PCIe IDE). The devsec_tsm device simulates a "guest"
+		TSM that implements the lock+accept flows.
+
+What:
+/sys/bus/faux/devices/devsec_link_tsm/{bind,unbind}
+Contact:	linux-coco@lists.linux.dev
+Description:
+
diff --git a/samples/devsec/link_tsm.c b/samples/devsec/link_tsm.c
index dea5215ff97b..2e4c1234bdee 100644
--- a/samples/devsec/link_tsm.c
+++ b/samples/devsec/link_tsm.c
@@ -19,6 +19,10 @@ struct devsec_tsm_fn {
 	struct pci_tsm pci;
 };
 
+struct devsec_tsm_tdi {
+	struct pci_tdi pci;
+};
+
 static struct devsec_tsm_pf0 *to_devsec_tsm_pf0(struct pci_tsm *tsm)
 {
 	return container_of(tsm, struct devsec_tsm_pf0, pci.base_tsm);
@@ -29,6 +33,12 @@ static struct devsec_tsm_fn *to_devsec_tsm_fn(struct pci_tsm *tsm)
 	return container_of(tsm, struct devsec_tsm_fn, pci);
 }
 
+/*
+ * Note that outside of pci_tsm_ops callbacks, this lookup is racy. I.e. does
+ * not account for racing disconnect / unlock after reading ->tsm. The
+ * @devsec_link_groups usage of this is only for best-effort protection against
+ * using this sample / test module to interfere with other TSM drivers.
+ */
 static struct device *pci_tsm_host(struct pci_dev *pdev)
 {
 	struct pci_tsm *tsm = READ_ONCE(pdev->tsm);
@@ -157,6 +167,8 @@ static int devsec_link_tsm_connect(struct pci_dev *pdev)
 	unsigned long __stream_id;
 	int rc;
 
+	dev_dbg(pci_tsm_host(pdev), "%s\n", pci_name(pdev));
+
 	unsigned long *stream_id __free(free_devsec_stream) =
 		alloc_devsec_stream_id(&__stream_id);
 	if (!stream_id)
@@ -197,6 +209,8 @@ static void devsec_link_tsm_disconnect(struct pci_dev *pdev)
 	struct pci_ide *ide;
 	unsigned long i;
 
+	dev_dbg(pci_tsm_host(pdev), "%s\n", pci_name(pdev));
+
 	for_each_set_bit(i, devsec_stream_ids, NR_TSM_STREAMS)
 		if (devsec_streams[i]->pdev == pdev)
 			break;
@@ -210,11 +224,56 @@ static void devsec_link_tsm_disconnect(struct pci_dev *pdev)
 	clear_bit(i, devsec_stream_ids);
 }
 
+static struct pci_tdi *devsec_link_tsm_bind(struct pci_dev *pdev,
+					    struct kvm *kvm, u32 tdi_id)
+{
+	struct devsec_tsm_tdi *devsec_tdi =
+		kzalloc(sizeof(struct devsec_tsm_tdi), GFP_KERNEL);
+
+	dev_dbg(pci_tsm_host(pdev), "%s\n", pci_name(pdev));
+
+	if (!devsec_tdi)
+		return ERR_PTR(-ENOMEM);
+
+	pci_tsm_tdi_constructor(pdev, &devsec_tdi->pci, kvm, tdi_id);
+
+	return &devsec_tdi->pci;
+}
+
+static void devsec_link_tsm_unbind(struct pci_tdi *tdi)
+{
+	struct devsec_tsm_tdi *devsec_tdi =
+		container_of(tdi, struct devsec_tsm_tdi, pci);
+
+	dev_dbg(pci_tsm_host(tdi->pdev), "%s\n", pci_name(tdi->pdev));
+
+	kfree(devsec_tdi);
+}
+
+static ssize_t devsec_link_tsm_guest_req(struct pci_tdi *tdi,
+					 enum pci_tsm_req_scope scope,
+					 sockptr_t req_in, size_t in_len,
+					 sockptr_t req_out, size_t out_len,
+					 u64 *tsm_code)
+{
+	if (!sockptr_is_kernel(req_in))
+		return -ENXIO;
+
+	dev_dbg(pci_tsm_host(tdi->pdev), "%s\n", pci_name(tdi->pdev));
+	print_hex_dump_debug("devsec req_in  ", DUMP_PREFIX_OFFSET, 16, 4,
+			     req_in.kernel, min(in_len, 256u), true);
+
+	return 0;
+}
+
 static struct pci_tsm_ops devsec_link_pci_ops = {
 	.probe = devsec_link_tsm_pci_probe,
 	.remove = devsec_link_tsm_pci_remove,
 	.connect = devsec_link_tsm_connect,
 	.disconnect = devsec_link_tsm_disconnect,
+	.bind = devsec_link_tsm_bind,
+	.unbind = devsec_link_tsm_unbind,
+	.guest_req = devsec_link_tsm_guest_req,
 };
 
 static void devsec_link_tsm_remove(void *tsm_dev)
@@ -240,10 +299,104 @@ static const struct faux_device_ops devsec_link_device_ops = {
 	.probe = devsec_link_tsm_probe,
 };
 
+static struct pci_dev *pci_find_device(const char *name)
+{
+	struct device *dev = bus_find_device_by_name(&pci_bus_type, NULL, name);
+
+	if (dev)
+		return to_pci_dev(dev);
+	return NULL;
+}
+
+static ssize_t tsm_bind_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct device *host;
+	int rc;
+
+	struct pci_dev *pdev __free(pci_dev_put) = pci_find_device(buf);
+	if (!pdev)
+		return -ENODEV;
+
+	host = pci_tsm_host(pdev);
+	if (!host || host != &devsec_link_tsm->dev)
+		return -ENXIO;
+
+	rc = pci_tsm_bind(pdev, (struct kvm *)1, pci_dev_id(pdev));
+	if (rc)
+		return rc;
+	return count;
+}
+static DEVICE_ATTR_WO(tsm_bind);
+
+static ssize_t tsm_unbind_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct device *host;
+
+	struct pci_dev *pdev __free(pci_dev_put) = pci_find_device(buf);
+	if (!pdev)
+		return -ENODEV;
+
+	host = pci_tsm_host(pdev);
+	if (!host || host != &devsec_link_tsm->dev)
+		return -ENXIO;
+
+	pci_tsm_unbind(pdev);
+	return count;
+}
+static DEVICE_ATTR_WO(tsm_unbind);
+
+static ssize_t tsm_request_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *__buf, size_t count)
+{
+	ssize_t rc;
+	u64 tsm_code = 0;
+	struct device *host;
+	char req_out[16] = {0};
+	size_t out_len = sizeof(req_out);
+
+	struct pci_dev *pdev __free(pci_dev_put) = pci_find_device(__buf);
+	if (!pdev)
+		return -ENODEV;
+
+	char *buf __free(kvfree) = kvmemdup(__buf, count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	host = pci_tsm_host(pdev);
+	if (!host || host != &devsec_link_tsm->dev)
+		return -ENXIO;
+
+	rc = pci_tsm_guest_req(pdev, PCI_TSM_REQ_INFO, KERNEL_SOCKPTR(buf),
+			       count, KERNEL_SOCKPTR(req_out), out_len,
+			       &tsm_code);
+	if (rc)
+		return rc;
+
+	return count;
+}
+static DEVICE_ATTR_WO(tsm_request);
+
+/*
+ * Facilitate testing of the bind and request flows in lieu of VFIO/IOMMUFD
+ * support to exercise these paths.
+ */
+static struct attribute *devsec_link_attrs[] = {
+	&dev_attr_tsm_bind.attr,
+	&dev_attr_tsm_unbind.attr,
+	&dev_attr_tsm_request.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(devsec_link);
+
 static int __init devsec_link_tsm_init(void)
 {
-	devsec_link_tsm = faux_device_create("devsec_link_tsm", NULL,
-					     &devsec_link_device_ops);
+	devsec_link_tsm = faux_device_create_with_groups(
+		"devsec_link_tsm", NULL, &devsec_link_device_ops,
+		devsec_link_groups);
 	if (!devsec_link_tsm)
 		return -ENOMEM;
 	return 0;
-- 
2.52.0

