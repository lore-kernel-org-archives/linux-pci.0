Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB7546AF15
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565623; cv=none; b=g4PTSJaOMW8B8z3gNmdZb3fLDzM5mFRkn3D8bwmYEykeka02k3A3MAjpBYUBtPdVuceEktLSuk/xjltbg1UNtfoCbe6SWC8WiCwJikBDK56Kcu47Vu3aIbcZDMNznIBF71+zCTxhiasRCUfMRqbKyfwhA8yrXR8l0VvrPZ/A0/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565623; c=relaxed/simple;
	bh=7FxeS7UrdqX2NlSTElB+df65eG4I664/MsabMaXbTjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzI6o45Zeh+svMIV+CQu0oGybX7XNMNkVHx8uMNUXppAeFjv/4UGK9W/d3/CpULtBjlxXzPtdQMVsyqdtnplm5gURnZ1VutXZcSVt4FIZDYxkl93hq+NjIO6z0e5jlNNqSOG6I4EV0CKHYvUQd1CYHfK8SH6o6rrTCRJxeS8RgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSfmxmKT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSfmxmKT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777565621; x=1809101621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7FxeS7UrdqX2NlSTElB+df65eG4I664/MsabMaXbTjs=;
  b=aSfmxmKTTBoVz1tpV7gSnMVsDglJ+1D/RrBwS2nSOD9AKWoj0hfxuSNW
   DDOya6FXSLwv9Q1vEeaU2RYgNkIaRRDAmV+yMsGpiBWYEcDoepDNfKrs2
   Adnooqszhd4qTZC0nxcJYkxqoj5GA85iwc8qTrA0kcVVVvkAs5FibicZC
   zRAurJBQa+OxOdJ2hujz0Szm8FECJ76E5bFXTqLCvTgRCCQsdjxaGhCo4
   1UXXPfBj8lS/uGlIwSRLgSkoHhAeiUm8N9DPSVp08Wvo0hs7Q9/jsOtJ0
   mt/2qJ1kaxQrqp4H/9K8iqC4tzxJB6G+OCm0zhJUSG0Bknwts6Rg60FZ/
   w==;
X-CSE-ConnectionGUID: LS4kgK50SOOScx6xxe5ECw==
X-CSE-MsgGUID: MSCv/OEhRfmOmUBklKsQbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="81100523"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="81100523"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 09:13:40 -0700
X-CSE-ConnectionGUID: AB+03OciRcikVXWgNFwl8Q==
X-CSE-MsgGUID: 60urOWMfSDGaX5pUkGvxkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="238948252"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 30 Apr 2026 09:13:38 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIU1A-000000004r3-08QC;
	Thu, 30 Apr 2026 16:13:36 +0000
Date: Thu, 30 Apr 2026 18:13:03 +0200
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 3/3] PCI: vmd: Replace pci_alloc_irq_vectors() with
 pcim_alloc_irq_vectors()
Message-ID: <202604301846.yNeYYwuL-lkp@intel.com>
References: <1776392767-83668-4-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1776392767-83668-4-git-send-email-shawn.lin@rock-chips.com>

Hi Shawn,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v7.1-rc1 next-20260430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/PCI-MSI-Add-Devres-managed-IRQ-vectors-allocation/20260418-031441
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/1776392767-83668-4-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH v2 3/3] PCI: vmd: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260430/202604301846.yNeYYwuL-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604301846.yNeYYwuL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604301846.yNeYYwuL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/pci/msi/api.c:304 function parameter 'dev' not described in 'pcim_alloc_irq_vectors'
>> Warning: drivers/pci/msi/api.c:304 function parameter 'min_vecs' not described in 'pcim_alloc_irq_vectors'
>> Warning: drivers/pci/msi/api.c:304 function parameter 'max_vecs' not described in 'pcim_alloc_irq_vectors'
>> Warning: drivers/pci/msi/api.c:304 function parameter 'flags' not described in 'pcim_alloc_irq_vectors'
>> Warning: drivers/pci/msi/api.c:317 function parameter 'dev' not described in 'pcim_alloc_irq_vectors_affinity'
>> Warning: drivers/pci/msi/api.c:317 function parameter 'min_vecs' not described in 'pcim_alloc_irq_vectors_affinity'
>> Warning: drivers/pci/msi/api.c:317 function parameter 'max_vecs' not described in 'pcim_alloc_irq_vectors_affinity'
>> Warning: drivers/pci/msi/api.c:317 function parameter 'flags' not described in 'pcim_alloc_irq_vectors_affinity'
>> Warning: drivers/pci/msi/api.c:317 function parameter 'affd' not described in 'pcim_alloc_irq_vectors_affinity'
>> Warning: drivers/pci/msi/api.c:304 function parameter 'dev' not described in 'pcim_alloc_irq_vectors'
>> Warning: drivers/pci/msi/api.c:304 function parameter 'min_vecs' not described in 'pcim_alloc_irq_vectors'
>> Warning: drivers/pci/msi/api.c:304 function parameter 'max_vecs' not described in 'pcim_alloc_irq_vectors'
>> Warning: drivers/pci/msi/api.c:304 function parameter 'flags' not described in 'pcim_alloc_irq_vectors'
>> Warning: drivers/pci/msi/api.c:317 function parameter 'dev' not described in 'pcim_alloc_irq_vectors_affinity'
>> Warning: drivers/pci/msi/api.c:317 function parameter 'min_vecs' not described in 'pcim_alloc_irq_vectors_affinity'
>> Warning: drivers/pci/msi/api.c:317 function parameter 'max_vecs' not described in 'pcim_alloc_irq_vectors_affinity'
>> Warning: drivers/pci/msi/api.c:317 function parameter 'flags' not described in 'pcim_alloc_irq_vectors_affinity'
>> Warning: drivers/pci/msi/api.c:317 function parameter 'affd' not described in 'pcim_alloc_irq_vectors_affinity'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
