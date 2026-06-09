Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254E94218A1;
	Tue,  9 Jun 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016576; cv=none; b=Lk8zZG683cKqZAJ0OjccIDRZ4DSYw7Jrewza20vzO+Jz8KZFBp0pWN4NzAYFlK6NGX686b/nTEgDmr4BQkkBflPFXtblQMkb69QaemiaMukpCMOxYPbMSAY8+2cwkAWrg74+vQOmZ7ydXr6cJiVnblBeiuMwTTjkAjw8VvAFXDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016576; c=relaxed/simple;
	bh=7Z2e8ukGc3KhQzq9CXL9zA+rmMjw439SLKHDG9lz3kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4TP/KlaMrMix+B4gWRWvlEJgnRCmPvaFv+08R+R2nIuP0XHh/eP2szjpxgYUGnou5QbJocnurRK9aG7NL5vste+gj/3yRTwT3rCaxJ3be7ZR/5XNtmbbBoBWWBcZSkfAad13k7DnTAgbD3Tp4O6br09RED2qLQcxbkKcvZAsWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWde64V7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWde64V7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781016574; x=1812552574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Z2e8ukGc3KhQzq9CXL9zA+rmMjw439SLKHDG9lz3kA=;
  b=dWde64V7BEMuAMat7h68IOaF3/V9LnDEWMn5+mefFiHprlyk29uUk3a0
   QvqsOoxG2GjoZ5X8MIp+x2pIiW83BVU/6y4UHlpYDLOoMqlQEovj5WT1d
   HxGC670XcwhFQWUX7XW0MYk62Zjn+d8USNLK1PLvNP1W/lYi/yNeL2ElP
   bfXamy9ZMaggpV83Q1FiHnc6K4EbHqjc3E4F5oWstrHaFxaby80PSXElX
   tcUWmFUAdfl43SsJSe2IDAaffOqgRWFvt24zTcI6Eq/VIw1TiKtIMG4hr
   9dze4oxKCmS88jccmat6FbNw8Ps/gynGVTur24JxMQEe/AW1xQHrXpp1N
   Q==;
X-CSE-ConnectionGUID: l76ygdzwR4KLK0wpoZeWSw==
X-CSE-MsgGUID: EGFAn94ETierQAJu4wTh7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81527054"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81527054"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:49:33 -0700
X-CSE-ConnectionGUID: Vor5LSMvR1y7lXA9Z9vPLg==
X-CSE-MsgGUID: JO+VAp6lR9Kw7gZOYCCT5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="242923218"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:49:26 -0700
Date: Tue, 9 Jun 2026 17:49:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Inochi Amaoto <inochiama@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Alex Elder <elder@riscstar.com>, Nam Cao <namcao@linutronix.de>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Randolph Lin <randolph@andestech.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 5/5] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Message-ID: <aign88JV3k_wn2HK@ashevche-desk.local>
References: <20260517014841.254085-1-inochiama@gmail.com>
 <20260517014841.254085-6-inochiama@gmail.com>
 <wztjdv4t5cn7djj3jyvheest7rn5nr2g3efzwods2fz3yy5wn2@hbl644sd6fst>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wztjdv4t5cn7djj3jyvheest7rn5nr2g3efzwods2fz3yy5wn2@hbl644sd6fst>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 07:48:12PM +0530, Manivannan Sadhasivam wrote:
> On Sun, May 17, 2026 at 09:48:40AM +0800, Inochi Amaoto wrote:
> > The PCIe controller on Spacemit K3 is almost a standard Synopsys
> > DesignWare PCIe IP with extra link and reset control. Unlike
> > the PCIe controller on K1, this controller supports external MSI
> > interrupt controller and can use multiple PHYs at the same time.
> > 
> > Add driver to support PCIe controller on Spacemit K3 PCIe.

...

> > +static int k3_pcie_enable_phy(struct k1_pcie *pcie)
> > +{
> > +	int i, ret;

No need to have i signed.

> > +
> > +	for (i = 0; i < pcie->phy_count; i++) {
> > +		ret = phy_init(pcie->phy[i]);
> > +		if (ret)
> > +			goto err_phy;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_phy:
> > +	while (--i >= 0)

	while (i--)

is shorter form of the same.

> > +		phy_exit(pcie->phy[i]);
> > +

...

> > +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> > +			PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE | PCIE_PERSTN_OUT);
> > +	usleep_range(1000, 2000);

fsleep(1 * USEC_PER_MSEC)

> > +	regmap_clear_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC, PCIE_PERSTN_OUT);
> > +
> > +	msleep(PCIE_T_PVPERL_MS);

...

> > +	int i;

Why is 'i' signed?

-- 
With Best Regards,
Andy Shevchenko


