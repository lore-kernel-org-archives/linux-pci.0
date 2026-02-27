Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB831B425C
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215276; cv=none; b=K59qrq+VYRwkfWUNbb/2Z+O3aukTb9NCWrdt/HPX+zbyho9OEIw+aRO56Rz5w9BtL8JJ7ff53CwLou6F/TxUjttqUgy03quBihXVy97mO8c4VH7BioiPzywbSIBJUBRUxjUi0p8JzUY3NdBrVCdQiFEjKlWPtmU015hcdA63OfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215276; c=relaxed/simple;
	bh=P5bbUYuFNAPflWkxQIFMgULdonwa8RYwr/kCHg9CDBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ogj/Mv43nZukCJtTO0qMBe/dx7c3+SvzZYtDnGmHEslyppFp8wDMtBtBW3e4ceUNNRYnrxAUYA0PQtFlfXQWqQRH4/TgLnX9+Qs4QIF2uniplQi77hzYsZ5eCOEoqF28xAmWZZ9EGuGIIlEE/TlUyh4chWqUe5gbvTDaUREjYL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHVQEkjO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHVQEkjO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772215275; x=1803751275;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P5bbUYuFNAPflWkxQIFMgULdonwa8RYwr/kCHg9CDBs=;
  b=jHVQEkjO0g3wJl2iIr+ROR6NEDgaucHcq4P8LkbRqHVGgIsMuMf1m+e/
   1BhJt+pe7ZaQROKcyiimIQ0rL/fv7FUWUEOxokEil2JVNWlIHu465gYeY
   nSXvjY9WU8qMl2weoWP5j8+Mt19SM9NuJdFiOTSEfj1W5nil/FfVLPUDK
   MHh41hJDE8Hj+b+tDviWjvDyJZbPGCANKWFBOhuTgQC6zdwylw+iSpxU/
   Ri/o0Vp4X4C+VlT6LzQqFefDCJYVzIyn6A9JN4NWZPeJ8n57Fm0CwOa80
   dgkUUEJO+MGtNdeSFfZyBzSMxSC1VFDbe7ponzCFvdmvV0EH3Gm1Z6EYT
   w==;
X-CSE-ConnectionGUID: vwYJklrKSRqL3Y1S8FAzVQ==
X-CSE-MsgGUID: FoLzLdHxRUyrRGweNxQl6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="77143455"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="77143455"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 10:01:14 -0800
X-CSE-ConnectionGUID: 0XWfsnxhRBCPYMrTKyUOdw==
X-CSE-MsgGUID: NTYAy2XCRhKzXTokjTmJzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="214360302"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 10:01:14 -0800
Message-ID: <d7224e3c-bec1-4c4c-ac83-a664de7b931a@linux.intel.com>
Date: Fri, 27 Feb 2026 10:01:13 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ERR: Clear fatal status of the reporting device
To: Bjorn Helgaas <helgaas@kernel.org>, Sizhe Liu <liusizhe5@huawei.com>
Cc: bhelgaas@google.com, jonathan.cameron@huawei.com, shiju.jose@huawei.com,
 keith.busch@intel.com, linux-pci@vger.kernel.org, linuxarm@huawei.com,
 prime.zeng@hisilicon.com, fanghao11@huawei.com, shenyang39@huawei.com,
 Shuai Xue <xueshuai@linux.alibaba.com>, Lukas Wunner <lukas@wunner.de>,
 Terry Bowman <terry.bowman@amd.com>
References: <20260227163118.GA3897131@bhelgaas>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260227163118.GA3897131@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/27/2026 8:31 AM, Bjorn Helgaas wrote:
> [+cc others interested in error handling]
> 
> On Fri, Feb 27, 2026 at 06:25:05PM +0800, Sizhe Liu wrote:
>> During PCIe native AER error recovery, ERR_FATAL status bits are not cleared
>> after fatal error handling. This causes stale ERR_FATAL bits to be reported
>> in subsequent AER events, even after reporting "device recovery successful".
>>
>> Prior to commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery"), native
>> AER handled non-fatal and fatal errors separately, clearing the corresponding
>> status bits for both types after processing. That commit unified the error
>> paths through pcie_do_recovery(), which began invoking
>> pci_cleanup_aer_uncorrect_error_status() after commit bfcb79fca19d
>> ("PCI/ERR: Run error recovery callbacks for all affected devices").
>>
>> This function only clears non-fatal error (NFE) bits and leaves ERR_FATAL
>> bits uncleared, resulting in stale error status.
>>
>> Fix this by explicitly clearing the ERR_FATAL status bits for the reporting
>> device during recovery, restoring the original fatal error handling behavior.
>>

It seem to be a valid fix to me. You probably need to add Fixes: tag and
cc stable.

>> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
>> ---
>>  drivers/pci/pcie/err.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index bebe4bc111d7..f51225f2592d 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -281,6 +281,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>  	if (host->native_aer || pcie_ports_native) {
>>  		pcie_clear_device_status(dev);
>>  		pci_aer_clear_nonfatal_status(dev);
>> +		pci_aer_clear_fatal_status(dev);
>>  	}

This code path is common for both fatal and non-fatal recovery. Clearing
the fatal status here during non-fatal recovery could silently erase newly
detected fatal errors. I suggest clearing it in the AER driver after it
parses the error.

>>  
>>  	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
>> -- 
>> 2.33.0
>>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

