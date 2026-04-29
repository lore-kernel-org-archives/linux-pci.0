Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC0939657D;
	Wed, 29 Apr 2026 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465671; cv=none; b=aFdhxn0w3AQsc/5GR5DGB1gpETACeTsHR7AvyMAAMZCu8Xmc9bp2LURIvmimBImwF6yizZnwRp0TtWXsvIyVLrC7aDQUHWM1PJeLpE6XgMpdSHk1yP5VGTLS5zatR/jijPihOApkpiLl8FgG0uL2rXArlAtfLb4YZ/9Gpe9jCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465671; c=relaxed/simple;
	bh=bA/bw4uk6IaI0FTLifNPnecs/kfGu2r52xBhz7Tz1C8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrotLXVs2BFV9aczKt+e6bjbOzaFbiDZoHeIvF8criskv9/iHhumw5uuDlmrYnJa+1G6VbLe8/kGhUcuSCiqHVP4rw5mhUtGp1Uu2fr2r/VbM0ugfjbiiQDM04lGTLd0A6TJC117ow1U83DyIWN76cq8Hc+ReflpAXHHnfTme+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZeZaYtzO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZeZaYtzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465670; x=1809001670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bA/bw4uk6IaI0FTLifNPnecs/kfGu2r52xBhz7Tz1C8=;
  b=ZeZaYtzOA0gpp9TTnfc9QyC89ZZLvM/3kOrc/oZOHD2kKQcW0/370ITo
   tix9BcxSZJgyL2zVZgZhhS6DRBfHGvJur31L48wEimQS8hrJ6gYrH0lWm
   bMZ/oQZxXFk23U1zBhaZnceDPFIiwFdFa5dIoA6gVVycp6NCF+jqP5ku/
   1tbH5GVmq1F1ra68xytzKR9gOKwKhKiioDh47tsHC2RzUbLug1kdGKioI
   JKdgOWKh+GC7TKwpyu6gMZxB9urM1BLP+fAmY6QMk5tGZ2Pz7+OX0GFkr
   Kb8kUh6FX1ZHA4S0wVbeT6PApRw9ZldeBd04KZOhmBEwjxp5OuM4IDeHr
   g==;
X-CSE-ConnectionGUID: a1z3ZFawSP+KFXI/seES4A==
X-CSE-MsgGUID: 1z7G4ulOQxKK7uJGNKlFUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78101842"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78101842"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:49 -0700
X-CSE-ConnectionGUID: BCDPRBVOSbePcbYVtec72A==
X-CSE-MsgGUID: SJlZA8uUQp+C/qrp8OS4Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="257573672"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 07/11] PCI: Make pci_sriov_resource_alignment() pci_dev const
Date: Wed, 29 Apr 2026 15:26:13 +0300
Message-Id: <20260429122617.7324-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
References: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_sriov_resource_alignment() inputs struct pci_dev which it should not
need to alter to calculate alignment.

Make pci_dev pci_sriov_resource_alignment() inputs const. It requires
making pci_iov_resource_size() input const as well.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/powerpc/include/asm/machdep.h         | 2 +-
 arch/powerpc/kernel/pci-common.c           | 2 +-
 arch/powerpc/platforms/powernv/pci-sriov.c | 4 ++--
 arch/powerpc/platforms/powernv/pci.h       | 3 ++-
 arch/powerpc/platforms/pseries/setup.c     | 2 +-
 drivers/pci/iov.c                          | 7 ++++---
 drivers/pci/pci.h                          | 5 +++--
 include/linux/pci.h                        | 8 +++++---
 8 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 3298eec123a3..256f9309bf4f 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -169,7 +169,7 @@ struct machdep_calls {
 
 #ifdef CONFIG_PCI_IOV
 	void (*pcibios_fixup_sriov)(struct pci_dev *pdev);
-	resource_size_t (*pcibios_iov_resource_alignment)(struct pci_dev *, int resno);
+	resource_size_t (*pcibios_iov_resource_alignment)(const struct pci_dev *, int resno);
 	int (*pcibios_sriov_enable)(struct pci_dev *pdev, u16 num_vfs);
 	int (*pcibios_sriov_disable)(struct pci_dev *pdev);
 #endif /* CONFIG_PCI_IOV */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 8efe95a0c4ff..3c4ca90e2ab7 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -254,7 +254,7 @@ resource_size_t pcibios_default_alignment(void)
 }
 
 #ifdef CONFIG_PCI_IOV
-resource_size_t pcibios_iov_resource_alignment(struct pci_dev *pdev, int resno)
+resource_size_t pcibios_iov_resource_alignment(const struct pci_dev *pdev, int resno)
 {
 	if (ppc_md.pcibios_iov_resource_alignment)
 		return ppc_md.pcibios_iov_resource_alignment(pdev, resno);
diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index 7105a573aec4..8652078801f2 100644
--- a/arch/powerpc/platforms/powernv/pci-sriov.c
+++ b/arch/powerpc/platforms/powernv/pci-sriov.c
@@ -244,8 +244,8 @@ void pnv_pci_ioda_fixup_iov(struct pci_dev *pdev)
 	}
 }
 
-resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
-						      int resno)
+resource_size_t pnv_pci_iov_resource_alignment(const struct pci_dev *pdev,
+					       int resno)
 {
 	resource_size_t align = pci_iov_resource_size(pdev, resno);
 	struct pnv_phb *phb = pci_bus_to_pnvhb(pdev->bus);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 032b2081aedb..3ac718d471c2 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -257,7 +257,8 @@ static inline struct pnv_iov_data *pnv_iov_get(const struct pci_dev *pdev)
 }
 
 void pnv_pci_ioda_fixup_iov(struct pci_dev *pdev);
-resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev, int resno);
+resource_size_t pnv_pci_iov_resource_alignment(const struct pci_dev *pdev,
+					       int resno);
 
 int pnv_pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs);
 int pnv_pcibios_sriov_disable(struct pci_dev *pdev);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index b670c6fdfcea..1223dc961242 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -789,7 +789,7 @@ static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
 		pseries_disable_sriov_resources(pdev);
 }
 
-static resource_size_t pseries_pci_iov_resource_alignment(struct pci_dev *pdev,
+static resource_size_t pseries_pci_iov_resource_alignment(const struct pci_dev *pdev,
 							  int resno)
 {
 	const __be32 *reg;
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9..c86409835f73 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -150,7 +150,7 @@ static void virtfn_remove_bus(struct pci_bus *physbus, struct pci_bus *virtbus)
 		pci_remove_bus(virtbus);
 }
 
-resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
+resource_size_t pci_iov_resource_size(const struct pci_dev *dev, int resno)
 {
 	if (!dev->is_physfn)
 		return 0;
@@ -1084,7 +1084,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno)
 	}
 }
 
-resource_size_t __weak pcibios_iov_resource_alignment(struct pci_dev *dev,
+resource_size_t __weak pcibios_iov_resource_alignment(const struct pci_dev *dev,
 						      int resno)
 {
 	return pci_iov_resource_size(dev, resno);
@@ -1100,7 +1100,8 @@ resource_size_t __weak pcibios_iov_resource_alignment(struct pci_dev *dev,
  * the VF BAR size multiplied by the number of VFs.  The alignment
  * is just the VF BAR size.
  */
-resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
+resource_size_t pci_sriov_resource_alignment(const struct pci_dev *dev,
+					     int resno)
 {
 	return pcibios_iov_resource_alignment(dev, resno);
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4fcf5a25ad9e..710803be3a79 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -947,7 +947,8 @@ int pci_iov_init(struct pci_dev *dev);
 void pci_iov_release(struct pci_dev *dev);
 void pci_iov_remove(struct pci_dev *dev);
 void pci_iov_update_resource(struct pci_dev *dev, int resno);
-resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
+resource_size_t pci_sriov_resource_alignment(const struct pci_dev *dev,
+					     int resno);
 void pci_restore_iov_state(struct pci_dev *dev);
 int pci_iov_bus_range(struct pci_bus *bus);
 void pci_iov_resource_set_size(struct pci_dev *dev, int resno, int size);
@@ -981,7 +982,7 @@ static inline int pci_iov_init(struct pci_dev *dev)
 static inline void pci_iov_release(struct pci_dev *dev) { }
 static inline void pci_iov_remove(struct pci_dev *dev) { }
 static inline void pci_iov_update_resource(struct pci_dev *dev, int resno) { }
-static inline resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev,
+static inline resource_size_t pci_sriov_resource_alignment(const struct pci_dev *dev,
 							   int resno)
 {
 	return 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..0ced3bbd08c0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2540,7 +2540,7 @@ int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 int pci_sriov_get_totalvfs(struct pci_dev *dev);
 int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn);
-resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
+resource_size_t pci_iov_resource_size(const struct pci_dev *dev, int resno);
 int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size);
 u32 pci_iov_vf_bar_get_sizes(struct pci_dev *dev, int resno, int num_vfs);
 void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
@@ -2548,7 +2548,8 @@ void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
 /* Arch may override these (weak) */
 int pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs);
 int pcibios_sriov_disable(struct pci_dev *pdev);
-resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
+resource_size_t pcibios_iov_resource_alignment(const struct pci_dev *dev,
+					       int resno);
 #else
 static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
 {
@@ -2593,7 +2594,8 @@ static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
 { return 0; }
 #define pci_sriov_configure_simple	NULL
-static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
+static inline resource_size_t pci_iov_resource_size(const struct pci_dev *dev,
+						    int resno)
 { return 0; }
 static inline int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size)
 { return -ENODEV; }
-- 
2.39.5

