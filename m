Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1FC3B6BFD
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400031; cv=none; b=YsKQvTPrb52m6brfmZvpkhUtiIMCy7/S7aegtzjSe3M+T+7rRBaDqfgdpGDx8wdwNL5PV7eZSHFB9XV+S2zYSX0PmGyBvJo71gnYXWLRwtmlaX8BnSCzkOAe5cWmJFqtvohFwx7lX5VVH757+UIxWehP++UWP/H8EnItAWnQmkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400031; c=relaxed/simple;
	bh=BsktEQDaagJKGUyOf/zTRckT4UIu1zFMWInVwUb0TXg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ckFGj0/1pjl5HN8evuFUTfrkgbFbVD3JtG2gM8aaMSeyOf8D+qq99c3zz0dqT+gtlwahPHs6sG1UQFrkCp/LSMdr3BL+t+1+gIjTO67dEiRWJq8HRlrU3Jd7hFf3b7Fck50AJsDWnepccbLqd8Duck33n3NN5R+yqv3cYJzZ0T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqmNMgLJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqmNMgLJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785400029; x=1816936029;
  h=date:from:to:cc:subject:message-id;
  bh=BsktEQDaagJKGUyOf/zTRckT4UIu1zFMWInVwUb0TXg=;
  b=YqmNMgLJMG+Cl+s8q1UF65h0sXlVbkamH52Z1wcKcfjas1arEa072nC6
   ssh+MsnluvIuLdBCJCn7k9e7cGmWs2mP5Vyn0u//H0jQ3eiiwUbBx9/23
   NPUxja4xbJfg0X4G5dOHfT0c4CFExUpBJAS2FUJcBChFA067+KQvDpAgM
   7h3d+VEYuX+ZODG5XrtcuQHAecUOMg1TGqyPb9S6b/ZM6SubbmAK/xtL0
   X6xBugbwnrHE7Cz4c7WUIHQWxGgsRDvq3WWUvFJ1tOCJFMHoWYaSi4rtM
   1ccUZDv4TGjAUNehLuMqOa23lSISLDkQ/26ZbZvolbjEMPm026ex61Uq6
   Q==;
X-CSE-ConnectionGUID: 40hnU4V8S3Os4fI5IdwEaA==
X-CSE-MsgGUID: ey/ix32DT2GoFSiyZs6umg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85139929"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="85139929"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 01:27:08 -0700
X-CSE-ConnectionGUID: q3hoB3pzT2ist+khdT//Yw==
X-CSE-MsgGUID: Dl9h0/GORBueEbs0B29Oig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="260839694"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 30 Jul 2026 01:27:07 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpM6a-00000000gIl-3T1n;
	Thu, 30 Jul 2026 08:27:04 +0000
Date: Thu, 30 Jul 2026 16:26:16 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/plda-starfive] BUILD SUCCESS
 aaae917990623a6ca6b638557056606a1ae4a8d6
Message-ID: <202607301604.B7FXi663-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/plda-starfive
branch HEAD: aaae917990623a6ca6b638557056606a1ae4a8d6  PCI: starfive: Fix unchecked pm_runtime_get_sync() in probe

elapsed time: 899m

configs tested: 128
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260730    gcc-8.5.0
arc                  randconfig-002-20260730    gcc-8.5.0
arm                  randconfig-001-20260730    gcc-8.5.0
arm                  randconfig-002-20260730    gcc-8.5.0
arm                  randconfig-003-20260730    gcc-8.5.0
arm                  randconfig-004-20260730    gcc-8.5.0
arm                       realview_defconfig    clang-17
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260730    gcc-14.3.0
arm64                randconfig-001-20260730    gcc-15.2.0
arm64                randconfig-002-20260730    gcc-14.3.0
arm64                randconfig-002-20260730    gcc-15.2.0
arm64                randconfig-003-20260730    gcc-14.3.0
arm64                randconfig-003-20260730    gcc-15.2.0
arm64                randconfig-004-20260730    gcc-14.3.0
arm64                randconfig-004-20260730    gcc-15.2.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260730    gcc-14.3.0
csky                 randconfig-001-20260730    gcc-15.2.0
csky                 randconfig-002-20260730    gcc-14.3.0
csky                 randconfig-002-20260730    gcc-15.2.0
hexagon                       randconfig-001    clang-24
hexagon              randconfig-001-20260730    clang-24
hexagon              randconfig-002-20260730    clang-24
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260730    clang-22
i386       buildonly-randconfig-001-20260730    gcc-14
i386       buildonly-randconfig-002-20260730    clang-22
i386       buildonly-randconfig-002-20260730    gcc-14
i386       buildonly-randconfig-003-20260730    gcc-14
i386       buildonly-randconfig-004-20260730    clang-22
i386       buildonly-randconfig-004-20260730    gcc-14
i386       buildonly-randconfig-005-20260730    gcc-14
i386       buildonly-randconfig-006-20260730    gcc-14
i386                          randconfig-001    gcc-14
i386                 randconfig-001-20260730    gcc-14
i386                 randconfig-002-20260730    gcc-14
i386                 randconfig-003-20260730    gcc-14
i386                 randconfig-004-20260730    gcc-14
i386                 randconfig-005-20260730    gcc-14
i386                 randconfig-006-20260730    gcc-14
i386                 randconfig-007-20260730    gcc-14
i386                 randconfig-011-20260730    clang-22
i386                 randconfig-012-20260730    clang-22
i386                 randconfig-013-20260730    clang-22
i386                 randconfig-014-20260730    clang-22
i386                 randconfig-015-20260730    clang-22
i386                 randconfig-016-20260730    clang-22
i386                 randconfig-017-20260730    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260730    clang-24
loongarch            randconfig-002-20260730    clang-24
m68k                      m5249evb_defconfig    gcc-16.1.0
mips                         ath25_defconfig    clang-24
mips                decstation_r4k_defconfig    gcc-16.1.0
mips                          ip30_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260730    clang-24
nios2                randconfig-002-20260730    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-14.3.0
parisc               randconfig-001-20260730    gcc-14.3.0
parisc               randconfig-002-20260730    gcc-14.3.0
powerpc              randconfig-001-20260730    gcc-14.3.0
powerpc              randconfig-002-20260730    gcc-14.3.0
powerpc64            randconfig-001-20260730    gcc-14.3.0
powerpc64            randconfig-002-20260730    gcc-14.3.0
riscv                randconfig-001-20260730    gcc-15.2.0
riscv                randconfig-002-20260730    gcc-15.2.0
s390                 randconfig-001-20260730    gcc-15.2.0
s390                 randconfig-002-20260730    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260730    gcc-15.2.0
sh                   randconfig-002-20260730    gcc-15.2.0
sh                          se7705_defconfig    gcc-16.1.0
sparc                         randconfig-001    clang-24
sparc                randconfig-001-20260730    clang-24
sparc                randconfig-002-20260730    clang-24
sparc64              randconfig-001-20260730    clang-24
sparc64              randconfig-002-20260730    clang-24
um                   randconfig-001-20260730    clang-24
um                   randconfig-002-20260730    clang-24
x86_64              buildonly-randconfig-001    gcc-14
x86_64     buildonly-randconfig-001-20260730    gcc-14
x86_64     buildonly-randconfig-002-20260730    gcc-14
x86_64     buildonly-randconfig-003-20260730    gcc-14
x86_64     buildonly-randconfig-004-20260730    gcc-14
x86_64     buildonly-randconfig-005-20260730    gcc-14
x86_64     buildonly-randconfig-006-20260730    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    clang-22
x86_64               randconfig-001-20260730    clang-22
x86_64               randconfig-002-20260730    clang-22
x86_64               randconfig-003-20260730    clang-22
x86_64               randconfig-004-20260730    clang-22
x86_64               randconfig-005-20260730    clang-22
x86_64               randconfig-006-20260730    clang-22
x86_64               randconfig-011-20260730    clang-22
x86_64               randconfig-012-20260730    clang-22
x86_64               randconfig-013-20260730    clang-22
x86_64               randconfig-014-20260730    clang-22
x86_64               randconfig-015-20260730    clang-22
x86_64               randconfig-016-20260730    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260730    gcc-12
x86_64               randconfig-071-20260730    gcc-14
x86_64               randconfig-072-20260730    gcc-12
x86_64               randconfig-072-20260730    gcc-14
x86_64               randconfig-073-20260730    gcc-12
x86_64               randconfig-073-20260730    gcc-14
x86_64               randconfig-074-20260730    gcc-12
x86_64               randconfig-074-20260730    gcc-14
x86_64               randconfig-075-20260730    gcc-12
x86_64               randconfig-075-20260730    gcc-14
x86_64               randconfig-076-20260730    gcc-12
x86_64               randconfig-076-20260730    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260730    clang-24
xtensa               randconfig-002-20260730    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
