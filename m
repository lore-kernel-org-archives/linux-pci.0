Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02D4499A5
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625500; cv=none; b=HD/9BceqHJpB9Cj05TizJSfp1utW7xGP2Ky6x2oDamSSGPI+2DJp4h+XDEB41kKw7izaNXC2PQIuei3ZD4+0QOB0mzWordoI7bTGWjnhqYkJp+SvqfUUhS4Scnw7FlYSExcMFoSqmERYcuo6qsLdPhdRv7iv10SKu3VWUGH77Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625500; c=relaxed/simple;
	bh=L5CoP8yusF9KIeHRrb3K86HEZZ8vdDEVQP5WRkGK4Yo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hfRpmuepoTV5+eJjUqp9Y6drq+5FD7JexjtrtHVzU+1OwHqChyaEFrkSNrT1YC4nkXDZWDRlv8rlNBJctpTWBTcnWEFVjohGQSAATnTi0nnXqHI0IDCgnyzzou0A8XXHhtkqmEgzs33vFnyQbrYnCVoH1ozp6MD41ygS4tZiY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMIxnt6m; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMIxnt6m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783625498; x=1815161498;
  h=date:from:to:cc:subject:message-id;
  bh=L5CoP8yusF9KIeHRrb3K86HEZZ8vdDEVQP5WRkGK4Yo=;
  b=AMIxnt6mG5U6mdUhGjA2dCK8XABsT9Arz9zIN4vZPvQNrseYBJfkNpev
   LOZ4somQ631MQY0Y/++3N9Wq/jYUuW8rnPNffqawyP7P6OYkHXAs9m4cm
   APNYa5mYZq55X1zKIWp+EFxx+2eVq7fwwIbKnhnm9EsqphEJ8J5qqEmGC
   38o/w2B/7c8wnOcUUxZsMhzP3DAlZYAZtxoNNFbekJVSFVWt9d8C0NcCY
   64VSJxvryyGlKWcaHSjBfAEu2IfXGib0MKLBL/rzbYUpPWM4rDRst3+N+
   L/h3SbQNZJ4zL+XyPFl5wPnIlpBlQz8yPrBrc04fj+amjTBNzZlDA+mgf
   A==;
X-CSE-ConnectionGUID: rCCTZ+BmT2aiemV+QQ4CGA==
X-CSE-MsgGUID: X51UZEkVSRiFl/ZlEMhYXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84375074"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84375074"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 12:31:37 -0700
X-CSE-ConnectionGUID: /7S5b7WJSdCEC5QOE0eXdw==
X-CSE-MsgGUID: ffBtbDbaTm6BHeFMWF7YLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="277910107"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 09 Jul 2026 12:31:35 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whuT5-00000000I2z-3ito;
	Thu, 09 Jul 2026 19:31:31 +0000
Date: Fri, 10 Jul 2026 03:30:47 +0800
From: kernel test robot <lkp@intel.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [pci:controller/dwc-rcar-gen4 2/4]
 include/linux/irqchip/arm-gic-v3.h:605:10: fatal error: 'asm/arch_gicv3.h'
 file not found
Message-ID: <202607100310.iQw5m9Uo-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4
head:   14e8394423ffd4fd28884ec8b4d5ba15be6e7e0d
commit: 8ba5de8db3acd06e35c42ecd0becc38134348df3 [2/4] PCI: rcar-gen4: Configure AXIINTC if iMSI-RX is not used
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260710/202607100310.iQw5m9Uo-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260710/202607100310.iQw5m9Uo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607100310.iQw5m9Uo-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/dwc/pcie-rcar-gen4.c:16:
>> include/linux/irqchip/arm-gic-v3.h:605:10: fatal error: 'asm/arch_gicv3.h' file not found
     605 | #include <asm/arch_gicv3.h>
         |          ^~~~~~~~~~~~~~~~~~
   1 error generated.


vim +605 include/linux/irqchip/arm-gic-v3.h

7e5802781c3e109 Andre Przywara        2014-11-12  604  
7936e914f7b0827 Jean-Philippe Brucker 2015-10-01 @605  #include <asm/arch_gicv3.h>
021f653791ad17e Marc Zyngier          2014-06-30  606  

:::::: The code at line 605 was first introduced by commit
:::::: 7936e914f7b0827c2dcfe63fbefdc21de2d61dcb irqchip/gic-v3: Refactor the arm64 specific parts

:::::: TO: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
:::::: CC: Marc Zyngier <marc.zyngier@arm.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
