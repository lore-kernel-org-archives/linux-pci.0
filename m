Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F671FFC48
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322228; cv=none; b=D6XNnVkJ5nmhrcWMtvWMqAE7ySBJgL0aYdeWVq0m6R3vn0Z/MOMrG4CAAstgU/IUieooFXBI0XE07xbJKKjnIG4ux55dY8XpJ76QqQHIu72fjrEmEzktcrS/uLjqhmBDAunxR5UH2CDzaRfarnVh1PLACvSuzZ54qh9m1K8rHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322228; c=relaxed/simple;
	bh=FBoPiUlDoe9JVM5P3owQwXNeUcOm6hAcVvPITx6fQqo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aLYrnH9OMseoJuFpXtbVRUtLKZ4M+7hRNNDPvpvL1Efr/kq4FisJW/WDKlth1Jm1cMBtrnS+DX1olHEAYy0V4zBBAW6mSeQYXpKPOv7pUxFWLaL2FFKGl3iFCex9cM3Yi1NXocOFNiB+7Tmpcl93ePvuOJVkxXReyvZoR5fY5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knvWHTT2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knvWHTT2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782322226; x=1813858226;
  h=date:from:to:cc:subject:message-id;
  bh=FBoPiUlDoe9JVM5P3owQwXNeUcOm6hAcVvPITx6fQqo=;
  b=knvWHTT26Wct8PHJ2PIyeTQlD/IKO7cyrHS5EaqHq4N9T5bcqyrZl27e
   pkC+n32H0DSSCgXgZTITHFwQOJrLoFIMwkiDf9lZLtoGgg7oRLxSbG+SW
   sbYzxUZVyJGYi2MgzMPfRR9IoY8/8Q/M9TxTbM83eRJ97ziv0mZ3OVX3F
   cv8vj6DCXLmEylfPkbPVQPCzp4eJF45gdcm8wRI7A3voNp62FusyQUWHZ
   Byk+BaLNcL/PKAPozWMROAwrLH9Wp/VYp43WC1uo5NsZZWwoC8QOr8YgW
   EgBD0HP/qF49YsT3kuhyM4vxlXregG43Wd4wymVgfLa0ERxd2Tt/Yd12d
   A==;
X-CSE-ConnectionGUID: Q/m+49n/T3CXmHCLeR0KGA==
X-CSE-MsgGUID: yxzu1UnQRpC/Zl4kYpkXMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="86999286"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="86999286"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 10:30:26 -0700
X-CSE-ConnectionGUID: E8+1eiHbQNi8XGGYDNOUfw==
X-CSE-MsgGUID: KqksvORLQK2+rOmUcQNdxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="247573642"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 24 Jun 2026 10:30:23 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcRQX-000000003ZV-39ds;
	Wed, 24 Jun 2026 17:30:17 +0000
Date: Thu, 25 Jun 2026 01:30:00 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:sysfs] BUILD SUCCESS
 92742802ecbf215a2b60dcfd326d2213595010f1
Message-ID: <202606250149.tUKLMi2N-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git sysfs
branch HEAD: 92742802ecbf215a2b60dcfd326d2213595010f1  PCI/sysfs: Use kstrtobool() to parse the ROM attribute input

elapsed time: 1264m

configs tested: 54
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    gcc-16.1.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-16.1.0
arm64        allmodconfig    clang-23
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    clang-23
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-20
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    gcc-16.1.0
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-16.1.0
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-23
s390         allmodconfig    clang-23
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-23
um            allnoconfig    clang-16
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
