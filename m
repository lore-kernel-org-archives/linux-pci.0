Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6B3EC2E7;
	Fri, 10 Jul 2026 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670876; cv=none; b=Sz+RQ/dWf57B5802ZW/e5TVMVF3r7Qov7jdfGgA9YjQWf2DzbYlZJG7hVK8CaHqLm9Hv1UG0SRxGI/FcDvK2wwomP58FkdwbNH0lk+1bHEUYsaxim91Sjvd43Gp+xt9yBQt1fCP5Uxp4IUZrtnmGR4Le3/OmGcz/BkC0hHjgoVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670876; c=relaxed/simple;
	bh=naUIyFM2ineqBmx6cpwvg+5iO9MPbuiQdUMA+z7fCpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixQ7v5lo6izxKqsDWN5hDKYDX/zzDbTobPFlK/NtOQmeQUs4AcjAZkFGZ38DV2Ds4aj4sCpyP6Q62Rm5kD/quAsBOUXlVG+vaLznqv2y/kbstRKE5KhNhI+HRFrxiepJjYMyb56DDv6j3/poSjytBqFxSdGF9jmxK8p5JbuFtw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FU0Sixje; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FU0Sixje"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783670875; x=1815206875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=naUIyFM2ineqBmx6cpwvg+5iO9MPbuiQdUMA+z7fCpA=;
  b=FU0Sixje3F1kyh/X6/v+zbPaRQIld/+SPfiPmw3nonutF84BHFlPwc99
   nV2UcJRTYpaqg7Co7w+1rV7eRuxwRTNnzv/IOSbBBc5GhqYkXtSNFcXkD
   jp1ou/uJIsLNJphQ1lGeo7dMuwyTk8rtdgqBJM1Cta2js7CTaOLHuAaJ/
   soV9wcfbBQcalE5kJhaTOusSTUy4SbIGGHidCMqq91oDLXxsuyOUcgleE
   NJAG+tVyAQ6zD1OXCgbGYMZ14s5j8RvcME29OUkAZdpywo7rfuas9P+Hz
   NBz8Omfd51QZ9rAKEST1Crp9yxjSWyXYFW4BpKT0EGUVonFuea9Ja+1uJ
   A==;
X-CSE-ConnectionGUID: 8UaaC3cGRC2fUL38lZgCcw==
X-CSE-MsgGUID: jH5Aln9IRUyNeW34eNXfLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84467120"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84467120"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:07:55 -0700
X-CSE-ConnectionGUID: k7BT+p0WS6GXZTFCbLFfbQ==
X-CSE-MsgGUID: ZEvW6qjkTVuzuBJ7QTu3sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253089844"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:07:47 -0700
Date: Fri, 10 Jul 2026 11:07:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
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
	Alex Elder <elder@riscstar.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 2/6] PCI: spacemit-k1: Add multiple PHY handles support
Message-ID: <alCoTEDUY8AO9OzD@ashevche-desk.local>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-3-inochiama@gmail.com>
 <ak9KzNFF26B0Kttz@ashevche-desk.local>
 <alBNXgMAwXPKwiJ2@inochi.infowork>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alBNXgMAwXPKwiJ2@inochi.infowork>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 10, 2026 at 09:57:05AM +0800, Inochi Amaoto wrote:
> On Thu, Jul 09, 2026 at 10:16:28AM +0300, Andy Shevchenko wrote:
> > On Thu, Jul 09, 2026 at 12:00:22PM +0800, Inochi Amaoto wrote:

...

> > >  struct k1_pcie {
> > >  	struct dw_pcie pci;
> > >  	const struct k1_pcie_device_data *data;
> > > -	struct phy *phy;
> > > +	struct phy **phy;
> > 
> > Should it be annotated by __counted_by_ptr() ?
> 
> Yes, I think it can, this is something I have missed.
> 
> > > +	unsigned int phy_count;
> > 
> > Ah, you allocate much more memory than possible PHYs... Can you redesign and
> > use the above annotation?
> 
> IIRC use the annotation does not reduce this memory usage...

It's about how you allocate it, the code uses max_phy_count instead of
phy_count.

> > >  	void __iomem *link;
> > >  	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
> > >  	u32 pmu_off;
> > 
> > >  }

...

> > > +	k1->phy_count = i;
> > > +	if (k1->phy_count == 0)
> > > +		return -EINVAL;
> > > +
> > > +	return 0;
> > 
> > This doesn't seem correct to me, I would expect phy_count to be assigned only
> > when it's valid. (Yes, perhaps 0 is the same as it was, but semantically it's
> > different 0 in this case.)
> 
> I guess you think 0 is a valid number? I can not understand what you thing
> Assign this to 0 if there is no phy is fine to me, which shows there is 0
> vaild phy found.

Isn't it already 0? Semantically code is wrong in a flow (not in the result).

> > See also above. Do we have some PHY API that just counts provided PHYs?
> > If not, that what you should probably add first, before this patch.
> 
> I have not found any api for this. But the actual problem is, how the api
> is designed. I have checked both the array bulk api for reset and clock,
> it seems like it is much more than this patch...

Yeah, I looked at the phy-core and I think it will be hard to implement.
So, the idea is then is to reallocate the pointer each time you get a new PHY.
In this case the phy_count will reflect the actual memory consumption by phy.

...

> > > +	for (i = 0; i < k1->phy_count; i++)
> > 
> > 	for (unsigned int i = 0; i < k1->phy_count; i++)
> > 
> 
> I agree with the unsigned int, but I guess this definition is not
> allowed in linux.

It's allowed and it's encouraged even by Linus. As long as iterator is local,
use this syntax sugar and reduce its scope. It hardens the code.

> > > +		phy_exit(k1->phy[i]);

-- 
With Best Regards,
Andy Shevchenko


