Return-Path: <SRS0=AwBA=DR=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=AwBA=DR=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH 1/4] PCI/AER: Return approrpiate value when AER is not
 supported
To: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <keith.busch@intel.com>
References: <20171219210643.24615-1-keith.busch@intel.com>
 <20171221010452.GD30595@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Maik
 Broemme" <mbroemme@libmpq.org>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <0efc29a7-69ec-2dd3-0aa1-74013d10e5a3@huawei.com>
Date: Thu, 21 Dec 2017 11:53:36 +0800
MIME-Version: 1.0
In-Reply-To: <20171221010452.GD30595@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Current code APEI AER and native AER seems a little different.
APEI AER ,the device must have AER capability, then can do recovery.
Native AER seems the device under the ROOT PORT can do not have the
AER capability. Current patch seems can fix the Inconsistency.
But as PCIe 4.0r1.0 6.2.5 Sequence of Device Error Signaling and Logging
Operations describe,It seems the device can implement the Device Status reg,
but do not have AER capability.So for such devices, can we use AER driver to
call device error handler callback to do recovery?

Thanks,
Dongdong
在 2017/12/21 9:04, Bjorn Helgaas 写道:
> s/approrpiate/appropriate/
>
> (But maybe should be restated altogether, see below.)
>
> On Tue, Dec 19, 2017 at 02:06:40PM -0700, Keith Busch wrote:
>> Getting the AER information is documented to return 0 when it failed to
>> get the information.
>
> I think this case is either impossible (if we only call this function
> for devices known to support AER), or it fixes an actual bug (the
> caller would call aer_print_error() when it shouldn't, and potentially
> print garbage).  Right?
>
> If the former, I vote for removing the test.  If the latter, the
> changelog should mention that it fixes a bug.
>
>> Signed-off-by: Keith Busch <keith.busch@intel.com>
>> ---
>>  drivers/pci/pcie/aer/aerdrv_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
>> index 744805232155..ea0dc1cc7fc7 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_core.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
>> @@ -660,7 +660,7 @@ static int get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>>
>>  	/* The device might not support AER */
>>  	if (!pos)
>> -		return 1;
>> +		return 0;
>>
>>  	if (info->severity == AER_CORRECTABLE) {
>>  		pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS,
>> --
>> 2.13.6
>>
>
> .
>
