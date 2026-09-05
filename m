Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DA1364959
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632459; cv=none; b=NYDc4NorRgJzsQYLIcpTxNmbQEubp50oU5IQTj8a2XhjxYLI8dtv94KDJtUr0Ap1xLvxtu/TH1uJkqAf8mOVryDvzbz9Ft+zGNdFXxle+8b3LnCI9Nt5HbgxRWjh1n9xc1+qHUtbyX2MzCHWsFCfU/4LofdwdN3cB6iUMdx26+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632459; c=relaxed/simple;
	bh=LN36xO3nGwON8P8S1VrSY4J/glLruryVlnSd6RPXy/4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NFX13OxOWn6eo6v5Hs/U6DFNgv7JHdmhPXp7HIUB3U548SVccqAVUWCZTdPPBcL4N8vSG0D5/xlu6quRnhypVAPOfup8M5LIbZPoi9eNMt+EjhFCU9fUK3TZxU1zagv6qME7O0XYGLpJbfRacS0snSVXn+p3gAEDjVLQDd8XKds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BsQfCQB0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BsQfCQB0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788632456; x=1820168456;
  h=date:from:to:cc:subject:message-id;
  bh=LN36xO3nGwON8P8S1VrSY4J/glLruryVlnSd6RPXy/4=;
  b=BsQfCQB0wTGg8NWduKV1iItq0eblVgApKIDK+qAzyrbXOVXLeaAddne4
   /KSWssJnnp9/H3XwjHh7ulYdplma2363zLRXM2ygQk4DAjr4ybUHpV2/D
   VjzN5jUFDZsHLobMxdyuH7LX8hLGAHGqXoFRbIzZpXKCzkj7+O420Hb8P
   Th54dy8McKZxVYufTUt8IzlVdiAmun0lgksOE6hQ1jajs5qeME99/YYAj
   kT5h0ZT9u8u9/c6cTKC8IwEqE0iR5ddT+CaFTeMbargYG4Eeb0tUVseTt
   PyD+AbECFI94divjZ6AcItKkF/iGinsLizKqTIO90dY+6a2kV7Sft3cX6
   A==;
X-CSE-ConnectionGUID: seSfZGATTsqcwsRADOEOhg==
X-CSE-MsgGUID: 7rHd/l5AQgyyZEE9y/3/HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11897"; a="99761597"
X-IronPort-AV: E=Sophos;i="6.25,264,1779174000"; 
   d="scan'208";a="99761597"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 11:20:55 -0700
X-CSE-ConnectionGUID: Z3a6zNvwRYW8qVzDhKCDaw==
X-CSE-MsgGUID: HLiV+n8JRWOEB4bMemBekQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,264,1779174000"; 
   d="scan'208";a="267762006"
Received: from lkp-server01.sh.intel.com (HELO 73f3364bc37e) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Sep 2026 11:20:55 -0700
Received: from kbuild by 73f3364bc37e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x2v0W-000000000x3-2Hil;
	Sat, 05 Sep 2026 18:20:52 +0000
Date: Sun, 06 Sep 2026 02:20:40 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 68fcdf30a1582574fe67e0b02488f8ba0d4d1242
Message-ID: <202609060238.Vw3iBqzs-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 68fcdf30a1582574fe67e0b02488f8ba0d4d1242  PCI: endpoint: pci-ep-msi: Let non-first EPFs use embedded doorbells

elapsed time: 3606m

configs tested: 56
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    clang-17
arm           allnoconfig    gcc-16.1.0
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    clang-24
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-14
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    clang-20
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
