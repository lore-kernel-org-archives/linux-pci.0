Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62985408251;
	Fri, 27 Mar 2026 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628665; cv=none; b=jnqOxb1SJ3+qh+wY51yqHCtNAtpfOh5IVwahxPq0zE2Atb9Xbje2T93QH76ZFGGt4BLH2mXh4vSbTeudxHQCSAFMZIi8COi8LUlfDx0p23YUZbkyDLAp9esSi1bNb3OLFszYViQg/+fk9ZsZChswAktCWGjMFuJkVPjz/uM+Lqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628665; c=relaxed/simple;
	bh=xIsA7BZZ8qFNyEF3mVWscDtKnNs9xK0BAxYPPzQTAOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tWmNJWiQstL7yYO+/SRfGt/KqKPurn/n3+UY5D7qECzGtjp5cy8yG16JBKQIVkpBX1Pqvz3grdknPuDj6VnIRtM785EkkzoQmgLutwffd7U3gJ9UGw59qBJ0IcOTppejP9p2sNlFboGuAUtvlZTsX5PmdgcyXiRJbR1/3oEXb7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4qgqw3f; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4qgqw3f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628664; x=1806164664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xIsA7BZZ8qFNyEF3mVWscDtKnNs9xK0BAxYPPzQTAOk=;
  b=e4qgqw3fgNk9Nby2XC28kcadNGS46KqHuCWWVPN5xL0j3QQNI59fO9Dk
   d2cKKs9WP4IGGDuxZc/De/Pd1rEP1VgousD3OT7o7Vk9esS6Ev6M/gK2r
   SensE02Gj2cQdliFl8G0BFQLMQwdnzaEo5g9Sl2zJO3KhsWFpojnKM0VI
   b6zuVWBU4sXVC9IktH7faaTjvP8F0wuz2i3KAXjUK62rnLrMbv/ukLEG/
   tZ9e34LbVpPzn6Wt42U5qxhAeK1hEiUaI1ogwLvSmgeq09sOl7KVL1p+w
   ctMFC32U5qz1cIQb6IgDD4074lB9njjmaX/rfHA3PU05Jv6+02+lY7sqn
   A==;
X-CSE-ConnectionGUID: BRANar8lR0eWJhuCacxqZA==
X-CSE-MsgGUID: WOFf8RlCTf+QK1ccYTbFBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565707"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565707"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:24:23 -0700
X-CSE-ConnectionGUID: GkiPIhJKReKCyJCqLIzbsg==
X-CSE-MsgGUID: D819/3SzQf23uFLusEu/Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516395"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:24:20 -0700
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
Subject: [PATCH v2 30/31] coco/tdx-host: Implement IDE stream setup/teardown
Date: Sat, 28 Mar 2026 00:01:31 +0800
Message-Id: <20260327160132.2946114-31-yilun.xu@linux.intel.com>
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

Implementation for a most straightforward Selective IDE stream setup.
Hard code all parameters for Stream Control Register. And no IDE Key
Refresh support.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 include/linux/pci-ide.h               |   2 +
 drivers/pci/ide.c                     |   5 +-
 drivers/virt/coco/tdx-host/tdx-host.c | 226 ++++++++++++++++++++++++++
 3 files changed, 231 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index 381a1bf22a95..f0c6975fd429 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -106,6 +106,8 @@ struct pci_ide {
 void pci_ide_set_nr_streams(struct pci_host_bridge *hb, u16 nr);
 struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev,
 					    struct pci_ide *ide);
+void pci_ide_stream_to_regs(struct pci_dev *pdev, struct pci_ide *ide,
+			    struct pci_ide_regs *regs);
 struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
 void pci_ide_stream_free(struct pci_ide *ide);
 int  pci_ide_stream_register(struct pci_ide *ide);
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index b35e8aba7ecb..1337608448c2 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -556,8 +556,8 @@ static void mem_assoc_to_regs(struct pci_bus_region *region,
  * @ide: registered IDE settings descriptor
  * @regs: output register values
  */
-static void pci_ide_stream_to_regs(struct pci_dev *pdev, struct pci_ide *ide,
-				   struct pci_ide_regs *regs)
+void pci_ide_stream_to_regs(struct pci_dev *pdev, struct pci_ide *ide,
+			    struct pci_ide_regs *regs)
 {
 	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
 	int assoc_idx = 0;
@@ -586,6 +586,7 @@ static void pci_ide_stream_to_regs(struct pci_dev *pdev, struct pci_ide *ide,
 
 	regs->nr_addr = assoc_idx;
 }
+EXPORT_SYMBOL_GPL(pci_ide_stream_to_regs);
 
 /**
  * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index d5072a68b81a..0f6056945788 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -72,6 +72,10 @@ struct tdx_tsm_link {
 	struct tdx_page_array *spdm_mt;
 	unsigned int dev_info_size;
 	void *dev_info_data;
+
+	struct pci_ide *ide;
+	struct tdx_page_array *stream_mt;
+	unsigned int stream_id;
 };
 
 static struct tdx_tsm_link *to_tdx_tsm_link(struct pci_tsm *tsm)
@@ -351,6 +355,219 @@ static void tdx_spdm_session_teardown(struct tdx_tsm_link *tlink)
 DEFINE_FREE(tdx_spdm_session_teardown, struct tdx_tsm_link *,
 	    if (!IS_ERR_OR_NULL(_T)) tdx_spdm_session_teardown(_T))
 
+enum tdx_ide_stream_km_op {
+	TDX_IDE_STREAM_KM_SETUP = 0,
+	TDX_IDE_STREAM_KM_REFRESH = 1,
+	TDX_IDE_STREAM_KM_STOP = 2,
+};
+
+static int tdx_ide_stream_km(struct tdx_tsm_link *tlink,
+			     enum tdx_ide_stream_km_op op)
+{
+	u64 r, out_msg_sz;
+	int ret;
+
+	do {
+		r = tdh_ide_stream_km(tlink->spdm_id, tlink->stream_id, op,
+				      tlink->in_msg, tlink->out_msg,
+				      &out_msg_sz);
+		ret = tdx_tsm_link_event_handler(tlink, r, out_msg_sz);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+
+static struct tdx_tsm_link *
+tdx_ide_stream_key_program(struct tdx_tsm_link *tlink)
+{
+	int ret;
+
+	ret = tdx_ide_stream_km(tlink, TDX_IDE_STREAM_KM_SETUP);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return tlink;
+}
+
+static void tdx_ide_stream_key_stop(struct tdx_tsm_link *tlink)
+{
+	tdx_ide_stream_km(tlink, TDX_IDE_STREAM_KM_STOP);
+}
+
+DEFINE_FREE(tdx_ide_stream_key_stop, struct tdx_tsm_link *,
+	    if (!IS_ERR_OR_NULL(_T)) tdx_ide_stream_key_stop(_T))
+
+static void sel_stream_block_regs(struct pci_dev *pdev, struct pci_ide *ide,
+				  struct pci_ide_regs *regs)
+{
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	struct pci_ide_partner *setting = pci_ide_to_settings(rp, ide);
+
+	/* only support address association for prefetchable memory */
+	setting->mem_assoc = (struct pci_bus_region) { 0, -1 };
+	pci_ide_stream_to_regs(rp, ide, regs);
+}
+
+#define STREAM_INFO_RP_DEVFN		GENMASK_ULL(7, 0)
+#define STREAM_INFO_TYPE		BIT_ULL(8)
+#define  STREAM_INFO_TYPE_LINK		0
+#define  STREAM_INFO_TYPE_SEL		1
+
+static struct tdx_tsm_link *tdx_ide_stream_create(struct tdx_tsm_link *tlink,
+						  struct pci_ide *ide)
+{
+	u64 stream_info, stream_ctrl;
+	u64 stream_id, rp_ide_id;
+	unsigned int nr_pages = tdx_sysinfo->connect.ide_mt_page_count;
+	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	struct pci_ide_regs regs;
+	u64 r;
+
+	struct tdx_page_array *stream_mt __free(tdx_page_array_free) =
+		tdx_page_array_create(nr_pages);
+	if (!stream_mt)
+		return ERR_PTR(-ENOMEM);
+
+	stream_info = FIELD_PREP(STREAM_INFO_RP_DEVFN, rp->devfn);
+	stream_info |= FIELD_PREP(STREAM_INFO_TYPE, STREAM_INFO_TYPE_SEL);
+
+	/*
+	 * For Selective IDE stream, below values must be 0:
+	 *   NPR_AGG/PR_AGG/CPL_AGG/CONF_REQ/ALGO/DEFAULT/STREAM_ID
+	 *
+	 * below values are configurable but now hardcode to 0:
+	 *   PCRC/TC
+	 */
+	stream_ctrl = FIELD_PREP(PCI_IDE_SEL_CTL_EN, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_TX_AGGR_NPR, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_TX_AGGR_PR, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_TX_AGGR_CPL, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_PCRC_EN, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_ALG, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_TC, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_ID, 0);
+
+	sel_stream_block_regs(pdev, ide, &regs);
+	if (regs.nr_addr != 1)
+		return ERR_PTR(-EFAULT);
+
+	r = tdh_ide_stream_create(stream_info, tlink->spdm_id,
+				  stream_mt, stream_ctrl,
+				  regs.rid1, regs.rid2, regs.addr[0].assoc1,
+				  regs.addr[0].assoc2, regs.addr[0].assoc3,
+				  &stream_id, &rp_ide_id);
+	if (r)
+		return ERR_PTR(-EFAULT);
+
+	tlink->stream_id = stream_id;
+	tlink->stream_mt = no_free_ptr(stream_mt);
+
+	pci_dbg(pdev, "%s stream id 0x%x rp ide_id 0x%llx\n", __func__,
+		tlink->stream_id, rp_ide_id);
+	return tlink;
+}
+
+static void tdx_ide_stream_delete(struct tdx_tsm_link *tlink)
+{
+	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
+	unsigned int nr_released;
+	u64 released_hpa, r;
+
+	r = tdh_ide_stream_block(tlink->spdm_id, tlink->stream_id);
+	if (r) {
+		pci_err(pdev, "ide stream block fail 0x%llx\n", r);
+		goto leak;
+	}
+
+	r = tdh_ide_stream_delete(tlink->spdm_id, tlink->stream_id,
+				  tlink->stream_mt, &nr_released,
+				  &released_hpa);
+	if (r) {
+		pci_err(pdev, "ide stream delete fail 0x%llx\n", r);
+		goto leak;
+	}
+
+	if (tdx_page_array_ctrl_release(tlink->stream_mt, nr_released,
+					released_hpa)) {
+		pci_err(pdev, "fail to release IDE stream_mt pages\n");
+		goto leak;
+	}
+
+	return;
+
+leak:
+	tdx_page_array_ctrl_leak(tlink->stream_mt);
+}
+
+DEFINE_FREE(tdx_ide_stream_delete, struct tdx_tsm_link *,
+	    if (!IS_ERR_OR_NULL(_T)) tdx_ide_stream_delete(_T))
+
+static struct tdx_tsm_link *tdx_ide_stream_setup(struct tdx_tsm_link *tlink)
+{
+	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
+	int ret;
+
+	struct pci_ide *ide __free(pci_ide_stream_release) =
+		pci_ide_stream_alloc(pdev);
+	if (!ide)
+		return ERR_PTR(-ENOMEM);
+
+	/* Configure IDE capability for RP & get stream_id */
+	struct tdx_tsm_link *tlink_create __free(tdx_ide_stream_delete) =
+		tdx_ide_stream_create(tlink, ide);
+	if (IS_ERR(tlink_create))
+		return tlink_create;
+
+	ide->stream_id = tlink->stream_id;
+	ret = pci_ide_stream_register(ide);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/*
+	 * Configure IDE capability for target device
+	 *
+	 * Some test devices work only with DEFAULT_STREAM enabled. For
+	 * simplicity, enable DEFAULT_STREAM for all devices. A future decent
+	 * solution may be to have a quirk table to specify which devices need
+	 * DEFAULT_STREAM.
+	 */
+	ide->partner[PCI_IDE_EP].default_stream = 1;
+	pci_ide_stream_setup(pdev, ide);
+
+	/* Key Programming for RP & target device, enable IDE stream for RP */
+	struct tdx_tsm_link *tlink_program __free(tdx_ide_stream_key_stop) =
+		tdx_ide_stream_key_program(tlink);
+	if (IS_ERR(tlink_program))
+		return tlink_program;
+
+	ret = tsm_ide_stream_register(ide);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* Enable IDE stream for target device */
+	ret = pci_ide_stream_enable(pdev, ide);
+	if (ret)
+		return ERR_PTR(ret);
+
+	retain_and_null_ptr(tlink_create);
+	retain_and_null_ptr(tlink_program);
+	tlink->ide = no_free_ptr(ide);
+
+	return tlink;
+}
+
+static void tdx_ide_stream_teardown(struct tdx_tsm_link *tlink)
+{
+	tdx_ide_stream_key_stop(tlink);
+	tdx_ide_stream_delete(tlink);
+	pci_ide_stream_release(tlink->ide);
+}
+
+DEFINE_FREE(tdx_ide_stream_teardown, struct tdx_tsm_link *,
+	    if (!IS_ERR_OR_NULL(_T)) tdx_ide_stream_teardown(_T))
+
 static int tdx_tsm_link_connect(struct pci_dev *pdev)
 {
 	struct tdx_tsm_link *tlink = to_tdx_tsm_link(pdev->tsm);
@@ -362,7 +579,15 @@ static int tdx_tsm_link_connect(struct pci_dev *pdev)
 		return PTR_ERR(tlink_spdm);
 	}
 
+	struct tdx_tsm_link *tlink_ide __free(tdx_ide_stream_teardown) =
+		tdx_ide_stream_setup(tlink);
+	if (IS_ERR(tlink_ide)) {
+		pci_err(pdev, "fail to setup ide stream\n");
+		return PTR_ERR(tlink_ide);
+	}
+
 	retain_and_null_ptr(tlink_spdm);
+	retain_and_null_ptr(tlink_ide);
 
 	return 0;
 }
@@ -371,6 +596,7 @@ static void tdx_tsm_link_disconnect(struct pci_dev *pdev)
 {
 	struct tdx_tsm_link *tlink = to_tdx_tsm_link(pdev->tsm);
 
+	tdx_ide_stream_teardown(tlink);
 	tdx_spdm_session_teardown(tlink);
 }
 
-- 
2.25.1

