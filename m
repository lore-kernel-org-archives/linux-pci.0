Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1492DC339
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770710457; cv=none; b=e9nHaE7edrcpDAzK0Do1QmoRLK1gmIOtAJZyRsC0AMilpHBvdgnLMV74KXe3vSJZawu1RgLlC3Q9/d25nyGgNj6lJRMVmuT2lOp00/cVPYM5JIRUgNZdC3vXT0xQGT+b7IUXQzgvJ2Yk3XwG8ly0PD5w5IFjZIa+dr/0dyf21iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770710457; c=relaxed/simple;
	bh=alr9acrPDFQl/wkEtyJ9+6LnIT4r6q8eUgoXYcLQ56w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XizZc/FX505nZSJOc+hriAbbWmSIKquZgl5j2kGilfl8CfsNiZkg8xuCJDm8TBHaCCDclyzKPdIEWnIk5rQB9RmZITMPFu6NYjLvfNpn3LRPIH/Ab7aWwAYlR2HrLDxffhUwhF9JGxPobaTpy4I0ihd2SlVyB1JUVJkFG4hsqGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AEJDqeG8; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AEJDqeG8"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=e0EpMAqMYKY5VXAbH/yn/E2kbczOXm4DmtVcUg9K4s0=;
	b=AEJDqeG82SPG5FKkA9WrK6sbLKnWSJOCOpvqXwYGx+KNVgh37eIx/hgckIVQzFCp1a/acTYFX
	EGhH8xctLaXf4lJ2ZaT4i8YMkNcRN145Guyeh6xgeccyTAEb5RSwxXSIzyUg8OgBqiktgjCBUkf
	6RZdkAedpeGFCn06S0nDQjQ=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4f9DQj68VlzmV6k;
	Tue, 10 Feb 2026 15:56:13 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 79FF54056D;
	Tue, 10 Feb 2026 16:00:52 +0800 (CST)
Received: from kwepemn200012.china.huawei.com (7.202.194.135) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Feb 2026 16:00:49 +0800
Received: from [10.67.120.233] (10.67.120.233) by
 kwepemn200012.china.huawei.com (7.202.194.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Feb 2026 16:00:49 +0800
Message-ID: <f8825b07-653b-4c8d-b805-b3ff65d4c713@huawei.com>
Date: Tue, 10 Feb 2026 16:00:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/AER: Fix AER log missing in DPC case
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <jonathan.cameron@huawei.com>,
	<shiju.jose@huawei.com>, <pandoh@google.com>, <linux-pci@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<shenyang39@huawei.com>
References: <20260206201046.GA75132@bhelgaas>
From: Sizhe LIU <liusizhe5@huawei.com>
In-Reply-To: <20260206201046.GA75132@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn200012.china.huawei.com (7.202.194.135)

On 2026/2/7 4:10, Bjorn Helgaas wrote:

> On Thu, Jan 29, 2026 at 10:01:03PM +0800, Sizhe Liu wrote:
>> In the current DPC error reporting case, some AER log information is missing.
>>
>> -- Error log abnormal
>> pcieport 0000:20:00.0: DPC: containment event, status: 0x1f11: unmasked uncorrectable error detected
>> (------ AER error log supposed to be printed here, but missing ------)
>> nvme nvme0: frozen state error detected, reset controller
>> {4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
>>
>> Cause:
>> In aer_print_error(), PCIe AER errors is reported, and is rate-limited
>> by info->ratelimit_print[i]. There are two entry points for
>> aer_print_error().
>>
>> 1) Native AER
>> aer_isr_one_error_type() -> aer_process_err_devices() ->
>> aer_print_error()
>> 2) DPC
>> dpc_process_error() -> aer_print_error()
>>
>> The value of info->ratelimit_print[i] is initialized correctly in
>> the native AER case:
>> aer_isr_one_error_type() -> find_source_device() ->
>> find_device_iter() -> add_error_device()
>>
>> In the DPC case, info->ratelimit_print[i] is not initialized and
>> alloc by 0 , so in aer_print_error(), it will directly return at line
>> if (!info->ratelimit_print[i])
>> This will result in losing the AER log messages in the DPC case.
>>
>> Solution:
>> 1. Move the initialization of info->ratelimit_print[i] to
>> aer_ratelimit_print_init().
>> 2. Add aer_ratelimit_print_init() in dpc_process_error().
>> 3. Replace the initialization by aer_ratelimit_print_init()in
>> Native AER case.
> I see the problem, and I think you're right that we're not logging any
> AER info for DPC events (including events handled via the EDR path,
> which also calls dpc_process_error()).
>
> Currently we do the ratelimit init in add_error_device(), which also
> includes pci_dev_get() for the device.  I don't see a similar
> pci_dev_get() anywhere in the DPC path.  There is one in the EDR path:
>
>    edr_handle_event
>      acpi_dpc_port_get
>        pci_dev_get                    <--
>      dpc_process_error
>        aer_get_device_error_info(aer_err_info)
>        aer_print_error(aer_err_info)
>      pcie_do_recovery
>      pci_dev_put
>
> Maybe DPC and EDR should be using add_error_device() directly?  It
> seems like holding that reference on the device is important.
I agree with directly using add_error_device() – holding a reference to 
the device is a more robust approach.
Below is the detailed call trace for reference:

DPC path:
     dpc_handler
         add_error_device           <--
         dpc_process_error
             aer_get_device_error_info(aer_err_info)
             aer_print_error(aer_err_info)
         pcie_do_recovery
         pci_dev_put

EDR path:
     edr_handle_event
         acpi_dpc_port_get
             add_error_device           <--
         dpc_process_error
             aer_get_device_error_info(aer_err_info)
             aer_print_error(aer_err_info)
         pcie_do_recovery
         pci_dev_put

I will implement this change in the v3 patch and add relevant comments 
to add_error_device() for clarity.

Thanks,
Sizhe
>> Test with AER inject:
>> Set the DPC reporting priority in the BIOS and send
>> MalfTLP(AER FATAL ERROR) to device.
>>
>> -- Error log normal
>> pcieport 0000:20:00.0: DPC: containment event, status:0x1f11: unmasked uncorrectable error detected
>> pcieport 0000:20:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>> pcieport 0000:20:00.0: device [19e5:a120] error status/mask=00040000/04580000
>> pcieport 0000:20:00.0:    [18] MalfTLP   (First)
>> pcieport 0000:20:00.0: AER:   TLP Header: 0x00000000 0x00000000 0x00000000 0x00000000
>> nvme nvme0: frozen state error detected, reset controller
>> {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
>>
>> [1] https://lore.kernel.org/linux-pci/20260127035405.712271-1-liusizhe5@huawei.com/
>>
>> Fixes: a57f2bfb4a58 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
>> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
>> ---
>> v2
>> - Corrected the format and spelling errors in the commit log.
>>
>>   drivers/pci/pci.h      |  1 +
>>   drivers/pci/pcie/aer.c | 35 +++++++++++++++++++++++------------
>>   drivers/pci/pcie/dpc.c |  1 +
>>   3 files changed, 25 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 0e67014aa001..0cbcbcd52354 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -748,6 +748,7 @@ struct aer_err_info {
>>   
>>   int aer_get_device_error_info(struct aer_err_info *info, int i);
>>   void aer_print_error(struct aer_err_info *info, int i);
>> +void aer_ratelimit_print_init(struct pci_dev *dev, struct aer_err_info *e_info, int idx);
>>   
>>   int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>>   		      unsigned int tlp_len, bool flit,
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index e0bcaa896803..b73915b63327 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -925,6 +925,28 @@ int cper_severity_to_aer(int cper_severity)
>>   EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>>   #endif
>>   
>> +/**
>> + * aer_ratelimit_print_init - set flag whether error message is printed
>> + * @dev: pointer to pci_dev to be rate-limited
>> + * @e_info: pointer to error info
>> + * @idx: index for ratelimit_print array
>> + */
>> +void aer_ratelimit_print_init(struct pci_dev *dev, struct aer_err_info *e_info, int idx)
>> +{
>> +	/*
>> +	 * Ratelimit AER log messages.  "dev" is either the source
>> +	 * identified by the root's Error Source ID or it has an unmasked
>> +	 * error logged in its own AER Capability.  Messages are emitted
>> +	 * when "ratelimit_print[i]" is non-zero.  If we will print detail
>> +	 * for a downstream device, make sure we print the Error Source ID
>> +	 * from the root as well.
>> +	 */
>> +	if (aer_ratelimit(dev, e_info->severity)) {
>> +		e_info->ratelimit_print[idx] = 1;
>> +		e_info->root_ratelimit_print = 1;
>> +	}
>> +}
>> +
>>   void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>   		   struct aer_capability_regs *aer)
>>   {
>> @@ -990,18 +1012,7 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>>   	e_info->dev[i] = pci_dev_get(dev);
>>   	e_info->error_dev_num++;
>>   
>> -	/*
>> -	 * Ratelimit AER log messages.  "dev" is either the source
>> -	 * identified by the root's Error Source ID or it has an unmasked
>> -	 * error logged in its own AER Capability.  Messages are emitted
>> -	 * when "ratelimit_print[i]" is non-zero.  If we will print detail
>> -	 * for a downstream device, make sure we print the Error Source ID
>> -	 * from the root as well.
>> -	 */
>> -	if (aer_ratelimit(dev, e_info->severity)) {
>> -		e_info->ratelimit_print[i] = 1;
>> -		e_info->root_ratelimit_print = 1;
>> -	}
>> +	aer_ratelimit_print_init(dev, e_info, i);
>>   	return 0;
>>   }
>>   
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index fc18349614d7..d17adc642781 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -275,6 +275,7 @@ void dpc_process_error(struct pci_dev *pdev)
>>   			 status);
>>   		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
>>   		    aer_get_device_error_info(&info, 0)) {
>> +			aer_ratelimit_print_init(pdev, &info, 0);
>>   			aer_print_error(&info, 0);
>>   			pci_aer_clear_nonfatal_status(pdev);
>>   			pci_aer_clear_fatal_status(pdev);
>> -- 
>> 2.33.0
>>
>
