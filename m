Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756E018FDDE
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277952; cv=none; b=uYYenmkB74g6E/D/pGT7VC+gHd6a/Fyt8Paagi3Jj57qXQvMuF9VQ08hbLnANJ8rsR+yOk60ql3+tyvOTahi/8U+ViwumQ0aZ6GoP8ZLpjbsffNnDAevntB3RK9bp6swfTc9qmcknfs37kbxn30+DPWSFaHX+kO9OzW/twCX4EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277952; c=relaxed/simple;
	bh=vAiNUcu+gkOvWbfiJgP+cqyo7fXScbPZtJNK2a1HxfA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aYQxcuDTDbOvON4b1ClKqLStUfVdMs1jIcd4UORU6ezc82j8HquzPLNRZ/kJkKCMjr0o2v2Flv7/qpAnsjaFj4+BszqMcjSHv07Dm0aeOmPiVz+WAkjN+lE7X1wVxpVbwAzjoTZFEa1vSmajXMCAfBLCYtWo/eSTXYLxbM1Gujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HysU5hIN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HysU5hIN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784277951; x=1815813951;
  h=date:from:to:cc:subject:message-id;
  bh=vAiNUcu+gkOvWbfiJgP+cqyo7fXScbPZtJNK2a1HxfA=;
  b=HysU5hINsKeF21mAtVA7Lsc3B8hoAi/+Cp0yDUGGBv0gE9dIkFGG8bZY
   uXcrB0lmCzfg5j8OlyY3IfnmQbXR7rXfLCGa4/XYnskuxTUh1SK6oLPHk
   8idNHmVnCPNC8WrZiOfaPKUAtk+ZgjyTsKNIOXqK8LRZ7RBEnIAz0ECRg
   ++aWOAe3PWaWxZzEvCMtDfSZopjINFV0rBZEy5B5o4BOtsUM5fTr2QkI4
   IorSwho8Z9Lg58rJAwl+zuhRjPpo0PZMBs/kktsOEIJYFEVbD7XXLhiyc
   iiSVL9OYdzD20OJgDeGayef4RKqWQhzeoay4eSkhHcHtR8FdPWbKnp74j
   g==;
X-CSE-ConnectionGUID: k5xHWpVZQT2r9KezbdJH8A==
X-CSE-MsgGUID: vAT+86tyTZ+TsWKL9xB73A==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="88847348"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="88847348"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:45:50 -0700
X-CSE-ConnectionGUID: QGF8UkBRRuuwZ0AMBLrqZw==
X-CSE-MsgGUID: dKwCyT53R46YGH5UxfQbKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="256815197"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 17 Jul 2026 01:45:49 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkeCY-00000000SaO-2Tqr;
	Fri, 17 Jul 2026 08:45:46 +0000
Date: Fri, 17 Jul 2026 16:45:16 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 41d034327abe154679c927a9efd8744af6f290a1
Message-ID: <202607171602.8Gf9JGYH-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 41d034327abe154679c927a9efd8744af6f290a1  Merge branch 'pci/misc'

elapsed time: 738m

configs tested: 16
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
csky                  allmodconfig    gcc-16.1.0
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
loongarch  randconfig-002-20260717    clang-24
mips               eyeq5_defconfig    gcc-16.1.0
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
sh                       defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
