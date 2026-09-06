Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B137B007
	for <linux-pci@vger.kernel.org>; Sun,  6 Sep 2026 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788677749; cv=none; b=VKXXx6dSS9clk3TnEdvixw9HgxhPlFFX/HZDSourDV4SNNUli6nJ0/WzgvIVx7M7xynoeQq2u4hzvQYToDPU9lwjmnYxJtn/xCkTnt8scdvOTS52UdJSsuUsvYUbRmkEteSOXDlz2LIDfMT9ICXigXcQBWFe4RyynTg0aCSSxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788677749; c=relaxed/simple;
	bh=Gli7IDHvPckLdeXUys/425mWXiOYIpjf6lrXy3nM5S0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ndb4291KEax2k1M7SnBGj43NBh7NQWJ5LQePzH3wXWvUXrNQBykqMjsX/SPj/JWlsZUVdUWREyD/joMwCc34aKWYHx4l91jRBepvIE+SYG5btffRxvy0U9qmZvE/15x9GCH0ICjOMhVv0gHrw1ypsBmVPE2juUn/p7ZDqgnZdxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpuKaTGt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpuKaTGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788677747; x=1820213747;
  h=date:from:to:cc:subject:message-id;
  bh=Gli7IDHvPckLdeXUys/425mWXiOYIpjf6lrXy3nM5S0=;
  b=mpuKaTGtYIZlBAvPqfajVb8K5Q/L+pdSjjmUvVQexHZGDPYZurJ9vnnb
   n3WDfvSC7NjXX2AY/+ZzkXfCn91z/3gw9mdmFswfeQxuE0K/xZnX03KgG
   oZziGMUgfednJtXhpjiXNBOD1SLXVjnRr/qhQMbckIQWi3Qaxmjq0shLW
   zGZQchiPRq6mofr3bAUnKEaFYImNhG/ooP/i1kEOGHxxGaP+I1sl4Hh51
   QmUEBG1fQIBxc1Wa+es/AD5zJkEBurbiDIvNNFZs7LGVI37KHPVOwi9Zt
   9De3PDfZQsSwK3W4VGdqnWVHGqzZYii2ySA97qSArOiI3XfFEb5ZYICv8
   Q==;
X-CSE-ConnectionGUID: awgtfxhuRO6AEW8rGExIhg==
X-CSE-MsgGUID: 23MR31efTCGlDo7xk+efHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11897"; a="99450047"
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; 
   d="scan'208";a="99450047"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 23:55:47 -0700
X-CSE-ConnectionGUID: KLIUD7h8T3ayNchkpebQtA==
X-CSE-MsgGUID: Drz76SzvTWSR04OycRE53Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; 
   d="scan'208";a="295301325"
Received: from lkp-server01.sh.intel.com (HELO 73f3364bc37e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Sep 2026 23:55:45 -0700
Received: from kbuild by 73f3364bc37e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x36n0-000000001St-2xfZ;
	Sun, 06 Sep 2026 06:55:42 +0000
Date: Sun, 06 Sep 2026 14:55:14 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc-qcom] BUILD SUCCESS
 89d17a6331087a76aea1a3a6c03dc45a19d306f2
Message-ID: <202609061411.8EFLk0dn-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-qcom
branch HEAD: 89d17a6331087a76aea1a3a6c03dc45a19d306f2  PCI: qcom: Skip system suspend/resume for firmware-managed PCIe

elapsed time: 3901m

configs tested: 64
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    gcc-16.1.0
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
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
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
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
