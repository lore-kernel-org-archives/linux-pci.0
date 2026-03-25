Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFED2EC54A
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 05:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774416980; cv=none; b=aYGT/7TNcJnpiHuxp6rXxVDJskdv7/EgZ4Xwy/3xZzN1ncL0HTknWBd1JF2cBW1w9P//5xDQaLypREIz57wmFsY/IivfxMcEZ4VCBWngu1Ja0Z+87HoW75battVkndGhGhScs/QHb1Aiub69xnzH8L47B8wN4mErOJTOnimBXQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774416980; c=relaxed/simple;
	bh=lw2dF1Jz7k5PP1qT6ep8zHjP8aZcyJlc8wVKL2yCQYc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NgBy/rd7TT6Xgi/LYAmfGsKJxs8Wqx0x3ApUsWu9NIZqDPceOP0tnNhTiq6D04IKg79wgROx2NqRjlIx99+dsboPDlOHmadxTcjP2p32Cm6uFkcq1wGJIcqEIpchu1RTGwpUfHGiMuEu7pjcB7yCKUVLOX+vjFLLu96CEBjY/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgCOyUaU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgCOyUaU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774416979; x=1805952979;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lw2dF1Jz7k5PP1qT6ep8zHjP8aZcyJlc8wVKL2yCQYc=;
  b=KgCOyUaUnvExCdxAP3z0t6NB8Kk4C177KXcXjINXICc2qHv4/QmYHsMH
   bhA0TfQTb2Ab5c08g3HgL2mGbtkOwGioH2fMsQ6YdnNHr+xMLcPauxmpY
   2NZR1+mmiw7F21TiAjhE+6CiXMnTUgqm/A4E4IcZ8a0EklRGIc1DS1uc7
   MuWSBQAFQQYGYyLZkrY/j4X28ATOul6vQvhfBijqgl/BS3t18gmncTOiu
   q30mUmenVGzR0H4jfatHA+xNyyCBGS/OsVR9qBXT/A18MDrABfhR9SW1j
   TaH8lOmq2FjjdqT8PDOvyi7AdU3dGBiDkxry31/k+chnqlrq3vsB36IQq
   A==;
X-CSE-ConnectionGUID: J3GwxopZSRW2pBRRnRaIsQ==
X-CSE-MsgGUID: q65TvIvERDygtvpMfeEg3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86820057"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="86820057"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 22:36:19 -0700
X-CSE-ConnectionGUID: vjaviDabQOKiGJfwMnZY+g==
X-CSE-MsgGUID: qPYsJTYbT7Cf/v995+SRQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="247610019"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 24 Mar 2026 22:36:16 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5Guc-000000006FP-1160;
	Wed, 25 Mar 2026 05:36:14 +0000
Date: Wed, 25 Mar 2026 13:35:45 +0800
From: kernel test robot <lkp@intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:vga 3/5] drivers/gpu/drm/i915/display/intel_vga.c:68:2:
 warning: ignoring return value of function declared with 'warn_unused_result'
 attribute
Message-ID: <202603251309.Q7UMM0U3-lkp@intel.com>
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
config: i386-defconfig (https://download.01.org/0day-ci/archive/20260325/20=
2603251309.Q7UMM0U3-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f022=
7cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20260325/202603251309.Q7UMM0U3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603251309.Q7UMM0U3-lkp@i=
ntel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/i915/display/intel_vga.c:68:2: warning: ignoring return =
value of function declared with 'warn_unused_result' attribute [-Wunused-re=
sult]
      68 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
         |         ^~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_vga.c:93:2: warning: ignoring return =
value of function declared with 'warn_unused_result' attribute [-Wunused-re=
sult]
      93 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
         |         ^~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +/warn_unused_result +68 drivers/gpu/drm/i915/display/intel_vga.c

0c80d60ae63461c Ville Syrj=C3=A4l=C3=A4 2025-04-17  43 =20
4fb8783165b7c6f Jani Nikula   2019-10-01  44  /* Disable the VGA plane that=
 we never use */
4b6e05c43b7542e Ville Syrj=C3=A4l=C3=A4 2024-09-06  45  void intel_vga_disa=
ble(struct intel_display *display)
4fb8783165b7c6f Jani Nikula   2019-10-01  46  {
4b6e05c43b7542e Ville Syrj=C3=A4l=C3=A4 2024-09-06  47  	struct pci_dev *pd=
ev =3D to_pci_dev(display->drm->dev);
4b6e05c43b7542e Ville Syrj=C3=A4l=C3=A4 2024-09-06  48  	i915_reg_t vga_reg=
 =3D intel_vga_cntrl_reg(display);
0c80d60ae63461c Ville Syrj=C3=A4l=C3=A4 2025-04-17  49  	enum pipe pipe;
0c80d60ae63461c Ville Syrj=C3=A4l=C3=A4 2025-04-17  50  	u32 tmp;
4fb8783165b7c6f Jani Nikula   2019-10-01  51  	u8 sr1;
4fb8783165b7c6f Jani Nikula   2019-10-01  52 =20
0c80d60ae63461c Ville Syrj=C3=A4l=C3=A4 2025-04-17  53  	tmp =3D intel_de_r=
ead(display, vga_reg);
0c80d60ae63461c Ville Syrj=C3=A4l=C3=A4 2025-04-17  54  	if (tmp & VGA_DISP=
_DISABLE)
a3af0140663dc33 Emil Velikov  2021-06-04  55  		return;
a3af0140663dc33 Emil Velikov  2021-06-04  56 =20
0c80d60ae63461c Ville Syrj=C3=A4l=C3=A4 2025-04-17  57  	if (display->platf=
orm.cherryview)
0c80d60ae63461c Ville Syrj=C3=A4l=C3=A4 2025-04-17  58  		pipe =3D REG_FIEL=
D_GET(VGA_PIPE_SEL_MASK_CHV, tmp);
0c80d60ae63461c Ville Syrj=C3=A4l=C3=A4 2025-04-17  59  	else if (has_vga_p=
ipe_sel(display))
0c80d60ae63461c Ville Syrj=C3=A4l=C3=A4 2025-04-17  60  		pipe =3D REG_FIEL=
D_GET(VGA_PIPE_SEL_MASK, tmp);
0c80d60ae63461c Ville Syrj=C3=A4l=C3=A4 2025-04-17  61  	else
0c80d60ae63461c Ville Syrj=C3=A4l=C3=A4 2025-04-17  62  		pipe =3D PIPE_A;
0c80d60ae63461c Ville Syrj=C3=A4l=C3=A4 2025-04-17  63 =20
0c80d60ae63461c Ville Syrj=C3=A4l=C3=A4 2025-04-17  64  	drm_dbg_kms(displa=
y->drm, "Disabling VGA plane on pipe %c\n",
0c80d60ae63461c Ville Syrj=C3=A4l=C3=A4 2025-04-17  65  		    pipe_name(pip=
e));
0c80d60ae63461c Ville Syrj=C3=A4l=C3=A4 2025-04-17  66 =20
4fb8783165b7c6f Jani Nikula   2019-10-01  67  	/* WaEnableVGAAccessThroughI=
OPort:ctg,elk,ilk,snb,ivb,vlv,hsw */
4fb8783165b7c6f Jani Nikula   2019-10-01 @68  	vga_get_uninterruptible(pdev=
, VGA_RSRC_LEGACY_IO);
f0bb41fad02e031 Jani Nikula   2022-02-02  69  	outb(0x01, VGA_SEQ_I);
f0bb41fad02e031 Jani Nikula   2022-02-02  70  	sr1 =3D inb(VGA_SEQ_D);
f0bb41fad02e031 Jani Nikula   2022-02-02  71  	outb(sr1 | VGA_SR01_SCREEN_O=
FF, VGA_SEQ_D);
4fb8783165b7c6f Jani Nikula   2019-10-01  72  	vga_put(pdev, VGA_RSRC_LEGAC=
Y_IO);
4fb8783165b7c6f Jani Nikula   2019-10-01  73  	udelay(300);
4fb8783165b7c6f Jani Nikula   2019-10-01  74 =20
4b6e05c43b7542e Ville Syrj=C3=A4l=C3=A4 2024-09-06  75  	intel_de_write(dis=
play, vga_reg, VGA_DISP_DISABLE);
4b6e05c43b7542e Ville Syrj=C3=A4l=C3=A4 2024-09-06  76  	intel_de_posting_r=
ead(display, vga_reg);
4fb8783165b7c6f Jani Nikula   2019-10-01  77  }
4fb8783165b7c6f Jani Nikula   2019-10-01  78 =20

:::::: The code at line 68 was first introduced by commit
:::::: 4fb8783165b7c6fb4b52428dbb80da8554e5fd1e drm/i915/display: abstract =
all vgaarb access to intel_vga.[ch]

:::::: TO: Jani Nikula <jani.nikula@intel.com>
:::::: CC: Jani Nikula <jani.nikula@intel.com>

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
