Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860151;
	b=KdaOkzJ1aFqRyJ4z2oA+7IP39HEW5W+9lSUI/AaCabKkgN/5HX/CyHxYTV/rgX+iFAI8
	 SQDAXlIXJeaQkZcvZawJaHdov9ZvGVxnr1X1bPvUlEPow7jPL2zdkiTo7ABdFT2BkVAh2
	 qSoYWZcQ4+In6xI6pkg6aS/pN01hW3qdxt20LVIyJL6o+XVDTA+vpAF1kPkb5o7ZU+w/8
	 bfUfJONUbnfAiQoZ7tIas/W5rXMo53mA3DaKW8sRYMB16FknKXz9YPBXY84VN/z7MHq74
	 Ym5GwHCyRUtXHhlhfzJPciAd1bGhUv+GiIBmdd0K+qIqrUsp7TR8/79/M39QwlxtrWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860151;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ymerU3qs+IE5SarRlTt1VKtK551vjj0c9kwV9TnzqGE=;
	b=bz7nLFytQJIpwdlB6K+T0XZQzPVrRpkICgDr1l0QB6pAvWdMBon4TguQWFv6I/Ibf/1i
	 U9n2gottvJczN6Oya8TC7oHm+sKZFweystnfQKjXcZ2cZTuEsjbKv6jknK6skWqXmw8DZ
	 hBP6BvCpxxnqs5r//rWvpnQKzTh+R9/ZJNaqiQ7mGiUV7ssMhu3pFFRJ4a8RU6kEXzpL5
	 uYNIUUBKnBjP+z472f6ywdeo3b/mQD0c+rDBNF9g6AJfg1+6YqX58s7IjVpv6IDrLBkyH
	 ILWBvbH4Am2BtShufrVUoiGd77nAnZ8IztF51VORHWHyZ8CP6oSuVnmuL2wlLMRtHCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DRwCC90U;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B17606A326;
	Thu,  5 Nov 2026 06:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9B17606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DRwCC90U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793860150; x=1825396150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t5hBDD13+lQVTKr4HGQoZraqtI76Sha+S89tCwE0n90=;
  b=DRwCC90UNTDO268sIHg6yoqQsP2EWvx2vR/ZJYPV1SfkafMBBwg+8cPo
   vYlpGOziR6SLA0j25MiSPPUJrXCIHpWNC0W04lhMZmVQcES4OS+gY1Drv
   gy4NQy53WbXqGsP6Rzt9zTRlexAHY2+YlNkVSc9aYHr6MsBiAZJhsHVyv
   Tqd/8jC9b+5idS0xfuFA6FTTA+BHxUiagrBecebR10P7u1lun96gBCLqN
   Cn0IFtAzxRVLi0K2Wi9nFBQwS9JA3iOw50F8s5xLE3TVAGZsnYZUjWYOk
   IgUYPHbNzEbl22boakqECvt4gUCQFNkfS116rgYjA/J2BNpxSogruPUDw
   w==;
X-CSE-ConnectionGUID: jt0Fx5h0Qf+ZF66+ADUpRQ==
X-CSE-MsgGUID: wyql7UtPQI2/Bbni70sNIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2630127"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2630127"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:29:09 -0800
X-CSE-ConnectionGUID: 51cbibPgTa+oa4yEGFhgvw==
X-CSE-MsgGUID: ZCdruSxMSvuEUaYY291XpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6763797"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2026 22:29:03 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOqy2-00000000lnN-303Z;
	Thu, 05 Nov 2026 06:28:58 +0000
Date: Thu, 5 Nov 2026 14:28:14 +0800
From: kernel test robot <lkp@intel.com>
To: Yureka Lilian <yureka@cyberchaos.dev>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>
Subject: Re: [PATCH v2 1/3] PCI/pwrctrl: Export per-device APIs
Message-ID: <202611051425.vj4FPfnn-lkp@intel.com>
References: <20261104-apple-pcie-pwren-v2-1-216a4066965f@cyberchaos.dev>
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
In-Reply-To: <20261104-apple-pcie-pwren-v2-1-216a4066965f@cyberchaos.dev>

Hi Yureka,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4]

url:    https://github.com/intel-lab-lkp/linux/commits/Yureka-Lilian/PCI-pwrctrl-Export-per-device-APIs/20261104-124029
base:   6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
patch link:    https://lore.kernel.org/r/20261104-apple-pcie-pwren-v2-1-216a4066965f%40cyberchaos.dev
patch subject: [PATCH v2 1/3] PCI/pwrctrl: Export per-device APIs
config: arm-defconfig (https://download.01.org/0day-ci/archive/20261105/202611051425.vj4FPfnn-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 812626a41399a1d464a0d69627ab45c83b8ebfb9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611051425.vj4FPfnn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611051425.vj4FPfnn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/pci/pwrctrl/core.c:203 function parameter 'np' not described in 'pci_pwrctrl_power_off_device'
>> Warning: drivers/pci/pwrctrl/core.c:203 Excess function parameter 'device_node' description in 'pci_pwrctrl_power_off_device'
>> Warning: drivers/pci/pwrctrl/core.c:272 function parameter 'np' not described in 'pci_pwrctrl_power_on_device'
>> Warning: drivers/pci/pwrctrl/core.c:272 Excess function parameter 'device_node' description in 'pci_pwrctrl_power_on_device'
>> Warning: drivers/pci/pwrctrl/core.c:370 function parameter 'np' not described in 'pci_pwrctrl_create_device'
>> Warning: drivers/pci/pwrctrl/core.c:370 function parameter 'parent' not described in 'pci_pwrctrl_create_device'
>> Warning: drivers/pci/pwrctrl/core.c:370 Excess function parameter 'device_node' description in 'pci_pwrctrl_create_device'
>> Warning: drivers/pci/pwrctrl/core.c:439 function parameter 'np' not described in 'pci_pwrctrl_destroy_device'
>> Warning: drivers/pci/pwrctrl/core.c:439 Excess function parameter 'device_node' description in 'pci_pwrctrl_destroy_device'
>> Warning: drivers/pci/pwrctrl/core.c:203 function parameter 'np' not described in 'pci_pwrctrl_power_off_device'
>> Warning: drivers/pci/pwrctrl/core.c:203 Excess function parameter 'device_node' description in 'pci_pwrctrl_power_off_device'
>> Warning: drivers/pci/pwrctrl/core.c:272 function parameter 'np' not described in 'pci_pwrctrl_power_on_device'
>> Warning: drivers/pci/pwrctrl/core.c:272 Excess function parameter 'device_node' description in 'pci_pwrctrl_power_on_device'
>> Warning: drivers/pci/pwrctrl/core.c:370 function parameter 'np' not described in 'pci_pwrctrl_create_device'
>> Warning: drivers/pci/pwrctrl/core.c:370 function parameter 'parent' not described in 'pci_pwrctrl_create_device'
>> Warning: drivers/pci/pwrctrl/core.c:370 Excess function parameter 'device_node' description in 'pci_pwrctrl_create_device'
>> Warning: drivers/pci/pwrctrl/core.c:439 function parameter 'np' not described in 'pci_pwrctrl_destroy_device'
>> Warning: drivers/pci/pwrctrl/core.c:439 Excess function parameter 'device_node' description in 'pci_pwrctrl_destroy_device'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
