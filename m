Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:27977 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbbDBIgV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2015 04:36:21 -0400
Message-ID: <551CFF6F.8050000@huawei.com>
Date: Thu, 2 Apr 2015 16:35:59 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	PCI <linux-pci@vger.kernel.org>,
	"Herui (Ray)" <Ray.herui@huawei.com>
Subject: Re: Assign mem resource fail after remove and rescan
References: <55167C1C.6010001@huawei.com>	<CAE9FiQWWNmJA1qKDaumuc8+EOj7E+fhbaZaNzTVyaDzbX4j9Hg@mail.gmail.com>	<551A40E8.4080708@huawei.com> <CAE9FiQUQ_Kz8sNzu9RmOfoe4xEwfZ3atGcfQ39UAp4dRz2rRFA@mail.gmail.com>
In-Reply-To: <CAE9FiQUQ_Kz8sNzu9RmOfoe4xEwfZ3atGcfQ39UAp4dRz2rRFA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/4/2 6:21, Yinghai Lu wrote:
> On Mon, Mar 30, 2015 at 11:38 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>> On 2015/3/29 14:18, Yinghai Lu wrote:
>>> On Sat, Mar 28, 2015 at 3:02 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>>>> ...
>>>>
>>>> I compared above log and found after we did remove and rescan, the bridge requested resource size extended to 0x06000000,
>>>> and when system boot up, it requested only 0x4800000.
>>>>
>>    I tested it, remove and rescan 05:19.0 device is ok now, but
>> if do the operations for the parent device of 05:19.0, the result is
>> still fail.
> 
> Found the problem, attached patch should fix the problem.

Thanks, will test soon.

> 
> Thanks
> 
> Yinghai
> 


-- 
Thanks!
Yijing

