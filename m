Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4FF354ADB
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 01:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772500658; cv=none; b=fodHHsp+BRrDGXyleb73IsJbrxInyvfpW6OXjBn2Mwep5o3CrviZh7omxyCeaFLFxNNucQkLZXZ4uSttJwNRQyhfs7ucf1yKdpyRc3sEp3hM6w+I+7NDY5GsIkcSzNodYHbIleuE2bb/k7s/Hwo+2PhcuicNFMwHyVwOrLmPTDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772500658; c=relaxed/simple;
	bh=Xw7ClG1ePdvzjjBOSd9cDtilGfHgLH1heokTyv8bgMM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WJa6daT2hLw9mW1RX4HPU9yvagOMeL8DZnXCUqerSP9rwp9b28kJfS2bWwm8mcL7QscpuiWQYSx/yODYvOqBQfKqAxhrH2K4xow5EKbtQ+R/gUgvPdlYQYU/KWoiLL2hpbZ4GqUKSepdv3JOulx0yAzvIydIMpbJwoEQhX1M6Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUILGNYM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUILGNYM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772500654; x=1804036654;
  h=date:from:to:cc:subject:message-id;
  bh=Xw7ClG1ePdvzjjBOSd9cDtilGfHgLH1heokTyv8bgMM=;
  b=mUILGNYM6ElWD3q0glWpCajpZPHA7FDI6/jczjGhUpKdxtbqjaXMuWap
   152Zb6Je9Ciadx5m1pbAdyjDWL9fAtTy1L0vJrfwmVaawuWV4woAwf7Rp
   jbkq7R41fzRZdOwNwEaojsn6SxaEtCAMzcjE5HcoQzQyJxOTiPZxrltDr
   OEBH1bKX3htzkl0l59VWPs22WbHg06UfF2FDnGbEkHiLEGNnzkydOk2Xo
   g11m/6a79DQJk5udx9LlynwmQ4q1VWLjv9dwEFLECSjsv3tEIGv5/Kw2d
   MciqjfsHkRZJ1uP64igLk+9fMVeMEVtMq/7akyFssze4xZ+rtueHSNfKc
   g==;
X-CSE-ConnectionGUID: WmNGrIYwTk6xekq9DGqBNw==
X-CSE-MsgGUID: PS3HTu9aRUmoIFiCp4CwJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73711580"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73711580"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 17:17:33 -0800
X-CSE-ConnectionGUID: RxuJ7bg3Speivtk+15hFdw==
X-CSE-MsgGUID: XqXaG8h7ROS4VfpGMzhHjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="255700537"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 02 Mar 2026 17:17:32 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxEO9-000000001ar-1pkp;
	Tue, 03 Mar 2026 01:17:29 +0000
Date: Tue, 03 Mar 2026 09:16:34 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 36bfc3642b19a98f1302aed4437c331df9b481f0
Message-ID: <202603030926.iMH4lHL3-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 36bfc3642b19a98f1302aed4437c331df9b481f0  PCI: epf-mhi: Return 0, not remaining timeout, when eDMA ops complete

elapsed time: 1161m

configs tested: 55
configs skipped: 0

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
xtensa       allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
