Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827396;
	b=ChsmzuEUaO9wNulQxSEFjcSADt+haDWQyGRKd/V8WlpUsY+q61h/+HYNv/gpLLF8sUey
	 GrpQG+ZyytC3ZEb9OdasaANeA2Z0IzwTdLGLqzFW6ibL0rNpHFZYg1XwYtkDnjGgXJL7f
	 28uaimdNOtNmGlNOTCd7UkUz2VGAlyVoQA3EuvjF79FDFPH3HLxf9aXBBYu3PyTnomiZS
	 E6B2lirLGLBRmjKlbEOaMUba6XJXT1MPtxaWokT2RbN7foQJVAN1+FnIzX1gaHO9NE7FM
	 /Ox3GsUvwjRV1uoUZ4ya3mr3i7CAd082ldljTwC1uzABw3q6Dg2EX9WdLWktEfp6OoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827396;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UVQjDz8uMptXUwHX1U614DZ5+kjG9ZysdKmrZrKVxts=;
	b=L/dxy0QobtfNezIoNV9iFnFo0zErIUYaMG+FbR7vpWVhU5Alms1SI7KLaEmYI8EXnyOb
	 SSS/bVOzp1QHzzus9KHupebs0cwmDSFLfGjuk1pJQnvn8xp3KdOdlvhZ2bE2s/L6DyQor
	 1ec0e4y428BiqEIQCx6/Zka+/awpOh5tPElHlZNWA4YaWAIlhe+9qI97AX1VuY/K+ibzS
	 8wBwWP7SizjO98KWuSLgmID8ePk+RJDer1Nc/tvQ5zW4URlty5UvesJ7WSRTo49k8JuCV
	 cnn9KqnEZQiXhwW5xUIS2+DE4LLGuiiNrbSyLi8DhiLnyzJf9j8cbwkAUOLis9H73Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Khzg2r20;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B55607D21F;
	Mon, 16 Nov 2026 11:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03B55607D21F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Khzg2r20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794827396; x=1826363396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iewts0mO2t3Cm42DkCHvOuE8t5QeVKh5uRkwmUG+hUU=;
  b=Khzg2r201hP56RnQy9fOrBfzSM/elh1GodYZ5/77TkVDt/EB3IGTSKi1
   Qh8fA3qXJIrK1Pg7Il97cz3UzWMXAFwvAcHmeg1hDN5zfzoyjNSzyWwJ+
   QOqTlV0rGlBxrjUEhim0D40VncSTJ2QZPMviyT/bQNqeY3ywUyUbJb0II
   SzvbcstZV4s2BSNL1DNv9TYVfpPSxSzIZxxNJije3EvqmB9PZ9kpF001q
   U+9wOz4d8V7233+zyWxMq+vTXdY2/DJSHEFgfY6dI3FfYpRV7lge1DjpI
   SyKKZMYkMusHINkut+WbWN5TulLsik6HFAR5uAXDaDDeokzdUlPj9qF72
   w==;
X-CSE-ConnectionGUID: ZiY18YfSSDyl23vSOAHqzQ==
X-CSE-MsgGUID: ZnJ/uVN7TWu8vT586PdIeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3429625"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3429625"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:09:56 -0800
X-CSE-ConnectionGUID: qyDTE+XTSEO+27ziRCwcPg==
X-CSE-MsgGUID: yJ8iFOn+TNeDp+JGkAwToA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9848131"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:09:55 -0800
From: Chao Gao <chao.gao@intel.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: rick.p.edgecombe@intel.com,
	kevin.tian@intel.com,
	yilun.xu@intel.com,
	chao.p.peng@intel.com,
	baolu.lu@linux.intel.com,
	chao.gao@intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [RFC PATCH 5/7] coco/tdx-host: Configure an IDE stream
Date: Mon, 16 Nov 2026 03:10:23 -0800
Message-ID: <20261116111037.3478844-6-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261116111037.3478844-1-chao.gao@intel.com>
References: <20261116111037.3478844-1-chao.gao@intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Establishing a PCIe Integrity and Data Encryption (IDE) stream has two
parts. The stream is first provisioned in the config space of both
Partner Ports (the root port and the device), and the keys are then
programmed via IDE Key Management (IDE_KM).

Commit 1e4d2ff3ae45 ("PCI/IDE: Add IDE establishment helpers") added
the pci_ide_stream_*() helpers for provisioning. They split it into
fine-grained allocate, register and setup steps to accommodate
differences between SEV-TIO and TDX Connect, such as who programs the
root port and who allocates the stream ID.

Provision the stream with these helpers. IDE_KM and enabling the stream
are left to later changes.

The TDX module owns the root port's IDE registers and provides
TDH.IDE.STREAM.CREATE for the host to program them. Configure the root
port with the SEAMCALL, passing the register values as parameters, and
write only the device's IDE registers from the host.

An IDE stream can be associated with address ranges, so that traffic
to different ranges, such as those of different devices, goes through
different streams with different keys. A stream can be associated with
multiple ranges, but TDX supports only one. Keep the prefetchable range
and drop the non-prefetchable one. Export pci_ide_stream_to_regs() to
generate the root port's register values from the adjusted settings.

TDH.IDE.STREAM.CREATE also returns the stream ID that the TDX module
assigns. Configure the device with the same ID.

Based on work by Yilun.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 drivers/pci/ide.c                 |   5 +-
 drivers/virt/coco/tdx-host/main.c | 147 ++++++++++++++++++++++++++++++
 include/linux/pci-ide.h           |   2 +
 3 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index beb67b8fb5c5..aced5ef923a9 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -550,8 +550,8 @@ static void mem_assoc_to_regs(struct pci_bus_region *region,
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
@@ -580,6 +580,7 @@ static void pci_ide_stream_to_regs(struct pci_dev *pdev, struct pci_ide *ide,
 
 	regs->nr_addr = assoc_idx;
 }
+EXPORT_SYMBOL_GPL(pci_ide_stream_to_regs);
 
 /**
  * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
diff --git a/drivers/virt/coco/tdx-host/main.c b/drivers/virt/coco/tdx-host/main.c
index da56178eac2e..63209a712c28 100644
--- a/drivers/virt/coco/tdx-host/main.c
+++ b/drivers/virt/coco/tdx-host/main.c
@@ -12,6 +12,7 @@
 #include <linux/sysfs.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <linux/pci-ide.h>
 #include <linux/pci-tsm.h>
 #include <linux/tsm.h>
 
@@ -69,6 +70,10 @@ struct tdx_tsm_link {
 	void *spdm_mt;
 	unsigned int dev_info_nr_pages;
 	void *dev_info;
+
+	struct pci_ide *ide;
+	struct page *stream_mt;
+	unsigned int stream_id;
 };
 
 static struct tdx_tsm_link *to_tdx_tsm_link(struct pci_tsm *tsm)
@@ -322,6 +327,140 @@ static void tdx_spdm_session_teardown(struct tdx_tsm_link *tlink)
 	tdx_spdm_delete(tlink);
 }
 
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
+static int tdx_ide_stream_create(struct tdx_tsm_link *tlink,
+				 struct pci_ide *ide)
+{
+	u64 stream_info, stream_ctrl, stream_id;
+	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	struct pci_ide_regs regs;
+	struct page *stream_mt;
+	u64 sret;
+	int ret;
+
+	stream_mt = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!stream_mt)
+		return -ENOMEM;
+
+	stream_info = FIELD_PREP(STREAM_INFO_RP_DEVFN, rp->devfn);
+	stream_info |= FIELD_PREP(STREAM_INFO_TYPE, STREAM_INFO_TYPE_SEL);
+	/* Keep optional stream features disabled for now. */
+	stream_ctrl = 0;
+
+	sel_stream_block_regs(pdev, ide, &regs);
+	if (regs.nr_addr != 1) {
+		ret = -EFAULT;
+		goto out_free_stream_mt;
+	}
+
+	sret = tdh_ide_stream_create(stream_info, tlink->spdm_id,
+				     stream_mt, stream_ctrl,
+				     regs.rid1, regs.rid2, regs.addr[0].assoc1,
+				     regs.addr[0].assoc2, regs.addr[0].assoc3,
+				     &stream_id);
+	if (sret) {
+		ret = -EIO;
+		goto out_free_stream_mt;
+	}
+
+	tlink->stream_id = stream_id;
+	tlink->stream_mt = stream_mt;
+
+	return 0;
+
+out_free_stream_mt:
+	__free_page(stream_mt);
+
+	return ret;
+}
+
+static void tdx_ide_stream_delete(struct tdx_tsm_link *tlink)
+{
+	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
+	u64 sret;
+
+	sret = tdh_ide_stream_block(tlink->spdm_id, tlink->stream_id);
+	if (sret) {
+		/* leak the metadata pages */
+		pci_err(pdev, "ide stream block fail 0x%llx\n", sret);
+		return;
+	}
+
+	sret = tdh_ide_stream_delete(tlink->spdm_id, tlink->stream_id);
+	if (sret) {
+		pci_err(pdev, "ide stream delete fail 0x%llx\n", sret);
+		return;
+	}
+
+	__free_page(tlink->stream_mt);
+}
+
+static int tdx_ide_stream_setup(struct tdx_tsm_link *tlink)
+{
+	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
+	struct pci_ide *ide;
+	int ret;
+
+	ide = pci_ide_stream_alloc(pdev);
+	if (!ide)
+		return -ENOMEM;
+
+	/* Configure IDE capability for RP & get stream_id */
+	ret = tdx_ide_stream_create(tlink, ide);
+	if (ret)
+		goto out_pci_ide_stream_free;
+
+	ide->stream_id = tlink->stream_id;
+	ret = pci_ide_stream_register(ide);
+	if (ret)
+		goto out_tdx_ide_stream_delete;
+
+	/*
+	 * Configure stream settings for the device. TDISP requires one
+	 * stream to be the default stream, and the PCI core does not set
+	 * one, so make the only stream the default.
+	 */
+	ide->partner[PCI_IDE_EP].default_stream = 1;
+	pci_ide_stream_setup(pdev, ide);
+
+	tlink->ide = ide;
+
+	return 0;
+
+out_tdx_ide_stream_delete:
+	tdx_ide_stream_delete(tlink);
+out_pci_ide_stream_free:
+	pci_ide_stream_free(ide);
+
+	return ret;
+}
+
+static void tdx_ide_stream_teardown(struct tdx_tsm_link *tlink)
+{
+	struct pci_ide *ide = tlink->ide;
+
+	pci_ide_stream_teardown(ide->pdev, ide);
+	pci_ide_stream_unregister(ide);
+	tdx_ide_stream_delete(tlink);
+	pci_ide_stream_free(ide);
+}
+
 static int tdx_tsm_link_connect(struct pci_dev *pdev)
 {
 	struct tdx_tsm_link *tlink = to_tdx_tsm_link(pdev->tsm);
@@ -334,8 +473,15 @@ static int tdx_tsm_link_connect(struct pci_dev *pdev)
 	ret = tdx_spdm_session_setup(tlink);
 	if (ret)
 		goto out_iommu_put;
+
+	ret = tdx_ide_stream_setup(tlink);
+	if (ret)
+		goto out_spdm_teardown;
+
 	return 0;
 
+out_spdm_teardown:
+	tdx_spdm_session_teardown(tlink);
 out_iommu_put:
 	tdx_iommu_put(pdev);
 	return ret;
@@ -345,6 +491,7 @@ static void tdx_tsm_link_disconnect(struct pci_dev *pdev)
 {
 	struct tdx_tsm_link *tlink = to_tdx_tsm_link(pdev->tsm);
 
+	tdx_ide_stream_teardown(tlink);
 	tdx_spdm_session_teardown(tlink);
 	tdx_iommu_put(pdev);
 }
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index ae07d9f699c0..f8074865d2cd 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -104,6 +104,8 @@ struct pci_ide {
 void pci_ide_set_nr_streams(struct pci_host_bridge *hb, u16 nr);
 struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev,
 					    struct pci_ide *ide);
+void pci_ide_stream_to_regs(struct pci_dev *pdev, struct pci_ide *ide,
+			    struct pci_ide_regs *regs);
 struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
 void pci_ide_stream_free(struct pci_ide *ide);
 int  pci_ide_stream_register(struct pci_ide *ide);
-- 
2.52.0

