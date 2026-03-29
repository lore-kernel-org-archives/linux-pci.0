Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D52C11CF
	for <linux-pci@vger.kernel.org>; Sun, 29 Mar 2026 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774814634; cv=none; b=BdO58edLqJh8g2qzBHjxtVnRUdgM7242piFVSL6vyRrzPKMk0OTbE4ERLWV3WvNTDC2DnuIIGFg2vAfc7pgByLUWx8xXIeBCLVZu2EKxSaU4OuIsK7NoRAsyvurLcQufk4f4yMZ0b+6qVdZpzqz6CdfnpQX1FIIlXS4FOOsEXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774814634; c=relaxed/simple;
	bh=q/qB0hRSdc8iLgrZTYUS7uvy+vi1WvhhaqNLFnacfJU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rbN2VicIBnnDBVXgxPS0e1aN9mf6HvA98/YniMKLiSy+6jdRWnvcJNRwLi2kyHIh/lvnOceMrRXMY86QUkNV4q1N3Hbpcsqc5HCm+a/r6WoZ+bBRVIK++OgkSC6p/meANhNjIlUsujYfwp4Js+uE2CY2vWs+PqOpmANzQdv1ex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I63oxAiC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I63oxAiC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774814632; x=1806350632;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=q/qB0hRSdc8iLgrZTYUS7uvy+vi1WvhhaqNLFnacfJU=;
  b=I63oxAiCnbaIzxWtBouAWPfHA/KMVe/Ul4C14xsX6wQTY7gIfzZeI6ny
   uz9K6IN4ik7DRJfBVTHuo2aq0L5Yx3bDGbxCEYO6GZXFWsnN5iBR+IlIP
   MQCwVD/8TcJGM6iARkbGvmFZMBd9kMsAGotu4FP0fsNU7aYK6Y3YNO4Pt
   3ogi2rttz8J6AorQtt4anc6UICigGeCols4lHwZ97Ju8FXqTpQnn+0H1b
   oZplwD/Ex2TPQLPgczX0x8gRrJXhGp9LXoQx6mDQT2EnxdeqoCiHVWhJR
   /uf2Rl57uN1y4gr6UpkHYKwVSA7MOUUQODXeXLi0ON6K/aSIoR8kc/CVK
   Q==;
X-CSE-ConnectionGUID: OAqD/+NuTf25vFbyUptdRw==
X-CSE-MsgGUID: EG9iMO+XQRyWOp4r5mMX5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75708667"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="75708667"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 13:03:51 -0700
X-CSE-ConnectionGUID: 8xNt/3fWSzmEU6QOZpoiWg==
X-CSE-MsgGUID: Xc7xvKgWRpqexbOk/sMx2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="229927052"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 29 Mar 2026 13:03:49 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6wMM-0000000007H-2vro;
	Sun, 29 Mar 2026 20:03:46 +0000
Date: Mon, 30 Mar 2026 04:02:59 +0800
From: kernel test robot <lkp@intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:vga 3/5] drivers/gpu/drm/i915/display/intel_vga.c:68:2:
 error: ignoring return value of function declared with 'warn_unused_result'
 attribute
Message-ID: <202603300336.G53JumVL-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Simon,

First bad commit (maybe !=3D root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git vga
head:   21b082bd2a45704a6f7e69c190c8287a3d011ea9
commit: dc582b5ed4b749335b947258d4874df628726632 [3/5] PCI/VGA: Mark vga_ge=
t() and wrappers as __must_check
config: x86_64-randconfig-011-20260329 (https://download.01.org/0day-ci/arc=
hive/20260330/202603300336.G53JumVL-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f022=
7cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20260330/202603300336.G53JumVL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603300336.G53JumVL-lkp@i=
ntel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/display/intel_vga.c:68:2: error: ignoring return va=
lue of function declared with 'warn_unused_result' attribute [-Werror,-Wunu=
sed-result]
      68 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
         |         ^~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_vga.c:93:2: error: ignoring return va=
lue of function declared with 'warn_unused_result' attribute [-Werror,-Wunu=
sed-result]
      93 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
         |         ^~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/warn_unused_result +68 drivers/gpu/drm/i915/display/intel_vga.c

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
