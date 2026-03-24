Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4CF314A83;
	Tue, 24 Mar 2026 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340626; cv=none; b=cxEhz9YFpyc/vnFgT/fqmkzHdVA0J3bIzv95WoIQYtEtCBYZ6dSpqGRkS9rTdHmmbOYNPlZTHYEYEwWWv1Vst0V9phuO0ISAfR8xv92CMJC+bXbBNUND5yezt+MXpDDJbmyv2n1cKx2BMOwlIMCeNO4XBSnP8mgW6eUFVOHxiQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340626; c=relaxed/simple;
	bh=YW1oumcShmJdUX2bVPw92WTp71r+w0EzqGKv/olyY1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqvjX4uTCXpXg7yi1qNHk1D2vzcR4GQl7KN8+61nodQHyYdjTsvWyFFS1rye+vFxwOTEQCKXqP7kYTIAdlhnPm75hLmFByjJeImuWtGs/otKBqSOs2k8QgwvhxbcHSEgZjmSARnWrluJV0NwSUV2CTMZgzfI24jjYxbVu2tSB0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f98KC4CZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f98KC4CZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774340621; x=1805876621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YW1oumcShmJdUX2bVPw92WTp71r+w0EzqGKv/olyY1o=;
  b=f98KC4CZaeyfxG72WM3q5bNculu5cr2oPVcqctGYfy2+RGPWoAJjKuYc
   bapjY04kxd1XNghpd73P4tJGwnjvTyBa7EXb8I/E/VNTZeHB8q0Le1mCR
   vFEo9ZsVTVfbQ86sy0+AQW+zVIwq/tsOk7WpwgLJCfdrMw1lCADbmX68F
   dYkUDBj81E2egEg9Reg26QNnwUHva3MZyWG/TGhatvnZCaEj6qKrIZe2i
   gyMqLM0aojP2Lh2xc3VtZh/Wjt8zL17aAx6GYZFz1alL3/RvgAiIKfuVj
   j1ax8dwqkU1YqTcQtlH7SeKUY7UhmNFvA8t/0MQvYLMbczeFTTDLjgabZ
   A==;
X-CSE-ConnectionGUID: lhTINTyIQBGAVB3YCA1CPQ==
X-CSE-MsgGUID: jCWPLS3ZSX2hrWhRxHKgVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75321931"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75321931"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 01:23:39 -0700
X-CSE-ConnectionGUID: la5BPmR+SsCZF91N9qYV7w==
X-CSE-MsgGUID: quziYg/kR1KJj/tuViZhjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="223500798"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2026 01:23:35 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4x2y-000000004DX-3E8K;
	Tue, 24 Mar 2026 08:23:32 +0000
Date: Tue, 24 Mar 2026 16:22:36 +0800
From: kernel test robot <lkp@intel.com>
To: Thierry Reding <thierry.reding@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jon Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: tegra: Add Tegra264 support
Message-ID: <202603241635.M39jGMQX-lkp@intel.com>
References: <20260320225443.2571920-5-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320225443.2571920-5-thierry.reding@kernel.org>

Hi Thierry,

kernel test robot noticed the following build errors:

[auto build test ERROR on tegra/for-next]
[also build test ERROR on next-20260323]
[cannot apply to pci/next pci/for-linus drm-tegra/drm/tegra/for-next linus/master v7.0-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thierry-Reding/soc-tegra-Update-BPMP-ABI-header/20260323-093336
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
patch link:    https://lore.kernel.org/r/20260320225443.2571920-5-thierry.reding%40kernel.org
patch subject: [PATCH v2 4/5] PCI: tegra: Add Tegra264 support
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20260324/202603241635.M39jGMQX-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260324/202603241635.M39jGMQX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603241635.M39jGMQX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/pcie-tegra264.c:302:16: error: use of undeclared identifier 'PCIE_LINK_WAIT_US_MIN'
                   usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
                                ^
>> drivers/pci/controller/pcie-tegra264.c:302:39: error: use of undeclared identifier 'PCIE_LINK_WAIT_US_MAX'
                   usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
                                                       ^
   drivers/pci/controller/pcie-tegra264.c:392:16: error: call to undeclared function 'tegra_bpmp_get_with_id'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   pcie->bpmp = tegra_bpmp_get_with_id(dev, &pcie->ctl_id);
                                ^
   drivers/pci/controller/pcie-tegra264.c:392:14: error: incompatible integer to pointer conversion assigning to 'struct tegra_bpmp *' from 'int' [-Wint-conversion]
                   pcie->bpmp = tegra_bpmp_get_with_id(dev, &pcie->ctl_id);
                              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   4 errors generated.


vim +/PCIE_LINK_WAIT_US_MIN +302 drivers/pci/controller/pcie-tegra264.c

   278	
   279	static void tegra264_pcie_init(struct tegra264_pcie *pcie)
   280	{
   281		enum pci_bus_speed speed;
   282		unsigned int i;
   283		u32 value;
   284	
   285		/* bring the link out of reset */
   286		value = readl(pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
   287		value |= XTL_RC_MGMT_PERST_CONTROL_PERST_O_N;
   288		writel(value, pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
   289	
   290		if (!tegra_is_silicon()) {
   291			dev_info(pcie->dev,
   292				 "skipping link state for PCIe #%u in simulation\n",
   293				 pcie->ctl_id);
   294			pcie->link_up = true;
   295			return;
   296		}
   297	
   298		for (i = 0; i < PCIE_LINK_WAIT_MAX_RETRIES; i++) {
   299			if (tegra264_pcie_link_up(pcie, NULL))
   300				break;
   301	
 > 302			usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
   303		}
   304	
   305		if (tegra264_pcie_link_up(pcie, &speed)) {
   306			/* Per PCIe r5.0, 6.6.1 wait for 100ms after DLL up */
   307			msleep(PCIE_RESET_CONFIG_WAIT_MS);
   308	
   309			dev_info(pcie->dev, "PCIe #%u link is up (speed: %s)\n",
   310				 pcie->ctl_id, pci_speed_string(speed));
   311			tegra264_pcie_icc_set(pcie);
   312			pcie->link_up = true;
   313		} else {
   314			dev_info(pcie->dev, "PCIe #%u link is down\n", pcie->ctl_id);
   315	
   316			value = readl(pcie->xtl + XTL_RC_MGMT_CLOCK_CONTROL);
   317	
   318			/*
   319			 * Set link state only when link fails and no hot-plug feature
   320			 * is present.
   321			 */
   322			if ((value & XTL_RC_MGMT_CLOCK_CONTROL_PEX_CLKREQ_I_N_PIN_USE_CONV_TO_PRSNT) == 0) {
   323				dev_info(pcie->dev,
   324					 "PCIe #%u link is down and not hotplug-capable, turning off\n",
   325					 pcie->ctl_id);
   326				tegra264_pcie_bpmp_set_rp_state(pcie);
   327				pcie->link_up = false;
   328			} else {
   329				pcie->link_up = true;
   330			}
   331		}
   332	}
   333	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
