Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3132DF144
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550749; cv=none; b=pP4OF+fO2Hr8KT/f6osqwrr47R623u9JGx6I+FUvwAhT86AL9Hos3qAjlaqTFQEH1PlQ+eSRCuJ27jHx7MfdOPQWEbgiAsgL46mUN6UfgKFof7QyjELAfWOJuZr7mRIrFpDFEZkdg4+jj31+7Le64VSPk2cCo5HoOdqX0vvN4fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550749; c=relaxed/simple;
	bh=9m0Blrtk3S4qTrOUsN+u+5DNUGNSAQDGSODTNLlJOxw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=U+JIqBd98swyOJNwoirjdTweH6jZUNRJ00Oj0/GYKQUYYmLl2y7uO2CkxJLejo5qZE726yXMPcQSVJTjFuNca+ywlE4EMQHCYxo6nZS2aY0VHEmiS4PpYEX6FDAgOu45K3tFnRWLRkHHTnYY0Oi5hZgdMn/2p/Bidy8UF9dGgkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZM9oMDLO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZM9oMDLO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772550746; x=1804086746;
  h=date:from:to:cc:subject:message-id;
  bh=9m0Blrtk3S4qTrOUsN+u+5DNUGNSAQDGSODTNLlJOxw=;
  b=ZM9oMDLO0E3KDiuSgaxeID3dtqc1cv661oqJnGxd3O6Gfg26P0BDVel0
   0v8q8N2BUQSGHtI2ttXQsIQ5q6JR3cQy+1MivVIoUtxnftRdBTIUHKSnG
   hfPKQVHoCNQuLAYt7mglyfh+qPhkPrEf/oZ63+bLxCfTA3HDZIE0oyuO1
   VxRYimdbp+9cbUWAJBLD53WlgEQzG1UDLWfzgIC43G4j2dOwlBKHYkBC0
   ZehS8lJdz+7R+HyJylGnvobk8x9OE/WdTd8LcLldh63MZzG4OLLYLMQQe
   xNslVoTFzWyNWvMnd9sXU4PStJ2sUQaMzOoXrh3XeidjuLEKBNO9sA6NX
   g==;
X-CSE-ConnectionGUID: y8kdSdNJQmCeglQDuU+vhg==
X-CSE-MsgGUID: 26bx28yjSaO/9CLN7ns3TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="72790769"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="72790769"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 07:12:25 -0800
X-CSE-ConnectionGUID: TeCOfO/PTmSh2RSdXMd3mg==
X-CSE-MsgGUID: 7P56yZoNSwGBSRFYRDxkYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="218001219"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 03 Mar 2026 07:12:23 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxRQ4-000000002Ph-0ZXM;
	Tue, 03 Mar 2026 15:12:20 +0000
Date: Tue, 03 Mar 2026 23:12:16 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 5e5ea39ff55297fc9d6338f26346c2a7738a78ea
Message-ID: <202603032309.BI2HO0J7-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 5e5ea39ff55297fc9d6338f26346c2a7738a78ea  PCI: dwc: Remove not-going-to-be-supported code for Baikal SoC

elapsed time: 1485m

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
