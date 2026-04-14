Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DAE26B0A9
	for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172184; cv=none; b=OkArRgOef7+n7sz61tcfVvRR3h9snvIM7avA6GJvUiPCLZdvz/QW8x2DrxB9xTUcu47Uhru0eN/soihusjK2nEwkeSSEeNxJW/mAyos8gjpPsyFQ35+zUY52RB6ZvgbbMl9YYMddpBnBy//8xE/nL0LScXrSzMVQV6KtKFITk5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172184; c=relaxed/simple;
	bh=3reLewjbVousu+B7IFismmQZJ3+1FWCbu+I9jmxY0ko=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TPqPWzI67zWQQZY0r+K7KnIQOGbF36oXoQdK5SM5etKz62gFod+hPZ2S5md572B6yITKEznX+klESlko21JT42i5LLAZvLklVi0W0JqxPc/my3YWjymL2SQET1SWPcb3C6AM5N9ARb4RRA4XKb//bhkvNIjSixIEWoDAb/dcyz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G3rDq+5y; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3rDq+5y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776172183; x=1807708183;
  h=date:from:to:cc:subject:message-id;
  bh=3reLewjbVousu+B7IFismmQZJ3+1FWCbu+I9jmxY0ko=;
  b=G3rDq+5yYW4cpZ+bUZPnPcPnZ0MNRNLo5uyJuwMsJNtlNIpFwQbvUSt4
   TRkMrvwbEHAnRIFfN1+1ScxDjxro6VaHFGzvQhoG7WBPz9MB7GIBZ+Z58
   SpzxmxymvTWo/PW/LwTSbtxo2F79u+AJiC2cmjjDdEfuKPjiXxlHxhHOP
   Hf6SN31VY0ySHyJ3he+BXD03b6oSe8lHFjX1La6AhhbpKifbVETbHmJBI
   dxm1gPtBRXLX4XvMjgGpNAHy/lPvdtZsTzPD1cPjubbUqIHewPp4proiP
   vk21k2wfdTWA5aIzMpA79IS6zFBXGXxm9LrqzkYdVJgehiMyJcvjJkMkG
   Q==;
X-CSE-ConnectionGUID: t5O9aKEaSfGo7hQaqBc/ow==
X-CSE-MsgGUID: 3m0pDlUXQHqMMkt2IBMazA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="102585583"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="102585583"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 06:09:42 -0700
X-CSE-ConnectionGUID: CT0abaCrTqe3QMR65e0+6A==
X-CSE-MsgGUID: kwwRccx1TDmyCE3c6cyXsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229218292"
Received: from lkp-server01.sh.intel.com (HELO 7b0b59b3a0d4) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 14 Apr 2026 06:09:41 -0700
Received: from kbuild by 7b0b59b3a0d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCdWN-000000001Sv-0A6n;
	Tue, 14 Apr 2026 13:09:39 +0000
Date: Tue, 14 Apr 2026 21:09:28 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 4224e91fea5695a89843b4c38283016616946307
Message-ID: <202604142121.OzzBkGEF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 4224e91fea5695a89843b4c38283016616946307  Merge branch 'pci/misc'

elapsed time: 1095m

configs tested: 141
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260414    gcc-9.5.0
arc                   randconfig-002-20260414    gcc-11.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260414    clang-23
arm                   randconfig-002-20260414    gcc-15.2.0
arm                   randconfig-003-20260414    clang-23
arm                   randconfig-004-20260414    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-002-20260414    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260414    clang-23
hexagon               randconfig-002-20260414    clang-16
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260414    clang-20
i386        buildonly-randconfig-002-20260414    clang-20
i386        buildonly-randconfig-003-20260414    gcc-14
i386        buildonly-randconfig-004-20260414    gcc-14
i386        buildonly-randconfig-005-20260414    gcc-14
i386        buildonly-randconfig-006-20260414    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260414    gcc-14
i386                  randconfig-002-20260414    clang-20
i386                  randconfig-003-20260414    gcc-14
i386                  randconfig-004-20260414    clang-20
i386                  randconfig-005-20260414    clang-20
i386                  randconfig-006-20260414    clang-20
i386                  randconfig-007-20260414    gcc-14
i386                  randconfig-011-20260414    clang-20
i386                  randconfig-012-20260414    clang-20
i386                  randconfig-013-20260414    gcc-14
i386                  randconfig-014-20260414    gcc-14
i386                  randconfig-015-20260414    clang-20
i386                  randconfig-016-20260414    clang-20
i386                  randconfig-017-20260414    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260414    clang-18
loongarch             randconfig-002-20260414    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260414    gcc-11.5.0
nios2                 randconfig-002-20260414    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260414    gcc-8.5.0
parisc                randconfig-002-20260414    gcc-14.3.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260414    gcc-8.5.0
powerpc               randconfig-002-20260414    gcc-8.5.0
powerpc                     tqm8541_defconfig    clang-23
powerpc64             randconfig-001-20260414    gcc-13.4.0
powerpc64             randconfig-002-20260414    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-002-20260414    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260414    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260414    gcc-15.2.0
sh                    randconfig-002-20260414    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260414    gcc-15.2.0
sparc                 randconfig-002-20260414    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260414    gcc-8.5.0
sparc64               randconfig-002-20260414    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260414    clang-23
um                    randconfig-002-20260414    gcc-12
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260414    gcc-14
x86_64      buildonly-randconfig-002-20260414    gcc-14
x86_64      buildonly-randconfig-003-20260414    gcc-14
x86_64      buildonly-randconfig-004-20260414    clang-20
x86_64      buildonly-randconfig-005-20260414    gcc-14
x86_64      buildonly-randconfig-006-20260414    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260414    gcc-14
x86_64                randconfig-002-20260414    clang-20
x86_64                randconfig-003-20260414    gcc-14
x86_64                randconfig-004-20260414    clang-20
x86_64                randconfig-005-20260414    clang-20
x86_64                randconfig-006-20260414    clang-20
x86_64                randconfig-014-20260414    gcc-14
x86_64                randconfig-071-20260414    gcc-14
x86_64                randconfig-072-20260414    gcc-14
x86_64                randconfig-073-20260414    gcc-14
x86_64                randconfig-074-20260414    gcc-14
x86_64                randconfig-075-20260414    gcc-14
x86_64                randconfig-076-20260414    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260414    gcc-8.5.0
xtensa                randconfig-002-20260414    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
