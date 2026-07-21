Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83791E531
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784612085; cv=none; b=S/OKfqx/fBj6/YVP9M9qFD/Ua5dzXn42PGDd6pyebu55hEkPnEyn550CjGIWokJd/zGDzLbCtOYFqgJ+SoRgwPJCgLP/5T+2B13c5ZQn1R42H+mH7ED+6G9z1TnGIg2X3LyhH4dj4RMW5SEAwiNDNJQrZe1B2+cZIVXlaql5L38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784612085; c=relaxed/simple;
	bh=bShMIh0OdinKjXJaJpqTZjAcMkJDZQ1HB16T4+7S7KU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Jz+jD18SsRxmbc7fEHpD8UnOqhtl5Ne1+7UZKFBOq+6xxf3meoFQzbp8dpOZlbFxKJScqAswVuz4faC4GmIPlfeu4DjoWSaI3Py8Lsn25cOjuUxAekk1fTYEgBYSq2lRKCzFYPcNuNHAwYvhKOCde4ZhAeZGbSv0Lg7uankAEBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I08Oyqh4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I08Oyqh4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784612083; x=1816148083;
  h=date:from:to:cc:subject:message-id;
  bh=bShMIh0OdinKjXJaJpqTZjAcMkJDZQ1HB16T4+7S7KU=;
  b=I08Oyqh41dTZTC4HHCEMVkkgEWe4DXZQXaRXgbdGnJEXXMl4D+HwC/pG
   AuIiD16ajheLh3nR/01AiuKS//Tsm5uLQ/jZ95Vg0Tsq+03C7lDCn+73m
   jaBlZzQ/9+O428lZDL2Xc90TYNPTC39eWHQ0ZNUpvZQivv6wjkxduFQcl
   RFsAt/J9LMvl3qNaF48/LOaE1Vq3B9XgjwTYBYeiz8af7mSF0ynL2uIQl
   M2kFc0Y8hMgOiP/UKpEr8uFYYZCHS/HYsxSoIrUua48qbaEF5y0faAWr3
   BZzTjqLCwTOqaKA+Xi7LC65cMyIbabMI/8eX7UYkOEfvF+80bjQVmOaw9
   Q==;
X-CSE-ConnectionGUID: KmhRaC8bThyb+7oW51D9AQ==
X-CSE-MsgGUID: RvCHg7ErRMmaZoee2HkOGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72737036"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="72737036"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 22:34:42 -0700
X-CSE-ConnectionGUID: p+LcmWRWQ5qIbHE2by11Tw==
X-CSE-MsgGUID: sWE0bu2STJ6+3PfdqJEjtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="254250758"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 20 Jul 2026 22:34:41 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wm37m-00000000XEu-49Hj;
	Tue, 21 Jul 2026 05:34:38 +0000
Date: Tue, 21 Jul 2026 13:34:08 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/aspeed] BUILD SUCCESS
 f944349dcbaeaa9d6e1c8f2f8182f5560ba79581
Message-ID: <202607211354.ZEngQGXJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/aspeed
branch HEAD: f944349dcbaeaa9d6e1c8f2f8182f5560ba79581  PCI: aspeed: Switch to irq_domain_create_linear()

elapsed time: 774m

configs tested: 15
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-16.1.0
alpha                  allyesconfig    gcc-16.1.0
alpha                     defconfig    gcc-16.1.0
arc                    allmodconfig    gcc-16.1.0
arc                    allyesconfig    gcc-16.1.0
csky                   allmodconfig    gcc-16.1.0
i386                   allmodconfig    gcc-14
loongarch                 defconfig    clang-24
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
parisc                 allmodconfig    gcc-16.1.0
parisc                 allyesconfig    gcc-16.1.0
parisc                    defconfig    gcc-16.1.0
sh                        defconfig    gcc-16.1.0
sh         sh7770_generic_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
