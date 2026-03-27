Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950714014B5;
	Fri, 27 Mar 2026 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628643; cv=none; b=n7Nf6/UILff+j1zF6Ccpaiz3RoGPIzcIsogog7f9oJDYFdTpOcHzP+31wD4JFgnAqfNQs6baBkVwT3sWfrk5BlSJZEWKUw1AOWZ59aGDqGJ+a96DWJExFuu1G1BHjnG+4bN2P49lgIwTowMRpNNeUqwxtrOMkFDMdUaDOKL5hvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628643; c=relaxed/simple;
	bh=BWgvuTh4wsiASYHYze+pv0K77l3r+BTKGEH1em4ro3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AwHJIm2gC0bqyHijkHVPNVleGLGY8zI8OqadgPwzdztxWxlkI8vxePcRYtSpLdjLoxLugeRMt2yspT+SnV4k9R49Ys/8BNZMVp1Pu0ZoK1ZVQ2ki1XFeje31b9oiim9E56B8F2+/aHe2qfC7DssQH5N0X3+7VrZ90m8IHAUdD4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOuK9H9K; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOuK9H9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628642; x=1806164642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BWgvuTh4wsiASYHYze+pv0K77l3r+BTKGEH1em4ro3s=;
  b=OOuK9H9K6FQlEaahdcz38NMaZj5GtWcfEOtubz6utyeHa8O0AinedHVi
   QckDdQxVFHvDt4/FevUjx5eQU7sa7NAy+Zdye84CCNRBONJH8Jad7vixr
   vivFOF6a9oqVbWWYo9hgS7eI+/zjhxoEm8R07rvrWUCJpa//iVkiv82wx
   B7UIsnnd3C454OM3hyG+IDBEtU5ql/+tzD7Rxoye5ztS+3vex1Xeu+x+d
   UpwBaqPRndfQDFIvgZw72tib3xMrRZn7in20j67/8333OySQ5StSZXlhm
   ERWKk+TuSiy7r8FyYnf1rboI/3vQM/ghoqcjAeTTnm8Ow5X9cL2OoQ10h
   g==;
X-CSE-ConnectionGUID: 4895LyNvSQubsUrMcJkjHw==
X-CSE-MsgGUID: 0anwO/gySa6aHPrDmMEbYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565662"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565662"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:24:02 -0700
X-CSE-ConnectionGUID: X0Uz/QmCSSujRQRpRKYfyg==
X-CSE-MsgGUID: DY8Zas4iTC+bZkPFfJug2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516349"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:23:58 -0700
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
Subject: [PATCH v2 24/31] coco/tdx-host: Add a helper to exchange SPDM messages through DOE
Date: Sat, 28 Mar 2026 00:01:25 +0800
Message-Id: <20260327160132.2946114-25-yilun.xu@linux.intel.com>
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

TDX host uses this function to exchange TDX Module encrypted data with
devices via SPDM. It is unfortunate that TDX passes raw DOE frames with
headers included and the PCI DOE core wants payloads separated from
headers.

This conversion code is about the same amount of work as teaching the PCI
DOE driver to support raw frames. Unless and until another raw frame use
case shows up, just do this conversion in the TDX TSM driver.

Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/virt/coco/tdx-host/tdx-host.c | 61 +++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 98ed93ac0153..06f3d194e0a8 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -5,11 +5,13 @@
  * Copyright (C) 2025 Intel Corporation
  */
 
+#include <linux/bitfield.h>
 #include <linux/device/faux.h>
 #include <linux/dmar.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/pci-tsm.h>
 #include <linux/tsm.h>
 
@@ -39,6 +41,65 @@ static struct tdx_tsm_link *to_tdx_tsm_link(struct pci_tsm *tsm)
 	return container_of(tsm, struct tdx_tsm_link, pci.base_tsm);
 }
 
+#define PCI_DOE_DATA_OBJECT_HEADER_1_OFFSET	0
+#define PCI_DOE_DATA_OBJECT_HEADER_2_OFFSET	4
+#define PCI_DOE_DATA_OBJECT_HEADER_SIZE		8
+#define PCI_DOE_DATA_OBJECT_PAYLOAD_OFFSET	PCI_DOE_DATA_OBJECT_HEADER_SIZE
+
+#define PCI_DOE_PROTOCOL_SECURE_SPDM		2
+
+static int __maybe_unused tdx_spdm_msg_exchange(struct tdx_tsm_link *tlink,
+						void *request, size_t request_sz,
+						void *response, size_t response_sz)
+{
+	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
+	void *req_pl_addr, *resp_pl_addr;
+	size_t req_pl_sz, resp_pl_sz;
+	u32 data, len;
+	u16 vendor;
+	u8 type;
+	int ret;
+
+	/*
+	 * pci_doe() accept DOE PAYLOAD only but request carries DOE HEADER so
+	 * shift the buffers, skip DOE HEADER in request buffer, and fill DOE
+	 * HEADER in response buffer manually.
+	 */
+
+	data = le32_to_cpu(*(__le32 *)(request + PCI_DOE_DATA_OBJECT_HEADER_1_OFFSET));
+	vendor = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, data);
+	type = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, data);
+
+	data = le32_to_cpu(*(__le32 *)(request + PCI_DOE_DATA_OBJECT_HEADER_2_OFFSET));
+	len = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, data);
+
+	req_pl_sz = len * sizeof(__le32) - PCI_DOE_DATA_OBJECT_HEADER_SIZE;
+	resp_pl_sz = response_sz - PCI_DOE_DATA_OBJECT_HEADER_SIZE;
+	req_pl_addr = request + PCI_DOE_DATA_OBJECT_HEADER_SIZE;
+	resp_pl_addr = response + PCI_DOE_DATA_OBJECT_HEADER_SIZE;
+
+	ret = pci_tsm_doe_transfer(pdev, type, req_pl_addr, req_pl_sz,
+				   resp_pl_addr, resp_pl_sz);
+	if (ret < 0) {
+		pci_err(pdev, "spdm msg exchange fail %d\n", ret);
+		return ret;
+	}
+
+	data = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, vendor) |
+	       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, type);
+	*(__le32 *)(response + PCI_DOE_DATA_OBJECT_HEADER_1_OFFSET) = cpu_to_le32(data);
+
+	len = (ret + PCI_DOE_DATA_OBJECT_HEADER_SIZE) / sizeof(__le32);
+	data = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, len);
+	*(__le32 *)(response + PCI_DOE_DATA_OBJECT_HEADER_2_OFFSET) = cpu_to_le32(data);
+
+	ret += PCI_DOE_DATA_OBJECT_HEADER_SIZE;
+
+	pci_dbg(pdev, "%s complete: vendor 0x%x type 0x%x rsp_sz %d\n",
+		__func__, vendor, type, ret);
+	return ret;
+}
+
 static int tdx_tsm_link_connect(struct pci_dev *pdev)
 {
 	return -ENXIO;
-- 
2.25.1

