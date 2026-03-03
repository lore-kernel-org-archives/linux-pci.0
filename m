Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EEB3909A3
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540532; cv=none; b=eygfxcJdgkQebjrHNtfH2fPOtWy56X5tgNfxk9TXFgkAoerCtn8RMWzeJ/ix2kxqQ98smmgqHalrKeeyYy5h6bpqFvDYSfFR6kkNKD40zK5mco+CCzC0Kj7Xj3P8dSGMijhY0OFAMuA1ep6d7zp4IwyaJDvLA3a4z2yQD1tIDHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540532; c=relaxed/simple;
	bh=0c9S4vxnG5dAmcLRYUPzYaIsPHzoXbggsCQhdPnZ5t0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PAeObkHdu8TEn1ww2rTT91ouuQkAGl+qCIBizAHhzS90AuoScy01bWjNiRdU/B1TS7auu/0Mj3u0qBLc55SStzWpEcKcuHZGWiaiVSmINkAVXYaRD3R12vf80LV1UJvHzPiOVM0Og13YhQhX/n/dArZ4Hl51rq47VsdybXMl1Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvhwFFZi; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvhwFFZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772540531; x=1804076531;
  h=date:from:to:cc:subject:message-id;
  bh=0c9S4vxnG5dAmcLRYUPzYaIsPHzoXbggsCQhdPnZ5t0=;
  b=kvhwFFZip/KeMaFYvG9rhlOEgOLjAcxAkPHMQB6BxjUqQKfMli7W8jXv
   Z5P9C+pfuNN/HMKbHEmYuJ/ZOYA3G/PqBWqfPunT8HFJfaXISIqZvwcxo
   tmDyddAtwOZWDNE+aaD+OCWB6a4KS7PKHudY+Su0yH2QjPF4vrm1mGt6x
   E4VqRqx6fVaM5MRBhmeC3uXxN3s3I44Q/svHiAGyC2TOqFwc18Q4oOp2e
   d/tIYekaidjnEZMerX8RVfB8d9SG51Qx+Ge0Y4WWRTiTk1Xognzpe1+LT
   rAW6BHky4It+DKNe0V5Kv1UTjyMwF2TyhT+kDT3TCA/yGmKY/TVeOAxQ7
   Q==;
X-CSE-ConnectionGUID: k3GwSH3DRB6yoZckKYJUSQ==
X-CSE-MsgGUID: Z+Q6k+f3TEaL+wbtmncu0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="76174521"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="76174521"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 04:22:10 -0800
X-CSE-ConnectionGUID: B63qZSBrSpCxNwNdgvzzzw==
X-CSE-MsgGUID: v8FclPNERdSkLHybEGt/vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="222140235"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 03 Mar 2026 04:22:10 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxOlK-000000002Cz-3qbX;
	Tue, 03 Mar 2026 12:22:06 +0000
Date: Tue, 03 Mar 2026 20:21:20 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 dc460215b97056f0686c8705118f8d44e5c78a96
Message-ID: <202603032012.nA85tszt-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: dc460215b97056f0686c8705118f8d44e5c78a96  sparc/PCI: Initialize msi_addr_mask for OF-created PCI devices

elapsed time: 771m

configs tested: 4
configs skipped: 51

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
powerpc  allmodconfig    gcc-15.2.0
powerpc   allnoconfig    gcc-15.2.0
sparc     allnoconfig    gcc-15.2.0
sparc64  allmodconfig    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
