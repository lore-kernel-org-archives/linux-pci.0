Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93C18DB1F
	for <linux-pci@vger.kernel.org>; Sat,  8 Aug 2026 05:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786165339; cv=none; b=DU3v8k9JOZomrv4M0lYLVfU9iTV/R5dKkOYZc7NYnnofpsk7Py3AJrMhzaRDx/pFPxhjK6QcH9TRHGu8Ns7M3cC7HO6G7KmkiFZXNj3+lsjhOuiG6vOi8Zkinub75AKNc5SSKMQxkeInhsQdq2GhI6R79+eiQL8603SwxOVUm/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786165339; c=relaxed/simple;
	bh=HUMnA10ZMY2fJuZENI75Z7c6Eq3KuAWfqDrf+nbWuVs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iwAMz+u+JZPxwrWk1gCJphYYL5w+3EwhWY6VZBgyFO5Zxdqo7101pMQAt950z8mTNtZEpH6lSlTqNUg/85lot8rOjHAAFht3G9zumyqJKNDfes8MlnkXMV25SADAOS4xp1lch2kfn9Lml8uApcH/QLj+/WaFoI7RnbINtAJWb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXSFd1op; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXSFd1op"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786165338; x=1817701338;
  h=date:from:to:cc:subject:message-id;
  bh=HUMnA10ZMY2fJuZENI75Z7c6Eq3KuAWfqDrf+nbWuVs=;
  b=IXSFd1op25100WFkEyPN21WKxYvxuPUJ+pdNpjA9Edm5oCKZCC/+ugAT
   wbmH40ab4XBwmpSg9Y8sQo5VU5GLlMjp+yP8G8NfEMhG5juUYjj1LrnYz
   W8OIBDJIx1OVZpgsDAHuCQhy82KiRanW/DKhGK3RpIYpvYOYI6uN7FvRz
   ms5hqc5UwSu8kqMjqyulkjPl5WWbT5CFfFjM6FQq3JgqgRnVBeUzsUPWC
   2/f0Di9vMCqTvK09sMnOJdHmSIUjFV4cDjZelmOlMXH6xM+K4rPtzlfCi
   eQWf1OHuylhutzxR9o2Gkf0wlL3bdZZlbPAOsE5NzInQxvx0yhKzEuaIT
   g==;
X-CSE-ConnectionGUID: pMef6itNSHSQTM4AZX8oIg==
X-CSE-MsgGUID: JkNzQxgPRoqHqCwe7WKM6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="89297583"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="89297583"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 22:02:17 -0700
X-CSE-ConnectionGUID: tXKd4N54QeOfoj3MADAOCg==
X-CSE-MsgGUID: Wzmh7mcISMibmAQrTNKrVA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 07 Aug 2026 22:02:16 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wsZCI-00000000JlL-13pn;
	Sat, 08 Aug 2026 05:02:14 +0000
Date: Sat, 08 Aug 2026 13:01:47 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-ultrarisc] BUILD SUCCESS
 30f22cc3ca904597193029929760186cf16033fe
Message-ID: <202608081333.8Phka6yF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-ultrarisc
branch HEAD: 30f22cc3ca904597193029929760186cf16033fe  PCI: ultrarisc: Use module_platform_driver()

elapsed time: 813m

configs tested: 15
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha             allnoconfig    gcc-16.1.0
alpha            allyesconfig    gcc-16.1.0
alpha               defconfig    gcc-16.1.0
arc              allmodconfig    gcc-16.1.0
arc              allyesconfig    gcc-16.1.0
csky             allmodconfig    gcc-16.1.0
i386             allmodconfig    gcc-14
loongarch           defconfig    clang-24
mips       rbtx49xx_defconfig    gcc-16.1.0
nios2            allmodconfig    gcc-11.5.0
nios2             allnoconfig    gcc-11.5.0
parisc           allmodconfig    gcc-16.1.0
parisc           allyesconfig    gcc-16.1.0
parisc              defconfig    gcc-16.1.0
sh                  defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
