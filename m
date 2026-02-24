Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFDE37B3F7
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931454; cv=none; b=ptqERRPNBEDjVQwW8nTmPaRKcPOlYFC4e7EePB084XHCX7/G34GW1jGjrSt2fevXmK2etPNd2z0Dzhp7/0G0zuyDbBCv9VgcH/IUc3Q4LnnY4xKzAvP/bY5R4Zqws5G9CIHERB3TRwXfVcMriXdjWsATnALwZb0J1F0pfTAoaYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931454; c=relaxed/simple;
	bh=QKZD5okm1xqkM8oQst752FNnt6DZN162fiSZYKIDKYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYq54RnrdEzh+nyxOMS6/TBW+OemPSkeZv9Fs+OeTiyUPlme8s5AVxehhogsjvkhYRYsX2yyL9UZP6KPnpqwd6ZhlHpNM0Zd+ROH1kBqnWQ1PuZVplWuJuOAqi3GTK53NPWHIrd2p1suQHjfdXS5ruSAIYWbMQClHG+6NVaP+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLogq8ub; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLogq8ub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771931453; x=1803467453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QKZD5okm1xqkM8oQst752FNnt6DZN162fiSZYKIDKYE=;
  b=YLogq8ub2pk/MonFVaVLNsjlTxu9kddXmxtmO4u+OBdmpAwjcny5Czse
   qYZkNU3MJkzkF6M9oAtmzUZ6UgeT8CvZNUKQdMwcZ+LnP+6au4fQh4LdI
   LtQTvmMxR+GwPq2X+TkFnW+daXThPApqfXDrqq1FUZyGS398vkmdY4XPx
   7mfSX36B6HNrOag/RC05IR11T8V3DEaV24kXDB+RzrZshwzosFjbkPwKG
   goUjEeHnW97CrNv56MlpmP5VJbMspihD5KM7GECyio+dp1fAV14AydfnJ
   B0GWWHB4R7ohmAfQzA8uqK23Us0iacr6FsQH44/Rx4SUVCjc4hEg289rR
   g==;
X-CSE-ConnectionGUID: hTPB/2ZrQNOlE2Z0gfJ3FA==
X-CSE-MsgGUID: a/vCa9r9TX20R13vMYMwSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="71974269"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="71974269"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 03:10:51 -0800
X-CSE-ConnectionGUID: EvVGT46fTLGP6NSmhSxlbg==
X-CSE-MsgGUID: yMJFeygtSkalUPvVEKcnxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="216037802"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 24 Feb 2026 03:10:46 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 25D989E; Tue, 24 Feb 2026 12:10:44 +0100 (CET)
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
Subject: [PATCH 4/5] PCI/PTM: Drop granularity parameter from pci_enable_ptm()
Date: Tue, 24 Feb 2026 12:10:43 +0100
Message-ID: <20260224111044.3487873-5-mika.westerberg@linux.intel.com>
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

This is not used by any of the existing callers so we can simplify the
function slightly and get rid of that.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c      |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c    |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c      |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c |  2 +-
 drivers/pci/pcie/ptm.c                         | 11 +++--------
 include/linux/pci.h                            |  4 ++--
 6 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ebf48feffb30..b35c4e4ecd2a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5028,7 +5028,7 @@ static int ice_init(struct ice_pf *pf)
 	}
 
 	if (pf->hw.mac_type == ICE_MAC_E830) {
-		err = pci_enable_ptm(pf->pdev, NULL);
+		err = pci_enable_ptm(pf->pdev);
 		if (err)
 			dev_dbg(dev, "PCIe PTM not supported by PCIe bus/controller\n");
 	}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 0dd741dcfcdb..ab3c409e587b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -257,7 +257,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_free;
 	}
 
-	err = pci_enable_ptm(pdev, NULL);
+	err = pci_enable_ptm(pdev);
 	if (err)
 		pci_dbg(pdev, "PCIe PTM is not supported by PCIe bus/controller\n");
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 84f5d92c81cc..291222b06915 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7124,7 +7124,7 @@ static int igc_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_pci_reg;
 
-	err = pci_enable_ptm(pdev, NULL);
+	err = pci_enable_ptm(pdev);
 	if (err < 0)
 		dev_info(&pdev->dev, "PCIe PTM not supported by PCIe bus/controller\n");
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index fdc3ba20912e..0b94d4ed0ef6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -960,7 +960,7 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
 
 	mlx5_pci_vsc_init(dev);
 
-	pci_enable_ptm(pdev, NULL);
+	pci_enable_ptm(pdev);
 
 	return 0;
 
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 91a598ed534c..2c848ae4f15f 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -88,7 +88,7 @@ void pci_ptm_init(struct pci_dev *dev)
 
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
 	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
-		pci_enable_ptm(dev, NULL);
+		pci_enable_ptm(dev);
 }
 
 void pci_save_ptm_state(struct pci_dev *dev)
@@ -182,15 +182,13 @@ static int __pci_enable_ptm(struct pci_dev *dev)
 /**
  * pci_enable_ptm() - Enable Precision Time Measurement
  * @dev: PCI device
- * @granularity: pointer to return granularity
  *
- * Enable Precision Time Measurement for @dev.  If successful and
- * @granularity is non-NULL, return the Effective Granularity.
+ * Enable Precision Time Measurement for @dev.
  *
  * Return: zero if successful, or -EINVAL if @dev lacks a PTM Capability or
  * is not a PTM Root and lacks an upstream path of PTM-enabled devices.
  */
-int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
+int pci_enable_ptm(struct pci_dev *dev)
 {
 	int rc;
 	char clock_desc[8];
@@ -201,9 +199,6 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 
 	dev->ptm_enabled = 1;
 
-	if (granularity)
-		*granularity = dev->ptm_granularity;
-
 	switch (dev->ptm_granularity) {
 	case 0:
 		snprintf(clock_desc, sizeof(clock_desc), "unknown");
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..8aaa72dcb164 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1975,11 +1975,11 @@ struct pci_ptm_debugfs {
 };
 
 #ifdef CONFIG_PCIE_PTM
-int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
+int pci_enable_ptm(struct pci_dev *dev);
 void pci_disable_ptm(struct pci_dev *dev);
 bool pcie_ptm_enabled(struct pci_dev *dev);
 #else
-static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
+static inline int pci_enable_ptm(struct pci_dev *dev)
 { return -EINVAL; }
 static inline void pci_disable_ptm(struct pci_dev *dev) { }
 static inline bool pcie_ptm_enabled(struct pci_dev *dev)
-- 
2.50.1

