Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EEE4A99DA
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788375593; cv=none; b=gC+2hLhS0MRPhr7Z64DvwO6Qw6wgVWLXBuDQRIsEAABxDlBSCULkE3IE72j4OCaTmPR/U09VDnpiHsHA9QuSWxQ+su1Rv5TD9hkO52gwdaNLS8gLA/4yh1GmqRAgozVq+80/UVI+9/qmd2smRlzm1YTgY0yO0eOzXxRDmpQZcis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788375593; c=relaxed/simple;
	bh=byVdeahY2Tgzg1hFdEdLfF7GCQbp81Pm2rqf+ryX1vY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tLzAW0BiP6xRY1t5BpA4axFizQUgDHLA4Ih2P0nFA15twfxQMxv8GMmdD8WUjdUaTyHSA961CpzJJxzGnw1xIwAXkAIzdsZCvSF63rZHXpomN4MZ1dBQbQlAX0nYkvvO7Vtn64aiJTqPYKanUvAq2WHStdkQJai6jwdRh+siF+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2tTFPRa; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2tTFPRa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788375593; x=1819911593;
  h=date:from:to:cc:subject:message-id;
  bh=byVdeahY2Tgzg1hFdEdLfF7GCQbp81Pm2rqf+ryX1vY=;
  b=M2tTFPRaYuyNNPxxaswllvO5VpBR6RnWMsno7R4N7Jpg6ZlBasTNWzy5
   CMb8yTWDoUH48lXg0OQby7YjK5aB8dXs+F7ZiWr5T0/d+jz6ieeqD2Ufr
   0N0mdjrS0TBAFv7PMED9sLXPuC+gi7iTBVU92Jjcr7whkLMQI1yZLMd/c
   7g/AqiS1jnVG8NL2PD91SRbHyI3p6/kG7LTdc6kUpcuZbOgIPPmUXGySZ
   MoBb4tuCBRVt8FKll/7MX190i/BwcibX9iDYSl6S7NM+SQ6V7z5QP+JEt
   Ttc0bUBiBO5woNn8H9iIBq6TpfX02xUMlDkL6Ld9yPjOfyH+bgYbyieTR
   w==;
X-CSE-ConnectionGUID: njogkoYIRVOPb8yIWrRymw==
X-CSE-MsgGUID: wdW8pDqwSoC0w6aiJAp9oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92713055"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92713055"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 11:59:50 -0700
X-CSE-ConnectionGUID: C3G8SC0pTvKFqulIwplBFg==
X-CSE-MsgGUID: ImXQtf8BSaujUDFYRaVJ/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="267736695"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 Sep 2026 11:59:49 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1qBW-000000003BU-29nD;
	Wed, 02 Sep 2026 18:59:46 +0000
Date: Thu, 03 Sep 2026 02:59:17 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc-qcom] BUILD SUCCESS
 86624b718f94517b26f96c1d7beb7632e5562afd
Message-ID: <202609030213.ib1IzdpD-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-qcom
branch HEAD: 86624b718f94517b26f96c1d7beb7632e5562afd  PCI: qcom: Block accesses to downstream devices on link down

elapsed time: 1756m

configs tested: 57
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
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
m68k         allyesconfig    clang-24
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    clang-17
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    clang-17
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
