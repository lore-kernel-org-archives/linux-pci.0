Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:10973 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755590AbaE2DyN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 May 2014 23:54:13 -0400
Message-ID: <5386AF2D.9050803@huawei.com>
Date: Thu, 29 May 2014 11:53:17 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: fix return in pci_bus_add_device
References: <1400729544-7940-1-git-send-email-wangyijing@huawei.com>	<20140528032213.GP11907@google.com>	<538558D2.3050706@huawei.com>	<CAE9FiQWM15UHvX=7wv4aMXfTp5QLsB+J9c1qjOzpZ1vU0ePB4A@mail.gmail.com>	<53868F40.8000909@huawei.com> <CAE9FiQX6-E7xq9Ew=KJQnMf9NkorSBtsAEWt_9+PW2R_T5ABrg@mail.gmail.com>
In-Reply-To: <CAE9FiQX6-E7xq9Ew=KJQnMf9NkorSBtsAEWt_9+PW2R_T5ABrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/5/29 11:36, Yinghai Lu wrote:
> On Wed, May 28, 2014 at 6:37 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>>>> I found some kernel code still check this return value, and I also think return the
>>>> real retval make sense.
>>>
>>> No, that is not right.
>>>
>>> If you look closely,
>>>
>>> device_attach() returns
>>> 1: success
>>> 0: not attached
>>> <0: fail.
>>
>> Hi Yinghai,
>>    Thanks for your explanation.
>> I found all the kernel code to check its return value, only for print a warning for users.
>>
>>
>> So I think we can drop all return checking from calling path
> 
> I prefer this one. as pci_bus_add_device already have
> 
>>         WARN_ON(retval < 0);
> 
> There is no need to print warning message later again.

OK, thanks for your suggestion.
I will send a patchset to clean the unnecessary check in kernel.

Hi Bjorn, please drop this patch.

Thanks!
Yijing.

> 
> 


-- 
Thanks!
Yijing

