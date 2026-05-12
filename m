Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23B7382385
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621711; cv=none; b=bDv2leYlW1Ue/yCC3UPgGK54cmK0AfvHrddzxSch5oqW1tFMpCVc4P+KQgywYGKvfTl/YE02p0q33Ua8xM9Voqi0nqyGWOp4IDfNAhQXDdW88E5+GG1U0/oV28pRdyPZKxz8Yj9/ISehu37a+mOWHwZikp/81zLOq0w8/Al2AjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621711; c=relaxed/simple;
	bh=PEOmvNsR7miHR6u/q8r4CNw7yS2s5vHkS9dA9BkAhk0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NJU6Vx4EoxMqZ2Mmp70O81Vn40DVBRqkRfXCyWEuhdumTjiDmKwUSoC1zVWssgsSaPBX9GNu5xR+8c6Q0faF4TcC2pAYaXfSiGh1/StKZQPJsHnuLWvg4zIfpngTMBiQpHNZQhU+gFDGTOrj1hZQuSwJprTyT9iQWMvnY5bw2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjkYozA+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjkYozA+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778621709; x=1810157709;
  h=date:from:to:cc:subject:message-id;
  bh=PEOmvNsR7miHR6u/q8r4CNw7yS2s5vHkS9dA9BkAhk0=;
  b=IjkYozA+s4xqqNg+Aqk2RqOtGBV1Ee+sjZVXd64azLzzkDwGR4GQVUM4
   7M2i9KISZrFIZAGMFQC6NYmpqYLc+JOfLB0JRDraYW1FYblAqclv8BQM/
   5ukMDmFIIBcnYtsQUsQNH9BZ+l57fk0YL4ekM6ygvFSiZPduhax6dkiih
   gi+2+laaHBR90j4gyrvTehcEfGWi9BooIDEdE92Qdxdp+MeV7FaU25MSK
   LN0jcFWbGLPaRjxfEGvXDHqn4L+GptrPL1HZmjYu4MuMiup7QdpK6Pszb
   uHtTmjy/SSr/9D8E4OnADijEKYHIzS2gvh4XWTrrTUk3Wr1qLhqGFHnGG
   w==;
X-CSE-ConnectionGUID: 14rm6TYXTLGJ9kI73A3Jbg==
X-CSE-MsgGUID: S7mX1rFtQ8CUrKqi/MQ5kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="105000328"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="105000328"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 14:35:08 -0700
X-CSE-ConnectionGUID: v63fCwEvSQ2iENIcrSgIkg==
X-CSE-MsgGUID: 6VCdDVbhTJ6BD9Xd9VaO7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="233608543"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 May 2026 14:35:07 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMukq-000000002rT-2hl8;
	Tue, 12 May 2026 21:35:04 +0000
Date: Wed, 13 May 2026 05:34:34 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 83dd9effefa2e9da58ccd37059a11820fc05caf4
Message-ID: <202605130526.j5jKizCY-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 83dd9effefa2e9da58ccd37059a11820fc05caf4  MAINTAINERS: Remove Chuanhua Lei as PCIe intel-gw maintainer

elapsed time: 956m

configs tested: 70
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
alpha                     defconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arc                       defconfig    gcc-15.2.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-15.2.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
arm64       randconfig-001-20260513    clang-23
arm64       randconfig-002-20260513    clang-23
arm64       randconfig-003-20260513    gcc-12.5.0
arm64       randconfig-004-20260513    clang-17
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
csky                      defconfig    gcc-15.2.0
csky        randconfig-001-20260513    gcc-13.4.0
csky        randconfig-002-20260513    gcc-10.5.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
hexagon                   defconfig    clang-23
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
i386                      defconfig    clang-20
i386        randconfig-011-20260512    gcc-14
i386        randconfig-012-20260512    clang-20
i386        randconfig-013-20260512    clang-20
i386        randconfig-014-20260512    clang-20
i386        randconfig-015-20260512    gcc-14
i386        randconfig-016-20260512    gcc-14
i386        randconfig-017-20260512    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
mips                   allmodconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                   allnoconfig    gcc-11.5.0
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sparc                   allnoconfig    gcc-15.2.0
sparc64                allmodconfig    clang-23
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
