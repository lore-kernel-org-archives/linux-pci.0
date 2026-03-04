Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AAA1E1E12
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587146; cv=none; b=XM5YkTMbKH8QMsRFdsJ824yax01OiB0jLDeHCGoZZ2gUTgKz+9JsNVhrkn75MPyuH9dvfaP96xaCXeYP5YgqqMLzmPKmTr2oD4kABN1f8S8hoDDx9XMgZokdDIoXsNm2bPiWMvb8TxCdiL24V3lu7tiJrpV4fjGYY+OIbaLBLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587146; c=relaxed/simple;
	bh=1Rgt/R7NiNI9okC1y03QN3AGUOdZUPwpNzlpo0/Pprk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Xnrbxka0GtMfGwjHIyqQ5k7VLJ9A/nkO3Kf+j0FYi+q1i67IAWs/UxNpZsEhNK9GsM0tiPJ2tnCcX1hY2RfR8OadkWukscRnYVLIPnLvpM5UZyf+58XY9GwhhnSKXUPy/MeCt4SekerMGfS7wTgcXrgEcQnboOMzpNTjgJFPh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahwqHWis; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahwqHWis"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772587145; x=1804123145;
  h=date:from:to:cc:subject:message-id;
  bh=1Rgt/R7NiNI9okC1y03QN3AGUOdZUPwpNzlpo0/Pprk=;
  b=ahwqHWisuQKNCmhfXBFn+MYHSdmcYet9ELfI1OCQ/IcQGC8hsN9zF9TG
   505x4BwDwcJpTP1E5Wrf5noupOhfScjUscoIRekjexz65feQO5qXVPMd2
   TVsp/L6q/bscVUrgHTPCuL/dEV2qrTTxn7y19KjeUzCik2s3qvzt7JZCW
   FyY+HCPRvX72ULYiwsPeru6TOoANXUkwh5frMfuVHUgUsXO030lvZUbxl
   onzKZqeR1MGsHSIeUcONug3HCm3hu6N6KQOyBOTSze7MM4LulkhkGzu3I
   is+qFlmxVQ/WnuhTUc4Rq1hBtbVbeGVldYrtL2WfmmKeEbHpKR7A3/QZu
   A==;
X-CSE-ConnectionGUID: X/0p890hSPGiEiTYN9WNMw==
X-CSE-MsgGUID: YSUf+W36SYmwOOfGTre83Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73341112"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="73341112"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 17:19:04 -0800
X-CSE-ConnectionGUID: j5vGYYlPRMmZjQqlo6zbww==
X-CSE-MsgGUID: kgTIECtPSBSYPLO3kVghuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="248664333"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Mar 2026 17:19:03 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxatA-0000000035R-1iDT;
	Wed, 04 Mar 2026 01:19:00 +0000
Date: Wed, 04 Mar 2026 09:18:01 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:wip/2603-keith-reset-v5] BUILD SUCCESS
 af7b70672fa7745fd0911adbfa5633b65af6ec5d
Message-ID: <202603040953.fJyfqyRd-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2603-keith-reset-v5
branch HEAD: af7b70672fa7745fd0911adbfa5633b65af6ec5d  PCI: make reset_subordinate hotplug safe

elapsed time: 1480m

configs tested: 54
configs skipped: 1

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

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
