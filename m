Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1720C422531
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648516; cv=none; b=RJDnEtImrXG9vicryJoKQsvCCpaq7wDFay/AokaPyCAoDgFM6iLJp0vINBtZ0sBY4aZm1h8LiNTQmO6xtdjqz4MaP4/qnuF3SC8SsSsYzgpNSMNTHlMJl9cBjN2oTY7gDnb7oudzGxlgI099N0Dn8ANKaTiAEtBInb80tuoEB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648516; c=relaxed/simple;
	bh=xswrpbWUy6mcafBgV6wPqH3UP9Sgk05riUdUbyqg/vM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qItFY+YmjJD0ikrjvQ+Cht6FtMXVvrXWCoZEzNAp75Sl8tMcGAu0BrCimjH+frTGySCyMgkaWWCtgODJU+pwjblLjghUNgKqq6QLHIXd9jjsHkCJGM0ul4iqIij9USXSLip4Qmp6/042sd+UN7+DNhg8IRycksbddLFtQP1wkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gK0kBF4s; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gK0kBF4s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786648514; x=1818184514;
  h=date:from:to:cc:subject:message-id;
  bh=xswrpbWUy6mcafBgV6wPqH3UP9Sgk05riUdUbyqg/vM=;
  b=gK0kBF4s0j/hXh1RBnjg1jtQCeZtu0mH/KcGECe3cJLltc38JpjiX8Zz
   7/qF19PcJP7+z2GYK90oN28DS4dqNc94tbXStCRBUxAplDLQwxSUFSm5d
   cSUeWtlq1llFgGyaRo+A8ea2Ht8HSdoSE+UaeDlSJvIODAwBdGkICYwv3
   cCGjrooDTilspEjpJ+gWfxxjM7Ojn9M0cfyAIVRMInx85I+1gF0cE1364
   fwn3d3xH87AKUF/A0PZ2Gm6KcVAVm6bUf4jiFJqbPRG0UEOedkp/SmNeE
   RXk7H50S2tDsS8evxmfXqveYsPWwLhmTbOl1NxRyKJ+gkNyGdZ9n37bPV
   A==;
X-CSE-ConnectionGUID: VROCMozZTgGvrS+an87Gjw==
X-CSE-MsgGUID: BcgCg/MQQuKll38zZrMnIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87305774"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="87305774"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 12:15:07 -0700
X-CSE-ConnectionGUID: Gy9ZiaDxQMW+kupFsfw4xw==
X-CSE-MsgGUID: gXugdOczRuqnRowyZ9sU4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="262697072"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Aug 2026 12:15:06 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuatM-00000000WJj-0Vex;
	Thu, 13 Aug 2026 19:15:04 +0000
Date: Fri, 14 Aug 2026 03:14:57 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 c1366b72ad4e87be60b57b74635a3a0bc58d2b0b
Message-ID: <202608140345.BhJ0qUxs-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: c1366b72ad4e87be60b57b74635a3a0bc58d2b0b  PCI: dwc: Handle return value from endpoint .pre_init callback

elapsed time: 742m

configs tested: 21
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
arm64      randconfig-001-20260814    gcc-10.5.0
arm64      randconfig-002-20260814    clang-24
arm64      randconfig-003-20260814    clang-19
arm64      randconfig-004-20260814    clang-17
csky                  allmodconfig    gcc-16.1.0
csky       randconfig-001-20260814    gcc-16.1.0
csky       randconfig-002-20260814    gcc-10.5.0
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
powerpc            holly_defconfig    clang-24
sh                       defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
