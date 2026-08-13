Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DCD33DEDF
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648631; cv=none; b=EdId7/fIWUt+mrLsqE2+39kqnw8PVU2vKpMBMfMNcxPuy8N1j65dUsHEtemzD+9RcJoPku40NGZvPDyElcXBPwaqK9O2HQGuU52ujXkG4binlRZErlAjDvgRZLZf3+XIVwbuX42m3ZiT4rW9BI/Vg8aUkjNTIszY1tngDFjOMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648631; c=relaxed/simple;
	bh=R59kxWvGaieNtIdicdnHY7X5+rC1oIbtxJnHCzhFbwc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I4HGbiE4++4c5PQOCSdycsvMMHomvSIz+j9shno1fpALooKtaevvFN+w2YQceIa0kLm+Vx0BpoAhfhpNa6llo/TTvFXERSaPqLhzQubzBdzlNWSE2i36wEgjU7P5bhfuiRGYCS3rk0OJPdd31IAqqmNbodcn3gBgVutYKqixjf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awYAssO8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awYAssO8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786648631; x=1818184631;
  h=date:from:to:cc:subject:message-id;
  bh=R59kxWvGaieNtIdicdnHY7X5+rC1oIbtxJnHCzhFbwc=;
  b=awYAssO8veB5XueW1Zs+ZyrPIkpEBWqmZ+a9wJ9ebALys8trnJjgrhNQ
   GFPkqPeQl+Fuh9uMq0sOSKkuieWOFBHpgYDuS/Cv9JuGlLxpAjoR7KFLt
   TBUKkzLNLBCy8/4rR+q97ZMapJ2GPyPsvIVoVtSqeRlspoKeOZXZlBOji
   LCn5gV2ESXsw63fQVAddEaL2I1PyICEWpuSlQ/qhPEjrnyeNb4pooU7IE
   CtIMxPbn0DuQDYMQkax/ftm1KDIocA/mQAVorKaG4kZaB+uKdOeb//pas
   2bwnHrPWgXI1druxLlAPcQT6uL0T0YpokYj8y25FXm/sb8JikA3v/O2Xn
   g==;
X-CSE-ConnectionGUID: MKDzAy+ITCOIsePkTGzL9Q==
X-CSE-MsgGUID: iStsgOrTQAyWBYXNRXfY9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="91106545"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="91106545"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 12:17:09 -0700
X-CSE-ConnectionGUID: Qtt02/IIRmWnFel3DjKNig==
X-CSE-MsgGUID: Wf9VC+ObRKK9oY7Wur0YuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="260214103"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 Aug 2026 12:17:08 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuavJ-00000000WKg-2Evt;
	Thu, 13 Aug 2026 19:17:05 +0000
Date: Fri, 14 Aug 2026 03:17:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:doc] BUILD SUCCESS
 1af156149d9a7de8e6cc44f09f4150cb677bf1bf
Message-ID: <202608140350.73zlK5rO-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git doc
branch HEAD: 1af156149d9a7de8e6cc44f09f4150cb677bf1bf  Documentation: PCI: Document how to write PCI Host Controller drivers

elapsed time: 744m

configs tested: 15
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha          allnoconfig    gcc-16.1.0
alpha         allyesconfig    gcc-16.1.0
alpha            defconfig    gcc-16.1.0
arc           allmodconfig    gcc-16.1.0
arc           allyesconfig    gcc-16.1.0
csky          allmodconfig    gcc-16.1.0
i386          allmodconfig    gcc-14
loongarch        defconfig    clang-24
nios2         allmodconfig    gcc-11.5.0
nios2          allnoconfig    gcc-11.5.0
parisc        allmodconfig    gcc-16.1.0
parisc        allyesconfig    gcc-16.1.0
parisc           defconfig    gcc-16.1.0
powerpc    holly_defconfig    clang-24
sh               defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
