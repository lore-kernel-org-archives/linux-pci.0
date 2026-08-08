Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F190394EB0
	for <linux-pci@vger.kernel.org>; Sat,  8 Aug 2026 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208893; cv=none; b=U5bvBlYec/ggCdvxSlPuEOOmlgeELwS2cTITpgQ86nmBkK0MypAOPVlkHOW7sdVKmVFxaAzFzAVCO81rBpBkVeLzeZFD9OQx89LiDKHVjrzzs9+FTgNJxffIJtcDbcTqhrl7KQNhg9Xfna3dbFrR/iAQSXBsLj0tQBr7phbbUPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208893; c=relaxed/simple;
	bh=fu+2fNcABOirS6P+3ebOkgze/fT4EAEtLTuu6IJQKt0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nI/8tU5hb0XZB0O1w2pfel3skfjg4m9aE3/8b7bGq4uwKJrAMiwuJ8xTbEAYVJOIelLy6gS7ciqFWraepQoVAZ9sA0Rga4YplGuPupoNRRT1jBLKb0u7QoGP8bRkoa8vkreStL8kRMz7cevcDuTM8a9+ghSMPSPQqsmubpZpueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buSIctn3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buSIctn3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786208892; x=1817744892;
  h=date:from:to:cc:subject:message-id;
  bh=fu+2fNcABOirS6P+3ebOkgze/fT4EAEtLTuu6IJQKt0=;
  b=buSIctn3amEVmcxo0qTwGOW4j2W06n9C5rMzTEJzmgZ6jHU/Blqq/hA6
   QxBw4+5A77ZGpmPwTFMx6bUOjx8TqxntnLTR+/z460iW3uruZwe2E0O68
   3QZpaRtMyoTxWRqR3wfXFjvhe4Uz8Z5wplz0ZvG/vMmrngNuWxzPeTTOv
   14v0mdQF3RvmTeAx3e0VsRporBmekyKSQZN4D3d5/3RcmQA4Gylm93DoY
   X9AWKHHZC0pd6gEEzbPh7+wLfkYmX+/0IddTye26BR57IRNu7+YXUmwaC
   ZIIRLoPcqPsYlt7024vwMFl92IR1OFLl9xptEyU3eGKgrmn6wY2IZH00P
   Q==;
X-CSE-ConnectionGUID: RC+GkWo3R5abYSdKIyHZ4Q==
X-CSE-MsgGUID: 8OxOX9eWQ4+kUTi3EoPg1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="97942108"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="97942108"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 10:08:11 -0700
X-CSE-ConnectionGUID: hQyWnVUwTRi2H1X+3Qnj+w==
X-CSE-MsgGUID: 9F+1NZ9ZQ8qMjK2iVRjQqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="300875781"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 08 Aug 2026 10:08:10 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wskWl-00000000KUg-2Y3A;
	Sat, 08 Aug 2026 17:08:07 +0000
Date: Sun, 09 Aug 2026 01:08:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 3de6add8d15430cde96c615fd156216676762bf9
Message-ID: <202608090148.sqs6UEe3-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 3de6add8d15430cde96c615fd156216676762bf9  Merge branch 'pci/misc'

elapsed time: 2811m

configs tested: 152
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260807    gcc-14.3.0
arc                  randconfig-001-20260808    gcc-9.5.0
arc                  randconfig-002-20260807    gcc-14.3.0
arc                  randconfig-002-20260808    gcc-9.5.0
arm                      aspeed_g5_defconfig    gcc-16.1.0
arm                  randconfig-001-20260807    gcc-14.3.0
arm                  randconfig-001-20260808    gcc-9.5.0
arm                  randconfig-002-20260807    gcc-14.3.0
arm                  randconfig-002-20260808    gcc-9.5.0
arm                  randconfig-003-20260807    gcc-14.3.0
arm                  randconfig-003-20260808    gcc-9.5.0
arm                  randconfig-004-20260807    gcc-14.3.0
arm                  randconfig-004-20260808    gcc-9.5.0
arm64                         randconfig-001    gcc-11.5.0
arm64                randconfig-001-20260807    gcc-16.1.0
arm64                randconfig-001-20260808    gcc-11.5.0
arm64                randconfig-002-20260807    gcc-16.1.0
arm64                randconfig-002-20260808    gcc-11.5.0
arm64                randconfig-003-20260807    gcc-16.1.0
arm64                randconfig-003-20260808    gcc-11.5.0
arm64                randconfig-004-20260807    gcc-16.1.0
arm64                randconfig-004-20260808    gcc-11.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260807    gcc-16.1.0
csky                 randconfig-001-20260808    gcc-11.5.0
csky                 randconfig-002-20260807    gcc-16.1.0
csky                 randconfig-002-20260808    gcc-11.5.0
hexagon              randconfig-001-20260807    clang-18
hexagon              randconfig-001-20260807    clang-24
hexagon              randconfig-001-20260808    gcc-16.1.0
hexagon              randconfig-002-20260807    clang-18
hexagon              randconfig-002-20260807    clang-24
hexagon              randconfig-002-20260808    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    clang-22
i386       buildonly-randconfig-001-20260807    gcc-13
i386       buildonly-randconfig-001-20260808    clang-22
i386       buildonly-randconfig-002-20260807    gcc-13
i386       buildonly-randconfig-002-20260808    clang-22
i386       buildonly-randconfig-003-20260807    gcc-13
i386       buildonly-randconfig-003-20260808    clang-22
i386       buildonly-randconfig-004-20260807    gcc-13
i386       buildonly-randconfig-004-20260808    clang-22
i386       buildonly-randconfig-005-20260807    gcc-13
i386       buildonly-randconfig-005-20260808    clang-22
i386       buildonly-randconfig-006-20260807    gcc-13
i386       buildonly-randconfig-006-20260808    clang-22
i386                 randconfig-001-20260808    clang-22
i386                 randconfig-002-20260808    clang-22
i386                 randconfig-003-20260808    clang-22
i386                 randconfig-004-20260808    clang-22
i386                 randconfig-005-20260808    clang-22
i386                 randconfig-006-20260808    clang-22
i386                 randconfig-007-20260808    clang-22
i386                 randconfig-011-20260807    clang-22
i386                 randconfig-011-20260808    clang-22
i386                 randconfig-012-20260807    clang-22
i386                 randconfig-012-20260808    clang-22
i386                 randconfig-013-20260807    clang-22
i386                 randconfig-013-20260808    clang-22
i386                 randconfig-014-20260807    clang-22
i386                 randconfig-014-20260808    clang-22
i386                 randconfig-015-20260807    clang-22
i386                 randconfig-015-20260808    clang-22
i386                 randconfig-016-20260807    clang-22
i386                 randconfig-016-20260808    clang-22
i386                 randconfig-017-20260807    clang-22
i386                 randconfig-017-20260808    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260807    clang-18
loongarch            randconfig-001-20260807    clang-24
loongarch            randconfig-001-20260808    gcc-16.1.0
loongarch            randconfig-002-20260807    clang-18
loongarch            randconfig-002-20260808    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260807    clang-18
nios2                randconfig-001-20260807    gcc-8.5.0
nios2                randconfig-001-20260808    gcc-16.1.0
nios2                randconfig-002-20260807    clang-18
nios2                randconfig-002-20260807    gcc-8.5.0
nios2                randconfig-002-20260808    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260808    gcc-8.5.0
parisc               randconfig-002-20260808    gcc-8.5.0
powerpc              randconfig-001-20260808    gcc-8.5.0
powerpc              randconfig-002-20260808    gcc-8.5.0
powerpc64            randconfig-001-20260808    gcc-8.5.0
powerpc64            randconfig-002-20260808    gcc-8.5.0
riscv                randconfig-001-20260808    clang-24
riscv                randconfig-002-20260808    clang-24
s390                 randconfig-001-20260808    clang-24
s390                 randconfig-002-20260808    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260808    clang-24
sh                   randconfig-002-20260808    clang-24
sparc                randconfig-001-20260808    gcc-8.5.0
sparc                randconfig-002-20260808    gcc-8.5.0
sparc64              randconfig-001-20260808    gcc-8.5.0
sparc64              randconfig-002-20260808    gcc-8.5.0
um                   randconfig-001-20260808    gcc-8.5.0
um                   randconfig-002-20260808    gcc-8.5.0
x86_64     buildonly-randconfig-001-20260807    clang-22
x86_64     buildonly-randconfig-001-20260808    gcc-14
x86_64     buildonly-randconfig-002-20260807    clang-22
x86_64     buildonly-randconfig-002-20260808    gcc-14
x86_64     buildonly-randconfig-003-20260807    clang-22
x86_64     buildonly-randconfig-003-20260808    gcc-14
x86_64     buildonly-randconfig-004-20260807    clang-22
x86_64     buildonly-randconfig-004-20260808    gcc-14
x86_64     buildonly-randconfig-005-20260807    clang-22
x86_64     buildonly-randconfig-005-20260808    gcc-14
x86_64     buildonly-randconfig-006-20260807    clang-22
x86_64     buildonly-randconfig-006-20260808    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    clang-22
x86_64               randconfig-001-20260808    clang-22
x86_64               randconfig-002-20260808    clang-22
x86_64               randconfig-003-20260808    clang-22
x86_64               randconfig-004-20260808    clang-22
x86_64               randconfig-005-20260808    clang-22
x86_64               randconfig-006-20260808    clang-22
x86_64               randconfig-011-20260808    clang-22
x86_64               randconfig-012-20260808    clang-22
x86_64               randconfig-013-20260808    clang-22
x86_64               randconfig-014-20260808    clang-22
x86_64               randconfig-015-20260808    clang-22
x86_64               randconfig-016-20260808    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260807    clang-22
x86_64               randconfig-071-20260808    gcc-14
x86_64               randconfig-072-20260807    clang-22
x86_64               randconfig-072-20260808    gcc-14
x86_64               randconfig-073-20260807    clang-22
x86_64               randconfig-073-20260808    gcc-14
x86_64               randconfig-074-20260807    clang-22
x86_64               randconfig-074-20260808    gcc-14
x86_64               randconfig-075-20260807    clang-22
x86_64               randconfig-075-20260808    gcc-14
x86_64               randconfig-076-20260807    clang-22
x86_64               randconfig-076-20260808    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa                 nommu_kc705_defconfig    gcc-16.1.0
xtensa               randconfig-001-20260808    gcc-8.5.0
xtensa               randconfig-002-20260808    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
