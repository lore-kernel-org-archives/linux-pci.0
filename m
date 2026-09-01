Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E396472530;
	Tue,  1 Sep 2026 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252284; cv=none; b=PNWqwftbk5omNXVoinviAQoziN100WZfBOZd9xkdwncOkvpdG985DrRy1mCO1h25h1FQCkhfGecMS+qiMOTl1A5eFkzwewPud2xYuX1itwzJ/NgWocZwLD3fNBEnsLfJseQx4hUnQSJjAwfTXUYuJurAg4LgF/k3QG57Yt3Ei/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252284; c=relaxed/simple;
	bh=2cHSBW63AdgeodvD37ubEWti0aeNOHuF9v35mxr2pUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTffg9vOL5P+uT67ytqndcgt4Kf9gx0yh1krXoWdI3XkceOYV2VYi0tRka7Z3btAPDi/cAyUq987vrHhQfVZASElep9puv9QgilzIg4qi1Scvg2k74M5Bp/+O05FftZkGPsuDbxS4HoELmRWr2HNi5xcds3Rw9CU+sZ1MwUxIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuwuPSqF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuwuPSqF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788252279; x=1819788279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2cHSBW63AdgeodvD37ubEWti0aeNOHuF9v35mxr2pUE=;
  b=fuwuPSqFmzI3hDIarCAxNrT84VQe8HV74TH2r/BN43XRjy1DUqKWCOrN
   4EQMDH+QLCcEvBjJ6AcGtZ+qdyT4MNXRv/bhFOLu0qT/dK/gwqCCUu4gh
   OjcX6TxCeSwspaQtyOPt2liilpqVrFx+VvakbKcIdosYAF1TT4pDqEHpx
   Swp+amKvMvAvDD+q2F5xIy/mb8cMJuzxjLuEpHgzODOCaCzEY4YVakth+
   dXhwcqWuRbRpvp7cWALSpAkXaYMbolQyUieuZWK5t6LXC4A1VYDZSsChv
   nHGJXhU/CFVZeXbz9Ba9SYY1ESrIkzmxf3n2kNXwXAxpfuqNUOoaYOUk/
   Q==;
X-CSE-ConnectionGUID: avdOkTK2QX2soF8d37hFLw==
X-CSE-MsgGUID: hj+92kFsSAqXrYMFzSChFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92541326"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="92541326"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:44:33 -0700
X-CSE-ConnectionGUID: KOe+vt0tRKKd2Zb6OdHn5w==
X-CSE-MsgGUID: DzjV9TXDShasA+l7KOJpwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="265314817"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:44:28 -0700
Date: Tue, 1 Sep 2026 11:44:22 +0300
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
Subject: Re: [PATCH v1 7/7] ACPI: scan: Take PCI device enumeration into
 account directly
Message-ID: <apaQZr71mBe0_3fU@ashevche-desk.local>
References: <3435655.aeNJFYEL58@rafael.j.wysocki>
 <2497062.NG923GbCHz@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2497062.NG923GbCHz@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 07:59:48PM +0200, Rafael J. Wysocki wrote:

> The ACPI companions of PCI devices are associated with the corresponding
> PCI devices before being processed by acpi_scan_attach() and by the time
> they are passed to attach_subtree(), the PCI devices associated with
> them have been already enumerated and initialized (including power
> management initialization).
> 
> Accordingly, it is not necessary or even useful to check their status in
> attach_subtree(), so do not do that.

...

> +	if (pci) {
> +		acpi_handle_debug(device->handle, "PCI companion %s found\n",
> +				  dev_name(&pci->dev));

We have pci_name().

> +
> +		pci_dev_put(pci);
> +	} else {
> +		acpi_bus_get_status(device);
> +		/*
> +		 * Skip devices that are not ready for enumeration (e.g. not
> +		 * present).
> +		 */
> +		if (!acpi_dev_ready_for_enumeration(device))
> +			return 0;
> +	}

-- 
With Best Regards,
Andy Shevchenko


