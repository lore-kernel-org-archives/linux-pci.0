Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:44163 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab2HKCDG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Aug 2012 22:03:06 -0400
Message-ID: <5025BCC3.5040509@huawei.com>
Date: Sat, 11 Aug 2012 10:00:35 +0800
From: Hanjun Guo <guohanjun@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Eric Moore <Eric.Moore@lsi.com>, <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [RFC PATCH] Fusion MPT: disable pci device when mpt map resoures
 failed
References: <1344589722-8772-1-git-send-email-guohanjun@huawei.com> <CAE9FiQX1Zq+FwdqX6D805pryiHS9je6cMFLyZSPhJBmEt41rSQ@mail.gmail.com>
In-Reply-To: <CAE9FiQX1Zq+FwdqX6D805pryiHS9je6cMFLyZSPhJBmEt41rSQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012/8/11 0:32, Yinghai Lu wrote:
> On Fri, Aug 10, 2012 at 2:08 AM, Hanjun Guo <guohanjun@huawei.com> wrote:
>> when probe a pci device, first we enable it, and disable it when
>> some error happened in the following process, because the power
>> state of the device is set to D0, and if MSI is disabled,
>> we will allocate irq and register gsi for this device in the enable process.
>>
>> In function mpt_mapresources(MPT_ADAPTER *ioc), it forgot disable the
>> pci device when error happened, the irq and gsi will never be released.
>> this patch will fix it.
>>
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>> ---
>>  drivers/message/fusion/mptbase.c |   18 +++++++++++-------
>>  1 files changed, 11 insertions(+), 7 deletions(-)
> 
> You may need to send to LSI and scsi list.
> 
> You need to use ./scripts/get_maintainer.pl to find out right CC list.
> 
> Thanks
> 
> Yinghai

Hi Yinghai,

Thanks for your help, I really appreciate it.

I will resend this patch with the right CC list.

Thanks,
Hanjun Guo



