Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F0C2765DF
	for <linux-pci@vger.kernel.org>; Sun,  6 Sep 2026 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788730494; cv=none; b=rJ07MqB753NDpX+rnUWUqUgfoQkqu33BH9f9P8dFCgumFaM7p8QxpLxOUzNOycibMMzyWJ2KvB4xRqawTbNLM9LcisIEldiQooZ0wCD+8oWIZ6dlku1siBTWjmMam98sVAQWBlFMWAgY+Cj/NnD3dk6tHdZV4VrvZq51ldr6y4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788730494; c=relaxed/simple;
	bh=u+zhZPfBR7288T6OYaL2BRmzXbE82tDIQiJkWon2Bms=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZXIcTZBB9PkUPjIYIXGni6kDiRAWktDWylvMhAXgRTIZHh8YJIzSnfBXeze4PTV50Qt1Itn3FzdJbd/GT0FAgnoiwH0lM+tViE5EwHbhkTcKqTHt1Gkl/4qUqQF5PI6c9D0F6MElwDieU9a6mWS85zGD6Tp8sGKxYSe7gAy4My4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GK2dMOAD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GK2dMOAD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788730492; x=1820266492;
  h=date:from:to:cc:subject:message-id;
  bh=u+zhZPfBR7288T6OYaL2BRmzXbE82tDIQiJkWon2Bms=;
  b=GK2dMOADxc1ZhY53KiLpzxs4ltU/1sAWAtLwWQiwqVMPZwxM6iLpSCAB
   wzFatouZTQUxYT0yzDdWBCEmE5BWQ1WqesDW+sW2NjF+57+GLEz4qcpIQ
   dZVI4qp5ww2cma/f/z7d3bYWFDlGt5m9UXOVysg2FzRR6pY0a7SFqABAf
   2c1uyK4QnpLqvbPSNFnap48xrQPWzUq9E2K/Xqb4rXJEKhPKM7PLUchi4
   46/Sr+/z8pNV6OSoMhaBupp/qYPQ5UYFGzYQwWYKhjcTzjkyvMwyrAmHY
   Ne4ghToFZfKKjlf6Q7Uzr87rl6fEQwkAr/U6hQWI7suBhvDb0jbh2+tTR
   A==;
X-CSE-ConnectionGUID: LN6Cnr6gQbK9+uOm4sK+tg==
X-CSE-MsgGUID: 9/+I7OzfR5m6FY850reGxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="92839097"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="92839097"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 14:34:51 -0700
X-CSE-ConnectionGUID: y0tTXb8yQXSSJc27TjtCcg==
X-CSE-MsgGUID: UB54aDinSASvrdQUm9RNEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="295412333"
Received: from lkp-server01.sh.intel.com (HELO 73f3364bc37e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 06 Sep 2026 14:34:49 -0700
Received: from kbuild by 73f3364bc37e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3KVj-000000002cR-1nSy;
	Sun, 06 Sep 2026 21:34:47 +0000
Date: Mon, 07 Sep 2026 05:34:29 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctrl] BUILD SUCCESS
 028f86457e822ab9de5b0d6d23efddc1b8b54ae1
Message-ID: <202609070527.hssGMrxn-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctrl
branch HEAD: 028f86457e822ab9de5b0d6d23efddc1b8b54ae1  PCI/pwrctrl: tc9563: Allow RESX reset assertion to sleep

elapsed time: 4357m

configs tested: 53
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    gcc-16.1.0
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
m68k         allyesconfig    gcc-16.1.0
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2         allnoconfig    clang-24
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    clang-24
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
