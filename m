Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198EC238C1A
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917245; cv=none; b=KyLgvmQL+OEOPadol3gFwpuGrV8ilcOz3h0GhST6TLnmXwjfrigwMhFox1+z+k7Tha5icJwjiJDcmovUyCFJQChZ5Je6i3/KZML41sn5uv0qP6c/6Vs8uKzt/WdhTEk2f27UwpESKIvyxpCY79Pj9kMIq25rRE6EMmkIXbCrRwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917245; c=relaxed/simple;
	bh=EN8z0fig73SsAFAoe+Okh/Aagi+cfAhggzK+2yrjCuw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qYlMNSCQIaJkYybv5+diaO35Q34+Wbe5S2ikbG8tVTg/l1wF+psPYCyOi6BNAv47UdZnht++71NCvY2z5eDRpXxj2s4R3omN5zrbNH/VMCAs5/xjSqclz9etRveU5d/6/a3FTuBE9KnsoRoMaFaug7BfISu766PegwCZ7IdMoYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYFDYfv0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYFDYfv0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777917244; x=1809453244;
  h=date:from:to:cc:subject:message-id;
  bh=EN8z0fig73SsAFAoe+Okh/Aagi+cfAhggzK+2yrjCuw=;
  b=eYFDYfv0MWfAag0HcnWORw/bUt22k5OIlDRn+YV/E/TtKYkJlqYgcwPU
   xEpTep/Fn1kSqEOdLRxpK4bou9Xge1HDklrVRLLnuCkic8trdjSKUK3xH
   /74vZCQVIFdsIJXagZLDOnvHyFzn/te6WTjE5+fPcICZ5gQumSfLjR9N5
   lKETCRlCTIadEyJ+7fs8OJLm1sP5yGNfnLYAo11tvXSh88UA4A7c26Y6w
   Kh+lKycJFFRhi+L8te6VL6BiV8OtGd/O1ym2nlaWyZT8i7Qnm6vFm3ogh
   dpHVOBiUUF0U+JCYsT73ZHOBhBR6XRGcCDmDxeC21jRT1daNY2IEzi7nm
   w==;
X-CSE-ConnectionGUID: f2zcueV7TYSgDbaQ/cW/jQ==
X-CSE-MsgGUID: ixRuxcmcTQOKbVcDRcojrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78710982"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78710982"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 10:54:03 -0700
X-CSE-ConnectionGUID: qJZ8vPkISF+1upTDVgoEfQ==
X-CSE-MsgGUID: vGRxEuUuS1mci7ZZ1Sp2/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="234563038"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 May 2026 10:54:03 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJxUN-000000003ut-0XhM;
	Mon, 04 May 2026 17:53:53 +0000
Date: Tue, 05 May 2026 01:52:38 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 25869ed1fed345da375b1067e0dc625579efbc75
Message-ID: <202605050128.zjisaMWR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 25869ed1fed345da375b1067e0dc625579efbc75  PCI: brcmstb: Assign pcie->gen from pcie_get_link_speed()

elapsed time: 4067m

configs tested: 50
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-23
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-23
um           allmodconfig    clang-19
um            allnoconfig    clang-23
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
