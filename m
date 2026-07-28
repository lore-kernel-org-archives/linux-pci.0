Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA9339396
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 04:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785213254; cv=none; b=VBpXlN8snSjrlAf7JS7Z6K52tihijtRAyu5Z643MOM63C/cqWfzoOGR5PNSohwd0lCgC/zdojr5myD5V1S8KlSiuoqF5wk++H1G+m+y2I5Xtet5PBvxBEi8qqnvtVpSeTNHKyN1jyjakJB0oQojilPJm/aOOrlar41d2EENMFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785213254; c=relaxed/simple;
	bh=EhWttfaHzrvUKKB6HGT9Z4sMrm5VnQ8BXyY1yv71/wU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IFCcqP3YxxT1cFC4MPJ4+7g2Mg2R0rbLTmMSBp8wHTqpK1xPontUmLFppG8uSguAaXOAZYX7C/9zFqleaS9qafpW+NzwSMOSFUu3dY/LQ4cxiD9OUst47TrNH89ObskVBspJ6acbxB3fsL1K9HvQfj8RbJuk+Fuocc71WRwLj2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsbgFbEl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsbgFbEl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785213253; x=1816749253;
  h=date:from:to:cc:subject:message-id;
  bh=EhWttfaHzrvUKKB6HGT9Z4sMrm5VnQ8BXyY1yv71/wU=;
  b=OsbgFbElr5dTbnn/9JifiLSx6r7TlZEmzVKfXC+rhD+itnLzopI2/x0f
   uoZhrHy9d36G0+tjLHdz6ip/ac4AOoe0PUD1T5z5u3r8yf0LMON5CyNNU
   gcpaqSMthDoG4c/Xx6Ni+eWiINW+teKRqkT+fxkmhmz6xZE+X87S1L7W/
   wNEwLZmIVGgKktfebMl5e428vV2sCiF6bRSDMs4nj/6AcXwueDBYXOdDm
   h/vJnww8fc/+IxvVRrXyVSg5EXSQUuXuk9q82d60pPeqAua5txb93bLS8
   /3qePZwj51sqXSWibZSbmD2evhB5xSH3I9Q5nXtSbmQ0PD6zBRfYI8rno
   g==;
X-CSE-ConnectionGUID: OpnIu2ACQnSU+SaJLVTlWQ==
X-CSE-MsgGUID: rIHKTuhvS9iW4nvxii7zJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85980166"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85980166"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 21:34:13 -0700
X-CSE-ConnectionGUID: fftIpYEnTO699smNnreOOA==
X-CSE-MsgGUID: sL0HErIDSZOFFdmuvVXyig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="289557828"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 27 Jul 2026 21:34:12 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1woZW4-00000000dyP-4971;
	Tue, 28 Jul 2026 04:34:08 +0000
Date: Tue, 28 Jul 2026 12:33:21 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/vmd] BUILD SUCCESS
 72b32eccbcd591b9606edacf3bd7c455176d7660
Message-ID: <202607281210.aL2PpYbt-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/vmd
branch HEAD: 72b32eccbcd591b9606edacf3bd7c455176d7660  PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow Lake-HX

elapsed time: 9133m

configs tested: 12
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha    allnoconfig    gcc-16.1.0
alpha   allyesconfig    gcc-16.1.0
arc     allmodconfig    gcc-16.1.0
arc     allyesconfig    gcc-16.1.0
csky    allmodconfig    gcc-16.1.0
i386    allmodconfig    gcc-14
nios2   allmodconfig    gcc-11.5.0
nios2    allnoconfig    gcc-11.5.0
parisc  allmodconfig    gcc-16.1.0
parisc  allyesconfig    gcc-16.1.0
x86_64         kexec    clang-22
x86_64  rhel-9.4-bpf    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
