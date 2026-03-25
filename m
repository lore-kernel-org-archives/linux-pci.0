Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73183CF059
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439013; cv=none; b=EFdoMLa99RavtV7kff89EWss9BwLju7W+YCHMFelScHO+SwzGR0FsWLJ7PnV5q8pS0QJAp33Nu6Zrvz7Kx+y961+WlE6n3VxAarNRyuDqtCctOjAlOgdMATcDhX1Bx1WTddCgTVnlNrh43uQrr/VnJqM/6+LFJQsSdv5PuRc7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439013; c=relaxed/simple;
	bh=QbIceMlA4lobVchoyY3Beq01Q1lYhp7hHttZ3qKrNx8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KaDS0ORIjQDG0bMHD8dCsN6UqVTw6Qyhj1AmC8K1wIx+T35rp6RvF4havN6cPwIEPSxVKpwoxLPXbhU3iKK8zB9DrGcvtp+wi12ZFoUAhLaz86hOmvkoLNr6FUQxjXv6kzaf8o2/5AxbgqCnY+F5EhHQkDIHmi/S4qHDwvjzbOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dblGg+9a; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dblGg+9a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774439011; x=1805975011;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QbIceMlA4lobVchoyY3Beq01Q1lYhp7hHttZ3qKrNx8=;
  b=dblGg+9a+mbfUCjJEmD9XrVLtIKBIDwHj4QjT5qvWxWq/ia5f7yBM81B
   aXv+fyTX59+6XagNYYeOXDML4jBfVEEM1IVSXfqa4pt3CnaxcIDU0wuub
   +vVgaOraXxfPL4SlQABNqOTiI3DT2KReE3GurdsQA8/VeinY/qSx0lNUS
   VFOcbVCqNmUINel2wzW0TTJop3PAvDsYwGTq0ptJ/ERXst8l0ZeBddR3O
   z6hQfoni2CmfkN46HaTqleFQUBs6G1gc4wnNrKBxbPvsaOROYIFp6bFqx
   p5yaFKAY0J4cPENQy2cZk+nmFRLpkt1PJ8QkCqm2jWTJT/i9nFD1TeLqx
   A==;
X-CSE-ConnectionGUID: 6jALhJsPQ7OlSTJjMLCgQQ==
X-CSE-MsgGUID: Qc+hrsyxSRuWgVhEnR52Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="93049759"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="93049759"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 04:43:31 -0700
X-CSE-ConnectionGUID: H428qD0oSj6u7/A2u+skpA==
X-CSE-MsgGUID: ErgEsXyqSnurQiLjfh9GjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="247686403"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 25 Mar 2026 04:43:29 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5Mdy-000000006kb-28wu;
	Wed, 25 Mar 2026 11:43:26 +0000
Date: Wed, 25 Mar 2026 19:43:10 +0800
From: kernel test robot <lkp@intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
 Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:vga 3/5] drivers/gpu/drm/i915/display/intel_vga.c:68:9:
 warning: ignoring return value of 'vga_get_uninterruptible' declared with
 attribute 'warn_unused_result'
Message-ID: <202603251922.YzNmC76O-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git vga
head:   aac641c7e5feb2d966a07f7f5da5ddecb5f07e13
commit: c75d295afc77223a889bed578e4a686e000c1691 [3/5] PCI/VGA: Mark vga_ge=
t() and wrappers as __must_check
config: i386-randconfig-003-20260325 (https://download.01.org/0day-ci/archi=
ve/20260325/202603251922.YzNmC76O-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20260325/202603251922.YzNmC76O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603251922.YzNmC76O-lkp@i=
ntel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/i915/display/intel_vga.c: In function 'intel_vga_disable=
':
>> drivers/gpu/drm/i915/display/intel_vga.c:68:9: warning: ignoring return =
value of 'vga_get_uninterruptible' declared with attribute 'warn_unused_res=
ult' [-Wunused-result]
      68 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_vga.c: In function 'intel_vga_reset_i=
o_mem':
   drivers/gpu/drm/i915/display/intel_vga.c:93:9: warning: ignoring return =
value of 'vga_get_uninterruptible' declared with attribute 'warn_unused_res=
ult' [-Wunused-result]
      93 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +68 drivers/gpu/drm/i915/display/intel_vga.c

0c80d60ae63461 Ville Syrj=C3=A4l=C3=A4 2025-04-17  43 =20
4fb8783165b7c6 Jani Nikula   2019-10-01  44  /* Disable the VGA plane that =
we never use */
4b6e05c43b7542 Ville Syrj=C3=A4l=C3=A4 2024-09-06  45  void intel_vga_disab=
le(struct intel_display *display)
4fb8783165b7c6 Jani Nikula   2019-10-01  46  {
4b6e05c43b7542 Ville Syrj=C3=A4l=C3=A4 2024-09-06  47  	struct pci_dev *pde=
v =3D to_pci_dev(display->drm->dev);
4b6e05c43b7542 Ville Syrj=C3=A4l=C3=A4 2024-09-06  48  	i915_reg_t vga_reg =
=3D intel_vga_cntrl_reg(display);
0c80d60ae63461 Ville Syrj=C3=A4l=C3=A4 2025-04-17  49  	enum pipe pipe;
0c80d60ae63461 Ville Syrj=C3=A4l=C3=A4 2025-04-17  50  	u32 tmp;
4fb8783165b7c6 Jani Nikula   2019-10-01  51  	u8 sr1;
4fb8783165b7c6 Jani Nikula   2019-10-01  52 =20
0c80d60ae63461 Ville Syrj=C3=A4l=C3=A4 2025-04-17  53  	tmp =3D intel_de_re=
ad(display, vga_reg);
0c80d60ae63461 Ville Syrj=C3=A4l=C3=A4 2025-04-17  54  	if (tmp & VGA_DISP_=
DISABLE)
a3af0140663dc3 Emil Velikov  2021-06-04  55  		return;
a3af0140663dc3 Emil Velikov  2021-06-04  56 =20
0c80d60ae63461 Ville Syrj=C3=A4l=C3=A4 2025-04-17  57  	if (display->platfo=
rm.cherryview)
0c80d60ae63461 Ville Syrj=C3=A4l=C3=A4 2025-04-17  58  		pipe =3D REG_FIELD=
_GET(VGA_PIPE_SEL_MASK_CHV, tmp);
0c80d60ae63461 Ville Syrj=C3=A4l=C3=A4 2025-04-17  59  	else if (has_vga_pi=
pe_sel(display))
0c80d60ae63461 Ville Syrj=C3=A4l=C3=A4 2025-04-17  60  		pipe =3D REG_FIELD=
_GET(VGA_PIPE_SEL_MASK, tmp);
0c80d60ae63461 Ville Syrj=C3=A4l=C3=A4 2025-04-17  61  	else
0c80d60ae63461 Ville Syrj=C3=A4l=C3=A4 2025-04-17  62  		pipe =3D PIPE_A;
0c80d60ae63461 Ville Syrj=C3=A4l=C3=A4 2025-04-17  63 =20
0c80d60ae63461 Ville Syrj=C3=A4l=C3=A4 2025-04-17  64  	drm_dbg_kms(display=
->drm, "Disabling VGA plane on pipe %c\n",
0c80d60ae63461 Ville Syrj=C3=A4l=C3=A4 2025-04-17  65  		    pipe_name(pipe=
));
0c80d60ae63461 Ville Syrj=C3=A4l=C3=A4 2025-04-17  66 =20
4fb8783165b7c6 Jani Nikula   2019-10-01  67  	/* WaEnableVGAAccessThroughIO=
Port:ctg,elk,ilk,snb,ivb,vlv,hsw */
4fb8783165b7c6 Jani Nikula   2019-10-01 @68  	vga_get_uninterruptible(pdev,=
 VGA_RSRC_LEGACY_IO);
f0bb41fad02e03 Jani Nikula   2022-02-02  69  	outb(0x01, VGA_SEQ_I);
f0bb41fad02e03 Jani Nikula   2022-02-02  70  	sr1 =3D inb(VGA_SEQ_D);
f0bb41fad02e03 Jani Nikula   2022-02-02  71  	outb(sr1 | VGA_SR01_SCREEN_OF=
F, VGA_SEQ_D);
4fb8783165b7c6 Jani Nikula   2019-10-01  72  	vga_put(pdev, VGA_RSRC_LEGACY=
_IO);
4fb8783165b7c6 Jani Nikula   2019-10-01  73  	udelay(300);
4fb8783165b7c6 Jani Nikula   2019-10-01  74 =20
4b6e05c43b7542 Ville Syrj=C3=A4l=C3=A4 2024-09-06  75  	intel_de_write(disp=
lay, vga_reg, VGA_DISP_DISABLE);
4b6e05c43b7542 Ville Syrj=C3=A4l=C3=A4 2024-09-06  76  	intel_de_posting_re=
ad(display, vga_reg);
4fb8783165b7c6 Jani Nikula   2019-10-01  77  }
4fb8783165b7c6 Jani Nikula   2019-10-01  78 =20

:::::: The code at line 68 was first introduced by commit
:::::: 4fb8783165b7c6fb4b52428dbb80da8554e5fd1e drm/i915/display: abstract =
all vgaarb access to intel_vga.[ch]

:::::: TO: Jani Nikula <jani.nikula@intel.com>
:::::: CC: Jani Nikula <jani.nikula@intel.com>

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
