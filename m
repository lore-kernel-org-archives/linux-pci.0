Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191C0368D50
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 22:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787263786; cv=none; b=io8RiIF8m2oaqq2lHGZHJExp3s6xhPgetP4Qo6WPbWiGw0k7WqdLmUVo4kijL8sikLJ1GHItUbjpvM+XPHKd7IKRjZihJRIXz+ssAuGTScuK5MFEzAErpWIEY8OfqNt5NqdkUcOugf71+4lBOU6m+6DvvvbHFQYTQjkDk26qYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787263786; c=relaxed/simple;
	bh=/FYVJkr24h6HnV9lWIorvCyVw9rmKjZiuUyX0ueiKd8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bGKZCYmi2jMbPdH38aKE8chN/gkKgv+Zjsznp5QWmgfnqSVKxL5wGkC4nKNok8yiV9zEIb7n+CZ8wEG+1AI+nXJD1MPY5/wEpqwvm0mj8Ynd5pmtkXwMt0AvpyYmOs9CIyqdWZucIRhWgZRunrJvJ6zGSeFHybWUotYyPX2R4os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9IfvSCh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9IfvSCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787263784; x=1818799784;
  h=date:from:to:cc:subject:message-id;
  bh=/FYVJkr24h6HnV9lWIorvCyVw9rmKjZiuUyX0ueiKd8=;
  b=L9IfvSChr4FGjuE3jHq9n8ROdRPR6UmxTzQBBVSs+/+yr3kgE7zpxUq0
   L4Hjqy+woVAdJft251p8Kyw9QKSptLv79cf+iSCUT65IpS/wV7S896Vn4
   efE3NWPKLjewvh7miFVs8vJsASHEVDXzOoci4nlMgx+xTFXwDGTydiVSZ
   06DFrX8ntqIeWvYLXhXfzGMChFwDl0cdzAbrKKKolkSsbXIhgMGUT3hwF
   7xwwAK3+Ytm4vadr6lIQ0kkTGFNdUHAmszYNnZe4Gz+YaYDgh3eS4peBv
   g/ZKKDkXY36p6AofyJ99dO8e69tBAHVGfb3H06f9531CFKUyHfFgsKwHs
   w==;
X-CSE-ConnectionGUID: 8NRdHKSrTIGsVWMFB3segg==
X-CSE-MsgGUID: DtNvPUkATDOfpxGuJyCqwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="86759886"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="86759886"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 15:09:44 -0700
X-CSE-ConnectionGUID: un59xlGgRaaNTErnHB8ElA==
X-CSE-MsgGUID: n+TTiYMCQ/6YeY/LqZKqUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="290983858"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 Aug 2026 15:09:42 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wxAx9-00000000nqj-24Zi;
	Thu, 20 Aug 2026 22:09:39 +0000
Date: Fri, 21 Aug 2026 06:09:12 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/vmd] BUILD SUCCESS
 55aa45154fe48b7d8e96bc031ad27d5b0edfcdb8
Message-ID: <202608210601.F19mw0TF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/vmd
branch HEAD: 55aa45154fe48b7d8e96bc031ad27d5b0edfcdb8  PCI: vmd: Add Nova Lake (NVL) and Dunlow (DNL) Device IDs

elapsed time: 1496m

configs tested: 182
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    clang-24
arc                  randconfig-001-20260820    clang-24
arc                  randconfig-001-20260820    gcc-16.1.0
arc                  randconfig-002-20260820    clang-24
arc                  randconfig-002-20260820    gcc-10.5.0
arm                  randconfig-001-20260820    clang-24
arm                  randconfig-002-20260820    clang-24
arm                  randconfig-003-20260820    clang-24
arm                  randconfig-003-20260820    gcc-8.5.0
arm                  randconfig-004-20260820    clang-24
arm                          sunxi_defconfig    gcc-16.1.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260820    clang-24
arm64                randconfig-001-20260820    gcc-14.3.0
arm64                randconfig-001-20260821    gcc-8.5.0
arm64                randconfig-002-20260820    clang-24
arm64                randconfig-002-20260820    gcc-14.3.0
arm64                randconfig-002-20260821    gcc-8.5.0
arm64                randconfig-003-20260820    clang-24
arm64                randconfig-003-20260820    gcc-14.3.0
arm64                randconfig-003-20260821    gcc-8.5.0
arm64                randconfig-004-20260820    clang-24
arm64                randconfig-004-20260820    gcc-14.3.0
arm64                randconfig-004-20260821    gcc-8.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260820    clang-24
csky                 randconfig-001-20260820    gcc-14.3.0
csky                 randconfig-001-20260820    gcc-16.1.0
csky                 randconfig-001-20260821    gcc-8.5.0
csky                 randconfig-002-20260820    clang-24
csky                 randconfig-002-20260820    gcc-14.3.0
csky                 randconfig-002-20260820    gcc-16.1.0
csky                 randconfig-002-20260821    gcc-8.5.0
hexagon                       randconfig-001    gcc-14.3.0
hexagon              randconfig-001-20260820    clang-18
hexagon              randconfig-001-20260820    gcc-14.3.0
hexagon              randconfig-002-20260820    clang-19
hexagon              randconfig-002-20260820    gcc-14.3.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260820    gcc-14
i386       buildonly-randconfig-001-20260821    gcc-14
i386       buildonly-randconfig-002-20260820    clang-22
i386       buildonly-randconfig-002-20260820    gcc-14
i386       buildonly-randconfig-002-20260821    gcc-14
i386       buildonly-randconfig-003-20260820    gcc-14
i386       buildonly-randconfig-003-20260821    gcc-14
i386       buildonly-randconfig-004-20260820    clang-22
i386       buildonly-randconfig-004-20260820    gcc-14
i386       buildonly-randconfig-004-20260821    gcc-14
i386       buildonly-randconfig-005-20260820    gcc-14
i386       buildonly-randconfig-005-20260821    gcc-14
i386       buildonly-randconfig-006-20260820    gcc-13
i386       buildonly-randconfig-006-20260820    gcc-14
i386       buildonly-randconfig-006-20260821    gcc-14
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260820    clang-22
i386                 randconfig-002-20260820    clang-22
i386                 randconfig-003-20260820    clang-22
i386                 randconfig-004-20260820    clang-22
i386                 randconfig-005-20260820    clang-22
i386                 randconfig-006-20260820    clang-22
i386                 randconfig-007-20260820    clang-22
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260820    gcc-14
i386                 randconfig-012-20260820    gcc-14
i386                 randconfig-013-20260820    gcc-14
i386                 randconfig-014-20260820    gcc-14
i386                 randconfig-015-20260820    clang-22
i386                 randconfig-015-20260820    gcc-14
i386                 randconfig-016-20260820    gcc-14
i386                 randconfig-017-20260820    clang-22
i386                 randconfig-017-20260820    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260820    clang-18
loongarch            randconfig-001-20260820    gcc-14.3.0
loongarch            randconfig-002-20260820    gcc-14.3.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260820    gcc-11.5.0
nios2                randconfig-001-20260820    gcc-14.3.0
nios2                randconfig-002-20260820    gcc-11.5.0
nios2                randconfig-002-20260820    gcc-14.3.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260820    gcc-8.5.0
parisc               randconfig-002-20260820    gcc-11.5.0
parisc               randconfig-002-20260820    gcc-8.5.0
powerpc                  lite5200b_defconfig    clang-24
powerpc              randconfig-001-20260820    clang-24
powerpc              randconfig-001-20260820    gcc-8.5.0
powerpc              randconfig-002-20260820    gcc-8.5.0
powerpc                    sequoia_defconfig    clang-24
powerpc64            randconfig-001-20260820    clang-24
powerpc64            randconfig-001-20260820    gcc-8.5.0
powerpc64            randconfig-002-20260820    gcc-10.5.0
powerpc64            randconfig-002-20260820    gcc-8.5.0
riscv                         randconfig-001    clang-24
riscv                randconfig-001-20260820    clang-24
riscv                randconfig-001-20260820    gcc-8.5.0
riscv                randconfig-002-20260820    clang-21
riscv                randconfig-002-20260820    clang-24
s390                 randconfig-001-20260820    clang-24
s390                 randconfig-001-20260820    gcc-8.5.0
s390                 randconfig-002-20260820    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260820    clang-24
sh                   randconfig-001-20260820    gcc-10.5.0
sh                   randconfig-002-20260820    clang-24
sh                   randconfig-002-20260820    gcc-12.5.0
sparc                         randconfig-001    gcc-8.5.0
sparc                randconfig-001-20260820    gcc-13.4.0
sparc                randconfig-001-20260820    gcc-8.5.0
sparc                randconfig-001-20260821    gcc-8.5.0
sparc                randconfig-002-20260820    gcc-13.4.0
sparc                randconfig-002-20260820    gcc-16.1.0
sparc                randconfig-002-20260821    gcc-8.5.0
sparc                      sparc32_defconfig    gcc-16.1.0
sparc                      sparc64_defconfig    gcc-16.1.0
sparc64              randconfig-001-20260820    gcc-11.5.0
sparc64              randconfig-001-20260820    gcc-13.4.0
sparc64              randconfig-001-20260821    gcc-8.5.0
sparc64              randconfig-002-20260820    gcc-13.4.0
sparc64              randconfig-002-20260820    gcc-9.5.0
sparc64              randconfig-002-20260821    gcc-8.5.0
um                   randconfig-001-20260820    gcc-13.4.0
um                   randconfig-001-20260820    gcc-14
um                   randconfig-001-20260821    gcc-8.5.0
um                   randconfig-002-20260820    gcc-13.4.0
um                   randconfig-002-20260820    gcc-14
um                   randconfig-002-20260821    gcc-8.5.0
x86_64     buildonly-randconfig-001-20260820    gcc-14
x86_64     buildonly-randconfig-002-20260820    gcc-14
x86_64     buildonly-randconfig-003-20260820    clang-22
x86_64     buildonly-randconfig-003-20260820    gcc-14
x86_64     buildonly-randconfig-004-20260820    clang-22
x86_64     buildonly-randconfig-004-20260820    gcc-14
x86_64     buildonly-randconfig-005-20260820    clang-22
x86_64     buildonly-randconfig-005-20260820    gcc-14
x86_64     buildonly-randconfig-006-20260820    clang-22
x86_64     buildonly-randconfig-006-20260820    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260820    clang-22
x86_64               randconfig-002-20260820    clang-22
x86_64               randconfig-003-20260820    clang-22
x86_64               randconfig-004-20260820    clang-22
x86_64               randconfig-005-20260820    clang-22
x86_64               randconfig-006-20260820    clang-22
x86_64               randconfig-011-20260820    clang-22
x86_64               randconfig-012-20260820    clang-22
x86_64               randconfig-013-20260820    clang-22
x86_64               randconfig-013-20260820    gcc-13
x86_64               randconfig-014-20260820    clang-22
x86_64               randconfig-015-20260820    clang-22
x86_64               randconfig-015-20260820    gcc-14
x86_64               randconfig-016-20260820    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260820    clang-22
x86_64               randconfig-071-20260820    gcc-14
x86_64               randconfig-072-20260820    clang-22
x86_64               randconfig-072-20260820    gcc-14
x86_64               randconfig-073-20260820    clang-22
x86_64               randconfig-073-20260820    gcc-14
x86_64               randconfig-074-20260820    clang-22
x86_64               randconfig-074-20260820    gcc-14
x86_64               randconfig-075-20260820    clang-22
x86_64               randconfig-075-20260820    gcc-14
x86_64               randconfig-076-20260820    clang-22
x86_64               randconfig-076-20260820    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260820    gcc-13.4.0
xtensa               randconfig-001-20260820    gcc-8.5.0
xtensa               randconfig-001-20260821    gcc-8.5.0
xtensa               randconfig-002-20260820    gcc-13.4.0
xtensa               randconfig-002-20260821    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
