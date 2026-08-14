Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61F3ED3AF
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786743914; cv=none; b=qN29zLMHbY81g8DmQeuF5KPXunlQAy7IJoM8wKXlSWzeNoGG991Mf9NIpJEk4Gi93jGsl1YEhFTlaC8zjj52GYcI7x5DuMNO+O90q7ofozrB9C8oIPkEufZ+w5CjLjI2e+qvworlBN6pR3oef4FVulBNd4lJwimQ2THr2PjmnWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786743914; c=relaxed/simple;
	bh=r9Ge08NijU1LD99+O/gFCJyWpv5F9xXmbAhkj8DeBAU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=clyafGaJNa8bpSi0ymgftBnmYfZBgjwY80lyJpetEXEtNy/nEbdUqV7udk5ImrPfa/RNMPa/Net4dR/wGVgQDSuI8ldC6wUNLp5goliyuBA6/ejETxPyM8/sz7x/HHrAeCLaOlFrtTKBw3lthsUFssOmrzTg+Inks+/MssQ4gLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFbXgat/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EFbXgat/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786743912; x=1818279912;
  h=date:from:to:cc:subject:message-id;
  bh=r9Ge08NijU1LD99+O/gFCJyWpv5F9xXmbAhkj8DeBAU=;
  b=EFbXgat/tifpMUqJr83wnLTWe0PmvxOYCP17oPt+2sX46WpK4kjR4unm
   /A7rEpv9VLPaprnwO1M5YmPzJ/5G58Cr4BnPnNjQpi44iK6gBHE04hFzT
   CoZt1ZfXVoH0bhIpcOzlyruja+txhdSH7W7+HAuQhi+iBaYDmxTgjKHvs
   2MawbEBva+nEw7EDyv9a3H7rcVkftajlrtxIBG5P3U/3tDOTdUfeCW95E
   C3uNIOgqPfi2Xh91liE3ps2GR4s/DXjH3uM0eEgpOhhQf2/k5j89ZAlLC
   sFC4KZ5XxoCB81YP2W5V5nXirZOWT8L+L+Zbs1oyFOfWnh3UaT9cCyTYZ
   w==;
X-CSE-ConnectionGUID: 7gXTE2EJQBWRdFdPXVBb9A==
X-CSE-MsgGUID: nCWCgRywQYy6ILjEl+ww9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="91138431"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="91138431"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 14:45:11 -0700
X-CSE-ConnectionGUID: 2zlHMfPsSbe6TTqAAxgi6Q==
X-CSE-MsgGUID: aEKE4jySROWFvI8HbtN0vA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 14 Aug 2026 14:45:10 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuzi7-00000000aI4-2VVq;
	Fri, 14 Aug 2026 21:45:07 +0000
Date: Sat, 15 Aug 2026 05:44:20 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 24d15dace26e940fcfaf5aefb36b33a5228c8375
Message-ID: <202608150508.xFymJeBM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 24d15dace26e940fcfaf5aefb36b33a5228c8375  Merge branch 'pci/misc'

elapsed time: 794m

configs tested: 54
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260815    gcc-11.5.0
arc                  randconfig-002-20260815    gcc-8.5.0
arm                  randconfig-001-20260815    clang-21
arm                  randconfig-002-20260815    gcc-8.5.0
arm                  randconfig-003-20260815    clang-17
arm                  randconfig-004-20260815    gcc-8.5.0
arm                       realview_defconfig    clang-17
arm64                randconfig-001-20260815    clang-24
arm64                randconfig-004-20260815    clang-24
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260815    gcc-13.4.0
csky                 randconfig-002-20260815    gcc-15.2.0
hexagon              randconfig-002-20260815    clang-22
i386                            allmodconfig    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260815    clang-18
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260815    gcc-8.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
riscv                randconfig-001-20260814    gcc-14.3.0
riscv                randconfig-002-20260814    clang-24
s390                 randconfig-001-20260814    gcc-11.5.0
s390                 randconfig-002-20260814    gcc-13.4.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260814    gcc-16.1.0
sh                   randconfig-002-20260814    gcc-16.1.0
sparc                randconfig-001-20260814    gcc-16.1.0
sparc                randconfig-002-20260814    gcc-15.2.0
sparc64              randconfig-001-20260814    gcc-8.5.0
sparc64              randconfig-002-20260814    clang-24
um                   randconfig-001-20260814    gcc-14
um                   randconfig-002-20260814    clang-22
x86_64     buildonly-randconfig-001-20260815    clang-22
x86_64     buildonly-randconfig-002-20260815    gcc-14
x86_64     buildonly-randconfig-003-20260815    gcc-14
x86_64     buildonly-randconfig-004-20260815    gcc-14
x86_64     buildonly-randconfig-005-20260815    gcc-14
x86_64     buildonly-randconfig-006-20260815    clang-22
x86_64               randconfig-001-20260814    gcc-14
x86_64               randconfig-002-20260814    clang-22
x86_64               randconfig-003-20260814    clang-22
x86_64               randconfig-004-20260814    clang-22
x86_64               randconfig-005-20260814    gcc-14
x86_64               randconfig-006-20260814    gcc-14
xtensa               randconfig-001-20260814    gcc-9.5.0
xtensa               randconfig-002-20260814    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
