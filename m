Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2017B37646A
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974662; cv=none; b=fsBALevCH8gfeo9f9bqXCu4iMdk4N1F08+7ZsDQzRElr6IPkrLXPIyfiC9QaUVs/7/MvHbcyTXB/2E0urIpU8CfmjCHoM9zloqrQ3xemzom2XXFqC0SU2tyl4v+XalXZk8+erOfwLf4jwLEGfBMDuFEP7KN22km+wBg0evF3Yx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974662; c=relaxed/simple;
	bh=4iHPM1HK9hTFJjDx8DbgUmIBYJBWB07oZ0+fC7MNw1s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gQj+pjXOMq1q5/eD4AwZ863zr6b7w1Lh9EAULeL0bihItbuLMmBslOdf098sEvX1nrAE5e2i84jS0Dl64Au6RbzDyZEUT3fGyAxoBW1UdQWR7R+mqSR/bxLeSvPlDXEGyJSSrDkFcOLgLw2wuIpxeAqx/UnICU8qCsFa4kV3OIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BjcYPvX9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjcYPvX9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788974660; x=1820510660;
  h=date:from:to:cc:subject:message-id;
  bh=4iHPM1HK9hTFJjDx8DbgUmIBYJBWB07oZ0+fC7MNw1s=;
  b=BjcYPvX92K5kJHiP+oDBkYrhbodapF37ZQ6ahAtfPRv0dCblXPVrBFZg
   sNxQy/xY0L6K//rHj5TOco9VdDwSdCfpLXFuFF+RBO74Ec9wZXn46BXPJ
   1o0A4hLK9soZbdF5OM/TM57l+UXo2MEmmWEyfPLQXOxqjvcEknudwEeov
   mSoaAWI0esC+rqcwlldkFLtYezhpU1cwiqcUUXWBMageXyT1PxDW2s6qq
   Y8hnsKf/zSxI3hwsdfOcO7+te1dKo29rF3DeKINZova7NN4+pkuE765kF
   FbpQsb51JDtAMS1/lT/Cs2BT1HJSBk0U/hRGL/vncUvjwCPmkU2I/owvy
   A==;
X-CSE-ConnectionGUID: THu1ofw8RTahxh57W6OGLg==
X-CSE-MsgGUID: OVQ2RDDjSZ24lNolU5zFQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106925834"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106925834"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 10:24:18 -0700
X-CSE-ConnectionGUID: h5fAZHVjQlGt1hrPQ5Nz1g==
X-CSE-MsgGUID: VzVkx5P/QkKFeTVy5YBdcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="274892125"
Received: from lkp-server01.sh.intel.com (HELO a3e91e2cf319) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Sep 2026 10:24:17 -0700
Received: from kbuild by a3e91e2cf319 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4M1v-000000000h8-0LdE;
	Wed, 09 Sep 2026 17:24:15 +0000
Date: Thu, 10 Sep 2026 01:24:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 12f8e3e3eef4a662b622cf12f00981f64c276307
Message-ID: <202609100102.kbBZ4xVo-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 12f8e3e3eef4a662b622cf12f00981f64c276307  Merge branch 'pci/controller/vmd'

elapsed time: 1060m

configs tested: 65
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
nios2         allnoconfig    clang-24
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
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

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
