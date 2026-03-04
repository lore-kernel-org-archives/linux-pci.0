Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143202836F
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 01:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772586546; cv=none; b=mdfhkFd9tWIBz42dDt6d/HVnyJ190IJY+sUoqn2aQZF61v+1aOhrCvYbeqz7eOAbE/nSdL1kn0qUObehKWsl59SZTwRQiNyQoNYdsOyCMPxM6fW7rD/xwuT4PNvZfJJyo0Xzb2i6puSE5FfFgsU9BghI2w2o+haw0KWi7BuROKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772586546; c=relaxed/simple;
	bh=wsLEeu6WcccfLufYwkk4Gj3DUkFL1F8zTRF4/hH1qTs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uBQNTi80nK0ixjc4/jUx4VtCUyYtUR6cQK2dAM2KiBx7SwD757O53918TheCD3sbyu+bmYX1OSR9DmIAGddND66K0Bfvjzh2ywukYfJob4kusGoHeN/GkgPfuqCOZEGjEd5vr5YY9qXcCAS0A8wQ9ooLYXDzBKS6btyyojrQIe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNMrU6AR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNMrU6AR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772586544; x=1804122544;
  h=date:from:to:cc:subject:message-id;
  bh=wsLEeu6WcccfLufYwkk4Gj3DUkFL1F8zTRF4/hH1qTs=;
  b=eNMrU6ARJi87aMs1vs/SdVlRc7J0s6HMOJzyO1hiHSxpxvGc1yjYN6q0
   8zuio8ZTfdgmRJbmYzSLEHAnGMu5dk85yOMiJe9mp1HToYAxX79DR4nxu
   KDKHdG9ltMDcAggDQY64/BYnfX9UCiYt0WSt0yD45DKdCjMHQxkL0ILVz
   k+F3ng5qJgQ1wy9OIABE8EDveGiQ969gENgB6pevNxn68UNLUOBSc2Ubp
   q1HCgiaS76ID49Hn4Cd/nkDyMaDZZvWwtqh/KQ5J0k/lGNg0inXvB5ThN
   sK/u00no9tA8gg5bcJx3SvdhssTPWidfEmhpGxdjIHhIiU+HH7qSMYYCg
   w==;
X-CSE-ConnectionGUID: MHYBwZGOTbeCpQjTFQP2ug==
X-CSE-MsgGUID: 8njszSikS+2urFa2XYwxzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73767262"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="73767262"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 17:09:03 -0800
X-CSE-ConnectionGUID: N7gC4VebSAaeVZkEgi49wg==
X-CSE-MsgGUID: d2xbJvBdSsWY1ltPg/tQTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="223178711"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 03 Mar 2026 17:09:03 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxajT-0000000034j-3BQu;
	Wed, 04 Mar 2026 01:08:59 +0000
Date: Wed, 04 Mar 2026 09:08:53 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-amd-mdb] BUILD SUCCESS
 56435b70f778995c696d53624ba93a429aa38432
Message-ID: <202603040945.02YmL7Wa-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-amd-mdb
branch HEAD: 56435b70f778995c696d53624ba93a429aa38432  PCI: amd-mdb: Correct IRQ number in INTx error message

elapsed time: 1600m

configs tested: 54
configs skipped: 2

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
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
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
