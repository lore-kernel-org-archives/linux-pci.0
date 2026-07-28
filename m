Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104703A2E28
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 04:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785212867; cv=none; b=pv4/l3GU4wli//UpzEKseNK+ZetjUyxfWpU6rsfh2vxQwGhNKZRDyXsZ3TsLZp+h4ODmsEyYUTjx8nG28s7ETl7xKFs19xNwyNDUJB8RFygKqA1qXl1EsBGtTDH3TeI7uLifaWiZsThDrBxGFZbn+sgMniIQ+BbbTe8NK6NLWDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785212867; c=relaxed/simple;
	bh=q1T8mWJCwpJkBjnGRluY6Rko2Vixueyf1pkLxirxjnA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a7UerMBMjvYtZJ4GStSo248YP13TMs+tmFoaTf6poGrMJv3NxmCGHTh1B0o5X47HRPj7yQk4QCTlaiw+ecKtB/F/hqER0+x8OKcg0TK7zvaHraprM4EWqHVxRvZ8xiQEkkrvriIcDvmmt6ZF4LfHTmAxq6LisR820sAXGrOah5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXcM7URF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXcM7URF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785212866; x=1816748866;
  h=date:from:to:cc:subject:message-id;
  bh=q1T8mWJCwpJkBjnGRluY6Rko2Vixueyf1pkLxirxjnA=;
  b=NXcM7URFfXl3psRFmnNlTjF8Dn7TK4mFqxHQhLZ4gY/VcwjGOAwEPhdS
   +zAJYxJ/6l5j1oievN5tJLGunTyZ6Pga3GvwReXupFsD285BSuLKtmwYo
   TeKajjgpnt38foBLiyyXiyLLZEs+aKoAm8SWZHMgajg2+GMZUw5F1c4MG
   nIDq9j4CdxI9ZHOsf+DwgowufY7HysSWmRm+LJT905Z+/28FVw3VauQaP
   J0Xi5kpd97zTHYnVG/ZjJ7WheLAH0DHz7oM+4cjtY5xmDhOLb4+lsztGY
   71QL0DCt0axCRCkn2wszyvtMeD/Q9rQx5/3TqLUIGPRb23SnIlPJ62T0x
   g==;
X-CSE-ConnectionGUID: GOSlIJKPQZywBBcWMhJJYQ==
X-CSE-MsgGUID: YDx6eFw0RKS5/hiL14ufwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="96144310"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="96144310"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 21:27:46 -0700
X-CSE-ConnectionGUID: L+POWsKqSVWnQj+B0XR0VQ==
X-CSE-MsgGUID: 6U3RN7/SSaGnVpRDokAPTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="263087022"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 27 Jul 2026 21:27:45 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1woZPq-00000000dxd-2Hbo;
	Tue, 28 Jul 2026 04:27:42 +0000
Date: Tue, 28 Jul 2026 12:27:26 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:portdrv] BUILD SUCCESS
 834171efeefffb1a0f2136f32e76669bbc11db86
Message-ID: <202607281213.RoA8V7rP-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git portdrv
branch HEAD: 834171efeefffb1a0f2136f32e76669bbc11db86  PCI/portdrv: Allow probing even without child services

elapsed time: 5171m

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
