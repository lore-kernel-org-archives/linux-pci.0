Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D932248F73;
	Sun, 12 Jul 2026 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783848929; cv=none; b=lh0fWxhKGojkDxhK96q+zqt2klCF5OOZtM5Xw0qztQbd5KVn/AhTJrb9vNX0RQREFBlh4m2vkc+Hpdl0urdg0e8B/aMSq3x4sZzDYGYklomeFnTHQQuz3IK6uPD4UEIyiiHnNe3yfc1NsXM9xB/G1ZiwDXuFfRdRfNtA205Ihu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783848929; c=relaxed/simple;
	bh=mGp1bq6AA1K85gaOp9+XDByvUL2SultskddshE44Syk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Do62rfIeLVMNglI6qgSST+x27WFXww3dwqyPyi9EX9JaC7mp64qLsuvls9r3pkLodumielPPSkirjCrOxlf8oiv690SnAaWuX4c46tqWbZWV9iljwtTwI0srvuoMVTXJqzrDujo4UAKC75md006G0JXAh6eLIU5u8hW7nv5H4WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMBNjoPn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMBNjoPn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783848928; x=1815384928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mGp1bq6AA1K85gaOp9+XDByvUL2SultskddshE44Syk=;
  b=fMBNjoPnwxgVuxXOYNLMbPEfaTGGPHn38BhktDWNkZzHsTtt1y5W9lfr
   x22OfgafT0ltAXeZ+BIdyD1ObyAVCTLt6Xzjz9fxabBuH607k0ajHQRIe
   IYYKWy/yoiQPKvzCtlNJFMYQ3q9DJCzDf93LosjDX0DUtW6pw2yV6jJU8
   UMfrMEXMwl09+IuftKVnuj2xhdVUSYwPuVn9nQ8zVNR6PZMmJ5sKwVxYz
   IIhlqi4Uh1po+XOjqquHAMpn8YUhaByMn+9sBg8vy9f+2eINUtH+JorNT
   UKYh2/VBEkourxrCKFW2DhZjUHSwhLJFMKnDDFidZBecooQhOzzEUJl81
   w==;
X-CSE-ConnectionGUID: z75NNL6kTVSOMK86JBfheg==
X-CSE-MsgGUID: iXf+9jT6SjaylLiMNFKM8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="102038664"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="102038664"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 02:35:26 -0700
X-CSE-ConnectionGUID: 9iJqSNd8TrO9jHI70RXUgg==
X-CSE-MsgGUID: yangtqhOTzKX89W8YnrRww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259587848"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 02:35:19 -0700
Date: Sun, 12 Jul 2026 12:35:16 +0300
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
Message-ID: <alNf1OoBtscauPXV@ashevche-desk.local>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-3-inochiama@gmail.com>
 <ak9KzNFF26B0Kttz@ashevche-desk.local>
 <alBNXgMAwXPKwiJ2@inochi.infowork>
 <alCoTEDUY8AO9OzD@ashevche-desk.local>
 <alDNlfb0_T9g-ATO@inochi.infowork>
 <alI6ml4xQboFOgxG@ashevche-desk.local>
 <alMmkHrfgWoN8RqS@inochi.infowork>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alMmkHrfgWoN8RqS@inochi.infowork>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 12, 2026 at 01:41:25PM +0800, Inochi Amaoto wrote:
> On Sat, Jul 11, 2026 at 03:44:10PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 10, 2026 at 06:55:10PM +0800, Inochi Amaoto wrote:
> > > On Fri, Jul 10, 2026 at 11:07:40AM +0300, Andy Shevchenko wrote:
> > > > On Fri, Jul 10, 2026 at 09:57:05AM +0800, Inochi Amaoto wrote:
> > > > > On Thu, Jul 09, 2026 at 10:16:28AM +0300, Andy Shevchenko wrote:
> > > > > > On Thu, Jul 09, 2026 at 12:00:22PM +0800, Inochi Amaoto wrote:

...

> > Then the counted_by will be incorrect as it may access valid memory, but
> > unused by the driver.
> 
> After some search I found a requirement in GCC patch:
> https://gcc.gnu.org/pipermail/gcc-patches/2024-May/653123.html
> 
> It seems like the array can have more elements than the counter.
> Some I guess the reallocation is not necessary and the counter
> is still correct. Correct me if I am wrong.

There will be no problem from memory accesses point of view, but there are two
disadvantages:
- the waste of memory for unused items
- the memory accesses beyond used items, which may lead to or show the subtle
  issues in the code elsewhere

Better to be correct. It might help debugging as well in some other cases.

...

> > > > > > > +	for (i = 0; i < k1->phy_count; i++)
> > > > > > 
> > > > > > 	for (unsigned int i = 0; i < k1->phy_count; i++)
> > > > > 
> > > > > I agree with the unsigned int, but I guess this definition is not
> > > > > allowed in linux.
> > > > 
> > > > It's allowed and it's encouraged even by Linus. As long as iterator is local,
> > > > use this syntax sugar and reduce its scope. It hardens the code.
> > > 
> > > Could you give me a reference url to check,
> > 
> > Sure, there are two (one for integers and one for pointers)
> > https://lore.kernel.org/lkml/CAHk-=wiCOTW5UftUrAnvJkr6769D29tF7Of79gUjdQHS_TkF5A@mail.gmail.com/
> > https://lore.kernel.org/lkml/CAHk-=wgy8p4is8ApEQCT5NS7XFb+NXeo-TKz7jRRZVksLLBSrQ@mail.gmail.com/
> > 
> > > I have not found this on the coding-style.
> > > https://www.kernel.org/doc/html/latest/process/coding-style.html
> > 
> > Feel free to update the documentation.
> 
> Good to know thanks.

Are you going to update documentation? I can review it.

> > > > > > > +		phy_exit(k1->phy[i]);

-- 
With Best Regards,
Andy Shevchenko


