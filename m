Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8193C583A
	for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2026 03:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791084467; cv=none; b=fhYLLDPBNrHNFzNJFyWFDcz/ctgkb4GY81sxXKFUoZfPPeKhsF8PwNRXcGpUPqBbS/2x7VdiJmsGiNGYmhTK8+h0XvuJI47D7xCyRqLOK/5E3Tipt5mpcLkWNcDFSuVqptdLuZh75OfS38Es/3Nj26w9QllJmSOsbbJHzCFJIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791084467; c=relaxed/simple;
	bh=GhaOK75QJMj/s8kC0mzDKT9JPjYHZyIJqXfH7UX1Sqw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Raoficqvt86JPTibi7ni9/+BNVLVdgzNiPzpuJjTCRIGnSXWJEpvu3qgmsXESb2dBVV0rwqUKW1fIfnb4frWS0QjV8JaxGHN+SxocdmQ7q3+6Sz+S8yknU87UnCGI42K892K3Ky9A8g6Eii6eLjjxttVGnCpC8lrXMdbrEyUgjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPZ5Nx75; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPZ5Nx75"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791084465; x=1822620465;
  h=date:from:to:cc:subject:message-id;
  bh=GhaOK75QJMj/s8kC0mzDKT9JPjYHZyIJqXfH7UX1Sqw=;
  b=fPZ5Nx753/+xG463Lrp4YfE9JJyZiyFP8PCQlGGR0XFQlyie9ZaQ1xKE
   QlXia/Vcix1nGfueyi07Cy8UkA9jpwTorgE/dKFDOlEXZEvX1T5acMhop
   dWj5AvAzzp2tBXPAma/RejrGZzuco2iuD27N/NHlBpDsqDTtvXB36+B/a
   vdc59QaOTarm4iDnaIS/kK9v3KwzUBgXkLusFvD8hMuaXE9z7ouTdUNMS
   qya8quclzUZOLrSzD5ljd//4rHxDUo0qXw201V3tg9l8acU/Ac9YV2Byv
   JQNKErpe3aO4qMA8SGa7U4cuHoYXpEr3R31jiedmdtOdE5myVFvNIPILE
   w==;
X-CSE-ConnectionGUID: afIt3GyhSjaxRIb8eOwwNA==
X-CSE-MsgGUID: Lw7jLPp9REGy4vz5gwQ2ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="90692454"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="90692454"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 20:27:44 -0700
X-CSE-ConnectionGUID: TVa06NDXSRu9CL+1uXZ6NA==
X-CSE-MsgGUID: ZvkUpKypQa2a7au4GCBUBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="306042592"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Oct 2026 20:27:43 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xDCt2-00000000UPx-2832;
	Sun, 04 Oct 2026 03:27:40 +0000
Date: Sun, 04 Oct 2026 11:26:45 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:reset] BUILD SUCCESS
 f8522a518e59be45ad09b419c0258eb9791c4ef1
Message-ID: <202610041142.bC99izq5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git reset
branch HEAD: f8522a518e59be45ad09b419c0258eb9791c4ef1  PCI: Add device-specific reset for Qualcomm WCN6855/WCN7850 WLAN

elapsed time: 1315m

configs tested: 198
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261004    clang-22
arc                   randconfig-1001-20261004    clang-22
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          bcm2835_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                           pxa168_defconfig    gcc-16.1.0
arm                              pxa_defconfig    gcc-16.1.0
arm                             qcom_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261004    clang-22
arm                   randconfig-1001-20261004    clang-22
arm                   randconfig-1002-20261004    clang-22
arm                   randconfig-1003-20261004    clang-22
arm                          s3c6400_defconfig    gcc-16.1.0
arm                     vt8500_v6_v7_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261003    gcc-9.5.0
arm64                 randconfig-1001-20261003    gcc-9.5.0
arm64                 randconfig-1002-20261003    gcc-9.5.0
arm64                 randconfig-1003-20261003    gcc-9.5.0
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261003    gcc-9.5.0
csky                  randconfig-1001-20261003    gcc-9.5.0
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261003    gcc-16.1.0
hexagon               randconfig-1001-20261003    gcc-16.1.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261003    gcc-14
i386        buildonly-randconfig-1001-20261003    gcc-14
i386        buildonly-randconfig-1002-20261003    gcc-14
i386        buildonly-randconfig-1003-20261003    gcc-14
i386        buildonly-randconfig-1004-20261003    gcc-14
i386        buildonly-randconfig-1005-20261003    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261003    gcc-14
i386                  randconfig-1001-20261003    gcc-14
i386                  randconfig-1002-20261003    gcc-14
i386                  randconfig-1003-20261003    gcc-14
i386                  randconfig-1004-20261003    gcc-14
i386                  randconfig-1005-20261003    gcc-14
i386                  randconfig-1006-20261003    gcc-14
i386                  randconfig-1007-20261003    gcc-14
i386                  randconfig-1008-20261003    gcc-14
i386                  randconfig-1009-20261003    gcc-14
i386                  randconfig-1010-20261003    gcc-14
i386                  randconfig-1011-20261003    gcc-14
i386                  randconfig-1012-20261003    gcc-14
i386                  randconfig-1013-20261003    gcc-14
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261003    gcc-16.1.0
loongarch             randconfig-1001-20261003    gcc-16.1.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          apollo_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                        m5275evb_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                      eyeq6lplus_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261003    gcc-16.1.0
nios2                 randconfig-1001-20261003    gcc-16.1.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc                  simple_smp_defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261003    gcc-11.5.0
parisc                randconfig-1000-20261004    gcc-12.5.0
parisc                randconfig-1001-20261003    gcc-11.5.0
parisc                randconfig-1001-20261004    gcc-12.5.0
parisc64                          alldefconfig    gcc-16.1.0
parisc64                             defconfig    clang-24
powerpc                            allnoconfig    clang-24
powerpc                      kmeter1_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261003    gcc-11.5.0
powerpc               randconfig-1000-20261004    gcc-12.5.0
powerpc               randconfig-1001-20261003    gcc-11.5.0
powerpc               randconfig-1001-20261004    gcc-12.5.0
powerpc64             randconfig-1000-20261003    gcc-11.5.0
powerpc64             randconfig-1000-20261004    gcc-12.5.0
powerpc64             randconfig-1001-20261003    gcc-11.5.0
powerpc64             randconfig-1001-20261004    gcc-12.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261003    gcc-12.5.0
riscv                 randconfig-1000-20261004    gcc-11.5.0
riscv                 randconfig-1001-20261003    gcc-12.5.0
riscv                 randconfig-1001-20261004    gcc-11.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261003    gcc-12.5.0
s390                  randconfig-1000-20261004    gcc-11.5.0
s390                  randconfig-1001-20261003    gcc-12.5.0
s390                  randconfig-1001-20261004    gcc-11.5.0
s390                        zfcpdump_defconfig    gcc-16.1.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261003    gcc-12.5.0
sh                    randconfig-1000-20261004    gcc-11.5.0
sh                    randconfig-1001-20261003    gcc-12.5.0
sh                    randconfig-1001-20261004    gcc-11.5.0
sh                         sh7785lcr_defconfig    gcc-16.1.0
sparc                             alldefconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261004    gcc-14
sparc                 randconfig-1001-20261004    gcc-14
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261004    gcc-14
sparc64               randconfig-1001-20261004    gcc-14
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261004    gcc-14
um                    randconfig-1001-20261004    gcc-14
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261003    clang-22
x86_64      buildonly-randconfig-1001-20261003    clang-22
x86_64      buildonly-randconfig-1002-20261003    clang-22
x86_64      buildonly-randconfig-1003-20261003    clang-22
x86_64      buildonly-randconfig-1004-20261003    clang-22
x86_64      buildonly-randconfig-1005-20261003    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261003    clang-22
x86_64                randconfig-1000-20261004    gcc-14
x86_64                randconfig-1001-20261003    clang-22
x86_64                randconfig-1001-20261004    gcc-14
x86_64                randconfig-1002-20261003    clang-22
x86_64                randconfig-1002-20261004    gcc-14
x86_64                randconfig-1003-20261003    clang-22
x86_64                randconfig-1003-20261004    gcc-14
x86_64                randconfig-1004-20261003    clang-22
x86_64                randconfig-1004-20261004    gcc-14
x86_64                randconfig-1005-20261003    clang-22
x86_64                randconfig-1005-20261004    gcc-14
x86_64                randconfig-1006-20261003    clang-22
x86_64                randconfig-1007-20261003    clang-22
x86_64                randconfig-1008-20261003    clang-22
x86_64                randconfig-1009-20261003    clang-22
x86_64                randconfig-1010-20261003    clang-22
x86_64                randconfig-1011-20261003    clang-22
x86_64                randconfig-1012-20261003    clang-22
x86_64                randconfig-1013-20261003    clang-22
x86_64                randconfig-1014-20261003    clang-22
x86_64                randconfig-1015-20261003    clang-22
x86_64                randconfig-1016-20261003    clang-22
x86_64                randconfig-1017-20261003    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261004    gcc-14
xtensa                randconfig-1001-20261004    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
