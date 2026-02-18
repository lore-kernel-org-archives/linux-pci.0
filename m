Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA45306D40
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 05:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771394381; cv=none; b=ofhXzSlxwoGeIPxxYI6/LuyuvoXUWw4czCMLz8bETmwlJ4phwRIFilL38lsQTW0oVcqGd9MrMGx6ZImBksnyO8V5+d+jNruVPsvF3CJzW8hdMMhJCUMSpw/jVdLvp9nwlDn55M/3YH00743jTzLPzPZ97PZQNymEHa6FDNO5NZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771394381; c=relaxed/simple;
	bh=DLItL20ZbEHuUuPcnGLdYf8yVxg7xkjOqr1FMwt1L3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s69le79hPBobMFFx89bcTx4eNmCn2zrca2m4+kA399B9Y/CBdP+hho2TBVoucnpEWiSTiVNSlrd76xEw6QnD7V7CD7smsDYNm/+BEA0NLH0gDE6LRgvkQsLqc0eGXiJoBjwZCsd5Swe9B81XRYBRBw6di3dL/SmkspKG/v3+kE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiHAYhz/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiHAYhz/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771394380; x=1802930380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DLItL20ZbEHuUuPcnGLdYf8yVxg7xkjOqr1FMwt1L3Y=;
  b=YiHAYhz/wDVxBXkXPTD6zG/kPVrEsInlzvjOEo2DaBeq+wax+AXETXw9
   kK9SNXjV1ioN/XzSy4RKw1TB3z4XJu02WhqG/E1qW0ZvTqrHfLL4QJmWj
   G/XLL3fPEEa9ZCPYGwpa9EvDb8+APXdMClmXq5z82JYUrtdZ/JC+NSvvs
   yyVDPiftdaKsZNdtYpzzu+LLzOgCwX+0dGa1fkc+vVZkJIyeGxYvuiHTV
   WUlVlqDE0WOchMQTFl/AEzZd1g9usjoBqnZ3TIryw9qTLox2FGfhug++q
   OnwU7vwZvn1AhkEHw6fdVtWiBAtn5vYOEk2tDV02VtjzXMkdAlQ3X7ygj
   w==;
X-CSE-ConnectionGUID: GXcT8JYNSu+gxq2x8Q5Bsg==
X-CSE-MsgGUID: kZow7HSfSuabTfgr3uVKlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72515354"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="72515354"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 21:59:39 -0800
X-CSE-ConnectionGUID: vDiaKcdXSNSrTvLxUt+5Yg==
X-CSE-MsgGUID: R0Aq4GcxSZGgIIjI/Oqtvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="214211115"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Feb 2026 21:59:37 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsab1-0000000126m-08zs;
	Wed, 18 Feb 2026 05:59:35 +0000
Date: Wed, 18 Feb 2026 13:59:27 +0800
From: kernel test robot <lkp@intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>, linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [PATCH 3/5] vgaarb: mark vga_get family as __must_check
Message-ID: <202602181332.NDKD0g1P-lkp@intel.com>
References: <20260217170419.236739-4-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260217170419.236739-4-Simon.Richter@hogyros.de>

Hi Simon,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9702969978695d9a699a1f34771580cdbb153b33]

url:    https://github.com/intel-lab-lkp/linux/commits/Simon-Richter/vgaarb-pass-vga_get-errors-to-userspace/20260218-010647
base:   9702969978695d9a699a1f34771580cdbb153b33
patch link:    https://lore.kernel.org/r/20260217170419.236739-4-Simon.Richter%40hogyros.de
patch subject: [PATCH 3/5] vgaarb: mark vga_get family as __must_check
config: i386-randconfig-141-20260218 (https://download.01.org/0day-ci/archive/20260218/202602181332.NDKD0g1P-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260218/202602181332.NDKD0g1P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602181332.NDKD0g1P-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/i915/display/intel_vga.c:68:2: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
      68 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
         |         ^~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_vga.c:93:2: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
      93 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
         |         ^~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +/warn_unused_result +68 drivers/gpu/drm/i915/display/intel_vga.c

0c80d60ae63461 Ville Syrjälä 2025-04-17  43  
4fb8783165b7c6 Jani Nikula   2019-10-01  44  /* Disable the VGA plane that we never use */
4b6e05c43b7542 Ville Syrjälä 2024-09-06  45  void intel_vga_disable(struct intel_display *display)
4fb8783165b7c6 Jani Nikula   2019-10-01  46  {
4b6e05c43b7542 Ville Syrjälä 2024-09-06  47  	struct pci_dev *pdev = to_pci_dev(display->drm->dev);
4b6e05c43b7542 Ville Syrjälä 2024-09-06  48  	i915_reg_t vga_reg = intel_vga_cntrl_reg(display);
0c80d60ae63461 Ville Syrjälä 2025-04-17  49  	enum pipe pipe;
0c80d60ae63461 Ville Syrjälä 2025-04-17  50  	u32 tmp;
4fb8783165b7c6 Jani Nikula   2019-10-01  51  	u8 sr1;
4fb8783165b7c6 Jani Nikula   2019-10-01  52  
0c80d60ae63461 Ville Syrjälä 2025-04-17  53  	tmp = intel_de_read(display, vga_reg);
0c80d60ae63461 Ville Syrjälä 2025-04-17  54  	if (tmp & VGA_DISP_DISABLE)
a3af0140663dc3 Emil Velikov  2021-06-04  55  		return;
a3af0140663dc3 Emil Velikov  2021-06-04  56  
0c80d60ae63461 Ville Syrjälä 2025-04-17  57  	if (display->platform.cherryview)
0c80d60ae63461 Ville Syrjälä 2025-04-17  58  		pipe = REG_FIELD_GET(VGA_PIPE_SEL_MASK_CHV, tmp);
0c80d60ae63461 Ville Syrjälä 2025-04-17  59  	else if (has_vga_pipe_sel(display))
0c80d60ae63461 Ville Syrjälä 2025-04-17  60  		pipe = REG_FIELD_GET(VGA_PIPE_SEL_MASK, tmp);
0c80d60ae63461 Ville Syrjälä 2025-04-17  61  	else
0c80d60ae63461 Ville Syrjälä 2025-04-17  62  		pipe = PIPE_A;
0c80d60ae63461 Ville Syrjälä 2025-04-17  63  
0c80d60ae63461 Ville Syrjälä 2025-04-17  64  	drm_dbg_kms(display->drm, "Disabling VGA plane on pipe %c\n",
0c80d60ae63461 Ville Syrjälä 2025-04-17  65  		    pipe_name(pipe));
0c80d60ae63461 Ville Syrjälä 2025-04-17  66  
4fb8783165b7c6 Jani Nikula   2019-10-01  67  	/* WaEnableVGAAccessThroughIOPort:ctg,elk,ilk,snb,ivb,vlv,hsw */
4fb8783165b7c6 Jani Nikula   2019-10-01 @68  	vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
f0bb41fad02e03 Jani Nikula   2022-02-02  69  	outb(0x01, VGA_SEQ_I);
f0bb41fad02e03 Jani Nikula   2022-02-02  70  	sr1 = inb(VGA_SEQ_D);
f0bb41fad02e03 Jani Nikula   2022-02-02  71  	outb(sr1 | VGA_SR01_SCREEN_OFF, VGA_SEQ_D);
4fb8783165b7c6 Jani Nikula   2019-10-01  72  	vga_put(pdev, VGA_RSRC_LEGACY_IO);
4fb8783165b7c6 Jani Nikula   2019-10-01  73  	udelay(300);
4fb8783165b7c6 Jani Nikula   2019-10-01  74  
4b6e05c43b7542 Ville Syrjälä 2024-09-06  75  	intel_de_write(display, vga_reg, VGA_DISP_DISABLE);
4b6e05c43b7542 Ville Syrjälä 2024-09-06  76  	intel_de_posting_read(display, vga_reg);
4fb8783165b7c6 Jani Nikula   2019-10-01  77  }
4fb8783165b7c6 Jani Nikula   2019-10-01  78  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
