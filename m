Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422622;
	b=j1zdc+70csGQGmFgad79LikuKXj6nJSNSz8JRtUmAXBYUCLTVrQIF/XmYHltCp6KbSWc
	 ZPl7pw7l6UWaETVrDTIrcrA+f+YqlRoRlNrx8J0SZwo1iBJDtqbti7qalPEz/erUNnl82
	 77XWxc3UuqI+wP5hYQsR44qUyrIVV8tOYFaJR+2cp23WAAXEBL4IuAS3BWXnZl5odzg+6
	 dY8OWpyp4BowCyFXPWSZ8gqU427cRLOdSlzT0TFmW0V4XL7F1LdeyXkgQbCczfjESYjC3
	 myJ3RJtdPMvHxJ8sHAuv0pO8HUt2+y8JR4h5eXaXPkiUC036JCCEdyBMQ9xzxLtmISQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422622;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=KHiSZNh72IpjEHCaEQ1jG3lGEjX8HmsV/nM9wnhtGR0=;
	b=lLiqOLin0vPjTCPhpRvmU/6VPMpOf55jJBhZ6TRusRQ4MPFHwvMY/xTCCqkFYgwiX+Qg
	 9BhSjrMua+NN9a2RlTzn4TCkiEmihvAP9g6UDLHORxa1hNqeZz4BTZ/KJTmLNhaz657rt
	 jiSsI0hMism163evqppDh7l383I6oB1ZNyqNVvOrBxWk0papCQV/8wWdLt8upiGg043E6
	 OqErJTaGBxTgq8jr/yz9wqYbjYvz0UbCKUWe7mvKn+1wQ3UEtbxhhGWtmU2IHXsGQsTle
	 p9kR0XUxYN1/baIsyG/atI3BMy1nlpxMWTtD5D0+oPqykBZINVg5tSEG/4vtO9OgdIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="oF/k8KDA";
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1449606A324
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 18:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1449606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oF/k8KDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794422622; x=1825958622;
  h=date:from:to:cc:subject:message-id;
  bh=ZOax+LSJbnQH8TooSuL4KJD5vm328vjGShmocHq28OU=;
  b=oF/k8KDA/sejb2AKI/IfMzLejGfS42ojCkfEXy8Ut1r+jqXMFO7WpwpE
   cNLyUGimt3cVuOyhb7qEgOcFjxjKBFPPRlYTmMiXmYS92wYjdk3t5nSmS
   jZ5TaY0iyk+il0swhz8SrcUtkzpcuE9AViwS4zmQiGypRw3q0JhaJaOqk
   q1CVRgBdnp9vQmDudXt7IJicJ78IMnEC3/Hx1wFD/0cLgMG9YAWArHdFd
   3SU3PkqfM91Piw2uxHh1HAImXjQqMVttHwzyHzecyaF+4F6163JASwbPH
   ZTflvZsmMfK5TEvzYhXxthxVQaOAIzlTfy2LxVKP3OHWcUl0eWOKbBtSm
   w==;
X-CSE-ConnectionGUID: sS7NbeXzSaK6G1vQ6azizA==
X-CSE-MsgGUID: VUhoVbttQ7OhYDrqKcTGlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3205348"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3205348"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 10:43:41 -0800
X-CSE-ConnectionGUID: I4LZm7a0RfuyaDQdcq+jqw==
X-CSE-MsgGUID: vfqG9YIvT5qA7SWBuUDKYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8801811"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Nov 2026 10:43:40 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRDIH-00000000zUZ-0HDd;
	Wed, 11 Nov 2026 18:43:37 +0000
Date: Thu, 12 Nov 2026 02:43:04 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 bdc99db8dabb66b1054d8cc297ff63f528c00da3
Message-ID: <20261112024304.MQ6qPFBm-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: bdc99db8dabb66b1054d8cc297ff63f528c00da3  PCI: Reject negative resource alignment order

elapsed time: 1414m

configs tested: 650
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             alldefconfig    gcc-16.2.0
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261110    gcc-12.5.0
alpha                 randconfig-2000-20261111    gcc-8.5.0
alpha                 randconfig-2001-20261110    gcc-12.5.0
alpha                 randconfig-2001-20261111    gcc-8.5.0
alpha                 randconfig-2200-20261110    gcc-9.5.0  smatch
alpha                 randconfig-2200-20261111    gcc-12.5.0 smatch
alpha                randconfig-r2107-20261111    gcc-10.5.0 cocci
alpha                randconfig-r2111-20261111    gcc-9.5.0  cocci
alpha                randconfig-r2301-20261110    gcc-10.5.0 sparse
alpha                randconfig-r2303-20261111    gcc-8.5.0  sparse
alpha                randconfig-r2306-20261111    clang-17   sparse
alpha                randconfig-r2307-20261111    gcc-14     sparse
alpha                randconfig-r2307-20261111    gcc-8.5.0  sparse
arc                               alldefconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                       axs103_smp_defconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                             hsdk_defconfig    gcc-16.2.0
arc                         nsimosci_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261111    gcc-15.3.0
arc                   randconfig-1001-20261111    gcc-15.3.0
arc                   randconfig-2000-20261110    gcc-8.5.0
arc                   randconfig-2000-20261111    gcc-14.4.0
arc                   randconfig-2001-20261110    gcc-8.5.0
arc                   randconfig-2001-20261111    gcc-14.4.0
arc                   randconfig-2002-20261110    gcc-8.5.0
arc                   randconfig-2002-20261111    gcc-14.4.0
arc                   randconfig-2003-20261110    gcc-8.5.0
arc                   randconfig-2003-20261111    gcc-14.4.0
arc                   randconfig-2004-20261110    gcc-8.5.0
arc                   randconfig-2004-20261111    gcc-14.4.0
arc                   randconfig-2005-20261110    gcc-8.5.0
arc                   randconfig-2005-20261111    gcc-14.4.0
arc                   randconfig-2200-20261110    gcc-8.5.0  smatch
arc                   randconfig-2200-20261111    gcc-16.2.0 smatch
arc                  randconfig-r2104-20261111    gcc-13.5.0 cocci
arc                  randconfig-r2104-20261111    gcc-8.5.0  cocci
arc                  randconfig-r2110-20261111    gcc-10.5.0 cocci
arc                  randconfig-r2300-20261110    gcc-10.5.0 sparse
arc                  randconfig-r2300-20261111    gcc-8.5.0  sparse
arc                  randconfig-r2301-20261111    gcc-8.5.0  sparse
arc                  randconfig-r2306-20261111    clang-24   sparse
arc                  randconfig-r2307-20261110    clang-24   sparse
arc                  randconfig-r2308-20261111    gcc-11.5.0 sparse
arc                  randconfig-r2308-20261111    gcc-14     sparse
arc                  randconfig-r2311-20261110    clang-24   sparse
arc                  randconfig-r2311-20261111    clang-17   sparse
arc                            tb10x_defconfig    clang-19
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                      am200epdkit_defconfig    gcc-16.2.0
arm                          bcm2835_defconfig    gcc-16.2.0
arm                      davinci_all_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                             hisi_defconfig    gcc-16.2.0
arm                          lpc18xx_defconfig    gcc-16.2.0
arm                         mvebu_v5_defconfig    gcc-16.2.0
arm                         mvebu_v7_defconfig    clang-24
arm                        omap2plus_defconfig    gcc-16.2.0
arm                           pxa910_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261111    gcc-15.3.0
arm                   randconfig-1001-20261111    gcc-15.3.0
arm                   randconfig-1002-20261111    gcc-15.3.0
arm                   randconfig-1003-20261111    gcc-15.3.0
arm                   randconfig-2000-20261110    clang-24
arm                   randconfig-2000-20261111    gcc-16.2.0
arm                   randconfig-2001-20261110    clang-24
arm                   randconfig-2001-20261111    gcc-16.2.0
arm                   randconfig-2002-20261110    clang-24
arm                   randconfig-2002-20261111    gcc-16.2.0
arm                   randconfig-2200-20261110    gcc-11.5.0 smatch
arm                   randconfig-2200-20261111    gcc-8.5.0  smatch
arm                  randconfig-r2102-20261110    gcc-12.5.0 cocci
arm                  randconfig-r2103-20261111    gcc-8.5.0  cocci
arm                  randconfig-r2108-20261110    gcc-8.5.0  cocci
arm                  randconfig-r2304-20261110    gcc-10.5.0 sparse
arm                  randconfig-r2305-20261111    gcc-16.2.0 sparse
arm                         shmobile_defconfig    gcc-16.2.0
arm                          socfpga_defconfig    gcc-16.2.0
arm                         spear3xx_defconfig    gcc-16.2.0
arm                         spear6xx_defconfig    clang-19
arm                            sunxi_defconfig    clang-19
arm                        versatile_defconfig    clang-19
arm                         vexpress_defconfig    clang-19
arm                          vf610m4_defconfig    gcc-16.2.0
arm                     vt8500_v6_v7_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261111    gcc-13.5.0
arm64                 randconfig-1001-20261111    gcc-13.5.0
arm64                 randconfig-1002-20261111    gcc-13.5.0
arm64                 randconfig-1003-20261111    gcc-13.5.0
arm64                 randconfig-2000-20261110    clang-24
arm64                 randconfig-2000-20261111    gcc-16.2.0
arm64                 randconfig-2001-20261110    clang-24
arm64                 randconfig-2001-20261111    gcc-16.2.0
arm64                 randconfig-2002-20261110    clang-24
arm64                 randconfig-2002-20261111    gcc-16.2.0
arm64                 randconfig-2200-20261110    clang-24   smatch
arm64                 randconfig-2200-20261111    gcc-11.5.0 smatch
arm64                randconfig-r2102-20261110    clang-22   cocci
arm64                randconfig-r2106-20261111    gcc-9.5.0  cocci
arm64                randconfig-r2110-20261110    clang-19   cocci
arm64                randconfig-r2307-20261110    clang-24   sparse
arm64                randconfig-r2309-20261110    clang-24   sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261111    gcc-13.5.0
csky                  randconfig-1001-20261111    gcc-13.5.0
csky                  randconfig-2000-20261110    gcc-11.5.0
csky                  randconfig-2000-20261111    gcc-16.2.0
csky                  randconfig-2001-20261110    gcc-11.5.0
csky                  randconfig-2001-20261111    gcc-16.2.0
csky                  randconfig-2200-20261110    gcc-16.2.0 smatch
csky                  randconfig-2200-20261111    gcc-16.2.0 smatch
csky                 randconfig-r2100-20261111    gcc-8.5.0  cocci
csky                 randconfig-r2102-20261111    gcc-8.5.0  cocci
csky                 randconfig-r2103-20261110    clang-22   cocci
csky                 randconfig-r2108-20261110    clang-19   cocci
csky                 randconfig-r2110-20261111    gcc-11.5.0 cocci
csky                 randconfig-r2301-20261110    gcc-8.5.0  sparse
csky                 randconfig-r2311-20261111    gcc-8.5.0  sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261111    clang-17
hexagon               randconfig-1001-20261111    clang-17
hexagon               randconfig-2000-20261110    gcc-11.5.0
hexagon               randconfig-2000-20261111    gcc-16.2.0
hexagon               randconfig-2001-20261110    gcc-11.5.0
hexagon               randconfig-2001-20261111    gcc-16.2.0
hexagon               randconfig-2200-20261110    clang-24   smatch
hexagon               randconfig-2200-20261111    clang-24   smatch
hexagon              randconfig-r2111-20261111    gcc-12.5.0 cocci
hexagon              randconfig-r2308-20261110    clang-24   sparse
hexagon              randconfig-r2308-20261111    clang-24   sparse
hexagon              randconfig-r2309-20261110    gcc-15.3.0 sparse
hexagon              randconfig-r2311-20261111    gcc-11.5.0 sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261111    clang-22
i386        buildonly-randconfig-1001-20261111    clang-22
i386        buildonly-randconfig-1002-20261111    clang-22
i386        buildonly-randconfig-1003-20261111    clang-22
i386        buildonly-randconfig-1004-20261111    clang-22
i386        buildonly-randconfig-1005-20261111    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261111    gcc-13
i386                  randconfig-1001-20261111    gcc-13
i386                  randconfig-1002-20261111    gcc-13
i386                  randconfig-1003-20261111    gcc-13
i386                  randconfig-1004-20261111    gcc-13
i386                  randconfig-1005-20261111    gcc-13
i386                  randconfig-1006-20261111    gcc-13
i386                  randconfig-1007-20261111    clang-22
i386                  randconfig-1008-20261111    clang-22
i386                  randconfig-1009-20261111    clang-22
i386                  randconfig-1010-20261111    clang-22
i386                  randconfig-1011-20261111    clang-22
i386                  randconfig-1012-20261111    clang-22
i386                  randconfig-1013-20261111    clang-22
i386                  randconfig-2000-20261110    clang-22
i386                  randconfig-2000-20261111    gcc-14
i386                  randconfig-2001-20261110    clang-22
i386                  randconfig-2001-20261111    gcc-14
i386                  randconfig-2002-20261110    clang-22
i386                  randconfig-2002-20261111    gcc-14
i386                  randconfig-2003-20261110    clang-22
i386                  randconfig-2003-20261111    gcc-14
i386                  randconfig-2004-20261110    clang-22
i386                  randconfig-2004-20261111    gcc-14
i386                  randconfig-2005-20261110    clang-22
i386                  randconfig-2005-20261111    gcc-14
i386                  randconfig-2100-20261110    gcc-14     cocci
i386                  randconfig-2100-20261111    gcc-14     cocci
i386                  randconfig-2101-20261110    gcc-14     cocci
i386                  randconfig-2101-20261111    gcc-14     cocci
i386                  randconfig-2102-20261110    gcc-14     cocci
i386                  randconfig-2102-20261111    gcc-14     cocci
i386                  randconfig-2103-20261110    gcc-14     cocci
i386                  randconfig-2103-20261111    gcc-14     cocci
i386                  randconfig-2104-20261110    gcc-14     cocci
i386                  randconfig-2104-20261111    gcc-14     cocci
i386                  randconfig-2105-20261110    gcc-14     cocci
i386                  randconfig-2105-20261111    gcc-14     cocci
i386                  randconfig-2200-20261110    gcc-13     smatch
i386                  randconfig-2200-20261111    gcc-14     smatch
i386                  randconfig-2300-20261110    clang-22   sparse
i386                  randconfig-2300-20261111    gcc-14     sparse
i386                  randconfig-2301-20261110    clang-22   sparse
i386                  randconfig-2301-20261111    gcc-14     sparse
i386                  randconfig-2302-20261110    clang-22   sparse
i386                  randconfig-2302-20261111    gcc-14     sparse
i386                 randconfig-r2100-20261110    clang-22   cocci
i386                 randconfig-r2104-20261111    gcc-8.5.0  cocci
i386                 randconfig-r2106-20261111    gcc-8.5.0  cocci
i386                 randconfig-r2307-20261111    clang-24   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261111    clang-17
loongarch             randconfig-1001-20261111    clang-17
loongarch             randconfig-2000-20261110    gcc-11.5.0
loongarch             randconfig-2000-20261111    gcc-11.5.0
loongarch             randconfig-2001-20261110    gcc-11.5.0
loongarch             randconfig-2001-20261111    gcc-11.5.0
loongarch             randconfig-2200-20261110    clang-24   smatch
loongarch             randconfig-2200-20261111    gcc-16.2.0 smatch
loongarch            randconfig-r2102-20261111    gcc-13.5.0 cocci
loongarch            randconfig-r2103-20261110    gcc-12.5.0 cocci
loongarch            randconfig-r2103-20261111    gcc-8.5.0  cocci
loongarch            randconfig-r2105-20261111    gcc-13.5.0 cocci
loongarch            randconfig-r2107-20261110    clang-19   cocci
loongarch            randconfig-r2109-20261111    gcc-9.5.0  cocci
loongarch            randconfig-r2303-20261110    gcc-8.5.0  sparse
loongarch            randconfig-r2308-20261111    gcc-8.5.0  sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                          amcore_defconfig    gcc-16.2.0
m68k                           atari_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                           multi_defconfig    gcc-16.2.0
m68k                  randconfig-2000-20261110    gcc-12.5.0
m68k                  randconfig-2000-20261111    gcc-8.5.0
m68k                  randconfig-2001-20261110    gcc-12.5.0
m68k                  randconfig-2001-20261111    gcc-8.5.0
m68k                  randconfig-2200-20261110    gcc-16.2.0 smatch
m68k                  randconfig-2200-20261111    gcc-9.5.0  smatch
m68k                 randconfig-r2102-20261111    gcc-8.5.0  cocci
m68k                 randconfig-r2105-20261111    gcc-8.5.0  cocci
m68k                 randconfig-r2107-20261111    gcc-9.5.0  cocci
m68k                 randconfig-r2108-20261111    gcc-11.5.0 cocci
m68k                 randconfig-r2111-20261110    clang-19   cocci
m68k                 randconfig-r2111-20261111    gcc-8.5.0  cocci
m68k                 randconfig-r2300-20261110    gcc-8.5.0  sparse
m68k                 randconfig-r2301-20261111    clang-24   sparse
m68k                 randconfig-r2304-20261111    clang-24   sparse
m68k                 randconfig-r2311-20261110    clang-24   sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261111    gcc-8.5.0
microblaze            randconfig-2001-20261110    gcc-12.5.0
microblaze            randconfig-2001-20261111    gcc-8.5.0
microblaze            randconfig-2200-20261110    gcc-8.5.0  smatch
microblaze            randconfig-2200-20261111    gcc-8.5.0  smatch
microblaze           randconfig-r2107-20261110    gcc-8.5.0  cocci
microblaze           randconfig-r2111-20261111    gcc-10.5.0 cocci
microblaze           randconfig-r2302-20261111    gcc-8.5.0  sparse
microblaze           randconfig-r2307-20261110    gcc-15.3.0 sparse
microblaze           randconfig-r2308-20261111    gcc-16.2.0 sparse
microblaze           randconfig-r2309-20261111    gcc-16.2.0 sparse
microblaze           randconfig-r2310-20261110    clang-24   sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                           ath79_defconfig    gcc-16.2.0
mips                        bmips_be_defconfig    gcc-16.2.0
mips                 econet_en751221_defconfig    gcc-16.2.0
mips                           eyeq6_defconfig    clang-24
mips                             gpr_defconfig    clang-24
mips                        lemote2f_defconfig    clang-24
mips                       malta_kvm_defconfig    clang-19
mips                            mtx1_defconfig    clang-24
mips                         omega2p_defconfig    gcc-16.2.0
mips                         qi_lb60_defconfig    gcc-16.2.0
mips                  randconfig-2000-20261110    gcc-16.2.0
mips                  randconfig-2000-20261111    gcc-10.5.0
mips                  randconfig-2001-20261110    gcc-16.2.0
mips                  randconfig-2001-20261111    gcc-10.5.0
mips                  randconfig-2002-20261110    gcc-16.2.0
mips                  randconfig-2002-20261111    gcc-10.5.0
mips                  randconfig-2200-20261110    clang-17   smatch
mips                  randconfig-2200-20261111    clang-19   smatch
mips                 randconfig-r2104-20261110    gcc-12.5.0 cocci
mips                 randconfig-r2109-20261111    gcc-10.5.0 cocci
mips                 randconfig-r2109-20261111    gcc-11.5.0 cocci
mips                 randconfig-r2110-20261110    gcc-8.5.0  cocci
mips                 randconfig-r2300-20261110    gcc-16.2.0 sparse
mips                 randconfig-r2300-20261111    gcc-8.5.0  sparse
mips                 randconfig-r2303-20261111    clang-24   sparse
mips                 randconfig-r2305-20261110    gcc-8.5.0  sparse
mips                 randconfig-r2310-20261111    gcc-11.5.0 sparse
mips                 randconfig-r2310-20261111    gcc-8.5.0  sparse
mips                            xway_defconfig    clang-19
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261111    clang-17
nios2                 randconfig-1001-20261111    clang-17
nios2                 randconfig-2000-20261110    gcc-11.5.0
nios2                 randconfig-2000-20261111    gcc-11.5.0
nios2                 randconfig-2001-20261110    gcc-11.5.0
nios2                 randconfig-2001-20261111    gcc-11.5.0
nios2                 randconfig-2200-20261110    gcc-11.5.0 smatch
nios2                 randconfig-2200-20261111    gcc-8.5.0  smatch
nios2                randconfig-r2101-20261110    gcc-12.5.0 cocci
nios2                randconfig-r2101-20261111    gcc-8.5.0  cocci
nios2                randconfig-r2104-20261111    gcc-10.5.0 cocci
nios2                randconfig-r2105-20261111    gcc-8.5.0  cocci
openrisc                          alldefconfig    gcc-16.2.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc                     or1ksim_defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261110    gcc-16.2.0
openrisc              randconfig-2000-20261111    gcc-10.5.0
openrisc              randconfig-2001-20261110    gcc-16.2.0
openrisc              randconfig-2001-20261111    gcc-10.5.0
openrisc              randconfig-2002-20261110    gcc-16.2.0
openrisc              randconfig-2002-20261111    gcc-10.5.0
openrisc              randconfig-2200-20261110    gcc-9.5.0  smatch
openrisc              randconfig-2200-20261111    gcc-16.2.0 smatch
openrisc             randconfig-r2105-20261111    gcc-8.5.0  cocci
openrisc             randconfig-r2106-20261111    gcc-10.5.0 cocci
openrisc             randconfig-r2111-20261110    gcc-8.5.0  cocci
openrisc             randconfig-r2302-20261110    gcc-16.2.0 sparse
openrisc             randconfig-r2302-20261111    gcc-16.2.0 sparse
openrisc             randconfig-r2305-20261110    gcc-10.5.0 sparse
openrisc             randconfig-r2306-20261111    gcc-16.2.0 sparse
openrisc             randconfig-r2309-20261111    clang-24   sparse
openrisc             randconfig-r2311-20261111    gcc-14     sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261111    gcc-15.3.0
parisc                randconfig-1001-20261111    gcc-15.3.0
parisc                randconfig-2000-20261110    gcc-11.5.0
parisc                randconfig-2000-20261111    gcc-11.5.0
parisc                randconfig-2001-20261110    gcc-11.5.0
parisc                randconfig-2001-20261111    gcc-11.5.0
parisc                randconfig-2200-20261110    gcc-15.3.0 smatch
parisc                randconfig-2200-20261111    gcc-14.4.0 smatch
parisc               randconfig-r2100-20261111    gcc-13.5.0 cocci
parisc               randconfig-r2101-20261111    gcc-8.5.0  cocci
parisc               randconfig-r2105-20261111    gcc-10.5.0 cocci
parisc               randconfig-r2108-20261111    gcc-12.5.0 cocci
parisc               randconfig-r2303-20261111    gcc-16.2.0 sparse
parisc               randconfig-r2305-20261111    gcc-8.5.0  sparse
parisc               randconfig-r2311-20261111    clang-24   sparse
parisc64                          alldefconfig    clang-24
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                        eiger_defconfig    gcc-16.2.0
powerpc                         icon_defconfig    clang-19
powerpc                       pcm030_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261111    gcc-15.3.0
powerpc               randconfig-1001-20261111    gcc-15.3.0
powerpc               randconfig-2000-20261110    gcc-10.5.0
powerpc               randconfig-2000-20261111    gcc-11.5.0
powerpc               randconfig-2001-20261110    gcc-10.5.0
powerpc               randconfig-2001-20261111    gcc-11.5.0
powerpc               randconfig-2002-20261110    gcc-10.5.0
powerpc               randconfig-2002-20261111    gcc-11.5.0
powerpc               randconfig-2200-20261110    clang-24   smatch
powerpc               randconfig-2200-20261111    gcc-13.5.0 smatch
powerpc              randconfig-r2103-20261111    gcc-10.5.0 cocci
powerpc              randconfig-r2109-20261110    gcc-8.5.0  cocci
powerpc              randconfig-r2303-20261110    gcc-16.2.0 sparse
powerpc              randconfig-r2305-20261110    gcc-16.2.0 sparse
powerpc              randconfig-r2306-20261110    clang-24   sparse
powerpc              randconfig-r2307-20261111    gcc-11.5.0 sparse
powerpc                      stx_gp3_defconfig    gcc-16.2.0
powerpc                       tqm8xx_defconfig    gcc-16.2.0
powerpc                          wii_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261111    gcc-15.3.0
powerpc64             randconfig-1001-20261111    gcc-15.3.0
powerpc64             randconfig-2000-20261110    gcc-10.5.0
powerpc64             randconfig-2000-20261111    gcc-11.5.0
powerpc64             randconfig-2001-20261110    gcc-10.5.0
powerpc64             randconfig-2001-20261111    gcc-11.5.0
powerpc64             randconfig-2002-20261110    gcc-10.5.0
powerpc64             randconfig-2002-20261111    gcc-11.5.0
powerpc64             randconfig-2200-20261110    clang-24   smatch
powerpc64             randconfig-2200-20261111    gcc-11.5.0 smatch
powerpc64            randconfig-r2101-20261111    gcc-10.5.0 cocci
powerpc64            randconfig-r2103-20261111    gcc-8.5.0  cocci
powerpc64            randconfig-r2106-20261111    gcc-11.5.0 cocci
powerpc64            randconfig-r2109-20261111    gcc-8.5.0  cocci
powerpc64            randconfig-r2111-20261111    gcc-11.5.0 cocci
powerpc64            randconfig-r2300-20261111    gcc-16.2.0 sparse
powerpc64            randconfig-r2302-20261111    clang-24   sparse
powerpc64            randconfig-r2308-20261110    gcc-15.3.0 sparse
powerpc64            randconfig-r2310-20261110    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261111    clang-17
riscv                 randconfig-1001-20261111    clang-17
riscv                 randconfig-2000-20261110    gcc-12.5.0
riscv                 randconfig-2000-20261111    clang-21
riscv                 randconfig-2001-20261110    gcc-12.5.0
riscv                 randconfig-2001-20261111    clang-21
riscv                 randconfig-2002-20261110    gcc-12.5.0
riscv                 randconfig-2002-20261111    clang-21
riscv                 randconfig-2003-20261110    gcc-12.5.0
riscv                 randconfig-2003-20261111    clang-21
riscv                 randconfig-2004-20261110    gcc-12.5.0
riscv                 randconfig-2004-20261111    clang-21
riscv                 randconfig-2005-20261110    gcc-12.5.0
riscv                 randconfig-2005-20261111    clang-21
riscv                 randconfig-2200-20261110    gcc-8.5.0  smatch
riscv                randconfig-r2106-20261110    gcc-8.5.0  cocci
riscv                randconfig-r2107-20261111    gcc-12.5.0 cocci
riscv                randconfig-r2108-20261111    gcc-8.5.0  cocci
riscv                randconfig-r2110-20261111    gcc-8.5.0  cocci
riscv                randconfig-r2304-20261110    gcc-8.5.0  sparse
riscv                randconfig-r2304-20261111    gcc-16.2.0 sparse
riscv                randconfig-r2304-20261111    gcc-8.5.0  sparse
riscv                randconfig-r2305-20261111    clang-24   sparse
riscv                randconfig-r2306-20261111    gcc-11.5.0 sparse
riscv                randconfig-r2310-20261111    clang-17   sparse
riscv                randconfig-r2311-20261110    gcc-15.3.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261111    clang-17
s390                  randconfig-1001-20261111    clang-17
s390                  randconfig-2000-20261110    clang-20
s390                  randconfig-2000-20261111    gcc-8.5.0
s390                  randconfig-2001-20261110    clang-20
s390                  randconfig-2001-20261111    gcc-8.5.0
s390                  randconfig-2002-20261110    clang-20
s390                  randconfig-2002-20261111    gcc-8.5.0
s390                  randconfig-2003-20261110    clang-20
s390                  randconfig-2003-20261111    gcc-8.5.0
s390                  randconfig-2004-20261110    clang-20
s390                  randconfig-2004-20261111    gcc-8.5.0
s390                  randconfig-2005-20261110    clang-20
s390                  randconfig-2005-20261111    gcc-8.5.0
s390                  randconfig-2200-20261110    clang-18   smatch
s390                 randconfig-r2104-20261110    clang-22   cocci
s390                 randconfig-r2104-20261111    gcc-8.5.0  cocci
s390                 randconfig-r2106-20261110    clang-19   cocci
s390                 randconfig-r2110-20261111    gcc-12.5.0 cocci
s390                 randconfig-r2305-20261111    gcc-8.5.0  sparse
s390                 randconfig-r2309-20261111    gcc-8.5.0  sparse
s390                 randconfig-r2310-20261111    clang-24   sparse
s390                        zfcpdump_defconfig    gcc-16.2.0
sh                                alldefconfig    gcc-16.2.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.2.0
sh                                   defconfig    gcc-14
sh                 ecovec24-romimage_defconfig    gcc-16.2.0
sh                  kfr2r09-romimage_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261111    clang-17
sh                    randconfig-1001-20261111    clang-17
sh                    randconfig-2000-20261110    gcc-9.5.0
sh                    randconfig-2000-20261111    gcc-16.2.0
sh                    randconfig-2001-20261110    gcc-9.5.0
sh                    randconfig-2001-20261111    gcc-16.2.0
sh                    randconfig-2002-20261110    gcc-9.5.0
sh                    randconfig-2002-20261111    gcc-16.2.0
sh                    randconfig-2003-20261110    gcc-9.5.0
sh                    randconfig-2003-20261111    gcc-16.2.0
sh                    randconfig-2004-20261110    gcc-9.5.0
sh                    randconfig-2004-20261111    gcc-16.2.0
sh                    randconfig-2005-20261110    gcc-9.5.0
sh                    randconfig-2005-20261111    gcc-16.2.0
sh                    randconfig-2200-20261110    gcc-16.2.0 smatch
sh                    randconfig-2200-20261111    gcc-16.2.0 smatch
sh                   randconfig-r2103-20261111    gcc-13.5.0 cocci
sh                   randconfig-r2105-20261110    gcc-12.5.0 cocci
sh                   randconfig-r2108-20261111    gcc-9.5.0  cocci
sh                   randconfig-r2301-20261111    gcc-8.5.0  sparse
sh                   randconfig-r2302-20261110    gcc-10.5.0 sparse
sh                   randconfig-r2304-20261111    gcc-8.5.0  sparse
sh                   randconfig-r2309-20261111    clang-17   sparse
sh                   randconfig-r2310-20261111    gcc-14     sparse
sh                            se7780_defconfig    gcc-16.2.0
sh                              sh03_defconfig    gcc-16.2.0
sh                            sh2007_defconfig    gcc-16.2.0
sh                         sh7763rdp_defconfig    gcc-16.2.0
sh                         sh7785lcr_defconfig    gcc-16.2.0
sh                             shmin_defconfig    gcc-16.2.0
sh                               ul2_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261111    gcc-16.2.0
sparc                 randconfig-1001-20261111    gcc-16.2.0
sparc                 randconfig-2000-20261110    gcc-14
sparc                 randconfig-2000-20261111    clang-18
sparc                 randconfig-2001-20261110    gcc-14
sparc                 randconfig-2001-20261111    clang-18
sparc                 randconfig-2200-20261110    gcc-13.5.0 smatch
sparc                 randconfig-2200-20261111    gcc-12.5.0 smatch
sparc                randconfig-r2101-20261110    clang-22   cocci
sparc                randconfig-r2101-20261111    gcc-13.5.0 cocci
sparc                randconfig-r2107-20261111    gcc-8.5.0  cocci
sparc                randconfig-r2109-20261110    clang-19   cocci
sparc                randconfig-r2109-20261111    gcc-12.5.0 cocci
sparc                randconfig-r2306-20261110    gcc-15.3.0 sparse
sparc                randconfig-r2310-20261111    gcc-16.2.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261111    gcc-16.2.0
sparc64               randconfig-1001-20261111    gcc-16.2.0
sparc64               randconfig-2000-20261110    gcc-14
sparc64               randconfig-2000-20261111    clang-18
sparc64               randconfig-2001-20261110    gcc-14
sparc64               randconfig-2001-20261111    clang-18
sparc64               randconfig-2200-20261110    clang-24   smatch
sparc64               randconfig-2200-20261111    gcc-9.5.0  smatch
sparc64              randconfig-r2100-20261111    gcc-10.5.0 cocci
sparc64              randconfig-r2100-20261111    gcc-8.5.0  cocci
sparc64              randconfig-r2101-20261111    gcc-8.5.0  cocci
sparc64              randconfig-r2110-20261111    gcc-9.5.0  cocci
sparc64              randconfig-r2303-20261110    gcc-10.5.0 sparse
sparc64              randconfig-r2309-20261111    gcc-11.5.0 sparse
sparc64              randconfig-r2310-20261110    gcc-15.3.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261111    gcc-16.2.0
um                    randconfig-1001-20261111    gcc-16.2.0
um                    randconfig-2000-20261110    gcc-14
um                    randconfig-2000-20261111    clang-18
um                    randconfig-2001-20261110    gcc-14
um                    randconfig-2001-20261111    clang-18
um                    randconfig-2200-20261110    gcc-14     smatch
um                    randconfig-2200-20261111    clang-24   smatch
um                   randconfig-r2102-20261111    gcc-8.5.0  cocci
um                   randconfig-r2105-20261110    clang-22   cocci
um                   randconfig-r2106-20261111    gcc-12.5.0 cocci
um                   randconfig-r2107-20261111    gcc-11.5.0 cocci
um                   randconfig-r2301-20261111    gcc-16.2.0 sparse
um                   randconfig-r2302-20261111    gcc-8.5.0  sparse
um                   randconfig-r2306-20261111    gcc-8.5.0  sparse
um                   randconfig-r2307-20261111    gcc-16.2.0 sparse
um                   randconfig-r2309-20261110    clang-24   sparse
um                            x86_64_defconfig    gcc-14
um                            x86_64_defconfig    gcc-16.2.0
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261111    gcc-14
x86_64      buildonly-randconfig-1001-20261111    gcc-14
x86_64      buildonly-randconfig-1002-20261111    gcc-14
x86_64      buildonly-randconfig-1003-20261111    gcc-14
x86_64      buildonly-randconfig-1004-20261111    gcc-14
x86_64      buildonly-randconfig-1005-20261111    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261111    clang-22
x86_64                randconfig-1001-20261111    clang-22
x86_64                randconfig-1002-20261111    clang-22
x86_64                randconfig-1003-20261111    clang-22
x86_64                randconfig-1004-20261111    clang-22
x86_64                randconfig-1005-20261111    clang-22
x86_64                randconfig-1006-20261111    clang-22
x86_64                randconfig-1007-20261111    clang-22
x86_64                randconfig-1008-20261111    clang-22
x86_64                randconfig-1009-20261111    clang-22
x86_64                randconfig-1010-20261111    clang-22
x86_64                randconfig-1011-20261111    clang-22
x86_64                randconfig-1012-20261111    gcc-14
x86_64                randconfig-1013-20261111    gcc-14
x86_64                randconfig-1014-20261111    gcc-14
x86_64                randconfig-1015-20261111    gcc-14
x86_64                randconfig-1016-20261111    gcc-14
x86_64                randconfig-1017-20261111    gcc-14
x86_64                randconfig-2000-20261110    clang-22
x86_64                randconfig-2000-20261111    clang-22
x86_64                randconfig-2001-20261110    clang-22
x86_64                randconfig-2001-20261111    clang-22
x86_64                randconfig-2002-20261110    clang-22
x86_64                randconfig-2002-20261111    clang-22
x86_64                randconfig-2003-20261110    clang-22
x86_64                randconfig-2003-20261111    clang-22
x86_64                randconfig-2004-20261110    clang-22
x86_64                randconfig-2004-20261111    clang-22
x86_64                randconfig-2005-20261110    clang-22
x86_64                randconfig-2005-20261111    clang-22
x86_64                randconfig-2100-20261110    clang-22   cocci
x86_64                randconfig-2100-20261111    clang-22   cocci
x86_64                randconfig-2101-20261110    clang-22   cocci
x86_64                randconfig-2101-20261111    clang-22   cocci
x86_64                randconfig-2102-20261110    clang-22   cocci
x86_64                randconfig-2102-20261111    clang-22   cocci
x86_64                randconfig-2103-20261110    clang-22   cocci
x86_64                randconfig-2103-20261111    clang-22   cocci
x86_64                randconfig-2104-20261110    clang-22   cocci
x86_64                randconfig-2104-20261111    clang-22   cocci
x86_64                randconfig-2105-20261110    clang-22   cocci
x86_64                randconfig-2105-20261111    clang-22   cocci
x86_64                randconfig-2200-20261110    gcc-14     smatch
x86_64                randconfig-2200-20261111    gcc-14     smatch
x86_64                randconfig-2300-20261110    clang-22   sparse
x86_64                randconfig-2300-20261111    gcc-14     sparse
x86_64                randconfig-2301-20261110    clang-22   sparse
x86_64                randconfig-2301-20261111    gcc-14     sparse
x86_64                randconfig-2302-20261110    clang-22   sparse
x86_64                randconfig-2302-20261111    gcc-14     sparse
x86_64               randconfig-r2102-20261111    gcc-10.5.0 cocci
x86_64               randconfig-r2108-20261111    gcc-10.5.0 cocci
x86_64               randconfig-r2303-20261111    gcc-8.5.0  sparse
x86_64               randconfig-r2306-20261111    gcc-14     sparse
x86_64               randconfig-r2311-20261111    gcc-16.2.0 sparse
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
xtensa                randconfig-1000-20261111    gcc-16.2.0
xtensa                randconfig-1001-20261111    gcc-16.2.0
xtensa                randconfig-2000-20261110    gcc-11.5.0
xtensa                randconfig-2000-20261111    gcc-16.2.0
xtensa                randconfig-2001-20261110    gcc-11.5.0
xtensa                randconfig-2001-20261111    gcc-16.2.0
xtensa                randconfig-2200-20261110    gcc-11.5.0 smatch
xtensa                randconfig-2200-20261111    gcc-8.5.0  smatch
xtensa               randconfig-r2100-20261110    gcc-12.5.0 cocci
xtensa               randconfig-r2100-20261111    gcc-8.5.0  cocci
xtensa               randconfig-r2300-20261111    clang-24   sparse
xtensa               randconfig-r2301-20261110    gcc-16.2.0 sparse
xtensa               randconfig-r2302-20261110    gcc-8.5.0  sparse
xtensa               randconfig-r2304-20261110    gcc-16.2.0 sparse
xtensa               randconfig-r2306-20261110    clang-24   sparse
xtensa               randconfig-r2307-20261111    clang-17   sparse
xtensa               randconfig-r2308-20261111    clang-17   sparse
xtensa               randconfig-r2309-20261111    gcc-14     sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
