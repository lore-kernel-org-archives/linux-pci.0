Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106413BED38
	for <linux-pci@vger.kernel.org>; Sun,  6 Sep 2026 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788736509; cv=none; b=NY+FebqZzm/nPvmMOej7soLxicVMtK5b853+2V9yeL4voahfiBkVi/sMMkPZHCs2Je/tHF+3jy7/TEhke9WGO2Tdvq0gPTQYnkorS/bnFkzBw78f818ss9ogtInB0jBHn3k62GQUCCltgciSSDRwoMstwWC0nIA136WyY/0yS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788736509; c=relaxed/simple;
	bh=ivWV/CZzEDeCrnBDzKZdJUSm+VcWrH4vzU6dESW4EZs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZEldypK4MUQZsJLJWomzwFuYMRsmwM7I5r4m9uDFHALJUuV30CIMcVADvKsdLHey8tMVmynuspvn1Rq53l7pF+7nbZ43Ws80nuDpWTT7v91vDQq5caQEGB6tsDeIItbEQ2dCHWNw++oA5wagdwwB4BsoZ32rFSHWwaFm+eu9kMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RE5Mqb3F; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RE5Mqb3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788736507; x=1820272507;
  h=date:from:to:cc:subject:message-id;
  bh=ivWV/CZzEDeCrnBDzKZdJUSm+VcWrH4vzU6dESW4EZs=;
  b=RE5Mqb3FXyu2MD/O+F8AoDiLRC5bx5Eceu6uAB4An3bs6A0WartYD/ZC
   RliwKFUXNFRslxEwLA2zAj7a5akij8GfZg6B9dzIDDHlNBGjRYZffJber
   ZSk1Z89tKhcrhC9KcceSFEiBiW4yO0V+va7VQk+s96Nnd/bZ6N9/IH3pb
   zNEiHgurpd7MqJfRZMAWFkFWgdtECVR7H9Pc+bpXIkXBlRvlCsw3yQLVU
   mTkCWEtgDwJ9kwT9JnhJOHRr1WjBcjp/clfoTOl2m45m9+opwHL1U+fqv
   2fwkR06A0B4rxDwIznFu/ITVzdFVlO/of/5bzh2aY4L3AlM9eHE99TyqU
   w==;
X-CSE-ConnectionGUID: /USF8/96RkKe9dIO96/e/A==
X-CSE-MsgGUID: y8cAZFUJR1a372iU5iq12A==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89176635"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="89176635"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 16:15:06 -0700
X-CSE-ConnectionGUID: lbgYwnHCSua8VGfTFgHNzA==
X-CSE-MsgGUID: fGY2yZppRqCGkT9TOXB95w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="266872512"
Received: from lkp-server01.sh.intel.com (HELO 73f3364bc37e) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 06 Sep 2026 16:15:05 -0700
Received: from kbuild by 73f3364bc37e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3M4k-000000002rt-3Dek;
	Sun, 06 Sep 2026 23:15:02 +0000
Date: Mon, 07 Sep 2026 07:14:53 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:p2pdma] BUILD SUCCESS
 f7c2204047009dd488ef05288c8cc9a8d70c058a
Message-ID: <202609070750.gYBkTQI1-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git p2pdma
branch HEAD: f7c2204047009dd488ef05288c8cc9a8d70c058a  PCI/P2PDMA: Add Zhaoxin host bridges to allowlist

elapsed time: 4367m

configs tested: 43
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    gcc-16.1.0
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
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2         allnoconfig    clang-24
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
parisc        allnoconfig    clang-24
powerpc       allnoconfig    clang-24
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
s390          allnoconfig    clang-24
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sparc         allnoconfig    clang-24
sparc64      allmodconfig    clang-20
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
