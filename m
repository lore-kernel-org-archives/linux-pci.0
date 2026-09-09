Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8836F8E5;
	Wed,  9 Sep 2026 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975979; cv=none; b=oaDp9cB1h3z54lTUBfB3FBPBw3NAPm58SUaHhcTY2wIHOFUuZMoe8O/nuNNfsdMtJNZOM5oHRqeu91kwU+Nc0ONrlg3RoC5rAj0j9ftDugpjHJlBNqjM7MaOKBK+rleEcDYXKZ1wR9oSKsyuumKlGHYnDZ1PJ0tUDYW+L62uZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975979; c=relaxed/simple;
	bh=Q6zSZ4oHZtJ1jCV/pynGgKcauImWL7dzD6jMkKxqQeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmIbSiKTgiMokKt6gQpUuApTb0uxRy+jb9DLjZNKZpxQWrth29cGUuvuSg1Kj4RKEYoim3vSdFDlQ1m5ekzaPrPj1apW5VvjsGE0svdm4fiWx59UVeFNGWiHNqt5SiJa5QlPh7pBjEJArqL7wae2zY/YNpSulSWYv5D8NCWMeOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHk2wA10; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHk2wA10"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788975977; x=1820511977;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q6zSZ4oHZtJ1jCV/pynGgKcauImWL7dzD6jMkKxqQeo=;
  b=HHk2wA1061JB06P+7NV9Ph8VnIH1rssauLIAG0UxopwWOxPqSXbn3zEg
   8mdhKUeTzKoo9X9VyeLcxpvDdMCX7Ueen54Bm/4GLz3iFt6Qp8DQ49dXK
   mLTyMqR01a2RhveHomKInghTRb9ivC15jEW2ZhGa7/YIb5CW52iI4g5Cg
   Bg5lZaUC2WAYhQXqtuzufxvzsTPjrjlU9gQ2Wzu1z4EDPTXGVahocxn5n
   LtcUs4HK3k0GxGNm21fQy1UKU7QD2Y/UnkvrmQOh2CpZ426bZL9fGsUwn
   oz7OLMins2CrTMZQEV4J63dYTTFEE/ce8c39ytPyryb9nQqqiWcwDpR4c
   g==;
X-CSE-ConnectionGUID: mvFJMgSpRIuUs2Wuo5d6MQ==
X-CSE-MsgGUID: qWTk8OgwQICBCpLHiqdfTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89539072"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89539072"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 10:46:16 -0700
X-CSE-ConnectionGUID: PFs5XvNeTzCKTp5Ekkv91Q==
X-CSE-MsgGUID: kftJiiGHTq6dgU3ug3SfMg==
X-ExtLoop1: 1
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.111.155]) ([10.125.111.155])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 10:46:16 -0700
Message-ID: <47071897-9715-4153-8c1e-0c23c0e364ad@intel.com>
Date: Wed, 9 Sep 2026 10:46:15 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/AER: Map a raw AER Capability image field by field
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260909163140.2723395-1-dave.jiang@intel.com>
 <20260909164539.CE6F41F000FF@smtp.kernel.org>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260909164539.CE6F41F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/26 9:45 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] aer_cap_regs_unpack() causes data corruption and mis-parsing of AER registers on big-endian architectures due to mixed endianness inputs and improper byte-offset access.

Will fix in v3.

DJ

> 
> Pre-existing issues:
> - [High] Memory allocated for `aer_info` from `ghes_estatus_pool` is permanently leaked when `aer_recover_queue()` fails to enqueue the error due to ring buffer overflow.
> --
> 
> commit 5fdf5d4c5bbdafcab0279ec4f99b6ca67a1876af
> Author: Dave Jiang <dave.jiang@intel.com>
> 
> PCI/AER: Map a raw AER Capability image field by field
> 
> This commit introduces aer_cap_regs_unpack() to map raw AER capability
> registers field-by-field into the kernel's struct aer_capability_regs layout.
> It updates ACPI GHES, ACPI extlog, and CXL RCH error handling to use this
> unpacking routine instead of flat memory copies.
> 
> Link: https://lore.kernel.org/linux-cxl/CAJZ5v0hDv11cPuztPZsaDd7uwD_49KznJy=tzuRO+dZc=CnAEQ@mail.gmail.com/
> Link: https://sashiko.dev/#/patchset/20260904172337.1409775-1-dave.jiang@intel.com?part=5
> 
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 08c985e729d6c..ade1cc8c9f8d1 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
> [ ... ]
>> @@ -668,20 +668,7 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>>  		if (!aer_info)
>>  			return;
>>  
> [ ... ]
>> +		aer_cap_regs_unpack(aer_info, pcie_err->aer_info, sizeof(pcie_err->aer_info));
> 
> [Severity: High]
> Will this corrupt the AER registers on big-endian architectures?
> 
> The pcie_err->aer_info buffer contains a strictly little-endian CPER payload.
> However, aer_cap_regs_unpack() receives this raw byte stream and populates
> native u32 fields with it, which can lead to mis-parsing.
> 
>>  
>>  		aer_recover_queue(pcie_err->device_id.segment,
>>  				  pcie_err->device_id.bus,
> 
> [Severity: High]
> This is a pre-existing issue, but does aer_recover_queue() permanently leak
> the aer_info allocation if the ring buffer overflows?
> 
> The aer_info is allocated from the fixed-size ghes_estatus_pool via
> gen_pool_alloc() earlier in this function. When passed to
> aer_recover_queue(), memory ownership is dropped without freeing it if
> the queue operation fails:
> 
> drivers/pci/pcie/aer.c:aer_recover_queue() {
>     if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
>                             &aer_recover_ring_lock))
>         schedule_work(&aer_recover_work);
>     else
>         pr_err("buffer overflow in recovery...");
>         /* aer_regs pointer dropped here */
> }
> 
> Since this pool is small and fixed-size, could an error storm that overflows
> the queue permanently deplete the pool and disable further ACPI GHES error
> reporting?
> 
>> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
>> index e0e01aa5eba6c..4005344dda55f 100644
>> --- a/drivers/cxl/core/ras_rch.c
>> +++ b/drivers/cxl/core/ras_rch.c
> [ ... ]
>> @@ -58,31 +58,17 @@ void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>>  				 struct aer_capability_regs *aer_regs)
>>  {
> [ ... ]
>> -	/* Use readl() to guarantee 32-bit accesses */
>> -	for (n = 0; n < read_cnt; n++)
>> -		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>> +	for (int n = 0; n < ARRAY_SIZE(raw); n++)
>> +		raw[n] = readl(aer_base + n * sizeof(u32));
>> +
>> +	aer_cap_regs_unpack(aer_regs, raw, sizeof(raw));
> 
> [Severity: High]
> Could populating the raw array using readl() cause data corruption on
> big-endian systems?
> 
> By using readl(), the raw array is filled with host-endian values. When
> aer_cap_regs_unpack() later extracts byte-offsets via memcpy(), this will
> read from the wrong half of the u32 on big-endian architectures, swapping
> fields like the correctable and uncorrectable error sources.
> 
>> diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
>> index 71f8fc9ea2edc..bba80c3803587 100644
>> --- a/drivers/pci/pcie/tlp.c
>> +++ b/drivers/pci/pcie/tlp.c
> [ ... ]
>> +void aer_cap_regs_unpack(struct aer_capability_regs *regs, const void *raw,
>> +			 size_t raw_len)
>> +{
> [ ... ]
>> +	if (raw_len < PCI_ERR_HEADER_LOG)
>> +		return;
>> +	memcpy(regs, raw, PCI_ERR_HEADER_LOG);
>> +
>> +	flit = FIELD_GET(PCI_ERR_CAP_TLP_LOG_FLIT, regs->cap_control);
> 
> [Severity: High]
> Will this extract the wrong bits on big-endian systems when processing
> little-endian CPER streams?
> 
> If raw comes from ACPI GHES (where it is little-endian), the memcpy() just
> above populates regs->cap_control with little-endian bytes. On a big-endian
> system, this results in a byte-swapped integer, causing FIELD_GET() to read
> incorrect bits for the FLIT status and TLP log size.
> 
> [ ... ]
>> +	if (raw_len >= PCI_ERR_ROOT_ERR_SRC + sizeof(regs->cor_err_source) +
>> +		       sizeof(regs->uncor_err_source)) {
>> +		memcpy(&regs->cor_err_source, raw + PCI_ERR_ROOT_ERR_SRC,
>> +		       sizeof(regs->cor_err_source));
> 
> [Severity: High]
> Does this byte-level copy extract the wrong half of the register on
> big-endian systems?
> 
> When raw is populated as a host-endian u32 array (as is done in
> cxl_rch_get_aer_info), copying 2 bytes from the PCI_ERR_ROOT_ERR_SRC offset
> will extract the upper 16 bits instead of the lower 16 bits on big-endian
> machines. This swaps the correctable and uncorrectable error source fields.
> 

