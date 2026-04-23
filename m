Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59A23BED1E
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776932355; cv=none; b=FBeBUrwYzWRHGie0UxnBzbNQMwLxNRRqVBxmsKq0xot/R8oh640mib+tpQDucq77VT+ttkglQCKum9oJ1K1O0w7jiAhwZhGiBszy45ZTGFOBzLtJqTilZqGhilj4MUun00t2yDKb1vfxTfsWM0YYnIXhEqdcSs1it5u0Yxs42Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776932355; c=relaxed/simple;
	bh=EFdlxpCXm9EXfK6IS4axbWtyrAGhmNgXfkFSce6ViDM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BUNoaAUDEmmDkloRc9tS6eH1KzB4ot7D5l030e4o4eg6UeQ0/j9DrMMm3jFHcjFnHgwXtVaM7ZK/qZM6yoNgDEpLkE/CXf8IYIq7srsGZJCKaDVp/cA/ke6v4ni51Wfz8WNWCcJMzGW21saKneVw9mYYQWDZpg2lRbVtpD5GF2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNkrzEGd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNkrzEGd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776932354; x=1808468354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EFdlxpCXm9EXfK6IS4axbWtyrAGhmNgXfkFSce6ViDM=;
  b=FNkrzEGd7R2O7qXqTslB4/dc62fuL9SAdgm+XVYhYyy3e5XvXMGpik/E
   Y1oB7Or8Flp5BfWYwGTHGJaYI0uUYZPoyoX/NUjq6ez+FRO16EZM5hrPj
   ASSY7ETEJNfMJjOB8R9MedgtzaOlbuaFGlmeTUNf6rP/FQ394sdCWAsSe
   WXAIevqJFeo/eIi4d6lwolyzV4NJbNisD8QaPdqpE/CoqpWNeTvGmRQNX
   +qMXsHi16p0AUruODhpp/E8Hl1wqGsGhoawD9ZOgYHs4XqvDqtY9E/93c
   sqeEdXAWBlIvNSuZIz3nzedJV7wDSp2ElgR4ifCu3jdX2qFi5PLuIAIKf
   g==;
X-CSE-ConnectionGUID: jlcY7htIRjOUk+BhfOPyVg==
X-CSE-MsgGUID: /Xmw2LU6QZOiyLYE8uA3Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77779041"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77779041"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 01:19:13 -0700
X-CSE-ConnectionGUID: aCLo9nGwT7ey1JfDlb+wKQ==
X-CSE-MsgGUID: xDknljxYQcaIteR4YoD/kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="229412639"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 23 Apr 2026 01:19:11 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wFpHB-0000000027N-1KQB;
	Thu, 23 Apr 2026 08:19:09 +0000
Date: Thu, 23 Apr 2026 16:18:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:kwilczynski/static-sysfs-attributes-v6] BUILD SUCCESS
 7e2ad92d9e27fe0bd848a0b97afe7a512accc1c3
Message-ID: <202604231622.DgR0zih3-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git kwilczynski/static-sysfs-attributes-v6
branch HEAD: 7e2ad92d9e27fe0bd848a0b97afe7a512accc1c3  PCI/sysfs: Limit BAR resize attribute scope to platforms with PCI mmap

elapsed time: 797m

configs tested: 53
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
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-23
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
xtensa       allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
