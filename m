Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117116;
	b=Xvzb3Im3q6SsSUbKc1TrdaSh3w7Ffn3bWNWpCkVfjFPjmaGgPppPyqZXwzQCzlpkWtv9
	 oJs5BZAq8q6xSOnxfieiWu4yub0hmJY7KFrLnBvk3nCcbKBYD93MiaeqPmD9IRWKn0/BL
	 yQCWKp68VGDvHYBs7IkG2L44HHQgJftD6abVqLmZN7o1C5rxNbjEYfhK2A0KvoBYVR33g
	 oySFmSSo467rOTLQtFxM/pUUrzipGZofCL7bx01damHd/xkhm8Pd1zXV6WgLbzQmwTO5M
	 l4n6+bIqwvCiDjpDeZsSL9iTpmB846f8hW/gcOqo/lyyefwytzAPlgmSy/i5PFnp8cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117116;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HhNo9RbvhSPsoI27qgc94K8E+rfET6/Gw2qIOGOAgQY=;
	b=VlxLCfLTBUNDLReIEA8x8dvXSK6g1lpJtpUZYB+Pn+r/FMyLlDTF3npHdV2lulyTJfO9
	 Zrf+NUj7XNa/HT5poJ9bKIW84BdnS/wca7ZxxVlIlsqoyNE6h2EYKl4f62u5zn+gM+UX5
	 7PL3fDnEWDXHKKK8UO6XS+O2eraMO022NvKVJoDgdttmnVwJUUAa9l/w/0qUUQDsn+BAK
	 3okv/Q8EFmpck8w6Fh/lVAFdDaU9oMgKK45L+QNX1lZomdc0ld5xo8McfuHPK0WP+0oAs
	 QHq1vQBgB98TVfrHSUpBbzIIymzzRjj+GyYaYXCOc7axhHHwMhotgvnkmIJMFsS1aFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oFvARCaI;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6960A2630
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34D6960A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oFvARCaI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117116; x=1824653116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UjJmGtHRj+byCY5SwDazErKdFJMauvbTv9EbmmXW/YA=;
  b=oFvARCaIuGQxraoA/YiTza1YdRAh5ZpcjyuaT1nLAF2fZNshqIg5FpPm
   uIllQ6B2A1kdvkkt5yvXESupko5Pn/KrJbbzAxX8C7lJsiuOn892l0XVk
   Ee7EMHSsAV9muye1UexG7hBitVpxIcLfavjhHnB13t8RXDqJv0H8reP2H
   625Nk+4z5jdivo7yxFQ/yHpHKiDz1HSIGHyn3MDRTnRL6NQKFCunEl9Jv
   7DqxPvw6EJfUVrTmNeyAlS2JFRVKTQeX3F3C+CzQgSZuCpejCU6oWLPEq
   9dyEdm3k2Q04Bh8yG9M8b9EePH2uKklippoVZKxNXOxvpVD/HpprBhQoo
   Q==;
X-CSE-ConnectionGUID: 6QJoi5IxTUqsKEw4JdiqXA==
X-CSE-MsgGUID: WD/5yneRSKG0OvXRFXCtbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1852205"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1852205"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:05:15 -0700
X-CSE-ConnectionGUID: 1fu8KJiVRIuDoMixtJypJA==
X-CSE-MsgGUID: 9NBlnfDuT1K3yEMqtlsgzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="5111823"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:05:12 -0700
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
Subject: [PATCH v2 03/13] PCI/IOV: Introduce VF locking helpers
Date: Tue, 27 Oct 2026 17:04:36 +0100
Message-ID: <20261027160446.858300-4-lukasz.laguna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027160446.858300-1-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
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
index 07399cfbb0e2..e524cee77457 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5131,6 +5131,45 @@ void pci_dev_unlock(struct pci_dev *dev)
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
index f5930cf5b03f..13d4acdfe79e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2098,6 +2098,8 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
 void pci_dev_lock(struct pci_dev *dev);
 int pci_dev_trylock(struct pci_dev *dev);
 void pci_dev_unlock(struct pci_dev *dev);
+void pci_dev_lock_vfs(struct pci_dev *dev);
+void pci_dev_unlock_vfs(struct pci_dev *dev);
 DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
 
 /*
-- 
2.43.0

