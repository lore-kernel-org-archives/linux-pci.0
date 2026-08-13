Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90033291F
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648630; cv=none; b=bDfU85VGDsBzfz6OOQrZqINb7PLpbHGDM8YYbXr9OA0z9ou6DMu7tN+2ghW1X8mayl/gsqd7RSqnF1g/Ax+2icbgKyhvlRZlcYLCobrGNd570P9CxwNuYkPe+DicaMmEWy0w5TD4p/6PekSgCxcSdrsALK9s2iZhhFuINHan3mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648630; c=relaxed/simple;
	bh=sn+8Iq/8tHWnz/9IKs0iTErDFGfyHvVHlCSnxLv2h64=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eNmaF2ZF4GDPZ6BtU/qJ1RM8Wv4t5sd+1r37LSnCRdNrtKfYbmr0cXprEfZWC06AqrMBa+j8pukyJO+RBNDtcYsq3ib0k0d8PQCqZdRY2iu41zfmZHs2cC/k0Tlf78BvkK+uC+MRDezEB3jOnsKuLsuEPEPc5ifTQQq4yZnXEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7VFTifR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7VFTifR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786648629; x=1818184629;
  h=date:from:to:cc:subject:message-id;
  bh=sn+8Iq/8tHWnz/9IKs0iTErDFGfyHvVHlCSnxLv2h64=;
  b=D7VFTifR2NgUZkR43cM3RVYAdEe59oQmbPPyvUnmd/WEdUYC0fJzcLWb
   VqNXUvl24DZwX6lIQQskJXo2tt++rKY3Up6Xi6jVWf1ewJ3ehIU4iqf4V
   YumEDtDrHDmNREOntNBptQTpipGfah5ouVUTaeKrl8fO4Xfo6rnqPma6C
   aY6CfR1iw236n/XTh+8gQJ8AD5i2+srM5R3YPwhoPo0CiuPZhJciIVxMO
   vBB0slqiXxnb46c+BjznL7y9+ljkcjti0dOH23A79AOf4l8c9Ijdwlzsy
   QdP84GtanWQsndRvSiuS4DjMvYo0xoBGRj4UAhMlhw64SMTzphujs1AvN
   g==;
X-CSE-ConnectionGUID: zoojkhziQD6Xz0VfyCfyJA==
X-CSE-MsgGUID: +eccvlI0S8K92DGotb0vZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="91106543"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="91106543"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 12:17:09 -0700
X-CSE-ConnectionGUID: Ml4O7axsTMqlRO/S5wI+1w==
X-CSE-MsgGUID: AWI453aoTPak2DVo1nMk0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="260214101"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 Aug 2026 12:17:08 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuavJ-00000000WKe-24Re;
	Thu, 13 Aug 2026 19:17:05 +0000
Date: Fri, 14 Aug 2026 03:16:31 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/misc] BUILD SUCCESS
 6d99b198629dde79aa098214e82f2a99ea44f330
Message-ID: <202608140318.WFR8eSiA-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/misc
branch HEAD: 6d99b198629dde79aa098214e82f2a99ea44f330  PCI: dwc: Add PCI ID for LECARC PCIe PMU

elapsed time: 744m

configs tested: 15
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha              allnoconfig    gcc-16.1.0
alpha             allyesconfig    gcc-16.1.0
alpha                defconfig    gcc-16.1.0
arc               allmodconfig    gcc-16.1.0
arc               allyesconfig    gcc-16.1.0
arm        netwinder_defconfig    gcc-16.1.0
csky              allmodconfig    gcc-16.1.0
i386              allmodconfig    gcc-14
loongarch            defconfig    clang-24
nios2             allmodconfig    gcc-11.5.0
nios2              allnoconfig    gcc-11.5.0
parisc            allmodconfig    gcc-16.1.0
parisc            allyesconfig    gcc-16.1.0
parisc               defconfig    gcc-16.1.0
sh                   defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
