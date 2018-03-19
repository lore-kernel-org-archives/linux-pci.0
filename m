Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in hv_pci_onchannelcallback
To: KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
 <SN6PR2101MB0893202C038AB406C6A6546BA0D40@SN6PR2101MB0893.namprd21.prod.outlook.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <c13413c3-67e2-fd1f-c8d0-28e810c6287b@gmail.com>
Date: Mon, 19 Mar 2018 11:44:11 +0800
MIME-Version: 1.0
In-Reply-To: <SN6PR2101MB0893202C038AB406C6A6546BA0D40@SN6PR2101MB0893.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2018/3/19 10:52, KY Srinivasan wrote:
>
>> -----Original Message-----
>> From: Jia-Ju Bai <baijiaju1990@gmail.com>
>> Sent: Sunday, March 18, 2018 7:53 AM
>> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
>> <haiyangz@microsoft.com>; Stephen Hemminger
>> <sthemmin@microsoft.com>; bhelgaas@google.com
>> Cc: devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Jia-Ju Bai <baijiaju1990@gmail.com>
>> Subject: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
>> GFP_KERNEL in hv_pci_onchannelcallback
>>
>> hv_pci_onchannelcallback() is not called in atomic context.
>>
>> The call chain ending up at hv_pci_onchannelcallback() is:
>> [1] hv_pci_onchannelcallback() <- hv_pci_probe()
>> hv_pci_probe() is only set as ".probe" in hv_driver
>> structure "hv_pci_drv".
> This function is setup as the function to handle interrupts on the channel. Hence the
> need for GFP_ATOMIC.
>

Oh, sorry for my incorrect patch.
Thanks for your reply :)


Best wishes,
Jia-Ju Bai
