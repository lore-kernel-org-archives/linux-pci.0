Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D20F37BE6C
	for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338447; cv=none; b=UIpiBUETY8F03CnsF7cBhiLIPrboazjkdnIdt9WC8eQeWzjEBy/2lfx2wOPxEmqyCb80ytvbUKWAp2aBA7z/Jxi3N84NR3du2qM6NNY+YSkd9HCRiAV+k/JxyPNm43Dnm4wpEWvQo33PxIykfKKsVABA49bWL1reXs4s1D1FkKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338447; c=relaxed/simple;
	bh=/me0Z29pcj72YNQ8cq5C68xmZddnxwuSDhPJDY6RUM4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EyT1mfhfic5bg6pAhm4ZdoZddaZMUDbglG6eG6hyQI69CzXjxzHDnzT4fuYgPBM/XFk6T8JxFLOMfOUjGVTd6Zw91sP77CFxq1XCR1pykV4mupsuxZN+nX01PzYD2/DQl7aZBauINfLYBX01ZmWk2gyjTu6RT2N32ocu94OBUoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nj+VeAP/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nj+VeAP/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776338446; x=1807874446;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/me0Z29pcj72YNQ8cq5C68xmZddnxwuSDhPJDY6RUM4=;
  b=Nj+VeAP/Hsd+a494uqCP3gzRtfajOjVEFH42u7i38kZ53kCz/+drWIf/
   OFx+oHx71Ib6te5DdeaFmeiZKVSMbPWAI5ZiJqbB87Dvwmwzhyg+7mcu6
   cthrZuuj51Zpo9Z5scWAoxSqImNiJxNlGV680tu5bpwKb9kw6az7jXzaB
   +rDaelOEcanMvn9Sl00/TtOJiVIjzsxysbhe+/pGwfiYG3ZfmQkGo0+LK
   if6Ju42IJIVUibvedAck50+xpZRX6dpk332Bna10VcSrAcDRAspGBBBgP
   Hl5cT6TjIxAX8yyprxIp42i3OYlra4hzPRL2qQx6Pkt4yLo2urR/yi48L
   Q==;
X-CSE-ConnectionGUID: fVfk6+r5SbCRO1nAPzf3mQ==
X-CSE-MsgGUID: pgzDqhqjTQyhn3jtfKgLVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77034751"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77034751"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 04:20:45 -0700
X-CSE-ConnectionGUID: WtwqQQDXT0WTr4jE0khdkA==
X-CSE-MsgGUID: ibax+8FnQw6d/E4RLOy+og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="261128320"
Received: from lkp-server01.sh.intel.com (HELO 7f3b36e5d6a5) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Apr 2026 04:20:44 -0700
Received: from kbuild by 7f3b36e5d6a5 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDKm1-000000001WQ-2BBQ;
	Thu, 16 Apr 2026 11:20:41 +0000
Date: Thu, 16 Apr 2026 19:20:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:kwilczynski/static-sysfs-attributes-v5] BUILD SUCCESS
 973e040579d67fb5e94319776d89711e3ab41609
Message-ID: <202604161928.DzuHQmeM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git kwilczynski/static-sysfs-attributes-v5
branch HEAD: 973e040579d67fb5e94319776d89711e3ab41609  PCI/sysfs: Remove pci_create_legacy_files() and pci_sysfs_init()

elapsed time: 776m

configs tested: 126
configs skipped: 3

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
arc                   randconfig-001-20260416    gcc-14.3.0
arc                   randconfig-002-20260416    gcc-10.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260416    clang-23
arm                   randconfig-002-20260416    gcc-8.5.0
arm                   randconfig-003-20260416    gcc-8.5.0
arm                   randconfig-004-20260416    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260416    gcc-8.5.0
arm64                 randconfig-002-20260416    gcc-10.5.0
arm64                 randconfig-003-20260416    clang-23
arm64                 randconfig-004-20260416    clang-16
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260416    gcc-14.3.0
csky                  randconfig-002-20260416    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260416    clang-23
hexagon               randconfig-002-20260416    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260416    gcc-14
i386        buildonly-randconfig-002-20260416    gcc-12
i386        buildonly-randconfig-003-20260416    clang-20
i386        buildonly-randconfig-004-20260416    clang-20
i386        buildonly-randconfig-005-20260416    clang-20
i386        buildonly-randconfig-006-20260416    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-011-20260416    gcc-14
i386                  randconfig-012-20260416    gcc-14
i386                  randconfig-013-20260416    clang-20
i386                  randconfig-014-20260416    clang-20
i386                  randconfig-015-20260416    clang-20
i386                  randconfig-016-20260416    clang-20
i386                  randconfig-017-20260416    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-002-20260416    gcc-15.2.0
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
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260416    gcc-8.5.0
nios2                 randconfig-002-20260416    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                randconfig-001-20260416    gcc-10.5.0
parisc                randconfig-002-20260416    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260416    clang-23
powerpc               randconfig-002-20260416    gcc-8.5.0
powerpc64             randconfig-001-20260416    clang-16
powerpc64             randconfig-002-20260416    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260416    gcc-11.5.0
riscv                 randconfig-002-20260416    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260416    clang-23
s390                  randconfig-002-20260416    clang-20
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260416    gcc-9.5.0
sh                    randconfig-002-20260416    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260416    gcc-12
x86_64      buildonly-randconfig-002-20260416    gcc-14
x86_64      buildonly-randconfig-003-20260416    clang-20
x86_64      buildonly-randconfig-004-20260416    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260416    gcc-13
x86_64                randconfig-002-20260416    gcc-14
x86_64                randconfig-003-20260416    clang-20
x86_64                randconfig-004-20260416    clang-20
x86_64                randconfig-005-20260416    gcc-14
x86_64                randconfig-006-20260416    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
