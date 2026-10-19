Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434403;
	b=jOy/1z14YZM9yFLqO5nW9PbdyZf2dHV0MlnvEnZo/Nm3EHJSdICCilxVgG/u6yodzJqE
	 v+s1mkDNHUZXLGyKnTaquwIwfVv7Pbkh0S+vGK3PegYBVuLREHmtdL1JKbIz0x9dbbcHg
	 Y3dHUPize/0qPWL9uWsgQQs7Wh/hAIvjUZz7RPpGcJvQn8ovzjvK+EFsRGp16dUuFKKvn
	 80AUTlFVkLBaKv5X9ScVxAQDbUETD4fvwbRrxThnNmKgigiaeFsdjPP/8z3/m+oU+m/3n
	 xD+5epTXXhYZCd8OLmrGbPfmsqH44zjxPHsP3B05cjT5uuzxN3sNPs0wz4bf9jKTnIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434403;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=yZFQ1a9VTpANlBDGvhpMj8DWX3T/W3tHL8N828qLvIE=;
	b=at+zbl4mNK/KxmVqSYJnAbByQ1BFVRA3S2AgFQixkSiq9WPLT9doxurk4EFm6HpGMdGJ
	 Kl7WuU+7nsj8Bq0MAvFnu1+MWp+mA0URObUEwRyPMPKfwWlEq0uZUSJh9wpi/11FKJUrX
	 lwcAQD81I3spxsv6At2RN0aUCvIOgsJwfdLaps2Mt1aSwtM0sQRKOpl0X2OELSYqQksnm
	 uF/swJEAIL61X8ktyaUygHOg0ESXnJV56x3uy/MydWtJ7CnxoP7FBbk2WJqdzAErv/oGI
	 a7xL1H7KgxMV5x6UkPyEG/zDA+GKH0Vkl/8zISyxNtrAsRkykRywoya746PK2vNI/5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VxSsVqfL;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E86360A2630
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 18:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E86360A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VxSsVqfL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792434403; x=1823970403;
  h=date:from:to:cc:subject:message-id;
  bh=l+Rgq3+01fYeNfw314Ha0X3vyFpJl7FysUGrFCvq9YQ=;
  b=VxSsVqfLt0YBN4TpTlCCcJC6eIW2jrFxjJC4rYf0j2DFtYKh9bB2vUFL
   IquPWoSOyowzkrfrjSc+sOHvzskPeyVoJHqjbRILgUgVyw5JGNVgbOTrO
   8p6k5430FY4Y7MhSrWjOe0CUVZMpIe/UXC76g1JX1VBY+6hjMXLrXPqa9
   cS53DYsu/+HkaMufUGfsgfcPTahScIJaRcMwjrCBiri0JpHotBA1WjZPP
   X4cwr6fLtA3OqEB9i+4K9OGNGrAhX9qUn3qWzhL/B64zJm+nGeY81Njb+
   B5L/EO2CxrD3uVwTnP7W/fGP6jy5zZpeRGJo8u4g79HYADSzpfTeald/b
   A==;
X-CSE-ConnectionGUID: VojhNm/gSUy8hInZqub9Aw==
X-CSE-MsgGUID: EeeR9W9hTLCFkIJOSEZHjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1163245"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1163245"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 11:26:40 -0700
X-CSE-ConnectionGUID: ZKJ4aurnRIibrv7CdxiCHw==
X-CSE-MsgGUID: JhibaI7vSPidRGkZ6eYlzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2607061"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 19 Oct 2026 11:26:38 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIs4C-00000000MCK-1diz;
	Mon, 19 Oct 2026 18:26:36 +0000
Date: Tue, 20 Oct 2026 02:26:04 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc] BUILD SUCCESS
 fd3186c0bbb157375532695ab365afe4a2e6fa24
Message-ID: <202610200202.aWfXHxBQ-lkp@intel.com>
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
branch HEAD: fd3186c0bbb157375532695ab365afe4a2e6fa24  PCI: dwc: Describe DWC PCIe fields with full masks and FIELD_PREP()

elapsed time: 2201m

configs tested: 133
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                    allnoconfig    gcc-16.2.0
alpha                   allyesconfig    gcc-16.2.0
arc                     allmodconfig    gcc-16.2.0
arc                      allnoconfig    gcc-16.2.0
arc                     allyesconfig    clang-24
arc                     allyesconfig    gcc-16.2.0
arc         randconfig-1000-20261019    clang-21
arc         randconfig-1001-20261019    clang-21
arm                      allnoconfig    clang-17
arm                     allyesconfig    gcc-16.2.0
arm                mv78xx0_defconfig    gcc-16.2.0
arm         randconfig-1000-20261019    clang-21
arm         randconfig-1001-20261019    clang-21
arm         randconfig-1002-20261019    clang-21
arm         randconfig-1003-20261019    clang-21
arm64                   allmodconfig    clang-24
arm64                    allnoconfig    gcc-16.2.0
arm64       randconfig-1000-20261019    clang-24
arm64       randconfig-1001-20261019    clang-24
arm64       randconfig-1002-20261019    clang-24
arm64       randconfig-1003-20261019    clang-24
csky                    allmodconfig    gcc-16.2.0
csky                     allnoconfig    gcc-16.2.0
csky        randconfig-1000-20261019    clang-24
csky        randconfig-1001-20261019    clang-24
hexagon                 allmodconfig    clang-24
hexagon                 allmodconfig    gcc-16.2.0
hexagon                  allnoconfig    clang-24
hexagon     randconfig-1000-20261019    clang-24
hexagon     randconfig-1001-20261019    clang-24
i386                    allmodconfig    gcc-14
i386                     allnoconfig    gcc-14
i386        randconfig-1007-20261019    gcc-14
i386        randconfig-1008-20261019    gcc-14
i386        randconfig-1009-20261019    gcc-14
i386        randconfig-1010-20261019    gcc-14
i386        randconfig-1011-20261019    gcc-14
i386        randconfig-1012-20261019    gcc-14
i386        randconfig-1013-20261019    gcc-14
loongarch               allmodconfig    clang-19
loongarch               allmodconfig    clang-24
loongarch                allnoconfig    clang-20
loongarch                  defconfig    clang-24
loongarch   randconfig-1000-20261019    clang-24
loongarch   randconfig-1001-20261019    clang-24
m68k                    allmodconfig    gcc-16.2.0
m68k                     allnoconfig    gcc-16.2.0
m68k                    allyesconfig    gcc-16.2.0
m68k                       defconfig    clang-24
m68k              m5208evb_defconfig    gcc-16.2.0
microblaze               allnoconfig    gcc-16.2.0
microblaze              allyesconfig    gcc-16.2.0
microblaze                 defconfig    clang-24
mips                    allmodconfig    gcc-16.2.0
mips                     allnoconfig    gcc-16.2.0
mips                    allyesconfig    gcc-16.2.0
mips          sb1250_swarm_defconfig    gcc-16.2.0
nios2                   allmodconfig    gcc-11.5.0
nios2                    allnoconfig    clang-24
nios2                    allnoconfig    gcc-11.5.0
nios2                      defconfig    clang-24
nios2       randconfig-1000-20261019    clang-24
nios2       randconfig-1001-20261019    clang-24
openrisc                allmodconfig    gcc-16.2.0
openrisc                 allnoconfig    clang-24
openrisc                 allnoconfig    gcc-16.2.0
openrisc                   defconfig    gcc-16.2.0
openrisc         or1klitex_defconfig    gcc-16.2.0
parisc                  allmodconfig    gcc-16.2.0
parisc                   allnoconfig    clang-24
parisc                   allnoconfig    gcc-16.2.0
parisc                  allyesconfig    clang-17
parisc                  allyesconfig    gcc-16.2.0
parisc                     defconfig    gcc-16.2.0
parisc      randconfig-1000-20261019    gcc-8.5.0
parisc      randconfig-1001-20261019    gcc-8.5.0
parisc64                   defconfig    clang-24
powerpc                 allmodconfig    gcc-16.2.0
powerpc                  allnoconfig    clang-24
powerpc                  allnoconfig    gcc-16.2.0
powerpc              ppc64_defconfig    gcc-16.2.0
powerpc             ppc64e_defconfig    gcc-16.2.0
powerpc     randconfig-1000-20261019    gcc-8.5.0
powerpc     randconfig-1001-20261019    gcc-8.5.0
powerpc64   randconfig-1000-20261019    gcc-8.5.0
powerpc64   randconfig-1001-20261019    gcc-8.5.0
riscv                   allmodconfig    clang-24
riscv                    allnoconfig    clang-24
riscv                    allnoconfig    gcc-16.2.0
riscv                   allyesconfig    clang-24
riscv                      defconfig    gcc-16.2.0
riscv       randconfig-1000-20261019    gcc-11.5.0
riscv       randconfig-1001-20261019    gcc-11.5.0
s390                    allmodconfig    clang-17
s390                    allmodconfig    clang-24
s390                     allnoconfig    clang-24
s390                    allyesconfig    gcc-16.2.0
s390                       defconfig    gcc-16.2.0
s390        randconfig-1000-20261019    gcc-11.5.0
s390        randconfig-1001-20261019    gcc-11.5.0
sh                      allmodconfig    gcc-16.2.0
sh                       allnoconfig    clang-24
sh                       allnoconfig    gcc-16.2.0
sh                      allyesconfig    clang-17
sh                      allyesconfig    gcc-16.2.0
sh                         defconfig    gcc-14
sh                      j2_defconfig    gcc-16.2.0
sh          randconfig-1000-20261019    gcc-11.5.0
sh          randconfig-1001-20261019    gcc-11.5.0
sh                  se7619_defconfig    gcc-16.2.0
sparc                    allnoconfig    clang-24
sparc                    allnoconfig    gcc-16.2.0
sparc                      defconfig    gcc-16.2.0
sparc64                 allmodconfig    clang-20
sparc64                    defconfig    gcc-14
um                      allmodconfig    clang-17
um                       allnoconfig    clang-17
um                       allnoconfig    clang-24
um                      allyesconfig    gcc-14
um                      allyesconfig    gcc-16.2.0
um                         defconfig    gcc-14
um                    i386_defconfig    gcc-14
um                  x86_64_defconfig    gcc-14
x86_64                   allnoconfig    clang-22
x86_64                   allnoconfig    clang-24
x86_64                     defconfig    gcc-14
x86_64                  rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-kunit    gcc-14
x86_64                  rhel-9.4-ltp    gcc-14
x86_64                 rhel-9.4-rust    clang-22
xtensa                   allnoconfig    clang-24
xtensa                   allnoconfig    gcc-16.2.0
xtensa                  allyesconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
