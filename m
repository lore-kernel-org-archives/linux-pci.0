Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:62463 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933208AbbFXBrY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2015 21:47:24 -0400
Message-ID: <558A0C1F.6010405@huawei.com>
Date: Wed, 24 Jun 2015 09:47:11 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: Use usleep_range() instead of msleep() for better
 accuracy
References: <1434700666-6346-1-git-send-email-wangyijing@huawei.com> <1434700666-6346-4-git-send-email-wangyijing@huawei.com> <20150619171249.GK7710@google.com>
In-Reply-To: <20150619171249.GK7710@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/20 1:12, Bjorn Helgaas wrote:
> On Fri, Jun 19, 2015 at 03:57:46PM +0800, Yijing Wang wrote:
>> Msleep < 20ms can sleep for up to 20ms, see
>> Documentation/timers/timers-howto.txt, so we could
>> use usleep_range instead.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/hotplug/pciehp_hpc.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> index daf54be..4553728 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -118,7 +118,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>>  		}
>>  		if (timeout < 0)
>>  			break;
>> -		msleep(10);
>> +		usleep_range(10000, 11000);
> 
> timers-howto.txt also says to use msleep for 10ms+ delays, so the guidance
> is a bit ambiguous.
> 
> This particular delay does not need to be precise, and if we delay 20ms
> instead of 10ms (1/50th of a second vs 1/100th of a second), I don't think
> it makes any difference at all.
> 
> If we *did* make a change here, I think we should use a range of at least
> 10ms.  There's no need to tighten the wakeup time to the 1ms window between
> 10ms and 11ms.  Any time in the range of 10ms to 50ms would probably be
> fine.
> 
> But I don't think a change here is necessary, and it does make it a bit
> harder to analyze the code because we have some things in microseconds and
> others in milliseconds.

OK， I got it, thanks for your explanation.

Thanks!
Yijing.


> 
>>  		timeout -= 10;
>>  	}
>>  	return 0;	/* timeout */
>> -- 
>> 1.7.1
>>
> 
> 


-- 
Thanks!
Yijing

