Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067DD3A6B82;
	Wed, 15 Jul 2026 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131192; cv=none; b=LeHAAp4P9kQTM0k3v1hlOeLsdI9xO2Vo+oYnM3tflJ0dPb1IYw2p8fv69Aj/K5eVZPDTzoAaWwL8Mvuvf0SdqFMEnOeiPMOV5vHzYY23KgN7mnvbuZ+pCCRokdQw3p7m0NmifxbLQI+A3HNLKx6wom6Z2H1gDVqO5et2ohTQqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131192; c=relaxed/simple;
	bh=evAaUEcf/ML705pgRZC4cWv/KT5O3EOHXUsIEBBt63c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uP56HJAMj53fgtVcqFbTyOZ3JE9aszMDloy1IveuoolhC1Iq1k1pcEkT4VDbeZh/N0rr8nt4Ffm5dui8cPDguAbCDj44AuSeNBjlCTyuHJ4i8bjl6M7RjHcquEXtL8s3KjLIJS/pT0ekh0nMXAl5BjXgH3/8eopbDFtIc2yGU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+bHjFVb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+bHjFVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784131190; x=1815667190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=evAaUEcf/ML705pgRZC4cWv/KT5O3EOHXUsIEBBt63c=;
  b=V+bHjFVb7XsTtQcwirZAR0Rsg5OyL2Bxl8SGSDY4tLjeE2BEP693PReV
   zd6+H3o/cnfHFarbPH8QjtBuIndWIOAv7i5oA2SytzTRMmPL3RDtjg5K0
   MYwzgVgCdZ8SQ1JaRzNC9cWuW6mgWaBEwFy5+GvYeHi1hBabQgUXQ6CxJ
   OiewWWL107wWpMIZuEfhoXTl2p9WOxBbDShmGupdk5piaX0pQW4ZWXBD7
   Bj3T5qtJoWZ6Nkj9oI+E2KgXwNB+uwcfAjKLeBgoNoQhkl13+sV/QGt7D
   6rD/VyAPzanWCL1EnTvsbbN9oMIUe1b68tDQz2EMjOxKstSfJEWtweZqL
   g==;
X-CSE-ConnectionGUID: CS+daM/2RGqg+o1n0/kWDg==
X-CSE-MsgGUID: CLsuXw/XQBS8vBFH4hwbVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84733270"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84733270"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:59:50 -0700
X-CSE-ConnectionGUID: ZNHLRS0zTGWPd8rs60KVEA==
X-CSE-MsgGUID: MOaCe0XPRQ2ELhJjsij37g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="249857372"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:59:48 -0700
Date: Wed, 15 Jul 2026 18:59:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v1 4/4] ACPI: video: Use acpi_dev_get_pci_dev() instead
 of acpi_get_pci_dev()
Message-ID: <aleucS8bSeEveCDZ@ashevche-desk.local>
References: <5115219.31r3eYUQgx@rafael.j.wysocki>
 <8706171.T7Z3S40VBb@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8706171.T7Z3S40VBb@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 05:21:23PM +0200, Rafael J. Wysocki wrote:

> In acpi_video_bus_check() and find_video(), simply replace
> acpi_get_pci_dev() with acpi_dev_get_pci_dev() that can be used
> in both places because the ACPI device needed to do the lookup is
> available.
> 
> In acpi_video_dev_register_backlight(), instead of doing a parent ACPI
> handle lookup based on the handle of an ACPI device that is already
> available, pass that ACPI device to acpi_dev_parent() which is much
> more straightforward and pass the return value of the latter directly
> to acpi_dev_get_pci_dev() to get the PCI device associated with it.
> That allows local variable acpi_parent to be eliminated.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +++ b/drivers/acpi/video_detect.c

>  	if (acpi_dev && !acpi_match_device_ids(acpi_dev, video_ids)) {
> -		dev = acpi_get_pci_dev(handle);
> +		dev = acpi_dev_get_pci_dev(acpi_dev);

This likely needs to be rebased on top of the series I sent?

-- 
With Best Regards,
Andy Shevchenko


