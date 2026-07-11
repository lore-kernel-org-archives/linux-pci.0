Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939A3126AD;
	Sat, 11 Jul 2026 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783773862; cv=none; b=mZoC0ooE2UZi7aVu9DscnY2pEkKOV4NV/fJs4LYZDvixQb/4lkREMnN6A4CVcK+1MPzY7q0jKecXd2RGOj/A4kHuFEqA1T788XFfQTxpcXPayz5rCiyecLzLQYhjAPWWDczGnGPyp6cpsckGT6W2uyu0+44zbaRc4h0PB+ypb3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783773862; c=relaxed/simple;
	bh=qqdphEGA6+7P5vo5z9LUEDm4KQwk81RmJ+HPo2OWlqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+I6lOnF976MfUa66UPK0Wnd7L2vQgfH2ylZ/wT6bgf9WfCV8k3P/rX3yJFn7XxNOmIz9wPEbtWvJtxo7ByQRLGYO7QGcMl15Ri9lgDmdtxXJT+GSMYuFXKkzFV0M67nIsOcSXHQY6Je5BZpDBQJSDjZ533Bf/UdOYSYXmukTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n289I0EX; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n289I0EX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783773861; x=1815309861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qqdphEGA6+7P5vo5z9LUEDm4KQwk81RmJ+HPo2OWlqU=;
  b=n289I0EXvqZSVDYRObvUwn7sEEk0J7BjGl2I1/Y7S9Mu6mryNvs0ntxk
   JEOOyh7B7UcD4zDr2K+8FY7lF0WR8JpIkj6z1ssM3Hohv3LGvkoKlnF47
   IuZTqSAHesFdNibv7Iie/uhpKilIM3Se6E7eS0I3f1aVUKuGqZqYzgXq3
   h42FvXk/pGB2vBkVuTI6FPwRar4NgzY6NMQpRhcZOo7s8hVXhSFLrlC2o
   THJH3qi2PPMyGyDiUCVFp960SJZuk3m/ObXSBD1HZcGD3XCOJWl5cRMyX
   nHRe8y+8CW3X2VMJ06n2yD6ufp4J4xFOe/pvQx6AUCC2ZEQIqlHGGg3Xn
   g==;
X-CSE-ConnectionGUID: +jbi3BchSa+/NvCSRC7Omg==
X-CSE-MsgGUID: wX14C6ssTs6ahaCJapyaVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84505115"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84505115"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 05:44:20 -0700
X-CSE-ConnectionGUID: I0xxxA1WRZ+3GkRt9TAmmg==
X-CSE-MsgGUID: ro29f7pBQWioi7CrIV0nXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254622845"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.254])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 05:44:13 -0700
Date: Sat, 11 Jul 2026 15:44:10 +0300
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
Message-ID: <alI6ml4xQboFOgxG@ashevche-desk.local>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-3-inochiama@gmail.com>
 <ak9KzNFF26B0Kttz@ashevche-desk.local>
 <alBNXgMAwXPKwiJ2@inochi.infowork>
 <alCoTEDUY8AO9OzD@ashevche-desk.local>
 <alDNlfb0_T9g-ATO@inochi.infowork>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alDNlfb0_T9g-ATO@inochi.infowork>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 10, 2026 at 06:55:10PM +0800, Inochi Amaoto wrote:
> On Fri, Jul 10, 2026 at 11:07:40AM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 10, 2026 at 09:57:05AM +0800, Inochi Amaoto wrote:
> > > On Thu, Jul 09, 2026 at 10:16:28AM +0300, Andy Shevchenko wrote:
> > > > On Thu, Jul 09, 2026 at 12:00:22PM +0800, Inochi Amaoto wrote:

...

> > > > > +	k1->phy_count = i;
> > > > > +	if (k1->phy_count == 0)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	return 0;
> > > > 
> > > > This doesn't seem correct to me, I would expect phy_count to be assigned only
> > > > when it's valid. (Yes, perhaps 0 is the same as it was, but semantically it's
> > > > different 0 in this case.)
> > > 
> > > I guess you think 0 is a valid number? I can not understand what you thing
> > > Assign this to 0 if there is no phy is fine to me, which shows there is 0
> > > vaild phy found.
> > 
> > Isn't it already 0? Semantically code is wrong in a flow (not in the result).
> 
> In fact it is already 0 here. But I am not understand why you thing is wrong.
> Could you explain it in detail? (Maybe you think it is not good to return 
> -EINVAL?)

You rewrite 0 by 0, but the fact of the rewriting is inaccuracy.
We should not rewrite the default (whatever it is) with 0 count
as semantically they are different cases. The rule of thumb, we
don't assign values in case of errors, we leave them as is and
it's user / caller responsibility to assign the default and handle
errors properly. This is simple layering violation.

Your code should be

	if (i == 0)
		return -EINVAL;

	k1->phy_count = i;
	return 0;

> > > > See also above. Do we have some PHY API that just counts provided PHYs?
> > > > If not, that what you should probably add first, before this patch.
> > > 
> > > I have not found any api for this. But the actual problem is, how the api
> > > is designed. I have checked both the array bulk api for reset and clock,
> > > it seems like it is much more than this patch...
> > 
> > Yeah, I looked at the phy-core and I think it will be hard to implement.
> > So, the idea is then is to reallocate the pointer each time you get a new PHY.
> > In this case the phy_count will reflect the actual memory consumption by phy.
> 
> Emmm, I think it is kind of buggy and not necessary. In most case
> this array is not long actually, so allocate some pointer should be
> fine and be an acceptable cost.

Then the counted_by will be incorrect as it may access valid memory, but
unused by the driver.

...

> > > > > +	for (i = 0; i < k1->phy_count; i++)
> > > > 
> > > > 	for (unsigned int i = 0; i < k1->phy_count; i++)
> > > > 
> > > 
> > > I agree with the unsigned int, but I guess this definition is not
> > > allowed in linux.
> > 
> > It's allowed and it's encouraged even by Linus. As long as iterator is local,
> > use this syntax sugar and reduce its scope. It hardens the code.
> 
> Could you give me a reference url to check,

Sure, there are two (one for integers and one for pointers)
https://lore.kernel.org/lkml/CAHk-=wiCOTW5UftUrAnvJkr6769D29tF7Of79gUjdQHS_TkF5A@mail.gmail.com/
https://lore.kernel.org/lkml/CAHk-=wgy8p4is8ApEQCT5NS7XFb+NXeo-TKz7jRRZVksLLBSrQ@mail.gmail.com/

> I have not found this on the coding-style.
> https://www.kernel.org/doc/html/latest/process/coding-style.html

Feel free to update the documentation.

> > > > > +		phy_exit(k1->phy[i]);

-- 
With Best Regards,
Andy Shevchenko


