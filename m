Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316E01DF74F;
	Thu, 18 Jun 2026 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781819854; cv=none; b=X8pK13t6huIx4fClZUQvwHgaT5aw+fYICy9aMXHKwzXXXyrujSqerHfKM+IIUtoc8NAi+QUeaSdWQZEJNxvq6QWIZFJ+hXybKsC+vjlBk0hVnFYTU+h4t5w5FX8BGV3wn1GPhXrkSK9OvCoEMJLfgBeBrCN0Q/nZAmprzeCMAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781819854; c=relaxed/simple;
	bh=YCXFDXqFWmI/jtIvKVAJq6fO6Qe9L7xMbtd8frzAbLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5Cc89OT+OC7p1lXrVnf/7rqLMo1Oe8ggFbPfh1V26xbJ1ARdxQ8JvZYVBvJ364fWTONu/mLNQEP1LFCBn07Xh9OK917RsAYyTmnvINAC5Z44Dy/llEArrDfm5xoAQdi647BlIeAxChDn6FYP0GGU5EBu1E6FndO3StFW3bIzao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQAS5ADA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQAS5ADA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781819853; x=1813355853;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YCXFDXqFWmI/jtIvKVAJq6fO6Qe9L7xMbtd8frzAbLY=;
  b=kQAS5ADA/xPa8EZwqHg9usIH2iX4yI1lIjPsPXMw0oDvDlqDFtaCAt6P
   b56nL0WbS88IHBbk9JYwk9N+bvBQIdKZ29GtTytjB8vaw+HdUA3/naJm2
   7735B/AeUtGVrGYEUFdJAPPBMJTVcXnWErQkPI9A0u4WvMQaEM78sJK+z
   AOrML/GjEEdRqairRSvyAWu3tIyPLO4qTyafv7F9SDtXDq1BxXcoA8aYc
   St4iflU1d4hpmXnPJ8c5b2Q53zC3F8nx21PsmAn4QSx0IeP1cPSOf78H5
   /EkZYRbm1gVRtN5/SX2jdlnNR0XP+rp1ROySdlb3kEMYeV3yZLj+5feEU
   w==;
X-CSE-ConnectionGUID: b+iFI2efReGjSBWEf0ciYA==
X-CSE-MsgGUID: z2A4M+zOTSG3aDL6JZTWsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82448160"
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="82448160"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 14:57:32 -0700
X-CSE-ConnectionGUID: BZCaCa7GTMmcw4UXEZt0PQ==
X-CSE-MsgGUID: CpFQTb0cTuevPyp3HmJAWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="253573947"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.111.229]) ([10.125.111.229])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 14:57:30 -0700
Message-ID: <2c7a2581-f5e3-4ae3-ba15-b42ace29bb1f@intel.com>
Date: Thu, 18 Jun 2026 14:57:29 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] PCI/CXL: Add RDPAS parsing support
To: "Bowman, Terry" <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, jic23@kernel.org, djbw@kernel.org
References: <20260618170723.2010490-1-dave.jiang@intel.com>
 <20260618170723.2010490-2-dave.jiang@intel.com>
 <c952069a-0cca-44ca-8cb3-d4305e0b844c@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <c952069a-0cca-44ca-8cb3-d4305e0b844c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/26 2:26 PM, Bowman, Terry wrote:
> On 6/18/2026 12:07 PM, Dave Jiang wrote:
>> Add parsing of the RCEC Downstream Port Association Structure (RDPAS),
>> which is a structure defined in the CXL spec r4.0 9.18.1.5. This
>> structure allows error handler to locate the downstream port(s)
>> that report errors to a given Root Complex Event Collector (RCEC).
>> The structure is part of CXL Early Discovery Table (CEDT) and can
>> be parsed like other CEDT tables.
>>
> 
> Maybe mention this is used only in RCH mode.
> 
>> A base address is provided in the RDPAS structure where depending on
>> the protocol field, it is the RCRB base associated with the downstream
>> port for CXL.io or the Component Base Register base associated with the
>> downstream port for CXL.cachemem.
>>
>> Per the spec, "For every RCEC, zero or more entries of this type are
>> permitted", so a single (segment, BDF) maps to multiple downstream
>> ports. Each RDPAS structure is stored as a per-port list node hung off
>> a per-RCEC container in an xarray indexed by the combination of the
>> RCEC segment plus the BDF in a 32bit field. Both the base address and
>> protocol type are recorded for every entry so the error handler can
>> walk all ports associated with an RCEC and dispatch per protocol.
>> It's stated here but I missed that a RCEC list must still be walked. May
> want to compare to the existing method using RCiEP.
> 
>> The parsed table is meant to live the entire life of the kernel, so the
>> xarray is not cleaned up when cxl_acpi unloads.
>>
>> A helper is also added to retrieve the per-RCEC container based on the
>> segment and BDF of the RCEC.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> RFC v2:
>> - verify table length (sashiko)
>> - store multiple downstream ports per RCEC in a list (sashiko)
>> - Add a gate to initialize the xarray only once per boot.
>> - Add support for multiple DSP per RCEC. (sashiko)
>> ---
>>  drivers/cxl/acpi.c             |   5 ++
>>  drivers/pci/pcie/aer_cxl_rch.c | 121 +++++++++++++++++++++++++++++++++
>>  include/cxl/ras.h              |  18 +++++
>>  3 files changed, 144 insertions(+)
>>  create mode 100644 include/cxl/ras.h
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 127537628817..e09706275d85 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/acpi.h>
>>  #include <linux/pci.h>
>>  #include <linux/node.h>
>> +#include <cxl/ras.h>
>>  #include <asm/div64.h>
>>  #include "cxlpci.h"
>>  #include "cxl.h"
>> @@ -933,6 +934,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>>  	if (rc < 0)
>>  		return -ENXIO;
>>  
>> +	rc = cxl_rdpas_init(host);
>> +	if (rc < 0)
>> +		dev_dbg(host, "No RDPAS entries found or failed to parse\n");
>> +
>>  	rc = add_cxl_resources(cxl_res);
>>  	if (rc)
>>  		return rc;
>> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
>> index 83142eac0cab..eaab7698217e 100644
>> --- a/drivers/pci/pcie/aer_cxl_rch.c
>> +++ b/drivers/pci/pcie/aer_cxl_rch.c
>> @@ -4,9 +4,130 @@
>>  #include <linux/pci.h>
>>  #include <linux/aer.h>
>>  #include <linux/bitfield.h>
>> +#include <linux/acpi.h>
>> +#include <linux/list.h>
>> +#include <cxl/ras.h>
>>  #include "../pci.h"
>>  #include "portdrv.h"
>>  
>> +/*
>> + * CXL r4.0 9.18.1.5: "For every RCEC, zero or more entries of this type are
>> + * permitted." A single (segment, bdf) therefore maps to multiple downstream
>> + * ports, each with its own base address and protocol. The xarray value is a
>> + * per-RCEC container holding the list of associated downstream ports.
>> + */
>> +struct cxl_rdpas_rcec {
>> +	struct list_head ports;
>> +};
>> +
>> +/* One per RDPAS structure, i.e. per associated downstream port */
>> +struct cxl_rdpas_entry {
>> +	struct list_head list;
>> +	u64 address;
>> +	u8 protocol;
>> +};
>> +
>> +static DEFINE_XARRAY(cxl_rdpas);
>> +static bool rdpas_parsed;
>> +
>> +/* CXL r4.0 9.18.1.5 Table 9-24. The segment and the BDF belongs to the RCEC */
>> +static unsigned long __rdpas_index(u16 segment, u16 bdf)
>> +{
>> +	return FIELD_PREP(GENMASK(31, 16), segment) |
>> +	       FIELD_PREP(GENMASK(15, 0), bdf);
>> +}
>> +
>> +static unsigned long rdpas_index(u16 segment, u8 bus, u8 device, u8 function)
>> +{
>> +	return __rdpas_index(segment,
>> +			     FIELD_PREP(GENMASK(15, 8), bus) |
>> +			     FIELD_PREP(GENMASK(7, 3), device) |
>> +			     FIELD_PREP(GENMASK(2, 0), function));
>> +}
>> +
>> +static int __cxl_parse_rdpas(struct acpi_cedt_rdpas *rdpas, struct device *dev)
>> +{
>> +	struct cxl_rdpas_rcec *rdpas_rcec;
>> +	struct cxl_rdpas_entry *entry;
>> +	unsigned long index;
>> +	int rc;
>> +
>> +	if (rdpas->header.length < sizeof(struct acpi_cedt_rdpas))
>> +		return -EINVAL;
>> +
>> +	index = __rdpas_index(rdpas->segment, rdpas->bdf);
>> +
>> +	rdpas_rcec = xa_load(&cxl_rdpas, index);
>> +	if (!rdpas_rcec) {
>> +		rdpas_rcec = kzalloc(sizeof(*rdpas_rcec), GFP_KERNEL);
>> +		if (!rdpas_rcec)
>> +			return -ENOMEM;
>> +
>> +		INIT_LIST_HEAD(&rdpas_rcec->ports);
>> +		rc = xa_insert(&cxl_rdpas, index, rdpas_rcec, GFP_KERNEL);
>> +		if (rc) {
>> +			kfree(rdpas_rcec);
>> +			return rc;
>> +		}
>> +	}
>> +
>> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>> +	if (!entry)
>> +		return -ENOMEM;
>> +
>> +	entry->address = rdpas->address;
>> +	entry->protocol = rdpas->protocol;
>> +	list_add_tail(&entry->list, &rdpas_rcec->ports);
>> +
>> +	dev_dbg(dev,
>> +		"RDPAS entry: PCI %04x:%02lx:%02lx.%ld %s CXL addr %016llx\n",
>> +		rdpas->segment, FIELD_GET(GENMASK(15, 8), rdpas->bdf),
>> +		FIELD_GET(GENMASK(7, 3), rdpas->bdf),
>> +		FIELD_GET(GENMASK(2, 0), rdpas->bdf),
>> +		rdpas->protocol == ACPI_CEDT_RDPAS_PROTOCOL_IO ?
>> +				   "CXL.io" : "CXL.cachemem",
>> +		rdpas->address);
>> +
> 
> This logging will be helpful.
> 
>> +	return 0;
>> +}
>> +
>> +static int cxl_parse_rdpas(union acpi_subtable_headers *header, void *arg,
>> +			   const unsigned long end)
>> +{
>> +	struct acpi_cedt_rdpas *rdpas = (struct acpi_cedt_rdpas *)header;
>> +	struct device *dev = arg;
>> +
>> +	return __cxl_parse_rdpas(rdpas, dev);
>> +}
>> +
>> +/*
>> + * The CEDT is a single static system-wide firmware table, so RDPAS is parsed
>> + * exactly once for the lifetime of the kernel. cxl_acpi may probe more than
>> + * once (re-bind or multiple ACPI0017), but the global xarray is populated only
>> + * on the first call; subsequent calls are no-ops. There is no teardown: the
>> + * data describes the platform and remains valid until the kernel exits.
>> + */
> 
> You may want to change the ACPI0017 reference. There is only one ACPI0017 per system.

Ok. This is the current deployed implementation right? Nothing stops anyone from deploying multiple ACPI0017 for whatever reason. The gate also prevents multiple parsing when someone load/unload the cxl_acpi module.

DJ

> 
> 
>> +int cxl_rdpas_init(struct device *host)
>> +{
>> +	if (rdpas_parsed)
>> +		return 0;
>> +
>> +	rdpas_parsed = true;
>> +
>> +	return acpi_table_parse_cedt(ACPI_CEDT_TYPE_RDPAS, cxl_parse_rdpas, host);> +}
>> +EXPORT_SYMBOL_FOR_MODULES(cxl_rdpas_init, "cxl_acpi");
>> +
>> +static struct cxl_rdpas_rcec __maybe_unused *cxl_get_rdpas_by_rcec(struct pci_dev *rcec)
>> +{
>> +	unsigned long index;
>> +
>> +	index = rdpas_index(pci_domain_nr(rcec->bus), rcec->bus->number,
>> +			    PCI_SLOT(rcec->devfn), PCI_FUNC(rcec->devfn));
>> +
>> +	return xa_load(&cxl_rdpas, index);
>> +}
>> +
>>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>>  {
>>  	/*
>> diff --git a/include/cxl/ras.h b/include/cxl/ras.h
>> new file mode 100644
>> index 000000000000..661307b0230a
>> --- /dev/null
>> +++ b/include/cxl/ras.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2026 Intel Corporation. */
>> +
>> +#ifndef __CXL_RAS_H__
>> +#define __CXL_RAS_H__
>> +
>> +#include <linux/acpi.h>
>> +
>> +#ifdef CONFIG_CXL_RAS
>> +int cxl_rdpas_init(struct device *host);
>> +#else
>> +static inline int cxl_rdpas_init(struct device *host)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +#endif
>> +
>> +#endif
> 
> The /include/cxl/ras.h addition will be helpful. I'll use this for 
> the CXL-AER definitions, instead of /include/linux/aer.h.
> 
> LGTM
> 
> -Terry
> 

