Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55251FECCD
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785634557; cv=none; b=e5vbbdI5zg3X+Q5rbgPvZzXCbF9yEwoWHUTC5z9NUQdJyEeoeh928xGcZVfeuj8YxjBo3jMmytuQMleuLzQAkKO+DkSr7OmKe1C7otFcstywoNrFKtGV7OAk2y3rIu9yfoi7te1WW7qrfRcXmqEqAqmQvRKH3UBYqixvLozUBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785634557; c=relaxed/simple;
	bh=Y0dSuVdTt5NhToWYa+yzjKc0Th0rjfMU7ou4n2Gca70=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Q08BEjBf82zaU2Bgd84/Z5/UHmukOpfyTMWOGn5iuLMNCgOl/ju+NmWmIPkH4sg4FQJCgnR57qXow712Vq8trqf4sfBrPn5XpaqI9ohhmVwp4L7Kh8N0pZRLONVralBHzIkMK4z9/A0wvtOnOpCpDjCzHAl7se+YzhLbZMea4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhkhZlTf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhkhZlTf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785634555; x=1817170555;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y0dSuVdTt5NhToWYa+yzjKc0Th0rjfMU7ou4n2Gca70=;
  b=jhkhZlTfoPhb6RrbcSqlmR09SUf1umG/j0gpxag5TSZclLaFn4ymge1l
   EgSHUBrJDqkejp5g62iSa1Uz/taYXrCqksHehusju/C7kcbt7SjQnqYMf
   7hR68g3UabizpRqVoGaSzT6ggnaCBRJ8pzPkl9jcyfimhwsQzWaeQ8wgH
   5WX4SQNULAi8J0UMtUFgYq0ggyapqR6RBe3t9XPLqKeFQpj3X5Io14Mx0
   YL3/3q9YD7Z7Ig3ps8zg89uvEv9DH/otnW8N+vqg8VMN7KGHMjl8dWZ2V
   ZSSjwMzhw0l0er+0KQxRDJYypJUvOhj+4wKyOE1SXV1LP4BAmW4Mp141P
   Q==;
X-CSE-ConnectionGUID: ral1evP7RmGGx4BKC93gnA==
X-CSE-MsgGUID: yuIQC/QbT0C5Xw2IfJehIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11862"; a="96575678"
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="96575678"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 18:35:51 -0700
X-CSE-ConnectionGUID: xz2OiYJkRUW7h5b7aDJTOQ==
X-CSE-MsgGUID: TcflsarsQKOkA+apjIXJNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="285518303"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 01 Aug 2026 18:35:50 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqL7D-000000004EB-3YO3;
	Sun, 02 Aug 2026 01:35:47 +0000
Date: Sun, 02 Aug 2026 09:35:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 ce3294cef61c85559059a9a49fa99a38df55d633
Message-ID: <202608020925.TlckVF9K-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: ce3294cef61c85559059a9a49fa99a38df55d633  PCI: Use %pe format specifier to print error pointers

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
sh                       sh7757lcr_defconfig    gcc-16.1.0
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
