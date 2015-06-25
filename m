Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:20775 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbbFYHZd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jun 2015 03:25:33 -0400
Message-ID: <558BACD5.9030305@huawei.com>
Date: Thu, 25 Jun 2015 15:25:09 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	PCI <linux-pci@vger.kernel.org>,
	"Herui (Ray)" <Ray.herui@huawei.com>
Subject: Re: Assign mem resource fail after remove and rescan
References: <55167C1C.6010001@huawei.com>	<CAE9FiQWWNmJA1qKDaumuc8+EOj7E+fhbaZaNzTVyaDzbX4j9Hg@mail.gmail.com>	<551A40E8.4080708@huawei.com>	<CAE9FiQUQ_Kz8sNzu9RmOfoe4xEwfZ3atGcfQ39UAp4dRz2rRFA@mail.gmail.com>	<20150505190729.GA24643@google.com>	<558B608F.9060003@huawei.com> <CAE9FiQWThD_o=5+3BVoWR7xCyXWzHOUqCAkWUK2BKo+oyN0YnQ@mail.gmail.com>
In-Reply-To: <CAE9FiQWThD_o=5+3BVoWR7xCyXWzHOUqCAkWUK2BKo+oyN0YnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/25 15:05, Yinghai Lu wrote:
> On Wed, Jun 24, 2015 at 6:59 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>>
>> Hi Yinghai, do you have some updates for this patch ?
>> I open a bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=100451
>>
>> I hope this fix could be merged in upstream.
> 
> Found problem with that patch on system with several bridges.
> 
> I am reworking allocation code.
> 
> Please check if you can test
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> for-pci-v4.2-rc1
> 
> on the setup.
> 
> It includes patches that support more smart bus align calculation and
> alt_align etc.

OK, I will look at it and try to test in local machine.

Thanks!
Yijing.

> 
> Thanks
> 
> Yinghai
> 
> 


-- 
Thanks!
Yijing

