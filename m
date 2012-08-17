Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:44225 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab2HQFBg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 01:01:36 -0400
Message-ID: <502DCFBF.5040901@huawei.com>
Date: Fri, 17 Aug 2012 12:59:43 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 3/3] PCI, acpiphp: Use res->flags to determine whether
 the resouce is valid
References: <1345119142-5896-1-git-send-email-wangyijing@huawei.com> <1345119142-5896-3-git-send-email-wangyijing@huawei.com> <502D9724.2030307@huawei.com> <CAErSpo7P7VtXBhZ2FTM8ozriyfjpRFp0V4HAVrqaiyMhhQpFTw@mail.gmail.com>
In-Reply-To: <CAErSpo7P7VtXBhZ2FTM8ozriyfjpRFp0V4HAVrqaiyMhhQpFTw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012/8/17 10:34, Bjorn Helgaas wrote:
> On Thu, Aug 16, 2012 at 6:58 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>> Hi Bjorn,
>>    Please ignore these three patches, I'm very sorry I still have some confusion about allocating resources
>> to pci devices.So this patch is not appropriate. I will provide new version patches when I find a better
>> solution for this problem.
> 
> We don't have a uniform way of detecting unassigned BARs and handling
> resource allocation failures yet.  When we make that all consistent, I
> think it will make it more obvious how to do these patches.
Yes, I also think maybe we need one uniform way to detecting unassigned BARs and resources
that be assigned failure.Then if necessary, some codes which want to correct or re-assign resoruces
for pci dev could do that more clearly. I will try to analyse that, and propose some patches as soon.
Thanks!
> I think patch 2/3 (the list_for_each_safe() one) is probably still a
> good bug fix, so with your permission, I'll keep that one.
Sure,that's ok.
>>> When we hot plug pci devices, system will allocate resources to these new add
>>> devices, pci_bus_assign_resources() will be called.If the pci devices was assigned
>>> resource fail, the resource struct will reset to zero.So I think use res->flags here
>>> to determine whether the resource is valid is reliable.


-- 
Thanks!
Yijing

