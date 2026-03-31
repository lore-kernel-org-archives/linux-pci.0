Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F7C3B0AFD;
	Tue, 31 Mar 2026 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941734; cv=none; b=cNEVMPTGM0vywZ9yClHErGqwW8+TmlAiwYdcVgF5q6TfnxyPLiN9aDcb1VcIDqT5t1mnJzGTqv6nHfJxIC+eACyn2M3g5Ur8sSsFAHU/TF75ubHR36m0Fuh76muRGgUM/u/qjWWN0M6NKrasAzpEj64NzJyJQiYjH82Gi2r5BXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941734; c=relaxed/simple;
	bh=C1YKXGKjApcPGj6BR6AhID4Gp4kW/avbsOowHqInjZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vF1G/qpSfWrFTu2pQZfQCtNxB/djWhHuKAINqhf5gjQi5ScT+QWW3jJQw+ZrD9bFDn8y3wqaAaLsEuYfBud5TpNoxwHKg72tk5vDH8qpVhIKOkY3GTuJRE3P0fT97ZDg+BbJKjdI1SWGqCZVrc4pY/vAS5/VNn+UpmvHlnKQOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l850NY0b; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l850NY0b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774941733; x=1806477733;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C1YKXGKjApcPGj6BR6AhID4Gp4kW/avbsOowHqInjZc=;
  b=l850NY0b30hXs0cvJjwy+0UtJARQgD5okXgxfq308f1AczMc94PUJtKV
   UdleadmiwnN/9xVZDTN0f+5JxDAok5yskmBdpG2xhPIAYjW9M/dSEri87
   Xx1xeIZdDUNTe1pcpnucuskvwKZctVVsk52IJP1xjX/lkvp/NAlx2TvtV
   VDQhzyphplN8v2jc34cyxhGgh722UasIfLqtmpRlC2Oa3qFE46pW1ONGh
   HeQTuJPwouR3J0DSMDPi+h/Uv46N0UTzqevNA03VrL8nqn6RF/5SHNSOT
   Yom9YIm0PFqFsbLK9FNjB+mWyoOs6L4LJUnhQBLN0VYwoeacKUPE5AFrX
   w==;
X-CSE-ConnectionGUID: 8NCEHOrmSbCxHelE+jDl4g==
X-CSE-MsgGUID: Su8X609gSKC0tReyf8AwFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93328655"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="93328655"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:22:13 -0700
X-CSE-ConnectionGUID: x0CbGA/6S6GVD2t9iXXBoA==
X-CSE-MsgGUID: SWJYIpSRQgS7gMnP8WtOmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="225287432"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:22:08 -0700
Message-ID: <4be868dc-d6e1-4488-8f28-34ef1d3659ac@linux.intel.com>
Date: Tue, 31 Mar 2026 15:20:44 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/31] iommu/vt-d: Reserve the MSB domain ID bit for
 the TDX module
To: kernel test robot <lkp@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 dan.j.williams@intel.com, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, chao.gao@intel.com, dave.jiang@intel.com,
 yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org,
 rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org,
 xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
References: <20260327160132.2946114-20-yilun.xu@linux.intel.com>
 <202603290006.za7iiDgF-lkp@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <202603290006.za7iiDgF-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/29/26 00:57, kernel test robot wrote:
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 11439c4635edd669ae435eec308f4ab8a0804808]
> 
> url:https://github.com/intel-lab-lkp/linux/commits/Xu-Yilun/x86-tdx-Move- 
> all-TDX-error-defines-into-asm-shared-tdx_errno-h/20260328-151524
> base:   11439c4635edd669ae435eec308f4ab8a0804808
> patch link:https://lore.kernel.org/r/20260327160132.2946114-20- 
> yilun.xu%40linux.intel.com
> patch subject: [PATCH v2 19/31] iommu/vt-d: Reserve the MSB domain ID bit for the TDX module
> config: i386-randconfig-141-20260328 (https://download.01.org/0day-ci/archive/20260329/202603290006.za7iiDgF- 
> lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> smatch: v0.5.0-9004-gb810ac53
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260329/202603290006.za7iiDgF- 
> lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot<lkp@intel.com>
> | Closes:https://lore.kernel.org/oe-kbuild-all/202603290006.za7iiDgF-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> WARNING: modpost: vmlinux: section mismatch in reference: iommu_max_domain_id+0x55 (section: .text.iommu_max_domain_id) -> acpi_table_parse_keyp (section: .init.text)


acpi_table_parse_keyp() is marked as __init. But this patch causes the
intel iommu driver to call it from a runtime function.

int __init_or_acpilib
acpi_table_parse_keyp(enum acpi_keyp_type id,
                       acpi_tbl_entry_handler_arg handler_arg, void *arg)
{
         return __acpi_table_parse_entries(ACPI_SIG_KEYP,
                                           sizeof(struct 
acpi_table_keyp), id,
                                           NULL, handler_arg, arg, 0);
}

One way to solve this might be parsing the table once in the __init
context and store the result in variable that could be used after boot.

How about the following additional change (untested)?

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 097c4a90302f..0b384a58a3a0 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -63,6 +63,7 @@ LIST_HEAD(dmar_drhd_units);
  struct acpi_table_header * __initdata dmar_tbl;
  static int dmar_dev_scope_status = 1;
  static DEFINE_IDA(dmar_seq_ids);
+static bool tdx_tvm_usable __ro_after_init;

  static int alloc_iommu(struct dmar_drhd_unit *drhd);
  static void free_iommu(struct intel_iommu *iommu);
@@ -915,6 +916,17 @@ dmar_validate_one_drhd(struct acpi_dmar_header 
*entry, void *arg)
  	return 0;
  }

+static void __init intel_iommu_check_tdxc_enhancement(void)
+{
+	int tvm_usable = 0;
+	int ret;
+
+	ret = acpi_table_parse_keyp(ACPI_KEYP_TYPE_CONFIG_UNIT,
+				    keyp_config_unit_tvm_usable, &tvm_usable);
+	if (ret >= 0)
+		tdx_tvm_usable = !!tvm_usable;
+}
+
  void __init detect_intel_iommu(void)
  {
  	int ret;
@@ -923,6 +935,8 @@ void __init detect_intel_iommu(void)
  		.ignore_unhandled = true,
  	};

+	intel_iommu_check_tdxc_enhancement();
+
  	down_write(&dmar_global_lock);
  	ret = dmar_table_detect();
  	if (!ret)
@@ -1046,24 +1060,6 @@ static int keyp_config_unit_tvm_usable(union 
acpi_subtable_headers *header,
  	return 0;
  }

-static bool platform_is_tdxc_enhanced(void)
-{
-	static int tvm_usable = -1;
-	int ret;
-
-	/* only need to parse once */
-	if (tvm_usable != -1)
-		return !!tvm_usable;
-
-	tvm_usable = 0;
-	ret = acpi_table_parse_keyp(ACPI_KEYP_TYPE_CONFIG_UNIT,
-				    keyp_config_unit_tvm_usable, &tvm_usable);
-	if (ret < 0)
-		tvm_usable = 0;
-
-	return !!tvm_usable;
-}
-
  static unsigned long iommu_max_domain_id(struct intel_iommu *iommu)
  {
  	unsigned long ndoms = cap_ndoms(iommu->cap);
@@ -1075,7 +1071,7 @@ static unsigned long iommu_max_domain_id(struct 
intel_iommu *iommu)
  	 * the VMM’s DID setting, reserving the MSB bit for the TDX module. The
  	 * TDX module always sets this reserved bit on the trusted DMA table.
  	 */
-	if (ecap_tdxc(iommu->ecap) && platform_is_tdxc_enhanced()) {
+	if (ecap_tdxc(iommu->ecap) && tdx_tvm_usable) {
  		pr_info_once("Most Significant Bit of domain ID reserved.\n");
  		return ndoms >> 1;
  	}

Thanks,
baolu
