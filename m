Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737560;
	b=tLHKwrZdO6P88ymlZI5HDM1r5KC8Ak6mntoEZ3bNPjEFaJ9bz20TqMKID2mRwWYX4CGg
	 UH517XRGqwIxx6LDQaUxvRjD8ZqyYYWdPm3BkLeXMd01jwP6w5NK86nhDhnbQBjY3Uxyx
	 u53eTFXylox4b+/fezX+2am2ZrYw5r9k0AP/DqwkDVElZ8oRdq+HWzyF7gcJR4JhKkkr8
	 XdW4xCz8i6NgRqw9/2gAszLf4GX08EebQel5sfuDQst+sH5/hi7kaOzAumqK9WcLfqF0I
	 3GwXpONCX6Xd2H0irtlX+f6pc3LzBnLwwgg5DsGa+CwD6lixcsOSfTDjWuyXFqwTuNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737560;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=XRAM5MpIj6Z1I4smHHGIzRKW0/u/4IqPVzsD/vQ4Szc=;
	b=kBvZtnN4W3OT7L5OxaY4krEiZE/+b50dIAcNQFDg2j3jr+zumu3M1P+/PkxBA3lRzr1r
	 ex8NFX3nFtTGZuQIpUVFA+OMg7lOH+NNfWUBcopTRsDSQ4CBqDajfx0s8lbQYzqXe6TmR
	 bX6jIgjmp2KRuhPSwf/slOr8/lagj511v8ioxKq6d8Uc5IGv9Oiejp96QKYiveYI8tzNI
	 mR6gKpcRRgk+fB+yVCZSLdmxsa2eZ+2PabSPbzov6cwlKXHV7DUqneSpbokm/c+QCm2p7
	 jK6T3YaaB8/gVKMxRkgiogYSIDWvUWU1nCwN1ufEXxQVqznzLAPM9dHNMGptmQia2pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cz3B2Mne;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255F606A31B;
	Tue,  3 Nov 2026 20:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C255F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cz3B2Mne
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793737560; x=1825273560;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SWq5OmyCwps2TKvfMs9OIHkssrxda8Ynaleu/ktXDIo=;
  b=cz3B2MnebSH+bNOrpZA2C6ouWHpdqOFkAU7ZrJWBKnfW1JDUsFZl6oDw
   ISPyXXAmrqH79gZ1WGkvYdLcePaB7d8Dd88JK3Nm3/HbgM5cnB/hRcocX
   xloPGByRu0oWZMb+H9s8hCigdK5Isdfj3QdvI8d8BF03gsjZhbpMwKWZ9
   GAr8AjEpxWagoAicUgQ1YrZgZA5pJNILbjoBjkEiNxcUWwon6kQgJaZJV
   fA4FVXxtJPyPqqRF9H4JJLSZSDARNn90xcBsV41BuFYPb0gvVvdFokQox
   RDv3FwGEJxM+C/ZgKuWpLiJ8LVjHLNBqYEgQIBPzAdipQXcUZFK1q5Zux
   g==;
X-CSE-ConnectionGUID: qESWJvG1TDavkMn8TkYsJg==
X-CSE-MsgGUID: TrudUbU0SfOxyxc331GXTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2363865"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2363865"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 12:25:59 -0800
X-CSE-ConnectionGUID: ZKWMP0uSRnO4LPHIxgsSVg==
X-CSE-MsgGUID: glCrLts5R8mzg5QKla6bbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6529492"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 12:25:58 -0800
Message-ID: <fe6ad028-35b0-462f-a2df-d3f9c6af66dd@linux.intel.com>
Date: Tue, 3 Nov 2026 12:25:58 -0800
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
Subject: Re: [PATCH v2 1/6] PCI/DPC: Avoid access to non-existent AER
 capability
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261103194734.GA314988@yaz-khff2.amd.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20261103194734.GA314988@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/3/2026 11:47 AM, Yazen Ghannam wrote:
> On Tue, Oct 20, 2026 at 11:19:18AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> From: Lukas Wunner <lukas@wunner.de>
>>
>> Downstream Port Containment does not mandate presence of an Advanced Error
>> Reporting capability, so a Downstream Port may support DPC, but not AER
>> (PCIe r7.1 sec 6.2.11.2).
>>
>> In February 2019, commit 9f08a5d896ce ("PCI/DPC: Fix print AER status in
>> DPC event handling") amended the DPC driver to access the AER capability
>> without checking for its presence.
>>
>> In May 2020, commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST
>> parsing for AER ownership") fixed it by inserting a call to
>> pcie_aer_is_native() in dpc_probe(), which implicitly checks for presence
>> of an AER capability.
>>
>> However already in October 2019, commit 35a0b2378c19 ("PCI/DPC: Add
>> "pcie_ports=dpc-native" to allow DPC without AER control") made it
>> possible to override the check:  The DPC driver may access a non-existent
>> AER capability if "pcie_ports=dpc-native" is passed on the command line.
>>
>> Fix it by making the DPC driver cope with AER-unsupporting Downstream
>> Ports.
>>
>> There are two places where the AER capability is accessed:
>>
>> - dpc_get_aer_uncorrect_severity() uses it to discern whether a Fatal or
>>   Non-Fatal Error triggered DPC.  Access the Device Status Register
>>   instead, in accordance with PCIe r7.1 sec 6.2.5.
>>
>> - dpc_is_surprise_removal() uses it to detect whether a Surprise Down
>>   Error triggered DPC.  Return false on AER-unsupporting devices.  The
>>   function works around an AMD-specific quirk and it seems reasonable to
>>   assume that all affected products are AER-supporting.  In any case the
>>   detection is not possible without AER capability.
>>
>> Insert a temporary check for an AER capability after the call to
>> aer_get_device_error_info() because the function currently returns false
>> for AER-unsupporting devices.  The check will become obsolete and will be
>> removed with the imminent baseline capability error reporting.
>>
>> Fixes: 35a0b2378c19 ("PCI/DPC: Add "pcie_ports=dpc-native" to allow DPC without AER control")
>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
>> Cc: stable@vger.kernel.org # v5.5+
>> ---
>>  drivers/pci/pcie/dpc.c | 23 ++++++++++-------------
>>  1 file changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index 2b779bd1d861..793a799053f1 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -236,21 +236,15 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
>>  static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>>  					  struct aer_err_info *info)
>>  {
>> -	int pos = dev->aer_cap;
>> -	u32 status, mask, sev;
>> +	u16 devsta;
>>  
>> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
>> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
>> -	status &= ~mask;
>> -	if (!status)
>> -		return 0;
>> -
>> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
>> -	status &= sev;
>> -	if (status)
>> +	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
>> +	if (devsta & PCI_EXP_DEVSTA_FED)
>>  		info->severity = AER_FATAL;
>> -	else
>> +	else if (devsta & PCI_EXP_DEVSTA_NFED)
>>  		info->severity = AER_NONFATAL;
>> +	else
>> +		return 0;
>>  
>>  	info->level = KERN_ERR;
> 
> Did you settle your question from here?
> 
> https://lore.kernel.org/all/74fe0d79-dc90-4c05-ba9c-9a0eec1ada48@linux.intel.com/

No, not yet.  Lukas hasn't replied, and v2 carries his patch unchanged.

The concern still stands.  For a port with an AER capability, the
Fatal/Non-Fatal Error Detected bits in Device Status are set
regardless of the Uncorrectable Error Mask (PCIe r7.1 sec 7.5.3.5).
So a masked Fatal error next to the unmasked Non-Fatal error that
triggered DPC is now reported as Fatal.

If Lukas agrees, I can fix it in v3 by keeping the AER-based logic
when dev->aer_cap is present and using Device Status only for ports
without AER.

> 
> Thanks,
> Yazen

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

