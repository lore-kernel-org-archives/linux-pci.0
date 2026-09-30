Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B435A39F;
	Wed, 30 Sep 2026 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754852; cv=none; b=Ko4QUn9Mla1SGvuojHWDbuXyRdkVQMAXCrVSP2atd0OIG8wJC2jhYaL4Qq/52Eg650XkRa+N/HHJTre4p0jZ8ROosaWvS9BXzZx141G8Vhn5SixXQ2mchEFXaA3ju5YlCWJms6MAqPsMs2wqmQmPpSje9mG/tjHqEESEyyzSsyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754852; c=relaxed/simple;
	bh=bp4reCZPd2XicV3CZCU05AoXT61eeQMuU3TMTWKtudM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwpme6F0MY7QtGV0dteYaf+Pa0r4BmlJ2AdUFbd5HBZHTp5W/4C/IU8oRAoAvn41NlgNxwXss9YpVQxNyHT/cy3wI4lp/NULYIDyvbQNqXlE0rVZgqciZf9pK+QiRNxYPSSwFNhJ/qvXqb231x8XJnikS5EtWZ2btOdODRD3EJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsvQoenG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsvQoenG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790754851; x=1822290851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bp4reCZPd2XicV3CZCU05AoXT61eeQMuU3TMTWKtudM=;
  b=ZsvQoenGSXuj+4sZfap/tgcp5WbI4NeXzbp3MTzcY3O9jtUitRIqwD5P
   YpE8KIbMFHTkzGm+3E2jmWbYPm92OYtKqTn2KrT0G4vp7r7s2hqlHVLwc
   9sIgdS9tHhenDYFFHtSdGPLW0TjILAVM2Ezcgx6yFr+7KKLDYC0Q+mtHB
   5r3bzpBho5MYvHFfRwudXBKYNPL2eisDbPKGiuiRzElimd+8En7flBtQi
   yKrMzLT5AWmWwIncs1JoQmoUNjkS70H/r/vhM59BVFmXSnlnUCAybDhze
   OkWO/c+kwMQ8rwNGdCR35cw5GIHWuGjZhejSEPCLtz2RASCGzRrNwP8Pa
   Q==;
X-CSE-ConnectionGUID: rfAH74fqQV+YOZXxRnvGTg==
X-CSE-MsgGUID: gcFLZK+rSf6e8ebGKoV+TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90346974"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90346974"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:54:10 -0700
X-CSE-ConnectionGUID: KyEvnr4UQQ6q6aJZsLT+gg==
X-CSE-MsgGUID: VBbluRZLSkqZAQgOMC+6EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="278823387"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:54:03 -0700
Date: Wed, 30 Sep 2026 10:54:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Frank Li <Frank.Li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
	Niklas Cassel <cassel@kernel.org>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Randolph Lin <randolph@andestech.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v7 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Message-ID: <arzAGOKLOustEW7F@ashevche-desk.local>
References: <20260929083755.458238-1-inochiama@gmail.com>
 <20260929083755.458238-7-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929083755.458238-7-inochiama@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 29, 2026 at 04:37:52PM +0800, Inochi Amaoto wrote:
> The PCIe controller on Spacemit K3 is almost a standard Synopsys
> DesignWare PCIe IP with extra link and reset control. Unlike
> the PCIe controller on K1, this controller supports external MSI
> interrupt controller and can use multiple PHYs at the same time.
> 
> Add driver to support PCIe controller on Spacemit K3 PCIe.

...

> +static int k3_pcie_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct k1_pcie *k1 = to_k1_pcie(pci);
> +	u32 reset_ctrl = k1->pmu_off + PCIE_CLK_RESET_CONTROL;
> +	u32 val;
> +	int ret;
> +
> +	regmap_clear_bits(k1->pmu, reset_ctrl, LTSSM_EN);
> +
> +	k1_pcie_toggle_soft_reset(k1);
> +
> +	/* K3: Set IGNORE_PERSTN and drive PERSTN_OE high (assert reset) */
> +	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE | PCIE_PERSTN_OUT,
> +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE);

Would it make sense to define permutations

  PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE

for here...

> +	ret = k1_pcie_enable_resources(k1);
> +	if (ret)
> +		goto failed_resources;
> +
> +	regmap_set_bits(k1->pmu, reset_ctrl, PCIE_AUX_PWR_DET);
> +	regmap_clear_bits(k1->pmu, reset_ctrl, APP_HOLD_PHY_RST);
> +
> +	ret = phy_bulk_init(k1->phy_count, k1->phys);
> +	if (ret)
> +		goto failed_phy_init;
> +
> +	ret = phy_bulk_power_on(k1->phy_count, k1->phys);
> +	if (ret)
> +		goto failed_phy_power_on;
> +
> +	msleep(PCIE_T_PVPERL_MS);
> +
> +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			PCIE_PERSTN_OUT | PCIE_PERSTN_OE);

...and

  PCIE_PERSTN_OUT | PCIE_PERSTN_OE

for here and elsewhere?

> +	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);

> +	val = u32_replace_bits(val, BIT(7),
> +			       GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);

It's perfectly a single line. Check your editor settings (I believe I have
commented on a such in one of the previous rounds).

> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
> +
> +	k1_pcie_set_device_id(k1);
> +
> +	/* Finally, as a workaround, disable ASPM L1 */
> +	k1_pcie_disable_aspm_l1(k1);
> +
> +	return 0;
> +
> +failed_phy_power_on:
> +	phy_bulk_exit(k1->phy_count, k1->phys);
> +failed_phy_init:
> +	k1_pcie_disable_resources(k1);
> +failed_resources:
> +	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			   PCIE_PERSTN_OUT | PCIE_PERSTN_OE,
> +			   PCIE_PERSTN_OE);
> +
> +	return ret;
> +}

...

You checked everything but regmap IO. Why? Do you except it won't ever fail?
Perhaps to add a note about this (if not yet) to the cover letter?

-- 
With Best Regards,
Andy Shevchenko


