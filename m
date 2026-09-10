Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123E36B925
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 03:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011802; cv=none; b=BzIP4fSo5LYuvT8gmn5bXh/S4uAbvQjaPVop04y3MYz+WMAsZ4wWZMo1W6rpPGw9XN2r8eSWYWfHVNa4ONPjtyUg2Zb1YnvrY2LoCDXpUNtzJHlpmq22ii9LDMXbJuE4S+ijFwIixlC7YjHGPlaQzd1qG6oezPZrPCx/rREW408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011802; c=relaxed/simple;
	bh=JUixJvvAvReY2bieLnLvmUgUtarSlOOvSlJvlAlicjM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Aox75JRwo4rQa/hv1VVm/zxOUK4xW6xjqxlu7YvPnJb7GcdR0Hhc1XkYZ1tcs+b7X3RAlmcoPpMPyBrjORQj+l1BXtpJbxRYjhICc7Pxf8QC1ELSjeDlRQX/zORJ65tOag6x9z/Naok5DXZ309VqINajKOVCiR1VV9ZzqxGUW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLzv46C/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLzv46C/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789011801; x=1820547801;
  h=date:from:to:cc:subject:message-id;
  bh=JUixJvvAvReY2bieLnLvmUgUtarSlOOvSlJvlAlicjM=;
  b=DLzv46C/DXu/ft83kShoQtZU1e5uzDCWNYtdyazRuxEXFF7fQ+g9vfNK
   XUybXbDlSEjyOC0/5YdR0PSDf0IyaKJK0FnY9dJk154R2zzn7rBtlBrjx
   WX2Ae4aNHMCa9V2JEpvnUYi70KPcUhASiyr0aEPe/v/8mTOZJ/HIazf0U
   GLWWWWMdQpJN2uq8EoeJ2UQP/zfnorD2mBxHQVWuVqSaxKvNtTlUWZ0ew
   w5e94PlXjRZEXckbMCyFVoUCCrKHpNphL4jXUDQl/SaSzqFA2k7xD4bZ1
   fN8IlKPL3SnRKRYMTcrrbJnFmRa3rOpVAv7ARZfSbqHpj0pyJw05CUt7D
   Q==;
X-CSE-ConnectionGUID: SYQ86qdtT6KSD/QW/baNew==
X-CSE-MsgGUID: zs1P9+diTcGsQJ5LwvHGrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93277727"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="93277727"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 20:43:20 -0700
X-CSE-ConnectionGUID: aXtfwQNGTKGxsyb1CvZCEA==
X-CSE-MsgGUID: BCFf2LiGSzC4G4TlV9GdYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="275650116"
Received: from lkp-server01.sh.intel.com (HELO a3e91e2cf319) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 09 Sep 2026 20:43:20 -0700
Received: from kbuild by a3e91e2cf319 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4Vgz-000000001Ko-16c5;
	Thu, 10 Sep 2026 03:43:17 +0000
Date: Thu, 10 Sep 2026 11:42:48 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:p2pdma] BUILD SUCCESS
 d3b6ec129234fe15c9d808db8db1a62de3edec71
Message-ID: <202609101145.IlupGP1x-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git p2pdma
branch HEAD: d3b6ec129234fe15c9d808db8db1a62de3edec71  PCI/P2PDMA: Gate the host bridge whitelist warning on verbose

elapsed time: 1507m

configs tested: 73
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm          allyesconfig    gcc-16.1.0
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
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
parisc       allyesconfig    clang-17
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    clang-17
sparc         allnoconfig    clang-24
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um            allnoconfig    clang-24
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
