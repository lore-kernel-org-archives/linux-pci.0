Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1228003A;
	Wed, 11 Mar 2026 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193957; cv=none; b=bhHE+9QfpSVBQDZUUc9Ql7ygTS3ptcrloe2uak/2k8ZpBFbI/g3wB8VcRAC6LXPrc6wpdqGmnd5HBsh6XlXif93XTnOXe6oHw2z3jKWOvrm9mLufyHduEGmZBTv9rzjnFhJAfsVAdyQfqH53AZAza7p+sICz64lAcoLyNCmFdhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193957; c=relaxed/simple;
	bh=XGzlhdpEKBTOsnraVyGUlevcXvDh7h412ghI53fuwyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOld4P9y0m0jfurg6yNrfN5rn5CnB6RjqEEjaenFfrQwFxO8PMBGKiy53f4pvRioGNGf4EtXR0bWFpTss6boM0uquwxeBr7yroNBLV2/NSkRg2m65H4YrW84fHPYpDgJo18EtJDttJtl7CFSJdPAGMc7+wlf5PftcJXKl6QVWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ix1ULMRG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ix1ULMRG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773193954; x=1804729954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XGzlhdpEKBTOsnraVyGUlevcXvDh7h412ghI53fuwyA=;
  b=ix1ULMRGOvK94pFNMJ9iWMzGSGs/Sg9ldAICmhTwYIQ4iphj7emawbLr
   D4Evp7kb1tEpnLaWCmKlA1pNLLf7Dxcu/6ZfZrA8bSaxGhUSXBIT7DaiQ
   3ZmFlaffhjXiufubqPIpMG9A6YxJ2OgFbTb7sqFlgghjhFgakAy2blc2U
   rFJfeenu4jCG1ldxE6BY2Pco/YKQ43Jqaw8gctBKseylPlZ4spIMGyVNY
   +27+Fi4Ess+1u+vk4gzk19MIcoXlDQgyf27gKLLFp05a3+DfBOENolhCn
   SLqI0QeT/HSPuCkO9Jv9A3IxPLb45tXXuq+7NmPJq9owkw5JbcIGDInHT
   w==;
X-CSE-ConnectionGUID: MAOwt521QAqrRt1Nm4pn0A==
X-CSE-MsgGUID: G94gPqFJQpeMCrfm9SD4ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="91638152"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="91638152"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 18:52:33 -0700
X-CSE-ConnectionGUID: BL63HbhrT9y9yaaHYc0/8A==
X-CSE-MsgGUID: 3SkngTNZQH+Vh8p5N1VljQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="218213338"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Mar 2026 18:52:31 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w08kO-000000000W1-1j3V;
	Wed, 11 Mar 2026 01:52:28 +0000
Date: Wed, 11 Mar 2026 09:51:45 +0800
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
Subject: Re: [PATCH v4 7/7] PCI: mediatek-gen3: Integrate new pwrctrl API
Message-ID: <202603110916.8SVCCZYO-lkp@intel.com>
References: <20260310091947.2742004-8-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310091947.2742004-8-wenst@chromium.org>

Hi Chen-Yu,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v7.0-rc3 next-20260310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yu-Tsai/PCI-mediatek-gen3-Clean-up-mtk_pcie_parse_port-with-dev_err_probe/20260310-175537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260310091947.2742004-8-wenst%40chromium.org
patch subject: [PATCH v4 7/7] PCI: mediatek-gen3: Integrate new pwrctrl API
config: sparc64-randconfig-001-20260310 (https://download.01.org/0day-ci/archive/20260311/202603110916.8SVCCZYO-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260311/202603110916.8SVCCZYO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603110916.8SVCCZYO-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/pci/controller/pcie-mediatek-gen3.c:1225:8: error: use of undeclared label 'err_teardown_irq'
    1225 |                 goto err_teardown_irq;
         |                      ^
>> drivers/pci/controller/pcie-mediatek-gen3.c:1248:1: warning: unused label 'err_tear_down_irq' [-Wunused-label]
    1248 | err_tear_down_irq:
         | ^~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +/err_teardown_irq +1225 drivers/pci/controller/pcie-mediatek-gen3.c

  1201	
  1202	static int mtk_pcie_probe(struct platform_device *pdev)
  1203	{
  1204		struct device *dev = &pdev->dev;
  1205		struct mtk_gen3_pcie *pcie;
  1206		struct pci_host_bridge *host;
  1207		int err;
  1208	
  1209		host = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
  1210		if (!host)
  1211			return -ENOMEM;
  1212	
  1213		pcie = pci_host_bridge_priv(host);
  1214	
  1215		pcie->dev = dev;
  1216		pcie->soc = device_get_match_data(dev);
  1217		platform_set_drvdata(pdev, pcie);
  1218	
  1219		err = mtk_pcie_setup_irq(pcie);
  1220		if (err)
  1221			return dev_err_probe(dev, err, "Failed to setup IRQ domains\n");
  1222	
  1223		err = pci_pwrctrl_create_devices(pcie->dev);
  1224		if (err) {
> 1225			goto err_teardown_irq;
  1226			dev_err_probe(dev, err, "failed to create pwrctrl devices\n");
  1227		}
  1228	
  1229		err = mtk_pcie_setup(pcie);
  1230		if (err)
  1231			goto err_destroy_pwrctrl;
  1232	
  1233		host->ops = &mtk_pcie_ops;
  1234		host->sysdata = pcie;
  1235	
  1236		err = pci_host_probe(host);
  1237		if (err)
  1238			goto err_power_down_pcie;
  1239	
  1240		return 0;
  1241	
  1242	err_power_down_pcie:
  1243		mtk_pcie_device_power_down(pcie);
  1244		mtk_pcie_power_down(pcie);
  1245	err_destroy_pwrctrl:
  1246		if (err != -EPROBE_DEFER)
  1247			pci_pwrctrl_destroy_devices(pcie->dev);
> 1248	err_tear_down_irq:
  1249		mtk_pcie_irq_teardown(pcie);
  1250		return err;
  1251	}
  1252	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
