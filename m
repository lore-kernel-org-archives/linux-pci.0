Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB71136E492;
	Fri, 27 Feb 2026 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224263; cv=none; b=oyrKjnF+ocTIew+B118Bp2FVYl9ouVoPbSkDSRvW0GK5I1bB4xFVqD9+bJ+4YrcTTzzdKtYXdEZHNEK6aloJgx3i9dO1MnSPZFR3ODrvtFzfcL0cEJelpGpLJdKNxRKw4neQxhkNhtn8dCPV+UxhOfjF1hHmc8lSk/lloeKRPY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224263; c=relaxed/simple;
	bh=7gMMXSmdmA1tBNKDTNrc8bRUDF2VVsAI+2IBxawq7Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttcdv+d1HyBICLZ4kCJWXYvdaCZmpIHe/1TntJQrEq1eCE2j5eKKaTOa8zgOSb1PD+Ws7LNGD0EqDlXeqHTk0zo08nWTot9zQOqomir+BCMk3/Xsiu8FWny4dK0Gb1/SwrQVIAi/pyh/ieL6uu+c8TKRZNzz6Dhq7eRncWKCjbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrkKNIe8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrkKNIe8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772224261; x=1803760261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7gMMXSmdmA1tBNKDTNrc8bRUDF2VVsAI+2IBxawq7Ls=;
  b=lrkKNIe8CWJiyp4+rIsBcAtzkfTi+GqCRXOZdIha4xf3G2Q2tsfeVyDF
   IXV9RqJO0ILO9Ja96utd8sjtosZI2yRcOMLVJ/9QIn1+3wAJ3OOwb1a+u
   JMnSWXUteK6lVTokpnNqeVQ0I4CHjrT9bhSAnXPjVo7YOunu+KR3JEbjj
   6/sNf4rx8G32l4+YrAcADrq18VHyUk7lAl0278eauJ+kiqpubFTGC4fwN
   3FueL6JJHrXH+aCfFqLsfQhaGxdU4/mgOhteLx77BhSyLDe4sXhTTODiN
   WSK/0fg0VMj/AFR8DcLKUYImyqmQkclmeE+WeBGqwzIkH1oZJTrnKIQ3S
   A==;
X-CSE-ConnectionGUID: 1/H1BBAcTbS/njzklw5YCg==
X-CSE-MsgGUID: NQoAX6EbRHOodTx8+B7p6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73225494"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="73225494"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 12:31:01 -0800
X-CSE-ConnectionGUID: HMmeM1m4RHiSOwEk0dTWQw==
X-CSE-MsgGUID: Mrhtn7flRSezBFQhe6Ft4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="240005938"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 27 Feb 2026 12:30:57 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vw4Te-00000000B2P-3TnR;
	Fri, 27 Feb 2026 20:30:37 +0000
Date: Sat, 28 Feb 2026 04:27:52 +0800
From: kernel test robot <lkp@intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] PCI: mediatek-gen3: Integrate new pwrctrl API
Message-ID: <202602280453.4TGe7q2R-lkp@intel.com>
References: <20260226074524.3808081-6-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226074524.3808081-6-wenst@chromium.org>

Hi Chen-Yu,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus robh/for-next linus/master v7.0-rc1 next-20260227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yu-Tsai/PCI-mediatek-gen3-Clean-up-mtk_pcie_parse_port-with-dev_err_probe/20260226-155647
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260226074524.3808081-6-wenst%40chromium.org
patch subject: [PATCH v2 5/7] PCI: mediatek-gen3: Integrate new pwrctrl API
config: um-randconfig-001-20260227 (https://download.01.org/0day-ci/archive/20260228/202602280453.4TGe7q2R-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 9a109fbb6e184ec9bcce10615949f598f4c974a9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260228/202602280453.4TGe7q2R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602280453.4TGe7q2R-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permissions
   /usr/bin/ld: drivers/pci/controller/pcie-mediatek-gen3.o: in function `mtk_pcie_probe':
>> pcie-mediatek-gen3.c:(.ltext+0x7e5): undefined reference to `pci_pwrctrl_create_devices'
>> /usr/bin/ld: pcie-mediatek-gen3.c:(.ltext+0xd45): undefined reference to `pci_pwrctrl_destroy_devices'
   /usr/bin/ld: drivers/pci/controller/pcie-mediatek-gen3.o: in function `mtk_pcie_remove':
>> pcie-mediatek-gen3.c:(.ltext+0xefd): undefined reference to `pci_pwrctrl_power_off_devices'
   /usr/bin/ld: pcie-mediatek-gen3.c:(.ltext+0xff0): undefined reference to `pci_pwrctrl_destroy_devices'
   /usr/bin/ld: drivers/pci/controller/pcie-mediatek-gen3.o: in function `mtk_pcie_device_power_down':
   pcie-mediatek-gen3.c:(.ltext+0x10cb): undefined reference to `pci_pwrctrl_power_off_devices'
   /usr/bin/ld: drivers/pci/controller/pcie-mediatek-gen3.o: in function `mtk_pcie_startup_port':
>> pcie-mediatek-gen3.c:(.ltext+0x13f6): undefined reference to `pci_pwrctrl_power_on_devices'
>> /usr/bin/ld: pcie-mediatek-gen3.c:(.ltext+0x1ae1): undefined reference to `pci_pwrctrl_power_off_devices'
   /usr/bin/ld: drivers/pci/controller/pcie-mediatek-gen3.o: in function `mtk_pcie_suspend_noirq':
   pcie-mediatek-gen3.c:(.ltext+0x1d19): undefined reference to `pci_pwrctrl_power_off_devices'
   clang: error: linker command failed with exit code 1 (use -v to see invocation)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
