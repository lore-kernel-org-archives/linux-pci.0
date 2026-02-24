Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70829156F45
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931456; cv=none; b=jxtKEjS70OcjOXAD0KNIhBjWUnYO7Bi/X6ooOlIARkbEEJfxc1ZYEf4xv+AegftwJM/GV/i8uVg+N9sX3nZZwvhD2D9XkJ0/RZe/vZnIc0U0X/oRlUiMvBCXgaupIov6JIu/hjhnkkSOKu/gRtd3L9wrFm1EC/GLR+04qgf3vQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931456; c=relaxed/simple;
	bh=Nx43f3p0wM+lMNlN3Kkqeor3DPzX52qzSrgORMn8EsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8BXeK0sZgw+sKcWk0NYFvCR5xBor9hkHzgNBCoMp4mAGKxovgZvq/MV8tWsRJMATRcpvWxFC/ekZOh+SL4E9XV3UKDTk3EX2xG5tvFCksc+QsToZAYORA0RQek/i+N0Df1KL8vhgkyOO0OLz0CRjiOWJryj6cTbYdOvPBcxzlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfPJ64Na; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfPJ64Na"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771931455; x=1803467455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nx43f3p0wM+lMNlN3Kkqeor3DPzX52qzSrgORMn8EsU=;
  b=nfPJ64NaequjHTuGGQltkN6V0IUFrj1Zj7xhePkduRCXNDszlJJVpj6q
   VBPY3xKef0KywQhNsA4wn9W4rBuaPUMln+hSe2QM0VR6YqTxTMQ3pVPuG
   mab398eE0mAXp/x5AvP+rUgrUCt50Wc8Rx5YWaZZhraVhvaSVQQGFme2T
   B5oCh+Ze6RCOZ16hd72jOV/zSNC7vfpyeDykLsQQ5TQ0cFbZmWmD9RhB9
   V45AaD9a+y3lK053Z+lGxwifh2Wk/mJmT2F0uUXk3mLDFgP4bw/5z2wGS
   ugCUcqfcQMmRQn/3inJmy1/0dUctJG+wuCrsi+0mrhfqO2V6M2pjJgeNF
   w==;
X-CSE-ConnectionGUID: xioLVnNiSr+jIb2wLeUzvg==
X-CSE-MsgGUID: hQ6Lt9nDRjSPoD3fgNr9cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="71974280"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="71974280"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 03:10:55 -0800
X-CSE-ConnectionGUID: s1nPANqzQyykN4lynBSZJA==
X-CSE-MsgGUID: jVhs4F/jSFK92aVLDpzhPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="216037820"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 24 Feb 2026 03:10:50 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 2989DA1; Tue, 24 Feb 2026 12:10:44 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 5/5] PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports
Date: Tue, 24 Feb 2026 12:10:44 +0100
Message-ID: <20260224111044.3487873-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
References: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we enable PTM automatically for Root and Switch Upstream Ports
if the advertised capabilities support the relevant role. However, there
are few issues with this. First of all if there is no Endpoint that
actually needs the PTM functionality, this is just wasting link
bandwidth. There are just a couple of drivers calling pci_ptm_enable()
in the tree.

Secondly we do the enablement in pci_ptm_init() that is called pretty
early for the Switch Upstream Port before Downstream Ports are even
enumerated. Since the Upstream Port configuration affects the whole
Switch enabling it this early might cause the PTM requests to be sent
already. We actually do see effect of this:

  pcieport 0000:00:07.1: pciehp: Slot(6-1): Card present
  pcieport 0000:00:07.1: pciehp: Slot(6-1): Link Up
  pci 0000:2c:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Upstream Port
  pci 0000:2c:00.0: PCI bridge to [bus 00]
  pci 0000:2c:00.0:   bridge window [io  0x0000-0x0fff]
  pci 0000:2c:00.0:   bridge window [mem 0x00000000-0x000fffff]
  pci 0000:2c:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
  ...
  pci 0000:2c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
  pci 0000:2c:00.0: PTM enabled, 4ns granularity

At this point we have only enumerated the Switch Upstream Port and now
PTM got enabled which immediately triggers flood of these:

  pcieport 0000:00:07.1: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.1
  pcieport 0000:00:07.1: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
  pcieport 0000:00:07.1:   device [8086:d44f] error status/mask=00200000/00000000
  pcieport 0000:00:07.1:    [21] ACSViol                (First)
  pcieport 0000:00:07.1: AER:   TLP Header: 0x34000000 0x00000052 0x00000000 0x00000000
  pcieport 0000:00:07.1: AER: device recovery successful
  pcieport 0000:00:07.1: AER: Uncorrectable (Non-Fatal) error message received from 0000:00:07.1

In the above TLP Header the Requester ID is 0 which rightfully triggers
an error as we have ACS Source Validation enabled.

For this reason change the PTM enablement to happen at the time
pci_enable_ptm() is called. It will try to enable PTM first for upstream
devices before enabling for the Endpoint itself. For disable path we
need to keep count of how many times PTM has been enabled and disable
only on the last so change the dev->ptm_enabled to a counter (and rename
it to dev->ptm_enable_cnt analogous to dev->pci_enable_cnt).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/ptm.c | 68 ++++++++++++++++++++++++------------------
 include/linux/pci.h    |  2 +-
 2 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 2c848ae4f15f..a41ffd1914de 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -52,6 +52,7 @@ void pci_ptm_init(struct pci_dev *dev)
 		return;
 
 	dev->ptm_cap = ptm;
+	atomic_set(&dev->ptm_enable_cnt, 0);
 	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u32));
 
 	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
@@ -85,10 +86,6 @@ void pci_ptm_init(struct pci_dev *dev)
 		dev->ptm_responder = 1;
 	if (cap & PCI_PTM_CAP_REQ)
 		dev->ptm_requester = 1;
-
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
-		pci_enable_ptm(dev);
 }
 
 void pci_save_ptm_state(struct pci_dev *dev)
@@ -129,26 +126,11 @@ void pci_restore_ptm_state(struct pci_dev *dev)
 static int __pci_enable_ptm(struct pci_dev *dev)
 {
 	u16 ptm = dev->ptm_cap;
-	struct pci_dev *ups;
 	u32 ctrl;
 
 	if (!ptm)
 		return -EINVAL;
 
-	/*
-	 * A device uses local PTM Messages to request time information
-	 * from a PTM Root that's farther upstream.  Every device along the
-	 * path must support PTM and have it enabled so it can handle the
-	 * messages.  Therefore, if this device is not a PTM Root, the
-	 * upstream link partner must have PTM enabled before we can enable
-	 * PTM.
-	 */
-	if (!dev->ptm_root) {
-		ups = pci_upstream_ptm(dev);
-		if (!ups || !ups->ptm_enabled)
-			return -EINVAL;
-	}
-
 	switch (pci_pcie_type(dev)) {
 	case PCI_EXP_TYPE_ROOT_PORT:
 		if (!dev->ptm_root)
@@ -193,11 +175,35 @@ int pci_enable_ptm(struct pci_dev *dev)
 	int rc;
 	char clock_desc[8];
 
+	/*
+	 * A device uses local PTM Messages to request time information
+	 * from a PTM Root that's farther upstream. Every device along
+	 * the path must support PTM and have it enabled so it can
+	 * handle the messages. Therefore, if this device is not a PTM
+	 * Root, the upstream link partner must have PTM enabled before
+	 * we can enable PTM.
+	 */
+	if (!dev->ptm_root) {
+		struct pci_dev *parent;
+
+		parent = pci_upstream_ptm(dev);
+		if (!parent)
+			return -EINVAL;
+		/* Enable PTM for the parent */
+		rc = pci_enable_ptm(parent);
+		if (rc)
+			return rc;
+	}
+
+	/* Already enabled? */
+	if (atomic_inc_return(&dev->ptm_enable_cnt) > 1)
+		return 0;
+
 	rc = __pci_enable_ptm(dev);
-	if (rc)
+	if (rc) {
+		atomic_dec(&dev->ptm_enable_cnt);
 		return rc;
-
-	dev->ptm_enabled = 1;
+	}
 
 	switch (dev->ptm_granularity) {
 	case 0:
@@ -239,27 +245,31 @@ static void __pci_disable_ptm(struct pci_dev *dev)
  */
 void pci_disable_ptm(struct pci_dev *dev)
 {
-	if (dev->ptm_enabled) {
+	struct pci_dev *parent;
+
+	if (atomic_dec_and_test(&dev->ptm_enable_cnt))
 		__pci_disable_ptm(dev);
-		dev->ptm_enabled = 0;
-	}
+
+	parent = pci_upstream_ptm(dev);
+	if (parent)
+		pci_disable_ptm(parent);
 }
 EXPORT_SYMBOL(pci_disable_ptm);
 
 /*
- * Disable PTM, but preserve dev->ptm_enabled so we silently re-enable it on
+ * Disable PTM, but preserve dev->ptm_enable_cnt so we silently re-enable it on
  * resume if necessary.
  */
 void pci_suspend_ptm(struct pci_dev *dev)
 {
-	if (dev->ptm_enabled)
+	if (atomic_read(&dev->ptm_enable_cnt))
 		__pci_disable_ptm(dev);
 }
 
 /* If PTM was enabled before suspend, re-enable it when resuming */
 void pci_resume_ptm(struct pci_dev *dev)
 {
-	if (dev->ptm_enabled)
+	if (atomic_read(&dev->ptm_enable_cnt))
 		__pci_enable_ptm(dev);
 }
 
@@ -268,7 +278,7 @@ bool pcie_ptm_enabled(struct pci_dev *dev)
 	if (!dev)
 		return false;
 
-	return dev->ptm_enabled;
+	return atomic_read(&dev->ptm_enable_cnt);
 }
 EXPORT_SYMBOL(pcie_ptm_enabled);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8aaa72dcb164..7e49d35d81a5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -518,7 +518,7 @@ struct pci_dev {
 	unsigned int	ptm_root:1;
 	unsigned int	ptm_responder:1;
 	unsigned int	ptm_requester:1;
-	unsigned int	ptm_enabled:1;
+	atomic_t	ptm_enable_cnt;		/* pci_enable_ptm() has been called */
 	u8		ptm_granularity;
 #endif
 #ifdef CONFIG_PCI_MSI
-- 
2.50.1

