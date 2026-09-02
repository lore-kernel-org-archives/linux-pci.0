Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAE14ACC98
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369947; cv=none; b=VAzhOT2c4M+2c/ZoHT+FfaPcZxgPl8UXbYH511P+wSsa5Jab6V0umNO+fYk5iC6sJf9gqN5iT67/C/F+HqFNMh1eXTKYl91DUICjVMUqST9Ox4pHm35Kj3GhVNxMC3bvybZsp1poDLPWToDOP0nAPIavFlq9ke/L3F5J9X8eRMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369947; c=relaxed/simple;
	bh=IXldv3Jo7Rne+kc00Zi7U+kL4yxydL073z00KCNtW4A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uQt64ScWHi9C+GHng7rep/wEvhQbD6DHWL2eg4WVu3QE+rFYlBdbwqG/XuWi1qX+gtKCBAVv0prjQtBR5yvhTsWP7Q9DyY4ERvlL/A1SsszBiVhAajJIZ1PEHXE/B7PUE+Xa52zE9FZDcKWra6Rn2eYSo8yfbdwKM8ih4TsmFX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aiqn/GQa; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aiqn/GQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788369946; x=1819905946;
  h=date:from:to:cc:subject:message-id;
  bh=IXldv3Jo7Rne+kc00Zi7U+kL4yxydL073z00KCNtW4A=;
  b=Aiqn/GQa+wz7bMA5eT7gFm15hZ4k7Vcb7g0qmNqETQUTbGg80/tBNEuM
   6b0bueJ8EfSHd2czFVCKM4TuWzeqRHTmn3ljlEdlSByGMjDZMuo/YfEu6
   gNm5BD0lbZ3bRG9qTGl9CUUDsINTnF14GlkVE/hIs0h6amB5Z17r5dw/U
   XMofTRdygeGBOJ9N/ooYS6xolbrngeIkG6ct8yeVbzr1VjBIyFmXLpvYm
   3vt88rdRvUpifr2HDWi/589C7f65bvrH7NeAqVv2lS3TXZMhuFICNviGU
   5Nh6W96P4ueIc4uY39GLw9ejGDnH3VYL5wLiuC0Or1KLGtjlUzvXj63LY
   w==;
X-CSE-ConnectionGUID: zQgPKwfPQUyVDhTXhCEulA==
X-CSE-MsgGUID: t9taJDAGR+KOSAxv94Wh/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88888360"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88888360"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 10:25:42 -0700
X-CSE-ConnectionGUID: M8R1bRnFTb2Lm9v46b7WyQ==
X-CSE-MsgGUID: Wbcah9znRKOjo+aWNZcnmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="268152380"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 Sep 2026 10:25:40 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1oiQ-0000000033q-2D1l;
	Wed, 02 Sep 2026 17:25:38 +0000
Date: Thu, 03 Sep 2026 01:25:04 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc-rcar-gen4] BUILD SUCCESS
 d9113a8a6bdda348d590845da014ab0e01afe638
Message-ID: <202609030159.uSdrShSl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4
branch HEAD: d9113a8a6bdda348d590845da014ab0e01afe638  PCI: rcar-gen4: Use .post_deinit to handle dw_pcie_ep_init() failures

elapsed time: 1588m

configs tested: 58
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    clang-17
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    clang-17
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
