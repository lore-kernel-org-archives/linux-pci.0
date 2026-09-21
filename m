Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9094B1D0E;
	Mon, 21 Sep 2026 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009027; cv=none; b=tPSK1Be0qLA2SY4MduQU6crwpncpcjad3ObBd+Z4lQp/fPZl+FAlnGacRoeKzReckAmAMPLapPGPdJcZqYS1T2DAvZUh5B3TL8z/XT9lpCCHwCFkeDg2rJqq0krqaRCk6qKxz1mjnZbkF/6jkNH0GFtzP1hzSULrXUclrGtGnUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009027; c=relaxed/simple;
	bh=eM1N6XqzmlgwM+AO0lHdun00OVqdgvGXGEqNfHmMGAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLwLl9QLN+8GoIvZNlGZFhEAGjDuKy0mgiesPhjoEwfE3ooZrY/q1Wtk1e5eCK1bsnOEJYDqgMXpkaCU/F2OoPpJJPBH5C0Tiv5KhR7aqgYiWTOm44x7RiP18O4bvpjjKtFZrjD3/vwdnDvosurv0OQPgNEKZYH8YrEokcnq9xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJQZM8ow; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJQZM8ow"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790009025; x=1821545025;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eM1N6XqzmlgwM+AO0lHdun00OVqdgvGXGEqNfHmMGAk=;
  b=AJQZM8owqDfGy2fKQjcW2wcwsIXtUwZzxifcAFBj2rdVjSXMjIkF02Ww
   8K1OtYQ6Dy0MNc3VngURsjtIuO18XKVKCVBhGGQXUWHL5D9lCgvPnNCQ3
   Ve6q3IELrrJ4BzUBR3GGpD6/H79aIPQ9qKVEXxR8JEvnK4O5/b9X/4fhp
   usvw3Z4Q8aro45rgaPdIrpQsXszIYnT78mVdrMWV03+DR16Crg16/bRsA
   vg0LeQaSidyh6DYmJkuurhNztVkWPQrQlxdjOPKcI2z/64wK/GbdPkdR5
   aWK7cd5rikdUfsTFXmdX67TwxIhMAQVXqy0xd35OjIGddq1Ku0uO6kE4d
   g==;
X-CSE-ConnectionGUID: vJgVAQtkS8ucWoNWGLGn4Q==
X-CSE-MsgGUID: Kz4sWl00Tm2ONPwzERI6Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="89467285"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="89467285"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 09:43:44 -0700
X-CSE-ConnectionGUID: Ov5NmTY/SoKvcsbUdfn5ZA==
X-CSE-MsgGUID: QX0iXJS2R9+E9w6/jnlkFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="300684514"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 09:43:44 -0700
Message-ID: <24b9db58-e654-408b-85a9-15c5af5e944a@linux.intel.com>
Date: Mon, 21 Sep 2026 09:43:43 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/5] PCI/DPC: Ignore devices with no AER Capability
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rafael J Wysocki <rafael@kernel.org>, Guixin Liu <kanie@linux.alibaba.com>,
 Olof Johansson <olof@lixom.net>
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260919162655.3499010-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <aq95LGUHL-pnmTlr@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aq95LGUHL-pnmTlr@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lukas,

On 9/19/2026 11:11 PM, Lukas Wunner wrote:
> On Sat, Sep 19, 2026 at 09:26:51AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Downstream Ports may support DPC regardless of whether they support AER
>> (see PCIe r7.0, sec 6.2.11.2).  Previously, if the user booted with
>> "pcie_ports=dpc-native", it was possible for dpc_probe() to succeed even if
>> the device had no AER Capability, but dpc_get_aer_uncorrect_severity()
>> depends on the AER Capability.
> [...]
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -477,6 +477,9 @@ static int dpc_probe(struct pcie_device *dev)
>>  	int status;
>>  	u16 cap;
>>  
>> +	if (!pdev->aer_cap)
>> +		return -ENOTSUPP;
>> +
>>  	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
>>  		return -ENOTSUPP;
> 
> I've got patches which make DPC work (again) on AER-unsupporting ports:
> 
>   https://github.com/l1k/linux/commits/aer_baseline_v1/
> 
> In particular:
> 
>   PCI/DPC: Avoid access to non-existent AER capability
>   https://github.com/l1k/linux/commit/85f209fd4732
> 
>   PCI/DPC: Reinstate support for AER-incapable ports
>   https://github.com/l1k/linux/commit/2de89b762d79
> 
> I'm almost done with that series and hope to submit it this cycle.
> Your patch [1/5] will cause a conflict with my patches.
> Would you mind holding off on patch [1/5] for now?

Sure. At first glance, your series fixes the AER/DPC dependency cleanly.

I think we can drop this patch. Bjorn, let me know if you think otherwise.

> 
> There's another reason:  I know of one product in particular,
> Intel "Ponte Vecchio" data center GPUs, which support DPC but
> lack an AER capability.  DPC was tested and made to work on
> those cards (see 53b54ad074de).
> 
> I didn't realize back then but know now that validation engineers
> specifically used pcie_ports=dpc-native to be able to use DPC on
> that product.  And I believe this was also communicated to customers
> as "best known method" for DPC on Ponte Vecchio.  In other words,
> using pcie_ports=dpc-native to make DPC work on non-AER-capable products
> has become a feature.  Your patch breaks those use cases.
> 
> That's why I chose to make DPC work (again) on non-AER-capable products
> with the above-linked patches, instead of closing this loophole to
> force-enable it.
> 



> Thanks,
> 
> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

