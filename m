Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947E3314DB;
	Tue, 27 Jan 2026 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507195; cv=none; b=EtqNfH0YGZjvreumJqUnsBAsPXPi4EoT1q7eO9Hw3/aPgK0j3EbyzkHRH6kcv7c3NeVEN/YJB8iyrYI9Risyx/T0sj6bK5tJ3DwenI3Ows1wXly/zQVLU70cD5xz/8At769xaS80MLJwp2E1VhWXaWZNY/fCttV0WblPcSMbw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507195; c=relaxed/simple;
	bh=bVc+d7DJg5NGklMe1sgBsuB1Uexqh/ghglOhkC5/v+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2quEjCrGRsLrFa/+9NVjiv5pAlhVcZcRf46h+WwA36RN9RIWmlGik53WjC8OiKDmfWKocfGky4mEMBiTiQ1VbO1sawCvKJqMdnNLy6imu7Qhsg4eDmVodyH2oFMtlijYVLMRQgOCFh0PGLgv04NITJLST0EDhEo82NMaO4mdTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKanL/Xz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKanL/Xz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769507193; x=1801043193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bVc+d7DJg5NGklMe1sgBsuB1Uexqh/ghglOhkC5/v+8=;
  b=JKanL/XzKL4g1XOpDtaPunxUO5FBFj8eL3jUxPQow8/L+X3npHOpMTC0
   RtKbp4cKypFsUQV74/YyydHbvu+vqMuyVu6eeKNZVRKxoptPbCWaLM7GT
   M/ftKH/47Z+XddX/eWXGR6mC7BScQN5t+0LzttLi+NbQMb31iwxZXdacH
   vp7jUZ/3SjJ2qAj6KjRMqmtv6AOQwi2vWk6CCjY5DHMX/9fJC+hnTaLld
   Opn9lFNmrJNR4BaRnVN9UE6gNweM7qZE1Yca9fVMTzxrNhVY/c23rRgYM
   xYQCkdMRfBitZEYppePHvUMjKKJnqR3VFqrcFFj/AP6aqXDeSELFPdfpA
   w==;
X-CSE-ConnectionGUID: R378oDPrQ5ed+JlRMd6KGg==
X-CSE-MsgGUID: lyyOzubpQLain36H0cm8EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="96162708"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="96162708"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 01:46:18 -0800
X-CSE-ConnectionGUID: s9Ynv8IYSxiAVB+81W9lhQ==
X-CSE-MsgGUID: MezOwrSOTla5Se/XPBcsBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="245544986"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 Jan 2026 01:46:15 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkfeG-00000000YGJ-0fCH;
	Tue, 27 Jan 2026 09:46:12 +0000
Date: Tue, 27 Jan 2026 17:45:16 +0800
From: kernel test robot <lkp@intel.com>
To: Koichiro Den <den@valinux.co.jp>, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, Frank.Li@nxp.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Add helper to query integrated dw-edma
 register window
Message-ID: <202601271718.STDXKWdE-lkp@intel.com>
References: <20260126071550.3233631-2-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126071550.3233631-2-den@valinux.co.jp>

Hi Koichiro,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.19-rc7 next-20260126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Koichiro-Den/PCI-dwc-Add-helper-to-query-integrated-dw-edma-register-window/20260126-152209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260126071550.3233631-2-den%40valinux.co.jp
patch subject: [PATCH 1/2] PCI: dwc: Add helper to query integrated dw-edma register window
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20260127/202601271718.STDXKWdE-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260127/202601271718.STDXKWdE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601271718.STDXKWdE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-designware.c:1358:7: error: call to undeclared function 'epc_get_drvdata'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1358 |         ep = epc_get_drvdata(epc);
         |              ^
   drivers/pci/controller/dwc/pcie-designware.c:1358:7: note: did you mean 'epf_get_drvdata'?
   include/linux/pci-epf.h:229:21: note: 'epf_get_drvdata' declared here
     229 | static inline void *epf_get_drvdata(struct pci_epf *epf)
         |                     ^
>> drivers/pci/controller/dwc/pcie-designware.c:1358:5: error: incompatible integer to pointer conversion assigning to 'struct dw_pcie_ep *' from 'int' [-Wint-conversion]
    1358 |         ep = epc_get_drvdata(epc);
         |            ^ ~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/epc_get_drvdata +1358 drivers/pci/controller/dwc/pcie-designware.c

  1348	
  1349	int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
  1350					 resource_size_t *sz)
  1351	{
  1352		struct dw_pcie_ep *ep;
  1353		struct dw_pcie *pci;
  1354	
  1355		if (!epc || !phys || !sz)
  1356			return -EINVAL;
  1357	
> 1358		ep = epc_get_drvdata(epc);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
