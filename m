Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA941A903
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551647; cv=none; b=k1/nr83iOMeDX4lq0Qj1KTjL7+7PSN5glSLkFVjIA01TqdNRzVL0u8C9mEk5dsPzrdkoEJu/eBGcYCZip9hQHaTXS2uuPWSAMCFUZfRtT3JdttjJmli7jMyw6iRD4Bq8jiIf6eDKvvLjwZ6PUw9wt60n2tC9J8vlvTdW9+OI8t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551647; c=relaxed/simple;
	bh=NcnNyziZGbKqB9/IQ97Pn/Zd3wi6XElCgi8oVMx4Z+0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qCXbyTMWjch8uiEm2fhqvHCltvouOy3iwwLcFMrfvcA3PNFVqCeacxTpwPNALllwNOgnofKSAb7evpZVDku4yacwlxg+04+AKSVIfeFfHzPoH2GVjV2ey/i/2Jk5mdO2JHnozJ1PZv+f60tZZ7iD/sFAwVoIpBtR8bAaumHRAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ozl0xrmi; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ozl0xrmi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788551643; x=1820087643;
  h=date:from:to:cc:subject:message-id;
  bh=NcnNyziZGbKqB9/IQ97Pn/Zd3wi6XElCgi8oVMx4Z+0=;
  b=Ozl0xrmiqE+9evGXkUnEA9xSSn56Hwf48E9JtIvYyK0OoU3vfDiWEBPB
   AhTvMPEA64oGj7vZXfA7r/N6nqIW9Y8CitqQeoZnYzAmDVgQeB1oP27WV
   L9aXO2+v9LaaQ5AGqc2xJq78lmFr6JPDStOZap1Zve/J+QYs6OT/Qa0lP
   qBp3ooXvOndS+6CleUjISn3UvmKbYqecXPuytOnrNmjP6PEmV7fz0yXw1
   5GYBdC4Mx5a8SMyLoK54wjm0FdIkVz7mEm2XJFSGyC3flBLANIsNlCTEX
   EsQlEku0NZmg27gDjeAYsRi3B6cS87ApKebDunOuBe/aWxXTr+NWWsOn0
   Q==;
X-CSE-ConnectionGUID: bh1zL5iPQK2Q4xmluZSHZA==
X-CSE-MsgGUID: qrM03XFkQqe37ZJxZvwaEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="111833086"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="111833086"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 12:53:59 -0700
X-CSE-ConnectionGUID: cxl0UXMRSOqI7XTEmfu/yg==
X-CSE-MsgGUID: 3fDOrrWPRp+9C36C943f3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="266434592"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 04 Sep 2026 12:53:57 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x2Zz0-00000000A7G-34U8;
	Fri, 04 Sep 2026 19:53:54 +0000
Date: Sat, 05 Sep 2026 03:53:07 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:vmd] BUILD SUCCESS
 95ac22dd4bf13373f90bb6d51bcd1fd1d8f5db54
Message-ID: <202609050304.e9e24IKa-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/vmd
branch HEAD: 95ac22dd4bf13373f90bb6d51bcd1fd1d8f5db54  PCI: vmd: Flush initiator posted writes before demuxing interrupts on Meteor Lake

elapsed time: 3309m

configs tested: 65
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    gcc-16.1.0
arm           allnoconfig    clang-17
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    gcc-16.1.0
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    clang-24
hexagon       allnoconfig    clang-24
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-14
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
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
nios2         allnoconfig    clang-24
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-16.1.0
openrisc      allnoconfig    clang-24
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
powerpc       allnoconfig    gcc-16.1.0
riscv         allnoconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    clang-24
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
