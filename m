Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795347447;
	b=0KkgZmFvWAVFqj8y7KbKFxvsdg00iSC9O20o/xqPEkxXaXF/qy6ma6q/OtuuLDtldY6W
	 QaHzrsGT7biUHz4VtCEpMB2r4pTpDcqzCF3tNvdZQo5qEISg/TK8L0vbt+S+hJeYbA2vH
	 opBz8RtmTsi2hqXCyw7l4EMHL8airMdCMv0PK09DTJxFyr4oxqdIlrm25kkmt7iVRCvDV
	 788tHt3h8uXLJjgzcTD6vXci1MiVWZpf7CABqsLqDeNaBUoRNrOFtyd6Yp3S6B18erAPC
	 2uNupUD5SeSE5WBArarh5G9kPqpuIwQbgLOiiye/1XUQ2In0LgBuHlbDAEg6C0b2oDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795347447;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=FsG+75OlCp3n2/HY9EecrXAJrqc5mUQQq+FqVgMrl5o=;
	b=PW2Dtbs0Nuevjo//fzBfWOPiceWCu7kAHTVo8nYgpcYLIu4MueEcYQ3GukoW+60S8Ope
	 DqMpBhmsQY0Tj5aMk0vNLX0eHywDIJ6FDV2yXhy5o9tr7we2k6fGIrJYBEKff6F2v904m
	 yuUbFIc9WxUzHvTuo6WLweVflGYXfnyD1giHwSa1XGWnzB0++9rGEGONGFNte3fX9L6jV
	 lCapnPvOJS2xdbgS8FRVcUwZn7e5WE2fqIdEmFE+pnm114igeMfOseqDznbulOcLfrnMz
	 3igDe5i4cgChhGRmTiwxK4gPtQXWe7oTMY07BmvQKa9WEq02+i+IkmkZKazSl3bXKBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XN1CGBiX;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DAD606A320
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 11:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63DAD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XN1CGBiX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795347447; x=1826883447;
  h=date:from:to:cc:subject:message-id;
  bh=pNJouPO2bdeD2O23pkWdfckUinykSkR1kKiP+BLNNOM=;
  b=XN1CGBiXnWc2FT4jMeuktRHhPl43VEvOi01hHogXYafTbyJW8eoI2sfm
   Y+jc4WgdubN/zacqKHz7bzDw9ghNi2b2YBtMejKM4KR+CoQIYVCqtSA1T
   mcddZp9v+S9IpcTDUDEeLRFaeZF01TMwxmZRVeUP+titx1YgCiPC7r7o9
   YclJxx673YFnrCu2rNSRyHNBNGTVkYVqK6Opbp/ivMNRxA39RXFALU/7k
   inhk4WHlgZp0t7/w129fr1UiFcepyU9PXxPdma434hq8yTkdKS8tU6nUR
   +IlQE1KD13x2pVrsv1v6Bxk1x4k0VLekno/L72qGO9NC9YbRD4gSOip5c
   g==;
X-CSE-ConnectionGUID: vVTFWXCES3yIGMWLzQIQnA==
X-CSE-MsgGUID: XC4iMUmpSjKStqF+fdaqZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11973"; a="4066360"
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; 
   d="scan'208";a="4066360"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 03:37:26 -0800
X-CSE-ConnectionGUID: vIXU8GyjQoaxBtXaoRqEew==
X-CSE-MsgGUID: J2ptOkJ/R/evSaCJzu7Quw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; 
   d="scan'208";a="11157709"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 22 Nov 2026 03:37:24 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xV5so-00000001LRW-19HC;
	Sun, 22 Nov 2026 11:37:22 +0000
Date: Sun, 22 Nov 2026 19:36:26 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:p2pdma] BUILD SUCCESS
 ddf4e7a4d89b7fcc23fd2dc59131799bc614b4a9
Message-ID: <20261122193626.IIo1qUsM-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git p2pdma
branch HEAD: ddf4e7a4d89b7fcc23fd2dc59131799bc614b4a9  PCI/P2PDMA: Test the routing of clients with ATS enabled

elapsed time: 876m

configs tested: 533
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261121    gcc-14.4.0
alpha                 randconfig-2000-20261122    gcc-8.5.0
alpha                 randconfig-2001-20261121    gcc-14.4.0
alpha                 randconfig-2001-20261122    gcc-8.5.0
alpha                 randconfig-2200-20261121    gcc-10.5.0 smatch
alpha                randconfig-r2100-20261121    gcc-8.5.0  cocci
alpha                randconfig-r2106-20261121    clang-22   cocci
alpha                randconfig-r2106-20261121    gcc-11.5.0 cocci
alpha                randconfig-r2110-20261121    gcc-11.5.0 cocci
alpha                randconfig-r2111-20261121    gcc-13.5.0 cocci
alpha                randconfig-r2301-20261121    gcc-14     sparse
alpha                randconfig-r2304-20261122    clang-24   sparse
alpha                randconfig-r2308-20261121    gcc-8.5.0  sparse
alpha                randconfig-r2308-20261122    gcc-13.5.0 sparse
alpha                randconfig-r2309-20261121    gcc-11.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261122    clang-17
arc                   randconfig-1001-20261122    clang-17
arc                   randconfig-2000-20261121    gcc-8.5.0
arc                   randconfig-2001-20261121    gcc-8.5.0
arc                   randconfig-2002-20261121    gcc-8.5.0
arc                   randconfig-2003-20261121    gcc-8.5.0
arc                   randconfig-2004-20261121    gcc-8.5.0
arc                   randconfig-2005-20261121    gcc-8.5.0
arc                   randconfig-2200-20261121    gcc-14.4.0 smatch
arc                  randconfig-r2101-20261121    gcc-9.5.0  cocci
arc                  randconfig-r2103-20261121    clang-24   cocci
arc                  randconfig-r2109-20261121    gcc-8.5.0  cocci
arc                  randconfig-r2110-20261121    clang-22   cocci
arc                  randconfig-r2111-20261121    clang-22   cocci
arc                  randconfig-r2111-20261121    gcc-14.4.0 cocci
arc                  randconfig-r2300-20261121    clang-24   sparse
arc                  randconfig-r2303-20261121    clang-24   sparse
arc                  randconfig-r2310-20261121    clang-22   sparse
arc                  randconfig-r2310-20261121    gcc-10.5.0 sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                            h3600_defconfig    clang-17
arm                   randconfig-1000-20261122    clang-17
arm                   randconfig-1001-20261122    clang-17
arm                   randconfig-1002-20261122    clang-17
arm                   randconfig-1003-20261122    clang-17
arm                   randconfig-2000-20261121    clang-24
arm                   randconfig-2001-20261121    clang-24
arm                   randconfig-2002-20261121    clang-24
arm                   randconfig-2200-20261121    clang-19   smatch
arm                  randconfig-r2100-20261121    clang-24   cocci
arm                  randconfig-r2106-20261121    clang-22   cocci
arm                  randconfig-r2106-20261121    clang-24   cocci
arm                  randconfig-r2106-20261121    gcc-11.5.0 cocci
arm                  randconfig-r2300-20261121    gcc-14     sparse
arm                  randconfig-r2307-20261121    clang-22   sparse
arm                  randconfig-r2308-20261121    gcc-8.5.0  sparse
arm                         shmobile_defconfig    clang-17
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261122    gcc-8.5.0
arm64                 randconfig-1001-20261122    gcc-8.5.0
arm64                 randconfig-1002-20261122    gcc-8.5.0
arm64                 randconfig-1003-20261122    gcc-8.5.0
arm64                 randconfig-2000-20261121    clang-24
arm64                 randconfig-2001-20261121    clang-24
arm64                 randconfig-2002-20261121    clang-24
arm64                 randconfig-2200-20261121    clang-22   smatch
arm64                randconfig-r2102-20261121    gcc-9.5.0  cocci
arm64                randconfig-r2104-20261121    gcc-9.5.0  cocci
arm64                randconfig-r2105-20261121    gcc-16.2.0 cocci
arm64                randconfig-r2111-20261121    clang-24   cocci
arm64                randconfig-r2301-20261121    gcc-11.5.0 sparse
arm64                randconfig-r2301-20261121    gcc-16.2.0 sparse
arm64                randconfig-r2304-20261121    gcc-16.2.0 sparse
arm64                randconfig-r2305-20261121    clang-24   sparse
arm64                randconfig-r2307-20261121    gcc-10.5.0 sparse
arm64                randconfig-r2309-20261121    gcc-16.2.0 sparse
arm64                randconfig-r2310-20261121    gcc-13.5.0 sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261122    gcc-8.5.0
csky                  randconfig-1001-20261122    gcc-8.5.0
csky                  randconfig-2000-20261121    gcc-16.2.0
csky                  randconfig-2001-20261121    gcc-16.2.0
csky                  randconfig-2200-20261121    gcc-16.2.0 smatch
csky                 randconfig-r2100-20261121    gcc-10.5.0 cocci
csky                 randconfig-r2101-20261121    gcc-16.2.0 cocci
csky                 randconfig-r2101-20261122    gcc-14     cocci
csky                 randconfig-r2103-20261121    clang-24   cocci
csky                 randconfig-r2105-20261122    gcc-14     cocci
csky                 randconfig-r2109-20261121    gcc-11.5.0 cocci
csky                 randconfig-r2109-20261121    gcc-13.5.0 cocci
csky                 randconfig-r2111-20261121    clang-24   cocci
csky                 randconfig-r2300-20261121    clang-24   sparse
csky                 randconfig-r2303-20261121    gcc-14     sparse
csky                 randconfig-r2306-20261121    gcc-10.5.0 sparse
csky                 randconfig-r2307-20261121    gcc-11.5.0 sparse
csky                 randconfig-r2308-20261121    gcc-13.5.0 sparse
csky                 randconfig-r2309-20261122    gcc-13.5.0 sparse
csky                 randconfig-r2310-20261121    gcc-12.5.0 sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261122    gcc-8.5.0
hexagon               randconfig-1001-20261122    gcc-8.5.0
hexagon               randconfig-2000-20261121    gcc-16.2.0
hexagon               randconfig-2001-20261121    gcc-16.2.0
hexagon               randconfig-2200-20261121    clang-24   smatch
hexagon              randconfig-r2102-20261122    gcc-14     cocci
hexagon              randconfig-r2104-20261121    gcc-16.2.0 cocci
hexagon              randconfig-r2107-20261121    clang-22   cocci
hexagon              randconfig-r2107-20261121    gcc-16.2.0 cocci
hexagon              randconfig-r2108-20261121    gcc-14.4.0 cocci
hexagon              randconfig-r2300-20261121    clang-24   sparse
hexagon              randconfig-r2303-20261121    clang-24   sparse
hexagon              randconfig-r2304-20261121    gcc-14     sparse
hexagon              randconfig-r2305-20261121    gcc-16.2.0 sparse
hexagon              randconfig-r2306-20261121    gcc-13.5.0 sparse
hexagon              randconfig-r2309-20261121    clang-20   sparse
hexagon              randconfig-r2309-20261121    gcc-8.5.0  sparse
hexagon              randconfig-r2310-20261121    gcc-8.5.0  sparse
hexagon              randconfig-r2311-20261121    gcc-8.5.0  sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261122    gcc-14
i386        buildonly-randconfig-1001-20261122    gcc-14
i386        buildonly-randconfig-1002-20261122    gcc-14
i386        buildonly-randconfig-1003-20261122    gcc-14
i386        buildonly-randconfig-1004-20261122    gcc-14
i386        buildonly-randconfig-1005-20261122    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261122    gcc-14
i386                  randconfig-1001-20261122    gcc-14
i386                  randconfig-1002-20261122    gcc-14
i386                  randconfig-1003-20261122    gcc-14
i386                  randconfig-1004-20261122    gcc-14
i386                  randconfig-1005-20261122    gcc-14
i386                  randconfig-1006-20261122    gcc-14
i386                  randconfig-1007-20261122    gcc-14
i386                  randconfig-1008-20261122    gcc-14
i386                  randconfig-1009-20261122    gcc-14
i386                  randconfig-1010-20261122    gcc-14
i386                  randconfig-1011-20261122    gcc-14
i386                  randconfig-1012-20261122    gcc-14
i386                  randconfig-1013-20261122    gcc-14
i386                  randconfig-2000-20261121    gcc-14
i386                  randconfig-2001-20261121    gcc-14
i386                  randconfig-2002-20261121    gcc-14
i386                  randconfig-2003-20261121    gcc-14
i386                  randconfig-2004-20261121    gcc-14
i386                  randconfig-2005-20261121    gcc-14
i386                  randconfig-2100-20261121    clang-22   cocci
i386                  randconfig-2101-20261121    clang-22   cocci
i386                  randconfig-2102-20261121    clang-22   cocci
i386                  randconfig-2103-20261121    clang-22   cocci
i386                  randconfig-2104-20261121    clang-22   cocci
i386                  randconfig-2105-20261121    clang-22   cocci
i386                  randconfig-2200-20261121    clang-22   smatch
i386                  randconfig-2300-20261121    gcc-14     sparse
i386                  randconfig-2301-20261121    gcc-14     sparse
i386                  randconfig-2302-20261121    gcc-14     sparse
i386                 randconfig-r2103-20261121    gcc-10.5.0 cocci
i386                 randconfig-r2104-20261122    gcc-14     cocci
i386                 randconfig-r2107-20261121    clang-22   cocci
i386                 randconfig-r2109-20261121    clang-22   cocci
i386                 randconfig-r2111-20261121    clang-22   cocci
i386                 randconfig-r2300-20261121    gcc-16.2.0 sparse
i386                 randconfig-r2304-20261121    clang-24   sparse
i386                 randconfig-r2306-20261122    gcc-13.5.0 sparse
i386                 randconfig-r2311-20261121    gcc-10.5.0 sparse
i386                 randconfig-r2311-20261122    gcc-13.5.0 sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261122    gcc-8.5.0
loongarch             randconfig-1001-20261122    gcc-8.5.0
loongarch             randconfig-2000-20261121    clang-22
loongarch             randconfig-2001-20261121    clang-22
loongarch             randconfig-2200-20261121    gcc-16.2.0 smatch
loongarch            randconfig-r2101-20261121    gcc-16.2.0 cocci
loongarch            randconfig-r2102-20261121    gcc-16.2.0 cocci
loongarch            randconfig-r2103-20261121    gcc-9.5.0  cocci
loongarch            randconfig-r2110-20261121    clang-22   cocci
loongarch            randconfig-r2111-20261121    gcc-11.5.0 cocci
loongarch            randconfig-r2302-20261121    clang-24   sparse
loongarch            randconfig-r2303-20261121    clang-21   sparse
loongarch            randconfig-r2306-20261121    clang-20   sparse
loongarch            randconfig-r2306-20261121    clang-22   sparse
loongarch            randconfig-r2307-20261122    gcc-13.5.0 sparse
loongarch            randconfig-r2309-20261121    gcc-13.5.0 sparse
loongarch            randconfig-r2311-20261121    gcc-13.5.0 sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5329evb_defconfig    clang-17
m68k                  randconfig-2000-20261121    gcc-14.4.0
m68k                  randconfig-2000-20261122    gcc-8.5.0
m68k                  randconfig-2001-20261121    gcc-14.4.0
m68k                  randconfig-2001-20261122    gcc-8.5.0
m68k                  randconfig-2200-20261121    gcc-8.5.0  smatch
m68k                 randconfig-r2103-20261121    gcc-9.5.0  cocci
m68k                 randconfig-r2106-20261121    gcc-16.2.0 cocci
m68k                 randconfig-r2107-20261121    clang-24   cocci
m68k                 randconfig-r2111-20261121    gcc-11.5.0 cocci
m68k                 randconfig-r2303-20261121    gcc-16.2.0 sparse
m68k                 randconfig-r2310-20261122    gcc-13.5.0 sparse
m68k                 randconfig-r2311-20261121    gcc-8.5.0  sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261121    gcc-14.4.0
microblaze            randconfig-2000-20261122    gcc-8.5.0
microblaze            randconfig-2001-20261121    gcc-14.4.0
microblaze            randconfig-2001-20261122    gcc-8.5.0
microblaze            randconfig-2200-20261121    gcc-8.5.0  smatch
microblaze           randconfig-r2102-20261121    gcc-10.5.0 cocci
microblaze           randconfig-r2105-20261121    gcc-10.5.0 cocci
microblaze           randconfig-r2109-20261121    clang-24   cocci
microblaze           randconfig-r2109-20261121    gcc-11.5.0 cocci
microblaze           randconfig-r2307-20261121    gcc-16.2.0 sparse
microblaze           randconfig-r2309-20261121    gcc-8.5.0  sparse
microblaze           randconfig-r2310-20261121    gcc-16.2.0 sparse
microblaze           randconfig-r2311-20261121    clang-20   sparse
microblaze           randconfig-r2311-20261121    clang-22   sparse
microblaze           randconfig-r2311-20261121    gcc-11.5.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                            mtx1_defconfig    clang-17
mips                  randconfig-2000-20261121    gcc-16.2.0
mips                  randconfig-2001-20261121    gcc-16.2.0
mips                  randconfig-2002-20261121    gcc-16.2.0
mips                  randconfig-2200-20261121    clang-21   smatch
mips                 randconfig-r2105-20261121    clang-24   cocci
mips                 randconfig-r2109-20261121    clang-24   cocci
mips                 randconfig-r2110-20261121    gcc-14.4.0 cocci
mips                 randconfig-r2301-20261121    clang-24   sparse
mips                 randconfig-r2304-20261121    clang-24   sparse
mips                 randconfig-r2305-20261121    clang-24   sparse
mips                 randconfig-r2306-20261121    gcc-16.2.0 sparse
mips                 randconfig-r2308-20261121    clang-20   sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261122    gcc-8.5.0
nios2                 randconfig-1001-20261122    gcc-8.5.0
nios2                 randconfig-2000-20261121    clang-22
nios2                 randconfig-2001-20261121    clang-22
nios2                 randconfig-2200-20261121    gcc-10.5.0 smatch
nios2                randconfig-r2101-20261121    gcc-8.5.0  cocci
nios2                randconfig-r2104-20261121    gcc-10.5.0 cocci
nios2                randconfig-r2104-20261121    gcc-16.2.0 cocci
nios2                randconfig-r2106-20261121    gcc-13.5.0 cocci
nios2                randconfig-r2107-20261121    gcc-11.5.0 cocci
nios2                randconfig-r2108-20261121    gcc-11.5.0 cocci
nios2                randconfig-r2305-20261121    clang-21   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261121    gcc-16.2.0
openrisc              randconfig-2001-20261121    gcc-16.2.0
openrisc              randconfig-2002-20261121    gcc-16.2.0
openrisc              randconfig-2200-20261121    gcc-14.4.0 smatch
openrisc              randconfig-2200-20261122    gcc-16.2.0 smatch
openrisc             randconfig-r2104-20261121    gcc-8.5.0  cocci
openrisc             randconfig-r2105-20261121    gcc-9.5.0  cocci
openrisc             randconfig-r2110-20261121    clang-24   cocci
openrisc             randconfig-r2302-20261122    clang-24   sparse
openrisc             randconfig-r2303-20261121    gcc-11.5.0 sparse
openrisc             randconfig-r2304-20261121    clang-24   sparse
openrisc             randconfig-r2306-20261121    gcc-8.5.0  sparse
openrisc             randconfig-r2308-20261121    gcc-10.5.0 sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261122    clang-24
parisc                randconfig-1001-20261122    clang-24
parisc                randconfig-2000-20261121    clang-22
parisc                randconfig-2001-20261121    clang-22
parisc                randconfig-2200-20261121    gcc-16.2.0 smatch
parisc               randconfig-r2101-20261121    gcc-10.5.0 cocci
parisc               randconfig-r2102-20261121    gcc-16.2.0 cocci
parisc               randconfig-r2103-20261121    gcc-16.2.0 cocci
parisc               randconfig-r2103-20261121    gcc-8.5.0  cocci
parisc               randconfig-r2107-20261121    gcc-13.5.0 cocci
parisc               randconfig-r2108-20261121    clang-22   cocci
parisc               randconfig-r2108-20261121    gcc-11.5.0 cocci
parisc               randconfig-r2108-20261121    gcc-8.5.0  cocci
parisc               randconfig-r2109-20261121    clang-22   cocci
parisc               randconfig-r2110-20261121    clang-22   cocci
parisc               randconfig-r2301-20261121    clang-21   sparse
parisc               randconfig-r2303-20261121    clang-24   sparse
parisc               randconfig-r2306-20261121    gcc-11.5.0 sparse
parisc               randconfig-r2307-20261121    gcc-13.5.0 sparse
parisc               randconfig-r2308-20261121    gcc-12.5.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                   mpc866_ads_defconfig    clang-17
powerpc               randconfig-1000-20261122    clang-24
powerpc               randconfig-1001-20261122    clang-24
powerpc               randconfig-2000-20261121    clang-24
powerpc               randconfig-2001-20261121    clang-24
powerpc               randconfig-2002-20261121    clang-24
powerpc               randconfig-2200-20261121    gcc-11.5.0 smatch
powerpc              randconfig-r2101-20261121    clang-24   cocci
powerpc              randconfig-r2102-20261121    gcc-9.5.0  cocci
powerpc              randconfig-r2107-20261121    gcc-11.5.0 cocci
powerpc              randconfig-r2301-20261121    clang-24   sparse
powerpc              randconfig-r2301-20261122    clang-24   sparse
powerpc              randconfig-r2303-20261122    clang-24   sparse
powerpc              randconfig-r2305-20261122    clang-24   sparse
powerpc              randconfig-r2308-20261121    gcc-16.2.0 sparse
powerpc              randconfig-r2309-20261121    gcc-10.5.0 sparse
powerpc                      sequoia_defconfig    clang-17
powerpc64             randconfig-1000-20261122    clang-24
powerpc64             randconfig-1001-20261122    clang-24
powerpc64             randconfig-2000-20261121    clang-24
powerpc64             randconfig-2001-20261121    clang-24
powerpc64             randconfig-2002-20261121    clang-24
powerpc64             randconfig-2200-20261121    gcc-10.5.0 smatch
powerpc64            randconfig-r2102-20261121    gcc-8.5.0  cocci
powerpc64            randconfig-r2109-20261121    gcc-14.4.0 cocci
powerpc64            randconfig-r2304-20261121    gcc-11.5.0 sparse
powerpc64            randconfig-r2306-20261121    gcc-8.5.0  sparse
powerpc64            randconfig-r2307-20261121    gcc-12.5.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261122    gcc-9.5.0
riscv                 randconfig-1001-20261122    gcc-9.5.0
riscv                 randconfig-2000-20261121    gcc-9.5.0
riscv                 randconfig-2001-20261121    gcc-9.5.0
riscv                 randconfig-2002-20261121    gcc-9.5.0
riscv                 randconfig-2003-20261121    gcc-9.5.0
riscv                 randconfig-2004-20261121    gcc-9.5.0
riscv                 randconfig-2005-20261121    gcc-9.5.0
riscv                 randconfig-2200-20261121    clang-24   smatch
riscv                randconfig-r2101-20261121    clang-24   cocci
riscv                randconfig-r2102-20261121    clang-24   cocci
riscv                randconfig-r2107-20261121    clang-24   cocci
riscv                randconfig-r2107-20261121    gcc-8.5.0  cocci
riscv                randconfig-r2108-20261121    clang-24   cocci
riscv                randconfig-r2310-20261121    gcc-8.5.0  sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261122    gcc-9.5.0
s390                  randconfig-1001-20261122    gcc-9.5.0
s390                  randconfig-2000-20261121    clang-22
s390                  randconfig-2001-20261121    clang-22
s390                  randconfig-2002-20261121    clang-22
s390                  randconfig-2003-20261121    clang-22
s390                  randconfig-2004-20261121    clang-22
s390                  randconfig-2005-20261121    clang-22
s390                  randconfig-2200-20261121    gcc-8.5.0  smatch
s390                 randconfig-r2100-20261121    clang-24   cocci
s390                 randconfig-r2100-20261121    gcc-9.5.0  cocci
s390                 randconfig-r2101-20261121    gcc-9.5.0  cocci
s390                 randconfig-r2102-20261121    clang-24   cocci
s390                 randconfig-r2104-20261121    clang-24   cocci
s390                 randconfig-r2105-20261121    gcc-9.5.0  cocci
s390                 randconfig-r2106-20261121    clang-22   cocci
s390                 randconfig-r2106-20261121    gcc-14.4.0 cocci
s390                 randconfig-r2108-20261121    clang-24   cocci
s390                 randconfig-r2110-20261121    gcc-11.5.0 cocci
s390                 randconfig-r2110-20261121    gcc-13.5.0 cocci
s390                 randconfig-r2111-20261121    gcc-16.2.0 cocci
s390                 randconfig-r2301-20261121    clang-24   sparse
s390                 randconfig-r2303-20261121    clang-24   sparse
s390                 randconfig-r2305-20261121    clang-24   sparse
s390                 randconfig-r2307-20261121    gcc-8.5.0  sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261122    gcc-9.5.0
sh                    randconfig-1001-20261122    gcc-9.5.0
sh                    randconfig-2000-20261121    gcc-16.2.0
sh                    randconfig-2000-20261122    gcc-13.5.0
sh                    randconfig-2001-20261121    gcc-16.2.0
sh                    randconfig-2001-20261122    gcc-13.5.0
sh                    randconfig-2002-20261121    gcc-16.2.0
sh                    randconfig-2002-20261122    gcc-13.5.0
sh                    randconfig-2003-20261121    gcc-16.2.0
sh                    randconfig-2003-20261122    gcc-13.5.0
sh                    randconfig-2004-20261121    gcc-16.2.0
sh                    randconfig-2004-20261122    gcc-13.5.0
sh                    randconfig-2005-20261121    gcc-16.2.0
sh                    randconfig-2005-20261122    gcc-13.5.0
sh                    randconfig-2200-20261121    gcc-10.5.0 smatch
sh                   randconfig-r2110-20261121    clang-24   cocci
sh                   randconfig-r2110-20261121    gcc-8.5.0  cocci
sh                   randconfig-r2300-20261121    clang-21   sparse
sh                   randconfig-r2311-20261121    gcc-16.2.0 sparse
sh                      sh7710voipgw_defconfig    clang-17
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261122    clang-24
sparc                 randconfig-1001-20261122    clang-24
sparc                 randconfig-2000-20261121    gcc-8.5.0
sparc                 randconfig-2001-20261121    gcc-8.5.0
sparc                 randconfig-2200-20261121    gcc-8.5.0  smatch
sparc                randconfig-r2100-20261121    gcc-16.2.0 cocci
sparc                randconfig-r2105-20261121    gcc-8.5.0  cocci
sparc                randconfig-r2107-20261121    gcc-14.4.0 cocci
sparc                randconfig-r2108-20261121    clang-22   cocci
sparc                randconfig-r2304-20261121    clang-24   sparse
sparc                randconfig-r2310-20261121    clang-20   sparse
sparc                randconfig-r2310-20261121    gcc-11.5.0 sparse
sparc                randconfig-r2311-20261121    gcc-12.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261122    clang-24
sparc64               randconfig-1001-20261122    clang-24
sparc64               randconfig-2000-20261121    gcc-8.5.0
sparc64               randconfig-2001-20261121    gcc-8.5.0
sparc64               randconfig-2200-20261121    clang-20   smatch
sparc64              randconfig-r2104-20261121    clang-24   cocci
sparc64              randconfig-r2106-20261121    clang-24   cocci
sparc64              randconfig-r2108-20261121    gcc-16.2.0 cocci
sparc64              randconfig-r2110-20261121    gcc-16.2.0 cocci
sparc64              randconfig-r2300-20261122    clang-24   sparse
sparc64              randconfig-r2302-20261121    clang-24   sparse
sparc64              randconfig-r2302-20261121    gcc-11.5.0 sparse
sparc64              randconfig-r2307-20261121    gcc-8.5.0  sparse
sparc64              randconfig-r2308-20261121    clang-22   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261122    clang-24
um                    randconfig-1001-20261122    clang-24
um                    randconfig-2000-20261121    gcc-8.5.0
um                    randconfig-2001-20261121    gcc-8.5.0
um                    randconfig-2200-20261121    gcc-14     smatch
um                   randconfig-r2104-20261121    gcc-9.5.0  cocci
um                   randconfig-r2106-20261121    gcc-8.5.0  cocci
um                   randconfig-r2108-20261121    gcc-13.5.0 cocci
um                   randconfig-r2302-20261121    clang-21   sparse
um                   randconfig-r2302-20261121    clang-24   sparse
um                   randconfig-r2304-20261121    clang-21   sparse
um                   randconfig-r2308-20261121    gcc-11.5.0 sparse
um                   randconfig-r2309-20261121    gcc-12.5.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261122    gcc-14
x86_64                randconfig-1001-20261122    gcc-14
x86_64                randconfig-1002-20261122    gcc-14
x86_64                randconfig-1003-20261122    gcc-14
x86_64                randconfig-1004-20261122    gcc-14
x86_64                randconfig-1005-20261122    gcc-14
x86_64                randconfig-1006-20261122    gcc-14
x86_64                randconfig-1007-20261122    gcc-14
x86_64                randconfig-1008-20261122    gcc-14
x86_64                randconfig-1009-20261122    gcc-14
x86_64                randconfig-1010-20261122    gcc-14
x86_64                randconfig-1011-20261122    gcc-14
x86_64                randconfig-1012-20261122    clang-22
x86_64                randconfig-1013-20261122    clang-22
x86_64                randconfig-1014-20261122    clang-22
x86_64                randconfig-1015-20261122    clang-22
x86_64                randconfig-1016-20261122    clang-22
x86_64                randconfig-1017-20261122    clang-22
x86_64                randconfig-2000-20261121    gcc-14
x86_64                randconfig-2001-20261121    gcc-14
x86_64                randconfig-2002-20261121    gcc-14
x86_64                randconfig-2003-20261121    gcc-14
x86_64                randconfig-2004-20261121    gcc-14
x86_64                randconfig-2005-20261121    gcc-14
x86_64                randconfig-2100-20261121    gcc-14     cocci
x86_64                randconfig-2101-20261121    gcc-14     cocci
x86_64                randconfig-2102-20261121    gcc-14     cocci
x86_64                randconfig-2103-20261121    gcc-14     cocci
x86_64                randconfig-2104-20261121    gcc-14     cocci
x86_64                randconfig-2105-20261121    gcc-14     cocci
x86_64                randconfig-2200-20261121    gcc-14     smatch
x86_64                randconfig-2300-20261121    gcc-14     sparse
x86_64                randconfig-2301-20261121    gcc-14     sparse
x86_64                randconfig-2302-20261121    gcc-14     sparse
x86_64               randconfig-r2103-20261122    gcc-14     cocci
x86_64               randconfig-r2107-20261121    clang-22   cocci
x86_64               randconfig-r2109-20261121    gcc-16.2.0 cocci
x86_64               randconfig-r2300-20261121    gcc-11.5.0 sparse
x86_64               randconfig-r2302-20261121    gcc-16.2.0 sparse
x86_64               randconfig-r2305-20261121    gcc-14     sparse
x86_64               randconfig-r2306-20261121    gcc-12.5.0 sparse
x86_64               randconfig-r2307-20261121    clang-20   sparse
x86_64               randconfig-r2309-20261121    clang-22   sparse
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
xtensa                   nommu_kc705_defconfig    clang-17
xtensa                randconfig-1000-20261122    clang-24
xtensa                randconfig-1001-20261122    clang-24
xtensa                randconfig-2000-20261121    gcc-16.2.0
xtensa                randconfig-2001-20261121    gcc-16.2.0
xtensa                randconfig-2200-20261121    gcc-12.5.0 smatch
xtensa                randconfig-2200-20261122    gcc-11.5.0 smatch
xtensa               randconfig-r2100-20261121    gcc-9.5.0  cocci
xtensa               randconfig-r2100-20261122    gcc-14     cocci
xtensa               randconfig-r2105-20261121    gcc-16.2.0 cocci
xtensa               randconfig-r2108-20261121    clang-22   cocci
xtensa               randconfig-r2111-20261121    clang-22   cocci
xtensa               randconfig-r2111-20261121    gcc-8.5.0  cocci
xtensa               randconfig-r2302-20261121    gcc-14     sparse
xtensa               randconfig-r2305-20261121    gcc-11.5.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
