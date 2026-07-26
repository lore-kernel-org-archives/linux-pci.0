Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CE73314C4
	for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785049770; cv=none; b=cmQzg49q+eClx3pBdy3t4t/JPPWCADrEFsjQrO8Vw3LNVsgCDbAtGfhg+Y15gerABsLbpMS8H8WtAPdtAojzKcWNJfeqYNik5gYm2Gi5FVuYiMs/rlZditTobjtISDml5+Zw9G+D3L3wFsDj+JLRJm9kh0ZTjzuo+xufxFmIlhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785049770; c=relaxed/simple;
	bh=mUlJyyxrhFMVRA+NjmLx3CEfkgkAx0yb8E8kknw7ECQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GgFDgx19kPW01yJEpmfjEinZ0LAJjxnz9XaggTBLePXJaDKRudDt9AI6d1b9lUDvsctyUleGXLHkSWJfZpy3BlwUoQhHjgt++SEqqKCpkoVlbeGoYp2TsOU/jz0BzUAxoQcf7Hc65lFUQf3d3bnkXq1Uc+kzcy6SIqZJUHuLnwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kiuRSRmb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kiuRSRmb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785049769; x=1816585769;
  h=date:from:to:cc:subject:message-id;
  bh=mUlJyyxrhFMVRA+NjmLx3CEfkgkAx0yb8E8kknw7ECQ=;
  b=kiuRSRmbamYC99yzmFBvq7Mg9b0jhcFMvQG/bE2QDG3/eF3Z8RDWbApR
   aKJIGPpVvwIWLaeWyCQYNKfvjA64hQiaIfOtIZ1k1Q/b+KpjKxL7TuQ8x
   pcTJe23sNquTiKNw9htiWRggYqkZ1v8FhrDOXtd5pdu7rndCaQED0CeSp
   K9PxNGiMaqx7Bl8+BXAXaPvaTYAeTL7OfFki1zYA0/N9/zAaN5uYteBGC
   XY961fMsFDkrFqh2ZPPBGjJUV+BMzSVEkbfazZo+c5JUJ4pUpH3CHUjIn
   4bbRDBxMaciBN/IXdLkQWyyvZ7cQVYlKBZ5DTmfjKCC5SET+zwJEUJyeF
   w==;
X-CSE-ConnectionGUID: 9sBUHxBwTWSn9JkWLRkchw==
X-CSE-MsgGUID: SvPGb6s9Qcy8MenvncJyew==
X-IronPort-AV: E=McAfee;i="6800,10657,11856"; a="85593002"
X-IronPort-AV: E=Sophos;i="6.25,186,1779174000"; 
   d="scan'208";a="85593002"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 00:09:28 -0700
X-CSE-ConnectionGUID: IVWXKzIMQZO/JMLtlYSp8g==
X-CSE-MsgGUID: FkvfLiwRSS67SFaiJ/b3JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,186,1779174000"; 
   d="scan'208";a="264095437"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 26 Jul 2026 00:09:26 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wnszB-00000000cMd-0LEo;
	Sun, 26 Jul 2026 07:09:23 +0000
Date: Sun, 26 Jul 2026 15:08:56 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 7d889f5b55e0da9b12238f724018101b6391474e
Message-ID: <202607261544.MUb6QegE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: 7d889f5b55e0da9b12238f724018101b6391474e  PCI/AER: Support Advisory Non-Fatal Errors

elapsed time: 857m

configs tested: 38
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
arc                 randconfig-001    gcc-8.5.0
arc        randconfig-001-20260726    gcc-8.5.0
arc        randconfig-002-20260726    gcc-10.5.0
arm        randconfig-001-20260726    gcc-10.5.0
arm        randconfig-002-20260726    clang-20
arm        randconfig-003-20260726    clang-24
arm        randconfig-004-20260726    clang-24
csky                  allmodconfig    gcc-16.1.0
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
loongarch  randconfig-002-20260726    gcc-14.3.0
mips                 gpr_defconfig    clang-24
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
parisc     randconfig-002-20260726    gcc-15.2.0
riscv      randconfig-001-20260726    clang-24
riscv      randconfig-002-20260726    clang-24
s390       randconfig-001-20260726    clang-24
s390       randconfig-002-20260726    clang-24
sh                       defconfig    gcc-16.1.0
sh         randconfig-001-20260726    gcc-16.1.0
sh         randconfig-002-20260726    gcc-16.1.0
sparc      randconfig-001-20260726    gcc-8.5.0
sparc      randconfig-002-20260726    gcc-8.5.0
sparc64    randconfig-001-20260726    gcc-8.5.0
sparc64    randconfig-002-20260726    clang-24
um         randconfig-001-20260726    clang-24
um         randconfig-002-20260726    gcc-14
xtensa     randconfig-001-20260726    gcc-8.5.0
xtensa     randconfig-002-20260726    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
