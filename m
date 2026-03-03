Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC3E43E494
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537594; cv=none; b=JyjKF/orbsmy5YAVmCYC9ZZpErcq4iVvVfROVKDoTJ1ESGBQXRE3PzUyr08OBAw09PFocd2tRTkeZ6Hl3YQ1wFVxEpLvd9VKMFDQt95M6YFQ/kfAWdoPwgKQ3aatulW6/kvqB3dIIz1ngRMJCjA7kOjgdmlJqeTDWlc8UmWbPFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537594; c=relaxed/simple;
	bh=YhF703JejSHeGWDlsnpoDuz4Ym7czh/WmbFvtBx61Cw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bqureS8EoY+zFsOsKmwwcpra5n4ZXLQuEQkJnbRXO5UuskVbj1Grzwm+P+/CY0X00etHGySG7b6SNhboycijLBWwCW/GaQTRTm4gN6kYAaGq6r/EBaXFey8KTtd2o4trgJH2YF97AhkLN2FWcAV8645NDep82s993mKO3VwOpgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAlDp+rh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAlDp+rh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772537589; x=1804073589;
  h=date:from:to:cc:subject:message-id;
  bh=YhF703JejSHeGWDlsnpoDuz4Ym7czh/WmbFvtBx61Cw=;
  b=dAlDp+rhNFH45HBPjv27L5gnGjAhej0y9ygWY9CdV3yby1MR1kCfi669
   ai/afeQDJ1H5uGI+LDx6iRW45KqRn0vszirNTdmWUDC2uvZsejeN40nkD
   3na6FFPru/JvvJQtdk56f/E55EMFKrkUOapPYjRt4aPmC0sn8oG9nFfp9
   3bPl6I+VSYa4pPqOqRdCf+Omp++YJR3ufzL9B0I88cLk8RMsylEEd1hhm
   zJPWHFNxy/gCIVvnuTTODpr7sWE5Fjjky7fuPmnBJw6VlLLgwjemxgors
   vuQh/+8eFa9hWUUXnBty31Se6rHXhBJ1mxXBc0zMD0N/CtFS08M5yNXn6
   g==;
X-CSE-ConnectionGUID: aNJI9lmTTf+rZ6e+w0GQ1Q==
X-CSE-MsgGUID: rqqoxYUlSl6G31+AqppG/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73479249"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73479249"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 03:33:09 -0800
X-CSE-ConnectionGUID: 5+gPOIHTQIO1J/iwkCHtAw==
X-CSE-MsgGUID: OV2r5X3QTiGifyNw7f0fjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="244843941"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 03 Mar 2026 03:33:06 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxNzr-0000000029H-3fax;
	Tue, 03 Mar 2026 11:33:03 +0000
Date: Tue, 03 Mar 2026 19:32:15 +0800
From: kernel test robot <lkp@intel.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [pci:wip/2603-farhan-s390-err-v10 1/9]
 drivers/pci/slot.c:40:19: warning: result of comparison of constant -1 with
 expression of type 'u16' (aka 'unsigned short') is always false
Message-ID: <202603031955.4B1fQXSq-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2603-farhan-s390-err-v10
head:   d72875f0a4958f51f7196e6fada9357799418a52
commit: 77c0762d2e847cf2e8d6d79e6f88a1c2b1ca4d06 [1/9] PCI: Allow per function PCI slots
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20260303/202603031955.4B1fQXSq-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 9a109fbb6e184ec9bcce10615949f598f4c974a9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260303/202603031955.4B1fQXSq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603031955.4B1fQXSq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/slot.c:40:19: warning: result of comparison of constant -1 with expression of type 'u16' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
      40 |         if (slot->number == -1)
         |             ~~~~~~~~~~~~ ^  ~~
   1 warning generated.


vim +40 drivers/pci/slot.c

    37	
    38	static ssize_t address_read_file(struct pci_slot *slot, char *buf)
    39	{
  > 40		if (slot->number == -1)
    41			return sysfs_emit(buf, "%04x:%02x\n",
    42					  pci_domain_nr(slot->bus),
    43					  slot->bus->number);
    44	
    45		return sysfs_emit(buf, "%04x:%02x:%02x\n",
    46				  pci_domain_nr(slot->bus),
    47				  slot->bus->number,
    48				  slot->number);
    49	}
    50	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
