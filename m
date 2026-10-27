Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793137290;
	b=10Bir1Xpbjc8vFhMmdhDNFgJfqKvzgHXoTcKGqWA6gSyCMH4X2oqHp9MMKrw3GZ7K1Z8
	 spnWrXY8GpryyNmQzG5pimIl4b3X4ot4L2qSG/Of/3A/y/LnxrPUpZdEU+XWIxCWGLx67
	 O+j8C3/HVRgw512dqEMDeFylXdhpPdSJxqcb2KLFruAJan31gmTfGMx+EreakjysbjZT4
	 6pgcI4iXLZe88UOIc7qUjWHfRHjIbjqKnfmAm9SNfFMorrMf6TUL/GMQSqyCqxzXZNl08
	 Ek5hW1R1TnIrXKEkt2BphUWwBdczr1vDVweVqQ6Q6numG9+SQL8IW3/O8uEBng4Nx3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793137290;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=JqtNFK3ELXkgzNZWBwmEIfqalrZXo7Hqgjs4QMXjvzM=;
	b=hzdIJ9HFiEDRO9mOlF6yUDCYmfqhAw0cOufxGQ3UkEJE221xsxr8AxrHff8RV82ytPGk
	 +HYPM/Zs1nMm6k6LIdfj1T1Cn7lMpK+B9mlstIjwzcOog7AYxsmf08fnuXTdp0wUyzwCe
	 5rdDY5OfYlBeaO9dgRa7HaCd/V+UZMznZJdTnK+OVvtYEglT35trog4OGykU9dQeIybiD
	 SlRKEp5kYLHhIfJ6sE7TFUEMnFWFHLl/sFaWK2hdG+CcdtM86TdopHYkA5fQDTmKNN5s7
	 yiIbOdPPkn8ff0I28dr1ZvVzbeOVNxnrSDAwqqdmHcQ/nFewbCo7Db1uvIEO33xYy+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HnvkTB2L;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D014606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 21:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D014606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HnvkTB2L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793137289; x=1824673289;
  h=date:from:to:cc:subject:message-id;
  bh=CLUwFtKpoTOQCVF1zwoCqNs/I+yl3z6eIZFykH7/oa0=;
  b=HnvkTB2LDxvBMl2ci3PxzB+ojCGdx1KO0IAyX7nj5GtOx3XJIcUTxp36
   OjOa212s2UEoTJkcYYUtZj7PUMYL2KgHGe/yO4btYJfM8OERKcj8AiKDd
   6ZtqcRrVQ3chLA2ynnlgUq8x8HhivHrtSREq0QzSvAtMO+6hmocEzGM2g
   OTMGB/OzMqkIxCYuCUX1H/cektNxvnPOyKLMmjAd0y2vKQsjMG29ATGSF
   oduOWyykZ0bh/nmiEtdYpJSA38iRdqSk3K+YAR4By5HKf+HQ9S/uCxpYm
   U1dr1ChH8I9OYVBXxjq6NQ5awJ6WiYjhYrJ1mU98KsaU8DHyG2u/IKJ9g
   g==;
X-CSE-ConnectionGUID: giqT5n4HQTaMg5MN4l3+cg==
X-CSE-MsgGUID: VHMvs0HSSt2ilAkaG2FjFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1731792"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1731792"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 14:41:29 -0700
X-CSE-ConnectionGUID: qcfVzo4vTL2Bo2TSgDcC+A==
X-CSE-MsgGUID: /B8Ye5GyQeWQofbn1xFleA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6523779"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 27 Oct 2026 14:41:28 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xLov7-00000000XnG-0GHi;
	Tue, 27 Oct 2026 21:41:25 +0000
Date: Wed, 28 Oct 2026 05:40:29 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:v7.4-merge] BUILD SUCCESS
 809090a99dac8e3dc01c397e7f885b322b406dc9
Message-ID: <202610280525.WkMUmVQm-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git v7.4-merge
branch HEAD: 809090a99dac8e3dc01c397e7f885b322b406dc9  Merge branch 'next' into v7.4-merge

elapsed time: 7753m

configs tested: 541
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                randconfig-r2111-20261022    gcc-12     cocci
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                      nsimosci_hs_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261023    gcc-14.4.0
arc                   randconfig-1000-20261024    clang-24
arc                   randconfig-1000-20261025    clang-24
arc                   randconfig-1000-20261026    clang-24
arc                   randconfig-1001-20261023    gcc-14.4.0
arc                   randconfig-1001-20261024    clang-24
arc                   randconfig-1001-20261025    clang-24
arc                   randconfig-1001-20261026    clang-24
arc                   randconfig-2000-20261022    clang-24
arc                   randconfig-2001-20261022    clang-24
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                         multi_v7_defconfig    gcc-16.2.0
arm                         mvebu_v7_defconfig    gcc-16.2.0
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20261023    gcc-14.4.0
arm                   randconfig-1000-20261024    clang-24
arm                   randconfig-1000-20261025    clang-24
arm                   randconfig-1000-20261026    clang-24
arm                   randconfig-1001-20261023    gcc-14.4.0
arm                   randconfig-1001-20261024    clang-24
arm                   randconfig-1001-20261025    clang-24
arm                   randconfig-1001-20261026    clang-24
arm                   randconfig-1002-20261023    gcc-14.4.0
arm                   randconfig-1002-20261024    clang-24
arm                   randconfig-1002-20261025    clang-24
arm                   randconfig-1002-20261026    clang-24
arm                   randconfig-1003-20261023    gcc-14.4.0
arm                   randconfig-1003-20261024    clang-24
arm                   randconfig-1003-20261025    clang-24
arm                   randconfig-1003-20261026    clang-24
arm                   randconfig-2000-20261022    clang-24
arm                   randconfig-2001-20261022    clang-24
arm                          s5pv210_defconfig    gcc-16.2.0
arm                          socfpga_defconfig    gcc-16.2.0
arm                           sp7021_defconfig    clang-24
arm                         spear6xx_defconfig    gcc-16.2.0
arm                            stm32_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261023    gcc-8.5.0
arm64                 randconfig-1000-20261024    gcc-10.5.0
arm64                 randconfig-1000-20261025    clang-24
arm64                 randconfig-1000-20261026    clang-24
arm64                 randconfig-1001-20261023    gcc-8.5.0
arm64                 randconfig-1001-20261024    gcc-10.5.0
arm64                 randconfig-1001-20261025    clang-24
arm64                 randconfig-1001-20261026    clang-24
arm64                 randconfig-1002-20261023    gcc-8.5.0
arm64                 randconfig-1002-20261024    gcc-10.5.0
arm64                 randconfig-1002-20261025    clang-24
arm64                 randconfig-1002-20261026    clang-24
arm64                 randconfig-1003-20261023    gcc-8.5.0
arm64                 randconfig-1003-20261024    gcc-10.5.0
arm64                 randconfig-1003-20261025    clang-24
arm64                 randconfig-1003-20261026    clang-24
arm64                randconfig-r2108-20261022    gcc-16.2.0 cocci
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261023    gcc-8.5.0
csky                  randconfig-1000-20261024    gcc-10.5.0
csky                  randconfig-1000-20261025    clang-24
csky                  randconfig-1000-20261026    clang-24
csky                  randconfig-1001-20261023    gcc-8.5.0
csky                  randconfig-1001-20261024    gcc-10.5.0
csky                  randconfig-1001-20261025    clang-24
csky                  randconfig-1001-20261026    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261023    clang-17
hexagon               randconfig-1000-20261024    clang-24
hexagon               randconfig-1000-20261025    clang-24
hexagon               randconfig-1000-20261026    clang-24
hexagon               randconfig-1001-20261023    clang-17
hexagon               randconfig-1001-20261024    clang-24
hexagon               randconfig-1001-20261025    clang-24
hexagon               randconfig-1001-20261026    clang-24
hexagon              randconfig-r2101-20261022    gcc-16.2.0 cocci
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261023    clang-22
i386        buildonly-randconfig-1000-20261024    clang-22
i386        buildonly-randconfig-1000-20261025    gcc-14
i386        buildonly-randconfig-1000-20261026    clang-22
i386        buildonly-randconfig-1001-20261023    clang-22
i386        buildonly-randconfig-1001-20261024    clang-22
i386        buildonly-randconfig-1001-20261025    gcc-14
i386        buildonly-randconfig-1001-20261026    clang-22
i386        buildonly-randconfig-1002-20261023    clang-22
i386        buildonly-randconfig-1002-20261024    clang-22
i386        buildonly-randconfig-1002-20261025    gcc-14
i386        buildonly-randconfig-1002-20261026    clang-22
i386        buildonly-randconfig-1003-20261023    clang-22
i386        buildonly-randconfig-1003-20261024    clang-22
i386        buildonly-randconfig-1003-20261025    gcc-14
i386        buildonly-randconfig-1003-20261026    clang-22
i386        buildonly-randconfig-1004-20261023    clang-22
i386        buildonly-randconfig-1004-20261024    clang-22
i386        buildonly-randconfig-1004-20261025    gcc-14
i386        buildonly-randconfig-1004-20261026    clang-22
i386        buildonly-randconfig-1005-20261023    clang-22
i386        buildonly-randconfig-1005-20261024    clang-22
i386        buildonly-randconfig-1005-20261025    gcc-14
i386        buildonly-randconfig-1005-20261026    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261023    gcc-14
i386                  randconfig-1000-20261024    clang-22
i386                  randconfig-1000-20261025    clang-22
i386                  randconfig-1000-20261026    gcc-14
i386                  randconfig-1001-20261023    gcc-14
i386                  randconfig-1001-20261024    clang-22
i386                  randconfig-1001-20261025    clang-22
i386                  randconfig-1001-20261026    gcc-14
i386                  randconfig-1002-20261023    gcc-14
i386                  randconfig-1002-20261024    clang-22
i386                  randconfig-1002-20261025    clang-22
i386                  randconfig-1002-20261026    gcc-14
i386                  randconfig-1003-20261023    gcc-14
i386                  randconfig-1003-20261024    clang-22
i386                  randconfig-1003-20261025    clang-22
i386                  randconfig-1003-20261026    gcc-14
i386                  randconfig-1004-20261023    gcc-14
i386                  randconfig-1004-20261024    clang-22
i386                  randconfig-1004-20261025    clang-22
i386                  randconfig-1004-20261026    gcc-14
i386                  randconfig-1005-20261023    gcc-14
i386                  randconfig-1005-20261024    clang-22
i386                  randconfig-1005-20261025    clang-22
i386                  randconfig-1005-20261026    gcc-14
i386                  randconfig-1006-20261023    gcc-14
i386                  randconfig-1006-20261024    clang-22
i386                  randconfig-1006-20261025    clang-22
i386                  randconfig-1006-20261026    gcc-14
i386                  randconfig-1007-20261023    clang-22
i386                  randconfig-1007-20261024    gcc-14
i386                  randconfig-1007-20261025    gcc-14
i386                  randconfig-1007-20261026    clang-22
i386                  randconfig-1008-20261023    clang-22
i386                  randconfig-1008-20261024    gcc-14
i386                  randconfig-1008-20261025    gcc-14
i386                  randconfig-1008-20261026    clang-22
i386                  randconfig-1009-20261023    clang-22
i386                  randconfig-1009-20261024    gcc-14
i386                  randconfig-1009-20261025    gcc-14
i386                  randconfig-1009-20261026    clang-22
i386                  randconfig-1010-20261023    clang-22
i386                  randconfig-1010-20261024    gcc-14
i386                  randconfig-1010-20261025    gcc-14
i386                  randconfig-1010-20261026    clang-22
i386                  randconfig-1011-20261023    clang-22
i386                  randconfig-1011-20261024    gcc-14
i386                  randconfig-1011-20261025    gcc-14
i386                  randconfig-1011-20261026    clang-22
i386                  randconfig-1012-20261023    clang-22
i386                  randconfig-1012-20261024    gcc-14
i386                  randconfig-1012-20261025    gcc-14
i386                  randconfig-1012-20261026    clang-22
i386                  randconfig-1013-20261023    clang-22
i386                  randconfig-1013-20261024    gcc-14
i386                  randconfig-1013-20261025    gcc-14
i386                  randconfig-1013-20261026    clang-22
i386                  randconfig-2000-20261022    clang-24
i386                  randconfig-2001-20261022    clang-24
i386                  randconfig-2100-20261022    gcc-14     cocci
i386                  randconfig-2101-20261022    gcc-14     cocci
i386                  randconfig-2102-20261022    gcc-14     cocci
i386                  randconfig-2103-20261022    gcc-14     cocci
i386                  randconfig-2104-20261022    gcc-14     cocci
i386                  randconfig-2105-20261022    gcc-14     cocci
i386                  randconfig-2200-20261022    gcc-14     smatch
i386                  randconfig-2300-20261022    gcc-14     sparse
i386                  randconfig-2301-20261022    gcc-14     sparse
i386                  randconfig-2302-20261022    gcc-14     sparse
i386                 randconfig-r2105-20261022    gcc-12     cocci
loongarch                         alldefconfig    gcc-16.2.0
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch                 loongson32_defconfig    gcc-11.5.0
loongarch             randconfig-1000-20261023    clang-17
loongarch             randconfig-1000-20261024    clang-24
loongarch             randconfig-1000-20261025    clang-24
loongarch             randconfig-1000-20261026    clang-24
loongarch             randconfig-1001-20261023    clang-17
loongarch             randconfig-1001-20261024    clang-24
loongarch             randconfig-1001-20261025    clang-24
loongarch             randconfig-1001-20261026    clang-24
loongarch             randconfig-2000-20261022    gcc-11.5.0
loongarch             randconfig-2001-20261022    gcc-11.5.0
m68k                              alldefconfig    gcc-16.2.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                        bvme6000_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                           hp300_defconfig    gcc-16.2.0
m68k                        m5275evb_defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2106-20261022    gcc-12     cocci
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                       bmips_stb_defconfig    clang-24
mips                          cobalt_defconfig    gcc-16.2.0
mips                           malta_defconfig    gcc-11.5.0
mips                 malta_qemu_32r6_defconfig    gcc-16.2.0
mips                     maltaup_xpa_defconfig    gcc-11.5.0
mips                         omega2p_defconfig    gcc-16.2.0
mips                        rbtx49xx_defconfig    clang-24
mips                           rm200_defconfig    gcc-16.2.0
mips                            xway_defconfig    gcc-16.2.0
nios2                             alldefconfig    gcc-11.5.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261023    clang-17
nios2                 randconfig-1000-20261024    clang-24
nios2                 randconfig-1000-20261025    clang-24
nios2                 randconfig-1000-20261026    clang-24
nios2                 randconfig-1001-20261023    clang-17
nios2                 randconfig-1001-20261024    clang-24
nios2                 randconfig-1001-20261025    clang-24
nios2                 randconfig-1001-20261026    clang-24
nios2                 randconfig-2000-20261022    gcc-11.5.0
nios2                 randconfig-2001-20261022    gcc-11.5.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc             randconfig-r2100-20261022    gcc-16.2.0 cocci
openrisc             randconfig-r2103-20261022    gcc-16.2.0 cocci
openrisc             randconfig-r2110-20261022    gcc-12     cocci
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                            allyesconfig    gcc-16.2.0
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261023    gcc-15.3.0
parisc                randconfig-1000-20261024    clang-24
parisc                randconfig-1000-20261025    clang-24
parisc                randconfig-1000-20261026    gcc-14.4.0
parisc                randconfig-1001-20261023    gcc-15.3.0
parisc                randconfig-1001-20261024    clang-24
parisc                randconfig-1001-20261025    clang-24
parisc                randconfig-1001-20261026    gcc-14.4.0
parisc                randconfig-2000-20261022    gcc-11.5.0
parisc                randconfig-2001-20261022    gcc-11.5.0
parisc               randconfig-r2104-20261022    gcc-12     cocci
parisc               randconfig-r2109-20261022    gcc-16.2.0 cocci
parisc64                             defconfig    clang-24
powerpc                     adder875_defconfig    gcc-16.2.0
powerpc                      akebono_defconfig    gcc-16.2.0
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       arches_defconfig    gcc-16.2.0
powerpc                      asp8347_defconfig    gcc-16.2.0
powerpc                        ebony_defconfig    gcc-11.5.0
powerpc                           g5_defconfig    clang-24
powerpc                         icon_defconfig    clang-24
powerpc                    lite5200b_defconfig    clang-24
powerpc                      mpc512x_defconfig    gcc-11.5.0
powerpc               randconfig-1000-20261023    gcc-15.3.0
powerpc               randconfig-1000-20261024    clang-24
powerpc               randconfig-1000-20261025    clang-24
powerpc               randconfig-1000-20261026    gcc-14.4.0
powerpc               randconfig-1001-20261023    gcc-15.3.0
powerpc               randconfig-1001-20261024    clang-24
powerpc               randconfig-1001-20261025    clang-24
powerpc               randconfig-1001-20261026    gcc-14.4.0
powerpc               randconfig-2000-20261022    clang-24
powerpc               randconfig-2001-20261022    clang-24
powerpc                      skiroot_defconfig    gcc-11.5.0
powerpc                      tqm8540_defconfig    gcc-16.2.0
powerpc                      tqm8548_defconfig    gcc-16.2.0
powerpc                         warp_defconfig    gcc-16.2.0
powerpc64                         alldefconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261023    gcc-15.3.0
powerpc64             randconfig-1000-20261024    clang-24
powerpc64             randconfig-1000-20261025    clang-24
powerpc64             randconfig-1000-20261026    gcc-14.4.0
powerpc64             randconfig-1001-20261023    gcc-15.3.0
powerpc64             randconfig-1001-20261024    clang-24
powerpc64             randconfig-1001-20261025    clang-24
powerpc64             randconfig-1001-20261026    gcc-14.4.0
powerpc64             randconfig-2000-20261022    clang-24
powerpc64             randconfig-2001-20261022    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv              nommu_k210_sdcard_defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261023    gcc-16.2.0
riscv                 randconfig-1000-20261024    gcc-11.5.0
riscv                 randconfig-1000-20261025    gcc-10.5.0
riscv                 randconfig-1000-20261026    gcc-13.5.0
riscv                 randconfig-1001-20261023    gcc-16.2.0
riscv                 randconfig-1001-20261024    gcc-11.5.0
riscv                 randconfig-1001-20261025    gcc-10.5.0
riscv                 randconfig-1001-20261026    gcc-13.5.0
riscv                         rzfive_defconfig    gcc-16.2.0
s390                              allmodconfig    clang-17
s390                              allmodconfig    gcc-16.2.0
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261023    gcc-16.2.0
s390                  randconfig-1000-20261024    gcc-11.5.0
s390                  randconfig-1000-20261025    gcc-10.5.0
s390                  randconfig-1000-20261026    gcc-13.5.0
s390                  randconfig-1001-20261023    gcc-16.2.0
s390                  randconfig-1001-20261024    gcc-11.5.0
s390                  randconfig-1001-20261025    gcc-10.5.0
s390                  randconfig-1001-20261026    gcc-13.5.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.2.0
sh                                   defconfig    gcc-14
sh                         edosk7705_defconfig    gcc-16.2.0
sh                                j2_defconfig    gcc-16.2.0
sh                             migor_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261023    gcc-16.2.0
sh                    randconfig-1000-20261024    gcc-11.5.0
sh                    randconfig-1000-20261025    gcc-10.5.0
sh                    randconfig-1000-20261026    gcc-13.5.0
sh                    randconfig-1001-20261023    gcc-16.2.0
sh                    randconfig-1001-20261024    gcc-11.5.0
sh                    randconfig-1001-20261025    gcc-10.5.0
sh                    randconfig-1001-20261026    gcc-13.5.0
sh                           rsk7269_defconfig    gcc-16.2.0
sh                           sdk7786_defconfig    gcc-16.2.0
sh                            se7724_defconfig    gcc-11.5.0
sh                            se7724_defconfig    gcc-16.2.0
sh                            sh2007_defconfig    gcc-16.2.0
sh                    sh7724_generic_defconfig    gcc-16.2.0
sh                         sh7757lcr_defconfig    clang-24
sh                              shx3_defconfig    gcc-16.2.0
sh                             titan_defconfig    gcc-16.2.0
sh                           urquell_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261023    clang-24
sparc                 randconfig-1000-20261024    gcc-14
sparc                 randconfig-1000-20261025    gcc-14
sparc                 randconfig-1000-20261026    gcc-14
sparc                 randconfig-1001-20261023    clang-24
sparc                 randconfig-1001-20261024    gcc-14
sparc                 randconfig-1001-20261025    gcc-14
sparc                 randconfig-1001-20261026    gcc-14
sparc                 randconfig-2000-20261022    gcc-15.3.0
sparc                 randconfig-2001-20261022    gcc-15.3.0
sparc                        sparc32_defconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261023    clang-24
sparc64               randconfig-1000-20261024    gcc-14
sparc64               randconfig-1000-20261025    gcc-14
sparc64               randconfig-1000-20261026    gcc-14
sparc64               randconfig-1001-20261023    clang-24
sparc64               randconfig-1001-20261024    gcc-14
sparc64               randconfig-1001-20261025    gcc-14
sparc64               randconfig-1001-20261026    gcc-14
sparc64               randconfig-2000-20261022    gcc-15.3.0
sparc64               randconfig-2001-20261022    gcc-15.3.0
sparc64              randconfig-r2102-20261022    gcc-16.2.0 cocci
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261023    clang-24
um                    randconfig-1000-20261024    gcc-14
um                    randconfig-1000-20261025    gcc-14
um                    randconfig-1000-20261026    gcc-14
um                    randconfig-1001-20261023    clang-24
um                    randconfig-1001-20261024    gcc-14
um                    randconfig-1001-20261025    gcc-14
um                    randconfig-1001-20261026    gcc-14
um                    randconfig-2000-20261022    gcc-15.3.0
um                    randconfig-2001-20261022    gcc-15.3.0
um                   randconfig-r2107-20261022    gcc-12     cocci
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261023    clang-22
x86_64      buildonly-randconfig-1000-20261024    gcc-14
x86_64      buildonly-randconfig-1000-20261025    gcc-14
x86_64      buildonly-randconfig-1000-20261026    clang-22
x86_64      buildonly-randconfig-1001-20261023    clang-22
x86_64      buildonly-randconfig-1001-20261024    gcc-14
x86_64      buildonly-randconfig-1001-20261025    gcc-14
x86_64      buildonly-randconfig-1001-20261026    clang-22
x86_64      buildonly-randconfig-1002-20261023    clang-22
x86_64      buildonly-randconfig-1002-20261024    gcc-14
x86_64      buildonly-randconfig-1002-20261025    gcc-14
x86_64      buildonly-randconfig-1002-20261026    clang-22
x86_64      buildonly-randconfig-1003-20261023    clang-22
x86_64      buildonly-randconfig-1003-20261024    gcc-14
x86_64      buildonly-randconfig-1003-20261025    gcc-14
x86_64      buildonly-randconfig-1003-20261026    clang-22
x86_64      buildonly-randconfig-1004-20261023    clang-22
x86_64      buildonly-randconfig-1004-20261024    gcc-14
x86_64      buildonly-randconfig-1004-20261025    gcc-14
x86_64      buildonly-randconfig-1004-20261026    clang-22
x86_64      buildonly-randconfig-1005-20261023    clang-22
x86_64      buildonly-randconfig-1005-20261024    gcc-14
x86_64      buildonly-randconfig-1005-20261025    gcc-14
x86_64      buildonly-randconfig-1005-20261026    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261023    gcc-14
x86_64                randconfig-1000-20261024    gcc-14
x86_64                randconfig-1000-20261025    clang-22
x86_64                randconfig-1000-20261026    clang-22
x86_64                randconfig-1001-20261023    gcc-14
x86_64                randconfig-1001-20261024    gcc-14
x86_64                randconfig-1001-20261025    clang-22
x86_64                randconfig-1001-20261026    clang-22
x86_64                randconfig-1002-20261023    gcc-14
x86_64                randconfig-1002-20261024    gcc-14
x86_64                randconfig-1002-20261025    clang-22
x86_64                randconfig-1002-20261026    clang-22
x86_64                randconfig-1003-20261023    gcc-14
x86_64                randconfig-1003-20261024    gcc-14
x86_64                randconfig-1003-20261025    clang-22
x86_64                randconfig-1003-20261026    clang-22
x86_64                randconfig-1004-20261023    gcc-14
x86_64                randconfig-1004-20261024    gcc-14
x86_64                randconfig-1004-20261025    clang-22
x86_64                randconfig-1004-20261026    clang-22
x86_64                randconfig-1005-20261023    gcc-14
x86_64                randconfig-1005-20261024    gcc-14
x86_64                randconfig-1005-20261025    clang-22
x86_64                randconfig-1005-20261026    clang-22
x86_64                randconfig-1006-20261023    gcc-14
x86_64                randconfig-1006-20261024    gcc-13
x86_64                randconfig-1006-20261025    clang-22
x86_64                randconfig-1006-20261026    gcc-14
x86_64                randconfig-1007-20261023    gcc-14
x86_64                randconfig-1007-20261024    gcc-13
x86_64                randconfig-1007-20261025    clang-22
x86_64                randconfig-1007-20261026    gcc-14
x86_64                randconfig-1008-20261023    gcc-14
x86_64                randconfig-1008-20261024    gcc-13
x86_64                randconfig-1008-20261025    clang-22
x86_64                randconfig-1008-20261026    gcc-14
x86_64                randconfig-1009-20261023    gcc-14
x86_64                randconfig-1009-20261024    gcc-13
x86_64                randconfig-1009-20261025    clang-22
x86_64                randconfig-1009-20261026    gcc-14
x86_64                randconfig-1010-20261023    gcc-14
x86_64                randconfig-1010-20261024    gcc-13
x86_64                randconfig-1010-20261025    clang-22
x86_64                randconfig-1010-20261026    gcc-14
x86_64                randconfig-1011-20261023    gcc-14
x86_64                randconfig-1011-20261024    gcc-13
x86_64                randconfig-1011-20261025    clang-22
x86_64                randconfig-1011-20261026    gcc-14
x86_64                randconfig-1012-20261023    clang-22
x86_64                randconfig-1012-20261024    clang-22
x86_64                randconfig-1012-20261025    clang-22
x86_64                randconfig-1012-20261026    gcc-14
x86_64                randconfig-1013-20261023    clang-22
x86_64                randconfig-1013-20261024    clang-22
x86_64                randconfig-1013-20261025    clang-22
x86_64                randconfig-1013-20261026    gcc-14
x86_64                randconfig-1014-20261023    clang-22
x86_64                randconfig-1014-20261024    clang-22
x86_64                randconfig-1014-20261025    clang-22
x86_64                randconfig-1014-20261026    gcc-14
x86_64                randconfig-1015-20261023    clang-22
x86_64                randconfig-1015-20261024    clang-22
x86_64                randconfig-1015-20261025    clang-22
x86_64                randconfig-1015-20261026    gcc-14
x86_64                randconfig-1016-20261023    clang-22
x86_64                randconfig-1016-20261024    clang-22
x86_64                randconfig-1016-20261025    clang-22
x86_64                randconfig-1016-20261026    gcc-14
x86_64                randconfig-1017-20261023    clang-22
x86_64                randconfig-1017-20261024    clang-22
x86_64                randconfig-1017-20261025    clang-22
x86_64                randconfig-1017-20261026    gcc-14
x86_64                randconfig-2000-20261022    clang-24
x86_64                randconfig-2001-20261022    clang-24
x86_64                randconfig-2100-20261022    gcc-14     cocci
x86_64                randconfig-2101-20261022    gcc-14     cocci
x86_64                randconfig-2102-20261022    gcc-14     cocci
x86_64                randconfig-2103-20261022    gcc-14     cocci
x86_64                randconfig-2104-20261022    gcc-14     cocci
x86_64                randconfig-2105-20261022    gcc-14     cocci
x86_64                randconfig-2200-20261022    gcc-14     smatch
x86_64                randconfig-2300-20261022    gcc-14     sparse
x86_64                randconfig-2301-20261022    gcc-14     sparse
x86_64                randconfig-2302-20261022    gcc-14     sparse
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
xtensa                 generic_kc705_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261023    clang-24
xtensa                randconfig-1000-20261024    gcc-14
xtensa                randconfig-1000-20261025    gcc-14
xtensa                randconfig-1000-20261026    gcc-14
xtensa                randconfig-1001-20261023    clang-24
xtensa                randconfig-1001-20261024    gcc-14
xtensa                randconfig-1001-20261025    gcc-14
xtensa                randconfig-1001-20261026    gcc-14
xtensa                randconfig-2000-20261022    gcc-15.3.0
xtensa                randconfig-2001-20261022    gcc-15.3.0
xtensa               randconfig-r2201-20261022    gcc-12.5.0 smatch
xtensa                          virt_defconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
