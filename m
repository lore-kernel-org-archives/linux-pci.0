Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816480;
	b=LOqJ6sqQrnQjE4/3CBr55TLrFaowYpbWoyT9bflk3HYjYJdX5SSK+UaTrIcW0Jx0h8+B
	 O5u5grGdogq6Sw8c6NFDki2SaBa0BNCxxfnXFjGXJeBk/NsoFnEjYHZPDTWTHU+XkDS5L
	 lcRmSrhOe1IcUK+1TRywUyaDzJ2cTEZvtW3/Jkh3MpFTT8Z4tVE/wG9OrHxE4tsKaUzhV
	 PGumb3jLwPf0HpsBV1bVe8yhiL6qcKP2OFIfi+fmKdcn8RoajXtLC59yqxyyYpXBl5+4D
	 3odwXfE6XahkpzBAZxPFPMKqU/KUV/2EL7uDfPQSlRaZo1GRV4PGGZeNUZ+XTC3vJYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816480;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=QPqayBP0oJU1EgJFeRWMjurJLcFQpMOEQ4l+qAchFb0=;
	b=qGAUJww4zWqvTr5KmcbldGIR7oAYFleZZ/SxZM2uogJwUTqdyWjGlII54uZa3nko6001
	 /lilkXVX8QUa+9bvXBagy7XpiaEAqFP/9mOdP+4QpSneWwxOPNfX4qeokJcu/iPrn5g+k
	 1UDz84Yx7vMOrnmYl6+XDdYyHP6jYE/hHfPv64Sci3XnGXKfUmmYBsLpkUO0hrMzpG3DY
	 Ex29f0UP1+TNamMZqM9T5N+9kaeOtAh9WYhCIq+cHwN/E4cIbFnJnpfOwLipaxDDiiLqa
	 5AQVAqdlcT3So+tmG7S0DKPr356U119JUoie5A1pQL63TiM6Id1c9b3muETXuj+/ymw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mPSV50yR;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC956082BE5;
	Wed,  4 Nov 2026 18:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BC956082BE5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mPSV50yR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793816480; x=1825352480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=52qvP5hVUSS3wD3/SCmGYf1Et4sj27QHBnuPGOuVz/I=;
  b=mPSV50yRmN/SEPytmxUn5EDF55RwHRatPuzNlx4JLrgDd7ODPKKcWkRB
   +Gux2xv0FFIYdicxk8Hw8afEufuN4+Rb+mkbzJcr1Eug9sQpirJb5+n5Z
   /eEt6QJjwGPspcwQ2WQ/QFePIjeANHTEvkjpsTx5b5hJWmjyEEadsjr7C
   KxKZpzYgCJiYFzqcitVTXT4rtBqRUtYgHbFlftoeI0byk9bOC290iS35W
   Piw1RZzmp6UpfQ7QZzvUNs9MHO4sIPURaAe9z/EKVeHARnWMLIkFlV/qr
   kSU8Yco1q/nZpmPWR5M+UqFeqcEaVq/o4x+hzdhULVbkK0Ucfn3Qdt+Ne
   w==;
X-CSE-ConnectionGUID: RS/apROmRfiWnI8tqHU8Mw==
X-CSE-MsgGUID: eUFNeQN5Sz2olyvdv8sgGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2599908"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2599908"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 10:21:19 -0800
X-CSE-ConnectionGUID: 8fWM/CxPQpm3FCV+T6H65Q==
X-CSE-MsgGUID: PAoxKYT3TeKmxtL8WZMboA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6933687"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 10:21:19 -0800
Message-ID: <78ca441d-e41d-49b6-9157-6efc3814bf6b@linux.intel.com>
Date: Wed, 4 Nov 2026 10:21:18 -0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] PCI/ACPI: Request DPC control only together with
 AER control
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261104161323.GD716491@yaz-khff2.amd.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20261104161323.GD716491@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/4/2026 8:13 AM, Yazen Ghannam wrote:
> On Tue, Oct 20, 2026 at 11:19:22AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> PCI Firmware r3.3, sec 4.5.2.4, requires the OS to request AER control
>> when it requests DPC control.  calculate_control() requests DPC control
>> whenever CONFIG_PCIE_DPC is enabled, even if it does not request AER
>> control, e.g., with "pci=noaer" or when MSI is disabled.
>>
>> Request DPC control only if AER control is also requested.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>> ---
>>  drivers/acpi/pci_root.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index b0e0b33e3254..5c674d5b6bb8 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -516,8 +516,12 @@ static u32 calculate_control(void)
>>  	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
>>  	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
>>  	 * and EDR.  EDR is always built with DPC on ACPI systems.
>> +	 *
>> +	 * PCI Firmware r3.3, sec 4.5.2.4, requires the OS to request AER
>> +	 * control while requesting DPC control.
> 
> What about folding this last line into the rest of the comment above?
> 
> Or maybe just drop the spec details and leave that for the commit
> message?

I'll fold it into the comment above in v3.

> 
>>  	 */
>> -	if (IS_ENABLED(CONFIG_PCIE_DPC))
>> +	if (IS_ENABLED(CONFIG_PCIE_DPC) &&
>> +	    (control & OSC_PCI_EXPRESS_AER_CONTROL))
>>  		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
>>  
>>  	return control;
>> -- 
> 
> Otherwise, looks good to me.
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks.

> 
> Thanks,
> Yazen

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

