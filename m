Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088236212C;
	Tue,  1 Sep 2026 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251266; cv=none; b=DCysUEeS8MeoO2gpG53HGY6kcScTv3mX9vZluAaDB7yojPc2CnkJ+srduurSC23GSXjbCCvC3dREX0LDft1gQng4YZGL1qxOvoeIIYYfe9zOctWEhR0sfO8wjm3Xs4eFMYyHEK1QmSId5WtHziCpcuTo7sU9jWrjVIp91yn+5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251266; c=relaxed/simple;
	bh=VlVd5f+Dr3shTQwSK1Y/zx9VfLvysp9BB/o6Z+senRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIaU4Opu5UwW9+aLiWxjRjxCTFhA3D46Dp+ObjFB0ddA/dV8UQUw5M40vPSF7Kb230c24au0b5xPfGILHeKNept5uDf5CmAeSK24IE1lj3CG09jgr/wiCKqHAZtpzRSrnkrGC+rywkqin30LrBeltby6b+IitPRGZ1Q00pScG+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qy2Nc6tI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qy2Nc6tI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788251265; x=1819787265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VlVd5f+Dr3shTQwSK1Y/zx9VfLvysp9BB/o6Z+senRc=;
  b=Qy2Nc6tIELK7ppSYyb67L7dDWJqhyRRJNivCHacxtes5/S8c8+Ckh7XU
   vDDfXYyzbgfDvc4NcjxnhAG3LlcnAAr259q1+5QKEQvj7Jwk78DDCcCO1
   CgfuNlpilBxMMvaW4lL0GF1vdpTiTG8uwV1eOtp15aDDXLSGRLqGZGxHR
   1sqauGZy7T+DdeNeQb28rVp6GoZZnHuKgRjGFPIKXNfDiwBdHu0KF1QB1
   2UXdM5z0BPTP+BV2xf5SLYBTv/clv0RybkV2f9rIiimXQhMqwZqaZWWsa
   tqKtSXzZqdF9unDaiT5s2B9UUH0IbI71wmFpQ6UrHEIs2Ah5fL82RVmVQ
   Q==;
X-CSE-ConnectionGUID: 6cKkun2iSDCGjZ7O1gk6Fg==
X-CSE-MsgGUID: BhYvm5e8TYK/qKi4/8DDXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99330638"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="99330638"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:27:44 -0700
X-CSE-ConnectionGUID: FCsxjfrIQdCN1xpeMgZAEQ==
X-CSE-MsgGUID: W2wU7We0Tk+Wegq+G7hx6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="274299076"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:27:42 -0700
Date: Tue, 1 Sep 2026 11:27:39 +0300
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
Subject: Re: [PATCH v1 1/7] ACPI: scan: Stop calling acpi_bus_init_power()
 early
Message-ID: <apaMe1A_h8wOYX4_@ashevche-desk.local>
References: <3435655.aeNJFYEL58@rafael.j.wysocki>
 <10913616.nUPlyArG6x@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10913616.nUPlyArG6x@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 06:24:45PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> There is a problem, introduced by commit 9d9bcae47fd5 ("ACPI: delay
> enumeration of devices with a _DEP pointing to an INT3472 device")
> inadvertently, that causes devices with missing dependencies to be
> put into power state D0 prematurely on some systems [1].
> 
> Namely, acpi_bus_init_power() called by acpi_bus_get_power_flags()
> during the early initialization of ACPI device objects, may discover
> that all of the power resources needed by the given device to be in
> power state D0 are initially on, so it will reference count those
> power resources and transition the device into D0.  Later, if
> acpi_bus_attach() running for that device notices that it has missing
> dependencies, the enumeration of it will be deferred and its
> power_manageable flag will be cleared, even though it is still in D0
> at that point.
> 
> After the dependencies in question have been met, acpi_bus_attach()
> will run again for the device and now it will call
> acpi_bus_init_power() that will take additional references to the
> power resources used by the device in D0.  These additional
> references prevent the power resources from being turned off when
> the device goes into D3hot/D3cold.
> 
> To address this, stop calling acpi_bus_init_power() from
> acpi_bus_get_power_flags(), but also take the initialization of
> PCI devices into account, which needs to be done because they
> are initialized and bound to their ACPI companions before
> calling acpi_bus_attach() for the latter.
> 
> To that end, notice that each PCI device discovered on the bus
> is put into power state D0 via pci_power_up() which involves
> invoking acpi_device_set_power().  The initial ACPI power state of
> the device needs to be known at that point to carry out the power
> transition of it properly, so modify acpi_device_set_power() to
> call acpi_bus_init_power() upfront if the device's ACPI power
> state is still unknown.
> 
> Also use the ACPI power state tracking to decide whether or not
> acpi_bus_init_power() needs to be called by acpi_bus_attach()
> instead of using the "initialized" flag of the ACPI device object
> for this purpose, which is fragile and inconvenient, and stop
> clearing the power_manageable flag for devices with unmet
> dependencies, which is not necessary.
> 
> While at it, add a debug message pringing statement to
> acpi_bus_init_power() to facilitate diagnostics.

...

> +	if (device->power.state == ACPI_STATE_UNKNOWN &&
> +	    acpi_bus_init_power(device)) {
> +		device->flags.power_manageable = 0;
> +		return -ENODEV;
> +	}

In this form it might be harder to catch the side effect of the conditional.
I would split it into two:


	if (device->power.state == ACPI_STATE_UNKNOWN) {
		int result;

		result = acpi_bus_init_power(device);
		if (result) {
			device->flags.power_manageable = 0;
			return result; // shouldn't we instead of return -ENODEV?
		}
	}

...

> +	if (device->flags.power_manageable &&
> +	    device->power.state == ACPI_STATE_UNKNOWN &&
> +	    acpi_bus_init_power(device))
> +		device->flags.power_manageable = 0;

In the similar way. And it might be even worth to have a helper to deduplicate
this check and setting?

static inline int ...()
{
	int result;

	if (device->power.state != ACPI_STATE_UNKNOWN)
		return 0;

	result = acpi_bus_init_power(device);
	if (result)
		device->flags.power_manageable = 0;

	return result;
}

-- 
With Best Regards,
Andy Shevchenko


