Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8A34EF0C;
	Thu,  3 Sep 2026 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420475; cv=none; b=OfJYFvFt405Ju04z2MEx4LsiaT4FFFpcPfhvhzbjE7MO2ZeieGz6FD2s9IkxZgaLbfMERCFCptflwDLUSYxLWuPhuQW5NHmg8+MH7w0GxXvNJ6BlwRoWDVwbUR66LeodsLeySpYVkSWqIWgJqXQB3CjEMTzcRCdTlP9AMZdZdkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420475; c=relaxed/simple;
	bh=V/voFFq9KQLX7kBDBUKWGRZA+L/ydeYxyLBn3t5+acM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiUoMkve+iZ3/GpiOJ+a6Je/fDQbxabPL21aB0fTAr6VIlFMU91AQPy+QeZ70LzFJKJa2uH7fgM1ALhAT0f7tNFOXPDWWyBJP9CUNoPYynBcDnO9VjBGgrXDT5jYtIo8MudsYoofMkj92cOSwedronOQmJFudLX0Mq8EqZ446HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiRPPJw3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiRPPJw3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788420474; x=1819956474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V/voFFq9KQLX7kBDBUKWGRZA+L/ydeYxyLBn3t5+acM=;
  b=WiRPPJw3UNlu8a7EGPV7M7mR7/p1NRVG90hD9TgSRXPBOWwgSpODNObO
   tNHR5KUEwGXLL/y8tZFE4TQb5Umzn9bOFE7lzrx7VabXB9hBinMHcSGDs
   dp8tHx6E9VfBL73dm5Y77A3n/wg/b1byWzuktI/EgyOuyz8A1aFFrf47u
   7Z2eRuICJ0+7/DJid+OClg3TT5OQUn2K36n2ZlemwoF1e7Kk+OIxg2tbp
   KDTcBlzw50I4Vfqr3tlQ159BcAh7jyXc8hUAVWvi+cFI9lSe0lm2Q6t2U
   FLsmsr89jVpCm9jwiGy2kx4trDncN410193p/p4rmcqQnW2AdfbWZOEf5
   g==;
X-CSE-ConnectionGUID: j2zf9v1HS8u/MI1XHuBvWQ==
X-CSE-MsgGUID: 8D5Z8r1nTrK41ISOVH33Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="114434505"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="114434505"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:27:53 -0700
X-CSE-ConnectionGUID: iNFgh2RaSOidy/gagV86NQ==
X-CSE-MsgGUID: fhio3FW4Ta2y1jNVcqvh7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="267043680"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:27:50 -0700
Date: Thu, 3 Sep 2026 10:27:48 +0300
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
Subject: Re: [PATCH v2 3/6] ACPI: scan: Combine two conditionals in
 acpi_bus_attach()
Message-ID: <apkhdHcu45NnkiNr@ashevche-desk.local>
References: <5144065.31r3eYUQgx@rafael.j.wysocki>
 <8743568.T7Z3S40VBb@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8743568.T7Z3S40VBb@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 02, 2026 at 09:30:00PM +0200, Rafael J. Wysocki wrote:

> There are two conditionals in acpi_bus_attach() that can be combined,
> which slightly reduces the overhead and makes the code a bit easier
> to follow, so do that.
> 
> No intentional functional impact.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


