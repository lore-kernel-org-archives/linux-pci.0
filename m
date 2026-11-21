Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795241714;
	b=K3Vfn41zd/sK3zmXf4jj/W2c51/lAI0aVw1Sl69BQd7F19rHFH+vTd66uXgFrGfPEqdu
	 wjnhBkqIlz0Ut1kZOM+t/7SS3I4fC7LAg13JG7v+J+CjBhHIPwuYCcMYnr06y7cFK6Qhl
	 JpA2TnYn0AKgJUWd4opJ/Y25SyeMlYNjvFCKYEAS8XAKQfO2nzbanm7wq/Pkh0mfCLLf0
	 DtkCSQXkSgRmXCdqfNhGAaLnQv+rINKioeWyCPc2w0UCe660ctu6vWwCoHua/P0cNbHN7
	 TXR1N9a5CgOGufq7H/A5D6C+muTvANM/A6NHTZ8P0ecO2RXQZS8XaAXChjeHlr6cmCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795241714;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=RVTKSZKf/3uy+4a3o1N7FosfbjNKGji0YvybUhsgDO0=;
	b=NQroy0WO8HDio0qPU40Eto79T3uvAZeWhPk2t1GbFNyEq9keqZTfHRp3+5UBNPJsNcO1
	 t+koTxIajl34Q7gPt8zDHofCJ+g5VDJRFB/Ehsa+8FBSzfl65d0vDe+K2OoWd9XajDTS1
	 9LwK47pxGNdjE/dxHaPBPwFsK4yfSrq7zQIeo62fJA0giInp3Y8ysPDOGtbaPSfmuemmf
	 lxzgS5C1WHah8YXnaOr/pfWz74PUpsmiq22vnCEKwLRH94jOPeA/bUhK8beajhRxxhj4Q
	 fZzmfAZPKmGTV7lO8PLzC6B3FEMv5x6bPOjLRYJdgtqJI+9bbj2yyn0C0htxq0UG2wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eOSTdbfc;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F05606A320
	for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 06:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12F05606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eOSTdbfc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795241715; x=1826777715;
  h=date:from:to:cc:subject:message-id;
  bh=uH/nxf1CmVje2aCp8TlXHqNY1fGwcWwTWRXBSI7O3XA=;
  b=eOSTdbfcuChdvgl27wyrnuEcSJgNEod2ZxXf56PddHNutsa2DAWfAHWQ
   CtDNGPlPeX08doYkgHaSfJ/PJ66779IeMmu0ldMiksJGHtGnqsJkS6RZ4
   5G7THIKLP9UA8bSgBJ0pmFwflPvdtLGokjDEUGO7E3DlAz83bIy27DRl2
   +7e/MaMpr7hoCsqhd7Bj3p85B46wmygq/4hU+ArU1CubA+rUt8uwO4AKv
   nUolg1DLrYxKAog89gWNwbQ1nlz+DgKGjVwLOIqdV8E0k2CmkhiZE6xWf
   9Vy8uhKTH04k+gK6qqRPIHb4RsZcEIQClzrcg2w7NOSHT/ZB7M0WfvkD+
   Q==;
X-CSE-ConnectionGUID: /TUhSJkRTt665vFVwYEbsQ==
X-CSE-MsgGUID: pk4c59/NTsqixxZkk8Za5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4110491"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4110491"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 22:15:13 -0800
X-CSE-ConnectionGUID: surZ1eZlQtqiuMeOCzOHpA==
X-CSE-MsgGUID: Io8jZni5SeaFieaCzrgJCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="12690071"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 20 Nov 2026 22:15:10 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xUeNQ-00000001JbX-2Dz8;
	Sat, 21 Nov 2026 06:15:08 +0000
Date: Sat, 21 Nov 2026 14:15:01 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 e735de71a2d9403fa1e2d134d1e9aa0a24f4eaff
Message-ID: <20261121141501.jdD15hki-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: e735de71a2d9403fa1e2d134d1e9aa0a24f4eaff  MAINTAINERS: Add Donghui Zhao as ESWIN PCIe maintainer

elapsed time: 1509m

configs tested: 512
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        randconfig-2000-20261118    gcc-16.2.0
alpha        randconfig-2000-20261119    gcc-8.5.0
alpha        randconfig-2001-20261118    gcc-16.2.0
alpha        randconfig-2001-20261119    gcc-8.5.0
alpha        randconfig-2200-20261118    gcc-13.5.0 smatch
alpha        randconfig-2200-20261119    gcc-12.5.0 smatch
alpha       randconfig-r2103-20261118    gcc-13.5.0 cocci
alpha       randconfig-r2110-20261118    gcc-14     cocci
alpha       randconfig-r2301-20261119    gcc-16.2.0 sparse
alpha       randconfig-r2304-20261118    gcc-8.5.0  sparse
alpha       randconfig-r2306-20261118    gcc-14.4.0 sparse
alpha       randconfig-r2306-20261119    gcc-14     sparse
alpha       randconfig-r2307-20261119    gcc-10.5.0 sparse
alpha       randconfig-r2311-20261119    gcc-11.5.0 sparse
alpha       randconfig-r2311-20261119    gcc-14.4.0 sparse
arc          randconfig-2000-20261118    gcc-11.5.0
arc          randconfig-2000-20261119    gcc-14.4.0
arc          randconfig-2001-20261118    gcc-11.5.0
arc          randconfig-2001-20261119    gcc-14.4.0
arc          randconfig-2002-20261118    gcc-11.5.0
arc          randconfig-2002-20261119    gcc-14.4.0
arc          randconfig-2003-20261118    gcc-11.5.0
arc          randconfig-2003-20261119    gcc-14.4.0
arc          randconfig-2004-20261118    gcc-11.5.0
arc          randconfig-2004-20261119    gcc-14.4.0
arc          randconfig-2005-20261118    gcc-11.5.0
arc          randconfig-2005-20261119    gcc-14.4.0
arc          randconfig-2200-20261118    gcc-9.5.0  smatch
arc          randconfig-2200-20261119    gcc-16.2.0 smatch
arc         randconfig-r2101-20261118    clang-24   cocci
arc         randconfig-r2102-20261118    clang-20   cocci
arc         randconfig-r2301-20261119    gcc-16.2.0 sparse
arc         randconfig-r2305-20261118    clang-22   sparse
arc         randconfig-r2308-20261119    gcc-14     sparse
arc         randconfig-r2308-20261119    gcc-8.5.0  sparse
arm          randconfig-2000-20261118    gcc-13.5.0
arm          randconfig-2000-20261119    gcc-16.2.0
arm          randconfig-2001-20261118    gcc-13.5.0
arm          randconfig-2001-20261119    gcc-16.2.0
arm          randconfig-2002-20261118    gcc-13.5.0
arm          randconfig-2002-20261119    gcc-16.2.0
arm          randconfig-2200-20261118    gcc-8.5.0  smatch
arm          randconfig-2200-20261119    clang-24   smatch
arm         randconfig-r2103-20261118    clang-17   cocci
arm         randconfig-r2105-20261118    gcc-13.5.0 cocci
arm         randconfig-r2109-20261119    gcc-12.5.0 cocci
arm         randconfig-r2110-20261118    gcc-14     cocci
arm         randconfig-r2302-20261118    gcc-14.4.0 sparse
arm         randconfig-r2305-20261119    gcc-13.5.0 sparse
arm         randconfig-r2306-20261119    gcc-10.5.0 sparse
arm         randconfig-r2308-20261119    gcc-14.4.0 sparse
arm64        randconfig-2000-20261118    gcc-13.5.0
arm64        randconfig-2000-20261119    gcc-16.2.0
arm64        randconfig-2001-20261118    gcc-13.5.0
arm64        randconfig-2001-20261119    gcc-16.2.0
arm64        randconfig-2002-20261118    gcc-13.5.0
arm64        randconfig-2002-20261119    gcc-16.2.0
arm64        randconfig-2200-20261118    clang-24   smatch
arm64        randconfig-2200-20261119    clang-17   smatch
arm64       randconfig-r2100-20261118    clang-20   cocci
arm64       randconfig-r2100-20261119    gcc-11.5.0 cocci
arm64       randconfig-r2101-20261118    clang-20   cocci
arm64       randconfig-r2101-20261119    clang-19   cocci
arm64       randconfig-r2102-20261119    gcc-11.5.0 cocci
arm64       randconfig-r2103-20261118    clang-20   cocci
arm64       randconfig-r2103-20261119    clang-17   cocci
arm64       randconfig-r2106-20261119    gcc-12.5.0 cocci
arm64       randconfig-r2300-20261119    gcc-16.2.0 sparse
arm64       randconfig-r2301-20261119    gcc-13.5.0 sparse
arm64       randconfig-r2303-20261118    gcc-8.5.0  sparse
arm64       randconfig-r2303-20261119    gcc-8.5.0  sparse
arm64       randconfig-r2305-20261119    gcc-16.2.0 sparse
arm64       randconfig-r2311-20261118    clang-20   sparse
arm64       randconfig-r2311-20261119    clang-24   sparse
csky         randconfig-2000-20261118    gcc-16.2.0
csky         randconfig-2000-20261119    gcc-16.2.0
csky         randconfig-2001-20261118    gcc-16.2.0
csky         randconfig-2001-20261119    gcc-16.2.0
csky         randconfig-2200-20261118    gcc-16.2.0 smatch
csky         randconfig-2200-20261119    gcc-16.2.0 smatch
csky        randconfig-r2101-20261119    gcc-11.5.0 cocci
csky        randconfig-r2103-20261119    gcc-8.5.0  cocci
csky        randconfig-r2104-20261118    gcc-14     cocci
csky        randconfig-r2302-20261119    gcc-16.2.0 sparse
csky        randconfig-r2304-20261118    gcc-9.5.0  sparse
csky        randconfig-r2310-20261118    gcc-14     sparse
hexagon      randconfig-2000-20261118    gcc-16.2.0
hexagon      randconfig-2000-20261119    gcc-16.2.0
hexagon      randconfig-2001-20261118    gcc-16.2.0
hexagon      randconfig-2001-20261119    gcc-16.2.0
hexagon      randconfig-2200-20261118    clang-20   smatch
hexagon      randconfig-2200-20261119    clang-17   smatch
hexagon     randconfig-r2102-20261119    gcc-8.5.0  cocci
hexagon     randconfig-r2102-20261119    gcc-9.5.0  cocci
hexagon     randconfig-r2104-20261118    gcc-13.5.0 cocci
hexagon     randconfig-r2104-20261119    clang-24   cocci
hexagon     randconfig-r2305-20261119    clang-24   sparse
hexagon     randconfig-r2309-20261118    gcc-14.4.0 sparse
hexagon     randconfig-r2309-20261119    gcc-11.5.0 sparse
i386         randconfig-2000-20261118    gcc-14
i386         randconfig-2000-20261119    gcc-14
i386         randconfig-2001-20261118    gcc-14
i386         randconfig-2001-20261119    gcc-14
i386         randconfig-2002-20261118    gcc-14
i386         randconfig-2002-20261119    gcc-14
i386         randconfig-2003-20261118    gcc-14
i386         randconfig-2003-20261119    gcc-14
i386         randconfig-2004-20261118    gcc-14
i386         randconfig-2004-20261119    gcc-14
i386         randconfig-2005-20261118    gcc-14
i386         randconfig-2005-20261119    gcc-14
i386         randconfig-2100-20261118    gcc-14     cocci
i386         randconfig-2100-20261119    clang-22   cocci
i386         randconfig-2101-20261118    gcc-14     cocci
i386         randconfig-2101-20261119    clang-22   cocci
i386         randconfig-2102-20261118    gcc-14     cocci
i386         randconfig-2102-20261119    clang-22   cocci
i386         randconfig-2103-20261118    gcc-14     cocci
i386         randconfig-2103-20261119    clang-22   cocci
i386         randconfig-2104-20261118    gcc-14     cocci
i386         randconfig-2104-20261119    clang-22   cocci
i386         randconfig-2105-20261118    gcc-14     cocci
i386         randconfig-2105-20261119    clang-22   cocci
i386         randconfig-2200-20261118    gcc-13     smatch
i386         randconfig-2200-20261119    gcc-14     smatch
i386         randconfig-2300-20261118    gcc-14     sparse
i386         randconfig-2300-20261119    gcc-14     sparse
i386         randconfig-2301-20261118    gcc-14     sparse
i386         randconfig-2301-20261119    gcc-14     sparse
i386         randconfig-2302-20261118    gcc-14     sparse
i386         randconfig-2302-20261119    gcc-14     sparse
i386        randconfig-r2101-20261118    clang-17   cocci
i386        randconfig-r2104-20261119    gcc-8.5.0  cocci
i386        randconfig-r2105-20261119    clang-17   cocci
i386        randconfig-r2106-20261118    gcc-14     cocci
i386        randconfig-r2107-20261119    gcc-14     cocci
i386        randconfig-r2108-20261118    gcc-8.5.0  cocci
i386        randconfig-r2108-20261119    clang-24   cocci
i386        randconfig-r2108-20261119    gcc-14     cocci
i386        randconfig-r2110-20261118    gcc-11.5.0 cocci
i386        randconfig-r2110-20261118    gcc-8.5.0  cocci
i386        randconfig-r2300-20261118    gcc-8.5.0  sparse
i386        randconfig-r2300-20261118    gcc-9.5.0  sparse
i386        randconfig-r2305-20261119    gcc-11.5.0 sparse
i386        randconfig-r2307-20261119    gcc-11.5.0 sparse
loongarch    randconfig-2000-20261118    gcc-11.5.0
loongarch    randconfig-2000-20261119    gcc-8.5.0
loongarch    randconfig-2001-20261118    gcc-11.5.0
loongarch    randconfig-2001-20261119    gcc-8.5.0
loongarch    randconfig-2200-20261118    gcc-16.2.0 smatch
loongarch    randconfig-2200-20261119    clang-24   smatch
loongarch   randconfig-r2100-20261118    gcc-14     cocci
loongarch   randconfig-r2102-20261119    clang-17   cocci
loongarch   randconfig-r2105-20261119    gcc-14.4.0 cocci
loongarch   randconfig-r2110-20261119    gcc-10.5.0 cocci
loongarch   randconfig-r2111-20261119    gcc-12.5.0 cocci
loongarch   randconfig-r2303-20261118    gcc-14.4.0 sparse
loongarch   randconfig-r2303-20261119    gcc-13.5.0 sparse
loongarch   randconfig-r2304-20261119    gcc-16.2.0 sparse
loongarch   randconfig-r2305-20261118    gcc-9.5.0  sparse
loongarch   randconfig-r2308-20261118    gcc-14.4.0 sparse
loongarch   randconfig-r2309-20261119    clang-24   sparse
loongarch   randconfig-r2309-20261119    gcc-8.5.0  sparse
m68k         randconfig-2000-20261118    gcc-16.2.0
m68k         randconfig-2000-20261119    gcc-8.5.0
m68k         randconfig-2001-20261118    gcc-16.2.0
m68k         randconfig-2001-20261119    gcc-8.5.0
m68k         randconfig-2200-20261118    gcc-12.5.0 smatch
m68k         randconfig-2200-20261119    gcc-9.5.0  smatch
m68k        randconfig-r2100-20261119    gcc-9.5.0  cocci
m68k        randconfig-r2102-20261118    gcc-13.5.0 cocci
m68k        randconfig-r2104-20261119    gcc-11.5.0 cocci
m68k        randconfig-r2106-20261118    gcc-8.5.0  cocci
m68k        randconfig-r2106-20261119    gcc-10.5.0 cocci
m68k        randconfig-r2111-20261119    gcc-12.5.0 cocci
m68k        randconfig-r2300-20261119    clang-24   sparse
m68k        randconfig-r2301-20261118    gcc-8.5.0  sparse
m68k        randconfig-r2307-20261118    clang-24   sparse
m68k        randconfig-r2310-20261118    clang-20   sparse
microblaze   randconfig-2000-20261118    gcc-16.2.0
microblaze   randconfig-2000-20261119    gcc-8.5.0
microblaze   randconfig-2001-20261118    gcc-16.2.0
microblaze   randconfig-2001-20261119    gcc-8.5.0
microblaze   randconfig-2200-20261118    gcc-13.5.0 smatch
microblaze   randconfig-2200-20261119    gcc-12.5.0 smatch
microblaze  randconfig-r2103-20261119    gcc-14.4.0 cocci
microblaze  randconfig-r2104-20261119    clang-19   cocci
microblaze  randconfig-r2105-20261119    gcc-8.5.0  cocci
microblaze  randconfig-r2107-20261119    gcc-12.5.0 cocci
microblaze  randconfig-r2111-20261119    gcc-12.5.0 cocci
microblaze  randconfig-r2302-20261118    gcc-9.5.0  sparse
microblaze  randconfig-r2302-20261119    gcc-8.5.0  sparse
microblaze  randconfig-r2305-20261118    gcc-8.5.0  sparse
microblaze  randconfig-r2309-20261118    clang-24   sparse
mips         randconfig-2000-20261118    gcc-15.3.0
mips         randconfig-2000-20261119    gcc-16.2.0
mips         randconfig-2001-20261118    gcc-15.3.0
mips         randconfig-2001-20261119    gcc-16.2.0
mips         randconfig-2002-20261118    gcc-15.3.0
mips         randconfig-2002-20261119    gcc-16.2.0
mips         randconfig-2200-20261118    clang-24   smatch
mips         randconfig-2200-20261119    clang-24   smatch
mips        randconfig-r2101-20261118    gcc-14     cocci
mips        randconfig-r2103-20261119    gcc-11.5.0 cocci
mips        randconfig-r2105-20261118    gcc-14     cocci
mips        randconfig-r2106-20261119    gcc-12.5.0 cocci
mips        randconfig-r2107-20261119    clang-24   cocci
mips        randconfig-r2110-20261119    gcc-14     cocci
mips        randconfig-r2300-20261119    gcc-16.2.0 sparse
mips        randconfig-r2301-20261118    clang-22   sparse
mips        randconfig-r2305-20261118    gcc-14.4.0 sparse
mips        randconfig-r2306-20261119    clang-24   sparse
mips        randconfig-r2306-20261119    gcc-11.5.0 sparse
mips        randconfig-r2307-20261119    gcc-8.5.0  sparse
mips        randconfig-r2310-20261118    gcc-9.5.0  sparse
mips        randconfig-r2310-20261119    gcc-11.5.0 sparse
mips        randconfig-r2310-20261119    gcc-14.4.0 sparse
nios2        randconfig-2000-20261118    gcc-11.5.0
nios2        randconfig-2000-20261119    gcc-8.5.0
nios2        randconfig-2001-20261118    gcc-11.5.0
nios2        randconfig-2001-20261119    gcc-8.5.0
nios2        randconfig-2200-20261118    gcc-8.5.0  smatch
nios2        randconfig-2200-20261119    gcc-11.5.0 smatch
nios2       randconfig-r2101-20261119    gcc-8.5.0  cocci
nios2       randconfig-r2101-20261119    gcc-9.5.0  cocci
nios2       randconfig-r2102-20261119    clang-19   cocci
nios2       randconfig-r2102-20261119    gcc-14.4.0 cocci
nios2       randconfig-r2104-20261118    clang-17   cocci
nios2       randconfig-r2104-20261118    clang-20   cocci
nios2       randconfig-r2105-20261118    clang-24   cocci
nios2       randconfig-r2105-20261119    gcc-9.5.0  cocci
nios2       randconfig-r2106-20261119    gcc-14     cocci
nios2       randconfig-r2107-20261119    gcc-12.5.0 cocci
nios2       randconfig-r2108-20261118    gcc-14     cocci
nios2       randconfig-r2109-20261118    gcc-11.5.0 cocci
nios2       randconfig-r2109-20261118    gcc-14     cocci
nios2       randconfig-r2109-20261119    gcc-12.5.0 cocci
nios2       randconfig-r2111-20261118    gcc-11.5.0 cocci
nios2       randconfig-r2300-20261118    clang-22   sparse
nios2       randconfig-r2300-20261119    gcc-11.5.0 sparse
nios2       randconfig-r2303-20261119    gcc-11.5.0 sparse
nios2       randconfig-r2311-20261119    gcc-8.5.0  sparse
openrisc     randconfig-2000-20261118    gcc-15.3.0
openrisc     randconfig-2000-20261119    gcc-16.2.0
openrisc     randconfig-2001-20261118    gcc-15.3.0
openrisc     randconfig-2001-20261119    gcc-16.2.0
openrisc     randconfig-2002-20261118    gcc-15.3.0
openrisc     randconfig-2002-20261119    gcc-16.2.0
openrisc     randconfig-2200-20261118    gcc-16.2.0 smatch
openrisc     randconfig-2200-20261119    gcc-16.2.0 smatch
openrisc    randconfig-r2100-20261119    gcc-14.4.0 cocci
openrisc    randconfig-r2101-20261119    clang-17   cocci
openrisc    randconfig-r2106-20261119    clang-24   cocci
openrisc    randconfig-r2107-20261118    gcc-14     cocci
openrisc    randconfig-r2107-20261118    gcc-8.5.0  cocci
openrisc    randconfig-r2108-20261118    gcc-14     cocci
openrisc    randconfig-r2109-20261119    gcc-10.5.0 cocci
openrisc    randconfig-r2111-20261118    gcc-14     cocci
openrisc    randconfig-r2300-20261119    gcc-8.5.0  sparse
openrisc    randconfig-r2302-20261118    gcc-8.5.0  sparse
openrisc    randconfig-r2304-20261118    gcc-14.4.0 sparse
openrisc    randconfig-r2310-20261118    clang-24   sparse
parisc       randconfig-2000-20261118    gcc-11.5.0
parisc       randconfig-2000-20261119    gcc-8.5.0
parisc       randconfig-2001-20261118    gcc-11.5.0
parisc       randconfig-2001-20261119    gcc-8.5.0
parisc       randconfig-2200-20261118    gcc-11.5.0 smatch
parisc       randconfig-2200-20261119    gcc-14.4.0 smatch
parisc      randconfig-r2104-20261118    clang-24   cocci
parisc      randconfig-r2104-20261119    clang-17   cocci
parisc      randconfig-r2105-20261118    clang-20   cocci
parisc      randconfig-r2105-20261119    clang-19   cocci
parisc      randconfig-r2107-20261118    gcc-14     cocci
parisc      randconfig-r2108-20261119    gcc-10.5.0 cocci
parisc      randconfig-r2110-20261119    gcc-12.5.0 cocci
parisc      randconfig-r2111-20261119    gcc-10.5.0 cocci
parisc      randconfig-r2307-20261118    gcc-14.4.0 sparse
parisc      randconfig-r2309-20261118    gcc-14     sparse
parisc      randconfig-r2309-20261119    gcc-10.5.0 sparse
powerpc      randconfig-2000-20261118    clang-21
powerpc      randconfig-2000-20261119    gcc-15.3.0
powerpc      randconfig-2001-20261118    clang-21
powerpc      randconfig-2001-20261119    gcc-15.3.0
powerpc      randconfig-2002-20261118    clang-21
powerpc      randconfig-2002-20261119    gcc-15.3.0
powerpc      randconfig-2200-20261118    clang-24   smatch
powerpc      randconfig-2200-20261119    gcc-13.5.0 smatch
powerpc     randconfig-r2100-20261119    clang-19   cocci
powerpc     randconfig-r2102-20261118    clang-24   cocci
powerpc     randconfig-r2102-20261118    gcc-14     cocci
powerpc     randconfig-r2109-20261119    gcc-14     cocci
powerpc     randconfig-r2301-20261119    gcc-11.5.0 sparse
powerpc     randconfig-r2302-20261118    clang-22   sparse
powerpc     randconfig-r2303-20261119    gcc-16.2.0 sparse
powerpc     randconfig-r2306-20261118    clang-20   sparse
powerpc     randconfig-r2307-20261119    gcc-14.4.0 sparse
powerpc     randconfig-r2308-20261118    gcc-14     sparse
powerpc     randconfig-r2310-20261119    gcc-14     sparse
powerpc64    randconfig-2000-20261118    clang-21
powerpc64    randconfig-2000-20261119    gcc-15.3.0
powerpc64    randconfig-2001-20261118    clang-21
powerpc64    randconfig-2001-20261119    gcc-15.3.0
powerpc64    randconfig-2002-20261118    clang-21
powerpc64    randconfig-2002-20261119    gcc-15.3.0
powerpc64    randconfig-2200-20261118    clang-24   smatch
powerpc64    randconfig-2200-20261119    clang-24   smatch
powerpc64   randconfig-r2100-20261119    gcc-8.5.0  cocci
powerpc64   randconfig-r2104-20261119    gcc-9.5.0  cocci
powerpc64   randconfig-r2305-20261119    gcc-8.5.0  sparse
powerpc64   randconfig-r2306-20261118    clang-24   sparse
powerpc64   randconfig-r2306-20261119    gcc-14.4.0 sparse
powerpc64   randconfig-r2308-20261118    gcc-9.5.0  sparse
powerpc64   randconfig-r2308-20261119    gcc-10.5.0 sparse
powerpc64   randconfig-r2310-20261119    gcc-8.5.0  sparse
riscv        randconfig-2000-20261118    gcc-8.5.0
riscv        randconfig-2000-20261119    clang-24
riscv        randconfig-2000-20261120    clang-24
riscv        randconfig-2001-20261118    gcc-8.5.0
riscv        randconfig-2001-20261119    clang-24
riscv        randconfig-2001-20261120    clang-24
riscv        randconfig-2002-20261118    gcc-8.5.0
riscv        randconfig-2002-20261119    clang-24
riscv        randconfig-2002-20261120    clang-24
riscv        randconfig-2003-20261118    gcc-8.5.0
riscv        randconfig-2003-20261119    clang-24
riscv        randconfig-2003-20261120    clang-24
riscv        randconfig-2004-20261118    gcc-8.5.0
riscv        randconfig-2004-20261119    clang-24
riscv        randconfig-2004-20261120    clang-24
riscv        randconfig-2005-20261118    gcc-8.5.0
riscv        randconfig-2005-20261119    clang-24
riscv        randconfig-2005-20261120    clang-24
riscv        randconfig-2200-20261118    clang-24   smatch
riscv        randconfig-2200-20261119    clang-24   smatch
riscv       randconfig-r2100-20261118    clang-17   cocci
riscv       randconfig-r2100-20261119    clang-17   cocci
riscv       randconfig-r2101-20261119    clang-24   cocci
riscv       randconfig-r2103-20261119    clang-24   cocci
riscv       randconfig-r2105-20261118    clang-17   cocci
riscv       randconfig-r2106-20261119    gcc-12.5.0 cocci
riscv       randconfig-r2111-20261119    gcc-14     cocci
riscv       randconfig-r2301-20261118    gcc-9.5.0  sparse
riscv       randconfig-r2302-20261119    clang-24   sparse
riscv       randconfig-r2302-20261119    gcc-16.2.0 sparse
riscv       randconfig-r2304-20261118    gcc-9.5.0  sparse
riscv       randconfig-r2307-20261118    gcc-9.5.0  sparse
riscv       randconfig-r2309-20261119    gcc-14     sparse
s390         randconfig-2000-20261118    clang-24
s390         randconfig-2000-20261119    clang-20
s390         randconfig-2001-20261118    clang-24
s390         randconfig-2001-20261119    clang-20
s390         randconfig-2002-20261118    clang-24
s390         randconfig-2002-20261119    clang-20
s390         randconfig-2003-20261118    clang-24
s390         randconfig-2003-20261119    clang-20
s390         randconfig-2004-20261118    clang-24
s390         randconfig-2004-20261119    clang-20
s390         randconfig-2005-20261118    clang-24
s390         randconfig-2005-20261119    clang-20
s390         randconfig-2200-20261118    gcc-8.5.0  smatch
s390         randconfig-2200-20261119    clang-24   smatch
s390        randconfig-r2102-20261118    clang-17   cocci
s390        randconfig-r2103-20261118    clang-24   cocci
s390        randconfig-r2103-20261119    clang-19   cocci
s390        randconfig-r2103-20261119    gcc-9.5.0  cocci
s390        randconfig-r2108-20261118    gcc-11.5.0 cocci
s390        randconfig-r2110-20261119    gcc-12.5.0 cocci
s390        randconfig-r2111-20261119    clang-24   cocci
s390        randconfig-r2300-20261118    gcc-9.5.0  sparse
s390        randconfig-r2303-20261118    gcc-9.5.0  sparse
s390        randconfig-r2303-20261119    clang-24   sparse
s390        randconfig-r2304-20261119    clang-24   sparse
s390        randconfig-r2304-20261119    gcc-11.5.0 sparse
s390        randconfig-r2307-20261118    clang-20   sparse
s390        randconfig-r2308-20261119    clang-24   sparse
s390        randconfig-r2309-20261118    gcc-9.5.0  sparse
s390        randconfig-r2311-20261118    clang-24   sparse
s390        randconfig-r2311-20261118    gcc-9.5.0  sparse
sh           randconfig-2000-20261118    gcc-9.5.0
sh           randconfig-2000-20261119    gcc-12.5.0
sh           randconfig-2001-20261118    gcc-9.5.0
sh           randconfig-2001-20261119    gcc-12.5.0
sh           randconfig-2002-20261118    gcc-9.5.0
sh           randconfig-2002-20261119    gcc-12.5.0
sh           randconfig-2003-20261118    gcc-9.5.0
sh           randconfig-2003-20261119    gcc-12.5.0
sh           randconfig-2004-20261118    gcc-9.5.0
sh           randconfig-2004-20261119    gcc-12.5.0
sh           randconfig-2005-20261118    gcc-9.5.0
sh           randconfig-2005-20261119    gcc-12.5.0
sh           randconfig-2200-20261118    gcc-13.5.0 smatch
sh           randconfig-2200-20261119    gcc-16.2.0 smatch
sh          randconfig-r2104-20261119    gcc-14.4.0 cocci
sh          randconfig-r2106-20261118    gcc-14     cocci
sh          randconfig-r2107-20261118    gcc-11.5.0 cocci
sh          randconfig-r2108-20261119    gcc-12.5.0 cocci
sh          randconfig-r2301-20261118    gcc-9.5.0  sparse
sh          randconfig-r2302-20261119    gcc-13.5.0 sparse
sh          randconfig-r2306-20261118    gcc-9.5.0  sparse
sh          randconfig-r2309-20261118    clang-20   sparse
sh          randconfig-r2310-20261119    clang-24   sparse
sparc        randconfig-2000-20261118    clang-24
sparc        randconfig-2000-20261119    clang-21
sparc        randconfig-2001-20261118    clang-24
sparc        randconfig-2001-20261119    clang-21
sparc        randconfig-2200-20261118    gcc-13.5.0 smatch
sparc        randconfig-2200-20261119    gcc-8.5.0  smatch
sparc       randconfig-r2100-20261118    gcc-13.5.0 cocci
sparc       randconfig-r2100-20261119    clang-24   cocci
sparc       randconfig-r2101-20261118    gcc-13.5.0 cocci
sparc       randconfig-r2101-20261119    gcc-14.4.0 cocci
sparc       randconfig-r2105-20261119    clang-24   cocci
sparc       randconfig-r2301-20261119    clang-24   sparse
sparc       randconfig-r2304-20261119    gcc-8.5.0  sparse
sparc       randconfig-r2307-20261118    gcc-14     sparse
sparc       randconfig-r2308-20261119    gcc-11.5.0 sparse
sparc       randconfig-r2309-20261119    gcc-14.4.0 sparse
sparc       randconfig-r2311-20261118    gcc-14     sparse
sparc       randconfig-r2311-20261118    gcc-14.4.0 sparse
sparc64      randconfig-2000-20261118    clang-24
sparc64      randconfig-2000-20261119    clang-21
sparc64      randconfig-2001-20261118    clang-24
sparc64      randconfig-2001-20261119    clang-21
sparc64      randconfig-2200-20261118    clang-22   smatch
sparc64      randconfig-2200-20261119    gcc-13.5.0 smatch
sparc64     randconfig-r2107-20261119    gcc-10.5.0 cocci
sparc64     randconfig-r2109-20261119    clang-24   cocci
sparc64     randconfig-r2300-20261119    gcc-13.5.0 sparse
sparc64     randconfig-r2305-20261118    gcc-9.5.0  sparse
sparc64     randconfig-r2307-20261119    clang-24   sparse
sparc64     randconfig-r2308-20261118    clang-20   sparse
um           randconfig-2000-20261118    clang-24
um           randconfig-2000-20261119    clang-21
um           randconfig-2001-20261118    clang-24
um           randconfig-2001-20261119    clang-21
um           randconfig-2200-20261118    clang-24   smatch
um          randconfig-r2100-20261118    clang-24   cocci
um          randconfig-r2103-20261118    gcc-14     cocci
um          randconfig-r2109-20261118    gcc-8.5.0  cocci
um          randconfig-r2110-20261119    clang-24   cocci
um          randconfig-r2301-20261118    gcc-14.4.0 sparse
um          randconfig-r2301-20261119    gcc-8.5.0  sparse
um          randconfig-r2303-20261119    gcc-16.2.0 sparse
um          randconfig-r2306-20261119    gcc-8.5.0  sparse
um          randconfig-r2308-20261118    clang-24   sparse
um          randconfig-r2310-20261118    gcc-14.4.0 sparse
um          randconfig-r2311-20261119    gcc-14     sparse
x86_64                          kexec    clang-22
x86_64       randconfig-2000-20261118    gcc-13
x86_64       randconfig-2000-20261119    clang-22
x86_64       randconfig-2001-20261118    gcc-13
x86_64       randconfig-2001-20261119    clang-22
x86_64       randconfig-2002-20261118    gcc-13
x86_64       randconfig-2002-20261119    clang-22
x86_64       randconfig-2003-20261118    gcc-13
x86_64       randconfig-2003-20261119    clang-22
x86_64       randconfig-2004-20261118    gcc-13
x86_64       randconfig-2004-20261119    clang-22
x86_64       randconfig-2005-20261118    gcc-13
x86_64       randconfig-2005-20261119    clang-22
x86_64       randconfig-2100-20261118    clang-22   cocci
x86_64       randconfig-2100-20261119    clang-22   cocci
x86_64       randconfig-2101-20261118    clang-22   cocci
x86_64       randconfig-2101-20261119    clang-22   cocci
x86_64       randconfig-2102-20261118    clang-22   cocci
x86_64       randconfig-2102-20261119    clang-22   cocci
x86_64       randconfig-2103-20261118    clang-22   cocci
x86_64       randconfig-2103-20261119    clang-22   cocci
x86_64       randconfig-2104-20261118    clang-22   cocci
x86_64       randconfig-2104-20261119    clang-22   cocci
x86_64       randconfig-2105-20261118    clang-22   cocci
x86_64       randconfig-2105-20261119    clang-22   cocci
x86_64       randconfig-2200-20261118    clang-22   smatch
x86_64       randconfig-2200-20261119    clang-22   smatch
x86_64       randconfig-2300-20261118    gcc-14     sparse
x86_64       randconfig-2300-20261119    gcc-14     sparse
x86_64       randconfig-2301-20261118    gcc-14     sparse
x86_64       randconfig-2301-20261119    gcc-14     sparse
x86_64       randconfig-2302-20261118    gcc-14     sparse
x86_64       randconfig-2302-20261119    gcc-14     sparse
x86_64      randconfig-r2102-20261119    clang-24   cocci
x86_64      randconfig-r2105-20261119    gcc-11.5.0 cocci
x86_64      randconfig-r2108-20261119    gcc-12.5.0 cocci
x86_64      randconfig-r2109-20261118    gcc-14     cocci
x86_64      randconfig-r2109-20261119    gcc-12.5.0 cocci
x86_64      randconfig-r2300-20261118    gcc-14.4.0 sparse
x86_64      randconfig-r2303-20261118    clang-22   sparse
x86_64      randconfig-r2304-20261119    gcc-13.5.0 sparse
x86_64      randconfig-r2306-20261118    gcc-14     sparse
x86_64      randconfig-r2307-20261119    gcc-14     sparse
x86_64      randconfig-r2311-20261119    gcc-10.5.0 sparse
x86_64                       rhel-9.4    clang-22
x86_64                   rhel-9.4-bpf    clang-22
x86_64                  rhel-9.4-func    clang-22
x86_64            rhel-9.4-kselftests    clang-22
x86_64                 rhel-9.4-kunit    clang-22
x86_64                   rhel-9.4-ltp    clang-22
x86_64                  rhel-9.4-rust    clang-22
xtensa       randconfig-2000-20261118    gcc-16.2.0
xtensa       randconfig-2000-20261119    gcc-16.2.0
xtensa       randconfig-2001-20261118    gcc-16.2.0
xtensa       randconfig-2001-20261119    gcc-16.2.0
xtensa       randconfig-2200-20261118    gcc-15.3.0 smatch
xtensa       randconfig-2200-20261119    gcc-14.4.0 smatch
xtensa      randconfig-r2106-20261118    gcc-11.5.0 cocci
xtensa      randconfig-r2107-20261119    gcc-12.5.0 cocci
xtensa      randconfig-r2111-20261118    gcc-14     cocci
xtensa      randconfig-r2111-20261118    gcc-8.5.0  cocci
xtensa      randconfig-r2302-20261119    gcc-11.5.0 sparse
xtensa      randconfig-r2303-20261118    gcc-9.5.0  sparse
xtensa      randconfig-r2304-20261118    clang-22   sparse
xtensa      randconfig-r2310-20261119    gcc-10.5.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
