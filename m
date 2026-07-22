Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D663AA4E9
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712243; cv=none; b=LmXOkVxKlqkfvERnyWuDBi9Q5L+zCekVRODWl2O+MeZmBicYfO8oNTksuIS2DR/OcKZl8GmEA7kq9gTPBEaDaZWRtOyzYT3mG94rtMB4+j1sR72rDwu23fJ1fz9UPtFiZYkbcUueQtNuRULIYccaaCZyPePUoU5ksUCOegXrQnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712243; c=relaxed/simple;
	bh=PVQBZB6vDJT4l2Zlcpr5ImX3VGIMQ5EcTnrW3XD0a6E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZagLwQ4dBhowRAX7nUs6j1GirmPdC5oHexuxj4bVUPcBV8H/ojmgfmAcL+I/8TfOYC10XC6HIVAqapvMR7KovBDYRUaomxV1/OeFRkb46tuLvRaHTvB5BP1xN9unLuRjiZ73PQe5ScEtQIvK1u1UziU5O6EYebzYiTSU2V/UO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqyQsw9h; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqyQsw9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784712242; x=1816248242;
  h=date:from:to:cc:subject:message-id;
  bh=PVQBZB6vDJT4l2Zlcpr5ImX3VGIMQ5EcTnrW3XD0a6E=;
  b=lqyQsw9hcqufHjYgsopypGoENpJo9vnYLC38JpUajL6I710wCi8HYIXR
   CmmznfBT0VWmJOLoVi8yL9amq7sK5mPxAaV94LqXOvejXEycXm41zd3B3
   AxuzhnFCx6WgNJ3RLkkYtLyuhsk0PPbBw6aheoL9nHUzTlRrtRGoomHm9
   td1zwSYiYN/ST9ctNYwK8Td2/co6kKh+MzmOB2b6WXIiDQ3avm0QYZ1WY
   0FSIUSjnSlCtzEpqdqCZQliXmI8yM/p8yyljvBkl7qnKMNcN7amGNIYsy
   S9YVHScdMLu18RNSGaGF541ghXqzmnREMSj3u46+VhftKYDe5RIsFZ1lK
   A==;
X-CSE-ConnectionGUID: QRFn7E4fQXeYOMvEmKM3vw==
X-CSE-MsgGUID: hUh5vUwqTKSOnrQ5SZ6IUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96715779"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="96715779"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 02:24:02 -0700
X-CSE-ConnectionGUID: OOgq+rRTSWqvPm2rbVEQjQ==
X-CSE-MsgGUID: u/Ih+XpfSnyJ4dszPFGbHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="254643864"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 22 Jul 2026 02:24:00 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wmTBG-00000000Yc1-00zc;
	Wed, 22 Jul 2026 09:23:58 +0000
Date: Wed, 22 Jul 2026 17:23:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:virtualization] BUILD SUCCESS
 062fb7f816439da6bf3860386889343482a66bd4
Message-ID: <202607221742.XuqJw6Dz-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git virtualization
branch HEAD: 062fb7f816439da6bf3860386889343482a66bd4  PCI: Add ACS quirk for Pericom PI7C9X2G608 switches [12d8:2608]

elapsed time: 783m

configs tested: 83
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260722    gcc-12.5.0
arc                  randconfig-002-20260722    gcc-14.3.0
arm                  randconfig-001-20260722    clang-19
arm                  randconfig-002-20260722    clang-24
arm                  randconfig-003-20260722    clang-24
arm                  randconfig-004-20260722    clang-24
arm                        s3c6400_defconfig    gcc-16.1.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260722    gcc-10.5.0
hexagon              randconfig-001-20260722    clang-24
hexagon              randconfig-002-20260722    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260722    clang-22
i386       buildonly-randconfig-002-20260722    clang-22
i386       buildonly-randconfig-003-20260722    clang-22
i386       buildonly-randconfig-004-20260722    gcc-13
i386       buildonly-randconfig-005-20260722    clang-22
i386       buildonly-randconfig-006-20260722    clang-22
i386                 randconfig-001-20260722    gcc-14
i386                 randconfig-002-20260722    gcc-14
i386                 randconfig-005-20260722    gcc-14
i386                 randconfig-007-20260722    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260722    gcc-16.1.0
loongarch            randconfig-002-20260722    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260722    gcc-8.5.0
nios2                randconfig-002-20260722    gcc-8.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260722    gcc-9.5.0
parisc               randconfig-002-20260722    gcc-8.5.0
powerpc              randconfig-001-20260722    gcc-8.5.0
powerpc              randconfig-002-20260722    clang-18
powerpc64            randconfig-001-20260722    gcc-8.5.0
powerpc64            randconfig-002-20260722    clang-24
riscv                randconfig-002-20260722    gcc-10.5.0
s390                 randconfig-001-20260722    gcc-13.4.0
s390                 randconfig-002-20260722    gcc-11.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260722    gcc-16.1.0
sh                   randconfig-002-20260722    gcc-16.1.0
sparc                randconfig-001-20260722    gcc-15.2.0
sparc                randconfig-002-20260722    gcc-16.1.0
sparc64              randconfig-001-20260722    gcc-11.5.0
sparc64              randconfig-002-20260722    gcc-9.5.0
um                   randconfig-001-20260722    gcc-14
um                   randconfig-002-20260722    clang-24
x86_64     buildonly-randconfig-001-20260722    clang-22
x86_64     buildonly-randconfig-002-20260722    gcc-14
x86_64     buildonly-randconfig-003-20260722    gcc-14
x86_64     buildonly-randconfig-004-20260722    clang-22
x86_64     buildonly-randconfig-005-20260722    gcc-14
x86_64     buildonly-randconfig-006-20260722    clang-22
x86_64               randconfig-001-20260722    clang-22
x86_64               randconfig-002-20260722    gcc-14
x86_64               randconfig-003-20260722    gcc-14
x86_64               randconfig-004-20260722    gcc-14
x86_64               randconfig-005-20260722    gcc-14
x86_64               randconfig-006-20260722    clang-22
x86_64               randconfig-011-20260722    clang-22
x86_64               randconfig-012-20260722    clang-22
x86_64               randconfig-013-20260722    gcc-14
x86_64               randconfig-014-20260722    clang-22
x86_64               randconfig-015-20260722    gcc-14
x86_64               randconfig-016-20260722    clang-22
x86_64               randconfig-071-20260722    clang-22
x86_64               randconfig-072-20260722    clang-22
x86_64               randconfig-073-20260722    clang-22
x86_64               randconfig-074-20260722    clang-22
x86_64               randconfig-075-20260722    clang-22
x86_64               randconfig-076-20260722    clang-22
xtensa               randconfig-001-20260722    gcc-8.5.0
xtensa               randconfig-002-20260722    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
