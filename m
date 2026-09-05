Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73B396561
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638283; cv=none; b=eAbEduddT9KzrFJd3tE5YG3bvTJXcBO58ol0BSE/tQWGwsSdlGvzFWvCojVrnIFWBp+sRi18keGhe6/FWw/zdwv98qOw5FLh03n6/CHz4WEzIH1LwcYEp9YRMoabkAzSi/XpDEGUCkib9q1hSqwbdeHzQo/Hqjy64bSv+/v6dxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638283; c=relaxed/simple;
	bh=xW/sJSRtqBJqKlxzZBKGhdf0tNsm5knCKxyljWg+lU8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GsDCdghr9DaZaJvltns2V7ROHUaZ8VP09SUNhQps+Xwd0f+8g9Q9vlueqSPpeYxvBeM4Dq0EpNH3g1pIRmpey63zTLvxPkVHePeRQ8cBpSv7+EK06EA/TLGfFXizi7naOiCoyOJo4QgMm2e5SxlSmMgkjWAL8ZUN2+wQ45jQ1G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BH4oGtKM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BH4oGtKM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788638282; x=1820174282;
  h=date:from:to:cc:subject:message-id;
  bh=xW/sJSRtqBJqKlxzZBKGhdf0tNsm5knCKxyljWg+lU8=;
  b=BH4oGtKMh58dctmDj0fz02HfUHrwySXeBQwOZDg3bEqTjrBVjOXF4uGF
   7aVwwZ8u5+O5MzG9efapfza3PPYlwH3AXknpEUTg4fGBnDWF3ML+3/kCg
   IEvdj1RsBuOkkXvJRlOEl4t6PZdkCQvWiCwVxHNjOckv68wCbiz9dlHWU
   LwIg2QIDMqg3ZY1Sgx2mu3asK2LjuZWmCqbkzMS3n1Xwc8Lz2uJxphXrV
   JQ6HgZ71OmB/rLZ5C4VPCdbCTp77kSa+IaPPpZOux55JXku5F+4gnwf5N
   v6wj4KWIQST7XBSuWTr/Cj/03MsqqPLNXAqtu0zMpej4JXzt2gWlxNXLg
   w==;
X-CSE-ConnectionGUID: z+yP8sE4RVaRSVICcCLWXw==
X-CSE-MsgGUID: DRbdFpyGToW8e3AyCyYevw==
X-IronPort-AV: E=McAfee;i="6800,10657,11897"; a="100623202"
X-IronPort-AV: E=Sophos;i="6.25,264,1779174000"; 
   d="scan'208";a="100623202"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 12:58:01 -0700
X-CSE-ConnectionGUID: /GKtWCHIQHaieXDuwhGcZw==
X-CSE-MsgGUID: piJXvlG6RSqUnQ69fiUFFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,264,1779174000"; 
   d="scan'208";a="275631106"
Received: from lkp-server01.sh.intel.com (HELO 73f3364bc37e) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Sep 2026 12:57:59 -0700
Received: from kbuild by 73f3364bc37e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x2wWT-0000000012v-2Ifc;
	Sat, 05 Sep 2026 19:57:57 +0000
Date: Sun, 06 Sep 2026 03:57:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 39ee38a9fa2eaeff030a6c865abb244597c091eb
Message-ID: <202609060359.g5AwvaBQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 39ee38a9fa2eaeff030a6c865abb244597c091eb  Merge branch 'pci/controller/dwc-rcar-gen4'

elapsed time: 3010m

configs tested: 55
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2         allnoconfig    clang-24
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc       allyesconfig    clang-17
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh           allyesconfig    clang-17
sparc         allnoconfig    clang-24
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
