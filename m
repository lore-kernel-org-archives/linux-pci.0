Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC253BED7D
	for <linux-pci@vger.kernel.org>; Sat, 25 Jul 2026 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784980691; cv=none; b=EQc/x366UBeWISxcWXTXCkH/5fa9fLSKlamAdhsHzpyB2dKEuf5MPKxggajKHlZT5nQc/mgQjo34U2/ycUmnK1e8zLRQ4JK7GoFkrs+TwWpKh9EcBSDPw5HJ0FxIpiwEbjetr4invZ3jQERAO35TYXwF14HHFTK7sxtgYodhp34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784980691; c=relaxed/simple;
	bh=npTF3QlGboCkKu39jyvIHp3mVpO79E3WxRmf3DVRG8g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pifmREKg38ULTHm6BYqqV34scUyurOf/GO+1nkb3EJ8BtxL7PljC+oRvSOOUAS7eeUrz91fdl1urS4mJGBkvPJNqMwey3j6rBfQkuASg6zUNuv3MgbiGdpXJxtAh1pKYID17bZZg8R4Zl5vDQ9r0SsSkfEuGepyKNQeT8qQMu5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKMw84Vg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKMw84Vg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784980688; x=1816516688;
  h=date:from:to:cc:subject:message-id;
  bh=npTF3QlGboCkKu39jyvIHp3mVpO79E3WxRmf3DVRG8g=;
  b=eKMw84VgaFlyJVntqeSaUXwhOiinQs5t8cjDB1O5i4aFcAOOWdSz6jeh
   4MYd9niTdNxYp+PVroLNg51dU79vHM1gAqifhFmLRT1kYATevLxxvxCQN
   opFtv3aDNiffPE77+5OAJgN+AYNScmX88KuvwiixWFA0Mk/zXGIvUvOtT
   lZe3vk/0Eib7O9NCYoG+ZHDEE7N1XBoI6WVN4C0Zea5ImMAE2AhSB55Y4
   jdgOG+Jq5ZmZWK7cEY3mz4WwCmov7Ms7uiYZgk5qJ9ifhOG0RB4rjzVMX
   43L5NAOr515r6ZaAow5eaUyKVH7NFhpNHo4NdO5/478UjY5EvBcLh1cg9
   Q==;
X-CSE-ConnectionGUID: pLNQxvJ8SQyDlmkngY2ItA==
X-CSE-MsgGUID: A0vWTd0YS3ydxAq6NrQDtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="97140575"
X-IronPort-AV: E=Sophos;i="6.25,184,1779174000"; 
   d="scan'208";a="97140575"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2026 04:58:08 -0700
X-CSE-ConnectionGUID: 3nAN2LS7QAuGF+W763aFwg==
X-CSE-MsgGUID: 4hBVA/zAQGSGuI7SpNETNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,184,1779174000"; 
   d="scan'208";a="297173840"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 25 Jul 2026 04:58:07 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wnb0z-00000000bes-25ja;
	Sat, 25 Jul 2026 11:58:01 +0000
Date: Sat, 25 Jul 2026 19:56:54 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 5012a69532081deb36f05e39511afb77edfabede
Message-ID: <202607251943.YgxoVBlE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 5012a69532081deb36f05e39511afb77edfabede  PCI: Do not add hotplug reservation multiple times

elapsed time: 1300m

configs tested: 96
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260725    gcc-11.5.0
arc                  randconfig-002-20260725    gcc-8.5.0
arm                  randconfig-001-20260725    gcc-8.5.0
arm                  randconfig-002-20260725    clang-21
arm                  randconfig-003-20260725    gcc-10.5.0
arm                  randconfig-004-20260725    gcc-15.2.0
arm64                randconfig-001-20260725    clang-24
arm64                randconfig-002-20260725    gcc-13.4.0
arm64                randconfig-003-20260725    clang-24
arm64                randconfig-004-20260725    clang-24
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260725    gcc-9.5.0
csky                 randconfig-002-20260725    gcc-16.1.0
hexagon                       randconfig-001    clang-17
hexagon              randconfig-001-20260725    clang-17
hexagon              randconfig-002-20260725    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260725    clang-22
i386       buildonly-randconfig-002-20260725    gcc-14
i386       buildonly-randconfig-003-20260725    clang-22
i386       buildonly-randconfig-004-20260725    clang-22
i386       buildonly-randconfig-005-20260725    gcc-14
i386       buildonly-randconfig-006-20260725    gcc-14
i386                 randconfig-002-20260725    gcc-14
i386                 randconfig-003-20260725    gcc-14
i386                 randconfig-004-20260725    gcc-12
i386                 randconfig-006-20260725    gcc-14
i386                 randconfig-007-20260725    gcc-14
i386                 randconfig-011-20260725    gcc-14
i386                 randconfig-012-20260725    gcc-14
i386                 randconfig-013-20260725    gcc-14
i386                 randconfig-014-20260725    clang-22
i386                 randconfig-015-20260725    clang-22
i386                 randconfig-016-20260725    clang-22
i386                 randconfig-017-20260725    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260725    gcc-16.1.0
loongarch            randconfig-002-20260725    gcc-13.4.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260725    gcc-11.5.0
nios2                randconfig-002-20260725    gcc-9.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260725    gcc-10.5.0
parisc               randconfig-002-20260725    gcc-12.5.0
powerpc              randconfig-001-20260725    gcc-9.5.0
powerpc              randconfig-002-20260725    gcc-15.2.0
powerpc64            randconfig-001-20260725    clang-17
powerpc64            randconfig-002-20260725    clang-24
riscv                         randconfig-001    gcc-13.4.0
riscv                randconfig-001-20260725    gcc-8.5.0
riscv                randconfig-002-20260725    gcc-8.5.0
s390                 randconfig-001-20260725    gcc-10.5.0
s390                 randconfig-002-20260725    gcc-16.1.0
sh                                 defconfig    gcc-16.1.0
sh                        ecovec24_defconfig    gcc-16.1.0
sh                   randconfig-001-20260725    gcc-16.1.0
sh                   randconfig-002-20260725    gcc-11.5.0
sparc                randconfig-001-20260725    gcc-16.1.0
sparc                randconfig-002-20260725    gcc-8.5.0
sparc64              randconfig-001-20260725    gcc-8.5.0
sparc64              randconfig-002-20260725    gcc-10.5.0
um                   randconfig-001-20260725    gcc-14
um                   randconfig-002-20260725    clang-24
x86_64     buildonly-randconfig-001-20260725    clang-22
x86_64     buildonly-randconfig-002-20260725    clang-22
x86_64     buildonly-randconfig-003-20260725    clang-22
x86_64     buildonly-randconfig-004-20260725    gcc-12
x86_64     buildonly-randconfig-005-20260725    gcc-12
x86_64     buildonly-randconfig-006-20260725    gcc-14
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260725    gcc-14
x86_64               randconfig-005-20260725    clang-22
x86_64               randconfig-006-20260725    clang-22
x86_64               randconfig-011-20260725    gcc-14
x86_64               randconfig-012-20260725    gcc-14
x86_64               randconfig-013-20260725    gcc-14
x86_64               randconfig-014-20260725    gcc-14
x86_64               randconfig-015-20260725    gcc-14
x86_64               randconfig-016-20260725    gcc-14
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260725    gcc-14
x86_64               randconfig-072-20260725    gcc-14
x86_64               randconfig-073-20260725    gcc-14
x86_64               randconfig-074-20260725    gcc-14
x86_64               randconfig-075-20260725    gcc-14
x86_64               randconfig-076-20260725    clang-22
xtensa               randconfig-001-20260725    gcc-16.1.0
xtensa               randconfig-002-20260725    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
