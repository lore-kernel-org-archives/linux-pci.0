Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6F935972
	for <linux-pci@vger.kernel.org>; Sat, 18 Jul 2026 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784357049; cv=none; b=sg1Zwd10qRdibbT8v2ne8Rcbk+xcAh8HtSqlT/tLVrdY8D5cKSPyn0QgO+iNkILD0Lg/WqeAVlU36aMnIz8G0okrqrucVPzNZDHtOAg1dTIob7ZEfLbE+WgFMD45iMpqsP+WfZ6/evh00hCcnJxKZu8rTkWSB03i0zEUFe0PH54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784357049; c=relaxed/simple;
	bh=yFYBaM+omfcNAai/0TcEcrlDfUNe7wf5ffdfkTUiBKo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s1HeOggNiWniJAySQcRJuZvCR4iNaY+8d0G3YdKVIvFLOvmSpJYQM2XDIKNF9qRyeHhcqu7Mo3lguMFtNT7vJo7jqKOmnd5fI7Y0cIXCndGcYoKuyRvlircJ6ONWk3tilI+yFeZ5B1T1wTbL/W7b8j7rviGdaJE027UA4nm9jhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOlIJsvs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOlIJsvs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784357047; x=1815893047;
  h=date:from:to:cc:subject:message-id;
  bh=yFYBaM+omfcNAai/0TcEcrlDfUNe7wf5ffdfkTUiBKo=;
  b=FOlIJsvsVXyVKm3A/gHWucCM/WN0+6g6Z7eW8300ohpqXMSg0NtV9jdz
   9dIgsvVxcRe+/9D28Wig5Lo+iptJ1xsoVbYOmF7s3/TfeFCrluv608KOQ
   LcgeWbDojI1t+oX44PN4UM/5uxCapdH77XDb6ulN0obrRyUXC38ZH7vpW
   uE6P+A9bvEPpXTHbLb38Wg2dDt9X/8r3Z74eUCcmI2V4+fRcwV5GQS+rr
   6YK3pq1PGlaQU64b1hKDvpXfwmiUZZR1/Pj5nx5Vcp70u4Rdr5kuGYHw+
   1A1P7xC17D1F6cNbwZsdlelkfG06lJlXGMR5AMMgxia41Hzv4tZHWzCaA
   A==;
X-CSE-ConnectionGUID: iAiX55YCQwep0sTkJQJQBQ==
X-CSE-MsgGUID: aB1mYfhYRIaOBFnrDHvZFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85219165"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="85219165"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 23:44:07 -0700
X-CSE-ConnectionGUID: CbeMva5FRji1wFKd+HVEJw==
X-CSE-MsgGUID: 2V0bImvFS2i2Tb8PC2mh0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="256410028"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 17 Jul 2026 23:44:06 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkym8-00000000TX1-3JwO;
	Sat, 18 Jul 2026 06:43:55 +0000
Date: Sat, 18 Jul 2026 14:43:20 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:switchtec] BUILD SUCCESS
 00a479ba1d01249d43ca5e453380d1ed60946f8a
Message-ID: <202607181408.cgEActT8-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git switchtec
branch HEAD: 00a479ba1d01249d43ca5e453380d1ed60946f8a  PCI: switchtec: Add Microchip PCI1008 to NTB DMA alias quirk

elapsed time: 749m

configs tested: 73
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260718    gcc-12.5.0
arc                  randconfig-002-20260718    gcc-10.5.0
arm                  randconfig-001-20260718    clang-17
arm                  randconfig-002-20260718    clang-17
arm                  randconfig-003-20260718    gcc-10.5.0
arm                  randconfig-004-20260718    gcc-8.5.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260718    clang-17
arm64                randconfig-002-20260718    clang-17
arm64                randconfig-003-20260718    clang-17
arm64                randconfig-004-20260718    clang-21
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260718    gcc-14.3.0
csky                 randconfig-002-20260718    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260718    gcc-14
i386       buildonly-randconfig-002-20260718    gcc-14
i386       buildonly-randconfig-003-20260718    gcc-14
i386       buildonly-randconfig-004-20260718    clang-22
i386       buildonly-randconfig-005-20260718    clang-22
i386       buildonly-randconfig-006-20260718    clang-22
i386                 randconfig-001-20260718    gcc-14
i386                 randconfig-002-20260718    gcc-14
i386                 randconfig-003-20260718    clang-22
i386                 randconfig-004-20260718    gcc-14
i386                 randconfig-005-20260718    clang-22
i386                 randconfig-006-20260718    clang-22
i386                 randconfig-007-20260718    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260718    clang-18
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-002-20260718    gcc-8.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260718    gcc-9.5.0
parisc               randconfig-002-20260718    gcc-11.5.0
powerpc              randconfig-001-20260718    clang-24
powerpc              randconfig-002-20260718    gcc-16.1.0
powerpc64            randconfig-001-20260718    clang-24
powerpc64            randconfig-002-20260718    clang-17
riscv                         randconfig-001    gcc-13.4.0
riscv                randconfig-001-20260718    gcc-16.1.0
riscv                randconfig-002-20260718    clang-24
s390                 randconfig-001-20260718    gcc-13.4.0
s390                 randconfig-002-20260718    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260718    gcc-16.1.0
sh                   randconfig-002-20260718    gcc-16.1.0
sparc                randconfig-001-20260718    gcc-11.5.0
sparc                randconfig-002-20260718    gcc-8.5.0
sparc64              randconfig-001-20260718    gcc-8.5.0
sparc64              randconfig-002-20260718    gcc-13.4.0
um                   randconfig-001-20260718    gcc-14
um                   randconfig-002-20260718    gcc-14
x86_64     buildonly-randconfig-001-20260718    clang-22
x86_64     buildonly-randconfig-002-20260718    clang-22
x86_64     buildonly-randconfig-003-20260718    clang-22
x86_64     buildonly-randconfig-004-20260718    clang-22
x86_64     buildonly-randconfig-005-20260718    clang-22
x86_64     buildonly-randconfig-006-20260718    clang-22
x86_64               randconfig-013-20260718    clang-22
xtensa               randconfig-001-20260718    gcc-11.5.0
xtensa               randconfig-002-20260718    gcc-8.5.0
xtensa                   smp_lx200_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
