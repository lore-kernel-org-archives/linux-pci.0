Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F323D4973A0
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398948; cv=none; b=By4KupOIDCOUXpNUExG83vQlJAZMSR8uNtfTiP6XUWVtpPgZJ19chG1UnPt3CLkqWflh5YFqlYg6d1C8JPV53PDb3qZ/QeiSzDyJK3HqDonXiSIq4aJXQzIVicpnCcQMBiiHcsawnNNmy1bkgxHnwRJtHKUNyBeTGcy2APeItC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398948; c=relaxed/simple;
	bh=FTJ4N54R6NJvwv48j3HnRg3hPkhS8TJSmAIVPcSR/w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0jNYJv2Y8XEq5k69zL3VPFpgyPqivXlf5S37daDUyC/yTlvZI8kbHEnsx3Ja5kW+GsHokHz7aQlU5KVI4LJsbDHaYRQ/O9w9lzNrwwwVPo5hIjFdOF5WmvCfOdDyOU8ZaZPGqkVUuwmVZGeAaUjQwJmSpF4sDo+qrCJVJZ5an4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5x7NO3B; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5x7NO3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792398942; x=1823934942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FTJ4N54R6NJvwv48j3HnRg3hPkhS8TJSmAIVPcSR/w4=;
  b=Q5x7NO3BYO96r0ZWgclrGgOFBnNdRY3E+wvIv/gtZl9fLAf0l4jKd93b
   YtWwPEW+D1LhvhUKOFX8QUgAbcilR83w6dCfF7MBIys2UwfgxuI+U4NSW
   bpOAUjEZsJFapEoyN/GS4Du28bS0fAlDWf8jZnNGv+aVVZgwP7g5KTost
   13sn011/ujm+oubzae4UF6fEQZ5ijzD0cxuhVpyttgGqRZ56l45u/0pJN
   e5zotEYO7wsOjuwCc6YNBKvC1SvBMUmBerERmKhoSGyxL2mVsEcS02RMQ
   +Of83pRyUQ41ddV8pY6ymjFJe6nq9vyExIysjeUQnydRpT/9dcbsSA1Bv
   A==;
X-CSE-ConnectionGUID: hsCpd8exRnWCSXAH5P/Gew==
X-CSE-MsgGUID: fQjO8X0bSMGUJsxoZA/p2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1061712"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1061712"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:35:42 -0700
X-CSE-ConnectionGUID: XyM4Y8VgQ7+ve/ZEZ8vkpQ==
X-CSE-MsgGUID: ZYgVizO8R6KPLAT5R8OGjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2857751"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:35:39 -0700
From: Lukasz Laguna <lukasz.laguna@intel.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com
Cc: michal.winiarski@intel.com,
	djbw@kernel.org,
	brett.creeley@amd.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Subject: [PATCH v1 03/13] PCI/IOV: Introduce VF locking helpers
Date: Mon, 19 Oct 2026 10:35:04 +0200
Message-ID: <20261019083514.838640-4-lukasz.laguna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019083514.838640-1-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pci_dev_lock_vfs() and pci_dev_unlock_vfs() helpers to lock and
unlock all enabled VFs of a PF device.

This provides a common way to serialize operations involving
subordinate VFs.

Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 drivers/pci/pci.c   | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a62af7320539..f1669f88e768 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5111,6 +5111,45 @@ void pci_dev_unlock(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_dev_unlock);
 
+/**
+ * pci_dev_lock_vfs() - Lock subordinate VFs of a PF device
+ * @dev: PCI device whose VFs should be locked
+ *
+ * Lock all currently enabled VFs in forward iteration order.
+ *
+ * Context: The caller must hold the device lock of @dev.
+ */
+void pci_dev_lock_vfs(struct pci_dev *dev)
+{
+	struct pci_dev *vf;
+
+	device_lock_assert(&dev->dev);
+
+	for_each_pci_vf(dev, vf)
+		pci_dev_lock(vf);
+}
+EXPORT_SYMBOL_GPL(pci_dev_lock_vfs);
+
+/**
+ * pci_dev_unlock_vfs() - Unlock subordinate VFs of a PF device
+ * @dev: PCI device whose VFs should be unlocked
+ *
+ * Unlock all currently enabled VFs in reverse iteration order of
+ * pci_dev_lock_vfs().
+ *
+ * Context: The caller must hold the device lock of @dev and all its VFs.
+ */
+void pci_dev_unlock_vfs(struct pci_dev *dev)
+{
+	struct pci_dev *vf;
+
+	device_lock_assert(&dev->dev);
+
+	for_each_pci_vf_reverse(dev, vf)
+		pci_dev_unlock(vf);
+}
+EXPORT_SYMBOL_GPL(pci_dev_unlock_vfs);
+
 static void pci_dev_save_and_disable(struct pci_dev *dev)
 {
 	const struct pci_error_handlers *err_handler =
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 03fe10ffa19b..718d17035439 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2097,6 +2097,8 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
 void pci_dev_lock(struct pci_dev *dev);
 int pci_dev_trylock(struct pci_dev *dev);
 void pci_dev_unlock(struct pci_dev *dev);
+void pci_dev_lock_vfs(struct pci_dev *dev);
+void pci_dev_unlock_vfs(struct pci_dev *dev);
 DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
 
 /*
-- 
2.43.0

