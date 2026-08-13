Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F8369D59
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648571; cv=none; b=m1sY4+iUj+7m8S1zM+zsqrosFfOHyEBhf95eVV5hGns8UgbCP8/3iNIoK4h41rJNC2ZnwPS694fXkhITvngfNHBUywcr0O2OSy2lSJRy9jJg/Gggh97uQ4UWsu8X2SRdYkfrOgf+/Tjlc4wtFx1gkaSD+dIuzE2cCU5ld8o9WNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648571; c=relaxed/simple;
	bh=hvF7LQ3eYSPsct0uRkm/ksd1lWZwbLwZtO8An68TFlY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HStL551Vx3bmOLcHtclItKbDf9uGJ8HOeAhy6Zp/3ls5dONHRYaSCOWd90oSVKTN0T4hUzTaq3Xkr/uiHePaOweEPGhN763mRiKLUlDBaEUiwMKX2/FVBBDx7M1egHkVvmTg34kuvmfYLMdxzeGSVA1UfM/UtKxFCioMmOLMhhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9WAw7jS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9WAw7jS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786648570; x=1818184570;
  h=date:from:to:cc:subject:message-id;
  bh=hvF7LQ3eYSPsct0uRkm/ksd1lWZwbLwZtO8An68TFlY=;
  b=a9WAw7jS+XT2vHoRQdvyNSje2Kzu1OW2y1zMZyp/dY0arSialhha0Xmb
   zP0S6b1A8twbqCH8iJG0M6crzPpC1gtCuDe4GfmrN9DaBnM69xW015+eG
   tC5mrKIWyc4/K1/Un9Nstyo5lVPUfoYs6SBC+7JbFXoEWD1aCdqdbbyRX
   IyxbxDgIIspzSPpNGIFHYI1ratSM20h2uUVWdlCJ7PA5QHTApJ2VIuWLA
   mrEyWCVVoL9uvuqQW+LMadeWSU97ksschn1AjDfBIiHYm0QtUEyeooYU3
   blITxEnHKJl+ztjo7SSkT/2vJeTUPHBe41y+tkzWDdlhflUXFxTajM3/F
   g==;
X-CSE-ConnectionGUID: SYwszT+kRgyPehFk0K8jaw==
X-CSE-MsgGUID: 6mF5JQmfT1GQpbqtGVEqrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="86196084"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="86196084"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 12:16:08 -0700
X-CSE-ConnectionGUID: tJ+lcG8iRhy/hQJdXUvbvQ==
X-CSE-MsgGUID: FnY025yVS6iGnev1pZvl/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="293955682"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 Aug 2026 12:16:07 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuauK-00000000WKE-1OBy;
	Thu, 13 Aug 2026 19:16:04 +0000
Date: Fri, 14 Aug 2026 03:15:59 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mediatek-gen3] BUILD SUCCESS
 8d076be9a10c68f7fac5d6a180bff19053b91dca
Message-ID: <202608140347.njmnKsvH-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek-gen3
branch HEAD: 8d076be9a10c68f7fac5d6a180bff19053b91dca  PCI: mediatek-gen3: Add 2-lane mode support for Airoha AN7581

elapsed time: 743m

configs tested: 15
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha           allnoconfig    gcc-16.1.0
alpha          allyesconfig    gcc-16.1.0
alpha             defconfig    gcc-16.1.0
arc            allmodconfig    gcc-16.1.0
arc            allyesconfig    gcc-16.1.0
arm        exynos_defconfig    clang-17
csky           allmodconfig    gcc-16.1.0
i386           allmodconfig    gcc-14
loongarch         defconfig    clang-24
nios2          allmodconfig    gcc-11.5.0
nios2           allnoconfig    gcc-11.5.0
parisc         allmodconfig    gcc-16.1.0
parisc         allyesconfig    gcc-16.1.0
parisc            defconfig    gcc-16.1.0
sh                defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
