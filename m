Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96A0495ACF
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992634; cv=none; b=ocg4O7/aYZSi8xkWLBvUI0c7SHkPEG9PhQyIooen1ibYYCjZbFecGfj2r/uXHVuAII8z48f5svjzYapi23sh5CgKjM9Jj+zB1FWXQ0EbCNEgYYIj+Se/CJRp54fK/st2jRWVFqyUosd8rD586J4qtvnH6lvEmmeYDD9XglvZhl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992634; c=relaxed/simple;
	bh=5TZ3EPpQnzQSIvCkMcb31CbV1T6fHoGZFQ9Vk5ddico=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I//vil/3syi+8r/kpX07K84u0zaztw2IZpiRv9F2HJ8qbw1bTHgQ3HyX3qIf26VUhhcSXNTOlOyERS5QMA5BIAWQJZSes9xCB7xtfa21o2FBiUGKDFoXnFXSQ363xgHxkLOIhjkPYbbIcAUEX88Fnn4ElEl4KKsyissheY5XwjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYRInQNE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYRInQNE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789992633; x=1821528633;
  h=date:from:to:cc:subject:message-id;
  bh=5TZ3EPpQnzQSIvCkMcb31CbV1T6fHoGZFQ9Vk5ddico=;
  b=lYRInQNEVhzcCOP4BZ06EXhMTMaQqbXe65grGQFQz3qR25TTtXNBrKwh
   BGSR8nUxTzYZw7ELD10sozkgVpZ29aScUq8WfIyYkOiDtbWbJaT6GYtB9
   23GkGbkru0ZOTpv4vbvo1fTNDHxtapFWNCtsmbYquv5R52p0oySWL59t+
   3mog7LRtDh/eDeaDTg+IXd1N1S2y2lxmvVp1GjeIfEKxCs1galfX6+2Um
   euMuG85h9fjX+3b0REJ+Ap7hc0jRXEuV96lp0LOyKlmJsstq66xjwsOty
   sWo9zM+001sU4SL4uSOVto9ZmRC7mMFHu7b40zIL+M1tLiM/L2+dMqQ5n
   Q==;
X-CSE-ConnectionGUID: NJMoVqLuRw2bW0WTCjUIJg==
X-CSE-MsgGUID: 0/3naVP1Taeqsm+dqL7/Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="90366824"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="90366824"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 05:10:31 -0700
X-CSE-ConnectionGUID: J3PUdYcnSJK0MwyId5+Z2w==
X-CSE-MsgGUID: uy8nOCCjQtyK724OQRQCFg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Sep 2026 05:10:30 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x8cqq-00000000Dj7-0RI3;
	Mon, 21 Sep 2026 12:10:28 +0000
Date: Mon, 21 Sep 2026 20:09:58 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 ff8a969f7dc8e79ea6113abcfa983e070b2b585a
Message-ID: <202609212054.MfoM3mP2-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: ff8a969f7dc8e79ea6113abcfa983e070b2b585a  PCI: Skip Target Speed quirk on clamped ports with no link

elapsed time: 2705m

configs tested: 164
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r1309-20260921    gcc-13.4.0 sparse
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260921    gcc-9.5.0
arc                   randconfig-1001-20260921    gcc-15.2.0
arm                                allnoconfig    clang-17
arm                               allyesconfig    gcc-16.1.0
arm                      am200epdkit_defconfig    gcc-16.1.0
arm                          assabet_defconfig    clang-22
arm                                  defconfig    clang-24
arm                   randconfig-1000-20260921    clang-24
arm                   randconfig-1001-20260921    gcc-13.4.0
arm                   randconfig-1002-20260921    gcc-15.2.0
arm                   randconfig-1003-20260921    clang-24
arm                  randconfig-r1300-20260921    clang-24   sparse
arm                        versatile_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260921    clang-24
arm64                 randconfig-1001-20260921    clang-24
arm64                 randconfig-1002-20260921    clang-24
arm64                 randconfig-1003-20260921    gcc-16.1.0
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260921    gcc-9.5.0
csky                  randconfig-1001-20260921    gcc-11.5.0
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                              defconfig    clang-24
hexagon               randconfig-1000-20260921    clang-18
hexagon               randconfig-1001-20260921    clang-17
i386                               allnoconfig    gcc-14
i386                                 defconfig    clang-22
i386                  randconfig-1000-20260921    clang-22
i386                  randconfig-1001-20260921    clang-22
i386                  randconfig-1002-20260921    clang-22
i386                  randconfig-1003-20260921    gcc-14
i386                  randconfig-1004-20260921    gcc-13
i386                  randconfig-1005-20260921    clang-22
i386                  randconfig-1006-20260921    clang-22
i386                  randconfig-1007-20260921    gcc-14
i386                  randconfig-1008-20260921    clang-22
i386                  randconfig-1009-20260921    gcc-14
i386                  randconfig-1010-20260921    gcc-14
i386                  randconfig-1011-20260921    clang-22
i386                  randconfig-1012-20260921    clang-22
i386                  randconfig-1013-20260921    clang-22
i386                  randconfig-1300-20260921    clang-22   sparse
i386                  randconfig-1302-20260921    gcc-14     sparse
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260921    clang-18
loongarch             randconfig-1001-20260921    gcc-16.1.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    gcc-16.1.0
m68k                           multi_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    gcc-16.1.0
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260921    gcc-8.5.0
nios2                 randconfig-1001-20260921    gcc-11.5.0
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r1307-20260921    gcc-16.1.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260921    gcc-8.5.0
parisc                randconfig-1001-20260921    gcc-13.4.0
parisc               randconfig-r1304-20260921    gcc-14.3.0 sparse
parisc64                             defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    gcc-16.1.0
powerpc               randconfig-1000-20260921    clang-17
powerpc               randconfig-1001-20260921    clang-24
powerpc                      tqm8540_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260921    gcc-10.5.0
powerpc64             randconfig-1001-20260921    gcc-8.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                 randconfig-1000-20260921    gcc-12.5.0
riscv                 randconfig-1001-20260921    gcc-8.5.0
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    clang-18
s390                  randconfig-1000-20260921    clang-24
s390                  randconfig-1001-20260921    clang-24
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    gcc-16.1.0
sh                          apsh4a3a_defconfig    gcc-16.1.0
sh                                   defconfig    gcc-16.1.0
sh                    randconfig-1000-20260921    gcc-9.5.0
sh                    randconfig-1001-20260921    gcc-16.1.0
sh                   randconfig-r1302-20260921    gcc-15.2.0 sparse
sh                   randconfig-r1305-20260921    gcc-13.4.0 sparse
sh                   randconfig-r1308-20260921    gcc-16.1.0 sparse
sh                            se7705_defconfig    gcc-16.1.0
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260921    gcc-8.5.0
sparc                 randconfig-1001-20260921    gcc-11.5.0
sparc                randconfig-r1301-20260921    gcc-8.5.0  sparse
sparc64                              defconfig    clang-24
sparc64               randconfig-1000-20260921    clang-21
sparc64               randconfig-1001-20260921    clang-22
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260921    gcc-14
um                    randconfig-1001-20260921    gcc-14
um                            x86_64_defconfig    clang-24
x86_64                             allnoconfig    clang-22
x86_64      buildonly-randconfig-1000-20260921    clang-22
x86_64      buildonly-randconfig-1001-20260921    gcc-13
x86_64      buildonly-randconfig-1002-20260921    clang-22
x86_64      buildonly-randconfig-1003-20260921    clang-22
x86_64      buildonly-randconfig-1004-20260921    clang-22
x86_64      buildonly-randconfig-1005-20260921    clang-22
x86_64                               defconfig    gcc-14
x86_64                randconfig-1000-20260921    gcc-13
x86_64                randconfig-1001-20260921    clang-22
x86_64                randconfig-1002-20260921    gcc-14
x86_64                randconfig-1003-20260921    gcc-14
x86_64                randconfig-1004-20260921    clang-22
x86_64                randconfig-1005-20260921    clang-22
x86_64                randconfig-1006-20260921    gcc-14
x86_64                randconfig-1007-20260921    clang-22
x86_64                randconfig-1008-20260921    clang-22
x86_64                randconfig-1009-20260921    clang-22
x86_64                randconfig-1010-20260921    gcc-14
x86_64                randconfig-1011-20260921    clang-22
x86_64                randconfig-1300-20260921    gcc-14     sparse
x86_64                randconfig-1301-20260921    clang-22   sparse
x86_64                randconfig-1302-20260921    clang-22   sparse
x86_64                           rhel-9.4-rust    clang-22
xtensa                            alldefconfig    gcc-16.1.0
xtensa                             allnoconfig    gcc-16.1.0
xtensa                randconfig-1000-20260921    gcc-11.5.0
xtensa                randconfig-1001-20260921    gcc-9.5.0
xtensa               randconfig-r1303-20260921    gcc-10.5.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
