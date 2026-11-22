Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795347387;
	b=HDj7FUIuI1wZHEnBTsHpvQVKfUuZ0NsaSbH+Crhxs0hTdGBPahhQvt0Jq2LvJzhaZcfL
	 lofxyePZSO+h2h8Aza0Yqi1E2fEYhnRW2tLU8CXN1HfFtFqwbRoVyXTzaN9f/PsH1d7Pi
	 XIMIObTydfjJHgLQcsKmdAq5Nf7cfGbzK78bgm8vqTpmOX0Jv+1Mpx0xbOsDNNoGTa+yJ
	 LMESSQBfvVcZ1V1H2RP7Wnk/pfRmdCkRkmBN4RUhJkIeZUIhaz6G+w/0M2w+Av8y86zYZ
	 oAo8EYhqn3zTrosjfBrL+XvOS+a0nzc76bX61nvD4hGP53zDfJdTR96Vffaqpibb10A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795347387;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=o358oWbj2bJklXR9hnS7fv7xfdOEiZr+XinzfqTbbgc=;
	b=IVAAvI/QVoWR2epR1K17ktd+tXr4+tZubRmTkqtsuFPu1SftirNmG7t38OjWo5l5cEy3
	 PM27fI3LhDQ6xwByRkTYs+2qa/3gTWpb5DjBWYCV9ejMUscaBbBednUxtiE7LfzVhs6tX
	 A4Ufu8P0iOZp/vVL88yGyeU+HOCoFe3TPlvKdRFWyPKcyPw/e71NbtgxR/7K92/yjkcdI
	 OtvMl4sF96yY42VALYjP9hhcJSLnoHVmhCesvWimGV70WaulXk/JWrOhiHnUVIRb9hHjo
	 2XfwlfeF6TOfd+upFdjc9sWlWrDsupesWhLP9Bmvzu4685JUJbA+saB++eMQmSdJ+vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ncmwUv4B;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D505606A32A
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 11:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D505606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ncmwUv4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795347386; x=1826883386;
  h=date:from:to:cc:subject:message-id;
  bh=IMhfK6XEnAF27YvBvKS8ZYbCfP7Sobg8FCE5YMDWhJk=;
  b=ncmwUv4B9aRB45gztzk2EM1GNu/GaTBbU5PdnIHEx9Ebzc4Z/7I0+TXu
   r368G5Noc5+w8peSG1iIqrnhpJa4sIML2/HhuBPLGZfGutf6uLuatRx/H
   iBohld/VA5DssK4/kSLszjPo7fuT8OnDcbMEKkMM7zZDcw0s2mVJr0e2q
   2yArb91YxjmUq1jiCzkH/t+Ii1N5bTC4H4V4uo3S3r9l5uSPqacWG6s1o
   LxHjrVf5IieC2HE9Y+7tHBIVaSgRiYCdQRJYg1jAWCgT0TT+64hr0+Aia
   ZZxMi6Ql5Yah+IA55fZeymlh8gPpaqnsk5e2Nu8MyeqWBearg7EIKos2x
   Q==;
X-CSE-ConnectionGUID: s4OcZA63RJOrnKIpAeyVPQ==
X-CSE-MsgGUID: 1XSkh1i2R6iH6LGpkZ4svw==
X-IronPort-AV: E=McAfee;i="6800,10657,11973"; a="4271098"
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; 
   d="scan'208";a="4271098"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 03:36:26 -0800
X-CSE-ConnectionGUID: MEcM36FxTj6D3C0ceUYVwg==
X-CSE-MsgGUID: kio6f963TBKNIYTg+ovNnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; 
   d="scan'208";a="11437215"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 22 Nov 2026 03:36:25 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xV5rq-00000001LRK-0yC5;
	Sun, 22 Nov 2026 11:36:22 +0000
Date: Sun, 22 Nov 2026 19:35:53 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 bdb7d930e04b5cd903df2d6c30eeb078bffd67f4
Message-ID: <20261122193553.5KuggZIc-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: bdb7d930e04b5cd903df2d6c30eeb078bffd67f4  PCI/AER: Enable baseline capability error reporting

elapsed time: 875m

configs tested: 614
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261120    gcc-15.3.0
alpha                 randconfig-2000-20261121    gcc-14.4.0
alpha                 randconfig-2001-20261120    gcc-15.3.0
alpha                 randconfig-2001-20261121    gcc-14.4.0
alpha                 randconfig-2200-20261120    gcc-15.3.0 smatch
alpha                 randconfig-2200-20261121    gcc-10.5.0 smatch
alpha                randconfig-r2103-20261121    gcc-9.5.0  cocci
alpha                randconfig-r2301-20261121    clang-17   sparse
alpha                randconfig-r2301-20261121    gcc-14     sparse
alpha                randconfig-r2305-20261121    clang-17   sparse
alpha                randconfig-r2309-20261121    gcc-11.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261122    clang-17
arc                   randconfig-1001-20261122    clang-17
arc                   randconfig-2000-20261120    gcc-11.5.0
arc                   randconfig-2000-20261121    gcc-8.5.0
arc                   randconfig-2001-20261120    gcc-11.5.0
arc                   randconfig-2001-20261121    gcc-8.5.0
arc                   randconfig-2002-20261120    gcc-11.5.0
arc                   randconfig-2002-20261121    gcc-8.5.0
arc                   randconfig-2003-20261120    gcc-11.5.0
arc                   randconfig-2003-20261121    gcc-8.5.0
arc                   randconfig-2004-20261120    gcc-11.5.0
arc                   randconfig-2004-20261121    gcc-8.5.0
arc                   randconfig-2005-20261120    gcc-11.5.0
arc                   randconfig-2005-20261121    gcc-8.5.0
arc                   randconfig-2200-20261120    gcc-15.3.0 smatch
arc                   randconfig-2200-20261121    gcc-14.4.0 smatch
arc                  randconfig-r2109-20261120    gcc-8.5.0  cocci
arc                  randconfig-r2109-20261121    gcc-8.5.0  cocci
arc                  randconfig-r2110-20261121    clang-22   cocci
arc                  randconfig-r2111-20261121    clang-22   cocci
arc                  randconfig-r2111-20261121    gcc-14.4.0 cocci
arc                  randconfig-r2304-20261120    clang-24   sparse
arc                  randconfig-r2309-20261120    clang-24   sparse
arc                  randconfig-r2310-20261121    clang-22   sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                            h3600_defconfig    clang-17
arm                   randconfig-1000-20261122    clang-17
arm                   randconfig-1001-20261122    clang-17
arm                   randconfig-1002-20261122    clang-17
arm                   randconfig-1003-20261122    clang-17
arm                   randconfig-2000-20261120    gcc-8.5.0
arm                   randconfig-2000-20261121    clang-24
arm                   randconfig-2001-20261120    gcc-8.5.0
arm                   randconfig-2001-20261121    clang-24
arm                   randconfig-2002-20261120    gcc-8.5.0
arm                   randconfig-2002-20261121    clang-24
arm                   randconfig-2200-20261120    clang-17   smatch
arm                   randconfig-2200-20261121    clang-19   smatch
arm                  randconfig-r2106-20261120    gcc-8.5.0  cocci
arm                  randconfig-r2106-20261121    clang-22   cocci
arm                  randconfig-r2111-20261120    gcc-16.2.0 cocci
arm                  randconfig-r2300-20261121    gcc-14     sparse
arm                  randconfig-r2304-20261121    gcc-8.5.0  sparse
arm                  randconfig-r2307-20261121    clang-22   sparse
arm                  randconfig-r2308-20261121    gcc-8.5.0  sparse
arm                  randconfig-r2309-20261120    gcc-8.5.0  sparse
arm                  randconfig-r2310-20261121    gcc-15.3.0 sparse
arm                         shmobile_defconfig    clang-17
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261122    gcc-8.5.0
arm64                 randconfig-1001-20261122    gcc-8.5.0
arm64                 randconfig-1002-20261122    gcc-8.5.0
arm64                 randconfig-1003-20261122    gcc-8.5.0
arm64                 randconfig-2000-20261120    gcc-8.5.0
arm64                 randconfig-2000-20261121    clang-24
arm64                 randconfig-2001-20261120    gcc-8.5.0
arm64                 randconfig-2001-20261121    clang-24
arm64                 randconfig-2002-20261120    gcc-8.5.0
arm64                 randconfig-2002-20261121    clang-24
arm64                 randconfig-2200-20261120    clang-17   smatch
arm64                 randconfig-2200-20261121    clang-22   smatch
arm64                randconfig-r2101-20261121    gcc-9.5.0  cocci
arm64                randconfig-r2102-20261120    clang-24   cocci
arm64                randconfig-r2102-20261121    gcc-9.5.0  cocci
arm64                randconfig-r2300-20261120    clang-24   sparse
arm64                randconfig-r2301-20261120    gcc-8.5.0  sparse
arm64                randconfig-r2301-20261121    gcc-16.2.0 sparse
arm64                randconfig-r2304-20261121    clang-17   sparse
arm64                randconfig-r2304-20261121    gcc-16.2.0 sparse
arm64                randconfig-r2305-20261120    gcc-9.5.0  sparse
arm64                randconfig-r2309-20261121    gcc-16.2.0 sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261122    gcc-8.5.0
csky                  randconfig-1001-20261122    gcc-8.5.0
csky                  randconfig-2000-20261120    gcc-16.2.0
csky                  randconfig-2000-20261121    gcc-16.2.0
csky                  randconfig-2001-20261120    gcc-16.2.0
csky                  randconfig-2001-20261121    gcc-16.2.0
csky                  randconfig-2200-20261120    gcc-15.3.0 smatch
csky                  randconfig-2200-20261121    gcc-16.2.0 smatch
csky                 randconfig-r2100-20261121    gcc-10.5.0 cocci
csky                 randconfig-r2100-20261121    gcc-14     cocci
csky                 randconfig-r2103-20261121    clang-24   cocci
csky                 randconfig-r2105-20261120    gcc-16.2.0 cocci
csky                 randconfig-r2108-20261121    gcc-13.5.0 cocci
csky                 randconfig-r2303-20261121    gcc-14     sparse
csky                 randconfig-r2307-20261121    gcc-11.5.0 sparse
csky                 randconfig-r2309-20261121    gcc-10.5.0 sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261122    gcc-8.5.0
hexagon               randconfig-1001-20261122    gcc-8.5.0
hexagon               randconfig-2000-20261120    gcc-16.2.0
hexagon               randconfig-2000-20261121    gcc-16.2.0
hexagon               randconfig-2001-20261120    gcc-16.2.0
hexagon               randconfig-2001-20261121    gcc-16.2.0
hexagon               randconfig-2200-20261120    clang-17   smatch
hexagon               randconfig-2200-20261121    clang-24   smatch
hexagon              randconfig-r2106-20261120    clang-17   cocci
hexagon              randconfig-r2107-20261121    clang-22   cocci
hexagon              randconfig-r2108-20261120    gcc-16.2.0 cocci
hexagon              randconfig-r2108-20261120    gcc-8.5.0  cocci
hexagon              randconfig-r2108-20261121    gcc-14.4.0 cocci
hexagon              randconfig-r2109-20261121    gcc-13.5.0 cocci
hexagon              randconfig-r2302-20261121    clang-17   sparse
hexagon              randconfig-r2304-20261121    gcc-14     sparse
hexagon              randconfig-r2305-20261121    gcc-16.2.0 sparse
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
i386                  randconfig-2000-20261120    clang-22
i386                  randconfig-2000-20261121    gcc-14
i386                  randconfig-2001-20261120    clang-22
i386                  randconfig-2001-20261121    gcc-14
i386                  randconfig-2002-20261120    clang-22
i386                  randconfig-2002-20261121    gcc-14
i386                  randconfig-2003-20261120    clang-22
i386                  randconfig-2003-20261121    gcc-14
i386                  randconfig-2004-20261120    clang-22
i386                  randconfig-2004-20261121    gcc-14
i386                  randconfig-2005-20261120    clang-22
i386                  randconfig-2005-20261121    gcc-14
i386                  randconfig-2100-20261120    gcc-14     cocci
i386                  randconfig-2100-20261121    clang-22   cocci
i386                  randconfig-2101-20261120    gcc-14     cocci
i386                  randconfig-2101-20261121    clang-22   cocci
i386                  randconfig-2102-20261120    gcc-14     cocci
i386                  randconfig-2102-20261121    clang-22   cocci
i386                  randconfig-2103-20261120    gcc-14     cocci
i386                  randconfig-2103-20261121    clang-22   cocci
i386                  randconfig-2104-20261120    gcc-14     cocci
i386                  randconfig-2104-20261121    clang-22   cocci
i386                  randconfig-2105-20261120    gcc-14     cocci
i386                  randconfig-2105-20261121    clang-22   cocci
i386                  randconfig-2200-20261120    clang-22   smatch
i386                  randconfig-2200-20261121    clang-22   smatch
i386                  randconfig-2300-20261120    clang-22   sparse
i386                  randconfig-2300-20261121    gcc-14     sparse
i386                  randconfig-2301-20261120    clang-22   sparse
i386                  randconfig-2301-20261121    gcc-14     sparse
i386                  randconfig-2302-20261120    clang-22   sparse
i386                  randconfig-2302-20261121    gcc-14     sparse
i386                 randconfig-r2103-20261121    gcc-10.5.0 cocci
i386                 randconfig-r2109-20261121    clang-22   cocci
i386                 randconfig-r2110-20261120    clang-17   cocci
i386                 randconfig-r2110-20261121    gcc-13.5.0 cocci
i386                 randconfig-r2111-20261120    clang-17   cocci
i386                 randconfig-r2300-20261121    gcc-16.2.0 sparse
i386                 randconfig-r2302-20261120    gcc-8.5.0  sparse
i386                 randconfig-r2308-20261121    gcc-10.5.0 sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261122    gcc-8.5.0
loongarch             randconfig-1001-20261122    gcc-8.5.0
loongarch             randconfig-2000-20261120    clang-24
loongarch             randconfig-2000-20261121    clang-22
loongarch             randconfig-2001-20261120    clang-24
loongarch             randconfig-2001-20261121    clang-22
loongarch             randconfig-2200-20261120    clang-18   smatch
loongarch             randconfig-2200-20261121    gcc-16.2.0 smatch
loongarch            randconfig-r2101-20261120    clang-24   cocci
loongarch            randconfig-r2101-20261121    gcc-16.2.0 cocci
loongarch            randconfig-r2103-20261120    clang-24   cocci
loongarch            randconfig-r2103-20261121    gcc-9.5.0  cocci
loongarch            randconfig-r2104-20261120    clang-24   cocci
loongarch            randconfig-r2109-20261120    clang-17   cocci
loongarch            randconfig-r2110-20261120    gcc-8.5.0  cocci
loongarch            randconfig-r2303-20261121    clang-21   sparse
loongarch            randconfig-r2306-20261121    clang-22   sparse
loongarch            randconfig-r2310-20261120    gcc-8.5.0  sparse
loongarch            randconfig-r2311-20261120    clang-24   sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5329evb_defconfig    clang-17
m68k                  randconfig-2000-20261120    gcc-15.3.0
m68k                  randconfig-2000-20261121    gcc-14.4.0
m68k                  randconfig-2001-20261120    gcc-15.3.0
m68k                  randconfig-2001-20261121    gcc-14.4.0
m68k                  randconfig-2200-20261120    gcc-14.4.0 smatch
m68k                  randconfig-2200-20261121    gcc-8.5.0  smatch
m68k                 randconfig-r2101-20261120    clang-24   cocci
m68k                 randconfig-r2104-20261120    clang-24   cocci
m68k                 randconfig-r2105-20261120    clang-24   cocci
m68k                 randconfig-r2110-20261120    gcc-16.2.0 cocci
m68k                 randconfig-r2301-20261120    gcc-9.5.0  sparse
m68k                 randconfig-r2303-20261121    gcc-16.2.0 sparse
m68k                 randconfig-r2310-20261121    gcc-11.5.0 sparse
m68k                 randconfig-r2311-20261121    gcc-11.5.0 sparse
m68k                 randconfig-r2311-20261121    gcc-8.5.0  sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261120    gcc-15.3.0
microblaze            randconfig-2000-20261121    gcc-14.4.0
microblaze            randconfig-2001-20261120    gcc-15.3.0
microblaze            randconfig-2001-20261121    gcc-14.4.0
microblaze            randconfig-2200-20261120    gcc-11.5.0 smatch
microblaze            randconfig-2200-20261121    gcc-8.5.0  smatch
microblaze           randconfig-r2102-20261121    gcc-10.5.0 cocci
microblaze           randconfig-r2105-20261121    gcc-10.5.0 cocci
microblaze           randconfig-r2106-20261120    gcc-16.2.0 cocci
microblaze           randconfig-r2300-20261120    gcc-8.5.0  sparse
microblaze           randconfig-r2306-20261120    gcc-8.5.0  sparse
microblaze           randconfig-r2306-20261121    gcc-10.5.0 sparse
microblaze           randconfig-r2307-20261121    gcc-16.2.0 sparse
microblaze           randconfig-r2308-20261121    gcc-15.3.0 sparse
microblaze           randconfig-r2309-20261121    gcc-8.5.0  sparse
microblaze           randconfig-r2310-20261121    gcc-16.2.0 sparse
microblaze           randconfig-r2311-20261121    clang-22   sparse
microblaze           randconfig-r2311-20261121    gcc-11.5.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                            mtx1_defconfig    clang-17
mips                  randconfig-2000-20261120    gcc-9.5.0
mips                  randconfig-2000-20261121    gcc-16.2.0
mips                  randconfig-2001-20261120    gcc-9.5.0
mips                  randconfig-2001-20261121    gcc-16.2.0
mips                  randconfig-2002-20261120    gcc-9.5.0
mips                  randconfig-2002-20261121    gcc-16.2.0
mips                  randconfig-2200-20261120    clang-24   smatch
mips                  randconfig-2200-20261121    clang-21   smatch
mips                 randconfig-r2101-20261120    gcc-16.2.0 cocci
mips                 randconfig-r2103-20261120    gcc-16.2.0 cocci
mips                 randconfig-r2107-20261120    gcc-8.5.0  cocci
mips                 randconfig-r2110-20261121    gcc-14.4.0 cocci
mips                 randconfig-r2302-20261120    clang-24   sparse
mips                 randconfig-r2302-20261121    gcc-8.5.0  sparse
mips                 randconfig-r2306-20261121    gcc-16.2.0 sparse
mips                 randconfig-r2308-20261120    gcc-8.5.0  sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261122    gcc-8.5.0
nios2                 randconfig-1001-20261122    gcc-8.5.0
nios2                 randconfig-2000-20261120    clang-24
nios2                 randconfig-2000-20261121    clang-22
nios2                 randconfig-2001-20261120    clang-24
nios2                 randconfig-2001-20261121    clang-22
nios2                 randconfig-2200-20261120    gcc-11.5.0 smatch
nios2                 randconfig-2200-20261121    gcc-10.5.0 smatch
nios2                randconfig-r2103-20261120    clang-24   cocci
nios2                randconfig-r2104-20261121    gcc-10.5.0 cocci
nios2                randconfig-r2104-20261121    gcc-16.2.0 cocci
nios2                randconfig-r2105-20261121    gcc-9.5.0  cocci
nios2                randconfig-r2111-20261121    gcc-13.5.0 cocci
nios2                randconfig-r2304-20261120    gcc-9.5.0  sparse
nios2                randconfig-r2305-20261121    clang-21   sparse
nios2                randconfig-r2305-20261121    gcc-8.5.0  sparse
nios2                randconfig-r2306-20261120    clang-24   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261120    gcc-9.5.0
openrisc              randconfig-2000-20261121    gcc-16.2.0
openrisc              randconfig-2001-20261120    gcc-9.5.0
openrisc              randconfig-2001-20261121    gcc-16.2.0
openrisc              randconfig-2002-20261120    gcc-9.5.0
openrisc              randconfig-2002-20261121    gcc-16.2.0
openrisc              randconfig-2200-20261120    gcc-11.5.0 smatch
openrisc              randconfig-2200-20261121    gcc-14.4.0 smatch
openrisc             randconfig-r2102-20261121    gcc-14     cocci
openrisc             randconfig-r2103-20261121    gcc-14     cocci
openrisc             randconfig-r2105-20261121    gcc-9.5.0  cocci
openrisc             randconfig-r2300-20261121    gcc-8.5.0  sparse
openrisc             randconfig-r2303-20261121    gcc-8.5.0  sparse
openrisc             randconfig-r2305-20261120    clang-24   sparse
openrisc             randconfig-r2305-20261120    gcc-8.5.0  sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261122    clang-24
parisc                randconfig-1001-20261122    clang-24
parisc                randconfig-2000-20261120    clang-24
parisc                randconfig-2000-20261121    clang-22
parisc                randconfig-2001-20261120    clang-24
parisc                randconfig-2001-20261121    clang-22
parisc                randconfig-2200-20261120    gcc-8.5.0  smatch
parisc                randconfig-2200-20261121    gcc-16.2.0 smatch
parisc               randconfig-r2101-20261121    gcc-10.5.0 cocci
parisc               randconfig-r2102-20261121    gcc-16.2.0 cocci
parisc               randconfig-r2103-20261121    gcc-16.2.0 cocci
parisc               randconfig-r2108-20261121    gcc-8.5.0  cocci
parisc               randconfig-r2109-20261120    gcc-16.2.0 cocci
parisc               randconfig-r2110-20261121    clang-22   cocci
parisc               randconfig-r2301-20261121    clang-21   sparse
parisc               randconfig-r2303-20261121    clang-17   sparse
parisc               randconfig-r2306-20261121    gcc-11.5.0 sparse
parisc               randconfig-r2306-20261121    gcc-15.3.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                   mpc866_ads_defconfig    clang-17
powerpc               randconfig-1000-20261122    clang-24
powerpc               randconfig-1001-20261122    clang-24
powerpc               randconfig-2000-20261120    clang-24
powerpc               randconfig-2000-20261121    clang-24
powerpc               randconfig-2001-20261120    clang-24
powerpc               randconfig-2001-20261121    clang-24
powerpc               randconfig-2002-20261120    clang-24
powerpc               randconfig-2002-20261121    clang-24
powerpc               randconfig-2200-20261120    clang-17   smatch
powerpc               randconfig-2200-20261121    gcc-11.5.0 smatch
powerpc              randconfig-r2100-20261120    clang-24   cocci
powerpc              randconfig-r2101-20261121    clang-24   cocci
powerpc              randconfig-r2102-20261120    gcc-16.2.0 cocci
powerpc              randconfig-r2104-20261121    gcc-9.5.0  cocci
powerpc              randconfig-r2300-20261120    gcc-9.5.0  sparse
powerpc              randconfig-r2308-20261120    clang-24   sparse
powerpc              randconfig-r2308-20261121    gcc-16.2.0 sparse
powerpc                      sequoia_defconfig    clang-17
powerpc64             randconfig-1000-20261122    clang-24
powerpc64             randconfig-1001-20261122    clang-24
powerpc64             randconfig-2000-20261120    clang-24
powerpc64             randconfig-2000-20261121    clang-24
powerpc64             randconfig-2001-20261120    clang-24
powerpc64             randconfig-2001-20261121    clang-24
powerpc64             randconfig-2002-20261120    clang-24
powerpc64             randconfig-2002-20261121    clang-24
powerpc64             randconfig-2200-20261120    gcc-16.2.0 smatch
powerpc64             randconfig-2200-20261121    gcc-10.5.0 smatch
powerpc64            randconfig-r2100-20261120    clang-24   cocci
powerpc64            randconfig-r2104-20261121    gcc-14     cocci
powerpc64            randconfig-r2109-20261121    gcc-14.4.0 cocci
powerpc64            randconfig-r2303-20261120    gcc-8.5.0  sparse
powerpc64            randconfig-r2306-20261121    gcc-8.5.0  sparse
powerpc64            randconfig-r2307-20261121    gcc-11.5.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261122    gcc-9.5.0
riscv                 randconfig-1001-20261122    gcc-9.5.0
riscv                 randconfig-2000-20261120    clang-24
riscv                 randconfig-2000-20261121    gcc-9.5.0
riscv                 randconfig-2001-20261120    clang-24
riscv                 randconfig-2001-20261121    gcc-9.5.0
riscv                 randconfig-2002-20261120    clang-24
riscv                 randconfig-2002-20261121    gcc-9.5.0
riscv                 randconfig-2003-20261120    clang-24
riscv                 randconfig-2003-20261121    gcc-9.5.0
riscv                 randconfig-2004-20261120    clang-24
riscv                 randconfig-2004-20261121    gcc-9.5.0
riscv                 randconfig-2005-20261120    clang-24
riscv                 randconfig-2005-20261121    gcc-9.5.0
riscv                 randconfig-2200-20261120    gcc-8.5.0  smatch
riscv                 randconfig-2200-20261121    clang-24   smatch
riscv                randconfig-r2102-20261120    clang-24   cocci
riscv                randconfig-r2107-20261121    gcc-13.5.0 cocci
riscv                randconfig-r2107-20261121    gcc-8.5.0  cocci
riscv                randconfig-r2108-20261120    clang-17   cocci
riscv                randconfig-r2310-20261120    clang-24   sparse
riscv                randconfig-r2310-20261121    gcc-8.5.0  sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261122    gcc-9.5.0
s390                  randconfig-1001-20261122    gcc-9.5.0
s390                  randconfig-2000-20261120    clang-24
s390                  randconfig-2000-20261121    clang-22
s390                  randconfig-2001-20261120    clang-24
s390                  randconfig-2001-20261121    clang-22
s390                  randconfig-2002-20261120    clang-24
s390                  randconfig-2002-20261121    clang-22
s390                  randconfig-2003-20261120    clang-24
s390                  randconfig-2003-20261121    clang-22
s390                  randconfig-2004-20261120    clang-24
s390                  randconfig-2004-20261121    clang-22
s390                  randconfig-2005-20261120    clang-24
s390                  randconfig-2005-20261121    clang-22
s390                  randconfig-2200-20261120    clang-17   smatch
s390                  randconfig-2200-20261121    gcc-8.5.0  smatch
s390                 randconfig-r2100-20261121    clang-24   cocci
s390                 randconfig-r2100-20261121    gcc-9.5.0  cocci
s390                 randconfig-r2101-20261121    gcc-9.5.0  cocci
s390                 randconfig-r2102-20261121    clang-24   cocci
s390                 randconfig-r2106-20261121    clang-22   cocci
s390                 randconfig-r2106-20261121    gcc-13.5.0 cocci
s390                 randconfig-r2106-20261121    gcc-14.4.0 cocci
s390                 randconfig-r2306-20261121    gcc-11.5.0 sparse
s390                 randconfig-r2307-20261120    clang-24   sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261122    gcc-9.5.0
sh                    randconfig-1001-20261122    gcc-9.5.0
sh                    randconfig-2000-20261120    gcc-11.5.0
sh                    randconfig-2000-20261121    gcc-16.2.0
sh                    randconfig-2001-20261120    gcc-11.5.0
sh                    randconfig-2001-20261121    gcc-16.2.0
sh                    randconfig-2002-20261120    gcc-11.5.0
sh                    randconfig-2002-20261121    gcc-16.2.0
sh                    randconfig-2003-20261120    gcc-11.5.0
sh                    randconfig-2003-20261121    gcc-16.2.0
sh                    randconfig-2004-20261120    gcc-11.5.0
sh                    randconfig-2004-20261121    gcc-16.2.0
sh                    randconfig-2005-20261120    gcc-11.5.0
sh                    randconfig-2005-20261121    gcc-16.2.0
sh                    randconfig-2200-20261120    gcc-11.5.0 smatch
sh                    randconfig-2200-20261121    gcc-10.5.0 smatch
sh                   randconfig-r2110-20261121    gcc-8.5.0  cocci
sh                   randconfig-r2300-20261121    clang-21   sparse
sh                   randconfig-r2307-20261121    gcc-10.5.0 sparse
sh                   randconfig-r2311-20261120    gcc-8.5.0  sparse
sh                   randconfig-r2311-20261121    gcc-15.3.0 sparse
sh                   randconfig-r2311-20261121    gcc-16.2.0 sparse
sh                      sh7710voipgw_defconfig    clang-17
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261122    clang-24
sparc                 randconfig-1001-20261122    clang-24
sparc                 randconfig-2000-20261120    gcc-8.5.0
sparc                 randconfig-2000-20261121    gcc-8.5.0
sparc                 randconfig-2001-20261120    gcc-8.5.0
sparc                 randconfig-2001-20261121    gcc-8.5.0
sparc                 randconfig-2200-20261120    gcc-11.5.0 smatch
sparc                 randconfig-2200-20261121    gcc-8.5.0  smatch
sparc                randconfig-r2100-20261121    gcc-16.2.0 cocci
sparc                randconfig-r2102-20261121    gcc-9.5.0  cocci
sparc                randconfig-r2107-20261121    gcc-14.4.0 cocci
sparc                randconfig-r2108-20261121    clang-22   cocci
sparc                randconfig-r2300-20261121    clang-17   sparse
sparc                randconfig-r2301-20261121    gcc-8.5.0  sparse
sparc                randconfig-r2302-20261120    gcc-9.5.0  sparse
sparc                randconfig-r2307-20261120    gcc-8.5.0  sparse
sparc                randconfig-r2310-20261121    gcc-10.5.0 sparse
sparc                randconfig-r2310-20261121    gcc-11.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261122    clang-24
sparc64               randconfig-1001-20261122    clang-24
sparc64               randconfig-2000-20261120    gcc-8.5.0
sparc64               randconfig-2000-20261121    gcc-8.5.0
sparc64               randconfig-2001-20261120    gcc-8.5.0
sparc64               randconfig-2001-20261121    gcc-8.5.0
sparc64               randconfig-2200-20261120    gcc-14.4.0 smatch
sparc64               randconfig-2200-20261121    clang-20   smatch
sparc64              randconfig-r2104-20261121    clang-24   cocci
sparc64              randconfig-r2107-20261120    clang-17   cocci
sparc64              randconfig-r2111-20261120    gcc-8.5.0  cocci
sparc64              randconfig-r2307-20261121    gcc-8.5.0  sparse
sparc64              randconfig-r2308-20261121    clang-22   sparse
sparc64              randconfig-r2309-20261121    gcc-15.3.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261122    clang-24
um                    randconfig-1001-20261122    clang-24
um                    randconfig-2000-20261120    gcc-8.5.0
um                    randconfig-2000-20261121    gcc-8.5.0
um                    randconfig-2001-20261120    gcc-8.5.0
um                    randconfig-2001-20261121    gcc-8.5.0
um                    randconfig-2200-20261120    clang-24   smatch
um                    randconfig-2200-20261121    gcc-14     smatch
um                   randconfig-r2104-20261120    gcc-16.2.0 cocci
um                   randconfig-r2104-20261121    gcc-9.5.0  cocci
um                   randconfig-r2105-20261120    clang-24   cocci
um                   randconfig-r2106-20261121    gcc-8.5.0  cocci
um                   randconfig-r2301-20261120    clang-24   sparse
um                   randconfig-r2302-20261121    clang-21   sparse
um                   randconfig-r2303-20261120    clang-24   sparse
um                   randconfig-r2304-20261121    clang-21   sparse
um                   randconfig-r2308-20261121    gcc-11.5.0 sparse
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
x86_64                randconfig-2000-20261120    clang-22
x86_64                randconfig-2000-20261121    gcc-14
x86_64                randconfig-2001-20261120    clang-22
x86_64                randconfig-2001-20261121    gcc-14
x86_64                randconfig-2002-20261120    clang-22
x86_64                randconfig-2002-20261121    gcc-14
x86_64                randconfig-2003-20261120    clang-22
x86_64                randconfig-2003-20261121    gcc-14
x86_64                randconfig-2004-20261120    clang-22
x86_64                randconfig-2004-20261121    gcc-14
x86_64                randconfig-2005-20261120    clang-22
x86_64                randconfig-2005-20261121    gcc-14
x86_64                randconfig-2100-20261120    gcc-14     cocci
x86_64                randconfig-2100-20261121    gcc-14     cocci
x86_64                randconfig-2101-20261120    gcc-14     cocci
x86_64                randconfig-2101-20261121    gcc-14     cocci
x86_64                randconfig-2102-20261120    gcc-14     cocci
x86_64                randconfig-2102-20261121    gcc-14     cocci
x86_64                randconfig-2103-20261120    gcc-14     cocci
x86_64                randconfig-2103-20261121    gcc-14     cocci
x86_64                randconfig-2104-20261120    gcc-14     cocci
x86_64                randconfig-2104-20261121    gcc-14     cocci
x86_64                randconfig-2105-20261120    gcc-14     cocci
x86_64                randconfig-2105-20261121    gcc-14     cocci
x86_64                randconfig-2200-20261120    clang-22   smatch
x86_64                randconfig-2200-20261121    gcc-14     smatch
x86_64                randconfig-2300-20261120    clang-22   sparse
x86_64                randconfig-2300-20261121    gcc-14     sparse
x86_64                randconfig-2301-20261120    clang-22   sparse
x86_64                randconfig-2301-20261121    gcc-14     sparse
x86_64                randconfig-2302-20261120    clang-22   sparse
x86_64                randconfig-2302-20261121    gcc-14     sparse
x86_64               randconfig-r2100-20261120    gcc-16.2.0 cocci
x86_64               randconfig-r2101-20261121    gcc-14     cocci
x86_64               randconfig-r2107-20261121    clang-22   cocci
x86_64               randconfig-r2302-20261121    gcc-16.2.0 sparse
x86_64               randconfig-r2303-20261120    gcc-9.5.0  sparse
x86_64               randconfig-r2305-20261121    gcc-14     sparse
x86_64               randconfig-r2309-20261121    clang-22   sparse
x86_64               randconfig-r2311-20261121    gcc-10.5.0 sparse
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
xtensa                randconfig-2000-20261120    gcc-16.2.0
xtensa                randconfig-2000-20261121    gcc-16.2.0
xtensa                randconfig-2001-20261120    gcc-16.2.0
xtensa                randconfig-2001-20261121    gcc-16.2.0
xtensa                randconfig-2200-20261120    gcc-9.5.0  smatch
xtensa                randconfig-2200-20261121    gcc-12.5.0 smatch
xtensa               randconfig-r2100-20261121    gcc-9.5.0  cocci
xtensa               randconfig-r2105-20261121    gcc-14     cocci
xtensa               randconfig-r2105-20261121    gcc-16.2.0 cocci
xtensa               randconfig-r2107-20261120    gcc-16.2.0 cocci
xtensa               randconfig-r2108-20261121    clang-22   cocci
xtensa               randconfig-r2111-20261121    clang-22   cocci
xtensa               randconfig-r2111-20261121    gcc-8.5.0  cocci
xtensa               randconfig-r2302-20261121    gcc-14     sparse
xtensa               randconfig-r2304-20261120    gcc-8.5.0  sparse
xtensa               randconfig-r2307-20261121    gcc-15.3.0 sparse
xtensa               randconfig-r2308-20261121    gcc-11.5.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
