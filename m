Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3DC3559DF;
	Wed, 18 Mar 2026 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856095; cv=none; b=FRNDfBG2gpUTnnmlr/CiKo2E3MRbQ2wX58eT8PxAzngpCYiusUE8Xp4Inqdg9l9ePUmMB3uiB9vQcTQxUNVEJYOqjhLqUIYe3fzcyvjqzJ5YRU7SCWGuF0Imfikj/Vi1L3nOvodB88DU9bV4ywI8o0q58ZMCE2TRCWRWV09giQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856095; c=relaxed/simple;
	bh=EBXx7mZURjjriaHaknc92YiYxITjYget2D/5f5AFI88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONIKsZUGKI4cd6n6PAO+NoV8uosaL6NC2Bzkug3Hpycfn2nCHOFkJy1DmYgyWmp3iowdsPBwJ3UlZd07ulE0zlCZ/jdEzlfkax3YUDb1h7MmMUSBb9M1Tcl4cFRmpxoI7OQZwqcFX5ep98j48kyjFib5U2MVXrHBODzZSNZ741g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brlf0DfV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brlf0DfV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773856094; x=1805392094;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EBXx7mZURjjriaHaknc92YiYxITjYget2D/5f5AFI88=;
  b=brlf0DfVpUDBQBCb7ZsFAkbFAksbpjH8RsWXXM6azELxnHLwmiI5A+r/
   naJOVOVNW8yqObYjU/qg48AK8/lfGz5lflmwwKKm6ABb2AUUY+HfHitzc
   cNjSDKLkgLSSWNUEcPMLka5E+4BEuMRJP95u4kwnusIf1aq14qErqVAXZ
   MwAduF+Ob1HnZopbeiRDcibUDqsaKwLTMDjThf2a8HyHIjFExI0eNOR0+
   4a84XO9S7B3OGx6YHvRAm+DmniQuaOErM1iLpU97xPDkh6PdkX0b0Dhf2
   WFk66RY3jj3ORFUQCCDZyU/V1YaZyx1pvWN9P3qJCX5jnHXb/aqf2z9u3
   A==;
X-CSE-ConnectionGUID: zeSLSg0SQzShIgSHbQ1Kjg==
X-CSE-MsgGUID: gK6zAoJTR+Kai1HaWe+iTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85550910"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85550910"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 10:48:13 -0700
X-CSE-ConnectionGUID: oKuGj8cqTOOym4NC7m+ULg==
X-CSE-MsgGUID: JJ4rVujgRa6YfmmD5Ensqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="226835664"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 10:48:08 -0700
Message-ID: <875b2f99-35b9-4a7c-b47e-bfdc543ef7a0@linux.intel.com>
Date: Wed, 18 Mar 2026 10:48:07 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI/DPC: Fix AER error logging for DPC/EDR triggered
 events
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, Jon Pan-Doh <pandoh@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Sizhe Liu <liusizhe5@huawei.com>
References: <20260318172203.GA51847@bhelgaas>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260318172203.GA51847@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bjorn,

On 3/18/2026 10:22 AM, Bjorn Helgaas wrote:
> [+cc Sizhe]
> 
> On Wed, Mar 18, 2026 at 10:04:49AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> aer_print_error() skips printing if ratelimit_print[i] is not set.
>> In the native AER path, ratelimit_print is initialized by
>> add_error_device() during source device discovery, and is set to 1
>> for fatal errors to bypass rate limiting since fatal errors should
>> always be logged.
>>
>> The DPC/EDR path uses the DPC-capable port as the error source and
>> reads its AER uncorrectable error status registers directly in
>> dpc_get_aer_uncorrect_severity(). Since it does not go through
>> add_error_device(), ratelimit_print[0] is left uninitialized and zero.
>> As a result, aer_print_error() silently drops all AER error messages
>> for DPC/EDR triggered events.
>>
>> Set ratelimit_print[0] to 1 to bypass rate limiting and always print
>> AER logs for fatal errors.
>>
>> Fixes: a57f2bfb4a58 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
>> Co-developed-by: Goudar Manjunath Ramanagouda <manjunath.ramanagouda.goudar@intel.com>
>> Signed-off-by: Goudar Manjunath Ramanagouda <manjunath.ramanagouda.goudar@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> I think this does the same as
> https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=d4d1ecff2c2d
> which is already queued for v7.1.

Thanks for the reference.

Since errors in the DPC path leads to port containment, I think it is best to
always log them for reference and debug purposes. So I think we don't need to
export aer_print_init() from the AER driver (which can ratelimit non-fatal DPC
error). Instead we can by default skip ratelimit for DPC errors by initializing
ratelimit_print[0] = 1.

.

> 
>> ---
>>  drivers/pci/pcie/dpc.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index fc18349614d7..7605ddd9f0ba 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -256,6 +256,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>>  
>>  	info->dev[0] = dev;
>>  	info->error_dev_num = 1;
>> +	info->ratelimit_print[0] = 1;
>>  
>>  	return 1;
>>  }
>> -- 
>> 2.43.0
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

