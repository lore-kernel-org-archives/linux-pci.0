Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C2D5012B5;
	Mon, 21 Sep 2026 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017176; cv=none; b=s7mpzqQdB9qTYoG/L7G2opjcFm5/rIPOMUl5sHnFO4H8t6buOGyizVPLxzwBTfs/IbeR/nODrSaQwVyj6uG9MgOvarOcwzx2m6053+miM2ix3j+igWvO3H4Kzgl1AV8MMRogOBefqyMq6tvb/hxuZJ50zBazorAEvFj/9ZP4KcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017176; c=relaxed/simple;
	bh=pEJgGk0cH37LV0k9pah/ONK+RZwICyiK2i1EslabjcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOof0kFgeyFVVTOiMu81SgxU7Q8SEMLzBtVRpTMZ1C8Kw8ztFD477QRjIG6rL3Ny8RPJ7SpW44JrH0QuDLKh8Lh4IgYHnpgeYB3MM3ny9tw+5ZG5vAnfAo6MuhXj5f1gkr6/Y4Ae+mfUWeyRwvRp7omkURzzDxF1QhYQLw6QoLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqLC9M2N; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqLC9M2N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790017174; x=1821553174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pEJgGk0cH37LV0k9pah/ONK+RZwICyiK2i1EslabjcY=;
  b=CqLC9M2NY/x0wcSL3nm2Xl76LPvACoP3DF+DS2ex/1f2eC1O/XwO5eOs
   54Z1oY8mqUObZNrfYmjTvtA3tJQJVuMyk30Iyny62NEiMXi59WLROrZ0Q
   fhy6UITsIYT/IHfrnQgWHbDmIHlKpO1y2ljxpFhBKjRMGqYAlphJtM/pU
   6SOPMFhWE/X2aUZY1adgaJWxKCCfMnF3qmAxTQTP7L2bOfO4u15TUtg9Q
   mVrDahpdgLxU3yila4pSRMF0rVdIWHxocvzyQCPMrLF/at6TvfqA7YJ/c
   CHKbI2m17f7k3PxfAbPQ3ZvnpAHcGZtkf6x2e4frct8rWZRAIzNSRxkis
   Q==;
X-CSE-ConnectionGUID: VLayl7JiR0qLOvCgcNGMuA==
X-CSE-MsgGUID: U6p3klJcTfavYMwIhV2U/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="108059005"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="108059005"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 11:59:33 -0700
X-CSE-ConnectionGUID: BsuX840qSi+2vC0YrmPdRw==
X-CSE-MsgGUID: kPAoAqbfTPu69ShvAQyqJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="280861595"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 11:59:32 -0700
Message-ID: <ebfa2423-f393-414b-a6ca-021747992bae@linux.intel.com>
Date: Mon, 21 Sep 2026 11:59:31 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/5] PCI: Assume control of portdrv-related features
 only when portdrv enabled
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rafael J Wysocki <rafael@kernel.org>, Guixin Liu <kanie@linux.alibaba.com>,
 Olof Johansson <olof@lixom.net>
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260919162655.3499010-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <aq96cULSmdeBzd3D@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aq96cULSmdeBzd3D@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/19/2026 11:17 PM, Lukas Wunner wrote:
> On Sat, Sep 19, 2026 at 09:26:52AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> +++ b/drivers/pci/probe.c
>> @@ -668,12 +668,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>>  	 * may implement its own AER handling and use _OSC to prevent the
>>  	 * OS from interfering.
>>  	 */
>> +#ifdef CONFIG_PCIEPORTBUS
>>  	bridge->native_aer = 1;
>>  	bridge->native_pcie_hotplug = 1;
>> -	bridge->native_shpc_hotplug = 1;
>>  	bridge->native_pme = 1;
>> -	bridge->native_ltr = 1;
>>  	bridge->native_dpc = 1;
>> +#endif
>> +	bridge->native_ltr = 1;
>> +	bridge->native_shpc_hotplug = 1;
>>  	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
> 
> How about (e.g.)
> 
>  	bridge->native_pcie_hotplug = IS_ENABLED(CONFIG_PCIEPORTBUS);
> 
> instead of using #ifdef?  That's the preferred style according to
> section 21 of Documentation/process/coding-style.rst

Good point, will fix in v14.  I will use a local variable for it so the
fields keep their current order and the diff stays small:

	bool port_services = IS_ENABLED(CONFIG_PCIEPORTBUS);

	bridge->native_aer = port_services;
	bridge->native_pcie_hotplug = port_services;
	bridge->native_shpc_hotplug = 1;
	bridge->native_pme = port_services;
	bridge->native_ltr = 1;
	bridge->native_dpc = port_services;

> 
>>  	bridge->native_cxl_error = 1;
> 
> Hm, this one depends on CONFIG_PCIEAER I believe.
> (But Terry Bowman is the expert.)

I don't think it does. The only consumer is cxl_event_config() in
drivers/cxl/pci.c. CXL_PCI doesn't depend on PCIEAER.

Terry, please correct me if I'm wrong.


> 
> Thanks,
> 
> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

