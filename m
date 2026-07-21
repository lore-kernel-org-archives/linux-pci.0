Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B84445AC4
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 23:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784676960; cv=none; b=QPih48f9KOsaKBwh9wFinbbuvOxDbHzByYnRVUR+BF276bSaUbP6E69ommPL2Mf4aCCRP5jrXa5yh2uZ32LSAmsi3CRqR5fyw8JcYcccnunnU1E7pAviOvSm8RyeG9An6Tc2th+3YJNIh4J8brtwVa4QetT+A0yL7p1QGCA3PL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784676960; c=relaxed/simple;
	bh=r+HWP+LFFuiz7VxpE8ffoLakTsGa+bt2IACMA7To5zY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CO7DUOUBmflthwL4LTCjAhVL9ehDV2fXDbMcQjc0QRMwiHDHQwnAujG0K5h9dyRUnVr+ARuSUPOnXsiBH3O0/sMCrh0e/rGFJ6vSU3L9t76/L2WG8HyhEy4cZ7MIFYmbt6gcMN0Sr4orrT4OsynEXBjC+P3Os64H9rgU2uDXIAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfLwWAnh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfLwWAnh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784676959; x=1816212959;
  h=date:from:to:cc:subject:message-id;
  bh=r+HWP+LFFuiz7VxpE8ffoLakTsGa+bt2IACMA7To5zY=;
  b=nfLwWAnhPW40VKT8l8NqhpOGcQxZNIVih2qFK3+nxVXIBiMTF9PpvG0k
   U+goSFRYJd0bI9KTxhbjm/itXZ7GK3tX+sQ+UMssSeCRcmn2uLLKKOIsJ
   3D4dHg/HBE6OHBeB3Fl8Y5OnNJSBLAtlj/o+sioqr1+hi6sT7HuWLrvOG
   sJEnc0Y3cIXVknSZPlItpLzxcQoOrkisDsauajoHYEXkv5si2incHqH5Z
   G3c69WU7i3eZInBtLjBbD3XzGQx/42Ske2VZvOxWjlkR15sNspPLicBmp
   W2oZtuY5lM7CqdZ2SuVElLNxesxq8hiqys2LjIS2agetxWuIlj36godev
   A==;
X-CSE-ConnectionGUID: Nl3e1WDeTIKG27kiHm0Mww==
X-CSE-MsgGUID: 1A805s3wQ7OdvFyfavyEKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85243357"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85243357"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 16:35:58 -0700
X-CSE-ConnectionGUID: xpY1u+4qRpqzYw/71a9THQ==
X-CSE-MsgGUID: nbrzsCtAS8e7+nrG2WHjHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="251589214"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 21 Jul 2026 16:35:56 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wmK0A-00000000YAm-2OdS;
	Tue, 21 Jul 2026 23:35:54 +0000
Date: Wed, 22 Jul 2026 07:35:30 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 82c58bf7fa535898861b971e1c5fe0543cc43056
Message-ID: <202607220716.i02BDTqN-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 82c58bf7fa535898861b971e1c5fe0543cc43056  Merge branch 'pci/misc'

elapsed time: 1697m

configs tested: 21
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha               allnoconfig    gcc-16.1.0
alpha              allyesconfig    gcc-16.1.0
alpha                 defconfig    gcc-16.1.0
arc                allmodconfig    gcc-16.1.0
arc                allyesconfig    gcc-16.1.0
arm            ep93xx_defconfig    clang-24
csky               allmodconfig    gcc-16.1.0
i386               allmodconfig    gcc-14
nios2              allmodconfig    gcc-11.5.0
nios2               allnoconfig    gcc-11.5.0
parisc             allmodconfig    gcc-16.1.0
parisc             allyesconfig    gcc-16.1.0
parisc                defconfig    gcc-16.1.0
riscv   randconfig-001-20260722    gcc-13.4.0
riscv   randconfig-002-20260722    gcc-13.4.0
s390    randconfig-001-20260722    gcc-13.4.0
s390    randconfig-002-20260722    gcc-13.4.0
sh                    defconfig    gcc-16.1.0
sh      randconfig-001-20260722    gcc-13.4.0
sh      randconfig-002-20260722    gcc-13.4.0
x86_64             rhel-9.4-bpf    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
