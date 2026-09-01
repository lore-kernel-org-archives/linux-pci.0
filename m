Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4646DFF4;
	Tue,  1 Sep 2026 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251386; cv=none; b=Gg+jrb+grAtfE2CzsEzRPPPbUqC+7wnSWFrZnsMxXCXoW3a0xk0fEHZHbtJ39/LbQSOmmxD84j5JNRmiZ0e5sr6U7njAGeF3mSKWiEjrBujkG3lSuvVKbTLDG2xec6JGB+9bQt1LwFFjnVm3Bnf56qATNtFwdDv9iwCIJUs8MRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251386; c=relaxed/simple;
	bh=XmxTWDIL/rVFbnbeiEcsAElIF83xR/cBl0UB35kcNf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5gNdOTIPNLxRhKNycW6KRsIOtxjvh2tE54bLnn1sTXn1Ow7vtEc/Vck0Uw6fQusIZXZgntTs/wWBBmQx/6Zdf8JaVduTWJPuEanTIIqsW/Qsot0mAdUr95rAndVmgitEBpYnxbMcS72JMv94LKwgkyXdjTphorGVI+CKfY+dzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjvvEWpe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjvvEWpe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788251384; x=1819787384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XmxTWDIL/rVFbnbeiEcsAElIF83xR/cBl0UB35kcNf0=;
  b=QjvvEWpeWPmZda4hwEhYaj/hoa2WMT9+pFKTyxotxEX1CjE4SCpAOPEI
   CZjNH4h0pWR1xQPP5WNAGHqwxVw8Q+r1YhCksQ+cKCYlMFLTYD9/m5IhN
   GVLqkL2gCNZ/UQtkyGaz7dHV5pD4b+2QTuTjdNVK7y2kndmqC/qoXIBuH
   qzRiVL7TIbc6tHAj8mKGZZD5SXLJb5A8UWekpTPs/UnwlXve+EpVeL0d4
   3q/kZyMCTd65ojTtbWML71n6evJVGy3/BZ2Magpa2I7pnE77KKd13YdPW
   4TS/deBIGoEacNuRy26zU3syq/3p9NEU/+1UrhgEXUxV23DvRYvnm7tBT
   A==;
X-CSE-ConnectionGUID: wGxtPwumThSeItU6+Zb+dQ==
X-CSE-MsgGUID: /In2Bs4+SeC1c/TvOhfqcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88682836"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88682836"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:29:44 -0700
X-CSE-ConnectionGUID: 9/8ZFSOJRRuJMpvXxrr2Dg==
X-CSE-MsgGUID: d6VnVzcLQimzWwuqiuUoSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="272541410"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:29:40 -0700
Date: Tue, 1 Sep 2026 11:29:37 +0300
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
Subject: Re: [PATCH v1 2/7] ACPI: PM: Introduce acpi_device_init_power()
Message-ID: <apaM8fsWKaGPRWxD@ashevche-desk.local>
References: <3435655.aeNJFYEL58@rafael.j.wysocki>
 <2055986.PYKUYFuaPT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2055986.PYKUYFuaPT@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 06:25:52PM +0200, Rafael J. Wysocki wrote:

> Two out of three callers of acpi_bus_init_power() need to clear
> flags.power_manageable for the target device on errors, which
> is somewhat cumbersome, so rename the function to
> __acpi_device_init_power(), add a wrapper called
> acpi_device_init_power() around it that will take care
> of the flags.power_manageable clearing, and make the two
> callers of acpi_bus_init_power() in question invoke that
> wrapper.
> 
> While at it, clean up the declaration of local variables
> in __acpi_device_init_power().

...

>  {
> -	int state;
> -	int result;
> +	int result, state;

Not sure if this change is required.

>  	result = acpi_device_get_power(device, &state);
>  	if (result)

...

> +int acpi_device_init_power(struct acpi_device *device)

Ah, here is a helper!

> +{
> +	int ret;

Elsewhere in the file it's called 'result'.

> +
> +	ret = __acpi_device_init_power(device);
> +	if (ret)
> +		device->flags.power_manageable = 0;
> +
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko


