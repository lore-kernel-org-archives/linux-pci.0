Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB1937A854
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788408108; cv=none; b=pMwYOOvdkIC2sFImFo2vuBAXbhPCwDrCgjdv46QI2fnEe69+f+hDBats79TsQPZnPjpgJO00vwJTAZBHST6pdT01fonzbLx8Eit1o28f210391GtUCbNGGrKnmYmXVHf22g9ed+xvVNis6QI5u2ntj9K07NtkHCkcH3yulP3vDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788408108; c=relaxed/simple;
	bh=juNPSaR0obCW8xYZ6J4vO4JO/NhOata5NIxcOqV7nsw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CfKSEbhEMOxVemJtvuhsshtacSSI1lmDOt+AA4OxF30+jvVQ9fQ4SJMZXqGc09kqKkDewenIfHVSbP3DUJaxuzdbifaCdbVz0lSl9RmsxXYeCh/UL/HSabthOSjgJTHXZ/YUGGR2wuQIa23XKkAvxJkBRblEZDa8mCpQ4Thg1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L61Z8mJk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L61Z8mJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788408107; x=1819944107;
  h=date:from:to:cc:subject:message-id;
  bh=juNPSaR0obCW8xYZ6J4vO4JO/NhOata5NIxcOqV7nsw=;
  b=L61Z8mJkzbotVMaHa44/ML6GtPrmVEhZX6gjdtfFca1LVmziDCVkBf1h
   JIqwqIaJky/B5FpGJ+Z29rNGUJXau4IQ5WMW4LfOmBwQByAxd0pGyqE92
   2hL8NUOq9yNRkjNS6faAEPQQAJc6nMsYK+qvXa0vw3GCPi8ltUMUb5Le0
   topPgykGvjwB6r2vzm/Mf0fYHH1MUrjDrV44+pyYN5aYdrWQzLdbjlREf
   b9ZGCSu2eU+aJMGXGLVnOgkUs3r3q+yzKjLTYIfQd5+mpOZLrHYj7S5rM
   s549aDOIQUGWnmqBpi6zEJkvqzTOOwuTSdtXvMApHOl9Uh55YGadSd5JD
   Q==;
X-CSE-ConnectionGUID: pYjW1NyyQq6WFMSIrB8mBA==
X-CSE-MsgGUID: vOQPcC0aSiqwtZWzJFewPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92696299"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92696299"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 21:01:46 -0700
X-CSE-ConnectionGUID: IZX5dsV4RX2sse1ylFlsQg==
X-CSE-MsgGUID: BjTIZdYfToenNcNou86sUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="269054165"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 02 Sep 2026 21:01:45 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1ydy-000000003xI-3bMg;
	Thu, 03 Sep 2026 04:01:42 +0000
Date: Thu, 03 Sep 2026 12:00:58 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc-qcom] BUILD SUCCESS
 86624b718f94517b26f96c1d7beb7632e5562afd
Message-ID: <202609031253.88sx6yia-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-qcom
branch HEAD: 86624b718f94517b26f96c1d7beb7632e5562afd  PCI: qcom: Block accesses to downstream devices on link down

elapsed time: 2297m

configs tested: 67
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
nios2         allnoconfig    clang-24
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    clang-17
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    clang-17
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    clang-24
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
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
