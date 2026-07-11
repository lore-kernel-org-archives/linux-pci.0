Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34938392822;
	Sat, 11 Jul 2026 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775058; cv=none; b=T7Y4vqFl0ufzJssC5UyTY6Hmd5gOq57LIBqotIHS9swSqK2vMGKMs9s1sEUn6rLwPrSLCoDV9xjeIDphUpALMk9iDoucbMVBFq0nJZPwaHTKOccELxGwQTAiNztlcGBv6QcN4nUuKIwdZGEjApUI5VVQsJ/HJ3swsuhgONsPQpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775058; c=relaxed/simple;
	bh=dh/NC1ZAMj5F/j++S19UU/UH7ttb+MchcJhoqRF0piY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azYPt2iqxqvgbVdP3T4Hd4QhFX5j9e0WpqotAVnHDRMZYEQln4CtoNKlA487Il9yiDtBUHLfE1W/0nBWkT8Wumsu0/zuJ2rTwpL7HXIpZryJY4yY4occLunCOjvPY72YiQ79Kt8uWFrchS5U9ZiS4XlXLKwpogQRAgy+pEYsNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZZefRbk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZZefRbk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783775058; x=1815311058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dh/NC1ZAMj5F/j++S19UU/UH7ttb+MchcJhoqRF0piY=;
  b=KZZefRbkKT7M5iP+USqO9uX7utDBQkYB5KgT4MLYCES8fwhThCp9IIef
   CEZ/kEtG2xtR97+O/St8EDrSoHDJCX/R9W/wAmIFAkydu8nEfzbC8eDN+
   GJsCjpg+ZzFmvlu3HCtdP+S9BdoGHyMYCMBtaBPOFRo8ooOvJ8mgkZJOo
   XAWoz4K3MIVGfeQkP42tr7YN1CVZgVAz8LrvKJKmPcCnIcLtfBclH44vR
   BDnp8Xjf02F/y4YcEXHxwA6WgwvVZ+BJuxqFJl8kq+as87QUSw82YSWIC
   nkeh4wZP8v+GM0+ArXPdWgxKHiXu4ZK7UUbl7xLubZoo63Y4PuW49jY/E
   A==;
X-CSE-ConnectionGUID: SJPPwTAMTbi4SHIu+eOSSg==
X-CSE-MsgGUID: o+BqXZzzTKiqzUflbphCtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84474542"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84474542"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 06:04:17 -0700
X-CSE-ConnectionGUID: Bwi9OOBeQiOd5U9xEkaNew==
X-CSE-MsgGUID: qw7nWE8zQg++guoxV6gm1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="285214472"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.254])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 06:04:10 -0700
Date: Sat, 11 Jul 2026 16:04:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alex Elder <elder@riscstar.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Frank Li <Frank.Li@nxp.com>, Nam Cao <namcao@linutronix.de>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 2/6] PCI: spacemit-k1: Add multiple PHY handles support
Message-ID: <alI_RxpH8E3-Hsy4@ashevche-desk.local>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-3-inochiama@gmail.com>
 <ak9KzNFF26B0Kttz@ashevche-desk.local>
 <9de024d9-c7a8-4291-a79d-83acc77b261d@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de024d9-c7a8-4291-a79d-83acc77b261d@riscstar.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 10, 2026 at 07:51:05AM -0500, Alex Elder wrote:
> On 7/9/26 2:16 AM, Andy Shevchenko wrote:

...

> > > +		if (IS_ERR(k1->phy[i])) {
> > > +			if (PTR_ERR(k1->phy[i]) == -ENODEV)
> > > +				break;
> > > +
> > > +			return PTR_ERR(k1->phy[i]);
> > > +		}
> > 		if (PTR_ERR(k1->phy[i]) == -ENODEV)
> > 			break;
> > 		if (IS_ERR(k1->phy[i]))
> > 			return PTR_ERR(k1->phy[i]);
> 
> I'm not sure this is a huge improvement.  Checking IS_ERR()
> before using PTR_ERR() is comforting (a little along the
> lines of the other issue you mentioned--assigning a result
> before checking for an error).  Anyway, it's a little bit
> of an ugly construct no matter how you do it.

Yeah...

> Here's another possible way to do it.
> 
> 	k1->phy[i] = devm_of_phy_get_by_index(dev, node, i);
> 	if (!IS_ERR(k1->phy[i]))
> 		continue;
> 
> 	ret = PTR_ERR(k1->phy[i]);
> 	if (ret == -ENODEV)
> 		break;

In this case one can simplify to

	k1->phy[i] = devm_of_phy_get_by_index(dev, node, i);
	ret = PTR_ERR_OR_ZERO(k1->phy[i]);
	if (ret == -ENODEV)
		break;
	else if (ret)
		return ret;

-- 
With Best Regards,
Andy Shevchenko


