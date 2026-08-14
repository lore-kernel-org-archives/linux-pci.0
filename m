Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4F2191F91
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786667369; cv=none; b=WUPYbd5RyIfpoFOp0eaVP6y9uFqK3U7uSqs/LkWcuNWnt6tP0z9iaq384VxVw+SGiBOmVOSsJ9ZGNpDD3q/qmM4G/6wly7TIzljEt4GE1eJJaiH/of3wqsLjUoLjopIXg8MdZ74Mafoldc2q4wyyKE85ZNAKq8MFaU9rDkv9fHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786667369; c=relaxed/simple;
	bh=unit/yAwnSNSVOh8UMNJ1i1cYz9qigAtWXIJqR9Yeyw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WlxY7Q4lCgrYN/LowtBJMydXam2IkVVCzUDNbSpTimYbQKW3gyCHZDsg7NSupi9wKR4/laFJswKG2k3QDXgEBLUS33No1o4QY/PMmYGpgMbtXDoa6bxQ4+wVaYW5CFo1U4ErIUdAagS7MUpisRexaJAws2AzxAChO7pU/ggUf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgIfGGHf; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgIfGGHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786667367; x=1818203367;
  h=date:from:to:cc:subject:message-id;
  bh=unit/yAwnSNSVOh8UMNJ1i1cYz9qigAtWXIJqR9Yeyw=;
  b=TgIfGGHfJ4lMFcq1WJhZ4/rh5qAYDAOOpWa5poUWW72G+r0HP3GQijef
   qXSevA93g68OoDEzqfTpjwJEfv5bagA6qzjCHqMWQ0ou2pbSdRP+NqMJb
   3jhX4OwERx17scXfeBJFLdFXaXL3RjJeX2z0O6fURdsilb9/xn3zsigRT
   CuIjLp1yF4OZKxKquvIzegAuK5OCHLCrqNxn04eydX0wj6wrS/EqljjAU
   ZVj/DD+cuftaVSayuUkSOLWuPo88n7t4oVcHpji5kcfZ/nSKNZypzBneu
   OO+GTDM1IhzC4PseIQurih/1rg4crDHF6NFo84jtxlJORiftDLxc3b675
   Q==;
X-CSE-ConnectionGUID: OgseuFIdQZKmmvLieM+kyQ==
X-CSE-MsgGUID: Sgh4clkDQKCpg2nF9ldAbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="86370317"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="86370317"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 17:29:26 -0700
X-CSE-ConnectionGUID: gdT09vH0SeWMeByGyfxEkA==
X-CSE-MsgGUID: OW2ALYwWSSuVUNtnEcp8aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="269273007"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Aug 2026 17:29:25 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wufnX-00000000X5O-15TR;
	Fri, 14 Aug 2026 00:29:23 +0000
Date: Fri, 14 Aug 2026 08:28:26 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aspm] BUILD SUCCESS
 eacf92a29af970b33f7323bf3e00a25bb23c8b19
Message-ID: <202608140813.fq5Q3IJG-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aspm
branch HEAD: eacf92a29af970b33f7323bf3e00a25bb23c8b19  PCI/ASPM: Mask ASPM states based on Devicetree properties

elapsed time: 1056m

configs tested: 45
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260814    gcc-10.5.0
arc                  randconfig-002-20260814    gcc-12.5.0
arm                  randconfig-001-20260814    gcc-16.1.0
arm                  randconfig-002-20260814    gcc-10.5.0
arm                  randconfig-003-20260814    gcc-16.1.0
arm                  randconfig-004-20260814    clang-17
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-002-20260814    gcc-10.5.0
hexagon              randconfig-001-20260814    clang-17
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260814    clang-22
i386       buildonly-randconfig-002-20260814    gcc-13
i386       buildonly-randconfig-003-20260814    clang-22
i386       buildonly-randconfig-004-20260814    clang-22
i386       buildonly-randconfig-005-20260814    gcc-13
i386       buildonly-randconfig-006-20260814    gcc-14
i386                 randconfig-015-20260814    gcc-12
i386                 randconfig-016-20260814    gcc-14
i386                 randconfig-017-20260814    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260814    gcc-16.1.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-002-20260814    gcc-11.5.0
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
sh                          se7721_defconfig    gcc-16.1.0
sparc                randconfig-001-20260814    gcc-16.1.0
sparc                randconfig-002-20260814    gcc-15.2.0
sparc64              randconfig-001-20260814    gcc-8.5.0
x86_64     buildonly-randconfig-001-20260814    clang-22
x86_64     buildonly-randconfig-005-20260814    clang-22
x86_64     buildonly-randconfig-006-20260814    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
