Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB093F1ABF
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910589; cv=none; b=hJLSSoAVrDw3bKlG36GnTf1rpRMWNuwTIcevskKssLMlFRYXXrRTLZQCDo/MHEwN1ztQpW/Pwn2EsU42lhvs0e/dTwPUtflRdz2DDdNRxf0TOyntjd1CDsbINKFZ+aF0dh/+eur6ItoUkrNbCSaPww1JCnU+dWnqJiyx2VRnjdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910589; c=relaxed/simple;
	bh=E9lkvK6JVHDyf9CsdpdAYjF8Zj+80R9xZDs7n/1hsjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqW1sen2xZ/p74Czddm6R9VmQ2Dd6GI5zwAtfq7FSrIllHUxCpBzJcB12lOcRxYJxD9cZMS9/VwHryrJb8AhLwcXLDKsJiQK088vYJbvTTIsdDBWVEMOZ8gtfYLYh7MKpHL9BEO/hUJuGoqTIxYLNUQlQZ8tyzLQOzKLQipKGI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWNULJrG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWNULJrG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787910583; x=1819446583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E9lkvK6JVHDyf9CsdpdAYjF8Zj+80R9xZDs7n/1hsjs=;
  b=cWNULJrG69arv1JGxKzzS0x9KW4Go7xSiGK7XdNN898/U71KRkHnbxEK
   0IRpTxOHHzsWjIBdIEjcbjRBzqEQC6lX/jQAEecz4m0hVYK738y6ECaKb
   4eSmxvH00dD7zXBoDJv8aEUhjbG36t3yDONaBvuBiE3KPD/h7NxRLcuKQ
   rl2DeYsIy1/dTvT2ADSAs33jkkbbQHteMNzd4qQIYEPVYjKtTxJvfsjf0
   CNbLjLZ8+HyaN+0BjceXVc984YKi/1Ly5QyrF1rJ8Oj/gRSfvi0FZsB2B
   t9D6atvf1nI9mNUJ8sU1OTb5NQFAcY1rU4EqmpZaSBw0dDAn6Kr8dX2Ej
   Q==;
X-CSE-ConnectionGUID: rZchJ8TwQRq28r2VPNHygA==
X-CSE-MsgGUID: hRirRTTWTKiyxR/kB0vP/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="87360951"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="87360951"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 02:49:39 -0700
X-CSE-ConnectionGUID: uCLi9JCNSEW7nXJKgHL2bQ==
X-CSE-MsgGUID: ULTzFYNqSTGmJdfvzRaD6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="267516480"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 28 Aug 2026 02:49:37 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wztDI-00000000All-22ir;
	Fri, 28 Aug 2026 09:49:33 +0000
Date: Fri, 28 Aug 2026 17:49:02 +0800
From: kernel test robot <lkp@intel.com>
To: Geramy Loveless <gloveless@jqluv.com>, linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bhelgaas@google.com,
	alexander.deucher@amd.com, ilpo.jarvinen@linux.intel.com,
	christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
	mario.limonciello@amd.com, nra3088@gmail.com, gloveless@jqluv.com
Subject: Re: How to correctly reserve prefetchable bridge windows for large,
 resizable BARs behind PCIe switches (8x GPU, PEX890xx) - seeking guidance on
 upstreamable approach.
Message-ID: <202608281725.lCnQu9B3-lkp@intel.com>
References: <a2292dfb-2ee5-4988-ac67-c75dd3e97a4c@jqluv.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2292dfb-2ee5-4988-ac67-c75dd3e97a4c@jqluv.com>

Hi Geramy,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master next-20260826]
[cannot apply to drm-misc/drm-misc-next v7.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geramy-Loveless/How-to-correctly-reserve-prefetchable-bridge-windows-for-large-resizable-BARs-behind-PCIe-switches-8x-GPU-PEX890xx-seeki/20260826-132218
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/a2292dfb-2ee5-4988-ac67-c75dd3e97a4c%40jqluv.com
patch subject: How to correctly reserve prefetchable bridge windows for large, resizable BARs behind PCIe switches (8x GPU, PEX890xx) - seeking guidance on upstreamable approach.
config: arm-randconfig-r072-20260827 (https://download.01.org/0day-ci/archive/20260828/202608281725.lCnQu9B3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260828/202608281725.lCnQu9B3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608281725.lCnQu9B3-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/pci/setup-res.o: in function `pcibios_align_resource':
>> drivers/pci/setup-res.c:289: undefined reference to `__aeabi_uldivmod'
>> arm-linux-gnueabi-ld: drivers/pci/setup-res.c:289: undefined reference to `__aeabi_uldivmod'
   arm-linux-gnueabi-ld: drivers/pci/setup-res.o: in function `pci_align_resource':
>> drivers/pci/setup-res.c:289: undefined reference to `__aeabi_uldivmod'
>> arm-linux-gnueabi-ld: drivers/pci/setup-res.c:289: undefined reference to `__aeabi_uldivmod'


vim +289 drivers/pci/setup-res.c

   262	
   263	/*
   264	 * For mem bridge windows, try to relocate tail remainder space to space
   265	 * before res->start if there's enough free space there. This enables
   266	 * tighter packing for resources.
   267	 */
   268	resource_size_t pci_align_resource(struct pci_dev *dev,
   269					   const struct resource *res,
   270					   const struct resource *empty_res,
   271					   resource_size_t size,
   272					   resource_size_t align)
   273	{
   274		resource_size_t remainder, start_addr;
   275	
   276		if (!(res->flags & IORESOURCE_MEM))
   277			return res->start;
   278	
   279		if (IS_ALIGNED(size, align))
   280			return res->start;
   281	
   282		remainder = size - ALIGN_DOWN(size, align);
   283		/*
   284		 * A window holding several align-sized resources has one tail per
   285		 * resource, but only the lowest can tuck below the first aligned
   286		 * boundary; the rest sit above it. Relocate a single tail's worth.
   287		 */
   288		if (ALIGN_DOWN(size, align) > align)
 > 289			remainder /= ALIGN_DOWN(size, align) / align;
   290		/* Don't mess with size that doesn't align with window size granularity */
   291		if (!IS_ALIGNED(remainder, pci_min_window_alignment(dev->bus, res->flags)))
   292			return res->start;
   293		/* Try to place remainder that doesn't fill align before */
   294		if (res->start < remainder)
   295			return res->start;
   296		start_addr = res->start - remainder;
   297		if (empty_res->start > start_addr)
   298			return res->start;
   299	
   300		pci_dbg(dev, "%pR: moving candidate start address below align to %llx\n",
   301			res, (unsigned long long)start_addr);
   302		return start_addr;
   303	}
   304	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
