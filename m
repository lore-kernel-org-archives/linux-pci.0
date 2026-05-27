Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1653DD874;
	Wed, 27 May 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892355; cv=none; b=E6mC0V4GKUuyLkFWxgfk3A41G0kj5hQnljRAUkDIFdhZaPftYQHVyu86BQOExnrxJUuwDAvpI9yl1fhSTCsrQqkeu7j4VsSjKporGK4/O8P1xcHYHWYKJO0xAMGPDiJNkkTUouCyen9nEo/44vpDbFor28Adsa8K+uxHzgyhiFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892355; c=relaxed/simple;
	bh=GfnJOq/p1y6BWmBJrxa05I1JLp/uNHeN7NUOWJ8ZT90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExChuGd4DIo6vEGp02Li3vjq2BvHv+bHHowgfdDi9NIr8AT0dTlv8SWrRbvNOzko8qCZVQ0rHdjX7j5WOFBJVvxtc4LK2uPFtOemmpZmbMc6A3FGfnL2Z1pe5M3e7kwwAV5TlyXpx+QMVyMmWAhbdH5e0kcCYwKuYQBBDSmosJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIuDvv6w; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIuDvv6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779892354; x=1811428354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GfnJOq/p1y6BWmBJrxa05I1JLp/uNHeN7NUOWJ8ZT90=;
  b=aIuDvv6wEgBIaYKp7IRVpDCVAjOQKe42THQnT3f+cfJN7BcgNlEwErsn
   eMEXIYmgrWJEVNvCZ4cFTmh64JDPj7HlTz0Kr1yVcLWVDWQz0fLF+UR2+
   n+tmuFGcsFRcA2u0sMR7A8iysS41besilIiug9IPeKnDMwgi9ukFcVKuG
   VolEQgJ3jqmCVALiLTkDRLIMX5nXuoIMB6UmDoh5mI5yJZepawtadCJxh
   E4kBRGkCuBG33Q4vmj0UJJWNgbYCYSp34MvqsPIO2DWD2RzJ7Bj9xG81d
   dGVzHQU5v/M+zITGkgVNDiyyaEIPs/ts3+Vi+iXKPgppdtd/LmlsdQVLP
   g==;
X-CSE-ConnectionGUID: AXr2XJS5QfOBvQ1DFEZqRw==
X-CSE-MsgGUID: uMVLitZaTue9VhwsnBh0zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="92110388"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="92110388"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 07:32:33 -0700
X-CSE-ConnectionGUID: hvwakyDvQuCUloBE+6OWBg==
X-CSE-MsgGUID: scYu4EL/T4eimLmdYrnBTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="244080985"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.111.23]) ([10.125.111.23])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 07:32:32 -0700
Message-ID: <1cdfd04a-c2f3-4f25-881d-352a532ffc9e@intel.com>
Date: Wed, 27 May 2026 07:32:31 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] PCI/CXL: Add RDPAS parsing support
To: Li Ming <ming.li@zohomail.com>
Cc: terry.bowman@amd.com, bhelgaas@google.com, jic23@kernel.org,
 djbw@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260526182334.1010870-1-dave.jiang@intel.com>
 <20260526182334.1010870-2-dave.jiang@intel.com>
 <70d15a21-ff90-40b8-a01f-479f9c3a1d51@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <70d15a21-ff90-40b8-a01f-479f9c3a1d51@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/27/26 6:37 AM, Li Ming wrote:
> 
> 在 2026/5/27 02:23, Dave Jiang 写道:
>> Add parsing of the RCEC Downstream Port Association Structure (RDPAS),
>> which is a structure defined in the CXL spec r4.0 9.18.1.5. This
>> structure allows error handler to locate the downstream port(s)
>> that report errors to a given Root Complex Event Collector (RCEC).
>> The structure is part of CXL Early Discovery Table (CEDT) and can
>> be parsed like other CEDT tables.
>>
>> A base address is provided in the RDPAS structure where depending on
>> the protocol field, it is the RCRB base associated with the downstream
>> port for CXL.io or the Component Base Register base associated with the
>> downstream port for CXL.cachemem.
>>
>> The 64bit address of the base address field will be stored in an xarray
>> indexed by the combination of the RCEC segment plus the BDF in a 32bit
>> field. Currently only the CXL.io base address will be stored. If the
>> protocol is CXL.cachemem, there is no way to retrieve a source id and
>> therefore identifying the BDF of the error device.
>>
>> A helper is also added to retrieve the base address based on the segment
>> and BDF of the RCEC.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> [...]
>> +static int __cxl_parse_rdpas(struct acpi_cedt_rdpas *rdpas, struct device *dev)
>> +{
>> +    unsigned long index;
>> +    int rc;
>> +
>> +    /* Skip CXL.cachemem as the current RDPAS scheme only supports CXL.io */
>> +    if (rdpas->protocol != CXL_RDPAS_PROTO_IO)
>> +        return 0;
>> +
>> +    u64 *addr __free(kfree) = kzalloc(sizeof(*addr), GFP_KERNEL);
>> +    if (!addr)
>> +        return -ENOMEM;
>> +
>> +    *addr = rdpas->address;
>> +
>> +    index = __rdpas_index(rdpas->segment, rdpas->bdf);
>> +    rc = xa_insert(&cxl_rdpas, index, addr, GFP_KERNEL);
>> +    if (rc) {
>> +        if (rc != -EBUSY)
>> +            return rc;
>> +
>> +        dev_dbg(dev, "Duplicate RDPAS: PCI %04x:%02lx:%02lx.%ld\n",
>> +            rdpas->segment, FIELD_GET(GENMASK(15, 8), rdpas->bdf),
>> +            FIELD_GET(GENMASK(7, 3), rdpas->bdf),
>> +            FIELD_GET(GENMASK(2, 0), rdpas->bdf));
>> +        return 0;
>> +    }
>> +
>> +    retain_and_null_ptr(addr);
> 
> Miss releasing implementation for the added entry?

Yup I'll add

DJ
> 
> Or should destroy xarray in cxl_acpi_exit()?
> 
>> +    dev_dbg(dev, "RDPAS entry: PCI %04x:%02lx:%02lx.%ld -> CXL addr %016llx\n",
>> +        rdpas->segment, FIELD_GET(GENMASK(15, 8), rdpas->bdf),
>> +        FIELD_GET(GENMASK(7, 3), rdpas->bdf),
>> +        FIELD_GET(GENMASK(2, 0), rdpas->bdf),
>> +        rdpas->address);
>> +
>> +    return 0;
>> +}
>> +
>> +int cxl_parse_rdpas(union acpi_subtable_headers *header, void *arg,
>> +            const unsigned long end)
>> +{
>> +    struct acpi_cedt_rdpas *rdpas = (struct acpi_cedt_rdpas *)header;
>> +    struct device *dev = arg;
>> +
>> +    return __cxl_parse_rdpas(rdpas, dev);
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(cxl_parse_rdpas, "cxl_acpi");
>> +
>> +static int __maybe_unused cxl_get_rdpas_by_rcec(struct pci_dev *rcec, u64 *dsp_addr)
>> +{
>> +    u64 index;
>> +    u64 *addr;
>> +
>> +    index = rdpas_index(pci_domain_nr(rcec->bus), rcec->bus->number,
>> +                PCI_SLOT(rcec->devfn), PCI_FUNC(rcec->devfn));
>> +    addr = xa_load(&cxl_rdpas, index);
>> +    if (!addr)
>> +        return -ENOENT;
>> +
>> +    *dsp_addr = *addr;
>> +
>> +    return 0;
>> +}
>> +
>>   static bool is_cxl_mem_dev(struct pci_dev *dev)
>>   {
>>       /*

