Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A064E29B8E1
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 03:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788577979; cv=none; b=klmeDuqN0XWyYHDFJfx8NtY+QRtozT55Pvvu7r2pcHc+lNRXNJPq6OEXpBZlzBRNkeGG20/WcNnFYcikvlojjy3JxgEax8jgh/SPIA7oi3ijr3N7uNszdev5Q9sjxxfFxuYFfdMm2V6KFwTaHEOp4RmWYA/dXBuuk8Y1CO8wyO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788577979; c=relaxed/simple;
	bh=dmy2Zg1sqa44UbqQqpyAAYeufToE9UY724OOl6g/wRg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tQnm1s7237lQacKhXx8RS/N4VqDKMbumnd22UsoW1Pne9bcLiZcxy81kYZrXA4r5/cM5TvPmDQHwS1UMwlRiUl8gO2JCi1pAU5b/3O7TtUmguCy+FfJHxdKLxfTXkFPwZuG3KarG9NadqeBIfvztD9rqtvga1ed1ZtM4u6O6bPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKzw5S7e; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKzw5S7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788577977; x=1820113977;
  h=date:from:to:cc:subject:message-id;
  bh=dmy2Zg1sqa44UbqQqpyAAYeufToE9UY724OOl6g/wRg=;
  b=BKzw5S7evgU7l0iYXIFqSVZtNYTOoxrhzjVKqvWelCyDxvkSwGYO27g5
   0brYZMmuFiOb5zikjPO6jnEaq6uQpicMLXGfBv0+m48C12LLIa8dCcLpF
   HPDkqlHNVvpFpK6yJA8WUvNt+WCUJ04iaJoyIU4i8pWpRs2CCQjVl+lCm
   ALCugN7UH/6sdiNz4OsBMC+Bsh+uwQlFcVgx4OHsfJKhqGPEQVapY1oBI
   tMWS3PPdjdcw8t/ooOwwFxuTXP8UI8edKjl1vTMUrY0tUF5vTapvk9TSh
   jORI+EZaEnEOGcVB6H9s0sWrKEsgIJaujofHZ8EOWSg+wn6GjOFhwBEnL
   w==;
X-CSE-ConnectionGUID: yHQcT9lKQbOl8Zdq+R7fuQ==
X-CSE-MsgGUID: d+sCnU39ST+7YTuj1/z4/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="92947664"
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="92947664"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 20:12:57 -0700
X-CSE-ConnectionGUID: 3FCcQRT3S8eVwVW+C+8bAg==
X-CSE-MsgGUID: pZD2dfCCRk6WsDYTxTTp4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="265843317"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 04 Sep 2026 20:12:53 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x2gpn-00000000Aej-2GJF;
	Sat, 05 Sep 2026 03:12:51 +0000
Date: Sat, 05 Sep 2026 11:12:35 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc-dra7xx] BUILD SUCCESS
 bdfdf654b4b2762b5ae48325d6dd8e0f3529cab3
Message-ID: <202609051132.ibIh2fgf-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-dra7xx
branch HEAD: bdfdf654b4b2762b5ae48325d6dd8e0f3529cab3  PCI: dra7xx: Fix device links leak when dra7xx_pcie_enable_phy() fails

elapsed time: 3620m

configs tested: 74
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arc          allyesconfig    gcc-16.1.0
arm           allnoconfig    clang-17
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    gcc-16.1.0
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
loongarch    allmodconfig    clang-19
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
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    clang-24
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
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
riscv        allmodconfig    clang-24
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
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    clang-20
xtensa       allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
