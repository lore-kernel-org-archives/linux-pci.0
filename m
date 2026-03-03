Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7CC34575F
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580359; cv=none; b=RdoZG05niG9Q+NwGaFIaYDmwDXNY8DlFoSifujZfIYbqKGk/FiLGWGg6b9xjwcMqe4osxod8jbCSdszisXqjmyTL/cmgkLWraWjnCrdM6KXbK7Wn9GlhigUT2yr+f+W23yUZJWnAoImED4dEYA4W5vo6kos8mSYd4Zl/WWw/cxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580359; c=relaxed/simple;
	bh=7zOvCQawphsGJjpWhXSfKvIFQswEY4RCSMydhfWhpG0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ujygOU4LnfXCGAE2Hpn5eTJUWU2VgAc5/Ho+J+q0iSTF0QmA7eGJ0tg3UCVTfyVeOPcKU/kbklb9As8MKJdcUR8mB/avFNayOAePrrAvDBRizgUMcVLm+hTwfr0anNjNI5EvCCTbkGvCuDDgFc/lQgqd4YEef7I64UtLTe+ezs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpHzIldk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpHzIldk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772580357; x=1804116357;
  h=date:from:to:cc:subject:message-id;
  bh=7zOvCQawphsGJjpWhXSfKvIFQswEY4RCSMydhfWhpG0=;
  b=GpHzIldkWzZrBkEX45tEIv/9jMHPPCx6vg3e6/Do0lZN2wFF6sgcv5D+
   HdPC3P7rLwOSif9tKIckB3IzLJfPNIxiQ97BsmLPjLuc7vIMWgm/RIbZY
   1oD7WPR4H0A9aKdHNMSvNtCqnhdxv/Id/LBddYODDDe4gA6WN5oKkgrtQ
   QDn988HQWuJbQ8eeXe0Q+qE4tJobQpZSSK751gr+jtKbIEY/XEiH7b2hl
   hHaS4r2gZ2/HCqPGcatXME0Ge0Yh8kyOQhSmdQUD0LXp0D2hsJ6gy4poR
   2IevGmhmvGSbS9bM6f+yXs8e/q6MND7lPpc3H6G6/B4ntCbEWTEnLEQkU
   w==;
X-CSE-ConnectionGUID: 8LyUtTvAQTmo8uAwF/Rsxg==
X-CSE-MsgGUID: yzuu2p/NQ8qOh1M9N5/uvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77239886"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="77239886"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 15:25:57 -0800
X-CSE-ConnectionGUID: Q6YrgBryS92HtT1+LHNJmw==
X-CSE-MsgGUID: QOH5dnX9Q2CN5mPlSdeNWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="217390292"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 03 Mar 2026 15:25:56 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxZ7h-000000002zJ-1LRZ;
	Tue, 03 Mar 2026 23:25:53 +0000
Date: Wed, 04 Mar 2026 07:25:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:wip/2603-farhan-s390-err-v10] BUILD SUCCESS WITH
 WARNING d72875f0a4958f51f7196e6fada9357799418a52
Message-ID: <202603040713.Ir1Cv4B0-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2603-farhan-s390-err-v10
branch HEAD: d72875f0a4958f51f7196e6fada9357799418a52  vfio: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202603031955.4B1fQXSq-lkp@intel.com

    drivers/pci/slot.c:40:19: warning: result of comparison of constant -1 with expression of type 'u16' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]

Warning ids grouped by kconfigs:

recent_errors
|-- arm64-allmodconfig
|   `-- drivers-pci-slot.c:warning:result-of-comparison-of-constant-with-expression-of-type-u16-(aka-unsigned-short-)-is-always-false
|-- loongarch-allmodconfig
|   `-- drivers-pci-slot.c:warning:result-of-comparison-of-constant-with-expression-of-type-u16-(aka-unsigned-short-)-is-always-false
|-- loongarch-allnoconfig
|   `-- drivers-pci-slot.c:warning:result-of-comparison-of-constant-with-expression-of-type-u16-(aka-unsigned-short-)-is-always-false
|-- riscv-allmodconfig
|   `-- drivers-pci-slot.c:warning:result-of-comparison-of-constant-with-expression-of-type-u16-(aka-unsigned-short-)-is-always-false
|-- riscv-allyesconfig
|   `-- drivers-pci-slot.c:warning:result-of-comparison-of-constant-with-expression-of-type-u16-(aka-unsigned-short-)-is-always-false
|-- s390-allmodconfig
|   `-- drivers-pci-slot.c:warning:result-of-comparison-of-constant-with-expression-of-type-u16-(aka-unsigned-short-)-is-always-false
|-- sparc64-allmodconfig
|   `-- drivers-pci-slot.c:warning:result-of-comparison-of-constant-with-expression-of-type-u16-(aka-unsigned-short-)-is-always-false
|-- um-allmodconfig
|   `-- drivers-pci-slot.c:warning:result-of-comparison-of-constant-with-expression-of-type-u16-(aka-unsigned-short-)-is-always-false
|-- x86_64-allmodconfig
|   `-- drivers-pci-slot.c:warning:result-of-comparison-of-constant-with-expression-of-type-u16-(aka-unsigned-short-)-is-always-false
|-- x86_64-allyesconfig
|   `-- drivers-pci-slot.c:warning:result-of-comparison-of-constant-with-expression-of-type-u16-(aka-unsigned-short-)-is-always-false
`-- x86_64-rhel-9.4-rust
    `-- drivers-pci-slot.c:warning:result-of-comparison-of-constant-with-expression-of-type-u16-(aka-unsigned-short-)-is-always-false

elapsed time: 1399m

configs tested: 54
configs skipped: 1

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
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
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

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
