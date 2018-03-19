Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:39242 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932794AbeCSIyF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Mar 2018 04:54:05 -0400
Subject: Re: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in hv_pci_onchannelcallback
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        bhelgaas@google.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
 <20180319083850.tglknmwwybdhahfl@mwanda>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <63a95bfd-0199-b935-b8d0-2b73d82e8d46@gmail.com>
Date: Mon, 19 Mar 2018 16:53:52 +0800
MIME-Version: 1.0
In-Reply-To: <20180319083850.tglknmwwybdhahfl@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2018/3/19 16:38, Dan Carpenter wrote:
> On Sun, Mar 18, 2018 at 10:53:02PM +0800, Jia-Ju Bai wrote:
>> hv_pci_onchannelcallback() is not called in atomic context.
>>
>> The call chain ending up at hv_pci_onchannelcallback() is:
>> [1] hv_pci_onchannelcallback() <- hv_pci_probe()
>> hv_pci_probe() is only set as ".probe" in hv_driver
>> structure "hv_pci_drv".
>>
> Your static analysis tool is faulty and apparently so is Smatch.
>
> $ smdb function_ptrs hv_pci_onchannelcallback
>
> Says it can't find a caller.  When I look for function pointers I get:
>
> $ smdb function_ptr hv_pci_onchannelcallback
> hv_pci_onchannelcallback =  'hv_pci_onchannelcallback' , 'vmbus_open param 5' , '(struct vmbus_channel)->onchannel_callback' , '__read_once_size param 0'
>
> Anyway the call tree is:
>
> vmbus_chan_sched() <-- takes rcu_read_lock();
> -> vmbus_channel_isr()
>     -> channel->onchannel_callback() -> which is hv_pci_onchannelcallback(

Thanks for your reply :)
I admit my tool produces a false positive for this code...
Sorry for my incorrect patch.

Anyway, I find that function pointers are quite hard to analyze in the 
Linux kernel code, because their usages are often flexible.
Have you found a good way to handle function pointers? Or can you 
recommend some good tools to handle them?


Best wishes,
Jia-Ju Bai
