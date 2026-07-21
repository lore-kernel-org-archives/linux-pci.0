Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4973AF643
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784676709; cv=none; b=ZqCczkfbYfWmvF0osB1/O8yBzoDDhw5JQcseKJQCvIaQFvBX2f/wo0c/cnvHqCyMJCXtcGR7M+voQ8dPpBzzGCUcD2iLhoI1mN5JfnXdS1ZZDa4kaiYcsWq+tmKVE+YyqX1LL+lx/SeweOV7mfbWE0HGLMJxD1YrFMx3mH1ztLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784676709; c=relaxed/simple;
	bh=/uquKTW+XF2qIeZtAiEuvupDVemMzwQNQiddg6mgSos=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sPuhUw0r/PnicRz9pgHBD28QOtdeoBUTrW+KQKPl+NtQeCj45e551kJTSKshCAb3N2gNQq+QijGXfA0V3wymd5oqZC3kha+b+3rdPqr/h/ylqDcXV4Z3dIE/QqZ1+FuQdchMnHp0rotF4D3ZsJURaX/VqP9G67YAb29YrWQeRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJR7l5k5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJR7l5k5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784676708; x=1816212708;
  h=date:from:to:cc:subject:message-id;
  bh=/uquKTW+XF2qIeZtAiEuvupDVemMzwQNQiddg6mgSos=;
  b=jJR7l5k5TVdyfbJJuZY8LFOV3HFH2TB2E/CYE2ua4SkdJLhplbUAsR0i
   AOwc2MQjWdRAvGU9m6Vqr00ZmscgbeQ0vV4xgMkd9rP4Vo1jXA9IAigAV
   YWk8bzkWwq/KfIfebFuGqvBXoTzgMQYMSVoc247238Zuz67e/J+5dCdsG
   gGokjq0JFQL8VSVc92vSCA3WSWDUn9s349jyLTXxu4d4syH2WgJO3GlQg
   yLtDPMcXOJ6qfIaVU9IPGxGJLCMpknzXafQlV4g+XbWMzJmZ09xAMbPH2
   mgWrg7hfVx36A8k4x7c8RYpE9rAaENbIEFu4gS/dRFoxO6X9Zx7bqOqwH
   A==;
X-CSE-ConnectionGUID: 1dPPlM9ySieIb8ESHdd3Fg==
X-CSE-MsgGUID: YHZpOK1CTC6tNf8MyLD7Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85336339"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85336339"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 16:31:47 -0700
X-CSE-ConnectionGUID: iFgEaPgZSS6pzHU2/YCAqA==
X-CSE-MsgGUID: DjqdF9KBTV+CBejK6nBpPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="253541047"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 21 Jul 2026 16:31:47 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wmJw7-00000000YAV-3eab;
	Tue, 21 Jul 2026 23:31:43 +0000
Date: Wed, 22 Jul 2026 07:31:04 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 b4bee12ebeccfcd5959ace2c3a4af08f5a917d4c
Message-ID: <202607220736.oLDgVqFL-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: b4bee12ebeccfcd5959ace2c3a4af08f5a917d4c  PCI: imx6: Keep i.MX6 Root Port MSI/MSI-X Capabilities with iMSI-RX to work around hardware bug

elapsed time: 6077m

configs tested: 15
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allnoconfig    gcc-16.1.0
alpha       allyesconfig    gcc-16.1.0
alpha          defconfig    gcc-16.1.0
arc         allmodconfig    gcc-16.1.0
arc         allyesconfig    gcc-16.1.0
arm     ep93xx_defconfig    clang-24
csky        allmodconfig    gcc-16.1.0
i386        allmodconfig    gcc-14
nios2       allmodconfig    gcc-11.5.0
nios2        allnoconfig    gcc-11.5.0
parisc      allmodconfig    gcc-16.1.0
parisc      allyesconfig    gcc-16.1.0
parisc         defconfig    gcc-16.1.0
sh             defconfig    gcc-16.1.0
x86_64      rhel-9.4-bpf    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
