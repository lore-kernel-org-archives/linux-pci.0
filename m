Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2684A0C
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980538; cv=none; b=q3A5sNzgXxOZMhKjXKep8aRVSVR/VrSOUCmaBdaeDG+kqZRySOPJpQDF9++EWtiDNP8eCgUVJN8pwqe36jRz94LF4NiB6FPtS76Yut/ZB9x32C6JIdFDb8VXGK1iyjTYiUAs8Uoax1eV/5gtkMxFK3SNTzNse8Et2WzY2bRDshQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980538; c=relaxed/simple;
	bh=jT5JK8lcia/MoaLiC7fPGHdSmEV0EutDgR8dUanQRJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVOlD5lSF36zU79mlX+uoQUKJ42nLy9hWhuELoCWm3CUvODHgpD0kvXyVGEdCHPCrNgFyQsk2C2tauUV1/1O6xQAhUUlRL5F75P3sXIJbzq1AhVjeVvqLjv/GxM6cfzUg/dWlkF6Cly/YAYowgosLYOjf+RJok2FFAx+4gFmQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktc1Tk51; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktc1Tk51"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783980536; x=1815516536;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jT5JK8lcia/MoaLiC7fPGHdSmEV0EutDgR8dUanQRJo=;
  b=ktc1Tk51LNzoNbWHNtrj4XphSQOY6fup71iv5McIEdWQMMDJsEWpDgT9
   NmTtJLcdx96YsG3NgCj6/NxnpgEQsXMEoLwIIBFdA6NkCDbQCXQRagSJ3
   1V6kTfqblXecXUoj/xV4gCi6WJj1MKdS7ltVxiKaJUYi/q1zqvkwzqHX8
   bq3PbKaVYDYYKfE8wdicjebZ2Tdzn1vBl1RsctV/UXm87G2zv6GcI8fZd
   ihafdTl7tDmOKGKzvVQ1sgG/MJZfGNHicR4VlbIvXNXkM7JhounQpcrfk
   xLQYyIwK292c+Oh1ydt5qlAUwxv9Flobt5a65/6Z05j8y5tfsD9YCaoHO
   A==;
X-CSE-ConnectionGUID: SJKVo8zTR32B81bC36m4ww==
X-CSE-MsgGUID: /X6F7POMT/O3xi8rgmSyUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83716490"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83716490"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 15:08:56 -0700
X-CSE-ConnectionGUID: FK8PasSyShawzh60xZKUjQ==
X-CSE-MsgGUID: yX20BwL8SrSryxbrLsyBmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254548340"
Received: from zp3110c002s0704.zpn.intel.com ([10.219.117.38])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 15:08:54 -0700
From: Nirmal Patel <nirmal.patel@intel.com>
To: nirmal.patel@intel.com,
	<linux-pci@vger.kernel.org>
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	lpieralisi@kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3] PCI: vmd: Only assign OSC features in bare metal OS
Date: Mon, 13 Jul 2026 22:08:44 +0000
Message-ID: <20260713220844.561357-1-nirmal.patel@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy valid OSC flags from root bridge only when OS can provide correct
values. In virtual machine, all of the control features are disabled as
hypervisor will not passthrough root bridge information to VM.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by:  Andy Shevchenko <andriy.shevchenko@intel.com>
---
v3 : Removed period from commit and added a black line.
v2 : Added descriptive boolean and removed period from commit message.
---
---
 drivers/pci/controller/vmd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d4ae250d4bc6..7c7d110290d6 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -782,6 +782,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	resource_size_t membar2_offset = 0x2000;
 	struct pci_bus *child;
 	struct pci_dev *dev;
+	bool vmd_in_guest;
 	int ret;
 
 	/*
@@ -862,14 +863,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		.parent = res,
 	};
 
+	/* Non-zero offset means guest/direct assign view. */
+	vmd_in_guest = offset[0] || offset[1];
+
 	/*
 	 * Currently MSI remapping must be enabled in guest passthrough mode
 	 * due to some missing interrupt remapping plumbing. This is probably
 	 * acceptable because the guest is usually CPU-limited and MSI
 	 * remapping doesn't become a performance bottleneck.
 	 */
-	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
-	    offset[0] || offset[1]) {
+	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) || vmd_in_guest) {
 		ret = vmd_alloc_irqs(vmd);
 		if (ret)
 			return ret;
@@ -910,8 +913,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		return -ENODEV;
 	}
 
-	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
-				   to_pci_host_bridge(vmd->bus->bridge));
+	/* Don't copy _OSC control flags in VM, it disables features. */
+	if (!vmd_in_guest)
+		vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
+					 to_pci_host_bridge(vmd->bus->bridge));
 
 	vmd_attach_resources(vmd);
 	if (vmd->irq_domain)
-- 
2.43.0

