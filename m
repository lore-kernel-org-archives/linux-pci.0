Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5020D3A1A43
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674891; cv=none; b=k2kWg3PrS0ogYKDCYIlhAuy9HR++j76/0Y5vdDYSrshmZ0fCyjP82swuXStE1mlhwy9sx8EVmCLGeSlqoeKyQZJKBD5uFX+1jvoYVeMxS0/09DC4lFAKrPEshz/QhRRhzV9TYzQtLY/eHmzKUNl4WW9nwAHQuFbOA/VeRa787q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674891; c=relaxed/simple;
	bh=F5oQXzAlSmzjBDrHgcsXALdm2k78IHKNRCmdk/xArjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bhHq6MKqRm/OVbDnbptOPVwxFHU/MQPktERci8B/9ZrJLvS5smmqCm/Tipmqbi5iomVLc12E4W9IW7Mf6lM6Za5tKvWmF2iodpCms8O7VzYg47YIspJy+dKO+u9RO3dJLhvRW50I1ckO1y1Ct85RmdVoBc2favgytSKRX0dMd1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRwtT2ag; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRwtT2ag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773674890; x=1805210890;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F5oQXzAlSmzjBDrHgcsXALdm2k78IHKNRCmdk/xArjo=;
  b=LRwtT2ag0C6xB9SHFvp4obxRySbAZS/vjrUboBNsXffY8qmyorAB1KPC
   0sJWm+LjqNm3kVHS4zaOIzAA8HW6pmTpX2C3UhlckXvkW3zPdNHZ9zcML
   1DBiL0e0AWWpislMlu11K4En6SGFPcffAxj1vNJml8OIeP0Xdr+Zkj3n8
   1DP1BLwGe1ywlhoY5jzu0xXIPcfZhnwPr0KBW5yJ13sY9+Y26BAIeIigq
   J6Mmt69HldLvtcNo/V3Qi7dXu4Z1nXuVCMIK0E5Wv4RTiCVIRt9N/sJTC
   GrbEuiT9hQvzRIrn7uVXHF+vPTj8dsGwLpGBotvORqlZg6OjpmApzNuip
   g==;
X-CSE-ConnectionGUID: g4yRiQCTSTuNOsk4tjIw4g==
X-CSE-MsgGUID: rOsh3wpYScK07EMPAfZtig==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74811023"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74811023"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:28:09 -0700
X-CSE-ConnectionGUID: b0AzziJlSqOFRjHd/jwiEw==
X-CSE-MsgGUID: AVvzWch1TuyyYPyAMZ9gkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="218193235"
Received: from lkp-server01.sh.intel.com (HELO 892944969b78) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 Mar 2026 08:28:08 -0700
Received: from kbuild by 892944969b78 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w29rS-000000000qE-1h7V;
	Mon, 16 Mar 2026 15:28:06 +0000
Date: Mon, 16 Mar 2026 23:27:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:kwilczynski/procfs-attach-device-rescan-lock] BUILD
 SUCCESS fed277e67f534e20188f1fd551d6aabaf07ae600
Message-ID: <202603162306.2oKy0qcP-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git kwilczynski/procfs-attach-device-rescan-lock
branch HEAD: fed277e67f534e20188f1fd551d6aabaf07ae600  PCI/proc: Fix race between pci_proc_init() and pci_bus_add_device()

elapsed time: 1210m

configs tested: 82
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arc         randconfig-001-20260316    gcc-10.5.0
arc         randconfig-002-20260316    gcc-9.5.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-15.2.0
arm         randconfig-001-20260316    clang-23
arm         randconfig-002-20260316    clang-23
arm         randconfig-003-20260316    clang-23
arm         randconfig-004-20260316    clang-23
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
i386        randconfig-001-20260316    gcc-14
i386        randconfig-002-20260316    clang-20
i386        randconfig-003-20260316    gcc-14
i386        randconfig-004-20260316    gcc-14
i386        randconfig-005-20260316    clang-20
i386        randconfig-006-20260316    gcc-12
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
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
parisc      randconfig-001-20260316    gcc-8.5.0
parisc      randconfig-002-20260316    gcc-12.5.0
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
powerpc     randconfig-001-20260316    clang-23
powerpc     randconfig-002-20260316    clang-23
powerpc64   randconfig-002-20260316    gcc-8.5.0
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sparc                   allnoconfig    gcc-15.2.0
sparc       randconfig-001-20260316    gcc-8.5.0
sparc       randconfig-002-20260316    gcc-12.5.0
sparc64                allmodconfig    clang-23
sparc64     randconfig-001-20260316    gcc-8.5.0
sparc64     randconfig-002-20260316    gcc-15.2.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64      randconfig-071-20260316    gcc-12
x86_64      randconfig-072-20260316    gcc-14
x86_64      randconfig-073-20260316    gcc-14
x86_64      randconfig-074-20260316    gcc-14
x86_64      randconfig-075-20260316    clang-20
x86_64      randconfig-076-20260316    clang-20
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0
xtensa                 allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
