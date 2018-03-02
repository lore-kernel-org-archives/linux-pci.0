Return-Path: <SRS0=UNj1=FY=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=UNj1=FY=gmail.com=ckoenig.leichtzumerken@kernel.org>
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] PCI: stop crashing in pci_release_resource v2
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20180221090715.2853-1-christian.koenig@amd.com>
 <20180301184957.GI13722@bhelgaas-glaptop.roam.corp.google.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d850105e-3ce1-2957-de79-98f7eda2dcee@gmail.com>
Date: Fri, 2 Mar 2018 08:55:03 +0100
MIME-Version: 1.0
In-Reply-To: <20180301184957.GI13722@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 01.03.2018 um 19:49 schrieb Bjorn Helgaas:
> On Wed, Feb 21, 2018 at 10:07:15AM +0100, Christian König wrote:
>> Is it entirely possible that the BIOS wasn't able to assign resources to
>> a device. In this case don't crash in pci_release_resource() when we try
>> to resize the resource.
>>
>> v2: keep printing the info that we try to release the BAR
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> CC: stable@vger.kernel.org
> I was hoping for a dmesg snippet, but I added a Fixes: tag and applied
> this to for-linus for v4.16.

Sorry, been on vacation and missed your mail.

I don't have a dmesg of hand either, cause the reporter provided only a 
mail with a picture of the crash :)

But he confirmed that the patch worked.

Thanks,
Christian.

>
>> ---
>>   drivers/pci/setup-res.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>> index e815111f3f81..c0f091614805 100644
>> --- a/drivers/pci/setup-res.c
>> +++ b/drivers/pci/setup-res.c
>> @@ -402,6 +402,10 @@ void pci_release_resource(struct pci_dev *dev, int resno)
>>   	struct resource *res = dev->resource + resno;
>>   
>>   	dev_info(&dev->dev, "BAR %d: releasing %pR\n", resno, res);
>> +
>> +	if (!res->parent)
>> +		return;
>> +
>>   	release_resource(res);
>>   	res->end = resource_size(res) - 1;
>>   	res->start = 0;
>> -- 
>> 2.14.1
>>
