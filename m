Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0440A31E82A
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780978275; cv=none; b=XxoI9J7sx8sc+D9ozPKoE2EQLRd7V+JSRHQQWzP5ELE8zqXoY6pUSuYeRoHsytAtmEXUeWcYvM+7hoZNn8asAs4ZN264AYvFG57/2GPiPUrXIIFwzT85EBe2bnbQG3+WA3m8F4Q0kPUpk6vtBxCIGOjPanszDi8GQPB2zb5HUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780978275; c=relaxed/simple;
	bh=szqA+g6QA0IMF+fOiM0oZOVp0uuLsgP9VtDbQTF/NiQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mXaNJoRvNV2e1Abqr/4GqJp8qLTFluY46Y0fP8f9krK4usecGAiNaRV/Mep/dbVLZrevFnR1uyydiyxK6zY9z7wc2W7eOWPrDv49Ck9u/c2u1VUwS5NCndA+eATpsOorDBfK3KcrqINjsNPnSo2W3bVKFOBOn0x9ziYwgnFN6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atJ6wK4D; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atJ6wK4D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780978275; x=1812514275;
  h=date:from:to:cc:subject:message-id;
  bh=szqA+g6QA0IMF+fOiM0oZOVp0uuLsgP9VtDbQTF/NiQ=;
  b=atJ6wK4DzKkWIvGqIUAqBjylY1SYty4FmmlC66d7QpGRYd/xA6CBLZ9d
   3yzfOW12+q30BShNRcF9FXswb1CVfnl/wbPwB2ZQBzApMH2IdFMgf3BB5
   IkynAHSlRLWrZMZseaQF5b7tcMiUVg0UXAE56+OHkEl40DrkA4xjnh3i+
   OG2shCkp3L6rSdt/vyrC8gIsJzNoHQSo3Y0y4wVIKVeZbJ7C0Hy7nqhIZ
   LyvoD8O5U+e9sCEBEQebUr3XkeEoWIpCnJriEPtadC/g24TVIYIWwdzb6
   U6F2Vah3RFVGgoXwkr/h6PBW2PyuoyNF7VvcObppvlEoO0e6cQrE8azE7
   Q==;
X-CSE-ConnectionGUID: wLipf12KQRaZ5X7inkw3hg==
X-CSE-MsgGUID: XbRMI9NnS5ajSCEaR+TGLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="92052452"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="92052452"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 21:11:14 -0700
X-CSE-ConnectionGUID: eyuZ2sZeTReUfGqcbS/zVQ==
X-CSE-MsgGUID: lebpkxwcRxqmfZZ2S3nf0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="249661540"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Jun 2026 21:11:12 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wWnnx-00000000Jcc-2eUE;
	Tue, 09 Jun 2026 04:11:09 +0000
Date: Tue, 09 Jun 2026 12:10:38 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-qcom] BUILD SUCCESS
 e0779713a1e2f891aeec53e629dbbd33f423c629
Message-ID: <202606091230.6phygugj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-qcom
branch HEAD: e0779713a1e2f891aeec53e629dbbd33f423c629  PCI: qcom: Initialize DWC MSI lock for firmware-managed ECAM hosts

elapsed time: 6164m

configs tested: 55
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    gcc-16.1.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-16.1.0
arm64        allmodconfig    clang-23
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    clang-23
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-20
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    gcc-16.1.0
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-16.1.0
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-23
s390         allmodconfig    clang-23
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-23
um            allnoconfig    clang-16
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
