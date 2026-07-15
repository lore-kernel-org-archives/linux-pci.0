Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3E2F83A2;
	Wed, 15 Jul 2026 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130786; cv=none; b=BnQdnrI57NOKjd+L2FYbjfYPteZ8f0NheDlVsbKXrssHKMv6yZ0H7EgnvBrtZhaXPflr6cs1guKPJqgt8zre7mIaSIC97GXQfZbrf4JetY1LW3MrwUqxDqit9gL9psiBPo4Eg6NYe9rKqbqOIubS2Z3versjX3cm135dqdvRhjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130786; c=relaxed/simple;
	bh=4L+0zwVkhqHN4iP7P1uMvG360zTk3aseXj0feS5u8CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYrbxbSy6AdGI/6QwVyXZedF+5dIlqslU++p/q46XzG0yjhCiaaBkYa4bHxNKUl+1nLXZ6Fc02GvWEu+QoOiR1mR4rOeVurcK+KhbYcmHJlsR1lfJHQUY/Ah2qFyYgowFCq7Z99I24bKasn3iJL9JsRc4YiigjHObXdzXGCfzN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E525pRL5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E525pRL5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784130785; x=1815666785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4L+0zwVkhqHN4iP7P1uMvG360zTk3aseXj0feS5u8CU=;
  b=E525pRL5yIkyCKbdkET0uVYc4PC9fC1l1UFme1rFPqUlP0OwPRGx1rz0
   P+9IZo14O1hkVeMFb5C9Yp2UtD+oda9ppvfxwXjUShPJkw7p8WAdix/Wb
   WIdLNCG1FklWNlrSW1TNtSMzqQO8XNxPRh/LYizaDlYptDw2R8Z99YR2p
   VI7DFg2MlhYlflyo+ZtM1n780cZasbz4ylFOQK+4+8Y1BRwgsO/niPfFD
   sdMCj4MNrZRJbViwerCNcsFEri7aNuA3BgXKDcd5kEv/NTqkGHfdoYsdq
   7dmK3Kdjn86KvFLm0S8b7ha5Lv9NVdSz+vE+yAiC18bfAH5gAaVIR0ifi
   w==;
X-CSE-ConnectionGUID: KnbFP1WdRMOIUK7zkINKEg==
X-CSE-MsgGUID: 3fv9Jn9OQT6Ed6jEBIi4oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95127082"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="95127082"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:53:04 -0700
X-CSE-ConnectionGUID: PiqTB6kERnihDp7csf+c2Q==
X-CSE-MsgGUID: 6LPFk/ZUS/yFwZ+WEGlQdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="286298867"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:53:02 -0700
Date: Wed, 15 Jul 2026 18:52:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v1 1/4] ACPI: PCI: Use a mutex guard to simplify
 acpi_get_pci_dev()
Message-ID: <ales2zV0uFJy5sOw@ashevche-desk.local>
References: <5115219.31r3eYUQgx@rafael.j.wysocki>
 <2417350.ElGaqSPkdT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2417350.ElGaqSPkdT@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 05:15:02PM +0200, Rafael J. Wysocki wrote:

> Use a mutex guard in acpi_get_pci_dev() for the physical_node_lock
> locking and drop local variable pci_dev that becomes redundant after
> that change.
> 
> No intentional functional impact.

...

> -	mutex_lock(&adev->physical_node_lock);
> +	guard(mutex)(&adev->physical_node_lock);

This needs a cleanup.h to be included (yes, I see the current inclusion block
and it's a mess :-( ).

-- 
With Best Regards,
Andy Shevchenko


