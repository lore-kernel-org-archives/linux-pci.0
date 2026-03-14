Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474DC3264D4;
	Sat, 14 Mar 2026 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773515909; cv=none; b=tnqMEC3ddGeYWApEK/ENtK66tMCSNIW6gIjQRroUTalNXTMjC/OLhsCSVRA0VzbBeOHvQ7eU/xfhWeOAJ6cCpr6b25uyCIW4qas7ep8I73j2GbA5voYt3pAZBEjg1w1UuhgHMYqhFWzEQZyWZS+/OzFEP74NdZtjrftrZ0NF89k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773515909; c=relaxed/simple;
	bh=ylNrgLGYs6FyNvdWSx2nz7nBY0yLMohSbhzFKOABu9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5yoiHSMEl8prCpN4rc7F51BtBdLLVb16okxe024rYVGJwAhgtiBmDxydorNgX1xfXOjwwKXBPBSwQ0+0T5APGOhZLHsnSIL+cncNDoQrVTwePddrEl23AXNIccI5ldX5HUtu3OiJl7CQQriAJQVcWrcQmhWH/aQ4i6uQObfbNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExVDBroC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExVDBroC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773515906; x=1805051906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ylNrgLGYs6FyNvdWSx2nz7nBY0yLMohSbhzFKOABu9A=;
  b=ExVDBroC/6aYJ8gJ6eKC7IPDcu3JElHs6JblPxjz5HCgHcZJZDwgY5ra
   qYDNglXhZOdrIyyHgJbm9oMWmgR/RhmdW/GLptCn36dRwtvPTE5hEi5AH
   53+BCEn8WVGUdNdsbrxa7fuI/fVJDm1TuEmpPPcjdQ/Q7u0YB5n/P95Wy
   bZNs9rpBvdxS3zzrTHVb1QvtHlb4bCjCZvrrPl+9SOliubpEGRGhCl67y
   IitHRdacd44LebfXZK8xi1Hro80ceYT3jSiYbWvlLCDEyM0NmxK1gLSOQ
   QuPU4BaSGnDm8E5mbjSjceDlOBFUskl3QpcTpVlHDeLqMscqZt2By32BM
   w==;
X-CSE-ConnectionGUID: jTjkhr7mRwOATNYr9MDb5w==
X-CSE-MsgGUID: 1aXA7T0wSMKosgQsz7SxLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="92159373"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="92159373"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 12:18:25 -0700
X-CSE-ConnectionGUID: WqONoNejSqSKPGmuWAFL7Q==
X-CSE-MsgGUID: yKGVWQrGTmWHc+cuJzCJEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="246532064"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 14 Mar 2026 12:18:24 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1UVB-000000003q1-2naQ;
	Sat, 14 Mar 2026 19:18:21 +0000
Date: Sat, 14 Mar 2026 20:17:32 +0100
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Simon Richter <Simon.Richter@hogyros.de>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI/VGA: Move pci_set_vga_state() to vgaarb.c
Message-ID: <202603142059.lRB5ARkv-lkp@intel.com>
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
[also build test ERROR on pci/for-linus next-20260313]
[cannot apply to linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bjorn-Helgaas/PCI-VGA-Move-pci_set_vga_state-to-vgaarb-c/20260314-150705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260312224713.1305228-1-bhelgaas%40google.com
patch subject: [PATCH v2] PCI/VGA: Move pci_set_vga_state() to vgaarb.c
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260314/202603142059.lRB5ARkv-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260314/202603142059.lRB5ARkv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603142059.lRB5ARkv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/vgaarb.c:229:7: error: call to undeclared function 'pci_set_vga_state_arch'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     229 |         rc = pci_set_vga_state_arch(dev, decode, command_bits, flags);
         |              ^
   drivers/pci/vgaarb.c:229:7: note: did you mean 'pci_set_vga_state'?
   drivers/pci/vgaarb.c:218:12: note: 'pci_set_vga_state' declared here
     218 | static int pci_set_vga_state(struct pci_dev *dev, bool decode,
         |            ^
     219 |                              unsigned int command_bits, u32 flags)
     220 | {
     221 |         struct pci_bus *bus;
     222 |         struct pci_dev *bridge;
     223 |         u16 cmd;
     224 |         int rc;
     225 | 
     226 |         WARN_ON((flags & PCI_VGA_STATE_CHANGE_DECODES) && (command_bits & ~(PCI_COMMAND_IO|PCI_COMMAND_MEMORY)));
     227 | 
     228 |         /* ARCH specific VGA enables */
     229 |         rc = pci_set_vga_state_arch(dev, decode, command_bits, flags);
         |              ~~~~~~~~~~~~~~~~~~~~~~
         |              pci_set_vga_state
   1 error generated.


vim +/pci_set_vga_state_arch +229 drivers/pci/vgaarb.c

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
