Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638183;
	b=G0Ol/rlg0giYB9+OoENZ5aiaVW2vGRxXEoSILiUZ+yVkdrVv83nVylD1MSr/9GsQSZ+v
	 6m1VeeoPS+gyjxwCBoP7h3ZK5XRziCbPU1F4hSFE+6tjny8cXfPHern1H65j4NU2MgQ/M
	 ILFk5ZHjX8iQUZ2tIP1qLPir2dsFvzLwhn/AMSWLpxOy/1UuG2B27XjTcGXpRbMT5p8YW
	 pFzFXl7Nqy0HnMnzVdAb4dKyqki7cz6gOJbbiUknLEDYE/os/k2OV3oao9Lr2b3I1uLfz
	 tUIiQdqGfN483qkVLkspNHTNUBcXbXvmj/9YTYg8w/ga8qVf68BBIT34UevhrgluO+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638183;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=OeeJZ5mT6SZ1loKA1lt9QWkxOvu+jVxNx4ICDSwpAa8=;
	b=EI7zQNSmfvEq2WAtUeA03lygmkukgHx3IIwJE134uyFsC5B4exAhEuSxD+QYJWUvZSIZ
	 73aRLuZVk5GocRNi/ZRa4gYs09ujDHcmwbB4vq3RD4z9Tx92yozqCddCObm7ZH1OCj23R
	 +DN7LbbseDLP+Fv5U3EetOSMDgewBsC9AegOcDfKO1oKh5AvHRJzv74RePRNRxjDW7TIS
	 eSgz9oNhFeyn4BXJFgsDl9DTN83ZWyTx2ye0ClnYArmg9Fdb3j3LeVXtPv7jOleptPZ8d
	 pTBMmlUvhQFepd2VwEwDoeUh3M78luZBYRjqEdmKrqVxFtv9uztaMOZFse2806DOWig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="GuWO/UQc";
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CAB6072C4B
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 16:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0CAB6072C4B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GuWO/UQc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793638181; x=1825174181;
  h=date:from:to:cc:subject:message-id;
  bh=UEis+mNRDC1P1C56WFEV5f/GkEQb2b8YBN/1IUbnpeM=;
  b=GuWO/UQcV5GshDw2BLju2ngXJ6q4V3jHTwAQg4I8+Ib4nVv7TkEL1kOv
   XEpD1lnl20e1G4AVRlQKIOgmg8wXdfDbxU+DwBQT/ihCW4gckb9t1mpTB
   YK6DpMbGWnJAe3hpkMfNuf5cGI2y7vioG3Tb6dAWr9+tF+QH3p4AdFlpU
   ilK4dbpBv5pWaNCZ8CfexK/59CZXRt9PoSwohZGvDKYhuEEyk/paTvWYQ
   v0NISa/Hb/2TKIj6qvrQJRUidbsQX1uyGOLjtq/pzHeYjAuoqIgL/qU67
   ewjmdZtEbqs6S/JAgnWFECy7Wd25SnnR+b2abvImpTwpYqolSnXM+5Hsf
   A==;
X-CSE-ConnectionGUID: dHPQ6WyHQDibeFCAFigEuQ==
X-CSE-MsgGUID: sm2Ad7VPQkioCs5imZlYIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2333135"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2333135"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 08:49:40 -0800
X-CSE-ConnectionGUID: MbpXOtvRRG2GLw4d/cFPZQ==
X-CSE-MsgGUID: cvWMJ58pSGOwwzoYfh4s/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6280960"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 02 Nov 2026 08:49:39 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xNvE0-00000000hPv-1yss;
	Mon, 02 Nov 2026 16:49:36 +0000
Date: Tue, 03 Nov 2026 00:48:53 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc] BUILD SUCCESS
 8b0e01d77ef4ceedd96d00d28f3518037481d2cd
Message-ID: <20261103004853.FtSDI4XV-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 8b0e01d77ef4ceedd96d00d28f3518037481d2cd  PCI: dwc: Skip MEM outbound iATU setup for identity mappings

elapsed time: 1976m

configs tested: 158
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                      haps_hs_smp_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261102    gcc-10.5.0
arc                   randconfig-1001-20261102    gcc-10.5.0
arm                                allnoconfig    gcc-16.2.0
arm                          bcm2835_defconfig    gcc-16.2.0
arm                           collie_defconfig    gcc-16.2.0
arm                                  defconfig    gcc-16.2.0
arm                       integrator_defconfig    gcc-16.2.0
arm                              mxs_defconfig    clang-24
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20261102    gcc-10.5.0
arm                   randconfig-1001-20261102    gcc-10.5.0
arm                   randconfig-1002-20261102    gcc-10.5.0
arm                   randconfig-1003-20261102    gcc-10.5.0
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261102    clang-24
arm64                 randconfig-1001-20261102    clang-24
arm64                 randconfig-1002-20261102    clang-24
arm64                 randconfig-1003-20261102    clang-24
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261102    clang-24
csky                  randconfig-1001-20261102    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261102    clang-19
hexagon               randconfig-1001-20261102    clang-19
i386                               allnoconfig    gcc-16.2.0
i386        buildonly-randconfig-1000-20261102    clang-22
i386        buildonly-randconfig-1001-20261102    clang-22
i386        buildonly-randconfig-1002-20261102    clang-22
i386        buildonly-randconfig-1003-20261102    clang-22
i386        buildonly-randconfig-1004-20261102    clang-22
i386        buildonly-randconfig-1005-20261102    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261102    gcc-14
i386                  randconfig-1001-20261102    gcc-14
i386                  randconfig-1002-20261102    gcc-14
i386                  randconfig-1003-20261102    gcc-14
i386                  randconfig-1004-20261102    gcc-14
i386                  randconfig-1005-20261102    gcc-14
i386                  randconfig-1006-20261102    gcc-14
i386                  randconfig-1007-20261102    clang-22
i386                  randconfig-1008-20261102    clang-22
i386                  randconfig-1009-20261102    clang-22
i386                  randconfig-1010-20261102    clang-22
i386                  randconfig-1011-20261102    clang-22
i386                  randconfig-1012-20261102    clang-22
i386                  randconfig-1013-20261102    clang-22
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261102    clang-19
loongarch             randconfig-1001-20261102    clang-19
m68k                               allnoconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
microblaze                         allnoconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                               allnoconfig    gcc-16.2.0
mips                      cu1830-neo_defconfig    gcc-16.2.0
mips                      decstation_defconfig    clang-24
mips                      eyeq6lplus_defconfig    clang-24
mips                            ip22_defconfig    clang-24
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261102    clang-19
nios2                 randconfig-1001-20261102    clang-19
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261102    clang-17
parisc                randconfig-1001-20261102    clang-17
parisc64                             defconfig    clang-24
powerpc                            allnoconfig    clang-24
powerpc                      asp8347_defconfig    gcc-16.2.0
powerpc                  canyonlands_defconfig    clang-24
powerpc                    lite5200b_defconfig    gcc-16.2.0
powerpc                      mpc512x_defconfig    clang-24
powerpc               randconfig-1000-20261102    clang-17
powerpc               randconfig-1001-20261102    clang-17
powerpc64             randconfig-1000-20261102    clang-17
powerpc64             randconfig-1001-20261102    clang-17
riscv                              allnoconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261102    clang-21
riscv                 randconfig-1001-20261102    clang-21
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261102    clang-21
s390                  randconfig-1001-20261102    clang-21
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261102    clang-21
sh                    randconfig-1001-20261102    clang-21
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261102    gcc-15.3.0
sparc                 randconfig-1001-20261102    gcc-15.3.0
sparc                        sparc64_defconfig    clang-24
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261102    gcc-15.3.0
sparc64               randconfig-1001-20261102    gcc-15.3.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261102    gcc-15.3.0
um                    randconfig-1001-20261102    gcc-15.3.0
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20261102    gcc-14
x86_64      buildonly-randconfig-1001-20261102    gcc-14
x86_64      buildonly-randconfig-1002-20261102    gcc-14
x86_64      buildonly-randconfig-1003-20261102    gcc-14
x86_64      buildonly-randconfig-1004-20261102    gcc-14
x86_64      buildonly-randconfig-1005-20261102    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261102    clang-22
x86_64                randconfig-1001-20261102    clang-22
x86_64                randconfig-1002-20261102    clang-22
x86_64                randconfig-1003-20261102    clang-22
x86_64                randconfig-1004-20261102    clang-22
x86_64                randconfig-1005-20261102    clang-22
x86_64                randconfig-1006-20261102    gcc-14
x86_64                randconfig-1007-20261102    gcc-14
x86_64                randconfig-1008-20261102    gcc-14
x86_64                randconfig-1009-20261102    gcc-14
x86_64                randconfig-1010-20261102    gcc-14
x86_64                randconfig-1011-20261102    gcc-14
x86_64                randconfig-1012-20261102    gcc-12
x86_64                randconfig-1013-20261102    gcc-12
x86_64                randconfig-1014-20261102    gcc-12
x86_64                randconfig-1015-20261102    gcc-12
x86_64                randconfig-1016-20261102    gcc-12
x86_64                randconfig-1017-20261102    gcc-12
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
xtensa                             allnoconfig    clang-24
xtensa                randconfig-1000-20261102    gcc-15.3.0
xtensa                randconfig-1001-20261102    gcc-15.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
