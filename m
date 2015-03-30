Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:2580 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbbC3EGt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2015 00:06:49 -0400
Message-ID: <5518CBA2.2020606@huawei.com>
Date: Mon, 30 Mar 2015 12:05:54 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	PCI <linux-pci@vger.kernel.org>,
	"Herui (Ray)" <Ray.herui@huawei.com>
Subject: Re: Assign mem resource fail after remove and rescan
References: <55167C1C.6010001@huawei.com> <CAE9FiQWWNmJA1qKDaumuc8+EOj7E+fhbaZaNzTVyaDzbX4j9Hg@mail.gmail.com>
In-Reply-To: <CAE9FiQWWNmJA1qKDaumuc8+EOj7E+fhbaZaNzTVyaDzbX4j9Hg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/3/29 14:18, Yinghai Lu wrote:
> On Sat, Mar 28, 2015 at 3:02 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>> ...
>>
>> I compared above log and found after we did remove and rescan, the bridge requested resource size extended to 0x06000000,
>> and when system boot up, it requested only 0x4800000.
>>
>> In hotplug(remove and rescan) path, we would call calculate_mem_align() function which would align the resource at 0x2000000.
> 
> Looks like we align the size too early. Please check if attach patch
> could fix the problem.

OK, I will test it today, thanks!


> 
> Thanks
> 
> Yinghai
> 


-- 
Thanks!
Yijing

