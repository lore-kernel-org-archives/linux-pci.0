Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329FD48BD40;
	Wed, 15 Jul 2026 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130971; cv=none; b=UAb417XeLXBsSztBxx4Jk0vz3Y+fzerK9oHqttaJ+NIcuHP29ozoMqSFKXJBlJcSBh2y3Zlgz/jlSs9vmTvTkiymT4tNA9ykWpG0d775i59QRiJP1Apwqtm3hZAvPybqhWHNeRDbrwuDabotj4jzYhJs/VfV6oXZXmh8eiTF2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130971; c=relaxed/simple;
	bh=9lqOVaKzGpbbVVDJ2lrh0CWv2rtdug5FrFYTL3iQZdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puSfSTUzKrqfvZVCI+0LTuC/oFvRXyXo7ddjLn0MXFbjiIQeC7JIYmk06jCy6phh1h6l6KuHkQkGga4P9FzqYGlUE/J74UoAhxZyuue8FOcU+Rl0r98GKZPBo7R5JdA2Yqkm+AQbscERLjzf3Gck5pJd0LbvorT0y82ovNWrlSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chumJ+VU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chumJ+VU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784130968; x=1815666968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9lqOVaKzGpbbVVDJ2lrh0CWv2rtdug5FrFYTL3iQZdI=;
  b=chumJ+VUoJ9aS9UEGUp7EmQUObPP16KYDci6N6N2u7LUcrQbiqNEsE+I
   8PejJIzoBlhoTAKnCipW3QMsGzHlzvW36s3+qJmr5wzlsJjTOf71bxmBK
   bNZKm0ayIhaJJiseSMzlZkA2jwma4rJxjqACNUqxx0aMOlSCfycdNEcSf
   w2GCm5tK4VQTGyCBXCzgOKrbrT27GYI8ovz8RE2f0sjPgOvzQGYtD12pm
   qNz+oyFM95faQZPSa8wEe5w8tHHtEswpHPjXsF+M7NON5bPL50ObsJk+5
   FraID0SvcGa1uczwBLy++pm5BPVcXarCAfLOSiLbRsprLhFFg6nM+17UE
   A==;
X-CSE-ConnectionGUID: kZENqTIeSLik5Z6wxZprWg==
X-CSE-MsgGUID: Al+zsKOHSvSXOb7/li8akQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88675954"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="88675954"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:56:06 -0700
X-CSE-ConnectionGUID: WRRvbJsMQUa/h0EvdxMjNw==
X-CSE-MsgGUID: am+92PyHThC/hTkw4C81Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="261118926"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:56:03 -0700
Date: Wed, 15 Jul 2026 18:56:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v1 2/4] ACPI: PCI: Introduce acpi_dev_get_pci_dev()
Message-ID: <aletkRwD7QKDJE5y@ashevche-desk.local>
References: <5115219.31r3eYUQgx@rafael.j.wysocki>
 <1961532.tdWV9SEqCh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1961532.tdWV9SEqCh@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 05:16:19PM +0200, Rafael J. Wysocki wrote:

> Some acpi_get_pci_dev() callers already have a struct ACPI device for
> which they want to get the struct pci_dev pointer of the associated
> PCI device, so they don't need to look for one.
> 
> For this reason, add acpi_dev_get_pci_dev() that will get a PCI device
> for a given ACPI one (if possible) and turn acpi_get_pci_dev() into
> a static inline helper passing the acpi_fetch_acpi_dev() return value
> directly to acpi_dev_get_pci_dev().

...

>  /**
> - * acpi_get_pci_dev - convert ACPI CA handle to struct pci_dev
> - * @handle: the handle in question
> + * acpi_dev_get_pci_dev - Get a struct pci_dev for a given ACPI device
> + * @adev: Target ACPI device.
>   *
> - * Given an ACPI CA handle, the desired PCI device is located in the
> - * list of PCI devices.
> + * Get the first PCI device associated with @adev, if present, and bump up its

What is the meaning of the "first PCI device" in terms of ACPI specification (and
implementation in the Linux kernel)? I think it's impossible case to have more
than one object to be a companion to a PCI device. Am I wrong?

> + * reference counter.
>   *
> - * If the device is found, its reference count is increased and this
> - * function returns a pointer to its data structure.  The caller must
> - * decrement the reference count by calling pci_dev_put().
> - * If no device is found, %NULL is returned.
> + * Callers are responsible for dropping the PCI device reference obtained by
> + * this function.
> + *
> + * Return: The struct pci_dev pointer of a reference-counted PCI device on
> + * success or NULL on failure.
>   */

-- 
With Best Regards,
Andy Shevchenko


