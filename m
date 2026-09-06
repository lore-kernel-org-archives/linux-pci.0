Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B53227A462
	for <linux-pci@vger.kernel.org>; Sun,  6 Sep 2026 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728568; cv=none; b=uGf4IPVBl7QNJxM7HkSgJtiMq3X7eSAZAkw6M75OUZFnMtIpCkbpPAqx1ac0f92XCzNOzVvLEGJozGYGmAtzImc9JSQCL+4kYz5G1JKTE5hma20M+1ygujGx5T2b8ifM0tgdtc5qtGoOWPMxFv9B3V/+d27bl4s/FJCdTVVIrfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728568; c=relaxed/simple;
	bh=VHF96F70gMIKpZnlNm4FDHQo2sMjgHBwKbZua5rx1ME=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qLfpAgDImJpPO0ulXfhUTDVeDwqIejbGTBG2WpKn9mKiBkaA7DEGs15nSQLtsC+OPMBbKrVy5v52Kmh9Wd3QhiSa4wf2I+6qU/KVc4tIWVAe29PAe6Dh7bveJuLoZd8gTpXkRz6/YXqWieqZ8DHzeYNPZuiFiwBosnWFooCPTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjCtgBkH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjCtgBkH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788728568; x=1820264568;
  h=date:from:to:cc:subject:message-id;
  bh=VHF96F70gMIKpZnlNm4FDHQo2sMjgHBwKbZua5rx1ME=;
  b=RjCtgBkHTJqlp25BkHm1shwPJxPskz/Ccc0tot6wQmlhuHsLaIbz+rbr
   AQ3RHsAoOcMX5nb34xWW4kf8XROgtdcVHUNHW4hZIETU+JTehTRqDxLJI
   rM8QIw7JxDXhkNieiiyPcyQzrC3ei09CWd4smBG9kCvVzTFV9f45Mcfiv
   oT+Ije/8HmXIAMhqceiyW8RYO+gBnjHCa7Vgg5V5lSwU+dQ3xuHlL6jvY
   A7bmrx/XfyXGamkDp978CvdUb8xnwiutxtnI7jmObTxmoodvC6oje5MGP
   ZGu1xUOhsGSJQaPSYvjnKZz+XhrLQS28V4BOfGpQaqujqYTLLBq+40csC
   Q==;
X-CSE-ConnectionGUID: pHb3azKORba5td4fpRSslw==
X-CSE-MsgGUID: ZG+vng2wQnGMgdHeov3vpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="99472741"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="99472741"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 14:02:47 -0700
X-CSE-ConnectionGUID: zKBPGRNcR4KUPVUOrPqqCw==
X-CSE-MsgGUID: tHjQRyMKRUCsskvAWJK6Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="274053243"
Received: from lkp-server01.sh.intel.com (HELO 73f3364bc37e) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Sep 2026 14:02:45 -0700
Received: from kbuild by 73f3364bc37e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3K0h-000000002Xb-2a12;
	Sun, 06 Sep 2026 21:02:43 +0000
Date: Mon, 07 Sep 2026 05:01:55 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc-rcar-gen4] BUILD SUCCESS
 0b4b2674688c6a719e93f0e52ddaf6432847bc1a
Message-ID: <202609070553.6KRakExr-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4
branch HEAD: 0b4b2674688c6a719e93f0e52ddaf6432847bc1a  PCI: rcar-gen4: Use .post_deinit() to handle dw_pcie_ep_init() failures

elapsed time: 4347m

configs tested: 51
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
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
