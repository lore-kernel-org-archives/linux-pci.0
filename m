Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720FC33D6EB;
	Wed, 21 Jan 2026 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020979; cv=none; b=QLJD8s+Aj2+2/D7NDTzpQ0cfRY4/lugikXPRkdV+DqP708XpK4vhV1C9UUDZBAJ2fZivw8gTSmnL8+8oWerJp0/shf+xLIfArSxZDCt7ho2W9uIEnxr+H8Fb9b7GBJkXiem/+eZw01gLHjkGSQEvGyZTKKjeYXaYAf3IET8ZAcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020979; c=relaxed/simple;
	bh=SAIxoBlDOoJV9Pzj6w6B8xsO3F9D3xHa8AhNUeK8mCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWWum8cspgU8niM2zvOKWaSfX+HAHmbaRPUD/rKcqcMEn7he3SPcf+Y4AnFJqClBJDz6/8oJo0YyZ9LAEd6RPwyvg0/YB1WdE7joiiyKQa6z4qv+agcp+0eYU4qCEESrK98wmVzS2E8IrnABo7GuyvG3KDw63OOXhDBzkHKIdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMYJVTy2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMYJVTy2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769020977; x=1800556977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SAIxoBlDOoJV9Pzj6w6B8xsO3F9D3xHa8AhNUeK8mCA=;
  b=RMYJVTy2Hq2wk+Oie6HuqmFIjqZ75d0xsxFzslEGRxk3lcANOx0n5tJI
   DzvqXg7ptgQ8lC2IHlXsfdB3+WVXnR8SEYeK7EfnbFGxzKY0NLsy/a6Aa
   myGG2JYIUlHMG0C/lN6GWnKPAFc6EcGunKCYIurVF4/XLdSLOr4OpY+V3
   VmFfC2SRBztOmVvMjDBiEWWs4kh4e7Al2CvvNe6m23AgEnS6CXbpQjhkF
   KwKXfvt1cxSRMok4PABZ9j/8JishfvHvxZBeXLByJ80p5nkb0FJ9aPr/T
   FlvqrN2QlMyijBr4HqcVNdZY2hz/jH488IQfZSvqoVn2jWRzs6lJ4nUWU
   Q==;
X-CSE-ConnectionGUID: 9WVkZEmKRtaRc0iMFC6Uxg==
X-CSE-MsgGUID: aTG9LZdgR9O0H8ufIuql8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81364031"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="81364031"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:42:56 -0800
X-CSE-ConnectionGUID: MzkaK09eSn6uxYVivS2AnQ==
X-CSE-MsgGUID: mR4LTis8QiaCwCRka1HW2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="206949929"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 21 Jan 2026 10:42:54 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vidAK-00000000RZZ-0mJp;
	Wed, 21 Jan 2026 18:42:52 +0000
Date: Thu, 22 Jan 2026 02:42:30 +0800
From: kernel test robot <lkp@intel.com>
To: Pragnesh Patel <pragneshp@marvell.com>
Cc: oe-kbuild-all@lists.linux.dev, gcherian@marvell.com,
	Suneel Garapati <sgarapati@marvell.com>,
	Pragnesh Patel <pragneshp@marvell.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: octeon: Add link down handler support for PCIe MAC
 controller
Message-ID: <202601220216.k4L3t8eH-lkp@intel.com>
References: <20260121051439.1882086-1-pragneshp@marvell.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121051439.1882086-1-pragneshp@marvell.com>

Hi Pragnesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/for-linus]
[also build test ERROR on linus/master v6.19-rc6 next-20260120]
[cannot apply to pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pragnesh-Patel/PCI-octeon-Add-link-down-handler-support-for-PCIe-MAC-controller/20260121-131806
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
patch link:    https://lore.kernel.org/r/20260121051439.1882086-1-pragneshp%40marvell.com
patch subject: [PATCH] PCI: octeon: Add link down handler support for PCIe MAC controller
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20260122/202601220216.k4L3t8eH-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260122/202601220216.k4L3t8eH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601220216.k4L3t8eH-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/pci-octeon-pem.c: In function 'pem_recover_rc_link':
   drivers/pci/controller/pci-octeon-pem.c:105:9: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Wimplicit-function-declaration]
     105 |         writeq(0x0, pem->base + RST_SOFT_PERST_OFFSET);
         |         ^~~~~~
         |         writel
   drivers/pci/controller/pci-octeon-pem.c:109:27: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Wimplicit-function-declaration]
     109 |                 pem_reg = readq(pem->base + ON_OFFSET);
         |                           ^~~~~
         |                           readl
>> drivers/pci/controller/pci-octeon-pem.c:130:24: error: 'struct pci_bus' has no member named 'domain_nr'
     130 |                 if (bus->domain_nr == rc_domain)
         |                        ^~


vim +130 drivers/pci/controller/pci-octeon-pem.c

    53	
    54	static void pem_recover_rc_link(struct work_struct *ws)
    55	{
    56		struct pem_ctlr *pem = container_of(ws, struct pem_ctlr,
    57						    recover_rc_work);
    58		struct pci_dev *pem_dev = pem->pdev;
    59		struct pci_dev *root_port;
    60		struct pci_bus *bus;
    61		struct pcie_device *pcie;
    62		struct controller *ctrl;
    63		int rc_domain, timeout = 100;
    64		u64 pem_reg;
    65	
    66		rc_domain = pem->index + DOMAIN_OFFSET;
    67	
    68		root_port = pci_get_domain_bus_and_slot(rc_domain, 0, 0);
    69		if (!root_port) {
    70			dev_err(&pem_dev->dev, "failed to get root port\n");
    71			return;
    72		}
    73	
    74		dev_dbg(&pem_dev->dev, "PEM%d rcvr work\n", pem->index);
    75	
    76		/* Check if HP interrupt thread is in progress
    77		 * and wait for it to complete
    78		 */
    79		pcie = to_pciehp_dev(root_port);
    80		if (!pcie)
    81			return;
    82		ctrl = get_service_data(pcie);
    83		wait_event(ctrl->requester,
    84			   !atomic_read(&ctrl->pending_events) &&
    85			   !ctrl->ist_running);
    86		dev_dbg(&pem_dev->dev, "PEM%d HP ist done\n", pem->index);
    87	
    88		/* Disable hot-plug interrupt
    89		 * Removal and rescan below would setup again.
    90		 */
    91		pcie_disable_interrupt(ctrl);
    92		dev_dbg(&pem_dev->dev, "PEM%d Disable interrupt\n", pem->index);
    93	
    94		pci_lock_rescan_remove();
    95	
    96		pci_walk_bus(root_port->subordinate, pci_dev_set_disconnected, NULL);
    97	
    98		/* Clean-up device and RC bridge */
    99		pci_stop_and_remove_bus_device(root_port);
   100	
   101		pci_unlock_rescan_remove();
   102	
   103		usleep_range(100, 200);
   104	
   105		writeq(0x0, pem->base + RST_SOFT_PERST_OFFSET);
   106	
   107		while (timeout--) {
   108			/* Check for PEM_OOR to be set */
   109			pem_reg = readq(pem->base + ON_OFFSET);
   110			if (pem_reg & BIT(1))
   111				break;
   112			usleep_range(1000, 2000);
   113		}
   114		if (!timeout) {
   115			dev_warn(&pem_dev->dev,
   116				 "PEM failed to get out of reset\n");
   117			return;
   118		}
   119	
   120		pci_lock_rescan_remove();
   121	
   122		/*
   123		 * Hardware resets and initializes config space of RC bridge
   124		 * on every link down event with auto-mode in use.
   125		 * Re-scan will setup RC bridge cleanly in kernel
   126		 * after removal and to be ready for next link-up event.
   127		 */
   128		bus = NULL;
   129		while ((bus = pci_find_next_bus(bus)) != NULL)
 > 130			if (bus->domain_nr == rc_domain)
   131				pci_rescan_bus(bus);
   132		pci_unlock_rescan_remove();
   133		pci_dev_put(root_port);
   134	
   135		/* Ack interrupt */
   136		writeq(RST_INT_LINKDOWN, pem->base + RST_INT_OFFSET);
   137		/* Enable RST_INT[LINKDOWN] interrupt */
   138		writeq(RST_INT_LINKDOWN, pem->base + RST_INT_ENA_W1S_OFFSET);
   139	}
   140	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
