Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4990A364E84
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788586510; cv=none; b=E51ayy1m7yxjj+0wdrzFZirn+28dtKnVNad3jnwLMcUBBEKqq51pFFLawNeDAHVf1At53Wqix67ZPR9t+eVESnAQ8FPbSVOUReWNJSJ8f14Jus6GYO89sSBUVCYSA9vDI8ljtA7MzGddk+EgsO/xiB/XWJOCbX1WkAGCq991Dg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788586510; c=relaxed/simple;
	bh=d+675QauUpw6xs22Rzt6jYLCHxdpm2z976zk9PhWrJk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SqS3U6J/Zb7prMFfex3mvNpEKLOP3Gp8GxNM1de7AuoQ5WjpbEpPbQvZAsAMgH+EcPLJd4dOfS2e+iYVUUELP0L4SYQCGG6rXdqBSVvEjnEZ57246Pm8crxEoZjZ4xWSZL83xxykzop6FCrK8WWNG2CBlMjVtrEUU0NYvq9/dPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sc/G8d/I; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sc/G8d/I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788586508; x=1820122508;
  h=date:from:to:cc:subject:message-id;
  bh=d+675QauUpw6xs22Rzt6jYLCHxdpm2z976zk9PhWrJk=;
  b=Sc/G8d/IpzLdEZ+GjxKtOyIUXNI21FhJUyKT5ffws1RgTXKxJCYCnw+8
   rrofgCf2uZz8ZZIcbqR03kFfLL6IKM24N+byfCHoesWFTq3Ztcu6AVo6w
   UTxT1kltcbk6nJmwN0B9Prp0y5rircqUc60YOCM75FxUerIzadCC074UL
   sJ82a4A0Z/VhkyfE83B51QC7eRIuePP0qNQI7LhscbgI2VdP5Ie6H4H5g
   kwrUTodD7OtnPShT7pGdxa+PD9JNraBD0h45nopWVx3kLf4IpseLGUU19
   2j5IzrTXlbyPpaxvwVsESWpoajgWqC/IW7CZyh86/qsjcIKG8aVk6XZgE
   Q==;
X-CSE-ConnectionGUID: aP+Ycwk1TlyO6HxYFv4dcg==
X-CSE-MsgGUID: g2PdzM2zTWKuEo8OQRrQRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="88845781"
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="88845781"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 22:35:08 -0700
X-CSE-ConnectionGUID: rnQyCtVcRF+Q3Anq4uTWyA==
X-CSE-MsgGUID: Jy8aUnesTkG+NGDT6yp4/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="265861711"
Received: from lkp-server01.sh.intel.com (HELO 73f3364bc37e) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 04 Sep 2026 22:35:06 -0700
Received: from kbuild by 73f3364bc37e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x2j3Q-0000000005b-0eMR;
	Sat, 05 Sep 2026 05:35:04 +0000
Date: Sat, 05 Sep 2026 13:34:09 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc-imx6] BUILD SUCCESS
 16929741a622eb345057e41c7b335d9b297890e1
Message-ID: <202609051304.lbTnMnma-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-imx6
branch HEAD: 16929741a622eb345057e41c7b335d9b297890e1  PCI: imx6: Move clock enable after core reset assertion

elapsed time: 3700m

configs tested: 75
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arc          allyesconfig    gcc-16.1.0
arm           allnoconfig    clang-17
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    gcc-16.1.0
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    clang-24
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    clang-24
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-14
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-19
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    clang-20
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    gcc-16.1.0
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    clang-24
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
openrisc     allmodconfig    gcc-16.1.0
openrisc      allnoconfig    clang-24
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    clang-24
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-14
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    clang-20
xtensa       allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
