Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7208388396;
	Wed, 17 Jun 2026 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781737652; cv=none; b=oUxqny36WUOt3dxn+1JTooSDxGTxLdjjp5TC39fb5gd/3OoyFhtN82snpDsiRk8dBiT5byGkmVGJwyzRuVf6P968VaQgitlojiklIaY9YFRc0ycUiyAcXh3DvnVcAyECQqJ0sAqfwqfpzgwsNaPOOZBcgsE6NrD6u9M8yAIwQeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781737652; c=relaxed/simple;
	bh=Fw52YTO4ly+KOnOqAfWnnOP9h8AuXlv8ftrkX4WigcY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=I7m3oKm4Zro+/ec2DRzq5Q7vbe7kVx/yl5sVNND36pYLX9iNk86fDpG0i1sUgIqwQjWBIRNNv9Pg08aFyt3LzNLpjV5pRqZU0/7fbppXxFHJGGYi3GZEJfItZPoBV/w5gKLGdy+I7YaWQYBRa+Gu1gR0JIRfSsrOLvztOTGMrc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/0VZgoM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/0VZgoM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781737651; x=1813273651;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Fw52YTO4ly+KOnOqAfWnnOP9h8AuXlv8ftrkX4WigcY=;
  b=S/0VZgoMm+WazmIPAssN8KVbsVob5MkGlD3eO57ezygWKckB3aYktBWh
   m167s3qOgOKFS9/B+6eTjQpH8rvfuwTXV9OyblDDxkAbY6gn4NtCUknY9
   5Gip0rm3x2ALHg5YAmwIqi/trBh7no4+dytmtGvAaQNumGKtHTSkANiNC
   +n4MAR40OWNyuYP4nmUxikDSD+SqH5fxie5vhuCMCxMgxEPY6Q1f09O3O
   7M+D+BNxns6rmDh/4DwQOTygfhNccoUAJK/9sExgEVtor4sCZ7WWF13VH
   nUOzJtzBG3n6UYsaEi1QnGgjjobtURdpAMF9UvCf+oQwRLOcgN/27IYrL
   w==;
X-CSE-ConnectionGUID: 8VL6Lb0+QRuLzn41BGaiDw==
X-CSE-MsgGUID: 6jaMFBeRRqOrHJPGVxOQpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82561180"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="82561180"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 16:07:31 -0700
X-CSE-ConnectionGUID: pMvd2DBRSsihG+VPnQiUaQ==
X-CSE-MsgGUID: 7l94Zp4YT6OymmxqK67e8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="245830755"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.162]) ([10.125.111.162])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 16:07:29 -0700
Message-ID: <356baf6e-58d0-4646-981c-963a6e5a63d4@intel.com>
Date: Wed, 17 Jun 2026 16:07:28 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] PCI/CXL: Add RDPAS parsing support
From: Dave Jiang <dave.jiang@intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: terry.bowman@amd.com, bhelgaas@google.com, jic23@kernel.org,
 djbw@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260526182334.1010870-1-dave.jiang@intel.com>
 <20260526182334.1010870-2-dave.jiang@intel.com>
 <70d15a21-ff90-40b8-a01f-479f9c3a1d51@zohomail.com>
 <1cdfd04a-c2f3-4f25-881d-352a532ffc9e@intel.com>
Content-Language: en-US
In-Reply-To: <1cdfd04a-c2f3-4f25-881d-352a532ffc9e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/27/26 7:32 AM, Dave Jiang wrote:
> 
> 
> On 5/27/26 6:37 AM, Li Ming wrote:
>>
>> 在 2026/5/27 02:23, Dave Jiang 写道:
>>> Add parsing of the RCEC Downstream Port Association Structure (RDPAS),
>>> which is a structure defined in the CXL spec r4.0 9.18.1.5. This
>>> structure allows error handler to locate the downstream port(s)
>>> that report errors to a given Root Complex Event Collector (RCEC).
>>> The structure is part of CXL Early Discovery Table (CEDT) and can
>>> be parsed like other CEDT tables.
>>>
>>> A base address is provided in the RDPAS structure where depending on
>>> the protocol field, it is the RCRB base associated with the downstream
>>> port for CXL.io or the Component Base Register base associated with the
>>> downstream port for CXL.cachemem.
>>>
>>> The 64bit address of the base address field will be stored in an xarray
>>> indexed by the combination of the RCEC segment plus the BDF in a 32bit
>>> field. Currently only the CXL.io base address will be stored. If the
>>> protocol is CXL.cachemem, there is no way to retrieve a source id and
>>> therefore identifying the BDF of the error device.
>>>
>>> A helper is also added to retrieve the base address based on the segment
>>> and BDF of the RCEC.
>>>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> [...]
>>> +static int __cxl_parse_rdpas(struct acpi_cedt_rdpas *rdpas, struct device *dev)
>>> +{
>>> +    unsigned long index;
>>> +    int rc;
>>> +
>>> +    /* Skip CXL.cachemem as the current RDPAS scheme only supports CXL.io */
>>> +    if (rdpas->protocol != CXL_RDPAS_PROTO_IO)
>>> +        return 0;
>>> +
>>> +    u64 *addr __free(kfree) = kzalloc(sizeof(*addr), GFP_KERNEL);
>>> +    if (!addr)
>>> +        return -ENOMEM;
>>> +
>>> +    *addr = rdpas->address;
>>> +
>>> +    index = __rdpas_index(rdpas->segment, rdpas->bdf);
>>> +    rc = xa_insert(&cxl_rdpas, index, addr, GFP_KERNEL);
>>> +    if (rc) {
>>> +        if (rc != -EBUSY)
>>> +            return rc;
>>> +
>>> +        dev_dbg(dev, "Duplicate RDPAS: PCI %04x:%02lx:%02lx.%ld\n",
>>> +            rdpas->segment, FIELD_GET(GENMASK(15, 8), rdpas->bdf),
>>> +            FIELD_GET(GENMASK(7, 3), rdpas->bdf),
>>> +            FIELD_GET(GENMASK(2, 0), rdpas->bdf));
>>> +        return 0;
>>> +    }
>>> +
>>> +    retain_and_null_ptr(addr);
>>
>> Miss releasing implementation for the added entry?
> 
> Yup I'll add

Actually after thinking about it I think I'll make the xarray only parse once but have the lifetime of the entire kernel boot. There is no need to clean it up.

DJ

> 
> DJ
>>
>> Or should destroy xarray in cxl_acpi_exit()?
>>
>>> +    dev_dbg(dev, "RDPAS entry: PCI %04x:%02lx:%02lx.%ld -> CXL addr %016llx\n",
>>> +        rdpas->segment, FIELD_GET(GENMASK(15, 8), rdpas->bdf),
>>> +        FIELD_GET(GENMASK(7, 3), rdpas->bdf),
>>> +        FIELD_GET(GENMASK(2, 0), rdpas->bdf),
>>> +        rdpas->address);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +int cxl_parse_rdpas(union acpi_subtable_headers *header, void *arg,
>>> +            const unsigned long end)
>>> +{
>>> +    struct acpi_cedt_rdpas *rdpas = (struct acpi_cedt_rdpas *)header;
>>> +    struct device *dev = arg;
>>> +
>>> +    return __cxl_parse_rdpas(rdpas, dev);
>>> +}
>>> +EXPORT_SYMBOL_FOR_MODULES(cxl_parse_rdpas, "cxl_acpi");
>>> +
>>> +static int __maybe_unused cxl_get_rdpas_by_rcec(struct pci_dev *rcec, u64 *dsp_addr)
>>> +{
>>> +    u64 index;
>>> +    u64 *addr;
>>> +
>>> +    index = rdpas_index(pci_domain_nr(rcec->bus), rcec->bus->number,
>>> +                PCI_SLOT(rcec->devfn), PCI_FUNC(rcec->devfn));
>>> +    addr = xa_load(&cxl_rdpas, index);
>>> +    if (!addr)
>>> +        return -ENOENT;
>>> +
>>> +    *dsp_addr = *addr;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static bool is_cxl_mem_dev(struct pci_dev *dev)
>>>   {
>>>       /*
> 
> 

