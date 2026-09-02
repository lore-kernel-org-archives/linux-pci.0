Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6FA4A8A38
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788370065; cv=none; b=iXjem4dtVuJ3YwJ/u4pUgIrjftf44QGioZAdhb94JfKza/lgQODuj4zsFc77bJSWG3PMzUCnl/Lz1UFO6cEsAHe7i60YWr155vpZJyRKF0VzA67ZifJlWyV75gzpM2eVKqNNvEIQnBkV54jY3RwbZoPwd6l2pBwJNo9ewhB8O+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788370065; c=relaxed/simple;
	bh=8xWywPeWqS+MKVrlSNL5hQErnTvgoFOU1Z15mM/bsHs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=c2Tsf9X/zK+9jmdG/ByMA/DRgUqPQzn9f4kCxNqQ6TdEWOoGSawPxP3cnTZpgZV4x8gMj8TWOcvR6mIoQ9NpXoQbK0f37fHGVj1O6+6yXdSnGkS3WsaN6kKI/eZYUYUbDh7KD1Nszj3zgbdEn9/MJp8eD0AcSMHIcwXl+Pk+a0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLfm19vy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLfm19vy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788370064; x=1819906064;
  h=date:from:to:cc:subject:message-id;
  bh=8xWywPeWqS+MKVrlSNL5hQErnTvgoFOU1Z15mM/bsHs=;
  b=KLfm19vym4++Vu/cx+BnbmlZSZJYkEwqRBZXNbRqTJ2+7D0zjH58ToHb
   9TE6aePTjwRIHPgW3pn4Ei/88Xt+VKTruDfyBRQJ0nAArV7wonRTvQ9uj
   kP/vqqkrdTjTJh+91XJzgiZb0aPnqNaoMgFvxUX6jaYL3pxSJ/c8n9gh4
   bumRoLksTur07wYX0oIi/pQMdZLW3NrtHhAjgda7FyWkUvP/md95+99rM
   JAUMQ5LuDKe8scudWCm0P4t6t39RLpbH9v/rfgL7tj8/Dr9dYEKWNugCz
   aNmI6xDsW8rV1ee1Ie1EhSJMEb2RVBDd6FkjsuDXw8XK62k1P7Ffkt9pI
   g==;
X-CSE-ConnectionGUID: FAIYrI7FSRu5bohkvz7pjA==
X-CSE-MsgGUID: oKtFEX8YRkWpGyDFJtyQiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88763076"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88763076"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 10:27:43 -0700
X-CSE-ConnectionGUID: edLMiNa0SjyMfUPHUWPdeg==
X-CSE-MsgGUID: B6E6Fvt3R62lnfR4oUcp/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="274749481"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 02 Sep 2026 10:27:41 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1okM-00000000344-3OnC;
	Wed, 02 Sep 2026 17:27:38 +0000
Date: Thu, 03 Sep 2026 01:27:29 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:aspeed] BUILD SUCCESS
 a54ac2eb6eca8baa86b89494b8a0d9439a0f72ee
Message-ID: <202609030109.c6ifzEHC-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/aspeed
branch HEAD: a54ac2eb6eca8baa86b89494b8a0d9439a0f72ee  PCI: aspeed: Fix clk and PHY leak in aspeed_pcie_port_init() error paths

elapsed time: 1530m

configs tested: 60
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arc          allyesconfig    gcc-16.1.0
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
loongarch    allmodconfig    clang-19
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
um            allnoconfig    clang-17
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
