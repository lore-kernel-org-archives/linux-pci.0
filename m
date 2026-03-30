Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499BA377ECC;
	Mon, 30 Mar 2026 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889011; cv=none; b=OajMLmwAg1pvhGGSNj+EIEHULKFgyl5hKKSvN4E+TPOo8HhkGOQu5jaYT7M4o5oCuGpIdF5J1qzSgWpVpfS38maHL1KS7nCSr7+Vv5dpjprnjYs2AVpHg5WbVEU51Ij8F8ibCVjoOHOfwKOoshEtL6ELaV/enpYfq82Xpq3Qcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889011; c=relaxed/simple;
	bh=p1jo0copgAEo8xrTWfLXOYQHLuRM6ONtDy8aiRv2lQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PeAtg851Mu99KqVGsRjtrH7DQ4hDkq/9Evp/r9s6VUs4T8LgAt2OVYb5ywF6M6wmhXP4qKtNS+7rXiY6Os0KxgpXCdKXVUomHkh6taFWikw2FRvrSpDv073YxQixCw7iqTkapVv1KzncwC3hvDtOX+nrmwTODzCY1m8etjLBSqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2IVOxLR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2IVOxLR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D836C4CEF7;
	Mon, 30 Mar 2026 16:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774889010;
	bh=p1jo0copgAEo8xrTWfLXOYQHLuRM6ONtDy8aiRv2lQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=f2IVOxLR6fhfrRkVXW7aZqz9z0nY+Tu32lPSojGKbpcR/PKUXKv1Uh4IvfneuqA3V
	 33e8otrxJFUKEt+YcyI1rEQz/k0l/bga4kWvFB1gQ/PZEpJo9781A5bA+zCaXho0Lb
	 XGzljxjoeFrDZe6GgsnmznfrLGA2GF72TsqmlJuWM4EOLliSCUCtVBlJ328eT19huU
	 PtxPKhddWi43eKbqNS8HEuR9ZKNZZaEtl0p5vxoWvR06HgPN+TRLkFAXAbd6KpGpl5
	 DSgi2zdC/c2uEmuFUrf1aOfI8Ubgu84xoNR/CmzpuevVuUY86ATQADKxwu7tim1enx
	 JO+VlMbO3dVTQ==
Date: Mon, 30 Mar 2026 11:43:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Simon Richter <Simon.Richter@hogyros.de>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [pci:vga 3/5] drivers/gpu/drm/i915/display/intel_vga.c:68:2:
 error: ignoring return value of function declared with 'warn_unused_result'
 attribute
Message-ID: <20260330164327.GA81786@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202603300336.G53JumVL-lkp@intel.com>

On Mon, Mar 30, 2026 at 04:02:59AM +0800, kernel test robot wrote:
> Hi Simon,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git vga
> head:   21b082bd2a45704a6f7e69c190c8287a3d011ea9
> commit: dc582b5ed4b749335b947258d4874df628726632 [3/5] PCI/VGA: Mark vga_get() and wrappers as __must_check
> config: x86_64-randconfig-011-20260329 (https://download.01.org/0day-ci/archive/20260330/202603300336.G53JumVL-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260330/202603300336.G53JumVL-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603300336.G53JumVL-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/gpu/drm/i915/display/intel_vga.c:68:2: error: ignoring return value of function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result]
>       68 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/gpu/drm/i915/display/intel_vga.c:93:2: error: ignoring return value of function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result]
>       93 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
>    2 errors generated.

Dropped the commits related to this, see
https://lore.kernel.org/all/20260330161802.GA79047@bhelgaas

> vim +/warn_unused_result +68 drivers/gpu/drm/i915/display/intel_vga.c
> 
> 0c80d60ae63461 Ville Syrjälä 2025-04-17  43  
> 4fb8783165b7c6 Jani Nikula   2019-10-01  44  /* Disable the VGA plane that we never use */
> 4b6e05c43b7542 Ville Syrjälä 2024-09-06  45  void intel_vga_disable(struct intel_display *display)
> 4fb8783165b7c6 Jani Nikula   2019-10-01  46  {
> 4b6e05c43b7542 Ville Syrjälä 2024-09-06  47  	struct pci_dev *pdev = to_pci_dev(display->drm->dev);
> 4b6e05c43b7542 Ville Syrjälä 2024-09-06  48  	i915_reg_t vga_reg = intel_vga_cntrl_reg(display);
> 0c80d60ae63461 Ville Syrjälä 2025-04-17  49  	enum pipe pipe;
> 0c80d60ae63461 Ville Syrjälä 2025-04-17  50  	u32 tmp;
> 4fb8783165b7c6 Jani Nikula   2019-10-01  51  	u8 sr1;
> 4fb8783165b7c6 Jani Nikula   2019-10-01  52  
> 0c80d60ae63461 Ville Syrjälä 2025-04-17  53  	tmp = intel_de_read(display, vga_reg);
> 0c80d60ae63461 Ville Syrjälä 2025-04-17  54  	if (tmp & VGA_DISP_DISABLE)
> a3af0140663dc3 Emil Velikov  2021-06-04  55  		return;
> a3af0140663dc3 Emil Velikov  2021-06-04  56  
> 0c80d60ae63461 Ville Syrjälä 2025-04-17  57  	if (display->platform.cherryview)
> 0c80d60ae63461 Ville Syrjälä 2025-04-17  58  		pipe = REG_FIELD_GET(VGA_PIPE_SEL_MASK_CHV, tmp);
> 0c80d60ae63461 Ville Syrjälä 2025-04-17  59  	else if (has_vga_pipe_sel(display))
> 0c80d60ae63461 Ville Syrjälä 2025-04-17  60  		pipe = REG_FIELD_GET(VGA_PIPE_SEL_MASK, tmp);
> 0c80d60ae63461 Ville Syrjälä 2025-04-17  61  	else
> 0c80d60ae63461 Ville Syrjälä 2025-04-17  62  		pipe = PIPE_A;
> 0c80d60ae63461 Ville Syrjälä 2025-04-17  63  
> 0c80d60ae63461 Ville Syrjälä 2025-04-17  64  	drm_dbg_kms(display->drm, "Disabling VGA plane on pipe %c\n",
> 0c80d60ae63461 Ville Syrjälä 2025-04-17  65  		    pipe_name(pipe));
> 0c80d60ae63461 Ville Syrjälä 2025-04-17  66  
> 4fb8783165b7c6 Jani Nikula   2019-10-01  67  	/* WaEnableVGAAccessThroughIOPort:ctg,elk,ilk,snb,ivb,vlv,hsw */
> 4fb8783165b7c6 Jani Nikula   2019-10-01 @68  	vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
> f0bb41fad02e03 Jani Nikula   2022-02-02  69  	outb(0x01, VGA_SEQ_I);
> f0bb41fad02e03 Jani Nikula   2022-02-02  70  	sr1 = inb(VGA_SEQ_D);
> f0bb41fad02e03 Jani Nikula   2022-02-02  71  	outb(sr1 | VGA_SR01_SCREEN_OFF, VGA_SEQ_D);
> 4fb8783165b7c6 Jani Nikula   2019-10-01  72  	vga_put(pdev, VGA_RSRC_LEGACY_IO);
> 4fb8783165b7c6 Jani Nikula   2019-10-01  73  	udelay(300);
> 4fb8783165b7c6 Jani Nikula   2019-10-01  74  
> 4b6e05c43b7542 Ville Syrjälä 2024-09-06  75  	intel_de_write(display, vga_reg, VGA_DISP_DISABLE);
> 4b6e05c43b7542 Ville Syrjälä 2024-09-06  76  	intel_de_posting_read(display, vga_reg);
> 4fb8783165b7c6 Jani Nikula   2019-10-01  77  }
> 4fb8783165b7c6 Jani Nikula   2019-10-01  78  
> 
> :::::: The code at line 68 was first introduced by commit
> :::::: 4fb8783165b7c6fb4b52428dbb80da8554e5fd1e drm/i915/display: abstract all vgaarb access to intel_vga.[ch]
> 
> :::::: TO: Jani Nikula <jani.nikula@intel.com>
> :::::: CC: Jani Nikula <jani.nikula@intel.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
