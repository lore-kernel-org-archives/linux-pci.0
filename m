Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A073D093B
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629567; cv=none; b=mQPHpzro34MmMwM1kTqB8ZDe3M9GKQmz3TFbbJrRNmkWJf12ZifNbL9hnlSjLi3ftftbDhLiH8QczgcQdUWtE3TCvtuVSdHPQm91MW1Y8tf6zdDVtl7NnXKUCOIt0FaY0B1RH9PZU+k5MBGDq1TKiFtng0ExCDkMe8idBBjgDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629567; c=relaxed/simple;
	bh=aHWS/UnnUq7xztHIV7aZMIErzImXOCmV/mEZOu1WNzs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hIh1hBysNi3XOP8WM0K0QJE/3pn27QqVcwXHC+6GJdkh7CcvDDaUPSUn9b2kpTtabaQVjM6cl4RNJ1+MsCpd9gSHqUTRyI+bM6zlxXJIn2Wv/yagOB1QK3ppeZEyYH+mGQm+Q/UQ/M6XXF2ekUZfpvAL5JioI2yc8TFnWIafiEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLfEtiMN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLfEtiMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783629565; x=1815165565;
  h=date:from:to:cc:subject:message-id;
  bh=aHWS/UnnUq7xztHIV7aZMIErzImXOCmV/mEZOu1WNzs=;
  b=bLfEtiMNFUp5ObyX8cxMQQ6Ms1yCFhampZIQkzUGeQX9N1NAgaoZnkgh
   1JBsAK1OddhdstQ6YkaXrVSoHXE5Ql1KCk2n5TaL5RbYLKxnDvBb4Mtg6
   EEcjS8pIz11RpMAwkv/0Z7OA4ezfh+05+QFCpmHr1EgMVUhfLi6KzqwQj
   VbMQSqIJ0LbTt6aJ/iKf241JnkddUJwdG3PLjQl7FCjOvnT/dUnL3aLT1
   RqqxrczBmsbNKRHpOjx2Ij1PUndqqtlPThEsCNABfpBNlspQFyK5NNTCG
   wiI7hw8z8s1HhxYrDAc/BQ9i8i8hqRMjGWuTLgAZn5FNFHiGl9DfSMIx+
   w==;
X-CSE-ConnectionGUID: BkO8JfvRQyyxwygzDscuxQ==
X-CSE-MsgGUID: l1knkVpvST2OF7G1uYRD/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88244190"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88244190"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 13:39:25 -0700
X-CSE-ConnectionGUID: eXER+/CNSeacbuBeNTOdag==
X-CSE-MsgGUID: x9d/58RIRXGKLTDGLPKKuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255341154"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 09 Jul 2026 13:39:22 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whvWh-00000000I6R-202d;
	Thu, 09 Jul 2026 20:39:19 +0000
Date: Fri, 10 Jul 2026 04:38:29 +0800
From: kernel test robot <lkp@intel.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [pci:controller/dwc-rcar-gen4 2/4]
 include/linux/irqchip/arm-gic-v3.h:605:10: fatal error: asm/arch_gicv3.h: No
 such file or directory
Message-ID: <202607100424.xo06gLTB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4
head:   14e8394423ffd4fd28884ec8b4d5ba15be6e7e0d
commit: 8ba5de8db3acd06e35c42ecd0becc38134348df3 [2/4] PCI: rcar-gen4: Configure AXIINTC if iMSI-RX is not used
config: parisc-randconfig-r071-20260709 (https://download.01.org/0day-ci/archive/20260710/202607100424.xo06gLTB-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 16.1.0
smatch: v0.5.0-9185-gbcc58b9c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260710/202607100424.xo06gLTB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607100424.xo06gLTB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/dwc/pcie-rcar-gen4.c:16:
>> include/linux/irqchip/arm-gic-v3.h:605:10: fatal error: asm/arch_gicv3.h: No such file or directory
     605 | #include <asm/arch_gicv3.h>
         |          ^~~~~~~~~~~~~~~~~~
   compilation terminated.


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
