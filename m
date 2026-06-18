Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9466A25B0B4;
	Thu, 18 Jun 2026 22:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820301; cv=none; b=TPqndyBSW92aiwodzbV3K+V2IUfcO2cH1SIoOAgjP2xh+46nDwgT8SryrOI/mhvraMVmNJABCg1H4LcCoY+Vj49pdfNbKX/S7ehAqHZ/9AMbLVAo9rAGYoI+bs6iB4ndrcmT8NUS0gBOWs3+09eHnopKU6z5jWo9TqW14oPYRmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820301; c=relaxed/simple;
	bh=l6N/6/A+/Lv0qvWUNbb3d8qmflcXGXKj2wS7jeZ+GdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsUmL8YgaXSlVyGmN2eTbiTZK33kTZjPf+jOAxZ+jN4Pwb/QC9HuPlch4/RPbd7W31kW9lCAXE1z6GsVBLt0OjGWzOzNBm0phVeipqSy7c1bukIwGuOro8lVZaeHIs0U4bQ8RvGGEoOzbbiw5rMsLSP+zZfH6MhCzzZtwWPhwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPupebwy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPupebwy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781820299; x=1813356299;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l6N/6/A+/Lv0qvWUNbb3d8qmflcXGXKj2wS7jeZ+GdM=;
  b=IPupebwyXDTERfkpZhjPQhK9PbRGdCnZglQAyM/YoxNmJbhS3x5Ok0Q5
   0t4KQbcpX4+rKtDHAi7czXZExnIBW8sbnnT6BltQXopKRzQvuk7UeMZ+4
   0vyqkATH8KQrvfSTTpOXJmGqVjA5pnh5Sj++Uo0gYPBR98nO8Pym0omga
   n4ffP6jWMA63sH4eerIZVLY7n/pA91htS5HR1WqZHPa7dnIwgQH40xc4a
   s/HzkAeuGUz1mFjlR7tYAMGtOkQFSVsWSYF8KsGf39Lxn6X/dP9GfQt9/
   foLgfuwTNCMG6TprEpFnqd5rFaLQdYTSzxzEwMasadSvZPoIW5+zGkmUb
   g==;
X-CSE-ConnectionGUID: GdZiKvLWRcuVrHoOVOz0JQ==
X-CSE-MsgGUID: DrIqGoRHRqCD1hAOQDLNcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82448963"
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="82448963"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 15:04:57 -0700
X-CSE-ConnectionGUID: hguh/KpqSBmM4PQqZykq2Q==
X-CSE-MsgGUID: o8C+gXWXR+27RdZ62pp67w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="253575211"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.111.229]) ([10.125.111.229])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 15:04:56 -0700
Message-ID: <379c873f-e780-41ea-895c-2b75e168c090@intel.com>
Date: Thu, 18 Jun 2026 15:04:55 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/2] PCI/CXL: Enable usage of RDPAS to shortcut
 error device discovery
To: "Bowman, Terry" <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, jic23@kernel.org, djbw@kernel.org
References: <20260618170723.2010490-1-dave.jiang@intel.com>
 <20260618170723.2010490-3-dave.jiang@intel.com>
 <e8ca6204-46a4-4c9f-a4d6-efb1d4f87c3c@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <e8ca6204-46a4-4c9f-a4d6-efb1d4f87c3c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/26 2:26 PM, Bowman, Terry wrote:
> On 6/18/2026 12:07 PM, Dave Jiang wrote:
>> The RDPAS allows the CXL RCH error handler to find the device directly
>> instead of iterating through a set number of RCiEP in order to discover
>> which device triggered an error. For the CXL.io protocol, the base
>> address provided from the cxl_rdpas xarray points to the RCRB of the
>> device. The RCRB mirrors the configuration space of the device via MMIO.
>> The error handler can walk the RCRB to find the AER capability block and
>> therefore read the root status as well as the error source in order
>> to determine the BDF of the error device.
>>
>> The entries with cxl.cachemem protocol is ignored because the base address
>> provided by the RDPAS structure points to the Component Base Register Base
>> and does not provide a way for th ecode to identify the device that
>> triggered the error.
>>
> 
> I see. The protocol explanation is here. And cachemem is ignored.
> 
>> Change the current RCH error handler behavior so it will probe the
>> RCRB first to see if the error device can be discovered quickly
>> before falling back to the current method of iterating through RCiEPs.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v2:
>> - Add boundary checks for MMIO reads (sashiko)
>> - Add checks for surprise removal of devices (sashiko)
>> - Use aer_info to also check severity. (Ming)
>> - Update to iterate list of RPs under a RCEC entry.
>> ---
>>  drivers/pci/pcie/aer_cxl_rch.c | 152 ++++++++++++++++++++++++++++++++-
>>  1 file changed, 148 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
>> index eaab7698217e..f295e4eefbba 100644
>> --- a/drivers/pci/pcie/aer_cxl_rch.c
>> +++ b/drivers/pci/pcie/aer_cxl_rch.c
>> @@ -118,7 +118,7 @@ int cxl_rdpas_init(struct device *host)
>>  }
>>  EXPORT_SYMBOL_FOR_MODULES(cxl_rdpas_init, "cxl_acpi");
>>  
>> -static struct cxl_rdpas_rcec __maybe_unused *cxl_get_rdpas_by_rcec(struct pci_dev *rcec)
>> +static struct cxl_rdpas_rcec *cxl_get_rdpas_by_rcec(struct pci_dev *rcec)
>>  {
>>  	unsigned long index;
>>  
>> @@ -166,6 +166,143 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>  	return 0;
>>  }
>>  
>> +static u16 rcrb_to_aer(void __iomem *rcrb)
>> +{
>> +	/*
>> +	 * The extended capability space is SZ_4K and each capability header
>> +	 * is dword aligned, so the chain can hold at most SZ_4K / 4 entries.
>> +	 * Bound the walk by that count to avoid spinning on a malformed,
>> +	 * looping capability list.
>> +	 */
>> +	int entries = SZ_4K / 4;
>> +	u16 offset;
>> +	u32 cap_hdr;
>> +
>> +	/* Start from PCIe extended capabilities at offset 0x100 */
>> +	offset = PCI_CFG_SPACE_SIZE;
>> +	cap_hdr = readl(rcrb + offset);
>> +	if (cap_hdr == 0 || PCI_POSSIBLE_ERROR(cap_hdr))
>> +		return 0;
>> +
>> +	while (PCI_EXT_CAP_ID(cap_hdr) != PCI_EXT_CAP_ID_ERR) {
>> +		if (--entries <= 0)
>> +			return 0;
>> +
>> +		offset = PCI_EXT_CAP_NEXT(cap_hdr);
>> +		if (!offset)
>> +			return 0;
>> +
>> +		if (offset >= SZ_4K)
>> +			return 0;
>> +
>> +		cap_hdr = readl(rcrb + offset);
>> +		if (cap_hdr == 0 || PCI_POSSIBLE_ERROR(cap_hdr))
>> +			return 0;
>> +	}
>> +
>> +	return offset;
>> +}
>> +
>> +DEFINE_FREE(iounmap, void __iomem *, if (_T) iounmap(_T))
>> +static u16 cxl_rch_get_err_src_id(u64 rcrb_base, struct aer_err_info *info)
>> +{
>> +	u32 root_status, err_src;
>> +	void __iomem *aer_base;
>> +	u16 aer_offset;
>> +
>> +	void __iomem *rcrb __free(iounmap) = ioremap(rcrb_base, SZ_4K);
>> +	if (!rcrb)
>> +		return 0;
>> +
>> +	aer_offset = rcrb_to_aer(rcrb);
>> +	if (!aer_offset)
>> +		return 0;
>> +
>> +	aer_base = rcrb + aer_offset;
>> +	if (aer_offset + PCI_ERR_ROOT_STATUS + sizeof(u32) > SZ_4K)
>> +		return 0;
>> +
>> +	root_status = readl(aer_base + PCI_ERR_ROOT_STATUS);
>> +	if (!(root_status & (PCI_ERR_ROOT_COR_RCV | PCI_ERR_ROOT_UNCOR_RCV)))
>> +		return 0;
>> +
>> +	if (aer_offset + PCI_ERR_ROOT_ERR_SRC + sizeof(u32) > SZ_4K)
>> +		return 0;
>> +
>> +	err_src = readl(aer_base + PCI_ERR_ROOT_ERR_SRC);
>> +
>> +	if (info->severity == AER_CORRECTABLE &&
>> +	    root_status & PCI_ERR_ROOT_COR_RCV)
>> +		return FIELD_GET(GENMASK(15, 0), err_src);
>> +
>> +	/* Assume at this point the info->severity points to UNCOR */
>> +	if (root_status & PCI_ERR_ROOT_UNCOR_RCV)
>> +		return FIELD_GET(GENMASK(31, 16), err_src);
>> +
>> +	return 0;
>> +}
>> +
>> +static bool cxl_rch_forward_error_by_dsp(struct pci_dev *rcec, u64 rcrb_base,
>> +					 struct aer_err_info *info)
>> +{
>> +	u8 bus, devfn;
>> +	u16 segment;
>> +	u16 src_id;
>> +
>> +	src_id = cxl_rch_get_err_src_id(rcrb_base, info);
>> +	if (!src_id)
>> +		return false;
>> +
> 
> !src_id (0000:00.0) is valid. May want to use ~0.
> 
> 
>> +	/* Try uncorrectable error source first, then correctable */
>> +	segment = pci_domain_nr(rcec->bus);
>> +	bus = FIELD_GET(GENMASK(15, 8), src_id);
>> +	devfn = FIELD_GET(GENMASK(7, 0), src_id);
>> +
>> +	struct pci_dev *pdev __free(pci_dev_put) =
>> +		pci_get_domain_bus_and_slot(segment, bus, devfn);
>> +	if (!pdev)
>> +		return false;
>> +
>> +	/*
>> +	 * The error source id resolves to whatever BDF the root port logged,
>> +	 * which is not guaranteed to be a natively handled CXL.mem device.
>> +	 * Apply the same gating as the RCiEP walk fallback before forwarding.
>> +	 */
>> +	if (!is_cxl_mem_dev(pdev) || !cxl_error_is_native(pdev))
>> +		return false;
>> +
>> +	cxl_forward_error(pdev, info);
> 
> Ok, I see the tie to kfifo cxl_forward_error().
> 
>> +	return true;
>> +}
>> +
>> +static bool cxl_rch_handled_error_by_rdpas(struct pci_dev *rcec,
>> +					   struct aer_err_info *info)
>> +{
>> +	struct cxl_rdpas_rcec *rdpas_rcec;
>> +	struct cxl_rdpas_entry *entry;
>> +	bool handled = false;
>> +
>> +	rdpas_rcec = cxl_get_rdpas_by_rcec(rcec);
>> +	if (!rdpas_rcec)
>> +		return false;
>> +
>> +	/*
>> +	 * The RCEC aggregates multiple downstream ports. Each CXL.io
> Maybe:
> 'The RCEC aggregates multiple downstream ports' errors. Each CXL.io'
> 
>> +	 * downstream port associated with this RCEC exposes the RCRB at its
>> +	 * base address; walk them all and forward the error from every port
>> +	 * that reports a valid error source.
>> +	 */
>> +	list_for_each_entry(entry, &rdpas_rcec->ports, list) {
>> +		if (entry->protocol != ACPI_CEDT_RDPAS_PROTOCOL_IO)
>> +			continue;
>> +
>> +		if (cxl_rch_forward_error_by_dsp(rcec, entry->address, info))
>> +			handled = true;
>> +	}
>> +
> 
> I was surprised we had to do another list traversal. For some reason I thought
> RDPAS would gift us an index for direct access to a RCH RCRB. The advantage to
> RDPAS looks to be the EP doesnt have to be accessed is all. Is that correct?

RDPAS entries give us the RCRB for each of the DSP that reports to the RCEC. But if there are multiple devices reports to the RCEC, then we have to go look at all of them to see which one actually flagging error unfortunately. 

DJ 

> 
>> +	return handled;
>> +}
>> +
>>  void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  {
>>  	/*
>> @@ -173,9 +310,16 @@ void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  	 * RCH's downstream port. Check and handle them in the CXL.mem
>>  	 * device driver.
>>  	 */
>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>> -	    is_aer_internal_error(info))
>> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)
>> +		return;
>> +
>> +	if (!is_aer_internal_error(info))
>> +		return;
>> +
>> +	if (cxl_rch_handled_error_by_rdpas(dev, info))
>> +		return;
>> +
>> +	pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>  }
>>  
>>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> 
> Looks good.
> 
> -Terry
> 

