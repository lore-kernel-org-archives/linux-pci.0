Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792966280;
	b=F97McX7c6v5MQ4B27aQzTl82XszylSYHKjxf7/EtlKW/yBLD8CaH5alUTEFk3GQX3A+9
	 OEvqYmdT8KSKI8taZs2FujZLrZ6zWEmIdoQLJbHjIPSmd+Wrnk7II69iCVNaLido42Ef1
	 hLmnoE3iRey+bhMPCr+iZhx1C62WWbi9Gd8EMr3p3Eou/WlvtSCwOpjEOqrWQPMx2zdy8
	 +3S5pwq4Ezr2MQMaxZJeO+0KdxWcgis8Ev8hn6YdeIHe0So3D9g6FVg85SRlrOnQgweTq
	 uBUEUUu/c05pSuATV/NzB0UdR/2wQUPhmScPzD4RaXTOPX9kcKkTM04v+6tLGhDxdgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792966280;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RbskrtRSFQKpXX2TVUnJjsMMRjXACIHvuNFaGQl3KOY=;
	b=W4yaotBn5KANeOwop83AMEvPk0jYlRxKVX2XUcMV5Nq5MYeU0UxeQkknMGGlCu3KE4TB
	 3N2r8n9WJcCl//pQ5ESaJlFUwbdNoA8PVdHNhv8L9kPN2WeSA+vN/r3MR6t5Qp2NE874j
	 wS+ntdjU5INZWuD3fwWLFxm7OydUf6D1g9QDhVWawncD/elCWsQRk/qIPzr0InFL+I6FH
	 snCBtvHYaiwEGZgCaBwWw+AK/n8xLqPwQwjGmKAmfPssf4N1SP80etWKAz0VHIWIPopir
	 weAyCvTKHFWUOH8TrTnczIuBaC4xKGx0tyRhtAQbuhCBem1xp0rBODiGvaanvLzb8Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C73HCDx9;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB598606A31A;
	Sun, 25 Oct 2026 22:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB598606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C73HCDx9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792966278; x=1824502278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SvvFyjxTb+lI7eFPlaBGniMfSYQ5Hlh9HQr+bDAhB9A=;
  b=C73HCDx96WLkay6CakySx1CazQMX2a2yY31Uuvxu/PceSIGKWAt56LTn
   Khe1cI/rrBfzyKTeIhvjIKdfsP6b2HGaU+HvaM9vX5zpE8jZwEblriurR
   DQzHM52tvvIdZTaQyYNxmfDvxQPXfPKmDUIEXmS5sM3fLhQBuQC52YcwV
   eKHSNAIUWV25e2wJph4yiAWw/gz/1/GZ97paoq/BMhfmYvfBETd3s1xqr
   +eEhBlgrsYFvR/TcTE2Njks9maDfjP+D8Tn6GjpNkax5QBNvILB47Ego+
   o7rCvXgVe03YyU/L6+GSgVEjifCUXg0Q49+GkSwT9OivTY+0y+CpkxSHG
   A==;
X-CSE-ConnectionGUID: piN7Kd0pTmm/eWtKnLm9Tw==
X-CSE-MsgGUID: IulAsO1ZQtuknE1xLXqMXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1720263"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1720263"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 15:11:17 -0700
X-CSE-ConnectionGUID: WDJ+oOdBR7yGTPf6fHnIlg==
X-CSE-MsgGUID: uvV5O+jKRce54uh3Wj/RwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4458231"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 25 Oct 2026 15:11:11 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xL6Qm-00000000VCU-1YQH;
	Sun, 25 Oct 2026 22:11:08 +0000
Date: Mon, 26 Oct 2026 06:10:19 +0800
From: kernel test robot <lkp@intel.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Andre Eikmeyer <dev@deq.rocks>, Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"(maintainer:X86 ARCHITECTURE \\(32-BIT AND 64-BIT\\))" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	"(open list:X86 ARCHITECTURE \\(32-BIT AND 64-BIT\\))" <linux-kernel@vger.kernel.org>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 03/13] platform/apple-gmux: Fix MMIO interface
Message-ID: <202610260503.TQjc0Dfl-lkp@intel.com>
References: <20261025040046.1602-4-atharvatiwarilinuxdev@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025040046.1602-4-atharvatiwarilinuxdev@gmail.com>

Hi Atharva,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v7.3]
[also build test WARNING on next-20261023]
[cannot apply to drm-misc/drm-misc-next pci/next pci/for-linus linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Atharva-Tiwari/platform-apple-gmux-Fix-power-for-MMIO-systems/20261024-235937
base:   v7.3
patch link:    https://lore.kernel.org/r/20261025040046.1602-4-atharvatiwarilinuxdev%40gmail.com
patch subject: [PATCH 03/13] platform/apple-gmux: Fix MMIO interface
config: x86_64-randconfig-1017-20261025 (https://download.01.org/0day-ci/archive/20261026/202610260503.TQjc0Dfl-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261026/202610260503.TQjc0Dfl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610260503.TQjc0Dfl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/apple-gmux.c:253:6: warning: variable 'val' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     253 |         if (gmux_mmio_wait(gmux_data)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/apple-gmux.c:263:9: note: uninitialized use occurs here
     263 |         return val;
         |                ^~~
   drivers/platform/x86/apple-gmux.c:253:2: note: remove the 'if' if its condition is always true
     253 |         if (gmux_mmio_wait(gmux_data)) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/apple-gmux.c:250:8: note: initialize the variable 'val' to silence this warning
     250 |         u8 val;
         |               ^
         |                = '\0'
   drivers/platform/x86/apple-gmux.c:290:6: warning: variable 'val' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     290 |         if (gmux_mmio_wait(gmux_data)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/apple-gmux.c:301:9: note: uninitialized use occurs here
     301 |         return val;
         |                ^~~
   drivers/platform/x86/apple-gmux.c:290:2: note: remove the 'if' if its condition is always true
     290 |         if (gmux_mmio_wait(gmux_data)) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/apple-gmux.c:286:9: note: initialize the variable 'val' to silence this warning
     286 |         u32 val;
         |                ^
         |                 = 0
   2 warnings generated.


vim +253 drivers/platform/x86/apple-gmux.c

   247	
   248	static u8 gmux_mmio_read8(struct apple_gmux_data *gmux_data, int port)
   249	{
   250		u8 val;
   251	
   252		mutex_lock(&gmux_data->index_lock);
 > 253		if (gmux_mmio_wait(gmux_data)) {
   254			iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
   255			iowrite8(GMUX_MMIO_READ | sizeof(val),
   256				gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
   257			if (!gmux_mmio_wait(gmux_data))
   258				return 0;
   259			val = ioread8(gmux_data->iomem_base);
   260		}
   261		mutex_unlock(&gmux_data->index_lock);
   262	
   263		return val;
   264	}
   265	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
