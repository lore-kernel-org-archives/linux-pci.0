Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC0C50EC1A;
	Tue,  8 Sep 2026 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863216; cv=none; b=KBe/JRa8HCWhABaqyO/SdjF8/FvGnF2cw+Bsy7ZNQxd23op5mB8uF0nrw5yBAJGsVsN2X4S9AI7faMc7gbfI36VG5r1vKf7Mb/p+iLqYbCScHphExkH4FtRvwwXNGfOlxfezScoGh1mgF1+OXzf7HM6UJgG5OgURlKJF5+zPOPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863216; c=relaxed/simple;
	bh=NRw+ETGIsTmdeUKeknoQ0Yj1vx+B3Gy2R9aH3D5k+KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLi4GNvsSwI/M3lz4OR6kGw3gYAKFiiNlPUBvCcr1bgSJo7gacizaXZzBJLbzokHYCGBIJllMm6oOVDo9CSwbdhAwR6tCLxQ1jX3CY5wgRJrGFozKBcO8e8vZNy/pEdtFy3C7pEFR2cNdUlGPOBY+wjqB6SB914eE4ogiNg1puA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/XLMwxy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/XLMwxy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788863215; x=1820399215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NRw+ETGIsTmdeUKeknoQ0Yj1vx+B3Gy2R9aH3D5k+KM=;
  b=K/XLMwxyRlchtNhGAMZaxdK3O6RRyMXMh/LKjC4Xw+DWmZ93YvHlpZU2
   OBcplq/TNofQJCj90yaB9G2Xe4ivIWPV2rWmp1AqtzP6H8dv/ZX/8e9at
   dwiIK5vWedPApuDnvGpSkI4q0Vtdj6L2pejcSTnEh4EbuIVrYty2oIJYB
   8NDrq94MNlllNilGIoIuZuP78RtQmt7zG8xKWw0iIW5ji6V6XX/Tp+jHs
   zeURjNJIULeQJllVO+KGVANVfVZVaITHwbLTcF8q5nArsTeRhkZHjxbRH
   3rrfFANTAYGHwfjlvqNnKxrRTXg+Hnmpmk3BzF1IBTNqwbOHkfit/O5Fe
   w==;
X-CSE-ConnectionGUID: iGO8/3x6QJCvvIlIJirIyA==
X-CSE-MsgGUID: 9fZ5YlZ3QW6Cr+PYRPK/vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="93125268"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="93125268"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:26:54 -0700
X-CSE-ConnectionGUID: AWLCOjaVT36BCPSmrDCMmQ==
X-CSE-MsgGUID: NbW/xd5MTgKX83yqBbb0VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="271468162"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:26:47 -0700
Date: Tue, 8 Sep 2026 13:26:44 +0300
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
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>,
	Sherry Sun <sherry.sun@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Alex Elder <elder@riscstar.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Randolph Lin <randolph@andestech.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5 1/6] PCI: spacemit-k1: Add device data support
Message-ID: <ap_i5Pw4nVB4LZ-7@ashevche-desk.local>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907112606.465778-2-inochiama@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 07, 2026 at 07:26:00PM +0800, Inochi Amaoto wrote:
> To reuse the K1 PCIe driver logic for K3 PCIe controller, add device
> data to handle the K1 specific logic and make room for the incoming
> logic for K3.

...

>  static int k1_pcie_probe(struct platform_device *pdev)
>  {
> +	const struct k1_pcie_device_data *data;
>  	struct device *dev = &pdev->dev;
>  	struct k1_pcie *k1;
>  	int ret;
>  
> +	data = device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;

It's better to use -ENODATA which will help to distinguish from other ENODEV
cases (which are more often to happen).

>  	k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
>  	if (!k1)
>  		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko


