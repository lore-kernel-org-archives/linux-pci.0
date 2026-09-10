Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4B38BF81;
	Thu, 10 Sep 2026 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022588; cv=none; b=a70CUz/iksNrw7Pa7lkjTPHKE+nKp0ZtRiHSvdN9xrKWXEBKkPx1xOTx/GHGDlsTSkU8rDgwMjrEkHcLBsYv6g9Zw04hYLpFd1tAMgkzydjanhWmaZOopXpYOu/BiW97pHM3bSSdCmU+hsJO7/kE1Neu/U4+DpNh8FjLV6EZ10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022588; c=relaxed/simple;
	bh=PnSdyt8IKSG7Cusf+et3nfCE6GN+a6K2xDtnxZ+Uwgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usu23/HqtSJHSy3XTI0Mh8/vErM6gY3ixKGe1f0cOMin+JUT66z8bsl76MCxu/bOtspgMTr2SnXrog606XDDmSLPh/qWW6/kRpgtd/RQg+JQul4eewn6VmZDu70hiZ4uWLBwzVYJO86EV2Kn11ky0aro0+s1E+AVvfsgHUZ/gfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEGUocWT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEGUocWT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789022587; x=1820558587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PnSdyt8IKSG7Cusf+et3nfCE6GN+a6K2xDtnxZ+Uwgk=;
  b=nEGUocWTzP0VqouPLnX+yoarTyWW14EGLl4QS/KOS2unNvPLw2i/Q7wM
   m4C8oMJ9jf+5axPkLfGBRcC9d3wazWUXVgnq1tVHEEr3Mh8G6rfG6nKJH
   OmvSyp7gJbQpiKbOurQIn8F5fAOx4dRBTgwMhS51pDhJSeBJBQXWIWBfg
   BDtPnBub22nlOQrjMxIgLONyPFWjP5bJAg3x5aaIEbbkQTKE3P0rS5J4W
   AG4KQdD7Xv5nLKAk4U0yXtkZ7e6AUlwNapcfxKGFR0n+++4tLS/ZtSlyf
   H1j74oKQZFn3DySSI7Au/OOtg4mDKmrWU1hhZjqW9V7XK9UjWXEuFqlHN
   g==;
X-CSE-ConnectionGUID: PCOrR5gCT5eM+o8oY+X24w==
X-CSE-MsgGUID: GWN/RBvyTFizN7+7mEzcNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="99792614"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="99792614"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:43:06 -0700
X-CSE-ConnectionGUID: qMrwe2q5S86Ch2Xiv4qJ6A==
X-CSE-MsgGUID: vOjSCGXARA64SzNa76+uMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="275058100"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:42:58 -0700
Date: Thu, 10 Sep 2026 09:42:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yao Zi <me@ziyao.cc>
Cc: Inochi Amaoto <inochiama@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
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
Message-ID: <aqJRbzZhROtXncZu@ashevche-desk.local>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-2-inochiama@gmail.com>
 <ap_i5Pw4nVB4LZ-7@ashevche-desk.local>
 <aqESGs3_BxOd4PYg@inochi.infowork>
 <aqJDvogeo3avWWQ3@pie>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqJDvogeo3avWWQ3@pie>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 10, 2026 at 05:44:50AM +0000, Yao Zi wrote:
> On Wed, Sep 09, 2026 at 04:00:33PM +0800, Inochi Amaoto wrote:
> > On Tue, Sep 08, 2026 at 01:26:44PM +0300, Andy Shevchenko wrote:
> > > On Mon, Sep 07, 2026 at 07:26:00PM +0800, Inochi Amaoto wrote:

...

> > > > +	data = device_get_match_data(dev);
> > > > +	if (!data)
> > > > +		return -ENODEV;
> > > 
> > > It's better to use -ENODATA which will help to distinguish from other ENODEV
> > > cases (which are more often to happen).
> > 
> > OK, thanks
> 
> Honestly, I don't think this should even happen, since every compatible
> supported by the driver carries its own of_match_data, and failing to
> do so is obviously a driver bug, so I think this branch could be
> dropped.

Does this driver do not support driver_override? How comes?

(Note, Sashiko is full of the issues of not checking for NULL the matching data
 and hence it describes a scenario in which this leads to NULL pointer
 dereference.)

-- 
With Best Regards,
Andy Shevchenko


