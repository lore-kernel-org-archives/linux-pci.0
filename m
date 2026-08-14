Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA003E3169
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786743792; cv=none; b=GhVHfKXBcvLg5UdzJAuyUrsKGlE9vOTnwJVbbC2vaGAdCsJMTye0vek6BATW5k83BBuR2pzw5Qgj1hs38ZN6gN5zm7+8AzkGBGUb4cZqdmSRilMx6+shT8dnPijAcB7wetiQy+/XUaawLP7dTiEn3uXrIEmo5NUMCSgvGBXUIA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786743792; c=relaxed/simple;
	bh=6n5qS2IVi2kHOr4Hr1WJ0pAfIp06qge/JdGV+pXuYtw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ctbdciGOi7fwOhBheyTu3YR4N6vAA1s6XEEduaKtG1vBDowhYDTfPXOXCWlROh+RNmcXqTKZu2OQN5gXeJJ5w4e+VEzi5+nUFXU1nBHXT9fki8a02Jcm5O+B3WuG7Fzxg/Y65VJ0vdx8hzp0Up3O/5AcWwHKIDQVYU4qxTaQVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BbiTxUhM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BbiTxUhM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786743789; x=1818279789;
  h=date:from:to:cc:subject:message-id;
  bh=6n5qS2IVi2kHOr4Hr1WJ0pAfIp06qge/JdGV+pXuYtw=;
  b=BbiTxUhMZ3d/I/I1K4bKfiaha6jJ1Y3Bxg/dNmwl87hT7vGyOCyzQ6xA
   ZWQoRWsa26dtbY8GwcrnRH2ms2IKpY4HKdG+fnFguwaA56Hg5gKnn+HkB
   fcegj6PGyixr0ujKkRbEF4b4o3UDNTmTRRY2y5Yqb8p6XH96j9DLKzpik
   4SEVYmP5R0b8Wnwji4glfjbWIx3dFabSiG4puqj+z3MkCLb5f7FtFwHDQ
   nOPi2GuzjrYEv9evbm7Sbv5uOSTEwvi2e9N7bjyWk7tmZ+FbVIvTmau3w
   YrepmgAGn8DNiDaHDAESxhlsOusjsH/G2cOJOQcqYEDVHEVhICdBGsKLy
   w==;
X-CSE-ConnectionGUID: aU0S85T9Qe6chUaZ38AVwg==
X-CSE-MsgGUID: 2pRK/fn1RAuT55HoHyuGRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="110110763"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="110110763"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 14:43:08 -0700
X-CSE-ConnectionGUID: 0sJJ+glERn2M12bLzUGDMg==
X-CSE-MsgGUID: dl/loUX0R7uIwxu3bgJAJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="267817334"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Aug 2026 14:43:08 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuzg9-00000000aHS-1IV6;
	Fri, 14 Aug 2026 21:43:05 +0000
Date: Sat, 15 Aug 2026 05:42:30 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mediatek-gen3] BUILD SUCCESS
 26c53c644350f02a444b2e0dbee9f5cf78511ff5
Message-ID: <202608150518.Rw8TiYGK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek-gen3
branch HEAD: 26c53c644350f02a444b2e0dbee9f5cf78511ff5  PCI: mediatek-gen3: Add 2-lane mode support for Airoha AN7581

elapsed time: 793m

configs tested: 23
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
csky                  allmodconfig    gcc-16.1.0
csky       randconfig-001-20260815    gcc-13.4.0
csky       randconfig-002-20260815    gcc-15.2.0
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
powerpc           pmac32_defconfig    clang-24
riscv      randconfig-002-20260815    gcc-8.5.0
sh                       defconfig    gcc-16.1.0
x86_64     randconfig-011-20260815    clang-22
x86_64     randconfig-013-20260815    clang-22
x86_64     randconfig-014-20260815    clang-22
x86_64     randconfig-015-20260815    gcc-14
x86_64     randconfig-016-20260815    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
