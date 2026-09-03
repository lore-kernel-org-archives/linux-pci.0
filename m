Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94923612EF
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 04:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788408048; cv=none; b=UlMs5U0E27bdYaSSMMcm2651TWMmPVPN6wSrUINW5vIdQNxjPRPEok4JDHdfz1UqQP6g1EXhsxejP5v/LKOUavc9wk93/gNZAxh6twqD9jeKri9n+4KJH7BkNQrtGFX0LnzKZACmMeNJVn8/ubPP3DP49Azbdbn8PZtvX/QhCrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788408048; c=relaxed/simple;
	bh=+GDQXEchQYCe5lhmJU33tzaC0RbjEN+9LmplogWoFnA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oFt+hXVJ4ddLxh8Om3rWf1VK9wvVweqPKafGcabAlidaYxUP1+LqtT5mMRSibGKEG+EE6bYRxtiZ0OkdhUpd94VfgiPN0F3emd9IuY9oT2+Q1FSxiyqP5m8hnEv6UFyGjl27PGqcPhivRDeyOUwAZk+RdvefWUj/WAoCNe82vCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PyK1FuGW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyK1FuGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788408047; x=1819944047;
  h=date:from:to:cc:subject:message-id;
  bh=+GDQXEchQYCe5lhmJU33tzaC0RbjEN+9LmplogWoFnA=;
  b=PyK1FuGWtl0qq6oJfZR/iGVTCbmXcb8M1lVKCG6Aob7lG5fHxwvnKXps
   apMT17vWpIapzX7l/p7UPan8Y7tslFWCADUv4lOW2DHdA/RBqlnMQCyPq
   zn2P+hjzENi1c5dmo+jjUnnjqyhjAPdgmLLTuiGpLgz3u4N+anyBPYCYa
   uZzpUbITeDgAZC3Sa8lttlNo07pwZOhC6tZ0msqofiQ4FW611+3ABZ6YS
   uVe0lypvCaOjE+XoqDLc2Cv/QFUPF9QFLLNL12+QAGMUJ61fMFW9W3ZZ6
   hIDjDd4/7eb+xiiehiNUY2Pz4ipWrHS+661coxSNO3R4OZH8EdAbjVLUO
   Q==;
X-CSE-ConnectionGUID: shM2XoZ8TaysTk8vuZ0SUQ==
X-CSE-MsgGUID: 1/Q42zjjQB6NySv28tGTOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="87814135"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="87814135"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 21:00:46 -0700
X-CSE-ConnectionGUID: kjlioWR5TY2crbgKLCkqWA==
X-CSE-MsgGUID: n/9K/5rWQo+VsKT5IyL7iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="293097642"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 02 Sep 2026 21:00:45 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1yd0-000000003wq-2QUH;
	Thu, 03 Sep 2026 04:00:42 +0000
Date: Thu, 03 Sep 2026 12:00:32 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:cadence] BUILD SUCCESS
 ce8034bb9c5c50f9f5c305856aff5d1c3efe3a30
Message-ID: <202609031227.WFsONrLW-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: ce8034bb9c5c50f9f5c305856aff5d1c3efe3a30  PCI: cadence: Fix enum type mismatch warning in LTSSM debugfs

elapsed time: 2254m

configs tested: 68
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
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    clang-17
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    clang-17
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    clang-24
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
