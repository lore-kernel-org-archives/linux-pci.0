Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958296;
	b=HEw8CmVQy6I2IukPqbenluT5M9w7oicD+Dv4u8uirJmys4BmB+e9qMEtNG6arVvfsU+r
	 BH7DPoG0VZ5pm0N1OBQTqT5AYOwDz2Whfqcj6jtn/aRaDi56wSyUzYVyThaD+lphk5VcH
	 OyQp7M6KYrlWQmPImutxO2ZedZTVggjJBDrHvlZcjfnpGZYgIGRCR8noOaTx0dKrrOtCX
	 lUg9NIvcEhR0KdWo0moZT8k2ANd76og7wgqssHTwYe9A68AuEoofpydzE0v5BRzOzoFrz
	 jBif4tQC2dSyI/Ux7HPDOWT0nBKRM1L3Et8kq/GLecHlk1FhsCGw+pDjshg0SeaMgkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958296;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=JEtlrF1Lx1MKt5mCDaoSiDi7Te90sBhnFmC8iigHiQk=;
	b=0DTq5V9KlrNFJOGqlVp/xlukPad6ScD6khlS3zm4jKiQ8UBmTIugxXQZp0P9W8ThFUaQ
	 CxvzMgvL5ak6roGGUn5z07sBlSBCOgLJ9nLv85r7UhIY3DrwEarnXSzWa5tCgsMuhPcfE
	 bn/QXMGu6q1EtCw5nEF9S1DFCvI+5gOq0WFCdNA+k8r/x/xxQQXAlfV4PV8XsgpsXuZeN
	 Hi1I5Qrr1mEHJ7Qlmdb30/gTssSSKnECwHMeVuxKVBl3UN34qAFIKm44wZAm/9+8oPL/c
	 mtHuvN1dfcSkKm823vl0UHnfDeiKvWBysnWOjbGrN/Uc1AHGeIl5Noa5AkQ/L5UW7Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P0y5qwT8;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1664606A329
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 09:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1664606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P0y5qwT8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793958294; x=1825494294;
  h=date:from:to:cc:subject:message-id;
  bh=BMCJHIZhb42GycqRJ6LR05yMXG8veII97fS0uyYxOSo=;
  b=P0y5qwT8p8jIDQIP2IRuEXYkGuCt4w7PhPWBPPyJFUT3OJ1RKwcrwXxT
   ISE1QSEVIikE9JP/B4mTIloE2azbawv/U3pP/k13OASzi5d8dqW76KdIm
   Q6wR06efLetlhgH6PHfsl4G7bTePVpCT5UpjrV2x3SdSmW+etclEI8rom
   VosXlR8oQy/K4ojpvxjbt+EjJTOt/UaibNWelQFeU8Sskp9JvXXOc02f6
   KvZBBqzWksH7Fw2e05fGiRJkpRXpjf9N0HEcMZNIyZuDMRlqHcI0WxYRq
   A/MFQaivAmJzd+f8ZQO2Fug/lTVgY+ucfS+RO1qGsLU+JT/4IHFyAuXaS
   g==;
X-CSE-ConnectionGUID: Dg63UxAqTq+93313nzY/RA==
X-CSE-MsgGUID: 2Oj1wCLNRduPFttqpdpO1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2790930"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2790930"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 01:44:54 -0800
X-CSE-ConnectionGUID: eL8qdVN6REeM984Uj2qb2Q==
X-CSE-MsgGUID: au3eUIlPRUiS024ln+j5+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7288882"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 Nov 2026 01:44:51 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPGV7-00000000orI-0i5C;
	Fri, 06 Nov 2026 09:44:49 +0000
Date: Fri, 06 Nov 2026 17:43:46 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc-qcom] BUILD SUCCESS
 f75d2d64fff15f7ac2b773aa335ea905b611f4b8
Message-ID: <20261106174346.Bxts6bhj-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-qcom
branch HEAD: f75d2d64fff15f7ac2b773aa335ea905b611f4b8  PCI: qcom: Add Nord PCIe controller support

elapsed time: 2402m

configs tested: 836
configs skipped: 26

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261104    gcc-10.5.0
alpha                 randconfig-2000-20261105    gcc-15.3.0
alpha                 randconfig-2001-20261104    gcc-10.5.0
alpha                 randconfig-2001-20261105    gcc-15.3.0
alpha                 randconfig-2200-20261104    gcc-16.2.0 smatch
alpha                 randconfig-2200-20261105    gcc-9.5.0  smatch
alpha                randconfig-r2100-20261105    clang-20   cocci
alpha                randconfig-r2101-20261105    gcc-8.5.0  cocci
alpha                randconfig-r2103-20261105    gcc-14.4.0 cocci
alpha                randconfig-r2104-20261105    gcc-14.4.0 cocci
alpha                randconfig-r2106-20261105    gcc-11.5.0 cocci
alpha                randconfig-r2108-20261105    gcc-10.5.0 cocci
alpha                randconfig-r2302-20261105    clang-24   sparse
alpha                randconfig-r2304-20261104    gcc-9.5.0  sparse
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.2.0
arc                           axs103_defconfig    clang-19
arc                           axs103_defconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261105    gcc-14.4.0
arc                   randconfig-1000-20261106    gcc-8.5.0
arc                   randconfig-1001-20261105    gcc-14.4.0
arc                   randconfig-1001-20261106    gcc-8.5.0
arc                   randconfig-2000-20261104    gcc-10.5.0
arc                   randconfig-2000-20261105    gcc-8.5.0
arc                   randconfig-2001-20261104    gcc-10.5.0
arc                   randconfig-2001-20261105    gcc-8.5.0
arc                   randconfig-2002-20261104    gcc-10.5.0
arc                   randconfig-2002-20261105    gcc-8.5.0
arc                   randconfig-2003-20261104    gcc-10.5.0
arc                   randconfig-2003-20261105    gcc-8.5.0
arc                   randconfig-2004-20261104    gcc-10.5.0
arc                   randconfig-2004-20261105    gcc-8.5.0
arc                   randconfig-2005-20261104    gcc-10.5.0
arc                   randconfig-2005-20261105    gcc-8.5.0
arc                   randconfig-2200-20261104    gcc-8.5.0  smatch
arc                   randconfig-2200-20261105    gcc-8.5.0  smatch
arc                  randconfig-r2100-20261104    gcc-11.5.0 cocci
arc                  randconfig-r2100-20261105    gcc-10.5.0 cocci
arc                  randconfig-r2101-20261105    gcc-16.2.0 cocci
arc                  randconfig-r2104-20261105    gcc-16.2.0 cocci
arc                  randconfig-r2105-20261104    gcc-11.5.0 cocci
arc                  randconfig-r2106-20261105    clang-21   cocci
arc                  randconfig-r2106-20261105    gcc-8.5.0  cocci
arc                  randconfig-r2108-20261105    gcc-11.5.0 cocci
arc                  randconfig-r2111-20261105    gcc-10.5.0 cocci
arc                  randconfig-r2301-20261105    clang-24   sparse
arc                  randconfig-r2305-20261105    gcc-8.5.0  sparse
arc                  randconfig-r2309-20261104    clang-24   sparse
arc                  randconfig-r2309-20261105    clang-24   sparse
arc                         vdk_hs38_defconfig    clang-17
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                         clps711x_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                            imxrt_defconfig    gcc-16.2.0
arm                       integrator_defconfig    gcc-16.2.0
arm                          lpc32xx_defconfig    clang-17
arm                   randconfig-1000-20261105    gcc-14.4.0
arm                   randconfig-1000-20261106    gcc-8.5.0
arm                   randconfig-1001-20261105    gcc-14.4.0
arm                   randconfig-1001-20261106    gcc-8.5.0
arm                   randconfig-1002-20261105    gcc-14.4.0
arm                   randconfig-1002-20261106    gcc-8.5.0
arm                   randconfig-1003-20261105    gcc-14.4.0
arm                   randconfig-1003-20261106    gcc-8.5.0
arm                   randconfig-2000-20261104    gcc-11.5.0
arm                   randconfig-2000-20261105    clang-24
arm                   randconfig-2001-20261104    gcc-11.5.0
arm                   randconfig-2001-20261105    clang-24
arm                   randconfig-2002-20261104    gcc-11.5.0
arm                   randconfig-2002-20261105    clang-24
arm                   randconfig-2200-20261104    clang-20   smatch
arm                   randconfig-2200-20261105    gcc-15.3.0 smatch
arm                  randconfig-r2100-20261104    gcc-8.5.0  cocci
arm                  randconfig-r2101-20261104    clang-24   cocci
arm                  randconfig-r2106-20261104    clang-24   cocci
arm                  randconfig-r2107-20261104    clang-24   cocci
arm                  randconfig-r2107-20261105    gcc-10.5.0 cocci
arm                  randconfig-r2107-20261105    gcc-8.5.0  cocci
arm                  randconfig-r2108-20261105    gcc-16.2.0 cocci
arm                  randconfig-r2109-20261104    gcc-16.2.0 cocci
arm                  randconfig-r2110-20261104    clang-24   cocci
arm                  randconfig-r2110-20261105    gcc-8.5.0  cocci
arm                  randconfig-r2300-20261105    clang-24   sparse
arm                  randconfig-r2305-20261105    clang-24   sparse
arm                  randconfig-r2311-20261105    clang-24   sparse
arm                  randconfig-r2311-20261105    gcc-16.2.0 sparse
arm                          s3c6400_defconfig    gcc-16.2.0
arm                            sama5_defconfig    gcc-16.2.0
arm                        spear13xx_defconfig    gcc-16.2.0
arm                            sunxi_defconfig    clang-17
arm                            sunxi_defconfig    gcc-16.2.0
arm                            u8500_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261105    gcc-13.5.0
arm64                 randconfig-1000-20261106    clang-17
arm64                 randconfig-1001-20261105    gcc-13.5.0
arm64                 randconfig-1001-20261106    clang-17
arm64                 randconfig-1002-20261105    gcc-13.5.0
arm64                 randconfig-1002-20261106    clang-17
arm64                 randconfig-1003-20261105    gcc-13.5.0
arm64                 randconfig-1003-20261106    clang-17
arm64                 randconfig-2000-20261104    gcc-11.5.0
arm64                 randconfig-2000-20261105    clang-24
arm64                 randconfig-2001-20261104    gcc-11.5.0
arm64                 randconfig-2001-20261105    clang-24
arm64                 randconfig-2002-20261104    gcc-11.5.0
arm64                 randconfig-2002-20261105    clang-24
arm64                 randconfig-2200-20261104    gcc-15.3.0 smatch
arm64                 randconfig-2200-20261105    clang-20   smatch
arm64                randconfig-r2100-20261104    clang-24   cocci
arm64                randconfig-r2100-20261105    gcc-16.2.0 cocci
arm64                randconfig-r2102-20261105    gcc-16.2.0 cocci
arm64                randconfig-r2104-20261105    clang-20   cocci
arm64                randconfig-r2105-20261104    clang-24   cocci
arm64                randconfig-r2106-20261105    gcc-10.5.0 cocci
arm64                randconfig-r2110-20261104    gcc-16.2.0 cocci
arm64                randconfig-r2111-20261105    clang-24   cocci
arm64                randconfig-r2307-20261104    clang-24   sparse
arm64                randconfig-r2307-20261104    gcc-9.5.0  sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261105    gcc-13.5.0
csky                  randconfig-1000-20261106    clang-17
csky                  randconfig-1001-20261105    gcc-13.5.0
csky                  randconfig-1001-20261106    clang-17
csky                  randconfig-2000-20261104    clang-24
csky                  randconfig-2000-20261105    clang-24
csky                  randconfig-2001-20261104    clang-24
csky                  randconfig-2001-20261105    clang-24
csky                  randconfig-2200-20261104    gcc-16.2.0 smatch
csky                  randconfig-2200-20261105    gcc-9.5.0  smatch
csky                 randconfig-r2100-20261105    gcc-14.4.0 cocci
csky                 randconfig-r2101-20261105    gcc-10.5.0 cocci
csky                 randconfig-r2102-20261105    clang-24   cocci
csky                 randconfig-r2102-20261105    gcc-8.5.0  cocci
csky                 randconfig-r2103-20261105    gcc-16.2.0 cocci
csky                 randconfig-r2106-20261105    clang-24   cocci
csky                 randconfig-r2106-20261105    gcc-16.2.0 cocci
csky                 randconfig-r2108-20261105    gcc-16.2.0 cocci
csky                 randconfig-r2110-20261105    gcc-10.5.0 cocci
csky                 randconfig-r2111-20261104    clang-24   cocci
csky                 randconfig-r2111-20261105    gcc-16.2.0 cocci
csky                 randconfig-r2301-20261105    gcc-8.5.0  sparse
csky                 randconfig-r2302-20261104    gcc-9.5.0  sparse
csky                 randconfig-r2306-20261104    gcc-9.5.0  sparse
csky                 randconfig-r2306-20261105    gcc-16.2.0 sparse
csky                 randconfig-r2310-20261104    clang-24   sparse
csky                 randconfig-r2310-20261105    gcc-16.2.0 sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261105    clang-24
hexagon               randconfig-1000-20261106    gcc-14.4.0
hexagon               randconfig-1001-20261105    clang-24
hexagon               randconfig-1001-20261106    gcc-14.4.0
hexagon               randconfig-2000-20261104    clang-24
hexagon               randconfig-2000-20261105    clang-24
hexagon               randconfig-2001-20261104    clang-24
hexagon               randconfig-2001-20261105    clang-24
hexagon               randconfig-2200-20261104    clang-22   smatch
hexagon               randconfig-2200-20261105    clang-17   smatch
hexagon              randconfig-r2102-20261104    clang-24   cocci
hexagon              randconfig-r2102-20261105    gcc-14.4.0 cocci
hexagon              randconfig-r2103-20261104    clang-24   cocci
hexagon              randconfig-r2105-20261105    clang-24   cocci
hexagon              randconfig-r2107-20261104    clang-24   cocci
hexagon              randconfig-r2109-20261105    gcc-16.2.0 cocci
hexagon              randconfig-r2310-20261105    clang-24   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261105    gcc-14
i386        buildonly-randconfig-1000-20261106    clang-22
i386        buildonly-randconfig-1001-20261105    gcc-14
i386        buildonly-randconfig-1001-20261106    clang-22
i386        buildonly-randconfig-1002-20261105    gcc-14
i386        buildonly-randconfig-1002-20261106    clang-22
i386        buildonly-randconfig-1003-20261105    gcc-14
i386        buildonly-randconfig-1003-20261106    clang-22
i386        buildonly-randconfig-1004-20261105    gcc-14
i386        buildonly-randconfig-1004-20261106    clang-22
i386        buildonly-randconfig-1005-20261105    gcc-14
i386        buildonly-randconfig-1005-20261106    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261105    clang-22
i386                  randconfig-1000-20261106    gcc-14
i386                  randconfig-1001-20261105    clang-22
i386                  randconfig-1001-20261106    gcc-14
i386                  randconfig-1002-20261105    clang-22
i386                  randconfig-1002-20261106    gcc-14
i386                  randconfig-1003-20261105    clang-22
i386                  randconfig-1003-20261106    gcc-14
i386                  randconfig-1004-20261105    clang-22
i386                  randconfig-1004-20261106    gcc-14
i386                  randconfig-1005-20261105    clang-22
i386                  randconfig-1005-20261106    gcc-14
i386                  randconfig-1006-20261105    clang-22
i386                  randconfig-1006-20261106    gcc-14
i386                  randconfig-1007-20261105    clang-22
i386                  randconfig-1007-20261106    gcc-14
i386                  randconfig-1008-20261105    clang-22
i386                  randconfig-1008-20261106    gcc-14
i386                  randconfig-1009-20261105    clang-22
i386                  randconfig-1009-20261106    gcc-14
i386                  randconfig-1010-20261105    clang-22
i386                  randconfig-1010-20261106    gcc-14
i386                  randconfig-1011-20261105    clang-22
i386                  randconfig-1011-20261106    gcc-14
i386                  randconfig-1012-20261105    clang-22
i386                  randconfig-1012-20261106    gcc-14
i386                  randconfig-1013-20261105    clang-22
i386                  randconfig-1013-20261106    gcc-14
i386                  randconfig-2000-20261104    gcc-14
i386                  randconfig-2000-20261105    clang-22
i386                  randconfig-2001-20261104    gcc-14
i386                  randconfig-2001-20261105    clang-22
i386                  randconfig-2002-20261104    gcc-14
i386                  randconfig-2002-20261105    clang-22
i386                  randconfig-2003-20261104    gcc-14
i386                  randconfig-2003-20261105    clang-22
i386                  randconfig-2004-20261104    gcc-14
i386                  randconfig-2004-20261105    clang-22
i386                  randconfig-2005-20261104    gcc-14
i386                  randconfig-2005-20261105    clang-22
i386                  randconfig-2100-20261104    gcc-14     cocci
i386                  randconfig-2100-20261105    gcc-14     cocci
i386                  randconfig-2101-20261104    gcc-14     cocci
i386                  randconfig-2101-20261105    gcc-14     cocci
i386                  randconfig-2102-20261104    gcc-14     cocci
i386                  randconfig-2102-20261105    gcc-14     cocci
i386                  randconfig-2103-20261104    gcc-14     cocci
i386                  randconfig-2103-20261105    gcc-14     cocci
i386                  randconfig-2104-20261104    gcc-14     cocci
i386                  randconfig-2104-20261105    gcc-14     cocci
i386                  randconfig-2105-20261104    gcc-14     cocci
i386                  randconfig-2105-20261105    gcc-14     cocci
i386                  randconfig-2200-20261104    gcc-12     smatch
i386                  randconfig-2200-20261105    clang-22   smatch
i386                  randconfig-2300-20261104    gcc-14     sparse
i386                  randconfig-2300-20261105    clang-22   sparse
i386                  randconfig-2301-20261104    gcc-14     sparse
i386                  randconfig-2301-20261105    clang-22   sparse
i386                  randconfig-2302-20261104    gcc-14     sparse
i386                  randconfig-2302-20261105    clang-22   sparse
i386                 randconfig-r2102-20261105    clang-20   cocci
i386                 randconfig-r2102-20261105    gcc-10.5.0 cocci
i386                 randconfig-r2104-20261105    gcc-8.5.0  cocci
i386                 randconfig-r2107-20261105    gcc-11.5.0 cocci
i386                 randconfig-r2108-20261105    gcc-8.5.0  cocci
i386                 randconfig-r2111-20261105    clang-21   cocci
i386                 randconfig-r2302-20261104    gcc-14     sparse
i386                 randconfig-r2306-20261105    gcc-16.2.0 sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch                 loongson64_defconfig    gcc-16.2.0
loongarch             randconfig-1000-20261105    clang-24
loongarch             randconfig-1000-20261106    gcc-14.4.0
loongarch             randconfig-1001-20261105    clang-24
loongarch             randconfig-1001-20261106    gcc-14.4.0
loongarch             randconfig-2000-20261104    gcc-15.3.0
loongarch             randconfig-2000-20261104    gcc-15.3.0
loongarch             randconfig-2000-20261105    gcc-16.2.0
loongarch             randconfig-2001-20261104    gcc-15.3.0
loongarch             randconfig-2001-20261104    gcc-15.3.0
loongarch             randconfig-2001-20261105    gcc-16.2.0
loongarch             randconfig-2200-20261104    clang-24   smatch
loongarch             randconfig-2200-20261105    gcc-16.2.0 smatch
loongarch            randconfig-r2100-20261105    clang-24   cocci
loongarch            randconfig-r2102-20261104    gcc-11.5.0 cocci
loongarch            randconfig-r2104-20261105    gcc-14.4.0 cocci
loongarch            randconfig-r2106-20261104    clang-24   cocci
loongarch            randconfig-r2110-20261104    clang-24   cocci
loongarch            randconfig-r2111-20261105    gcc-8.5.0  cocci
loongarch            randconfig-r2306-20261105    clang-24   sparse
loongarch            randconfig-r2309-20261105    clang-24   sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                           atari_defconfig    clang-17
m68k                                 defconfig    clang-24
m68k                        m5208evb_defconfig    gcc-16.2.0
m68k                         m5307c3_defconfig    gcc-16.2.0
m68k                         m5407c3_defconfig    gcc-16.2.0
m68k                       m54418evb_defconfig    clang-19
m68k                       m54418evb_defconfig    clang-24
m68k                         mvme147_defconfig    clang-24
m68k                          nettel_defconfig    gcc-16.2.0
m68k                  randconfig-2000-20261104    gcc-10.5.0
m68k                  randconfig-2000-20261105    gcc-15.3.0
m68k                  randconfig-2001-20261104    gcc-10.5.0
m68k                  randconfig-2001-20261105    gcc-15.3.0
m68k                  randconfig-2200-20261104    gcc-13.5.0 smatch
m68k                  randconfig-2200-20261105    gcc-8.5.0  smatch
m68k                 randconfig-r2102-20261104    gcc-8.5.0  cocci
m68k                 randconfig-r2102-20261105    clang-24   cocci
m68k                 randconfig-r2107-20261105    gcc-8.5.0  cocci
m68k                 randconfig-r2301-20261105    clang-24   sparse
m68k                 randconfig-r2303-20261104    clang-24   sparse
m68k                 randconfig-r2305-20261104    gcc-14     sparse
m68k                           sun3x_defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261104    gcc-10.5.0
microblaze            randconfig-2000-20261105    gcc-15.3.0
microblaze            randconfig-2001-20261104    gcc-10.5.0
microblaze            randconfig-2001-20261105    gcc-15.3.0
microblaze            randconfig-2200-20261104    gcc-16.2.0 smatch
microblaze            randconfig-2200-20261105    gcc-9.5.0  smatch
microblaze           randconfig-r2105-20261104    gcc-8.5.0  cocci
microblaze           randconfig-r2308-20261104    clang-24   sparse
microblaze           randconfig-r2308-20261105    clang-24   sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                   cavium_octeon_defconfig    gcc-16.2.0
mips                      cu1830-neo_defconfig    gcc-16.2.0
mips                 econet_en751221_defconfig    gcc-16.2.0
mips                           eyeq5_defconfig    clang-17
mips                           eyeq5_defconfig    gcc-16.2.0
mips                      eyeq6lplus_defconfig    gcc-16.2.0
mips                            ip28_defconfig    gcc-16.2.0
mips                       loongson3_defconfig    gcc-16.2.0
mips                 malta_qemu_32r6_defconfig    clang-17
mips                       maltasmvp_defconfig    gcc-16.2.0
mips                     maltaup_xpa_defconfig    clang-19
mips                     maltaup_xpa_defconfig    gcc-16.2.0
mips                            mtx1_defconfig    gcc-16.2.0
mips                       pic32mzda_defconfig    gcc-16.2.0
mips                  randconfig-2000-20261104    clang-19
mips                  randconfig-2000-20261105    gcc-9.5.0
mips                  randconfig-2001-20261104    clang-19
mips                  randconfig-2001-20261105    gcc-9.5.0
mips                  randconfig-2002-20261104    clang-19
mips                  randconfig-2002-20261105    gcc-9.5.0
mips                  randconfig-2200-20261104    clang-24   smatch
mips                  randconfig-2200-20261105    gcc-11.5.0 smatch
mips                 randconfig-r2104-20261105    gcc-8.5.0  cocci
mips                 randconfig-r2107-20261104    gcc-16.2.0 cocci
mips                 randconfig-r2107-20261105    clang-21   cocci
mips                 randconfig-r2108-20261104    clang-24   cocci
mips                 randconfig-r2108-20261104    gcc-16.2.0 cocci
mips                 randconfig-r2109-20261105    clang-21   cocci
mips                 randconfig-r2110-20261105    gcc-16.2.0 cocci
mips                 randconfig-r2303-20261104    gcc-9.5.0  sparse
mips                 randconfig-r2306-20261104    clang-24   sparse
mips                 randconfig-r2307-20261105    gcc-16.2.0 sparse
mips                 randconfig-r2311-20261105    clang-24   sparse
mips                           rb532_defconfig    clang-24
mips                            xway_defconfig    gcc-16.2.0
nios2                          3c120_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261105    clang-24
nios2                 randconfig-1000-20261106    gcc-14.4.0
nios2                 randconfig-1001-20261105    clang-24
nios2                 randconfig-1001-20261106    gcc-14.4.0
nios2                 randconfig-2000-20261104    gcc-15.3.0
nios2                 randconfig-2000-20261104    gcc-15.3.0
nios2                 randconfig-2000-20261105    gcc-16.2.0
nios2                 randconfig-2001-20261104    gcc-15.3.0
nios2                 randconfig-2001-20261104    gcc-15.3.0
nios2                 randconfig-2001-20261105    gcc-16.2.0
nios2                 randconfig-2200-20261104    gcc-8.5.0  smatch
nios2                 randconfig-2200-20261105    gcc-9.5.0  smatch
nios2                randconfig-r2103-20261104    gcc-11.5.0 cocci
nios2                randconfig-r2109-20261105    gcc-8.5.0  cocci
nios2                randconfig-r2110-20261104    gcc-16.2.0 cocci
nios2                randconfig-r2111-20261104    gcc-16.2.0 cocci
nios2                randconfig-r2302-20261105    gcc-8.5.0  sparse
nios2                randconfig-r2303-20261105    clang-24   sparse
nios2                randconfig-r2304-20261104    gcc-14     sparse
nios2                randconfig-r2305-20261105    clang-24   sparse
openrisc                          alldefconfig    gcc-16.2.0
openrisc                          allmodconfig    clang-20
openrisc                          allmodconfig    gcc-11.5.0
openrisc                           allnoconfig    clang-24
openrisc                    de0_nano_defconfig    clang-19
openrisc          de0_nano_multicore_defconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261104    clang-19
openrisc              randconfig-2000-20261105    gcc-9.5.0
openrisc              randconfig-2001-20261104    clang-19
openrisc              randconfig-2001-20261105    gcc-9.5.0
openrisc              randconfig-2002-20261104    clang-19
openrisc              randconfig-2002-20261105    gcc-9.5.0
openrisc              randconfig-2200-20261104    gcc-16.2.0 smatch
openrisc              randconfig-2200-20261105    gcc-16.2.0 smatch
openrisc             randconfig-r2109-20261105    clang-24   cocci
openrisc             randconfig-r2109-20261105    gcc-10.5.0 cocci
openrisc             randconfig-r2110-20261105    gcc-8.5.0  cocci
openrisc             randconfig-r2111-20261105    gcc-8.5.0  cocci
openrisc             randconfig-r2305-20261104    clang-24   sparse
openrisc             randconfig-r2308-20261104    gcc-9.5.0  sparse
openrisc             randconfig-r2308-20261105    gcc-16.2.0 sparse
openrisc             randconfig-r2310-20261105    gcc-16.2.0 sparse
openrisc                  simple_smp_defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                 generic-64bit_defconfig    clang-24
parisc                randconfig-1000-20261105    clang-21
parisc                randconfig-1000-20261106    clang-19
parisc                randconfig-1001-20261105    clang-21
parisc                randconfig-1001-20261106    clang-19
parisc                randconfig-2000-20261104    gcc-15.3.0
parisc                randconfig-2000-20261104    gcc-15.3.0
parisc                randconfig-2000-20261105    gcc-16.2.0
parisc                randconfig-2001-20261104    gcc-15.3.0
parisc                randconfig-2001-20261104    gcc-15.3.0
parisc                randconfig-2001-20261105    gcc-16.2.0
parisc                randconfig-2200-20261104    gcc-8.5.0  smatch
parisc                randconfig-2200-20261105    gcc-15.3.0 smatch
parisc               randconfig-r2101-20261105    clang-20   cocci
parisc               randconfig-r2102-20261105    gcc-14.4.0 cocci
parisc               randconfig-r2104-20261104    clang-24   cocci
parisc               randconfig-r2104-20261105    gcc-10.5.0 cocci
parisc               randconfig-r2105-20261105    gcc-10.5.0 cocci
parisc               randconfig-r2111-20261105    gcc-11.5.0 cocci
parisc               randconfig-r2200-20261104    gcc-10.5.0 smatch
parisc               randconfig-r2304-20261105    gcc-8.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       chrp32_defconfig    clang-24
powerpc                    currituck_defconfig    gcc-16.2.0
powerpc                      ep8248e_defconfig    clang-17
powerpc                       ep88xc_defconfig    clang-17
powerpc                     gamecube_defconfig    clang-19
powerpc                       mgcoge_defconfig    clang-17
powerpc                       mgcoge_defconfig    gcc-16.2.0
powerpc                      mpc512x_defconfig    gcc-16.2.0
powerpc                  mpc834x_itx_defconfig    gcc-16.2.0
powerpc                   mpc866_ads_defconfig    clang-17
powerpc                   mpc885_ads_defconfig    clang-19
powerpc                       pcm030_defconfig    gcc-16.2.0
powerpc                       pmac32_defconfig    gcc-16.2.0
powerpc                      rainier_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261105    clang-21
powerpc               randconfig-1000-20261106    clang-19
powerpc               randconfig-1001-20261105    clang-21
powerpc               randconfig-1001-20261106    clang-19
powerpc               randconfig-2000-20261104    clang-17
powerpc               randconfig-2000-20261104    gcc-13.5.0
powerpc               randconfig-2000-20261105    clang-18
powerpc               randconfig-2001-20261104    clang-17
powerpc               randconfig-2001-20261104    gcc-13.5.0
powerpc               randconfig-2001-20261105    clang-18
powerpc               randconfig-2002-20261104    gcc-13.5.0
powerpc               randconfig-2002-20261105    clang-18
powerpc               randconfig-2200-20261104    clang-20   smatch
powerpc               randconfig-2200-20261105    clang-17   smatch
powerpc              randconfig-r2100-20261105    gcc-8.5.0  cocci
powerpc              randconfig-r2103-20261105    clang-24   cocci
powerpc              randconfig-r2103-20261105    gcc-14.4.0 cocci
powerpc              randconfig-r2104-20261105    clang-24   cocci
powerpc              randconfig-r2105-20261105    clang-24   cocci
powerpc              randconfig-r2109-20261104    clang-24   cocci
powerpc              randconfig-r2300-20261104    gcc-14     sparse
powerpc              randconfig-r2305-20261104    gcc-9.5.0  sparse
powerpc                      tqm8555_defconfig    clang-19
powerpc                  xes_mpc85xx_defconfig    clang-17
powerpc64             randconfig-1000-20261105    clang-21
powerpc64             randconfig-1000-20261106    clang-19
powerpc64             randconfig-1001-20261105    clang-21
powerpc64             randconfig-1001-20261106    clang-19
powerpc64             randconfig-2000-20261104    clang-17
powerpc64             randconfig-2000-20261104    gcc-13.5.0
powerpc64             randconfig-2000-20261105    clang-18
powerpc64             randconfig-2001-20261104    clang-17
powerpc64             randconfig-2001-20261104    gcc-13.5.0
powerpc64             randconfig-2001-20261105    clang-18
powerpc64             randconfig-2002-20261104    gcc-13.5.0
powerpc64             randconfig-2002-20261105    clang-18
powerpc64             randconfig-2200-20261104    gcc-15.3.0 smatch
powerpc64             randconfig-2200-20261105    clang-24   smatch
powerpc64            randconfig-r2100-20261105    gcc-14.4.0 cocci
powerpc64            randconfig-r2101-20261105    gcc-14.4.0 cocci
powerpc64            randconfig-r2104-20261104    gcc-8.5.0  cocci
powerpc64            randconfig-r2105-20261105    gcc-16.2.0 cocci
powerpc64            randconfig-r2107-20261105    clang-24   cocci
powerpc64            randconfig-r2108-20261104    clang-24   cocci
powerpc64            randconfig-r2301-20261104    gcc-9.5.0  sparse
powerpc64            randconfig-r2302-20261104    clang-24   sparse
powerpc64            randconfig-r2308-20261104    gcc-13.5.0 sparse
powerpc64            randconfig-r2309-20261105    gcc-16.2.0 sparse
powerpc64            randconfig-r2311-20261104    gcc-13.5.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv              nommu_k210_sdcard_defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261105    clang-24
riscv                 randconfig-1000-20261106    gcc-14.4.0
riscv                 randconfig-1001-20261105    clang-24
riscv                 randconfig-1001-20261106    gcc-14.4.0
riscv                 randconfig-2000-20261104    clang-18
riscv                 randconfig-2000-20261104    gcc-12.5.0
riscv                 randconfig-2000-20261105    clang-24
riscv                 randconfig-2001-20261104    clang-18
riscv                 randconfig-2001-20261104    gcc-12.5.0
riscv                 randconfig-2001-20261105    clang-24
riscv                 randconfig-2002-20261104    clang-18
riscv                 randconfig-2002-20261105    clang-24
riscv                 randconfig-2003-20261104    clang-18
riscv                 randconfig-2003-20261105    clang-24
riscv                 randconfig-2004-20261104    clang-18
riscv                 randconfig-2004-20261105    clang-24
riscv                 randconfig-2005-20261104    clang-18
riscv                 randconfig-2005-20261105    clang-24
riscv                 randconfig-2200-20261104    gcc-13.5.0 smatch
riscv                 randconfig-2200-20261105    clang-24   smatch
riscv                randconfig-r2102-20261105    gcc-8.5.0  cocci
riscv                randconfig-r2108-20261105    clang-24   cocci
riscv                randconfig-r2108-20261105    gcc-8.5.0  cocci
riscv                randconfig-r2304-20261105    clang-24   sparse
riscv                randconfig-r2307-20261105    gcc-16.2.0 sparse
riscv                randconfig-r2309-20261104    gcc-13.5.0 sparse
riscv                randconfig-r2309-20261104    gcc-9.5.0  sparse
riscv                randconfig-r2310-20261104    gcc-13.5.0 sparse
s390                              alldefconfig    clang-17
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261105    clang-24
s390                  randconfig-1000-20261106    gcc-14.4.0
s390                  randconfig-1001-20261105    clang-24
s390                  randconfig-1001-20261106    gcc-14.4.0
s390                  randconfig-2000-20261104    gcc-12.5.0
s390                  randconfig-2000-20261104    gcc-8.5.0
s390                  randconfig-2000-20261105    clang-24
s390                  randconfig-2001-20261104    gcc-12.5.0
s390                  randconfig-2001-20261104    gcc-8.5.0
s390                  randconfig-2001-20261105    clang-24
s390                  randconfig-2002-20261104    gcc-8.5.0
s390                  randconfig-2002-20261105    clang-24
s390                  randconfig-2003-20261104    gcc-8.5.0
s390                  randconfig-2003-20261105    clang-24
s390                  randconfig-2004-20261104    gcc-8.5.0
s390                  randconfig-2004-20261105    clang-24
s390                  randconfig-2005-20261104    gcc-8.5.0
s390                  randconfig-2005-20261105    clang-24
s390                  randconfig-2200-20261104    gcc-8.5.0  smatch
s390                  randconfig-2200-20261105    clang-24   smatch
s390                 randconfig-r2100-20261105    clang-24   cocci
s390                 randconfig-r2106-20261105    gcc-16.2.0 cocci
s390                 randconfig-r2107-20261105    gcc-16.2.0 cocci
s390                 randconfig-r2109-20261104    clang-24   cocci
s390                 randconfig-r2109-20261105    gcc-11.5.0 cocci
s390                 randconfig-r2200-20261104    clang-22   smatch
s390                 randconfig-r2300-20261104    clang-24   sparse
s390                 randconfig-r2307-20261105    clang-24   sparse
s390                 randconfig-r2307-20261105    gcc-16.2.0 sparse
s390                 randconfig-r2308-20261105    gcc-16.2.0 sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.2.0
sh                                   defconfig    gcc-14
sh                              espt_defconfig    gcc-16.2.0
sh                  kfr2r09-romimage_defconfig    clang-17
sh                  kfr2r09-romimage_defconfig    gcc-16.2.0
sh                           polaris_defconfig    gcc-16.2.0
sh                           r7780mp_defconfig    gcc-16.2.0
sh                           r7785rp_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261105    clang-24
sh                    randconfig-1000-20261106    gcc-14.4.0
sh                    randconfig-1001-20261105    clang-24
sh                    randconfig-1001-20261106    gcc-14.4.0
sh                    randconfig-2000-20261104    gcc-12.5.0
sh                    randconfig-2000-20261104    gcc-16.2.0
sh                    randconfig-2000-20261105    gcc-16.2.0
sh                    randconfig-2001-20261104    gcc-12.5.0
sh                    randconfig-2001-20261104    gcc-16.2.0
sh                    randconfig-2001-20261105    gcc-16.2.0
sh                    randconfig-2002-20261104    gcc-16.2.0
sh                    randconfig-2002-20261105    gcc-16.2.0
sh                    randconfig-2003-20261104    gcc-16.2.0
sh                    randconfig-2003-20261105    gcc-16.2.0
sh                    randconfig-2004-20261104    gcc-16.2.0
sh                    randconfig-2004-20261105    gcc-16.2.0
sh                    randconfig-2005-20261104    gcc-16.2.0
sh                    randconfig-2005-20261105    gcc-16.2.0
sh                    randconfig-2200-20261104    gcc-16.2.0 smatch
sh                    randconfig-2200-20261105    gcc-13.5.0 smatch
sh                   randconfig-r2103-20261105    gcc-8.5.0  cocci
sh                   randconfig-r2105-20261105    gcc-14.4.0 cocci
sh                   randconfig-r2108-20261104    gcc-16.2.0 cocci
sh                   randconfig-r2110-20261105    clang-21   cocci
sh                   randconfig-r2306-20261105    clang-24   sparse
sh                   randconfig-r2309-20261105    gcc-16.2.0 sparse
sh                           rsk7201_defconfig    clang-17
sh                            se7724_defconfig    gcc-16.2.0
sh                         sh7757lcr_defconfig    gcc-16.2.0
sh                   sh7785lcr_32bit_defconfig    gcc-16.2.0
sh                              shx3_defconfig    clang-17
sh                              shx3_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261105    gcc-8.5.0
sparc                 randconfig-1000-20261106    gcc-15.3.0
sparc                 randconfig-1001-20261105    gcc-8.5.0
sparc                 randconfig-1001-20261106    gcc-15.3.0
sparc                 randconfig-2000-20261104    clang-24
sparc                 randconfig-2000-20261104    clang-24
sparc                 randconfig-2000-20261105    clang-24
sparc                 randconfig-2001-20261104    clang-24
sparc                 randconfig-2001-20261104    clang-24
sparc                 randconfig-2001-20261105    clang-24
sparc                 randconfig-2200-20261104    gcc-12.5.0 smatch
sparc                 randconfig-2200-20261105    gcc-16.2.0 smatch
sparc                randconfig-r2101-20261105    clang-24   cocci
sparc                randconfig-r2101-20261105    gcc-14.4.0 cocci
sparc                randconfig-r2106-20261104    gcc-16.2.0 cocci
sparc                randconfig-r2110-20261105    gcc-16.2.0 cocci
sparc                randconfig-r2111-20261105    gcc-16.2.0 cocci
sparc                randconfig-r2300-20261105    clang-24   sparse
sparc                randconfig-r2300-20261105    gcc-8.5.0  sparse
sparc                randconfig-r2311-20261105    gcc-16.2.0 sparse
sparc64                           alldefconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261105    gcc-8.5.0
sparc64               randconfig-1000-20261106    gcc-15.3.0
sparc64               randconfig-1001-20261105    gcc-8.5.0
sparc64               randconfig-1001-20261106    gcc-15.3.0
sparc64               randconfig-2000-20261104    clang-24
sparc64               randconfig-2000-20261104    clang-24
sparc64               randconfig-2000-20261105    clang-24
sparc64               randconfig-2001-20261104    clang-24
sparc64               randconfig-2001-20261104    clang-24
sparc64               randconfig-2001-20261105    clang-24
sparc64               randconfig-2200-20261104    gcc-8.5.0  smatch
sparc64               randconfig-2200-20261105    gcc-8.5.0  smatch
sparc64              randconfig-r2101-20261105    clang-24   cocci
sparc64              randconfig-r2103-20261104    gcc-8.5.0  cocci
sparc64              randconfig-r2103-20261105    gcc-10.5.0 cocci
sparc64              randconfig-r2105-20261105    clang-20   cocci
sparc64              randconfig-r2105-20261105    gcc-8.5.0  cocci
sparc64              randconfig-r2300-20261104    gcc-9.5.0  sparse
sparc64              randconfig-r2301-20261104    clang-24   sparse
sparc64              randconfig-r2303-20261104    gcc-14     sparse
sparc64              randconfig-r2304-20261104    clang-24   sparse
sparc64              randconfig-r2306-20261104    gcc-13.5.0 sparse
um                                alldefconfig    gcc-16.2.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261105    gcc-8.5.0
um                    randconfig-1000-20261106    gcc-15.3.0
um                    randconfig-1001-20261105    gcc-8.5.0
um                    randconfig-1001-20261106    gcc-15.3.0
um                    randconfig-2000-20261104    clang-24
um                    randconfig-2000-20261104    clang-24
um                    randconfig-2000-20261105    clang-24
um                    randconfig-2001-20261104    clang-24
um                    randconfig-2001-20261104    clang-24
um                    randconfig-2001-20261105    clang-24
um                    randconfig-2200-20261104    clang-24   smatch
um                    randconfig-2200-20261105    clang-19   smatch
um                   randconfig-r2103-20261105    clang-20   cocci
um                   randconfig-r2105-20261105    gcc-14.4.0 cocci
um                   randconfig-r2105-20261105    gcc-8.5.0  cocci
um                   randconfig-r2107-20261105    gcc-16.2.0 cocci
um                   randconfig-r2111-20261104    clang-24   cocci
um                   randconfig-r2303-20261105    clang-24   sparse
um                   randconfig-r2307-20261104    gcc-13.5.0 sparse
um                   randconfig-r2307-20261105    clang-24   sparse
um                   randconfig-r2309-20261105    gcc-16.2.0 sparse
um                   randconfig-r2310-20261105    clang-24   sparse
um                   randconfig-r2311-20261104    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            alldefconfig    clang-19
x86_64                            alldefconfig    gcc-16.2.0
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261105    gcc-14
x86_64      buildonly-randconfig-1000-20261106    gcc-13
x86_64      buildonly-randconfig-1001-20261105    gcc-14
x86_64      buildonly-randconfig-1001-20261106    gcc-13
x86_64      buildonly-randconfig-1002-20261105    gcc-14
x86_64      buildonly-randconfig-1002-20261106    gcc-13
x86_64      buildonly-randconfig-1003-20261105    gcc-14
x86_64      buildonly-randconfig-1003-20261106    gcc-13
x86_64      buildonly-randconfig-1004-20261105    gcc-14
x86_64      buildonly-randconfig-1004-20261106    gcc-13
x86_64      buildonly-randconfig-1005-20261105    gcc-14
x86_64      buildonly-randconfig-1005-20261106    gcc-13
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261105    clang-22
x86_64                randconfig-1000-20261106    clang-22
x86_64                randconfig-1001-20261105    clang-22
x86_64                randconfig-1001-20261106    clang-22
x86_64                randconfig-1002-20261105    clang-22
x86_64                randconfig-1002-20261106    clang-22
x86_64                randconfig-1003-20261105    clang-22
x86_64                randconfig-1003-20261106    clang-22
x86_64                randconfig-1004-20261105    clang-22
x86_64                randconfig-1004-20261106    clang-22
x86_64                randconfig-1005-20261105    clang-22
x86_64                randconfig-1005-20261106    clang-22
x86_64                randconfig-1006-20261105    clang-22
x86_64                randconfig-1006-20261106    clang-22
x86_64                randconfig-1007-20261105    clang-22
x86_64                randconfig-1007-20261106    clang-22
x86_64                randconfig-1008-20261105    clang-22
x86_64                randconfig-1008-20261106    clang-22
x86_64                randconfig-1009-20261105    clang-22
x86_64                randconfig-1009-20261106    clang-22
x86_64                randconfig-1010-20261105    clang-22
x86_64                randconfig-1010-20261106    clang-22
x86_64                randconfig-1011-20261105    clang-22
x86_64                randconfig-1011-20261106    clang-22
x86_64                randconfig-1012-20261105    clang-22
x86_64                randconfig-1012-20261106    gcc-14
x86_64                randconfig-1013-20261105    clang-22
x86_64                randconfig-1013-20261106    gcc-14
x86_64                randconfig-1014-20261105    clang-22
x86_64                randconfig-1014-20261106    gcc-14
x86_64                randconfig-1015-20261105    clang-22
x86_64                randconfig-1015-20261106    gcc-14
x86_64                randconfig-1016-20261105    clang-22
x86_64                randconfig-1016-20261106    gcc-14
x86_64                randconfig-1017-20261105    clang-22
x86_64                randconfig-1017-20261106    gcc-14
x86_64                randconfig-2000-20261104    clang-17
x86_64                randconfig-2000-20261104    clang-22
x86_64                randconfig-2000-20261105    gcc-14
x86_64                randconfig-2001-20261104    clang-17
x86_64                randconfig-2001-20261104    clang-22
x86_64                randconfig-2001-20261105    gcc-14
x86_64                randconfig-2002-20261104    clang-22
x86_64                randconfig-2002-20261105    gcc-14
x86_64                randconfig-2003-20261104    clang-22
x86_64                randconfig-2003-20261105    gcc-14
x86_64                randconfig-2004-20261104    clang-22
x86_64                randconfig-2004-20261105    gcc-14
x86_64                randconfig-2005-20261104    clang-22
x86_64                randconfig-2005-20261105    gcc-14
x86_64                randconfig-2100-20261104    clang-22   cocci
x86_64                randconfig-2100-20261105    gcc-14     cocci
x86_64                randconfig-2101-20261104    clang-22   cocci
x86_64                randconfig-2101-20261105    gcc-14     cocci
x86_64                randconfig-2102-20261104    clang-22   cocci
x86_64                randconfig-2102-20261105    gcc-14     cocci
x86_64                randconfig-2103-20261104    clang-22   cocci
x86_64                randconfig-2103-20261105    gcc-14     cocci
x86_64                randconfig-2104-20261104    clang-22   cocci
x86_64                randconfig-2104-20261105    gcc-14     cocci
x86_64                randconfig-2105-20261104    clang-22   cocci
x86_64                randconfig-2105-20261105    gcc-14     cocci
x86_64                randconfig-2200-20261104    gcc-14     smatch
x86_64                randconfig-2200-20261105    clang-22   smatch
x86_64                randconfig-2300-20261104    gcc-14     sparse
x86_64                randconfig-2300-20261105    clang-22   sparse
x86_64                randconfig-2301-20261104    gcc-14     sparse
x86_64                randconfig-2301-20261105    clang-22   sparse
x86_64                randconfig-2302-20261104    gcc-14     sparse
x86_64                randconfig-2302-20261105    clang-22   sparse
x86_64               randconfig-r2100-20261105    gcc-8.5.0  cocci
x86_64               randconfig-r2103-20261105    gcc-8.5.0  cocci
x86_64               randconfig-r2104-20261104    gcc-11.5.0 cocci
x86_64               randconfig-r2107-20261104    gcc-16.2.0 cocci
x86_64               randconfig-r2108-20261105    clang-21   cocci
x86_64               randconfig-r2109-20261104    gcc-16.2.0 cocci
x86_64               randconfig-r2110-20261105    clang-24   cocci
x86_64               randconfig-r2111-20261104    gcc-16.2.0 cocci
x86_64               randconfig-r2301-20261104    gcc-14     sparse
x86_64               randconfig-r2306-20261105    gcc-16.2.0 sparse
x86_64               randconfig-r2308-20261105    clang-24   sparse
x86_64               randconfig-r2310-20261104    gcc-9.5.0  sparse
x86_64               randconfig-r2311-20261105    gcc-16.2.0 sparse
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
xtensa                            allyesconfig    gcc-11.5.0
xtensa                 generic_kc705_defconfig    gcc-16.2.0
xtensa                   nommu_kc705_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261105    gcc-8.5.0
xtensa                randconfig-1000-20261106    gcc-15.3.0
xtensa                randconfig-1001-20261105    gcc-8.5.0
xtensa                randconfig-1001-20261106    gcc-15.3.0
xtensa                randconfig-2000-20261104    clang-24
xtensa                randconfig-2000-20261104    clang-24
xtensa                randconfig-2000-20261105    clang-24
xtensa                randconfig-2001-20261104    clang-24
xtensa                randconfig-2001-20261104    clang-24
xtensa                randconfig-2001-20261105    clang-24
xtensa                randconfig-2200-20261104    gcc-10.5.0 smatch
xtensa                randconfig-2200-20261105    gcc-8.5.0  smatch
xtensa               randconfig-r2101-20261104    gcc-11.5.0 cocci
xtensa               randconfig-r2101-20261104    gcc-8.5.0  cocci
xtensa               randconfig-r2103-20261105    clang-24   cocci
xtensa               randconfig-r2104-20261105    clang-24   cocci
xtensa               randconfig-r2106-20261105    gcc-8.5.0  cocci
xtensa               randconfig-r2109-20261105    gcc-16.2.0 cocci
xtensa               randconfig-r2109-20261105    gcc-8.5.0  cocci
xtensa               randconfig-r2110-20261105    gcc-11.5.0 cocci
xtensa               randconfig-r2302-20261105    clang-24   sparse
xtensa               randconfig-r2303-20261105    gcc-8.5.0  sparse
xtensa               randconfig-r2308-20261105    gcc-16.2.0 sparse
xtensa               randconfig-r2310-20261105    gcc-16.2.0 sparse
xtensa               randconfig-r2311-20261104    gcc-9.5.0  sparse
xtensa                     xip_kc705_defconfig    clang-17
xtensa                     xip_kc705_defconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
