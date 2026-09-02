Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207144AA3FC
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788375592; cv=none; b=fY8vxs5G3cFjGsThnCg7kNqri4FUStRpAFa0DGkkKKlRtHNXn/QuNqDePJdqlXUmAI7f5mbSJt2/l1BNzq0SY8ENXXwDceD4cyY6ywnuBwwQfjF4TV/CG6d0vXId3pqUNuc5a+gytCdam24X90wgSkB3GnT5vdtSw3kcRiINnGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788375592; c=relaxed/simple;
	bh=0EUWcEx6eydz4ruvklIddwv5V3y6vnjWg1/N8KiQDvs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E9lMaJy2dWbvPRCqnkHLKmUh3dYmkCsEQwpioRQBYW3ggGnj6G8xInQI4Rj7tbcWGRZAzhK9DvONgh/Cjeo1KmnRAGrFruPN7nEjkvFBysq9jrNd1bmbPah1nm74ax1RcgM0xHuZJpVFkWjljjz2AaJ2lTlQqIHDomTTR4uLvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKsM6apU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKsM6apU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788375591; x=1819911591;
  h=date:from:to:cc:subject:message-id;
  bh=0EUWcEx6eydz4ruvklIddwv5V3y6vnjWg1/N8KiQDvs=;
  b=gKsM6apUCUOogSITXGHldJja47QVt6hNJ1Rv2GDpDHwnrxqSjXtufKD+
   wQtm3Rv57hdWQ6WP1lXhCqIW7gWlBPbd5ndBhLCNvlguYjrznwhOc8x72
   rxsVkJR/mw2CSsr0iU9opUEEHGRD3AgU+olNTKyd4FoWEoK1Y+LAM6L1J
   Uflj/owe69uPrnZIJzqSo54xX+KArDP7W4cKii7GrTnkA1YbOIaKj7SMp
   wl/oHBLclrpk7UqnZufHphjkvAhv9OgmPwdzxsDuqsExle65IQaddA8jx
   5n3Y6FtAoo2ifmZycnmZjKZVdHWkh+nCKg4nbGHXdU/tE90P/UNsNtVxI
   g==;
X-CSE-ConnectionGUID: K/Ja8ShSSBqsDzkLfKHy7A==
X-CSE-MsgGUID: 9TNxuKDmTZqW62xRd0v6Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92713052"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92713052"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 11:59:50 -0700
X-CSE-ConnectionGUID: 5LiG4ys3QR2515HMk90FJA==
X-CSE-MsgGUID: pQ65v8JrRV6OqusRyuvfNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="267736693"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 Sep 2026 11:59:49 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1qBW-000000003BS-22M5;
	Wed, 02 Sep 2026 18:59:46 +0000
Date: Thu, 03 Sep 2026 02:58:55 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:cadence] BUILD SUCCESS
 ce8034bb9c5c50f9f5c305856aff5d1c3efe3a30
Message-ID: <202609030250.h4aXb9B8-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: ce8034bb9c5c50f9f5c305856aff5d1c3efe3a30  PCI: cadence: Fix enum type mismatch warning in LTSSM debugfs

elapsed time: 1713m

configs tested: 58
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
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    clang-17
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    clang-17
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
