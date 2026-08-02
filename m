Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544D021C16A
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785634677; cv=none; b=HMegqtOHrjhuqGlbAw8dxzk8Yro/tuhU0xinV/gTdHaRKzeky3E4ubEryvQmHjWXWipDcpxMAe90DLyJpVnIRTytBuKZQpPOosPthNb3fbc7cn9uPgKOeDn1pFYx8fGdNj6xJUM1XBMQPSM/zwJkRNVt/QMELl3ZMiOtBiuyybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785634677; c=relaxed/simple;
	bh=I5/Uv56YVw5UYZp6nHQGmXrZxuse1BETe+DMqhKHY08=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ORRn3SmTL2m/tygO/mwrtjLRUyYnp0U9C+Y7JnZqwfSLcyq/49uA031L+dFk9PI5/HRKmjPJ1ibesEgyQaCt3y413fo53w96w1GzCIVShps8R234mwGX25wU2o4Bm6FAlOMaLrEOVPHK7L1HjVHQb7WAb6Vj9SRnzCJhRJl1CiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iVLTJuyj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVLTJuyj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785634676; x=1817170676;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I5/Uv56YVw5UYZp6nHQGmXrZxuse1BETe+DMqhKHY08=;
  b=iVLTJuyj5a6SNDT9YdmQiZf02mh8razuyE+I2fPfprpCNQiKQ7vRwWUl
   dQFOOQtFxXWTyhoDAsO0rqI+b25JOqxgms96k1GBXGg/0A0eZsZsOPR5a
   ZuoQMalx88W7ikZNqMubAlSgUCNdkTcjdjBbw6jhFpErZcBShrmZkYldx
   M7yWAaxwibG2lqgTs9J14pzc/ZEh13UKdiFMTm9+2VoGUwdW6Re93w8GL
   82u+3h5OCgJ3nBSJ77XgL5krADSP5dCw/TeyS/fm2FGG6rz+ciIJs8VS+
   fXl/0UQqzPRdh3zO+XtODDRjAisq8eE7ZMKt0sdAyTr6BEWspcq8lNeT+
   A==;
X-CSE-ConnectionGUID: aNK2S39vSOaadQJX1ucj/g==
X-CSE-MsgGUID: EQtbSyRLSpyaAyoGVWjJAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11862"; a="85983983"
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="85983983"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 18:37:53 -0700
X-CSE-ConnectionGUID: Krek8Sm8SSqFCdiAShaAGw==
X-CSE-MsgGUID: Q7FNb7VIS1eH0pR/2TjnBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="260956817"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 01 Aug 2026 18:37:52 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqL9B-000000004Ea-2oQu;
	Sun, 02 Aug 2026 01:37:49 +0000
Date: Sun, 02 Aug 2026 09:37:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:sysfs] BUILD SUCCESS
 d27b03dbcab0bfdd8b734de4fbaf4128689d988d
Message-ID: <202608020911.f9dNqgJI-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git sysfs
branch HEAD: d27b03dbcab0bfdd8b734de4fbaf4128689d988d  PCI/sysfs: Add legacy I/O and memory attribute macros

elapsed time: 747m

configs tested: 115
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
i386       buildonly-randconfig-001-20260801    clang-22
i386       buildonly-randconfig-001-20260802    gcc-14
i386       buildonly-randconfig-002-20260801    clang-22
i386       buildonly-randconfig-002-20260802    gcc-14
i386       buildonly-randconfig-003-20260801    clang-22
i386       buildonly-randconfig-003-20260802    gcc-14
i386       buildonly-randconfig-004-20260801    clang-22
i386       buildonly-randconfig-004-20260802    gcc-14
i386       buildonly-randconfig-005-20260801    gcc-14
i386       buildonly-randconfig-005-20260802    gcc-14
i386       buildonly-randconfig-006-20260801    gcc-14
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
riscv                randconfig-002-20260802    clang-24
riscv                randconfig-002-20260802    gcc-13.4.0
s390                 randconfig-001-20260802    clang-24
s390                 randconfig-001-20260802    gcc-13.4.0
s390                 randconfig-002-20260802    gcc-13.4.0
s390                 randconfig-002-20260802    gcc-8.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260802    gcc-11.5.0
sh                   randconfig-001-20260802    gcc-13.4.0
sh                   randconfig-002-20260802    gcc-13.4.0
sparc                randconfig-001-20260802    gcc-12.5.0
sparc                randconfig-002-20260802    gcc-12.5.0
sparc64                         alldefconfig    gcc-16.1.0
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
x86_64               randconfig-071-20260802    gcc-14
x86_64               randconfig-072-20260802    clang-22
x86_64               randconfig-072-20260802    gcc-12
x86_64               randconfig-073-20260802    gcc-12
x86_64               randconfig-073-20260802    gcc-14
x86_64               randconfig-074-20260802    gcc-12
x86_64               randconfig-074-20260802    gcc-14
x86_64               randconfig-075-20260802    clang-22
x86_64               randconfig-075-20260802    gcc-12
x86_64               randconfig-076-20260802    gcc-12
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260802    gcc-12.5.0
xtensa               randconfig-002-20260802    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
