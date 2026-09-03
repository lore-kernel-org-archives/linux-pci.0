Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02007429038;
	Thu,  3 Sep 2026 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423161; cv=none; b=eYqmsMHvhIxh5FojO8qodjSUVeCrWFcvP/V/2x9WSD2d1PizEsZ3Rc5mTOHjb677gNTNvfk4kP2hp1TQw/BZPaas6cKzjko8Cn+QwumtsH30xu2YsHhLeazu7Dl0AjrxE2qQB9+eS8f+AA1MUA9Lcx+4FvJfOS+k1Oili1naXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423161; c=relaxed/simple;
	bh=05YqIAB3Hi+10tqPXqbRfid7oamabNtLXWeKZGjES44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cdf5FmRGgmJmWkwDUQ1MAU/2qjxbvDXVOsNrMYVYFgN5J/XHVtHirXW76b+33oFDwDPvSH11yfs19MHuJv//ygtngMXsHMOfXJZ58U9hTXBsmLoU94D0LsfFZkMrwKW9RYcCHgNYVBMoJ92ltWFkmxVigyKrYbRM58CuRpSWXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2t3j1O2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2t3j1O2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788423160; x=1819959160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=05YqIAB3Hi+10tqPXqbRfid7oamabNtLXWeKZGjES44=;
  b=U2t3j1O2GFhr0njUETlUgMXlBhLG57r6e0M8NlC+i6uR1Jx7aRk+isPJ
   0jOIEeU2V9kWNif/2L1Lu9i3RjFls0mJFOzJl9YhO8IIFeBZvAddOk1wu
   e1YfHWeb6Ce3G2i/U/9ToyehR+xcPC62rfSq0ox4ghVS2wedCaUtwntlG
   mqW5BztvqCmOb4HqnbHjvn+FVTSY7Qbam97UZ+6N56tbfkXPHsWIwngfm
   jqPFNWgOW/p3QIE+KuAvvNLkLAHnYa16NTfvzcjPTRhd3dT/e+djimubc
   W67nmtX4CKNsNXNzKV2cRUZ6dTn8jPgnkXzLjnbbxUqEFiAhDQgkqklNJ
   A==;
X-CSE-ConnectionGUID: ZmPAr4pfSo+TiE1t+bSI3A==
X-CSE-MsgGUID: 6PJUlgEdTe6w1YYbRYOeQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99557869"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99557869"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:12:38 -0700
X-CSE-ConnectionGUID: ebcaxZTOTZyQmKhH7pXHsg==
X-CSE-MsgGUID: VSY9bY4eQY6UKBYeZAoSvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="293150793"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:12:35 -0700
Date: Thu, 3 Sep 2026 11:12:33 +0300
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
Subject: Re: [PATCH v2 6/6] ACPI: scan: Take PCI device enumeration into
 account directly
Message-ID: <apkr8cm-Hg3KZ6HD@ashevche-desk.local>
References: <5144065.31r3eYUQgx@rafael.j.wysocki>
 <6207934.MhkbZ0Pkbq@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6207934.MhkbZ0Pkbq@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 02, 2026 at 09:36:54PM +0200, Rafael J. Wysocki wrote:

> The ACPI companions of PCI devices are associated with the corresponding
> PCI devices before being processed by acpi_scan_attach() and by the time
> they are passed to attach_subtree(), the PCI devices associated with
> them have been already enumerated and initialized.
> 
> Accordingly, it is not necessary or even useful to check their status in
> attach_subtree(), so do not do that.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


