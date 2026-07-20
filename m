Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6BC3D79FB;
	Mon, 20 Jul 2026 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541084; cv=none; b=QZBFaQtnIFSUnambOwW4qklWXRSoa2RJfBtXphEiDK8BM7F025acu3VmexPWdQX0QQ+SYhrmlDZkF7rMc2aU2NUcBwQSLmkjbb3FamyqMCLLnO2PBzmIQnFC3D3aBlkYEjHH9mY+THslppvo7lj1319FqyXtoaDAftVHZh32neQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541084; c=relaxed/simple;
	bh=/GSrZLzHLAwJoAuaU+EelKF/9lrhUVZsoCwr10rnRsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIWMWM8M1vCU5DHo4U5mYQ00NMnn2MrIm7B6rmTLneQ3Gz2/cPcSOYuvzKVcuZ6X137D8NB+761JSKueokWygq1YYR66Gr9fGkB4EkkryYRmYbp97h5o632NJ6vctq7SN1+TOvuUF/ixD78aMwEFnSXiRXJl+lPJr/wFWpXOxlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSWx/6O2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSWx/6O2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784541084; x=1816077084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/GSrZLzHLAwJoAuaU+EelKF/9lrhUVZsoCwr10rnRsU=;
  b=nSWx/6O2zZJ7sjfg6d69j2kkKp1ubRqwk1x2lfxr9L5P0XKB9N1uZQgk
   25slxR+oeLdlKsHVtl9OeSY5AgM+TxnKkZeBm1TDopUYYhqPJ/Lv0NHQR
   zLVvM8FhFjSl1n14Sjt7AM2SVam93RK9p+AChGclz+vBl/a+44LeLuIdf
   z9V5TaPI9yliRveWYkSmosAt2LX3og58zhCLAGihUMPvZxMHimd9Ie+5p
   nxMgytTKM3Qig0Y4NB/rZheEbCctopSIIZpZ6UXg/jYibgZHmMijq3nSZ
   yJMdoY0DEuufEkENtFXXAWWpcEQHZSzgTFl/1juIea29jCloZ14dBcuo0
   A==;
X-CSE-ConnectionGUID: mXUUhgRwTBKE1l8oR9zFVw==
X-CSE-MsgGUID: 2OGbnS93TQieuSxz2jd/ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="95476740"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="95476740"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 02:51:23 -0700
X-CSE-ConnectionGUID: wz5N29qhQXG9ojqwuruTYg==
X-CSE-MsgGUID: CEv0O1bZSwGTBKE9MPXPOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="261216343"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 02:51:18 -0700
Date: Mon, 20 Jul 2026 12:51:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-i2c@vger.kernel.org, linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Mika Westerberg <westeri@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v2 5/6] PCI/VGA: Convert to use
 acpi_dev_is_video_device() helper
Message-ID: <al3vlIdpQBBLeTI9@ashevche-desk.local>
References: <20260714185915.865396-1-andriy.shevchenko@linux.intel.com>
 <20260714185915.865396-6-andriy.shevchenko@linux.intel.com>
 <c7c0e201-0b34-ac87-232a-548b0307969a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7c0e201-0b34-ac87-232a-548b0307969a@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 20, 2026 at 12:04:04PM +0300, Ilpo Järvinen wrote:
> On Tue, 14 Jul 2026, Andy Shevchenko wrote:

...

> >  #if defined(CONFIG_ACPI)
> > -	struct acpi_device *adev = ACPI_COMPANION(dev);
> > -
> > -	return adev && !strcmp(acpi_device_hid(adev), ACPI_VIDEO_HID);
> > +	return acpi_dev_is_video_device(ACPI_COMPANION(dev));
> >  #else
> >  	return false;
> >  #endif
> 
> How about adding a stub for acpi_dev_is_video_device() if !CONFIG_ACPI
> so this code can do without ifdeffery?

So far it's the only the case where it may gain something, but overall
it's not required, all other current users already implied that. So,
I do not see the value in this churn. When we have more such users,
we may reconsider.

-- 
With Best Regards,
Andy Shevchenko


