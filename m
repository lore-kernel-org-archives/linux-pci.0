Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2803E3C47;
	Fri, 27 Mar 2026 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628614; cv=none; b=UIgD1/i4C7UbK3I9BCZB/+t263MTwi6ILeCNuzxD0gxyP6edpQvfrxVGVCKxZOy7BOoB7LFV8+m5kfVijX8Tj+XQf8b5BZ7VDXj4xFCTRoJrLaukscJR6KyF6l8AnSPVGmHsx50t4J+KsDlHXuRdsvFl87LKr3pkuKwlMtZ2CXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628614; c=relaxed/simple;
	bh=dzQVPWIaSxETgDXevSN0G82bnXnd5YoCZ3n3bdcc8Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZ2sUBBRUPtaL/ntkjGqlLpR4DMQ825UdX/OA8FKuGeEujZWwCEBOx43wmDDjIG5ZhOM2ODzzuWgR3JC2e+QjNnnQQcmP6KaITwLGwYfAUL7hSBoCSLiSfgkcRA+eMgvNOdHlEbPCJWyJ6CyZJJXG6tea93hb9nDdGAq/bdbExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsXxciyg; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsXxciyg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628612; x=1806164612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dzQVPWIaSxETgDXevSN0G82bnXnd5YoCZ3n3bdcc8Zw=;
  b=WsXxciygjX9xR/+mY+NXBXcRPhCU0tsVvRvLG0IOcT3GkN9mCf+9ETds
   QTbbpjDHVKSg78Cghpd/smS8qN87g10vOwfJDFxQ2HMN7R1Voa2XE606R
   eo7w+hoQ/3AouX2M5HlUc87sw98drd2JlXoKvergXxxrq888cpxux32BS
   UJoTyq+Lmuoy5vOyPAUPgFGSN9+EKrxcBJHLdwkKeKY17oz6cjBS2UZfB
   pOYd2mt7qD+uaTZaRXCReLpAdDfcdrDPQ3hbyhXI/1OVP7xLiMxFC7jep
   wnLACv3a3OKPzQOK7pcrhBe/cggbbatuFCVPK3m9230BPm4KzL7WcQCMW
   w==;
X-CSE-ConnectionGUID: BRXUEIN9SW26+Ec5n5CIKQ==
X-CSE-MsgGUID: kszwnvuMQA+Hz5IMcItovw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565600"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565600"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:23:32 -0700
X-CSE-ConnectionGUID: hr8btrkQS3K/8jDTuCM4eQ==
X-CSE-MsgGUID: VKoD1c00RHeRl0xVyucjlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516261"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:23:29 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dan.j.williams@intel.com,
	x86@kernel.org
Cc: chao.gao@intel.com,
	dave.jiang@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	zhenzhong.duan@intel.com,
	kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	dave.hansen@linux.intel.com,
	kas@kernel.org,
	xiaoyao.li@intel.com,
	vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/31] coco/tdx-host: Support Link TSM for TDX host
Date: Sat, 28 Mar 2026 00:01:17 +0800
Message-Id: <20260327160132.2946114-17-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register a Link TSM instance to support host side TSM operations for
TDISP, when the TDX Connect support bit is set by TDX Module in
tdx_feature0.

This is the main purpose of an independent tdx-host module out of TDX
core. Recall that a TEE Security Manager (TSM) is a platform agent that
speaks the TEE Device Interface Security Protocol (TDISP) to PCIe
devices and manages private memory resources for the platform. An
independent tdx-host module allows for device-security enumeration and
initialization flows to be deferred from other TDX Module initialization
requirements. Crucially, when / if TDX Module init moves earlier in x86
initialization flow this driver is still guaranteed to run after IOMMU
and PCI init (i.e. subsys_initcall() vs device_initcall()).

The ability to unload the module, or unbind the driver is also useful
for debug and coarse grained transitioning between PCI TSM operation and
PCI CMA operation (native kernel PCI device authentication).

For now only verify TDX Connect support in TDX Module and enable TDX
Module Extentions. The TSM support are basic boilerplate with operation
flows to be added later.

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/virt/coco/tdx-host/Kconfig    |   5 +
 drivers/virt/coco/tdx-host/tdx-host.c | 138 +++++++++++++++++++++++++-
 2 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
index d35d85ef91c0..32add81b7d56 100644
--- a/drivers/virt/coco/tdx-host/Kconfig
+++ b/drivers/virt/coco/tdx-host/Kconfig
@@ -8,3 +8,8 @@ config TDX_HOST_SERVICES
 
 	  Say y or m if enabling support for confidential virtual machine
 	  support (CONFIG_INTEL_TDX_HOST). The module is called tdx_host.ko.
+
+config TDX_CONNECT
+	def_bool y
+	depends on TDX_HOST_SERVICES
+	depends on PCI_TSM
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index c77885392b09..5ea35a514865 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -8,9 +8,13 @@
 #include <linux/device/faux.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/pci.h>
+#include <linux/pci-tsm.h>
+#include <linux/tsm.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/tdx.h>
+#include <asm/tdx_global_metadata.h>
 
 static const struct x86_cpu_id tdx_host_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_TDX_HOST_PLATFORM, NULL),
@@ -18,14 +22,144 @@ static const struct x86_cpu_id tdx_host_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, tdx_host_ids);
 
+/*
+ * The global pointer is for features which won't be affected by tdx_sysinfo
+ * change after TDX Module update, e.g. TDX Connect, so could cache it. A
+ * counterexample is the TDX Module version.
+ */
+static const struct tdx_sys_info *tdx_sysinfo;
+
+struct tdx_tsm_link {
+	struct pci_tsm_pf0 pci;
+};
+
+static struct tdx_tsm_link *to_tdx_tsm_link(struct pci_tsm *tsm)
+{
+	return container_of(tsm, struct tdx_tsm_link, pci.base_tsm);
+}
+
+static int tdx_tsm_link_connect(struct pci_dev *pdev)
+{
+	return -ENXIO;
+}
+
+static void tdx_tsm_link_disconnect(struct pci_dev *pdev)
+{
+}
+
+static struct pci_tsm *tdx_tsm_link_pf0_probe(struct tsm_dev *tsm_dev,
+					      struct pci_dev *pdev)
+{
+	int rc;
+
+	struct tdx_tsm_link *tlink __free(kfree) = kzalloc_obj(*tlink);
+	if (!tlink)
+		return NULL;
+
+	rc = pci_tsm_pf0_constructor(pdev, &tlink->pci, tsm_dev);
+	if (rc)
+		return NULL;
+
+	return &no_free_ptr(tlink)->pci.base_tsm;
+}
+
+static void tdx_tsm_link_pf0_remove(struct pci_tsm *tsm)
+{
+	struct tdx_tsm_link *tlink = to_tdx_tsm_link(tsm);
+
+	pci_tsm_pf0_destructor(&tlink->pci);
+	kfree(tlink);
+}
+
+static struct pci_tsm *tdx_tsm_link_fn_probe(struct tsm_dev *tsm_dev,
+					     struct pci_dev *pdev)
+{
+	int rc;
+
+	struct pci_tsm *pci_tsm __free(kfree) = kzalloc_obj(*pci_tsm);
+	if (!pci_tsm)
+		return NULL;
+
+	rc = pci_tsm_link_constructor(pdev, pci_tsm, tsm_dev);
+	if (rc)
+		return NULL;
+
+	return no_free_ptr(pci_tsm);
+}
+
+static struct pci_tsm *tdx_tsm_link_probe(struct tsm_dev *tsm_dev,
+					  struct pci_dev *pdev)
+{
+	if (is_pci_tsm_pf0(pdev))
+		return tdx_tsm_link_pf0_probe(tsm_dev, pdev);
+
+	return tdx_tsm_link_fn_probe(tsm_dev, pdev);
+}
+
+static void tdx_tsm_link_remove(struct pci_tsm *tsm)
+{
+	if (is_pci_tsm_pf0(tsm->pdev)) {
+		tdx_tsm_link_pf0_remove(tsm);
+		return;
+	}
+
+	/* for sub-functions */
+	kfree(tsm);
+}
+
+static struct pci_tsm_ops tdx_tsm_link_ops = {
+	.probe = tdx_tsm_link_probe,
+	.remove = tdx_tsm_link_remove,
+	.connect = tdx_tsm_link_connect,
+	.disconnect = tdx_tsm_link_disconnect,
+};
+
+static void unregister_link_tsm(void *link)
+{
+	tsm_unregister(link);
+}
+
+static int __maybe_unused tdx_connect_init(struct device *dev)
+{
+	struct tsm_dev *link;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_TDX_CONNECT))
+		return 0;
+
+	if (!(tdx_sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
+		return 0;
+
+	link = tsm_register(dev, &tdx_tsm_link_ops);
+	if (IS_ERR(link))
+		return dev_err_probe(dev, PTR_ERR(link),
+				     "failed to register TSM\n");
+
+	return devm_add_action_or_reset(dev, unregister_link_tsm, link);
+}
+
+static int tdx_host_probe(struct faux_device *fdev)
+{
+	/* TODO: do tdx_connect_init() when it is fully implemented. */
+	return 0;
+}
+
+static struct faux_device_ops tdx_host_ops = {
+	.probe = tdx_host_probe,
+};
+
 static struct faux_device *fdev;
 
 static int __init tdx_host_init(void)
 {
-	if (!x86_match_cpu(tdx_host_ids) || !tdx_get_sysinfo())
+	if (!x86_match_cpu(tdx_host_ids))
+		return -ENODEV;
+
+	tdx_sysinfo = tdx_get_sysinfo();
+	if (!tdx_sysinfo)
 		return -ENODEV;
 
-	fdev = faux_device_create(KBUILD_MODNAME, NULL, NULL);
+	fdev = faux_device_create(KBUILD_MODNAME, NULL, &tdx_host_ops);
 	if (!fdev)
 		return -ENODEV;
 
-- 
2.25.1

