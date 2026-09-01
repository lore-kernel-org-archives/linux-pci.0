Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926DA376A0C;
	Tue,  1 Sep 2026 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252052; cv=none; b=Fe+IJKnKA9eedsw3iWLI2d+9MhztDUeNfu13eXFPQaRKtYu6NyBqGLt5Y+HF+Q0COJKPHZM4MCvws7o1WaEEmrVxcpppLr7o8vfNBp/03R+6wGjWQCSgH7NbU7+Z+JYTLYySMzXmCE188JN6LJfzT/Th8MQFDVh687QvTcFPFwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252052; c=relaxed/simple;
	bh=5XiakXpplk8GoOLAS7psNyW3QXrUDVAxVTxHN8ADh68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovlmcsyLABjxcFzMXTyzlBE92fKtxHPaAo06OaM0Kam4YB++F07AFeUJRieI4UmjYohzlSEKmR6V8O62VrwFhC5KxC3EMKuCzfxXWMbSeLLTaIDqLa1zuzEd2X7VPWl+2r1wu1h0N7OHpWoKgRnu86H8DulO7vODw1do2OZgdMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6nbN+pZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6nbN+pZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788252050; x=1819788050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5XiakXpplk8GoOLAS7psNyW3QXrUDVAxVTxHN8ADh68=;
  b=e6nbN+pZsqA0XrH/zZN87vdIHyrM/pBpxzVAmfr0mqeWBUpSWYPRoYwr
   tweoSyTSdIJErvpS+2nDadGluAukEAZKNWBtlO9rvlX1Xw+XsFzt+AiWm
   u1xr057sOiyanJi6JxNWQq8ne3qF1ujim9QAdjcjAP+6TLE6topQf2t4m
   2Qq75Fmzl7IpIjpf+3ufBcWwXcADlMszFycyHxDg7uzqG2ti2IWXqwf28
   8pZnDiroLc20bvm3VXFkIiaRqPjSRw9e69jso19Tyx9KRgzI0ds9ZhTr9
   NH5QgvWqbb24z6PAHXjXgzYjlkDqJ8i72BP2z3gL/Cf2cC/kIRPqXScha
   w==;
X-CSE-ConnectionGUID: 5tOAbxlHQwWpizDjNdHu8g==
X-CSE-MsgGUID: D9kYKiyPTiC4yM3kbACeJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88722537"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88722537"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:40:50 -0700
X-CSE-ConnectionGUID: EmnUlq1cQOCiv+mWZezLaw==
X-CSE-MsgGUID: DCs01bhUQT+6MvJqY4kkqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="307247761"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:40:48 -0700
Date: Tue, 1 Sep 2026 11:40:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peixin Xie <peixin.xie@linux.spacemit.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v1 4/7] ACPI: scan: Combine two conditionals in
 acpi_bus_attach()
Message-ID: <apaPjaBH48O4V03m@ashevche-desk.local>
References: <3435655.aeNJFYEL58@rafael.j.wysocki>
 <2021470.taCxCBeP46@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2021470.taCxCBeP46@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 07:59:32PM +0200, Rafael J. Wysocki wrote:

> There are two conditionals in acpi_bus_attach() that can be combined,
> which slightly reduces the overhead and makes the code a bit easier
> to follow, so do that.
> 
> No intentional functional impact.

...

> -	if (ret > 0 && !device->flags.enumeration_by_parent) {
> +	if (!device->flags.enumeration_by_parent && (ret > 0 ||
> +	    (!device->pnp.type.platform_id && !device->pnp.type.backlight)))
>  		acpi_device_set_enumerated(device);
> -		goto ok;
> -	}
> -
> -	if (device->pnp.type.platform_id || device->pnp.type.backlight ||
> -	    device->flags.enumeration_by_parent)
> -		acpi_default_enumeration(device);
>  	else
> -		acpi_device_set_enumerated(device);
> +		acpi_default_enumeration(device);

I would leave a longer line (having logical split)

	if (!device->flags.enumeration_by_parent &&
	    (ret > 0 || (!device->pnp.type.platform_id && !device->pnp.type.backlight)))
		acpi_device_set_enumerated(device);
	else
		acpi_default_enumeration(device);

Or even going further and cleaning too many negations (if I'm not mistaken in
the logic)

	if (device->flags.enumeration_by_parent ||
// not sure what the expected ret values here, maybe < 0 or == 0 part is not needed
	    (ret <= 0 && (device->pnp.type.platform_id || device->pnp.type.backlight)))
		acpi_default_enumeration(device);
	else
		acpi_device_set_enumerated(device);

-- 
With Best Regards,
Andy Shevchenko


