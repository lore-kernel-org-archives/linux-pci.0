Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278BF42050
	for <linux-pci@vger.kernel.org>; Sun, 16 Aug 2026 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838415; cv=none; b=iPn5HjqcyHmssAVknxa57BXxvGOfWDogSfY9PRfrFE4uimGk9W7yZtPaaZZiler7KjySOf/qlNNlLtFGIiKSPvqswkmUeOf0AdyQwwDZkPsKSQgTx4LEB8RBwWKkd4LLqA46iIq9FPwafAFP+rqc1abG4grZFhXheAlGNa2dAI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838415; c=relaxed/simple;
	bh=hpyEYQlphuMGSWtld6HTsvXWcseCl0VZcdBjodTV5rM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dB4rcDNiKmIPwpTBzaNVZ0CfeRZaSlXHMKB2Z/CkY5nX1Q/0DeVHvqSKSUlrXFTJxe8oeQdbShywAOjBazQPN+KdMKV9tI8d+nPnclfiVHTCCQctl8vKGga1fvigbx7/0kTfEoHHQxrFaJ+nN10QYOls4Tri5C91pr/PxnBOMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJHJj6IO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJHJj6IO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786838414; x=1818374414;
  h=date:from:to:cc:subject:message-id;
  bh=hpyEYQlphuMGSWtld6HTsvXWcseCl0VZcdBjodTV5rM=;
  b=AJHJj6IOEqZunmGS8U/ARPdIlYw8ll1frIR/X6fH6phWYUtdFlyaRzP0
   MfO9ISy4DCWs8W5NThsFXMzh1b3X6gPGwArtlA3zvcXqgoocL39ZW8HKX
   AaKYWZ7ZqljP/Vglck2bW5DlZeQufXdziTcOHZyKbsih1XOfKYIMh44FJ
   /s6nNywOS0XjADQqDnnsuYZY8K0tyxWoR983YmM2/uQulKpulRuCmYXLJ
   DmwOkQZiqqPVUpfj929nM4fujEgDvQ/Idg4VEvja12AuKHKPilwXP33/O
   NzEG5FBXaxIuKZrf8jZlmuhK1fAkG9XdrLYvFN33oIGKfTPXDzwbhoKOy
   w==;
X-CSE-ConnectionGUID: a8ZCj3MLTuyTPJKi36dIpg==
X-CSE-MsgGUID: 1cC8IbhKR6eLVEsUu8eLeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="87576550"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="87576550"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 17:00:14 -0700
X-CSE-ConnectionGUID: IM04gtD9RWSCTEUhNpfrOQ==
X-CSE-MsgGUID: 7ajSkqDpTCKHcxXQ/Nox1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="261283511"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 15 Aug 2026 17:00:13 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvOIM-00000000cXK-1l9n;
	Sun, 16 Aug 2026 00:00:10 +0000
Date: Sun, 16 Aug 2026 07:59:18 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/tegra264] BUILD SUCCESS
 d56131f7a401841c09b6611402a8d2e795da3a6b
Message-ID: <202608160705.gHSrmATZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/tegra264
branch HEAD: d56131f7a401841c09b6611402a8d2e795da3a6b  PCI: tegra: Add Tegra264 support

elapsed time: 770m

configs tested: 14
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
alpha           defconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc          allyesconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
i386         allmodconfig    gcc-14
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
parisc       allmodconfig    gcc-16.1.0
parisc       allyesconfig    gcc-16.1.0
parisc          defconfig    gcc-16.1.0
sh              defconfig    gcc-16.1.0
sh      rsk7264_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
