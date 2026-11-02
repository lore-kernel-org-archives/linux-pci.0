Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638182;
	b=Vt5fcRZ7qafirhUsqGAQ+KtB5X3ZMdYnOlTZpmmDQEHw/LP49JfSa1JNIRWeJNxfw5D5
	 eCzm6u5WLOdncyYH7Rg5q5contJNWJ8nnO18u025Yrwflh8FGd+YcbJayAmitsXeGJYeq
	 vpf6kXM05DL5bGtL2xql4i4Ou8DnWydI7/H0aElVLbtDBzqhdMC2knWetsZcXXKAvZ/xq
	 z6Ui1dZZ0W8e0UvAnmdrwOXg7WkfwuevbwijENc+/p4PfImQQzGthSXoSaSjLlLaa6CYc
	 nQanZNIm9howxLSxsVAjnmyOq895wMB9AGe7/B59r64E114kVA9Pa8Y5mehRFO/5Mxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638182;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=dXNZX8JCngS9R7XFJOh9zru81nQIGSbkroWsq82ThJ8=;
	b=ckuu+QeahHSKmLCv3HsT4QRn3pXQOWYiTOpbos08S2+yUtKJ43UMA44/xm2jyz3TeJu/
	 SO6oh9xbVEMJr7Gb+aNILC+PWnuvzHCgvKwesb8ckllzGwLB7IGKTnhTgD/00cFA4usCy
	 s2Ylf7kpVIEjXWk12+6jRj/L5z5jq3f5KF0cKlRFECROIJEnvr/TBNb3gqYMVkYNSNbVP
	 BRnlQj7fScPW5o0SeWX+4i2/jqdiUB25RPrXdXItnT3govlrna9aQE7Hjz9+r6D+3gyxP
	 o15JAnfTqiWy9kXV+CEFDANPmDHXJUUqWAwqpO5xGmbPQyAr1GagLWwX33xOEEonbLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cRgF0sqO;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845E56072C67
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 16:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 845E56072C67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cRgF0sqO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793638181; x=1825174181;
  h=date:from:to:cc:subject:message-id;
  bh=6P4SPTGEyqg/iheyjXExNtUk5fig5eUcytlHE3jSMCM=;
  b=cRgF0sqO/LI98vvPqMXEO3ju723ptyptxCO5z5jh3WL7w1DycXY3WWzJ
   hyKZfdgT9tPZH/m7Pm88OQiH/nJERio5PO0P4/a+9O/k47TRUGRk58URA
   xos0Oo1ci0rXPbowc91aTS0wbYhyRbRGZqDjrw3xi2k+v57TKtTyjgb/5
   HBX68hxbNFkBd+ezegQNoXlIbzFm81u5QS1KjVnx9GN/5dqMlB6WNQVuZ
   +LKsqas93n3B6krR58TorelXArH0bglh3rqkEOAR39BcADeUSZL2cMb8y
   aJeV41+GStTgFjQdh3KJ1w2jqOJ1seM3NE5Pc8UUWAr2s5MLKfOCok27o
   Q==;
X-CSE-ConnectionGUID: NGXk3uB8QBqiirJbc06sXQ==
X-CSE-MsgGUID: 2ym/fTxnSAG5NtZUZlf+Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2217996"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2217996"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 08:49:40 -0800
X-CSE-ConnectionGUID: Pm5nubjmS06Bd1EsvApWZw==
X-CSE-MsgGUID: 0iR6IKZSTIu1Z4QK025lfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6269019"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 02 Nov 2026 08:49:39 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xNvE0-00000000hPz-2pme;
	Mon, 02 Nov 2026 16:49:36 +0000
Date: Tue, 03 Nov 2026 00:49:04 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:rcar-host] BUILD SUCCESS
 bd3f9176579dd568257b6de8d7ba8f3ba2779028
Message-ID: <20261103004904.LK5W7HdN-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rcar-host
branch HEAD: bd3f9176579dd568257b6de8d7ba8f3ba2779028  PCI: rcar-host: Free MSI IRQs on error

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
