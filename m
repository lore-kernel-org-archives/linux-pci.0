Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4533261F;
	Wed, 27 May 2026 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892429; cv=none; b=XDl0daA3xBGCryZ6NbENvr9LxdahlXLAWCj0V8jFdBgRnSrxIAZXIvk0PtUcqmEER9UnbkRoQJTZAt5HjPZ6MbcScv4k8gbnXB9fAjL2uerSZI1k6cY7antcXgY0b8HPau1b7ckUqrBfYWostmKhnB4QMCMjWyYroex3wYC4pGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892429; c=relaxed/simple;
	bh=h3m4hFfh4/Nz2NF7qwzt5Ba1Q1P4gdB18lZsEEAYsRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYwU224oFbUu3f4CxI3eaShuYxgPtTU948sXE2/8KwCBERnqUgoBWQruOPiJ9tq3bMEkB2zgay+yXckiHr7YWbpbo7QP14vcvpKy2NwkuK467M0Phc9aRhf7rySfnUXNtI4JwYCBUiqIKBd7FgVgaCp8XjlNnfV/RHv4KtJL1QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGD/gqYm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGD/gqYm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779892428; x=1811428428;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h3m4hFfh4/Nz2NF7qwzt5Ba1Q1P4gdB18lZsEEAYsRg=;
  b=AGD/gqYmi0O/yp/MFI9kCGsWX4OmZ1E2XclnWZ2LglN4TipyWAL54l0M
   O77DNWRnAE3XCKqX19Q7bjlBra3U4ezfdy0UfsgZNUPg/Sq5uaZXZDSM3
   ieHAH50qmyikTDd5LhdE8uh+xqrhRjjhoI3vS6FX/oSSDPEudBZvrCmJC
   FwrYaiwQ6GwONymmqF2/HpNHS7wS45iFVKTcv2VbRm2vdk4alPXHY1146
   Eq2WfXtwIjV3uHxJ2k54bmN5emWmve6acKNqA9kMKdTBQPNjTQsOfRZii
   oFxKuICn2wOHtvS8BfBhd5X0s1QEimuPU7p/i+5lAyhMprBnozEW+A8h+
   g==;
X-CSE-ConnectionGUID: P/btVwlRTuyE4S3CU+H+DQ==
X-CSE-MsgGUID: A09YfL5HTcul4+PmwecMUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="92110936"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="92110936"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 07:33:47 -0700
X-CSE-ConnectionGUID: dlYHjzrKSv+hjR53Wa3S9Q==
X-CSE-MsgGUID: xq1AdZzrQFCkaJNiVcBxuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="244081470"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.111.23]) ([10.125.111.23])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 07:33:46 -0700
Message-ID: <a88f73d5-a0ec-4717-9aa9-c682026ac197@intel.com>
Date: Wed, 27 May 2026 07:33:45 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] PCI/CXL: Enable usage of RDPAS to shortcut error
 device discovery
To: Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: terry.bowman@amd.com, bhelgaas@google.com, jic23@kernel.org,
 djbw@kernel.org
References: <20260526182334.1010870-1-dave.jiang@intel.com>
 <20260526182334.1010870-3-dave.jiang@intel.com>
 <2a448110-569d-4296-8430-19a115d7d651@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <2a448110-569d-4296-8430-19a115d7d651@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/27/26 6:47 AM, Li Ming wrote:
> 
> 在 2026/5/27 02:23, Dave Jiang 写道:
>> The RDPAS allows the CXL RCH error handler to find the device directly
>> instead of iterating through a set number of RCiEP in order to discover
>> which device triggered an error. For the CXL.io protocol, the base
>> address provided from the cxl_rdpas xarray points to the RCRB of the
>> device. The RCRB mirrors the configuration space of the device via MMIO.
>> The error handler can walk the RCRB to find the AER capability block and
>> therefore read the root status as well as the error source in order
>> to determine the BDF of the error device.
>>
>> Change the current RCH error handler behavior so it will probe the
>> RCRB first to see if the error device can be discovered quickly
>> before falling back to the current method of iterating through RCiEPs.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/pci/pcie/aer_cxl_rch.c | 103 +++++++++++++++++++++++++++++++--
>>   1 file changed, 99 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
>> index 37bbecf495af..0fd6c4234856 100644
>> --- a/drivers/pci/pcie/aer_cxl_rch.c
>> +++ b/drivers/pci/pcie/aer_cxl_rch.c
>> @@ -80,7 +80,7 @@ int cxl_parse_rdpas(union acpi_subtable_headers *header, void *arg,
>>   }
>>   EXPORT_SYMBOL_FOR_MODULES(cxl_parse_rdpas, "cxl_acpi");
>>   -static int __maybe_unused cxl_get_rdpas_by_rcec(struct pci_dev *rcec, u64 *dsp_addr)
>> +static int cxl_get_rdpas_by_rcec(struct pci_dev *rcec, u64 *dsp_addr)
>>   {
>>       u64 index;
>>       u64 *addr;
>> @@ -134,6 +134,94 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>       return 0;
>>   }
>>   +static u16 rcrb_to_aer(void __iomem *rcrb)
>> +{
>> +    u16 offset;
>> +    u32 cap_hdr;
>> +
>> +    /* Start from PCIe extended capabilities at offset 0x100 */
>> +    offset = PCI_CFG_SPACE_SIZE;
>> +    cap_hdr = readl(rcrb + offset);
>> +    if (cap_hdr == 0 || cap_hdr == ~0u)
>> +        return 0;
>> +
>> +    while (PCI_EXT_CAP_ID(cap_hdr) != PCI_EXT_CAP_ID_ERR) {
>> +        offset = PCI_EXT_CAP_NEXT(cap_hdr);
>> +        if (!offset)
>> +            return 0;
>> +
>> +        if (offset >= SZ_4K)
>> +            return 0;
>> +
>> +        cap_hdr = readl(rcrb + offset);
>> +    }
>> +
>> +    return offset;
>> +}
>> +
>> +DEFINE_FREE(iounmap, void __iomem *, if (_T) iounmap(_T))
>> +static u16 cxl_rch_get_err_src_id(u64 rcrb_base)
>> +{
>> +    u32 root_status, err_src;
>> +    void __iomem *aer_base;
>> +    u16 aer_offset;
>> +
>> +    void __iomem *rcrb __free(iounmap) = ioremap(rcrb_base, SZ_4K);
>> +    if (!rcrb)
>> +        return 0;
>> +
>> +    aer_offset = rcrb_to_aer(rcrb);
>> +    if (!aer_offset)
>> +        return 0;
>> +
>> +    aer_base = rcrb + aer_offset;
>> +
>> +    root_status = readl(aer_base + PCI_ERR_ROOT_STATUS);
>> +    if (!(root_status & (PCI_ERR_ROOT_COR_RCV | PCI_ERR_ROOT_UNCOR_RCV)))
>> +        return 0;
>> +
>> +    err_src = readl(aer_base + PCI_ERR_ROOT_ERR_SRC);
>> +
>> +    if (root_status & PCI_ERR_ROOT_UNCOR_RCV)
>> +        return FIELD_GET(GENMASK(31, 16), err_src);
>> +
>> +    if (root_status & PCI_ERR_ROOT_COR_RCV)
>> +        return FIELD_GET(GENMASK(15, 0), err_src);
>> +
>> +    return 0;
>> +}
>> +
>> +static bool cxl_rch_handled_error_by_rdpas(struct pci_dev *rcec,
>> +                       struct aer_err_info *info)
>> +{
>> +    u8 bus, devfn;
>> +    u64 dsp_addr;
>> +    u16 segment;
>> +    u16 src_id;
>> +    int rc;
>> +
>> +    rc = cxl_get_rdpas_by_rcec(rcec, &dsp_addr);
>> +    if (rc)
>> +        return false;
>> +
>> +    src_id = cxl_rch_get_err_src_id(dsp_addr);
>> +    if (!src_id)
>> +        return false;
>> +
>> +    /* Try uncorrectable error source first, then correctable */
> 
> I am a little bit confused about this comment and cxl_rch_get_err_src_id(). I think aer_err_info->severify idendifies current ERR is a correctable error or not.
> 
> In cxl_rch_get_err_src_id() always handles UNCOR_ERR before COR_ERR, is it possible that getting an UNCOR_ERR src id for a COR_ERR aer_err_info?
> 
> E.g. aer_err_info is created for a COR_ERR, but the RCH DSP masks PCI_ERR_ROOT_UNCOR_RCV after the aer_err_info created.
> 
> Maybe I misunderstand something, please correct me if I am wrong.

No. I was blindly just looking at the registers. I need to take into account what came from the aer_err_info.

DJ

> 
> Ming
> 
>> +    segment = pci_domain_nr(rcec->bus);
>> +    bus = FIELD_GET(GENMASK(15, 8), src_id);
>> +    devfn = FIELD_GET(GENMASK(7, 0), src_id);
>> +
>> +    struct pci_dev *pdev __free(pci_dev_put) =
>> +        pci_get_domain_bus_and_slot(segment, bus, devfn);
>> +    if (!pdev)
>> +        return false;
>> +
>> +    cxl_forward_error(dev, info);
>> +    return true;
>> +}
>> +
>>   void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>   {
>>       /*
>> @@ -141,9 +229,16 @@ void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>        * RCH's downstream port. Check and handle them in the CXL.mem
>>        * device driver.
>>        */
>> -    if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>> -        is_aer_internal_error(info))
>> -        pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>> +    if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)
>> +        return;
>> +
>> +    if (!is_aer_internal_error(info))
>> +        return;
>> +
>> +    if (cxl_rch_handled_error_by_rdpas(dev, info))
>> +        return;
>> +
>> +    pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>   }
>>     static int handles_cxl_error_iter(struct pci_dev *dev, void *data)

