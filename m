Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76434E744
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 05:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788586449; cv=none; b=kOWAwyn68HKUz9Eo+1Zn0JSQ/V4IyzgUAY2RdKPRQh3p9k3/WR7fthslA1FTx8r+i1ttFCKEIkpCu/0msXkC7Zpoyfr/nLVs1BXR3Eaff+LpgfWjR+HsZ7MgEI4pI95p+N+fGG/EaPnGgj3s1ZN88uiOfLOTk4fsUJ6LiV4x5nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788586449; c=relaxed/simple;
	bh=J76/SBUIV4FGdLxD289Dza25FDIVQ7To4BYJhkpw4SY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OpfLS5LVL9LXx19C3oqdI0cLKzb2n0foNc2UDoZ6+TG+XIuPVFS+rjMhb1n5nkQ2DTJpj1P40+s42Oh2oAvETmd/6o27WJaTEZLfePFDU81+mhI9SMs2EauIYIm6phj+IXMRtrfrtkldLWMyFkv1B8TnHgzyzlDSQlRp5vOMSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xy//1StZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xy//1StZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788586447; x=1820122447;
  h=date:from:to:cc:subject:message-id;
  bh=J76/SBUIV4FGdLxD289Dza25FDIVQ7To4BYJhkpw4SY=;
  b=Xy//1StZKwlrJ/YZKf3jejhdBCMJLZR1FIboditWHERZHaD7eHxB+GIL
   4bxBGcWGrXX46IjMmfzaQqRed4J+nCe5V1TJYW75oN55Qb3EdRukK8qch
   Y9nRw0jV9+Yoi9O8DJMckaybSBFGlpxZ/U0ypt4SVHtg7vB7TOOR1VhK8
   beeQYlgWWsDJ6W0K1snUdpPPrx+urrJKz2BfOOE819DFPO6JXN34nmxtM
   1aX21T7Yv/37AcPbfRYcH1jLHjvgO6SnAZCSObtMf3Yr8y15tPC/a0uzx
   9xMqtn1hOGrTyGQmUzyIyFy+0rMQLaygFITuvoyQK3mrYd1j0ItM2Yx3t
   A==;
X-CSE-ConnectionGUID: bINIAZG9Qhu8WOXVItTaMA==
X-CSE-MsgGUID: 29gdyCzUQ86NXHPXZ9Fxkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="111859112"
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="111859112"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 22:34:06 -0700
X-CSE-ConnectionGUID: Ycia5/vFTPOyPZWhdvvVvQ==
X-CSE-MsgGUID: WZ8Amw9nRtW0GRMdzodUHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="264027531"
Received: from lkp-server01.sh.intel.com (HELO 73f3364bc37e) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 04 Sep 2026 22:34:05 -0700
Received: from kbuild by 73f3364bc37e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x2j2P-0000000005N-0GNL;
	Sat, 05 Sep 2026 05:34:01 +0000
Date: Sat, 05 Sep 2026 13:33:37 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:tegra264] BUILD SUCCESS
 ed17593383fe3926950cae250842783630f32697
Message-ID: <202609051334.qxiHT3bZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/tegra264
branch HEAD: ed17593383fe3926950cae250842783630f32697  PCI: tegra264: Fix Link Capabilities register offset

elapsed time: 3756m

configs tested: 76
configs skipped: 3

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
powerpc      allmodconfig    gcc-16.1.0
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
