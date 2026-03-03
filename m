Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018435BDC9
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496068; cv=none; b=IUPHV0TOBaS+NSPJp6Zpy7I5YcNYjBnnPSE6DrwGzV5IliB4z3wtbW/XIiDpYusnY0vAQ70d9BUea4xM4RUlsVUormZFdw1Nn1N+mhAS9aIyLeUWCsKKRu17VfX7qxWE/Bv0uM8cMOf4JlLTuKS0p3rqwy40MeJWOel2qn+ch8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496068; c=relaxed/simple;
	bh=UtKD+1ggTOsvGFWGTo+MIyCQ1Owa45ETNwVucwl3+8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItpjoxYRpeZbxuqV5yad7bkOESTKdo57m9hzYqyGn09+MSBBCiGETCvrnLOYVGKcLp6huXRqZkyyxZs54aJbwRYXw7MuBhQ1dVnCrh8j2MAbFcPtqib87LzzjXe5qbqBXWkuskytdWwABUMQDCycsozIa2szSUJwVHnSicptZCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kfQPa3wP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfQPa3wP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496066; x=1804032066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UtKD+1ggTOsvGFWGTo+MIyCQ1Owa45ETNwVucwl3+8g=;
  b=kfQPa3wPetPSNo5VEy0koi9O8jRCcjvLfdNSzwZw//ubWAr5AX4jwHwS
   7BNwkbx0Kr5UDWCFygw9wXErSKKyMyvOnglLm1/a35pfN9IsEoUhkBwcS
   U//IBL9fM2J/z1J2cRgjfX710TiIjMAQxIQilHqng0XBWYp4fB4lMqX80
   tGG1tXuQEhuLTOed68ENPHUn/nVrxXmPc/DLQsgIt6j9gYTtV07j62lWs
   YMSdCyxaJIctgmyxrFg4GBFSmxhWtDP5BaTCht/yabScPP3MN1KwR9yZL
   06FwlcHpLL5CbkdSpHFd+HV+S6KxgHcdFFRP29ciJx8kxhn9wd2PlHFie
   g==;
X-CSE-ConnectionGUID: annS857aQfegjgSzSysZEQ==
X-CSE-MsgGUID: gOzPjy7oRYebzh/WBZABKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73483007"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73483007"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:01:00 -0800
X-CSE-ConnectionGUID: t7VBRXsaSgyGEgCZNxVUyA==
X-CSE-MsgGUID: rv68BHq3R7qYm0MTXWk6Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967122"
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
Subject: [PATCH v2 14/19] samples/devsec: Add sample IDE establishment
Date: Mon,  2 Mar 2026 16:02:02 -0800
Message-ID: <20260303000207.1836586-15-dan.j.williams@intel.com>
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

Exercise common setup and teardown flows for a sample platform TSM
driver that implements the TSM 'connect' and 'disconnect' flows.

This is both a template for platform specific implementations and a
simple integration test for the PCI core infrastructure + ABI.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 samples/devsec/bus.c      |  4 +++
 samples/devsec/link_tsm.c | 70 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
index a55e9573c8bf..fe32b5c8e033 100644
--- a/samples/devsec/bus.c
+++ b/samples/devsec/bus.c
@@ -6,6 +6,7 @@
 #include <linux/device/faux.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci-ide.h>
 #include <linux/range.h>
 #include <uapi/linux/pci_regs.h>
 
@@ -16,6 +17,7 @@
 #define NR_DEVICES_PER_BUS 1
 #define NR_FUNCTIONS 2
 #define NR_DEVICES (NR_DEVICES_PER_BUS * NR_FUNCTIONS * NR_DEVSEC_BUSES)
+#define NR_HOST_BRIDGE_STREAMS 4
 #define NR_PORT_STREAMS 1
 #define NR_PORT_LINK_STREAMS 4
 #define NR_ADDR_ASSOC 1
@@ -728,6 +730,7 @@ static int devsec_add_host_bridge(struct faux_device *fdev, int hb_idx)
 	hb->dev.parent = dev;
 	hb->sysdata = sd;
 	hb->ops = &devsec_ops;
+	pci_ide_set_nr_streams(hb, NR_HOST_BRIDGE_STREAMS);
 
 	rc = pci_scan_root_bus_bridge(hb);
 	if (rc)
@@ -776,5 +779,6 @@ static void __exit devsec_bus_exit(void)
 }
 module_exit(devsec_bus_exit);
 
+MODULE_IMPORT_NS("PCI_IDE");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Device Security Sample Infrastructure: TDISP Device Emulation");
diff --git a/samples/devsec/link_tsm.c b/samples/devsec/link_tsm.c
index e5d66b877bca..dea5215ff97b 100644
--- a/samples/devsec/link_tsm.c
+++ b/samples/devsec/link_tsm.c
@@ -4,6 +4,7 @@
 #define dev_fmt(fmt) "devsec: " fmt
 #include <linux/device/faux.h>
 #include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/tsm.h>
@@ -111,6 +112,23 @@ static void devsec_link_tsm_pci_remove(struct pci_tsm *tsm)
 	}
 }
 
+/* protected by tsm_ops lock */
+static DECLARE_BITMAP(devsec_stream_ids, NR_TSM_STREAMS);
+static struct pci_ide *devsec_streams[NR_TSM_STREAMS];
+
+static unsigned long *alloc_devsec_stream_id(unsigned long *stream_id)
+{
+	unsigned long id;
+
+	id = find_first_zero_bit(devsec_stream_ids, NR_TSM_STREAMS);
+	if (id == NR_TSM_STREAMS)
+		return NULL;
+	set_bit(id, devsec_stream_ids);
+	*stream_id = id;
+	return stream_id;
+}
+DEFINE_FREE(free_devsec_stream, unsigned long *, if (_T) clear_bit(*_T, devsec_stream_ids))
+
 /*
  * Reference consumer for a TSM driver "connect" operation callback. The
  * low-level TSM driver understands details about the platform the PCI
@@ -135,11 +153,61 @@ static void devsec_link_tsm_pci_remove(struct pci_tsm *tsm)
  */
 static int devsec_link_tsm_connect(struct pci_dev *pdev)
 {
-	return -ENXIO;
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	unsigned long __stream_id;
+	int rc;
+
+	unsigned long *stream_id __free(free_devsec_stream) =
+		alloc_devsec_stream_id(&__stream_id);
+	if (!stream_id)
+		return -EBUSY;
+
+	struct pci_ide *ide __free(pci_ide_stream_release) =
+		pci_ide_stream_alloc(pdev);
+	if (!ide)
+		return -ENOMEM;
+
+	ide->stream_id = *stream_id;
+	rc = pci_ide_stream_register(ide);
+	if (rc)
+		return rc;
+
+	pci_ide_stream_setup(pdev, ide);
+	pci_ide_stream_setup(rp, ide);
+
+	rc = tsm_ide_stream_register(ide);
+	if (rc)
+		return rc;
+
+	/*
+	 * Model a TSM that handled enabling the stream at
+	 * tsm_ide_stream_register() time
+	 */
+	rc = pci_ide_stream_enable(pdev, ide);
+	if (rc)
+		return rc;
+
+	devsec_streams[*no_free_ptr(stream_id)] = no_free_ptr(ide);
+
+	return 0;
 }
 
 static void devsec_link_tsm_disconnect(struct pci_dev *pdev)
 {
+	struct pci_ide *ide;
+	unsigned long i;
+
+	for_each_set_bit(i, devsec_stream_ids, NR_TSM_STREAMS)
+		if (devsec_streams[i]->pdev == pdev)
+			break;
+
+	if (i >= NR_TSM_STREAMS)
+		return;
+
+	ide = devsec_streams[i];
+	devsec_streams[i] = NULL;
+	pci_ide_stream_release(ide);
+	clear_bit(i, devsec_stream_ids);
 }
 
 static struct pci_tsm_ops devsec_link_pci_ops = {
-- 
2.52.0

