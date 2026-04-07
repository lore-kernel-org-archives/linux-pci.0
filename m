Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215BF286D4D
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 20:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775594779; cv=none; b=M/YLexoOC5CfluqVMWn2jfQUUol0moo7MyHf4ip2dkT/Nz5zuS+s60JzxfjMhDZReWLQIt4JGdx3MMaqHQMXd7oLoxGjSonkuo5Brf9ScI0J8wLr56ptyc5bYTv56Px5fnHYukrsCz292KXEe/t53OUniQYlZjFlTKocb5pv30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775594779; c=relaxed/simple;
	bh=OMDbQxgwTvN7M1LP1XrjSE2Bw+S1tQ7FujhnqdsJIb0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=X4hx3VBHVc1mgJP8vTxSI7YyHiTjqSgcb2zWVzlJXc6tsE8Kl/qIPwJW/m5fPg+ZJdYi0WPfWSUq4vlIxAi17Ds48Gbf0JXeUXOndexV40ecJY7BRsTpn0AstK+ZXtbq3NwEZTDAMRCFy0AycoQlOwlez3ZxxzljAximE8ObPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikQqDpCj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikQqDpCj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775594778; x=1807130778;
  h=date:from:to:cc:subject:message-id;
  bh=OMDbQxgwTvN7M1LP1XrjSE2Bw+S1tQ7FujhnqdsJIb0=;
  b=ikQqDpCj14CYUAm4K0vVN3liXt41liPEfb7vw7OSk3CwjZymP8TAzpZr
   4uwuflSZHfUmcsLoMrqEy23Sx93/mFE1aHoiZH8QpDMg75M7AdDGAousD
   aN81Zjy+8PeR5Z7qjvSUjbN10fx/VIhUhTVMaDHkGXKtt+5VvWEu1VVEa
   tNgWoc5iSDufazarBB8lh1BXeOrSuNfc9mivVfnvleFHQ6hpL2vBaS3A/
   rtaVrTdQaO3cKeCQWhHAEHzU/6FqdJlJfW+OROoNLK/ab7otfT+agEl/V
   gdeXFbwhE8LHKarjuxRaQYtkFTKh47yoXtfEG1CBgUsAHrfhwmsTX8c/F
   g==;
X-CSE-ConnectionGUID: bmBK4UWdSO+vuE25ViCfbA==
X-CSE-MsgGUID: 0H7pAFYwQjGREcWcI8SPtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="75740004"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="75740004"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 13:46:16 -0700
X-CSE-ConnectionGUID: xcZSTdM+SwWUsJqXU2dv2w==
X-CSE-MsgGUID: svbxvQntRbCsIEJ6TPC0cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="233236101"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 07 Apr 2026 13:46:15 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wADJM-00000000123-1XZR;
	Tue, 07 Apr 2026 20:46:12 +0000
Date: Wed, 08 Apr 2026 04:45:36 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 06d8a0ad6bc3b7609f14441ea2d2470d9a33b2b5
Message-ID: <202604080428.L9dTUViP-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 06d8a0ad6bc3b7609f14441ea2d2470d9a33b2b5  Merge branch 'pci/misc'

elapsed time: 1336m

configs tested: 54
configs skipped: 1

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
