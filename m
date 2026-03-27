Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED834FF4D;
	Fri, 27 Mar 2026 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628625; cv=none; b=O1JFvtCW7UJXqvhqOzinYsXI1jfjDYE6iFZ06DwSIfe5egO9ymJahPdp+1XYuAG3OU/z3aXLRNLcaC4QCvMixTYAOT0vd8r542v7NPu8Df/MF6aJCNxPlMVHod41Y61OSIRoxLMRjR7z3MHz5TajtQ/Cga10S+jj9oC66SehaUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628625; c=relaxed/simple;
	bh=dJBSY5nZlLW3s/69xR3iEOmBKQ+myKH7t2obUbqnFKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKLmHCgPgJghzlhZ/MQmdX6jwcmn+pYy0g9VJsOpRmj9Wjqrvk8IufaB6Y12nZ9J6dBFwp6HBT/XW79zmQg4acK+YusejzOyG4P4p5dJ7UYBSZmI35mZ64B7fN8dKUi7su338alg29+Nh9aJrNB709NEivmBT/UA9XBVb4mX2js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/UpO+UC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/UpO+UC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628624; x=1806164624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dJBSY5nZlLW3s/69xR3iEOmBKQ+myKH7t2obUbqnFKg=;
  b=m/UpO+UChNkfF1uUqdmIKV8Ct3qrbmFO3h4zDtEPcFvmx8nsjpg0lbDg
   JaO0dnrZYODoNgcXfDjmNaIIFj/83G7HlbNTpK1Ut08oE91OwX0Swh54w
   w9AIfD/xGqE0tmcGtj/rXSfI94Xs6zG+cP/058awL+8gwDZfmRnhDOlRe
   k+uVsXfTs56tplRFXxGVhZeciO+8B8swT9sLEij/0dMZ6BzmLnbZ0J+5B
   wbVfXqkFkAZIuu4kjeyhDDGPBBPbzwc29TKhpTLMH4ckLxeYckJ5iPOja
   kdTZiDoxldKdWM91XTknlmvlpw7IBiMXWIx2YOJN1vcoXQhi2o5z3EYR8
   Q==;
X-CSE-ConnectionGUID: VJVUh5ytS8OEqrFzIKWmNw==
X-CSE-MsgGUID: sllwQ513T6WModCw+dj9aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565634"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565634"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:23:43 -0700
X-CSE-ConnectionGUID: IEKcN4BnRUCescArNhzMNQ==
X-CSE-MsgGUID: B9AlSQTAS4eNwRJhspnjug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516311"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:23:40 -0700
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
Subject: [PATCH v2 19/31] iommu/vt-d: Reserve the MSB domain ID bit for the TDX module
Date: Sat, 28 Mar 2026 00:01:20 +0800
Message-Id: <20260327160132.2946114-20-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

The Intel TDX Connect Architecture Specification defines some enhancements
for the VT-d architecture to introduce IOMMU support for TEE-IO requests.
Section 2.2, 'Trusted DMA' states that:

"I/O TLB and DID Isolation – When IOMMU is enabled to support TDX
Connect, the IOMMU restricts the VMM’s DID setting, reserving the MSB bit
for the TDX module. The TDX module always sets this reserved bit on the
trusted DMA table. IOMMU tags IOTLB, PASID cache, and context entries to
indicate whether they were created from TEE-IO transactions, ensuring
isolation between TEE and non-TEE requests in translation caches."

Reserve the MSB in the domain ID for the TDX module's use if the
enhancement is required, which is detected if the ECAP.TDXCS bit in the
VT-d extended capability register is set and the TVM Usable field of the
ACPI KEYP table is set.

Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  1 +
 drivers/iommu/intel/dmar.c  | 52 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 4a21ab6a311d..0c2b4e38dee7 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -192,6 +192,7 @@
  */
 
 #define ecap_pms(e)		(((e) >> 51) & 0x1)
+#define ecap_tdxc(e)		(((e) >> 50) & 0x1)
 #define ecap_rps(e)		(((e) >> 49) & 0x1)
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 93efd1a5dc5b..4f9571eee1d4 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1033,6 +1033,56 @@ static int map_iommu(struct intel_iommu *iommu, struct dmar_drhd_unit *drhd)
 	return err;
 }
 
+static int keyp_config_unit_tvm_usable(union acpi_subtable_headers *header,
+				       void *arg, const unsigned long end)
+{
+	struct acpi_keyp_config_unit *acpi_cu =
+		(struct acpi_keyp_config_unit *)&header->keyp;
+	int *tvm_usable = arg;
+
+	if (acpi_cu->flags & ACPI_KEYP_F_TVM_USABLE)
+		*tvm_usable = 1;
+
+	return 0;
+}
+
+static bool platform_is_tdxc_enhanced(void)
+{
+	static int tvm_usable = -1;
+	int ret;
+
+	/* only need to parse once */
+	if (tvm_usable != -1)
+		return !!tvm_usable;
+
+	tvm_usable = 0;
+	ret = acpi_table_parse_keyp(ACPI_KEYP_TYPE_CONFIG_UNIT,
+				    keyp_config_unit_tvm_usable, &tvm_usable);
+	if (ret < 0)
+		tvm_usable = 0;
+
+	return !!tvm_usable;
+}
+
+static unsigned long iommu_max_domain_id(struct intel_iommu *iommu)
+{
+	unsigned long ndoms = cap_ndoms(iommu->cap);
+
+	/*
+	 * Intel TDX Connect Architecture Specification, Section 2.2 Trusted DMA
+	 *
+	 * When IOMMU is enabled to support TDX Connect, the IOMMU restricts
+	 * the VMM’s DID setting, reserving the MSB bit for the TDX module. The
+	 * TDX module always sets this reserved bit on the trusted DMA table.
+	 */
+	if (ecap_tdxc(iommu->ecap) && platform_is_tdxc_enhanced()) {
+		pr_info_once("Most Significant Bit of domain ID reserved.\n");
+		return ndoms >> 1;
+	}
+
+	return ndoms;
+}
+
 static int alloc_iommu(struct dmar_drhd_unit *drhd)
 {
 	struct intel_iommu *iommu;
@@ -1099,7 +1149,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	spin_lock_init(&iommu->lock);
 	ida_init(&iommu->domain_ida);
 	mutex_init(&iommu->did_lock);
-	iommu->max_domain_id = cap_ndoms(iommu->cap);
+	iommu->max_domain_id = iommu_max_domain_id(iommu);
 
 	ver = readl(iommu->reg + DMAR_VER_REG);
 	pr_info("%s: reg_base_addr %llx ver %d:%d cap %llx ecap %llx\n",
-- 
2.25.1

