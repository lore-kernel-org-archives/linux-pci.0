Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F913AE189
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633279; cv=none; b=Wr4ajgz5DQGuSYs2qlal8S997ox85jTzkAOR9MSG4zvMbCbAGQi+dsvTlSegbRjnYgDhPMDjS7qrenNEw+G1WzfdyHHCc/VtY46SN/EXjsSwve072Wuh4CfBvuvUHkL4E8myk4nB1FuABybAOJuk4IZu7YiTAkpoTRhSAEIA3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633279; c=relaxed/simple;
	bh=MgP0bE8RyvDvrp1xUmMjlYyTohNqW80Nf+BduHygBcc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=meg8gJTsExt0KrmwzqRVZ0gxhEtCNW7728TZ8k6B0fkyL7q1jIqAjz2PP/WANGTUi7y44aUpKw9lP0e38rbHbRcK6KMdbo+V2xovEtJnRCwUKHwjw2pXqaaEzaxBKKqk/bp4Mj2NIGWuDRF9a6iwP6Apb0JJutFJCL1ml3X5fZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7Ukh17q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7Ukh17q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772633278; x=1804169278;
  h=date:from:to:cc:subject:message-id;
  bh=MgP0bE8RyvDvrp1xUmMjlYyTohNqW80Nf+BduHygBcc=;
  b=d7Ukh17qTrkiy57A8tz7SIv+QAMmcIZT4cK/+HuNmu3oHnlq7MQG5cAj
   cCTbjvx6pQRP8nAdqqZfWbBMipkDgZ6ZFHLE1I5x7XoTwqV2hBvQXwZjd
   ilNzZNexqjoLr7FhKQtKOFRIqH8yvyM6b2vTankK/LRMVRQc40EQB67m4
   d5C8t2paxNmI7lsiPrlrCn5k4oyC+24XieUJjpC3ZD90UH3cPPM6LXLFy
   e5J/wLydcHTmB8kOJlQYXjPrYNXYfSK+BnLOKvuP/umY8MwQSqCpM1wiM
   FUXtjE6M2ocenubvMrgBp6cUa6F6EJbWZun2qwh2EKqGZKLpOZ4OPEFpD
   Q==;
X-CSE-ConnectionGUID: k3zC55WmQgav6kD9jwiFzQ==
X-CSE-MsgGUID: vJbkuuF7RNKZ9Jq5afOSOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77297674"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="77297674"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 06:07:54 -0800
X-CSE-ConnectionGUID: k+DVmvmQR6WMLl9tXwmYFg==
X-CSE-MsgGUID: 8+kIiWThR3mh32XgxYMIUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="222515530"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 04 Mar 2026 06:07:52 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxmtB-000000003oN-3mJr;
	Wed, 04 Mar 2026 14:07:49 +0000
Date: Wed, 04 Mar 2026 22:07:00 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 147dae12985947cdb9e1918142f06482c5077a81
Message-ID: <202603042252.fL8dpIhM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 147dae12985947cdb9e1918142f06482c5077a81  sparc/PCI: Initialize msi_addr_mask for OF-created PCI devices

elapsed time: 923m

configs tested: 4
configs skipped: 278

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
