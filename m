Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108869;
	b=JOp/J+x4VssnHkXsmSL5Dq9TJKzlKNoiCZAaxaEySJnRGvr5qX8l1ZQDhOfZ1QzsWwmp
	 vZblHM159WdX0M0q9e6Nfh35tuh4YRzjvVNQgUES9DdjX2+lpuwgQEQTPqRfDYonpIjfl
	 acIaC96XCs96LCfCO0ijHewBXgrr2D6wLzcj3bT4XYGYqWYAFrghvQMJ62bnuA8zZOT5P
	 CSHFCW8RSLYJ9BYswzsBm54MkLJIr5z18T+SrADJSVLsBdV0vNTtNHFg+WHT0bFddpTSx
	 4snSsmx3k08V92Ubz17My3RDzG5uxZCt8w/BE4F0uqfZI/0kzw1FzHICWPweEu1gRpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108869;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=NIOjyQwa1huamyiWSyAG0v1EOaAoTvb0DcjMke+yswU=;
	b=v2EG6XZM6oXhn+fCSm42lXpZ8fCycdpr9pOHb9AZCDVP1LP+XUK6nwpsQxXydpZ+trMu
	 6ztidWzJio3EabsRpO+W3FORFbIUaIw39w8qw9eRum9UkYOCTOUAH9dLn47gzMSaA/Zpe
	 HNlCDvKGfKRd8XRc+jthCnhn82rcwDcFs4DySSKFVMUTwI2PSZG7jlLHw1XpEE5HTj3bt
	 ft7YdSOee3hBnB8y+iE3OKpt+5jq/lDvBWPd6kqzg1Epa74uaWq60/WWXD5FIjeDYqM06
	 SKWOCLyAYZjWhnn641D8tS+Q6qNqm8MH4xn6pWyck1ebtK0ukqJ+XE/z5sj2giBne8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DYcftx6F;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B334606A336;
	Thu, 19 Nov 2026 17:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B334606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DYcftx6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795108868; x=1826644868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UpkMnnrGzJrw64nYsSqPlALwNPD8c8U90kWS3ZDpvbw=;
  b=DYcftx6FXPw/SNofG2olt7gqa0ecrcE0wWFz3J9NWdLNuveM3mknRXxD
   mKFZaDEgt8/BTSMyeT1XxpjIwPz3g0RRcudOJ0ecY9QvcthJzzL9qNoMa
   KdHEOLQBgIXjKw3iwBWCM0hylXhcZPdg87vaet9nEUNtaxHBoM2a56V89
   9zniFQYkrK1U3FIuNCNfkZ+pDS3Rgw58L86m9i/VYHH5VwS0XkNGZ9tzl
   Cgwajw4Pqe82GfEuWd1x5PR+DudzdcSdg2cUIw23uKDXtpQlRSYBgMO0i
   SeykHtowMATvzkLtHKRoAzneLPZQdF7WeofV+FEDBNYU2CqfjdVa8lr4I
   Q==;
X-CSE-ConnectionGUID: WNt8LAihTli0rt1RTxhNNw==
X-CSE-MsgGUID: 5bnz/iLgQy+ExqYj8QdlFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3959479"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3959479"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:18:50 -0800
X-CSE-ConnectionGUID: 2l+HAzB7RNS9BI9wb0ivSw==
X-CSE-MsgGUID: PBxuaL8ES/yrwFqO6Ss2Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10382679"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:18:47 -0800
Date: Thu, 19 Nov 2026 19:18:44 +0200
From: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Habil Eren =?iso-8859-1?Q?T=FCrker?= <habilerenturker@hotmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@kernel.org" <tglx@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 1/4] PCI: Add pci_power_t helper functions
Message-ID: <av8vdHPJhXII2955@ashevche-desk.local>
References: <av8o-tHHScd0gjZM@ashevche-desk.local>
 <20261119170713.GA817259@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261119170713.GA817259@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 11:07:13AM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 19, 2026 at 06:51:06PM +0200, andriy.shevchenko@intel.com wrote:
> > On Thu, Nov 19, 2026 at 02:35:46PM +0000, Habil Eren Türker wrote:
> > > Add helper functions to extract, set and compare PCI power
> > > states in the Power Management Control/Status register.

...

> > > +/* Helper functions for PCI power management */
> > > +static inline pci_power_t pci_power_t_get(u32 csr)
> > 
> > Why u32 as it seems the value is 16-bit?
> 
> I think there's one reader of PCI_PM_CTRL that does a 32-bit read, and
> I figured a u16->u32 promotion would be better than a u32->u16
> truncation.  But maybe that reader should be changed to a 16-bit read.

Is it specific read on the specific HW that is always done as 32-bit?
(Personally I do not believe there is such a requirement to even weirdest
 PCI HW. This register is way too standard.)

-- 
With Best Regards,
Andy Shevchenko


