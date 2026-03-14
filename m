Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2A31716A;
	Sat, 14 Mar 2026 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773507986; cv=none; b=VMBM+iz3JOOHyzlRL8d7/QQOe/NBbKtgRS/RJ8o5+XDE+xZoXj/qfDZxW/gZOFbL+CtsNepKDurp8wZgivlXONwT8RGG3h7Ssuv6navvtNrYWqJ+jFocGh6C5sqhRxCMU9imECg1p3CtxS8mUoq61huKG0smiLky5gKwE+H6hfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773507986; c=relaxed/simple;
	bh=o61DSeEMjd3Rx2eOF6NYIOB4qv6cuF52tyuug927qgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfAuyjW8tXRsbioTi3cJLO/7eE35uwIL8YC+XpvkwNA0tPj9rCdd/lyPltViopqKdWEDk6ArSQjEfHs5VXULEGEqu4rnZWwXwEgl/btK7BqTJLa37HTGqXrupuDYOoOfZaUXMY+kgBUTGKbiuvJbCCOe2XVSbTXSarw01v9QCcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KW+LTp9/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KW+LTp9/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773507985; x=1805043985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o61DSeEMjd3Rx2eOF6NYIOB4qv6cuF52tyuug927qgM=;
  b=KW+LTp9/weydiC9VuITanMwv0cGMcXy54ad0b6PsjFpbP9KLxLAQO41C
   29VYhruMVJ4zIBFVh8zvtEXUKXHaLClihVTlu1c1YtrBGNlBSJpuT1CtC
   AM9gOWHI1dayeZUuX4Ts5nn54ptuIMeH2HRZbJC/jFvCA7CBp6iqVfAoR
   KuYPLbndP2UrCLA9OoiLK/Mo0Nyq2GI+cOkn23bssoIALAB98xjycJpyu
   mRdoqWJM0vRjV11fzo4Bhn9+p3jkLbufo9PzIOelQUPOnzmSrDaLsboYX
   jSHsT2SnLNnEvpRzYt2txlkY8/dFxA6AaCXWReamoEkeFefDxBcTAU2Bg
   A==;
X-CSE-ConnectionGUID: tG6EVBXUQemfu4ffyXR5Fg==
X-CSE-MsgGUID: aOfC6MxoTyG7EE+C5DPJyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="74291604"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="74291604"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 10:06:25 -0700
X-CSE-ConnectionGUID: nTbNDGvJRm6sP+Iqmj0anQ==
X-CSE-MsgGUID: dcRuw723R7KY6RNvKbvdNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="221543532"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa008.jf.intel.com with ESMTP; 14 Mar 2026 10:06:23 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1SRR-000000003pL-0BJ8;
	Sat, 14 Mar 2026 17:06:21 +0000
Date: Sat, 14 Mar 2026 18:05:41 +0100
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Simon Richter <Simon.Richter@hogyros.de>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI/VGA: Move pci_set_vga_state() to vgaarb.c
Message-ID: <202603141825.YjwGEnoa-lkp@intel.com>
References: <20260312224713.1305228-1-bhelgaas@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312224713.1305228-1-bhelgaas@google.com>

Hi Bjorn,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v7.0-rc3 next-20260313]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bjorn-Helgaas/PCI-VGA-Move-pci_set_vga_state-to-vgaarb-c/20260314-150705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260312224713.1305228-1-bhelgaas%40google.com
patch subject: [PATCH v2] PCI/VGA: Move pci_set_vga_state() to vgaarb.c
config: x86_64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260314/202603141825.YjwGEnoa-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260314/202603141825.YjwGEnoa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603141825.YjwGEnoa-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/vgaarb.c: In function 'pci_set_vga_state':
>> drivers/pci/vgaarb.c:229:14: error: implicit declaration of function 'pci_set_vga_state_arch'; did you mean 'pci_set_vga_state'? [-Wimplicit-function-declaration]
     229 |         rc = pci_set_vga_state_arch(dev, decode, command_bits, flags);
         |              ^~~~~~~~~~~~~~~~~~~~~~
         |              pci_set_vga_state


vim +229 drivers/pci/vgaarb.c

   209	
   210	/**
   211	 * pci_set_vga_state - set VGA decode state on device and parents if requested
   212	 * @dev: the PCI device
   213	 * @decode: true = enable decoding, false = disable decoding
   214	 * @command_bits: PCI_COMMAND_IO and/or PCI_COMMAND_MEMORY
   215	 * @flags: traverse ancestors and change bridges
   216	 * CHANGE_BRIDGE_ONLY / CHANGE_BRIDGE
   217	 */
   218	static int pci_set_vga_state(struct pci_dev *dev, bool decode,
   219				     unsigned int command_bits, u32 flags)
   220	{
   221		struct pci_bus *bus;
   222		struct pci_dev *bridge;
   223		u16 cmd;
   224		int rc;
   225	
   226		WARN_ON((flags & PCI_VGA_STATE_CHANGE_DECODES) && (command_bits & ~(PCI_COMMAND_IO|PCI_COMMAND_MEMORY)));
   227	
   228		/* ARCH specific VGA enables */
 > 229		rc = pci_set_vga_state_arch(dev, decode, command_bits, flags);
   230		if (rc)
   231			return rc;
   232	
   233		if (flags & PCI_VGA_STATE_CHANGE_DECODES) {
   234			pci_read_config_word(dev, PCI_COMMAND, &cmd);
   235			if (decode)
   236				cmd |= command_bits;
   237			else
   238				cmd &= ~command_bits;
   239			pci_write_config_word(dev, PCI_COMMAND, cmd);
   240		}
   241	
   242		if (!(flags & PCI_VGA_STATE_CHANGE_BRIDGE))
   243			return 0;
   244	
   245		bus = dev->bus;
   246		while (bus) {
   247			bridge = bus->self;
   248			if (bridge) {
   249				pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
   250						     &cmd);
   251				if (decode)
   252					cmd |= PCI_BRIDGE_CTL_VGA;
   253				else
   254					cmd &= ~PCI_BRIDGE_CTL_VGA;
   255				pci_write_config_word(bridge, PCI_BRIDGE_CONTROL,
   256						      cmd);
   257			}
   258			bus = bus->parent;
   259		}
   260		return 0;
   261	}
   262	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
