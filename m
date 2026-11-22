Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362398;
	b=lXgkwpxTeoXMmxGWv2PYPh7oeB5Hgp3Ah0Dh3cTgLPlQToa11opuAvqpFevJKbgS9vOK
	 LmjG9Fa/Qoy1wzyRRvHH3d6eH/PNDDi8fzjhg8Lo8DC+Ayl/trBUl9FqMtQ4+PqeBKBQv
	 P9ZQ7+Cp/4/IgIP3hlG3PAqQwZCsp1EZDRunXxWmUxXageiUe6NXVhXkegF/EKkzwhQMp
	 4TxDGaZLFPx0x2v0IaTMDUwm47JYeTC8ge2ozz/ljd3EiGwqYMsKRLEqQ4Y7zd2CYzxIr
	 ezAHyjENqY2a9QA9aCJm6wyhdlKjHIbc0AJcG3uZ92C04kJ3gGUv5GywHBz022+uWQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362398;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=HNbO930+HTVnakJ2Gi5xU9dnJJEcz0CSJiqRRUgCLuQ=;
	b=SDqvpndLIuARRxvAv/gm4RTphCFJePMX+O+8vLfysZNDtd5eT6Var+Vj8rg/yQpMDUeQ
	 EUeaxdpEhr40sa644dKtqlCvV8DuSmswRQOKa6WlWanzUGKeT8ZPMQPoLBfg0F/0Z2gUX
	 D5Ct3lVKATQpCND3FBBsypQqPnKogX1Fj6UXVDYN6HioNbIQ1NjgYyQ9CfVBwj2a2BLOa
	 Hy9jNe2GzW2AAxeeiy15Iqm5eUAjMu6FLOnJqyC57ZL0J3vVfnpTw5cmmysQ4QP5P8Sq+
	 7Gg0rNvC3AXC58mN2MjcqeFyxKt7cYrZ6zOSj4yHS98oXCbq+U2A8IH0RmQYkrJsMjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kcXirUpF;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D6606A330
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 15:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C14D6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kcXirUpF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795362397; x=1826898397;
  h=date:from:to:cc:subject:message-id;
  bh=MQJzNKXr2fTf5IfPpZxTMh30k4qqKjrS8pEAz5jaMls=;
  b=kcXirUpFqDMbVhHHMs+vep3u8r3swkJ76n8hU9JadJ+63DC8kFfsZ4gi
   jN51W+N51WCJ212WddVNByGtI+5z47rTtagfOk2+6gQWWegTIpgrHHLnQ
   DpDnXMIU0tR+mUUN/ELFwCfhxTsGuL16NzK5zUYy/Ds3KJNrTFHHB/KZb
   HtMGcre6/jfTTaTi/54tsd9i+rf+YXbADrE+cqg1LSZEAc1xPd2BcPjDL
   LT5vr6ErGOLa9BvDmOk/Nnf/93yRnOYpKTq9T3Exu9MCLmOZuL/Byy7/L
   6/j5MFGrjs4aRo62COaY5cFFGm6PQJffxSEP1BryphG1HkLdm6Vy3s5e/
   w==;
X-CSE-ConnectionGUID: Pa8vLr8YSsaC84icSdgbHw==
X-CSE-MsgGUID: E+BFWmFrT92iiwx9AP4z2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4056396"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4056396"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 07:46:35 -0800
X-CSE-ConnectionGUID: At7MOPDRQSasxp1rsMaCLA==
X-CSE-MsgGUID: uYhwgf8+R3Og0VGNU7gIXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11363087"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 22 Nov 2026 07:46:35 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xV9lw-00000001Lg8-0D8W;
	Sun, 22 Nov 2026 15:46:32 +0000
Date: Sun, 22 Nov 2026 23:46:00 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 647e1e846730c6aad27e9b858df292f5d4377f63
Message-ID: <20261122234600.QzYnW0XH-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 647e1e846730c6aad27e9b858df292f5d4377f63  Merge branch 'pci/misc'

elapsed time: 1125m

configs tested: 455
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261121    gcc-14.4.0
alpha                 randconfig-2001-20261121    gcc-14.4.0
alpha                 randconfig-2200-20261121    gcc-10.5.0 smatch
alpha                randconfig-r2100-20261121    gcc-8.5.0  cocci
alpha                randconfig-r2106-20261121    clang-22   cocci
alpha                randconfig-r2110-20261121    gcc-11.5.0 cocci
alpha                randconfig-r2111-20261121    gcc-13.5.0 cocci
alpha                randconfig-r2309-20261121    gcc-11.5.0 sparse
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                      haps_hs_smp_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261122    clang-17
arc                   randconfig-1001-20261122    clang-17
arc                   randconfig-2000-20261121    gcc-8.5.0
arc                   randconfig-2001-20261121    gcc-8.5.0
arc                   randconfig-2002-20261121    gcc-8.5.0
arc                   randconfig-2003-20261121    gcc-8.5.0
arc                   randconfig-2004-20261121    gcc-8.5.0
arc                   randconfig-2005-20261121    gcc-8.5.0
arc                   randconfig-2200-20261121    gcc-14.4.0 smatch
arc                  randconfig-r2103-20261121    clang-24   cocci
arc                  randconfig-r2110-20261121    clang-22   cocci
arc                  randconfig-r2111-20261121    clang-22   cocci
arc                  randconfig-r2111-20261121    gcc-14.4.0 cocci
arc                  randconfig-r2310-20261121    clang-22   sparse
arc                  randconfig-r2310-20261121    gcc-10.5.0 sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                            h3600_defconfig    clang-17
arm                   randconfig-1000-20261122    clang-17
arm                   randconfig-1001-20261122    clang-17
arm                   randconfig-1002-20261122    clang-17
arm                   randconfig-1003-20261122    clang-17
arm                   randconfig-2000-20261121    clang-24
arm                   randconfig-2001-20261121    clang-24
arm                   randconfig-2002-20261121    clang-24
arm                   randconfig-2200-20261121    clang-19   smatch
arm                  randconfig-r2100-20261121    clang-24   cocci
arm                  randconfig-r2106-20261121    clang-22   cocci
arm                  randconfig-r2106-20261121    clang-24   cocci
arm                  randconfig-r2106-20261121    gcc-11.5.0 cocci
arm                  randconfig-r2302-20261122    gcc-11.5.0 sparse
arm                  randconfig-r2307-20261121    clang-22   sparse
arm                  randconfig-r2308-20261121    gcc-8.5.0  sparse
arm                         shmobile_defconfig    clang-17
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261122    gcc-8.5.0
arm64                 randconfig-1001-20261122    gcc-8.5.0
arm64                 randconfig-1002-20261122    gcc-8.5.0
arm64                 randconfig-1003-20261122    gcc-8.5.0
arm64                 randconfig-2000-20261121    clang-24
arm64                 randconfig-2001-20261121    clang-24
arm64                 randconfig-2002-20261121    clang-24
arm64                 randconfig-2200-20261121    clang-22   smatch
arm64                randconfig-r2102-20261121    gcc-9.5.0  cocci
arm64                randconfig-r2105-20261121    gcc-16.2.0 cocci
arm64                randconfig-r2111-20261121    clang-24   cocci
arm64                randconfig-r2301-20261121    gcc-11.5.0 sparse
arm64                randconfig-r2301-20261121    gcc-16.2.0 sparse
arm64                randconfig-r2304-20261121    gcc-16.2.0 sparse
arm64                randconfig-r2305-20261121    clang-24   sparse
arm64                randconfig-r2307-20261121    gcc-10.5.0 sparse
arm64                randconfig-r2310-20261121    gcc-13.5.0 sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261122    gcc-8.5.0
csky                  randconfig-1001-20261122    gcc-8.5.0
csky                  randconfig-2000-20261121    gcc-16.2.0
csky                  randconfig-2001-20261121    gcc-16.2.0
csky                  randconfig-2200-20261121    gcc-16.2.0 smatch
csky                 randconfig-r2100-20261121    gcc-10.5.0 cocci
csky                 randconfig-r2101-20261121    gcc-16.2.0 cocci
csky                 randconfig-r2109-20261121    gcc-13.5.0 cocci
csky                 randconfig-r2300-20261121    clang-24   sparse
csky                 randconfig-r2306-20261121    gcc-10.5.0 sparse
csky                 randconfig-r2307-20261121    gcc-11.5.0 sparse
csky                 randconfig-r2308-20261121    gcc-13.5.0 sparse
csky                 randconfig-r2310-20261121    gcc-12.5.0 sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261122    gcc-8.5.0
hexagon               randconfig-1001-20261122    gcc-8.5.0
hexagon               randconfig-2000-20261121    gcc-16.2.0
hexagon               randconfig-2001-20261121    gcc-16.2.0
hexagon               randconfig-2200-20261121    clang-24   smatch
hexagon              randconfig-r2104-20261121    gcc-16.2.0 cocci
hexagon              randconfig-r2107-20261121    clang-22   cocci
hexagon              randconfig-r2108-20261121    gcc-14.4.0 cocci
hexagon              randconfig-r2300-20261121    clang-24   sparse
hexagon              randconfig-r2305-20261121    gcc-16.2.0 sparse
hexagon              randconfig-r2305-20261122    gcc-11.5.0 sparse
hexagon              randconfig-r2306-20261121    gcc-13.5.0 sparse
hexagon              randconfig-r2309-20261121    clang-20   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261122    gcc-14
i386        buildonly-randconfig-1001-20261122    gcc-14
i386        buildonly-randconfig-1002-20261122    gcc-14
i386        buildonly-randconfig-1003-20261122    gcc-14
i386        buildonly-randconfig-1004-20261122    gcc-14
i386        buildonly-randconfig-1005-20261122    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261122    gcc-14
i386                  randconfig-1001-20261122    gcc-14
i386                  randconfig-1002-20261122    gcc-14
i386                  randconfig-1003-20261122    gcc-14
i386                  randconfig-1004-20261122    gcc-14
i386                  randconfig-1005-20261122    gcc-14
i386                  randconfig-1006-20261122    gcc-14
i386                  randconfig-1007-20261122    gcc-14
i386                  randconfig-1008-20261122    gcc-14
i386                  randconfig-1009-20261122    gcc-14
i386                  randconfig-1010-20261122    gcc-14
i386                  randconfig-1011-20261122    gcc-14
i386                  randconfig-1012-20261122    gcc-14
i386                  randconfig-1013-20261122    gcc-14
i386                  randconfig-2000-20261121    gcc-14
i386                  randconfig-2001-20261121    gcc-14
i386                  randconfig-2002-20261121    gcc-14
i386                  randconfig-2003-20261121    gcc-14
i386                  randconfig-2004-20261121    gcc-14
i386                  randconfig-2005-20261121    gcc-14
i386                  randconfig-2100-20261121    clang-22   cocci
i386                  randconfig-2101-20261121    clang-22   cocci
i386                  randconfig-2102-20261121    clang-22   cocci
i386                  randconfig-2103-20261121    clang-22   cocci
i386                  randconfig-2104-20261121    clang-22   cocci
i386                  randconfig-2105-20261121    clang-22   cocci
i386                  randconfig-2200-20261121    clang-22   smatch
i386                  randconfig-2300-20261121    gcc-14     sparse
i386                  randconfig-2301-20261121    gcc-14     sparse
i386                  randconfig-2302-20261121    gcc-14     sparse
i386                 randconfig-r2103-20261121    gcc-10.5.0 cocci
i386                 randconfig-r2107-20261121    clang-22   cocci
i386                 randconfig-r2109-20261121    clang-22   cocci
i386                 randconfig-r2111-20261121    clang-22   cocci
i386                 randconfig-r2300-20261121    gcc-16.2.0 sparse
i386                 randconfig-r2301-20261122    gcc-11.5.0 sparse
i386                 randconfig-r2311-20261121    gcc-10.5.0 sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261122    gcc-8.5.0
loongarch             randconfig-1001-20261122    gcc-8.5.0
loongarch             randconfig-2000-20261121    clang-22
loongarch             randconfig-2001-20261121    clang-22
loongarch             randconfig-2200-20261121    gcc-16.2.0 smatch
loongarch            randconfig-r2101-20261121    gcc-16.2.0 cocci
loongarch            randconfig-r2102-20261121    gcc-16.2.0 cocci
loongarch            randconfig-r2103-20261121    gcc-9.5.0  cocci
loongarch            randconfig-r2110-20261121    clang-22   cocci
loongarch            randconfig-r2302-20261121    clang-24   sparse
loongarch            randconfig-r2303-20261121    clang-21   sparse
loongarch            randconfig-r2304-20261122    gcc-11.5.0 sparse
loongarch            randconfig-r2306-20261121    clang-20   sparse
loongarch            randconfig-r2306-20261121    clang-22   sparse
loongarch            randconfig-r2309-20261121    gcc-13.5.0 sparse
loongarch            randconfig-r2311-20261121    gcc-13.5.0 sparse
m68k                              alldefconfig    gcc-16.2.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                        m5329evb_defconfig    clang-17
m68k                  randconfig-2000-20261121    gcc-14.4.0
m68k                  randconfig-2001-20261121    gcc-14.4.0
m68k                  randconfig-2200-20261121    gcc-8.5.0  smatch
m68k                 randconfig-r2107-20261121    clang-24   cocci
m68k                 randconfig-r2111-20261121    gcc-11.5.0 cocci
m68k                 randconfig-r2303-20261121    gcc-16.2.0 sparse
m68k                 randconfig-r2311-20261121    gcc-8.5.0  sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261121    gcc-14.4.0
microblaze            randconfig-2001-20261121    gcc-14.4.0
microblaze            randconfig-2200-20261121    gcc-8.5.0  smatch
microblaze           randconfig-r2102-20261121    gcc-10.5.0 cocci
microblaze           randconfig-r2105-20261121    gcc-10.5.0 cocci
microblaze           randconfig-r2109-20261121    gcc-11.5.0 cocci
microblaze           randconfig-r2309-20261121    gcc-8.5.0  sparse
microblaze           randconfig-r2311-20261121    clang-20   sparse
microblaze           randconfig-r2311-20261121    clang-22   sparse
microblaze           randconfig-r2311-20261121    gcc-11.5.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                      cu1830-neo_defconfig    gcc-16.2.0
mips                            mtx1_defconfig    clang-17
mips                  randconfig-2000-20261121    gcc-16.2.0
mips                  randconfig-2001-20261121    gcc-16.2.0
mips                  randconfig-2002-20261121    gcc-16.2.0
mips                  randconfig-2200-20261121    clang-21   smatch
mips                 randconfig-r2105-20261121    clang-24   cocci
mips                 randconfig-r2109-20261121    clang-24   cocci
mips                 randconfig-r2110-20261121    gcc-14.4.0 cocci
mips                 randconfig-r2308-20261121    clang-20   sparse
mips                           rb532_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261122    gcc-8.5.0
nios2                 randconfig-1001-20261122    gcc-8.5.0
nios2                 randconfig-2000-20261121    clang-22
nios2                 randconfig-2001-20261121    clang-22
nios2                 randconfig-2200-20261121    gcc-10.5.0 smatch
nios2                randconfig-r2101-20261121    gcc-8.5.0  cocci
nios2                randconfig-r2104-20261121    gcc-10.5.0 cocci
nios2                randconfig-r2104-20261121    gcc-16.2.0 cocci
nios2                randconfig-r2106-20261121    gcc-13.5.0 cocci
nios2                randconfig-r2108-20261121    gcc-11.5.0 cocci
nios2                randconfig-r2300-20261122    gcc-11.5.0 sparse
nios2                randconfig-r2303-20261122    gcc-11.5.0 sparse
nios2                randconfig-r2305-20261121    clang-21   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261121    gcc-16.2.0
openrisc              randconfig-2001-20261121    gcc-16.2.0
openrisc              randconfig-2002-20261121    gcc-16.2.0
openrisc              randconfig-2200-20261121    gcc-14.4.0 smatch
openrisc             randconfig-r2104-20261121    gcc-8.5.0  cocci
openrisc             randconfig-r2105-20261121    gcc-9.5.0  cocci
openrisc             randconfig-r2303-20261121    gcc-11.5.0 sparse
openrisc             randconfig-r2304-20261121    clang-24   sparse
openrisc             randconfig-r2308-20261121    gcc-10.5.0 sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261122    clang-24
parisc                randconfig-1001-20261122    clang-24
parisc                randconfig-2000-20261121    clang-22
parisc                randconfig-2001-20261121    clang-22
parisc                randconfig-2200-20261121    gcc-16.2.0 smatch
parisc               randconfig-r2101-20261121    gcc-10.5.0 cocci
parisc               randconfig-r2102-20261121    gcc-16.2.0 cocci
parisc               randconfig-r2103-20261121    gcc-16.2.0 cocci
parisc               randconfig-r2103-20261121    gcc-8.5.0  cocci
parisc               randconfig-r2107-20261121    gcc-13.5.0 cocci
parisc               randconfig-r2108-20261121    clang-22   cocci
parisc               randconfig-r2109-20261121    clang-22   cocci
parisc               randconfig-r2110-20261121    clang-22   cocci
parisc               randconfig-r2301-20261121    clang-21   sparse
parisc               randconfig-r2303-20261121    clang-24   sparse
parisc               randconfig-r2306-20261121    gcc-11.5.0 sparse
parisc               randconfig-r2307-20261121    gcc-13.5.0 sparse
parisc               randconfig-r2308-20261121    gcc-12.5.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                         icon_defconfig    gcc-16.2.0
powerpc                   mpc866_ads_defconfig    clang-17
powerpc               randconfig-1000-20261122    clang-24
powerpc               randconfig-1001-20261122    clang-24
powerpc               randconfig-2000-20261121    clang-24
powerpc               randconfig-2001-20261121    clang-24
powerpc               randconfig-2002-20261121    clang-24
powerpc               randconfig-2200-20261121    gcc-11.5.0 smatch
powerpc              randconfig-r2107-20261121    gcc-11.5.0 cocci
powerpc              randconfig-r2301-20261121    clang-24   sparse
powerpc              randconfig-r2309-20261121    gcc-10.5.0 sparse
powerpc                      sequoia_defconfig    clang-17
powerpc                      tqm5200_defconfig    gcc-16.2.0
powerpc                      tqm8560_defconfig    gcc-16.2.0
powerpc                         warp_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261122    clang-24
powerpc64             randconfig-1001-20261122    clang-24
powerpc64             randconfig-2000-20261121    clang-24
powerpc64             randconfig-2001-20261121    clang-24
powerpc64             randconfig-2002-20261121    clang-24
powerpc64             randconfig-2200-20261121    gcc-10.5.0 smatch
powerpc64            randconfig-r2102-20261121    gcc-8.5.0  cocci
powerpc64            randconfig-r2109-20261121    gcc-14.4.0 cocci
powerpc64            randconfig-r2304-20261121    gcc-11.5.0 sparse
powerpc64            randconfig-r2306-20261121    gcc-8.5.0  sparse
powerpc64            randconfig-r2307-20261121    gcc-12.5.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261122    gcc-9.5.0
riscv                 randconfig-1001-20261122    gcc-9.5.0
riscv                 randconfig-2000-20261121    gcc-9.5.0
riscv                 randconfig-2001-20261121    gcc-9.5.0
riscv                 randconfig-2002-20261121    gcc-9.5.0
riscv                 randconfig-2003-20261121    gcc-9.5.0
riscv                 randconfig-2004-20261121    gcc-9.5.0
riscv                 randconfig-2005-20261121    gcc-9.5.0
riscv                 randconfig-2200-20261121    clang-24   smatch
riscv                randconfig-r2101-20261121    clang-24   cocci
riscv                randconfig-r2102-20261121    clang-24   cocci
riscv                randconfig-r2108-20261121    clang-24   cocci
riscv                randconfig-r2310-20261121    gcc-8.5.0  sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261122    gcc-9.5.0
s390                  randconfig-1001-20261122    gcc-9.5.0
s390                  randconfig-2000-20261121    clang-22
s390                  randconfig-2001-20261121    clang-22
s390                  randconfig-2002-20261121    clang-22
s390                  randconfig-2003-20261121    clang-22
s390                  randconfig-2004-20261121    clang-22
s390                  randconfig-2005-20261121    clang-22
s390                  randconfig-2200-20261121    gcc-8.5.0  smatch
s390                 randconfig-r2101-20261121    gcc-9.5.0  cocci
s390                 randconfig-r2104-20261121    clang-24   cocci
s390                 randconfig-r2106-20261121    clang-22   cocci
s390                 randconfig-r2106-20261121    gcc-14.4.0 cocci
s390                 randconfig-r2110-20261121    gcc-13.5.0 cocci
s390                 randconfig-r2301-20261121    clang-24   sparse
s390                 randconfig-r2303-20261121    clang-24   sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261122    gcc-9.5.0
sh                    randconfig-1001-20261122    gcc-9.5.0
sh                    randconfig-2000-20261121    gcc-16.2.0
sh                    randconfig-2001-20261121    gcc-16.2.0
sh                    randconfig-2002-20261121    gcc-16.2.0
sh                    randconfig-2003-20261121    gcc-16.2.0
sh                    randconfig-2004-20261121    gcc-16.2.0
sh                    randconfig-2005-20261121    gcc-16.2.0
sh                    randconfig-2200-20261121    gcc-10.5.0 smatch
sh                   randconfig-r2110-20261121    clang-24   cocci
sh                   randconfig-r2300-20261121    clang-21   sparse
sh                      sh7710voipgw_defconfig    clang-17
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261122    clang-24
sparc                 randconfig-1001-20261122    clang-24
sparc                 randconfig-2000-20261121    gcc-8.5.0
sparc                 randconfig-2001-20261121    gcc-8.5.0
sparc                 randconfig-2200-20261121    gcc-8.5.0  smatch
sparc                randconfig-r2100-20261121    gcc-16.2.0 cocci
sparc                randconfig-r2105-20261121    gcc-8.5.0  cocci
sparc                randconfig-r2107-20261121    gcc-14.4.0 cocci
sparc                randconfig-r2108-20261121    clang-22   cocci
sparc                randconfig-r2304-20261121    clang-24   sparse
sparc                randconfig-r2310-20261121    clang-20   sparse
sparc                randconfig-r2310-20261121    gcc-11.5.0 sparse
sparc                randconfig-r2311-20261121    gcc-12.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261122    clang-24
sparc64               randconfig-1001-20261122    clang-24
sparc64               randconfig-2000-20261121    gcc-8.5.0
sparc64               randconfig-2001-20261121    gcc-8.5.0
sparc64               randconfig-2200-20261121    clang-20   smatch
sparc64              randconfig-r2302-20261121    gcc-11.5.0 sparse
sparc64              randconfig-r2307-20261121    gcc-8.5.0  sparse
sparc64              randconfig-r2308-20261121    clang-22   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261122    clang-24
um                    randconfig-1001-20261122    clang-24
um                    randconfig-2000-20261121    gcc-8.5.0
um                    randconfig-2001-20261121    gcc-8.5.0
um                    randconfig-2200-20261121    gcc-14     smatch
um                   randconfig-r2104-20261121    gcc-9.5.0  cocci
um                   randconfig-r2108-20261121    gcc-13.5.0 cocci
um                   randconfig-r2302-20261121    clang-21   sparse
um                   randconfig-r2302-20261121    clang-24   sparse
um                   randconfig-r2304-20261121    clang-21   sparse
um                   randconfig-r2308-20261121    gcc-11.5.0 sparse
um                   randconfig-r2309-20261121    gcc-12.5.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261122    gcc-14
x86_64                randconfig-1001-20261122    gcc-14
x86_64                randconfig-1002-20261122    gcc-14
x86_64                randconfig-1003-20261122    gcc-14
x86_64                randconfig-1004-20261122    gcc-14
x86_64                randconfig-1005-20261122    gcc-14
x86_64                randconfig-1006-20261122    gcc-14
x86_64                randconfig-1007-20261122    gcc-14
x86_64                randconfig-1008-20261122    gcc-14
x86_64                randconfig-1009-20261122    gcc-14
x86_64                randconfig-1010-20261122    gcc-14
x86_64                randconfig-1011-20261122    gcc-14
x86_64                randconfig-1012-20261122    clang-22
x86_64                randconfig-1013-20261122    clang-22
x86_64                randconfig-1014-20261122    clang-22
x86_64                randconfig-1015-20261122    clang-22
x86_64                randconfig-1016-20261122    clang-22
x86_64                randconfig-1017-20261122    clang-22
x86_64                randconfig-2000-20261121    gcc-14
x86_64                randconfig-2001-20261121    gcc-14
x86_64                randconfig-2002-20261121    gcc-14
x86_64                randconfig-2003-20261121    gcc-14
x86_64                randconfig-2004-20261121    gcc-14
x86_64                randconfig-2005-20261121    gcc-14
x86_64                randconfig-2100-20261121    gcc-14     cocci
x86_64                randconfig-2101-20261121    gcc-14     cocci
x86_64                randconfig-2102-20261121    gcc-14     cocci
x86_64                randconfig-2103-20261121    gcc-14     cocci
x86_64                randconfig-2104-20261121    gcc-14     cocci
x86_64                randconfig-2105-20261121    gcc-14     cocci
x86_64                randconfig-2200-20261121    gcc-14     smatch
x86_64                randconfig-2300-20261121    gcc-14     sparse
x86_64                randconfig-2301-20261121    gcc-14     sparse
x86_64                randconfig-2302-20261121    gcc-14     sparse
x86_64               randconfig-r2107-20261121    clang-22   cocci
x86_64               randconfig-r2300-20261121    gcc-11.5.0 sparse
x86_64               randconfig-r2302-20261121    gcc-16.2.0 sparse
x86_64               randconfig-r2306-20261121    gcc-12.5.0 sparse
x86_64               randconfig-r2307-20261121    clang-20   sparse
x86_64               randconfig-r2309-20261121    clang-22   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   nommu_kc705_defconfig    clang-17
xtensa                randconfig-1000-20261122    clang-24
xtensa                randconfig-1001-20261122    clang-24
xtensa                randconfig-2000-20261121    gcc-16.2.0
xtensa                randconfig-2001-20261121    gcc-16.2.0
xtensa                randconfig-2200-20261121    gcc-12.5.0 smatch
xtensa               randconfig-r2100-20261121    gcc-9.5.0  cocci
xtensa               randconfig-r2105-20261121    gcc-16.2.0 cocci
xtensa               randconfig-r2108-20261121    clang-22   cocci
xtensa               randconfig-r2111-20261121    clang-22   cocci
xtensa               randconfig-r2305-20261121    gcc-11.5.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
