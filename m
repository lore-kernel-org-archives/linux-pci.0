Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99F723E334;
	Wed, 14 Oct 2026 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974812; cv=none; b=PYbahBLRH+dKzuJsKDfmy7dhHaWHEtO+F8kPQb0DLwWoWVv7HzmjwW7rSnpOUWKMUvCZJsNnjL5lT2jwXzGqJKU298bH1SX3NsK7E/tycmYtOZFV5I17kzcC6XVk3aPJ0NaYrCnkL3GIYYb/dO6yG3fMIsAaFgiRi/9NPwvGjRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974812; c=relaxed/simple;
	bh=JtG1HONRpZR0jNIXlTzUqB48YC3qE8S+XSP5JTYlG/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6dV8ZXhIUqwQFhryE1StF2B9U2uMrUw/fYN78gScsumG/VWaGATXocR9wfml1onUC6vFPe9wEtqcPHZnWlp0Fdgq8VntCFLj/3R77eVVI3Y47U54qY1TQHEwGHBz5e7fJW8DlrLPbTYMrS61RUJ1/MA/M985rtrPEC4R0QoEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgABIDG5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgABIDG5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791974811; x=1823510811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JtG1HONRpZR0jNIXlTzUqB48YC3qE8S+XSP5JTYlG/I=;
  b=DgABIDG5RtedK3+uUkDXAVIz4SgjyFrCwe6RJUC68atnoKQiMh/tTg3W
   51uF701l58vcEoIszUjlexTY8J8987E6WLFHN9bVNqdG2utmItF4LnCrL
   8IQBmOonbITIL6l/j8l9yobdIrOWILwIcrAavyD3IazyFnna7ZzEp7wck
   Qh7STuILf7q8Y7W4Yks2R+kEFhz0RcMVR752fnzP3amO9Z6cMOicAsYtu
   Lk45d0qQvj1f5DijlG+DEXVPCAH+Kd8efjhwCWLjG/eJCvdMyCEvon0vv
   3PtGoYD6qXdb49AZcv8hUqobhwSdEweU1lR/2BUpy0fZerPLhj5uo9+MB
   A==;
X-CSE-ConnectionGUID: aYVqDYtIS2aZYILkT+b2Tw==
X-CSE-MsgGUID: 0xOAwtQBQWiJbmL++bRf/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="823403"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="823403"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 03:46:50 -0700
X-CSE-ConnectionGUID: kGOETs84QuClla25mJZSiw==
X-CSE-MsgGUID: F4iwqtJkQ2S5LNynjY90DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1366374"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.236])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 03:46:44 -0700
Date: Wed, 14 Oct 2026 13:46:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Hans de Goede <hansg@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa systems
Message-ID: <as9dkrvJbyMwkKol@ashevche-desk.local>
References: <81b4f4bf-b721-4b5b-8ddf-d040865f02b2@amd.com>
 <20261013224010.GA1589480@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261013224010.GA1589480@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 05:40:10PM -0500, Bjorn Helgaas wrote:
> [+cc Hans, Kai-Heng, Andy, linux-acpi]

If you want my opinion, I think that Mario's quirk series (with the revert of
the 07eab0901ede) [2] is the way to go. I have not much time to dive into this,
though. I also have no HW to reproduce either of the problems.

> On Tue, Oct 13, 2026 at 01:59:23PM -0500, Mario Limonciello wrote:
> > On 10/13/26 12:26, Ilpo Järvinen wrote:
> > > On Tue, 13 Oct 2026, Mario Limonciello wrote:
> > > > On 10/13/26 12:00, Mario Limonciello wrote:
> > > > > On 10/13/26 08:09, Ilpo Järvinen wrote:

[2] https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/genoa-mess

> > Bjorn, thoughts on this?  I'll send it out if that's the way we want
> > to go (or Ilpo feel free to subsume into your series as it's only
> > really exposed by your series at the moment)
> 
> I would LOVE it if we can use those patches because it's way less
> magic than 07eab0901ede is.
> 
> But I'm frankly terrified to touch it because I'm skeptical that two
> more quirks are enough.  I just expect that whatever strategy BIOS
> uses to build these maps is likely to be used on many models.  I do
> hate 07eab0901ede though, so I would love to see it gone.
> 
> I do think the description [1] is overly specific because AFAIK
> there's nothing that connects this to AMD EPYC 9354 or igb other than
> the fact that it was seen there.  It could happen to any PCI device on
> any system with similar memory maps.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/commit/?h=superm1/genoa-mess&id=0a49c704477153d6597d34b3c6e3141007ff058c

-- 
With Best Regards,
Andy Shevchenko


