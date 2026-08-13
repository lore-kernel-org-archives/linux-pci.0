Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BFD3382C7
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786587990; cv=none; b=QIeFuO/KJFt6W8lK/xk8nBxKql20tR/fHo28DB0j4mfv6T+KXtJxjFNjg9XMVpLHlrpaPQKs5AVLhrRyTHjbMTeHTNMsAf9BHZPk7AwQNTAKDZmU1HAS7ONfmzrw0sKRwlR1L7D8ft5rOFD/EYai5JYzKVNX2m+Hh9e2egUS0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786587990; c=relaxed/simple;
	bh=1wf0DlkYNJ1Icv7D/qD+Jc6wngCwToZL1614SY+QVdU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Za4v8gPCoiXhzXjrubfTWxIzibHC2P2OqYOnLGVfgPCnI5GQ7+SuH5fYi1yupvlZOBLQBN4PSOVZkRRpW7Lud06Sy3rLzraYj6t3P7/Lbp4G5aDByJSMseb9KgZzjbAlaabbXVa123OowrlKP8Q6KSQspfqUEPcGVdNl2QRlf1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPg4/5+A; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPg4/5+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786587989; x=1818123989;
  h=date:from:to:cc:subject:message-id;
  bh=1wf0DlkYNJ1Icv7D/qD+Jc6wngCwToZL1614SY+QVdU=;
  b=WPg4/5+AFxz0WfQMhrCSj94EP1grgo8Qo8c7fMw5ooVlVJ9eMsTUGtVN
   7DpoVh+h0PlncE7fjb30XDlaI2StvNOo/H9Q+E31czqQvplvyvaeyNl3H
   /UBHDZA/LKXYFYBeKMAYsuTESVu77ZqSA5GV4xqefkZjhMTqJB2LKjNxE
   BonqmIgZY9nsvOGWqix6cfDQTSFy7pJlNO8RA+WPl6yZQAgVQcy9qILQk
   He5Cpf9/A0XCcEP0szBsD4NEEO3mpA7V4TAdWxI5MmdPcpHkH2buLKin6
   oKjxs0pcwc1JNFm9WHk0fYqsV4xv2Zh+izo6mukiNn8n23sUVNdMw2S3K
   w==;
X-CSE-ConnectionGUID: 33FJ8lWWRBSW6ghayTlVEQ==
X-CSE-MsgGUID: CQgVhO+iQz6q15F1KxZ9wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87374205"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="87374205"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 19:26:28 -0700
X-CSE-ConnectionGUID: 0vmgwcEtR+q+6Be+tA0z/Q==
X-CSE-MsgGUID: QsPvDA/tS6K2SWA/zaZwjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="293760119"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 12 Aug 2026 19:26:27 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuL9E-00000000SXK-2u4B;
	Thu, 13 Aug 2026 02:26:24 +0000
Date: Thu, 13 Aug 2026 10:25:43 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 d55d5a8f3d852baab49dba910dcb04b6d8091b05
Message-ID: <202608131032.tE9Dh4kJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: d55d5a8f3d852baab49dba910dcb04b6d8091b05  Merge branch 'pci/misc'

elapsed time: 2416m

configs tested: 165
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-12.5.0
arc                  randconfig-001-20260812    gcc-12.5.0
arc                  randconfig-001-20260813    gcc-13.4.0
arc                  randconfig-002-20260812    gcc-12.5.0
arc                  randconfig-002-20260813    gcc-13.4.0
arm                    am200epdkit_defconfig    gcc-16.1.0
arm                       keystone_defconfig    gcc-16.1.0
arm                        mv78xx0_defconfig    clang-24
arm                  randconfig-001-20260812    gcc-12.5.0
arm                  randconfig-001-20260813    gcc-13.4.0
arm                  randconfig-002-20260812    gcc-12.5.0
arm                  randconfig-002-20260813    gcc-13.4.0
arm                  randconfig-003-20260812    gcc-12.5.0
arm                  randconfig-003-20260813    gcc-13.4.0
arm                  randconfig-004-20260812    gcc-12.5.0
arm                  randconfig-004-20260813    gcc-13.4.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260812    gcc-10.5.0
arm64                randconfig-001-20260812    gcc-14.3.0
arm64                randconfig-002-20260812    gcc-10.5.0
arm64                randconfig-002-20260812    gcc-14.3.0
arm64                randconfig-003-20260812    gcc-10.5.0
arm64                randconfig-003-20260812    gcc-14.3.0
arm64                randconfig-004-20260812    gcc-10.5.0
arm64                randconfig-004-20260812    gcc-14.3.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260812    gcc-10.5.0
csky                 randconfig-001-20260812    gcc-14.3.0
csky                 randconfig-002-20260812    gcc-10.5.0
csky                 randconfig-002-20260812    gcc-14.3.0
hexagon                       randconfig-001    gcc-11.5.0
hexagon              randconfig-001-20260812    gcc-11.5.0
hexagon              randconfig-001-20260813    gcc-11.5.0
hexagon              randconfig-002-20260812    gcc-11.5.0
hexagon              randconfig-002-20260813    gcc-11.5.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    clang-22
i386       buildonly-randconfig-001-20260812    clang-22
i386       buildonly-randconfig-002-20260812    clang-22
i386       buildonly-randconfig-003-20260812    clang-22
i386       buildonly-randconfig-004-20260812    clang-22
i386       buildonly-randconfig-005-20260812    clang-22
i386       buildonly-randconfig-006-20260812    clang-22
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260812    clang-22
i386                 randconfig-001-20260813    clang-22
i386                 randconfig-002-20260812    clang-22
i386                 randconfig-002-20260813    clang-22
i386                 randconfig-003-20260812    clang-22
i386                 randconfig-003-20260813    clang-22
i386                 randconfig-004-20260812    clang-22
i386                 randconfig-004-20260813    clang-22
i386                 randconfig-005-20260812    clang-22
i386                 randconfig-005-20260813    clang-22
i386                 randconfig-006-20260812    clang-22
i386                 randconfig-006-20260813    clang-22
i386                 randconfig-007-20260812    clang-22
i386                 randconfig-007-20260813    clang-22
i386                          randconfig-011    gcc-12
i386                 randconfig-011-20260812    gcc-12
i386                 randconfig-012-20260812    gcc-12
i386                 randconfig-013-20260812    gcc-12
i386                 randconfig-014-20260812    gcc-12
i386                 randconfig-015-20260812    gcc-12
i386                 randconfig-016-20260812    gcc-12
i386                 randconfig-017-20260812    gcc-12
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260812    gcc-11.5.0
loongarch            randconfig-001-20260813    gcc-11.5.0
loongarch            randconfig-002-20260812    gcc-11.5.0
loongarch            randconfig-002-20260813    gcc-11.5.0
mips                    cu1000-neo_defconfig    gcc-16.1.0
mips                         eyeq5_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260812    gcc-11.5.0
nios2                randconfig-001-20260813    gcc-11.5.0
nios2                randconfig-002-20260812    gcc-11.5.0
nios2                randconfig-002-20260813    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260812    clang-17
parisc               randconfig-001-20260813    gcc-10.5.0
parisc               randconfig-002-20260812    clang-17
parisc               randconfig-002-20260813    gcc-10.5.0
powerpc              randconfig-001-20260812    clang-17
powerpc              randconfig-001-20260813    gcc-10.5.0
powerpc              randconfig-002-20260812    clang-17
powerpc              randconfig-002-20260813    gcc-10.5.0
powerpc64            randconfig-001-20260812    clang-17
powerpc64            randconfig-001-20260813    gcc-10.5.0
powerpc64            randconfig-002-20260812    clang-17
powerpc64            randconfig-002-20260813    gcc-10.5.0
riscv                         randconfig-001    clang-24
riscv                randconfig-001-20260812    clang-24
riscv                randconfig-001-20260813    gcc-10.5.0
riscv                randconfig-002-20260812    clang-24
riscv                randconfig-002-20260813    gcc-10.5.0
s390                 randconfig-001-20260812    clang-24
s390                 randconfig-001-20260813    gcc-10.5.0
s390                 randconfig-002-20260812    clang-24
s390                 randconfig-002-20260813    gcc-10.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260812    clang-24
sh                   randconfig-001-20260813    gcc-10.5.0
sh                   randconfig-002-20260812    clang-24
sh                   randconfig-002-20260813    gcc-10.5.0
sparc                         randconfig-001    gcc-13.4.0
sparc                randconfig-001-20260812    gcc-13.4.0
sparc                randconfig-001-20260813    clang-20
sparc                randconfig-002-20260812    gcc-13.4.0
sparc                randconfig-002-20260813    clang-20
sparc64              randconfig-001-20260812    gcc-13.4.0
sparc64              randconfig-001-20260813    clang-20
sparc64              randconfig-002-20260812    gcc-13.4.0
sparc64              randconfig-002-20260813    clang-20
um                   randconfig-001-20260812    gcc-13.4.0
um                   randconfig-001-20260813    clang-20
um                   randconfig-002-20260812    gcc-13.4.0
um                   randconfig-002-20260813    clang-20
x86_64              buildonly-randconfig-001    gcc-14
x86_64     buildonly-randconfig-001-20260812    gcc-14
x86_64     buildonly-randconfig-002-20260812    gcc-14
x86_64     buildonly-randconfig-003-20260812    gcc-14
x86_64     buildonly-randconfig-004-20260812    gcc-14
x86_64     buildonly-randconfig-005-20260812    gcc-14
x86_64     buildonly-randconfig-006-20260812    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260812    clang-22
x86_64               randconfig-001-20260812    gcc-14
x86_64               randconfig-002-20260812    clang-22
x86_64               randconfig-002-20260812    gcc-14
x86_64               randconfig-003-20260812    clang-22
x86_64               randconfig-003-20260812    gcc-14
x86_64               randconfig-004-20260812    clang-22
x86_64               randconfig-004-20260812    gcc-14
x86_64               randconfig-005-20260812    clang-22
x86_64               randconfig-005-20260812    gcc-14
x86_64               randconfig-006-20260812    clang-22
x86_64               randconfig-006-20260812    gcc-14
x86_64                        randconfig-011    clang-22
x86_64               randconfig-011-20260812    clang-22
x86_64               randconfig-012-20260812    clang-22
x86_64               randconfig-013-20260812    clang-22
x86_64               randconfig-014-20260812    clang-22
x86_64               randconfig-015-20260812    clang-22
x86_64               randconfig-016-20260812    clang-22
x86_64               randconfig-071-20260812    clang-22
x86_64               randconfig-072-20260812    clang-22
x86_64               randconfig-073-20260812    clang-22
x86_64               randconfig-074-20260812    clang-22
x86_64               randconfig-075-20260812    clang-22
x86_64               randconfig-076-20260812    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260812    gcc-13.4.0
xtensa               randconfig-001-20260813    clang-20
xtensa               randconfig-002-20260812    gcc-13.4.0
xtensa               randconfig-002-20260813    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
