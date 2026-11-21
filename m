Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795228872;
	b=FcAJYuvcddQu1/Gi1/zEp6P7Zb+CocNlH4uIenBAP8ccdokgL5m96I8T3VuzbLSwMHKz
	 9q0yRjmKTI/5MPu15vEDAjRbFLhqWzMEgXR/MO3zOJzGOxyLQBQ7jdwmyugXCJCjUSuQV
	 DYgqw8gDDWCzgHI8O/X9bbmcoLXCUwpolQkks3bi0gcWdWfLXukd2PPRyRvykpjeLIurB
	 CK5ok6MiboaMySIzGfv2IMuQdGOYmUgREvzZTJ8FHYx8Myh/cjj9cvyUcjKqFWIKKVu2v
	 S3kT310PXygR6zeTGEYhDVPiZs9LxlyR82G3oEWxHfeoR6DFfR2LBbGpQcmdedPAh1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795228872;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=HX6aSwezyBgd3S7xa3qr/Ssao4Ds9PnCaCeZP+39/KI=;
	b=21h9i4Sr2LpIU7RkVBXp8pIqNNw7R/yD2bQ1C7ikiXEE000AFRPLubclGez9DMChvHx3
	 ziAYgYWoXVgl6NULGFW99pxZHIpMP6hV2yLuLGMk3iZkHAdAnaHGjgv72+4IFFrSikirE
	 cP9huYP27fRav0NsAWjUUXO0InAO5eAEZwTpdpUhU8vFr4be28eG9KUKI89IURusO+LoO
	 07BBN2hm7l9ENDA6N07Y8HiiPIw85GUwVpHaWqygLDBjPE4P54OiWCQA/b5HTYSrlTi2n
	 bDmBpaJgN7MuHvDZrWa0MzqYHOYXoAS6yWtcBE7+jFpi4co3CHD1IxT+VYTKQU7KJ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VBDFYpN2;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDDA606A685
	for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 02:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EDDA606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VBDFYpN2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795228868; x=1826764868;
  h=date:from:to:cc:subject:message-id;
  bh=7q9nhsganx2FHHwAkrj0CIeSOPDcEICG+LK5DOlvw9Y=;
  b=VBDFYpN2t0Khz+ozpJ0FoOxNG6/NFnUI3RCoGmgKQ3gMDoiLmQtdZmdU
   zREsFPtC8+ADgTCh2rEI1sjh1b11/ql+Iw8zDKiI4kcaLndrBlOGMuktI
   FNvcropR+MEtKI5DJZEr3ItNhfE0Zftjht9YDm8ufLl9MPFCud8UoQws5
   2n1nLW5phwLt3Hw0GRIx2UoL8KhNngF3Z2dJQsyPMtv7dw2F44qU45lpw
   srRXZasjSCFuMDkV+8qTCc+gBu41wLCYvA31XFgKaKZn1kDEp+Wn3gbS+
   Es8S/VR1FW1HjylsMGiRH6RisyfMrBFurzm8FZTUlt7uvAQYQJH/3DiIu
   w==;
X-CSE-ConnectionGUID: G9JYdwhmT4uhMXTuVkTQHA==
X-CSE-MsgGUID: /Ha5cpzwST+KbZCUOOowOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3997596"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="3997596"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 18:41:08 -0800
X-CSE-ConnectionGUID: OwEAjHuGQ3G9yofCH8clBw==
X-CSE-MsgGUID: n8njlnK/TMyC/BRTSqGrRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="11178453"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 Nov 2026 18:41:06 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xUb2F-00000001JLK-3SLA;
	Sat, 21 Nov 2026 02:41:03 +0000
Date: Sat, 21 Nov 2026 10:40:04 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 f1e4b30c9012d3956102d0a02e40c001a9a53bca
Message-ID: <20261121104004.WFo0nYCG-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: f1e4b30c9012d3956102d0a02e40c001a9a53bca  PCI/AER: Hide the 'aer' sysfs directory on devices without AER

elapsed time: 1294m

configs tested: 477
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                 randconfig-2000-20261119    gcc-8.5.0
alpha                 randconfig-2001-20261119    gcc-8.5.0
alpha                 randconfig-2200-20261119    gcc-12.5.0 smatch
alpha                randconfig-r2100-20261119    gcc-13.5.0 cocci
alpha                randconfig-r2102-20261119    gcc-16.2.0 cocci
alpha                randconfig-r2103-20261119    gcc-16.2.0 cocci
alpha                randconfig-r2106-20261119    gcc-11.5.0 cocci
alpha                randconfig-r2111-20261119    gcc-11.5.0 cocci
alpha                randconfig-r2301-20261119    gcc-16.2.0 sparse
alpha                randconfig-r2304-20261119    gcc-16.2.0 sparse
alpha                randconfig-r2307-20261119    gcc-10.5.0 sparse
alpha                randconfig-r2311-20261119    gcc-14.4.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                   randconfig-1000-20261120    clang-17
arc                   randconfig-1000-20261121    clang-24
arc                   randconfig-1001-20261120    clang-17
arc                   randconfig-1001-20261121    clang-24
arc                   randconfig-2000-20261119    gcc-14.4.0
arc                   randconfig-2001-20261119    gcc-14.4.0
arc                   randconfig-2002-20261119    gcc-14.4.0
arc                   randconfig-2003-20261119    gcc-14.4.0
arc                   randconfig-2004-20261119    gcc-14.4.0
arc                   randconfig-2005-20261119    gcc-14.4.0
arc                   randconfig-2200-20261119    gcc-16.2.0 smatch
arc                  randconfig-r2306-20261119    gcc-8.5.0  sparse
arc                  randconfig-r2308-20261119    gcc-10.5.0 sparse
arc                  randconfig-r2308-20261119    gcc-8.5.0  sparse
arc                  randconfig-r2311-20261119    gcc-8.5.0  sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                         multi_v7_defconfig    clang-17
arm                   randconfig-1000-20261120    clang-17
arm                   randconfig-1000-20261121    clang-24
arm                   randconfig-1001-20261120    clang-17
arm                   randconfig-1001-20261121    clang-24
arm                   randconfig-1002-20261120    clang-17
arm                   randconfig-1002-20261121    clang-24
arm                   randconfig-1003-20261120    clang-17
arm                   randconfig-1003-20261121    clang-24
arm                   randconfig-2000-20261119    gcc-16.2.0
arm                   randconfig-2001-20261119    gcc-16.2.0
arm                   randconfig-2002-20261119    gcc-16.2.0
arm                   randconfig-2200-20261119    clang-24   smatch
arm                  randconfig-r2105-20261119    gcc-16.2.0 cocci
arm                  randconfig-r2109-20261119    gcc-12.5.0 cocci
arm                  randconfig-r2302-20261119    gcc-15.3.0 sparse
arm                  randconfig-r2305-20261119    gcc-13.5.0 sparse
arm                  randconfig-r2306-20261119    gcc-10.5.0 sparse
arm                  randconfig-r2307-20261119    gcc-10.5.0 sparse
arm                  randconfig-r2308-20261119    gcc-14.4.0 sparse
arm                  randconfig-r2309-20261119    clang-24   sparse
arm                  randconfig-r2310-20261119    clang-24   sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                 randconfig-1000-20261120    clang-18
arm64                 randconfig-1001-20261120    clang-18
arm64                 randconfig-1002-20261120    clang-18
arm64                 randconfig-1003-20261120    clang-18
arm64                 randconfig-2000-20261119    gcc-16.2.0
arm64                 randconfig-2001-20261119    gcc-16.2.0
arm64                 randconfig-2002-20261119    gcc-16.2.0
arm64                 randconfig-2200-20261119    clang-17   smatch
arm64                randconfig-r2103-20261119    clang-17   cocci
arm64                randconfig-r2104-20261119    gcc-16.2.0 cocci
arm64                randconfig-r2106-20261119    gcc-12.5.0 cocci
arm64                randconfig-r2106-20261119    gcc-14     cocci
arm64                randconfig-r2108-20261119    gcc-10.5.0 cocci
arm64                randconfig-r2109-20261119    gcc-14     cocci
arm64                randconfig-r2300-20261119    gcc-16.2.0 sparse
arm64                randconfig-r2301-20261119    gcc-13.5.0 sparse
arm64                randconfig-r2302-20261119    gcc-16.2.0 sparse
arm64                randconfig-r2303-20261119    gcc-8.5.0  sparse
arm64                randconfig-r2304-20261119    gcc-15.3.0 sparse
arm64                randconfig-r2305-20261119    gcc-16.2.0 sparse
arm64                randconfig-r2309-20261119    clang-24   sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                  randconfig-1000-20261120    clang-18
csky                  randconfig-1001-20261120    clang-18
csky                  randconfig-2000-20261119    gcc-16.2.0
csky                  randconfig-2001-20261119    gcc-16.2.0
csky                  randconfig-2200-20261119    gcc-16.2.0 smatch
csky                 randconfig-r2110-20261119    gcc-13.5.0 cocci
csky                 randconfig-r2111-20261119    gcc-13.5.0 cocci
csky                 randconfig-r2300-20261119    gcc-16.2.0 sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon               randconfig-1000-20261121    gcc-11.5.0
hexagon               randconfig-1001-20261121    gcc-11.5.0
hexagon               randconfig-2000-20261119    gcc-16.2.0
hexagon               randconfig-2001-20261119    gcc-16.2.0
hexagon               randconfig-2200-20261119    clang-17   smatch
hexagon              randconfig-r2100-20261119    gcc-11.5.0 cocci
hexagon              randconfig-r2101-20261119    clang-19   cocci
hexagon              randconfig-r2101-20261119    gcc-11.5.0 cocci
hexagon              randconfig-r2102-20261119    gcc-9.5.0  cocci
hexagon              randconfig-r2104-20261119    clang-24   cocci
hexagon              randconfig-r2105-20261119    clang-19   cocci
hexagon              randconfig-r2109-20261119    gcc-10.5.0 cocci
hexagon              randconfig-r2300-20261119    gcc-15.3.0 sparse
hexagon              randconfig-r2305-20261119    gcc-15.3.0 sparse
hexagon              randconfig-r2310-20261119    gcc-10.5.0 sparse
hexagon              randconfig-r2310-20261119    gcc-11.5.0 sparse
hexagon              randconfig-r2310-20261119    gcc-8.5.0  sparse
hexagon              randconfig-r2311-20261119    clang-24   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261120    clang-22
i386        buildonly-randconfig-1000-20261121    gcc-13
i386        buildonly-randconfig-1001-20261120    clang-22
i386        buildonly-randconfig-1001-20261121    gcc-13
i386        buildonly-randconfig-1002-20261120    clang-22
i386        buildonly-randconfig-1002-20261121    gcc-13
i386        buildonly-randconfig-1003-20261120    clang-22
i386        buildonly-randconfig-1003-20261121    gcc-13
i386        buildonly-randconfig-1004-20261120    clang-22
i386        buildonly-randconfig-1004-20261121    gcc-13
i386        buildonly-randconfig-1005-20261120    clang-22
i386        buildonly-randconfig-1005-20261121    gcc-13
i386                  randconfig-1000-20261120    clang-22
i386                  randconfig-1001-20261120    clang-22
i386                  randconfig-1002-20261120    clang-22
i386                  randconfig-1003-20261120    clang-22
i386                  randconfig-1004-20261120    clang-22
i386                  randconfig-1005-20261120    clang-22
i386                  randconfig-1006-20261120    clang-22
i386                  randconfig-1007-20261121    gcc-14
i386                  randconfig-1008-20261121    gcc-14
i386                  randconfig-1009-20261121    gcc-14
i386                  randconfig-1010-20261121    gcc-14
i386                  randconfig-1011-20261121    gcc-14
i386                  randconfig-1012-20261121    gcc-14
i386                  randconfig-1013-20261121    gcc-14
i386                  randconfig-2000-20261119    gcc-14
i386                  randconfig-2001-20261119    gcc-14
i386                  randconfig-2002-20261119    gcc-14
i386                  randconfig-2003-20261119    gcc-14
i386                  randconfig-2004-20261119    gcc-14
i386                  randconfig-2005-20261119    gcc-14
i386                  randconfig-2100-20261119    clang-22   cocci
i386                  randconfig-2101-20261119    clang-22   cocci
i386                  randconfig-2102-20261119    clang-22   cocci
i386                  randconfig-2103-20261119    clang-22   cocci
i386                  randconfig-2104-20261119    clang-22   cocci
i386                  randconfig-2105-20261119    clang-22   cocci
i386                  randconfig-2200-20261119    gcc-14     smatch
i386                  randconfig-2300-20261119    gcc-14     sparse
i386                  randconfig-2301-20261119    gcc-14     sparse
i386                  randconfig-2302-20261119    gcc-14     sparse
i386                 randconfig-r2100-20261119    gcc-16.2.0 cocci
i386                 randconfig-r2105-20261119    clang-17   cocci
i386                 randconfig-r2107-20261119    gcc-10.5.0 cocci
i386                 randconfig-r2107-20261119    gcc-14     cocci
i386                 randconfig-r2108-20261119    gcc-14     cocci
i386                 randconfig-r2300-20261119    gcc-15.3.0 sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch             randconfig-1000-20261121    gcc-11.5.0
loongarch             randconfig-1001-20261121    gcc-11.5.0
loongarch             randconfig-2000-20261119    gcc-8.5.0
loongarch             randconfig-2001-20261119    gcc-8.5.0
loongarch             randconfig-2200-20261119    clang-24   smatch
loongarch            randconfig-r2102-20261119    clang-17   cocci
loongarch            randconfig-r2111-20261119    gcc-12.5.0 cocci
loongarch            randconfig-r2300-20261119    gcc-16.2.0 sparse
loongarch            randconfig-r2303-20261119    gcc-13.5.0 sparse
loongarch            randconfig-r2304-20261119    gcc-16.2.0 sparse
loongarch            randconfig-r2306-20261119    clang-24   sparse
loongarch            randconfig-r2309-20261119    gcc-8.5.0  sparse
loongarch            randconfig-r2311-20261119    gcc-10.5.0 sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                           hp300_defconfig    gcc-16.2.0
m68k                        m5275evb_defconfig    clang-17
m68k                  randconfig-2000-20261119    gcc-8.5.0
m68k                  randconfig-2001-20261119    gcc-8.5.0
m68k                  randconfig-2200-20261119    gcc-9.5.0  smatch
m68k                 randconfig-r2100-20261119    gcc-9.5.0  cocci
m68k                 randconfig-r2103-20261119    clang-19   cocci
m68k                 randconfig-r2105-20261119    gcc-11.5.0 cocci
m68k                 randconfig-r2106-20261119    gcc-10.5.0 cocci
m68k                 randconfig-r2108-20261119    gcc-13.5.0 cocci
m68k                 randconfig-r2301-20261119    gcc-15.3.0 sparse
m68k                 randconfig-r2305-20261119    clang-24   sparse
m68k                 randconfig-r2311-20261119    gcc-11.5.0 sparse
m68k                         stmark2_defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze            randconfig-2000-20261119    gcc-8.5.0
microblaze            randconfig-2001-20261119    gcc-8.5.0
microblaze            randconfig-2200-20261119    gcc-12.5.0 smatch
microblaze           randconfig-r2107-20261119    gcc-12.5.0 cocci
microblaze           randconfig-r2110-20261119    gcc-11.5.0 cocci
microblaze           randconfig-r2111-20261119    gcc-12.5.0 cocci
microblaze           randconfig-r2302-20261119    gcc-8.5.0  sparse
microblaze           randconfig-r2304-20261119    gcc-15.3.0 sparse
microblaze           randconfig-r2305-20261119    gcc-16.2.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                      cu1000-neo_defconfig    gcc-16.2.0
mips                 econet_en751221_defconfig    clang-17
mips                           eyeq5_defconfig    gcc-16.2.0
mips                            ip32_defconfig    clang-17
mips                       maltasmvp_defconfig    gcc-16.2.0
mips                  randconfig-2000-20261119    gcc-16.2.0
mips                  randconfig-2001-20261119    gcc-16.2.0
mips                  randconfig-2002-20261119    gcc-16.2.0
mips                  randconfig-2200-20261119    clang-24   smatch
mips                 randconfig-r2101-20261119    gcc-13.5.0 cocci
mips                 randconfig-r2102-20261119    clang-19   cocci
mips                 randconfig-r2103-20261119    gcc-11.5.0 cocci
mips                 randconfig-r2103-20261119    gcc-13.5.0 cocci
mips                 randconfig-r2106-20261119    gcc-12.5.0 cocci
mips                 randconfig-r2109-20261119    gcc-13.5.0 cocci
mips                 randconfig-r2110-20261119    gcc-10.5.0 cocci
mips                 randconfig-r2110-20261119    gcc-14     cocci
mips                 randconfig-r2300-20261119    clang-24   sparse
mips                 randconfig-r2303-20261119    gcc-16.2.0 sparse
mips                 randconfig-r2307-20261119    gcc-8.5.0  sparse
mips                 randconfig-r2310-20261119    gcc-14.4.0 sparse
mips                          rt305x_defconfig    clang-17
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                 randconfig-1000-20261121    gcc-11.5.0
nios2                 randconfig-1001-20261121    gcc-11.5.0
nios2                 randconfig-2000-20261119    gcc-8.5.0
nios2                 randconfig-2001-20261119    gcc-8.5.0
nios2                 randconfig-2200-20261119    gcc-11.5.0 smatch
nios2                randconfig-r2101-20261119    gcc-9.5.0  cocci
nios2                randconfig-r2102-20261119    gcc-11.5.0 cocci
nios2                randconfig-r2105-20261119    gcc-9.5.0  cocci
nios2                randconfig-r2106-20261119    gcc-14     cocci
nios2                randconfig-r2107-20261119    gcc-12.5.0 cocci
nios2                randconfig-r2109-20261119    gcc-12.5.0 cocci
nios2                randconfig-r2110-20261119    gcc-14     cocci
nios2                randconfig-r2303-20261119    gcc-15.3.0 sparse
nios2                randconfig-r2309-20261119    gcc-10.5.0 sparse
nios2                randconfig-r2311-20261119    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc          de0_nano_multicore_defconfig    clang-17
openrisc          de0_nano_multicore_defconfig    gcc-16.2.0
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261119    gcc-16.2.0
openrisc              randconfig-2001-20261119    gcc-16.2.0
openrisc              randconfig-2002-20261119    gcc-16.2.0
openrisc              randconfig-2200-20261119    gcc-16.2.0 smatch
openrisc             randconfig-r2101-20261119    clang-17   cocci
openrisc             randconfig-r2108-20261119    gcc-11.5.0 cocci
openrisc             randconfig-r2300-20261119    gcc-8.5.0  sparse
openrisc             randconfig-r2302-20261119    gcc-15.3.0 sparse
openrisc             randconfig-r2307-20261119    gcc-11.5.0 sparse
openrisc             randconfig-r2308-20261119    gcc-11.5.0 sparse
openrisc             randconfig-r2308-20261119    gcc-8.5.0  sparse
openrisc             randconfig-r2309-20261119    gcc-8.5.0  sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                 generic-64bit_defconfig    clang-17
parisc                randconfig-1000-20261121    gcc-10.5.0
parisc                randconfig-1001-20261121    gcc-10.5.0
parisc                randconfig-2000-20261119    gcc-8.5.0
parisc                randconfig-2001-20261119    gcc-8.5.0
parisc                randconfig-2200-20261119    gcc-14.4.0 smatch
parisc               randconfig-r2104-20261119    clang-17   cocci
parisc               randconfig-r2110-20261119    gcc-12.5.0 cocci
parisc               randconfig-r2303-20261119    gcc-15.3.0 sparse
parisc               randconfig-r2309-20261119    gcc-10.5.0 sparse
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc               randconfig-1000-20261121    gcc-10.5.0
powerpc               randconfig-1001-20261121    gcc-10.5.0
powerpc               randconfig-2000-20261119    gcc-15.3.0
powerpc               randconfig-2001-20261119    gcc-15.3.0
powerpc               randconfig-2002-20261119    gcc-15.3.0
powerpc               randconfig-2200-20261119    gcc-13.5.0 smatch
powerpc              randconfig-r2100-20261119    clang-19   cocci
powerpc              randconfig-r2104-20261119    gcc-13.5.0 cocci
powerpc              randconfig-r2107-20261119    gcc-11.5.0 cocci
powerpc              randconfig-r2109-20261119    gcc-14     cocci
powerpc              randconfig-r2307-20261119    gcc-14.4.0 sparse
powerpc64             randconfig-1000-20261121    gcc-10.5.0
powerpc64             randconfig-1001-20261121    gcc-10.5.0
powerpc64             randconfig-2000-20261119    gcc-15.3.0
powerpc64             randconfig-2001-20261119    gcc-15.3.0
powerpc64             randconfig-2002-20261119    gcc-15.3.0
powerpc64             randconfig-2200-20261119    clang-24   smatch
powerpc64            randconfig-r2101-20261119    gcc-16.2.0 cocci
powerpc64            randconfig-r2104-20261119    gcc-9.5.0  cocci
powerpc64            randconfig-r2111-20261119    gcc-10.5.0 cocci
powerpc64            randconfig-r2305-20261119    gcc-8.5.0  sparse
powerpc64            randconfig-r2306-20261119    gcc-14.4.0 sparse
powerpc64            randconfig-r2307-20261119    clang-24   sparse
powerpc64            randconfig-r2308-20261119    gcc-10.5.0 sparse
powerpc64            randconfig-r2310-20261119    gcc-8.5.0  sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261120    gcc-11.5.0
riscv                 randconfig-1001-20261120    gcc-11.5.0
riscv                 randconfig-2000-20261119    clang-24
riscv                 randconfig-2001-20261119    clang-24
riscv                 randconfig-2002-20261119    clang-24
riscv                 randconfig-2003-20261119    clang-24
riscv                 randconfig-2004-20261119    clang-24
riscv                 randconfig-2005-20261119    clang-24
riscv                 randconfig-2200-20261119    clang-24   smatch
riscv                randconfig-r2100-20261119    clang-17   cocci
riscv                randconfig-r2101-20261119    clang-24   cocci
riscv                randconfig-r2103-20261119    clang-24   cocci
riscv                randconfig-r2107-20261119    gcc-13.5.0 cocci
riscv                randconfig-r2111-20261119    gcc-14     cocci
riscv                randconfig-r2302-20261119    clang-24   sparse
riscv                randconfig-r2302-20261119    gcc-16.2.0 sparse
riscv                randconfig-r2306-20261119    gcc-10.5.0 sparse
riscv                randconfig-r2306-20261119    gcc-11.5.0 sparse
riscv                randconfig-r2307-20261119    gcc-8.5.0  sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261120    gcc-11.5.0
s390                  randconfig-1001-20261120    gcc-11.5.0
s390                  randconfig-2000-20261119    clang-20
s390                  randconfig-2001-20261119    clang-20
s390                  randconfig-2002-20261119    clang-20
s390                  randconfig-2003-20261119    clang-20
s390                  randconfig-2004-20261119    clang-20
s390                  randconfig-2005-20261119    clang-20
s390                  randconfig-2200-20261119    clang-24   smatch
s390                 randconfig-r2103-20261119    gcc-9.5.0  cocci
s390                 randconfig-r2104-20261119    gcc-11.5.0 cocci
s390                 randconfig-r2110-20261119    gcc-12.5.0 cocci
s390                 randconfig-r2301-20261119    gcc-16.2.0 sparse
s390                 randconfig-r2303-20261119    gcc-16.2.0 sparse
s390                 randconfig-r2306-20261119    clang-24   sparse
s390                 randconfig-r2307-20261119    clang-24   sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                           r7785rp_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261120    gcc-11.5.0
sh                    randconfig-1001-20261120    gcc-11.5.0
sh                    randconfig-2000-20261119    gcc-12.5.0
sh                    randconfig-2001-20261119    gcc-12.5.0
sh                    randconfig-2002-20261119    gcc-12.5.0
sh                    randconfig-2003-20261119    gcc-12.5.0
sh                    randconfig-2004-20261119    gcc-12.5.0
sh                    randconfig-2005-20261119    gcc-12.5.0
sh                    randconfig-2200-20261119    gcc-16.2.0 smatch
sh                   randconfig-r2108-20261119    gcc-12.5.0 cocci
sh                   randconfig-r2302-20261119    gcc-13.5.0 sparse
sh                   randconfig-r2304-20261119    clang-24   sparse
sh                   randconfig-r2305-20261119    gcc-15.3.0 sparse
sh                   randconfig-r2309-20261119    gcc-11.5.0 sparse
sh                            se7780_defconfig    clang-17
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261120    clang-24
sparc                 randconfig-1001-20261120    clang-24
sparc                 randconfig-2000-20261119    clang-21
sparc                 randconfig-2001-20261119    clang-21
sparc                 randconfig-2200-20261119    gcc-8.5.0  smatch
sparc                randconfig-r2100-20261119    clang-24   cocci
sparc                randconfig-r2105-20261119    clang-24   cocci
sparc                randconfig-r2105-20261119    gcc-13.5.0 cocci
sparc                randconfig-r2304-20261119    gcc-8.5.0  sparse
sparc                randconfig-r2309-20261119    gcc-14.4.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261120    clang-24
sparc64               randconfig-1001-20261120    clang-24
sparc64               randconfig-2000-20261119    clang-21
sparc64               randconfig-2001-20261119    clang-21
sparc64               randconfig-2200-20261119    gcc-13.5.0 smatch
sparc64              randconfig-r2300-20261119    gcc-13.5.0 sparse
sparc64              randconfig-r2302-20261119    gcc-16.2.0 sparse
sparc64              randconfig-r2305-20261119    gcc-16.2.0 sparse
sparc64              randconfig-r2308-20261119    clang-24   sparse
sparc64              randconfig-r2310-20261119    clang-24   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261120    clang-24
um                    randconfig-1001-20261120    clang-24
um                    randconfig-2000-20261119    clang-21
um                    randconfig-2001-20261119    clang-21
um                   randconfig-r2107-20261119    gcc-14     cocci
um                   randconfig-r2108-20261119    gcc-14     cocci
um                   randconfig-r2301-20261119    gcc-15.3.0 sparse
um                   randconfig-r2301-20261119    gcc-8.5.0  sparse
um                   randconfig-r2303-20261119    gcc-16.2.0 sparse
um                   randconfig-r2306-20261119    gcc-8.5.0  sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261120    clang-22
x86_64      buildonly-randconfig-1001-20261120    clang-22
x86_64      buildonly-randconfig-1002-20261120    clang-22
x86_64      buildonly-randconfig-1003-20261120    clang-22
x86_64      buildonly-randconfig-1004-20261120    clang-22
x86_64      buildonly-randconfig-1005-20261120    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261120    clang-22
x86_64                randconfig-1001-20261120    clang-22
x86_64                randconfig-1002-20261120    clang-22
x86_64                randconfig-1003-20261120    clang-22
x86_64                randconfig-1004-20261120    clang-22
x86_64                randconfig-1005-20261120    clang-22
x86_64                randconfig-1006-20261120    clang-22
x86_64                randconfig-1007-20261120    clang-22
x86_64                randconfig-1008-20261120    clang-22
x86_64                randconfig-1009-20261120    clang-22
x86_64                randconfig-1010-20261120    clang-22
x86_64                randconfig-1011-20261120    clang-22
x86_64                randconfig-2000-20261119    clang-22
x86_64                randconfig-2001-20261119    clang-22
x86_64                randconfig-2002-20261119    clang-22
x86_64                randconfig-2003-20261119    clang-22
x86_64                randconfig-2004-20261119    clang-22
x86_64                randconfig-2005-20261119    clang-22
x86_64                randconfig-2100-20261119    clang-22   cocci
x86_64                randconfig-2101-20261119    clang-22   cocci
x86_64                randconfig-2102-20261119    clang-22   cocci
x86_64                randconfig-2103-20261119    clang-22   cocci
x86_64                randconfig-2104-20261119    clang-22   cocci
x86_64                randconfig-2105-20261119    clang-22   cocci
x86_64                randconfig-2200-20261119    clang-22   smatch
x86_64                randconfig-2300-20261119    gcc-14     sparse
x86_64                randconfig-2301-20261119    gcc-14     sparse
x86_64                randconfig-2302-20261119    gcc-14     sparse
x86_64               randconfig-r2102-20261119    clang-24   cocci
x86_64               randconfig-r2111-20261119    gcc-14     cocci
x86_64               randconfig-r2301-20261119    gcc-16.2.0 sparse
x86_64               randconfig-r2303-20261119    clang-24   sparse
x86_64               randconfig-r2304-20261119    gcc-13.5.0 sparse
x86_64               randconfig-r2308-20261119    clang-24   sparse
x86_64               randconfig-r2311-20261119    gcc-10.5.0 sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261120    clang-24
xtensa                randconfig-1001-20261120    clang-24
xtensa                randconfig-2000-20261119    gcc-16.2.0
xtensa                randconfig-2001-20261119    gcc-16.2.0
xtensa                randconfig-2200-20261119    gcc-14.4.0 smatch
xtensa               randconfig-r2102-20261119    gcc-13.5.0 cocci
xtensa               randconfig-r2104-20261119    clang-19   cocci
xtensa               randconfig-r2106-20261119    gcc-13.5.0 cocci
xtensa               randconfig-r2109-20261119    gcc-11.5.0 cocci
xtensa               randconfig-r2310-20261119    gcc-10.5.0 sparse
xtensa               randconfig-r2311-20261119    clang-24   sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
