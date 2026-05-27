Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3244E045
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903215; cv=none; b=GcqodrIsGoaNK5l2bxkEYgvWCQwXSR5Jcmzb0zheRKgwy/AjOq5Rvz3NiNoNCSfLREnOzweAQ+pcwz1Lr9r8K0GI0GUcJhbAJu3B64TzfKg32YoWtMzeriAq95HadFDi3r9bX8lgvP/6cDIXALWV7/FpLBnJox0veIvW9UrFJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903215; c=relaxed/simple;
	bh=PDaZ/m0U90KProbi0AUtOZhGxAv3/isfFFaJmH6CDsQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NlHzFswcxtb8JS0bTaql9Ierxt1elZIBzp/Bk078tdoDQe8iO1RpP4LP9MwRWlM6J1Oxl7kVdM3E4XdFZURFMKJoW5VAg1Ud5O3wA6wsarCY1mR7bbT/ukytGpBGTr+VglpGEN2iTDzU0vCLPeCGiFPSlCp3O4CvFg3EV8GxtFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0zIY1oP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0zIY1oP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779903213; x=1811439213;
  h=date:from:to:cc:subject:message-id;
  bh=PDaZ/m0U90KProbi0AUtOZhGxAv3/isfFFaJmH6CDsQ=;
  b=E0zIY1oPEp9AvSHI60xl3cHyVqD8GDYdnF08w/0abrZZNZ6p3AyH/VDi
   D3pd/M1VpWetH/Dsq0JO6uX3H8rrEoHtngUEO9/pGqP/UNRPfmZcM0LeP
   LJvcNGQNlMEC4X5KCTDjKSWAfWrzKnoJQz/iAJG4SChk36BogsZs7yUei
   lJ7OVswMOPkMcUCw2WZxtT7C0xaejdxlMyeUtu5ffwzAOMr1V3+RqFBSg
   xPIUy8C0uSOmWSlbGuremappv4Er6T0qF5WnvEYFPpTfMZhEHneJUjrAR
   QQG9WIbfkCNRVS8VRIG7sbvn/G6daxKDkBi9a9MKTxmQfY+r65CUCztqQ
   g==;
X-CSE-ConnectionGUID: 7nkiSqNTQ4avS6avAFC5Vw==
X-CSE-MsgGUID: KjgLifh6QkGr9uxnRdxxSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80468141"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="80468141"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 10:33:32 -0700
X-CSE-ConnectionGUID: Z861l0yfReWWWP7Trk9XOg==
X-CSE-MsgGUID: 0hFM6KLsTledjwddW4dbLw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 27 May 2026 10:33:30 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSI8F-000000004Gs-3tpF;
	Wed, 27 May 2026 17:33:27 +0000
Date: Thu, 28 May 2026 01:32:32 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-qcom] BUILD SUCCESS
 e9769bb172696b7e924eb30fc94909e0c30786cf
Message-ID: <202605280121.iMDX9yvG-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-qcom
branch HEAD: e9769bb172696b7e924eb30fc94909e0c30786cf  PCI: qcom: Program T_POWER_ON

elapsed time: 1526m

configs tested: 63
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha             allnoconfig    gcc-15.2.0
alpha            allyesconfig    gcc-15.2.0
arc              allmodconfig    gcc-15.2.0
arc               allnoconfig    gcc-15.2.0
arc              allyesconfig    gcc-15.2.0
arm               allnoconfig    clang-23
arm              allyesconfig    gcc-15.2.0
arm64            allmodconfig    clang-19
arm64             allnoconfig    gcc-15.2.0
csky             allmodconfig    gcc-15.2.0
csky              allnoconfig    gcc-15.2.0
hexagon          allmodconfig    clang-17
hexagon           allnoconfig    clang-23
i386              allnoconfig    gcc-14
i386             allyesconfig    gcc-14
loongarch        allmodconfig    clang-19
loongarch         allnoconfig    clang-23
m68k             allmodconfig    gcc-15.2.0
m68k              allnoconfig    gcc-15.2.0
m68k             allyesconfig    gcc-15.2.0
microblaze        allnoconfig    gcc-15.2.0
microblaze       allyesconfig    gcc-15.2.0
mips             allmodconfig    gcc-15.2.0
mips              allnoconfig    gcc-15.2.0
mips             allyesconfig    gcc-15.2.0
nios2            allmodconfig    gcc-11.5.0
nios2             allnoconfig    gcc-11.5.0
openrisc         allmodconfig    gcc-15.2.0
openrisc          allnoconfig    gcc-15.2.0
openrisc            defconfig    gcc-15.2.0
parisc           allmodconfig    gcc-15.2.0
parisc            allnoconfig    gcc-15.2.0
parisc           allyesconfig    gcc-15.2.0
parisc              defconfig    gcc-15.2.0
powerpc          allmodconfig    gcc-15.2.0
powerpc           allnoconfig    gcc-15.2.0
riscv            allmodconfig    clang-23
riscv             allnoconfig    gcc-15.2.0
riscv            allyesconfig    clang-16
s390             allmodconfig    clang-18
s390              allnoconfig    clang-23
s390             allyesconfig    gcc-15.2.0
sh               allmodconfig    gcc-15.2.0
sh                allnoconfig    gcc-15.2.0
sh               allyesconfig    gcc-15.2.0
sh                  defconfig    gcc-15.2.0
sparc             allnoconfig    gcc-15.2.0
sparc               defconfig    gcc-15.2.0
sparc       sparc32_defconfig    gcc-15.2.0
sparc64          allmodconfig    clang-23
sparc64             defconfig    clang-20
um               allmodconfig    clang-19
um                allnoconfig    clang-23
um               allyesconfig    gcc-14
um                  defconfig    clang-23
um             i386_defconfig    gcc-14
um           x86_64_defconfig    clang-23
x86_64           allmodconfig    clang-20
x86_64            allnoconfig    clang-20
x86_64           allyesconfig    clang-20
x86_64              defconfig    gcc-14
x86_64          rhel-9.4-rust    clang-20
xtensa            allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
