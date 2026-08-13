Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB5345CCA
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648692; cv=none; b=LWnQQk5XkVEn6VTUQay6RJBF+T/29fC/HEibGPquLmiRBy2hub8me55Cya32RHN4sx34usHddw4Sv/MF21D8Dz6/dITORket9CRavodsTQC2BeLKnfTpANcRlYdwv5tMWZszBNQhsmV/NUg+KSbjSry/r1KdA76aG9Eo1dQxxEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648692; c=relaxed/simple;
	bh=Ey9yTg3yxKb6nvzJoIwJtXn2ri1CXYoujZIEyuIbfvI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DVU1BxKBkealcJiWrvDmTBYociS2y/tSGn1FN39k9gmxgM4HdUbx3+SzajxouQpAUISt33EM3xuAsoRDg2xUwXe/xjlE14FQoFcSI1/iimkbQPSNXKqZAnnu8kTh6JG/14oihEBP6RSlV42MxEIJuhctfgOIITXmfS/jQH084Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5XbeZ6S; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5XbeZ6S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786648691; x=1818184691;
  h=date:from:to:cc:subject:message-id;
  bh=Ey9yTg3yxKb6nvzJoIwJtXn2ri1CXYoujZIEyuIbfvI=;
  b=m5XbeZ6SWSjKqYIbEvQDhRdazHJ52aKqHDBoZH2wnT4MnrNJkwW/4jfL
   0oo1lo3jAmujH0FAwhw44VUKafekRNwaorKgyHi1l05PwcUo+ymVwI02N
   z5svu5/O4kpfShxk7s1SW7xp/KBH7yHnYpTRWjI2IOyyxTujaXhERnSEi
   V0sq0CppdbNLHqRN4r6W87pV0Lw97PRdVLdpgNKHEAWquEvDj1eejcD40
   ELuJ7CBe+X8imdZyt3i5w6VKKa7PLGa+QmgkraJnQRuBOXamkOrmqiy01
   QMXVAbbCkL4l2liTvhX5toMjKrREyIL9eQKiciAVC/WQs2h6FTkRzSxED
   g==;
X-CSE-ConnectionGUID: /9GRTyLdQO+vvYdyenxaYA==
X-CSE-MsgGUID: K4qm+DHjTlKsuf6lgGCp1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87448874"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="87448874"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 12:18:11 -0700
X-CSE-ConnectionGUID: URD3fiQoTjeBh2IsdDMTyg==
X-CSE-MsgGUID: ZA72UoX2SLq72d2qj88S3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="267518941"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 13 Aug 2026 12:18:09 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuawJ-00000000WL0-1FHC;
	Thu, 13 Aug 2026 19:18:07 +0000
Date: Fri, 14 Aug 2026 03:17:17 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:slot] BUILD SUCCESS
 231c7a57d19304beb0931e6cbe3a4929daf49747
Message-ID: <202608140305.7kVFpasD-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git slot
branch HEAD: 231c7a57d19304beb0931e6cbe3a4929daf49747  PCI/MSI: Enable memory decoding before restoring MSI-X messages

elapsed time: 744m

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
arm               exynos_defconfig    clang-17
csky                  allmodconfig    gcc-16.1.0
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
riscv      randconfig-001-20260813    clang-24
riscv      randconfig-002-20260813    gcc-15.2.0
s390       randconfig-001-20260813    gcc-8.5.0
s390       randconfig-002-20260813    gcc-10.5.0
sh                       defconfig    gcc-16.1.0
sh         randconfig-001-20260813    gcc-11.5.0
sh         randconfig-002-20260813    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
