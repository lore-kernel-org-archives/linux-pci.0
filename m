Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B290A41F341;
	Mon, 17 Aug 2026 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971700; cv=none; b=GvyHVhBBj+Q0NbEjd2bkj7raJfT9UWYXW7LKuzioUU/RYK9uvgiTCMnzW4OxhkaA6XgzCgRoKZ9rJVydrpafXBX0vLtzifrJwH5kr4MuQhyYoOO7eU3mcN5igpHM7EbkRgWZpV3W4fZgDIDNvNfnIrh+6ai+FFIUBvIjXy4TTQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971700; c=relaxed/simple;
	bh=zoVTlgD3cD2htjt1jPfKTgtfncDVduw8Z413cvKsh88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4eiyaQWc2bbZgQB3Y9RBnCaPVIzoPPm1N7eqNR9TKF0kVlUzTB0iu/H/hiwqe3Shf9qD2y/H1vvn7gGv+GMAhEHKtjIBNVxxtorccJ/UGkFxv7BIPAQQjIy9jEM4VVdPR1zJMNRLd+Z230dD73Tgz9x5nyNmbfhf+kN0JJ/0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miIRVYkp; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miIRVYkp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786971697; x=1818507697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zoVTlgD3cD2htjt1jPfKTgtfncDVduw8Z413cvKsh88=;
  b=miIRVYkpDIf4QrOQRKccQZmoZkosi77RBP5do+QYa2+fe2Bmn87MfBUl
   U52RQwBrEYnV3iUmffGY11yadH36vHwh0u3+IMztkAAbln+nk5ZJ0dGFH
   VmF7MuJdoNTkfgy14JoXCPShx/Irf7074sFqRxuUgfa6VTy74zhH3BOor
   yAc6KUhgdMT0zslJUaqr9UJjQ7NllXVPDTi6w6c6mqualA8bLJZK4wv3w
   3MV6UMdGspNUJUuKkfvMwJsD3I7jRaJRgjw8fnpYc97CQoUUTWAs4xlqQ
   girJhKbUHLM+JyyUCaqBP8g65BrZbpsQOYxFuiZBl2W55bMUap7zBg3AD
   A==;
X-CSE-ConnectionGUID: RzVl9RYdRTGx2d5TjCE3vA==
X-CSE-MsgGUID: FetLo2L/TjiFei7aMstdhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87363062"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87363062"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 06:01:35 -0700
X-CSE-ConnectionGUID: azCg8Rr7T/S8kwEPBqJd8w==
X-CSE-MsgGUID: yVvpOZZwRqG5LMVSYbkNLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="258705916"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 17 Aug 2026 06:01:27 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4048899; Mon, 17 Aug 2026 15:01:26 +0200 (CEST)
Date: Mon, 17 Aug 2026 15:01:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	manivannan.sadhasivam@oss.qualcomm.com,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org, Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v3 03/14] software node: Implement device_get_match_data
 fwnode callback
Message-ID: <aoMGJqwcEAHWmZX9@black.igk.intel.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-3-4faee7d0d5ae@oss.qualcomm.com>
 <aWSpFk9z0zpyKjr6@smile.fi.intel.com>
 <6l3rs5pv6xnrbygpvqrdxqoqtybjyefsltk5bl4336q56rfoza@ejo3sxuufghe>
 <aWSwgRiEkT9unYw9@smile.fi.intel.com>
 <6peb6afhpm4l7opxbdt3b5sx32longevwds5c3dlqji2hr5dlh@kxuvj55jkqgi>
 <ljqd5ovcsg7t62tdzd77w5mv5buawm3x7xyapy7n7l7azcaorh@tytj46t2lxyb>
 <ks2nm67zp5i2grzomu7mjb7uhkuwtd7w5stoqp5kri2clpxpsp@ayn42h7meh5l>
 <aoKrmZzmYsyvRJ-5@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoKrmZzmYsyvRJ-5@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 17, 2026 at 09:35:05AM +0300, Andy Shevchenko wrote:
> On Fri, Aug 14, 2026 at 02:49:31PM +0200, Manivannan Sadhasivam wrote:
> > On Mon, Jan 12, 2026 at 10:01:23PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Jan 12, 2026 at 02:32:21PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Jan 12, 2026 at 10:27:45AM +0200, Andy Shevchenko wrote:
> > > > > On Mon, Jan 12, 2026 at 01:49:54PM +0530, Manivannan Sadhasivam wrote:
> > > > > > + Dmitry Torokhov (who was against this patch previously)
> > > > > > 
> > > > > > On Mon, Jan 12, 2026 at 09:56:06AM +0200, Andy Shevchenko wrote:
> > > > > > > On Sat, Jan 10, 2026 at 12:26:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > > > > 
> > > > > > > > Because the software node backend of the fwnode API framework lacks an
> > > > > > > > implementation for the .device_get_match_data function callback.
> > > > > > > 
> > > > > > > Maybe this is done on purpose. Have you thought about this aspect?
> > > > > > 
> > > > > > IMO, software nodes were introduced to add sub-properties to the existing
> > > > > > firmware nodes, but it has usecase/potential to go beyond that. More below.
> > > > > 
> > > > > Potential doesn't mean the necessity.
> > > > > 
> > > > > > > > This makes it difficult to use(and/or test) a few drivers that originates
> > > > > > > > from DT world on the non-DT platform.
> > > > > > > 
> > > > > > > How difficult? DSA implementation went to the way of taking DT overlay
> > > > > > > approach. Why that one can't be applied here?
> > > > > > 
> > > > > > Sometimes you do not have any DT node at all.
> > > > > 
> > > > > Yes, that is exactly the case I have referred to. The PCI core (in Linux)
> > > > > is able to create DT subtree on non-OF based platforms.
> > > > 
> > > > Maybe I should look into creating dynamic DT node for the device and insert it
> > > > to the uart node. Theoretically it should work.
> > > 
> > > It worked flawlessly. So I sent v4 incorporating this design:
> > > https://lore.kernel.org/linux-pci/20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com/
> > 
> > Andy, I had to revive this old thread of a merged series as Krzk is not in
> > favour of adding DT overlay or dynamic OF nodes for these BT devices [1]. His
> > objections are due to the fact that we are just adding BT nodes of a
> > discoverable device (M.2 PCIe device) without any resources. So the node just
> > contains the compatible to match with the serdev driver and nothing else.
> > 
> > And he suggested to use swnodes or other similar mechanisms to plug with the
> > serdev driver as that's the only thing we want here, not a true hardware
> > description.
> 
> SW nodes are not for describing HW from scratch. They are for fixing missing
> pieces. If you can justify your case as a missing piece for the *existing*
> device (which is enumerated using standard mechanisms), you can add a property
> that fills the gap.
> 
> Unfortunately I see that there are `PROPERTY_ENTRY_STRING("compatible", ...)`
> cases in the kernel (only 9 drivers so far), and I can't say if they describing
> missing pieces or a SW-made descriptions of the hardware. For the latter the
> DT/ACPI/other means but swnodes should be used.

I have read all replies by @krzk and the question here, why don't you use
auxiliary bus? It seems the best suit for the case.

> > Since you strongly objected the swnode approach in this series, I wanted to hear
> > your opinion before I rework the code.
> 
> > [1] https://lore.kernel.org/linux-pci/768142f0-2638-41f3-a34f-dc80bb99eb7f@kernel.org

-- 
With Best Regards,
Andy Shevchenko


