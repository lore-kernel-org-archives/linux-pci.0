Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56F35DA71
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772577476; cv=none; b=bIX7LRV7PoJxTgHa2EJwsC2M5J6hS/4XgqGwJO3/RrAtJWke1IObNjoU+pjlqKPecT94Io9ijDPmupyb84JnMG3Z+JfOaobHcT8qE8u9e2VCYTvE95J4+I/Svg6+LJJEOFLoiEnb1uhgOvefQdQg9W0Nn9n/IXQNYKNcaIVbCl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772577476; c=relaxed/simple;
	bh=rFwmgOEKW1bQpuy8qPokcG7sHT8yawmrQlj6lXFPFps=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rVpBp7h34hb5V5lXv3THBPrq2GX7dxLIgtlOnYG2vrQn2cnO6wXXl5L9oHTVKn5jGwXDamrqAEDNo+1O9B7VfQoaHZCaGaD/2k+IcAMzlQpje2TIjJdV755D/xSHjNF6YhRMizGLaBb/bMKQls/UX65qnzRBCxIWwK/xNTg4jd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crQn1xYK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crQn1xYK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772577476; x=1804113476;
  h=date:from:to:cc:subject:message-id;
  bh=rFwmgOEKW1bQpuy8qPokcG7sHT8yawmrQlj6lXFPFps=;
  b=crQn1xYKLhumrDeNpXnSpSokoUlHluLLf8Fw/YNR0f7w36XKyzoKWjME
   6CzgtIqITvErhJsQIuhqt/HuEp7MG56VqZWACSw73lSud+aCAQIaiMKU4
   tj9Ay2HFcxRTfuJ34sxIpT1BSqJyKQ5nn953PxfvySl7bgK7syYz/OoJ+
   QPmWag8VNdDs8w1TOnxI6/J9NTiMXX4glDKVpmPLO7KmrJDhflw+TrOQM
   7hd6FAn1+jrorYe/PX5dL7IY3Z9hHk5GUGN0lx2SF0ReYgQaYG7/85vLD
   eRGBZWEU458FKuyVsXpReDSHR+6dXtv4XbCnTKMS0mQAneQCPoTVW902Q
   Q==;
X-CSE-ConnectionGUID: e2ls0XMdRf6kVaMnLQDnAg==
X-CSE-MsgGUID: YZjyFS82SqugndsoLP227Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="91023400"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="91023400"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 14:37:55 -0800
X-CSE-ConnectionGUID: n8P5rHodS4KCIlXBu1U1ag==
X-CSE-MsgGUID: k+id6nrZSCqju1Jfuz4l6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="241152591"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 03 Mar 2026 14:37:53 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxYND-000000002xF-1dWD;
	Tue, 03 Mar 2026 22:37:51 +0000
Date: Wed, 04 Mar 2026 06:37:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:virtualization] BUILD SUCCESS
 806140e9a33218f22188fe5019c7874aa78d81f8
Message-ID: <202603040657.ARMiKPHQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git virtualization
branch HEAD: 806140e9a33218f22188fe5019c7874aa78d81f8  PCI: Avoid FLR for AMD NPU device

elapsed time: 1387m

configs tested: 55
configs skipped: 0

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
xtensa       allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
