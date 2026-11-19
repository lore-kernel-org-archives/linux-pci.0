Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108197;
	b=xiEQRYzcJ7KE4/FvgQfL+PoRxfHaj5z4TNYFw5+PGYi79fwlj8TZsGkvZfu/ZLekHBdc
	 /GZsre6LnZvqcc7rcv22wqsK0CQqKcnbeke6FjAnXQR3x7/7KjKNPk9bPY0hh6T/xJ9Hq
	 6Y2gcDE6HcW1WXhO6LktbzTn5IvopoONk0p9lMT12MSawPF3iFGDfUGgFQXPaoTSAsv1U
	 39NG397bZDOIBZuzajS+R3bOEhztFtThdq0hPDXqbIfqD2zJQwn2XwqKFvSCTf4XVITTo
	 mBI7t0IvMnijxEv2gbSDP8pH+9P2cpflvAJI9ac9o9tKoGR9v3v9NFKdLDO5FygompQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108197;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=3NTavAa9uvZzFgLNNzt7xQH73wEGU3Y+0dnqwUUM7VA=;
	b=qMi3TrcXA8aUDrR3vDIZXPPt0AwECR6SDX/TPT40TEX/mSku/fULIreyePSJUxD8uWOB
	 LhttBc2V7yd4iA5zxY6DQAEzIVIbEj6I0yZq1aMVj4luOz1uB2SjK5OOdVVTuyk+OTqoJ
	 qSVmJv/GNpzDb5zoBKoqlYZqcHdeituGv5hggOgENpjW7sUDUVxo4JB/gBeUjnpUajMKp
	 Cl+Mcf5brjUNJM8iWd9ETRJwfXgRhgbALqFEr8hpk5CLHjdUkcQSZRsSaSZCd6HH/PSUF
	 Hv125CYMqbN7RMzA0AdfKXcnZwADa/vxVkCdUEAl98eQxaefxkiBdVIiXNR1gDpM6RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sz4cnTdE;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE660A2610;
	Thu, 19 Nov 2026 17:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EEE660A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sz4cnTdE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795108196; x=1826644196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AHh+Yi2ZFE/PPeu7El1ixQ5cdUzfhxtMKu9lHFo7O+c=;
  b=Sz4cnTdEy1CFVYaiRvLWCs9Mjh//q23n9qJGY4NHRx4ZvfeN2zL7T5XK
   Ucz/h5Y65a0DmHt/WbtdXr2bWVmQvuq1B38qy9bYLdAs27y5LOfLCG2m0
   XQoJSiD42hV6vHH0rposw+c9SLdJ139Lub4ZBVbhhb75J6lpYrQnSY/QV
   RlAJiI9MbMIEiiw9T6D4tveq+IK/jtgKymvNFBq0UXMmPnmhXfLXZn04u
   deYlEYk7Rrr53X5BRbyBhfiunVAbVL/wgxRaNp866nYlJEXefkh9Ayjce
   iqI4navvFMM8kV2oFcENGklIi8xfsmhoXKx5nHgA/UAKjwwjXHYtpWMti
   A==;
X-CSE-ConnectionGUID: nIruRNfkTDG0L6YX+d7vJw==
X-CSE-MsgGUID: w5fZpLjNS2OS4vwCUDYMgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3974999"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3974999"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:09:55 -0800
X-CSE-ConnectionGUID: Xed9eTLFQUaJKpkoYiDEmA==
X-CSE-MsgGUID: vpoAfa6LSVulKiVtVhknkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10367018"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:09:52 -0800
Date: Thu, 19 Nov 2026 19:09:49 +0200
From: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To: Habil Eren =?iso-8859-1?Q?T=FCrker?= <habilerenturker@hotmail.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@kernel.org" <tglx@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 2/4] PCI: Convert pci.c to pci_power_t helpers
Message-ID: <av8tXbagXZeM443k@ashevche-desk.local>
References: <cover.1795097970.git.habilerenturker@hotmail.com>
 <68e76d8e17030a21d3ee6df2f2109057f75147fd.1795097970.git.habilerenturker@hotmail.com>
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
In-Reply-To: <68e76d8e17030a21d3ee6df2f2109057f75147fd.1795097970.git.habilerenturker@hotmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 02:35:48PM +0000, Habil Eren Türker wrote:
> Convert PCI core code to use the pci_power_t helper functions
> when accessing the Power Management Control/Status register.
> 
> Keep comparisons between values already typed as pci_power_t
> as direct typed comparisons.

Please, add a couple of examples of the sparse warnings.

...

> -	state = pmcsr & PCI_PM_CTRL_STATE_MASK;
> -
> -	need_restore = (state == PCI_D3hot || dev->current_state >= PCI_D3hot) &&
> +	need_restore = (pci_power_eq(pmcsr, PCI_D3hot) ||
> +		dev->current_state >= PCI_D3hot) &&
>  			!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET);

Please, fix indentation.

	need_restore = !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
		       (pci_power_eq(pmcsr, PCI_D3hot) || dev->current_state >= PCI_D3hot);

Or create an additional temporary variable.

	in_d3 = pci_power_eq(pmcsr, PCI_D3hot) || dev->current_state >= PCI_D3hot;
	need_restore = in_d3 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET);

> -	if (state == PCI_D0)
> +	if (pci_power_eq(pmcsr, PCI_D0))
>  		goto end;

-- 
With Best Regards,
Andy Shevchenko


