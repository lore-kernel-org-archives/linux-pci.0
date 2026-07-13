Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392C3382C9
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783976982; cv=none; b=c9wawx/ENcCYLNDmTXdWL/73T52x+rdr3m7QnrxNBGbBtpWgDkkbNnry7EvX0bBgKZx6p9LmIr7XPhY2jWH9luCG3vkyf91X8hiciVHtliRYQULEvEYTPK+UJvKaqkdIkK5v+SvAY4tuhvRTrO+mE9h4fxaL6boUG8QW8GGv93w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783976982; c=relaxed/simple;
	bh=H+tV90uADunieo0tI5Ft2cYrFZTGsrTzRnK/vEQx5eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWtwfDIO7MNVxdej7obK1qvi4O5AIgid/gXSWekwFUJouZxaFmcBQOAfbEUaj5h6NiWXtAqpcKT+f3WBQFW4DEMx0+MKIJmrqHOltPhO3Y4CMLyuurjueIanVq4CC+bc8T0IsUvXDfnB8EVUrrPVDpq9iTuY0mK9ZoQVcLelMfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zt8QmA3F; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zt8QmA3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783976982; x=1815512982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H+tV90uADunieo0tI5Ft2cYrFZTGsrTzRnK/vEQx5eY=;
  b=Zt8QmA3Fl57akTLlRsD9FNqPm/Dza6/f4mPZbz1nt3m4yXRo8Xba9I0k
   cEheFVgJKX4XPFHoB5GHick8Z8lUyCwHEw35P4beLl4PmgaaJvGicRRc3
   wR2X2LA0Px2E3ePoqX/BQlkDK3VOFwOBo9BhaeeJKX9xKicRpWzT/JOvw
   Npr8O0zZwJ72DNuSQO8QyVO5a9rtAdy6o5P3NfrSuqASbfi2e1IDLLBWA
   vuP5IjcNSeJfnOW6lXCE2ENbHd/Rb5Ss7+BGZBWWTUC6DVx6gRO9GDxvL
   51hycqrLPpauy3VYBn/3f7wZInuIPjUKoC3RS+xE6aez5FWef3yEo1Su9
   Q==;
X-CSE-ConnectionGUID: 1B1rKSqSTnuFPteciF4esg==
X-CSE-MsgGUID: AfYFrdZ6Sg6MOviVeHyCtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88273062"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88273062"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 14:09:41 -0700
X-CSE-ConnectionGUID: 58/UWHBOQKOBwRE84aeYRw==
X-CSE-MsgGUID: Nz6AQD0cRFqa0vAcCG59cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="257612682"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 14:09:38 -0700
Date: Tue, 14 Jul 2026 00:09:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Nirmal Patel <nirmal.patel@intel.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, lpieralisi@kernel.org
Subject: Re: [PATCH v2] PCI: vmd: Only assign OSC features in bare metal OS.
Message-ID: <alVUENXUHISGHQ7I@ashevche-desk.local>
References: <20260710200558.499434-1-nirmal.patel@intel.com>
 <alOIyYDz_RhsqT8v@ashevche-desk.local>
 <20260713111457.00006fa8@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713111457.00006fa8@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 13, 2026 at 11:14:57AM -0700, Nirmal Patel wrote:
> On Sun, 12 Jul 2026 15:30:01 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Fri, Jul 10, 2026 at 08:05:58PM +0000, Nirmal Patel wrote:

...

> > > v2 : Added descriptive boolean and removed period from commit
> > > message.  
> > 
> > It's still in the $Subject. You probably misinterpreted the
> > comment(s).
> My bad, i removed (_). Let me correct. Is (_OSC) in subject okay?

I believe so.

-- 
With Best Regards,
Andy Shevchenko


