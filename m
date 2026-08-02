Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C68142A80
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 01:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785634554; cv=none; b=l55VmWWchvQcVI3jZ4+1r16pJbTmzT80fLpImBSKG1U5siaxbdcSXu7qPjuAz8Uk4prw8ahrfXeVIpYQu0mW+e1GsRqokxWKE+AgYYgP/EfqDUv0zHaca44BtaELDFdqaWPQsx7LaOnyf3qSY6X91q/N1aOQiHn9MqV3jSnZ1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785634554; c=relaxed/simple;
	bh=TkcAh5NKdD9D4tcim49h21DFf3TFxJkQI7EqH81YFPM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eGnZVB3BuDMLIwJqIgktnFyIXerZ/QTyJyn93+g7n9sV0WgxluhNK4CjnjljIF0Ci6qcK54x74o0JRZnF/wW4/gi02vhJ6ujqv4y3ofgzXj3N9PT9KM8EQYZgSVlBqyeavrtDi1dYkAbfmgS0RMT8c98FWQwtxWhz4ktKEZ/49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKdhnAMS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKdhnAMS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785634552; x=1817170552;
  h=date:from:to:cc:subject:message-id;
  bh=TkcAh5NKdD9D4tcim49h21DFf3TFxJkQI7EqH81YFPM=;
  b=ZKdhnAMS5kQq3s1jaT2tDyG+mIl/XKU3hqWonHReGmzAQNtJb/49o+Hp
   zt29CQcYG/dp//jmWtEFXO2Z6EYyso8xfnJz97dwovXd0lDCQ4nK/aI8l
   sly5OqUhKZwE6hvxopN66/lo6yglfrr4X4ijoCg1SZExuZz1zpPSdIMMD
   vDKTFGaFr0cqbkDq2p+UBltF/ZygqFz5w6wj54f980Rzult3KJeUAT9el
   BnKCzrDftpajHYSEADL3d6lcqxnLB5oHXk3mFq4xvQL6Eu5mAsf+GLgji
   PWyfpuiuWT6HdmD3v0kV+wpV86EOP8mM7ch5q6UmtfZpQVhBsNLXSkSZj
   g==;
X-CSE-ConnectionGUID: BaL8Shh3TjGMA2HdfIvVMA==
X-CSE-MsgGUID: +XZqWdxAQnKCkCsgCjumwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11862"; a="96575676"
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="96575676"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 18:35:51 -0700
X-CSE-ConnectionGUID: KGSBzk3FS0y1gs8gnAKwrw==
X-CSE-MsgGUID: Xr6a/oFSSFiQWKKzXmFViA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="285518300"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 01 Aug 2026 18:35:50 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqL7D-000000004E9-36km;
	Sun, 02 Aug 2026 01:35:47 +0000
Date: Sun, 02 Aug 2026 09:35:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-qcom] BUILD SUCCESS
 65ccb2203ef8919390ccdcbe34ac6f8ec1fee672
Message-ID: <202608020959.FayczeoB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-qcom
branch HEAD: 65ccb2203ef8919390ccdcbe34ac6f8ec1fee672  PCI: qcom: Clear Attention Button Present in Slot Capabilities

elapsed time: 746m

configs tested: 100
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260802    gcc-15.2.0
arc                  randconfig-002-20260802    gcc-15.2.0
arm                           qcom_defconfig    clang-24
arm                  randconfig-001-20260802    gcc-15.2.0
arm                  randconfig-002-20260802    gcc-15.2.0
arm                  randconfig-003-20260802    gcc-15.2.0
arm                  randconfig-004-20260802    gcc-15.2.0
arm64                randconfig-001-20260802    gcc-9.5.0
arm64                randconfig-002-20260802    gcc-9.5.0
arm64                randconfig-003-20260802    gcc-9.5.0
arm64                randconfig-004-20260802    gcc-9.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260802    gcc-9.5.0
csky                 randconfig-002-20260802    gcc-9.5.0
hexagon              randconfig-001-20260802    clang-24
hexagon              randconfig-002-20260802    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260802    gcc-14
i386       buildonly-randconfig-002-20260802    gcc-14
i386       buildonly-randconfig-003-20260802    gcc-14
i386       buildonly-randconfig-004-20260802    gcc-14
i386       buildonly-randconfig-005-20260802    gcc-14
i386       buildonly-randconfig-006-20260802    gcc-14
i386                 randconfig-001-20260802    gcc-14
i386                 randconfig-002-20260802    gcc-14
i386                 randconfig-003-20260802    gcc-14
i386                 randconfig-004-20260802    gcc-14
i386                 randconfig-005-20260802    gcc-14
i386                 randconfig-006-20260802    gcc-14
i386                 randconfig-007-20260802    gcc-14
i386                 randconfig-011-20260802    gcc-14
i386                 randconfig-012-20260802    gcc-14
i386                 randconfig-013-20260802    gcc-14
i386                 randconfig-014-20260802    gcc-14
i386                 randconfig-015-20260802    gcc-14
i386                 randconfig-016-20260802    gcc-14
i386                 randconfig-017-20260802    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260802    clang-24
loongarch            randconfig-002-20260802    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260802    clang-24
nios2                randconfig-002-20260802    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260802    gcc-14.3.0
parisc               randconfig-002-20260802    gcc-14.3.0
powerpc                  bluestone_defconfig    clang-24
powerpc              randconfig-001-20260802    gcc-14.3.0
powerpc              randconfig-002-20260802    gcc-14.3.0
powerpc64            randconfig-001-20260802    gcc-14.3.0
powerpc64            randconfig-002-20260802    gcc-14.3.0
riscv                randconfig-001-20260802    gcc-13.4.0
riscv                randconfig-002-20260802    gcc-13.4.0
s390                 randconfig-001-20260802    gcc-13.4.0
s390                 randconfig-002-20260802    gcc-13.4.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260802    gcc-13.4.0
sh                   randconfig-002-20260802    gcc-13.4.0
sparc                randconfig-001-20260802    gcc-12.5.0
sparc                randconfig-002-20260802    gcc-12.5.0
sparc64              randconfig-001-20260802    gcc-12.5.0
sparc64              randconfig-002-20260802    gcc-12.5.0
um                   randconfig-001-20260802    gcc-12.5.0
um                   randconfig-002-20260802    gcc-12.5.0
x86_64     buildonly-randconfig-001-20260802    gcc-12
x86_64     buildonly-randconfig-002-20260802    gcc-12
x86_64     buildonly-randconfig-003-20260802    gcc-12
x86_64     buildonly-randconfig-004-20260802    gcc-12
x86_64     buildonly-randconfig-005-20260802    gcc-12
x86_64     buildonly-randconfig-006-20260802    gcc-12
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260802    clang-22
x86_64               randconfig-002-20260802    clang-22
x86_64               randconfig-003-20260802    clang-22
x86_64               randconfig-004-20260802    clang-22
x86_64               randconfig-005-20260802    clang-22
x86_64               randconfig-006-20260802    clang-22
x86_64               randconfig-011-20260802    clang-22
x86_64               randconfig-012-20260802    clang-22
x86_64               randconfig-013-20260802    clang-22
x86_64               randconfig-014-20260802    clang-22
x86_64               randconfig-015-20260802    clang-22
x86_64               randconfig-016-20260802    clang-22
x86_64               randconfig-071-20260802    gcc-12
x86_64               randconfig-072-20260802    gcc-12
x86_64               randconfig-073-20260802    gcc-12
x86_64               randconfig-074-20260802    gcc-12
x86_64               randconfig-075-20260802    gcc-12
x86_64               randconfig-076-20260802    gcc-12
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260802    gcc-12.5.0
xtensa               randconfig-002-20260802    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
