Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:22901 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624Ab2ISHeC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2012 03:34:02 -0400
Message-ID: <50597502.2020600@huawei.com>
Date: Wed, 19 Sep 2012 15:32:18 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Chen Gong <gong.chen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Huang Ying <ying.huang@intel.com>, <jiang.liu@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/6] fix aer_inject bug while doing pci hot-plug
References: <1348022442-7816-1-git-send-email-wangyijing@huawei.com> <20120919072435.GB15513@gchen.bj.intel.com>
In-Reply-To: <20120919072435.GB15513@gchen.bj.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012/9/19 15:24, Chen Gong wrote:
> On Wed, Sep 19, 2012 at 10:40:36AM +0800, Yijing Wang wrote:
>> Date: Wed, 19 Sep 2012 10:40:36 +0800
>> From: Yijing Wang <wangyijing@huawei.com>
>> To: Bjorn Helgaas <bhelgaas@google.com>, Huang Ying <ying.huang@intel.com>,
>>  Chen Gong <gong.chen@linux.intel.com>
>> CC: jiang.liu@huawei.com, Hanjun Guo <guohanjun@huawei.com>,
>>  linux-pci@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>
>> Subject: [PATCH 0/6] fix aer_inject bug while doing pci hot-plug
>> X-Mailer: git-send-email 1.7.11.msysgit.1
>>
>> v2--->v3
>> 1??find the pci_ops of nearest parent bus in patch 1;
>> 2??introduce pci_bus_ops_get to avoid race condition window in aer_inject_exit;
>> 3??scan the root bus for cleaning untracked pci_ops_aer instead of scan all pci bus as Huang Ying suggestion;
>> 4??remove unused code pci_bus_ops_pop;
>>
>> Yijing Wang (6):
>>   PCI/AER: fix pci_ops return NULL when hotplug a pci bus doing aer
>>     error inject
>>   PCI/AER: introduce pci_bus_ops_get() function to avoid a small race
>>     condition window
>>   PCI/AER: clean all untracked pci_ops_aer when rmmod aer_inject
>>   PCI/AER: clean pci_bus_ops when related pci bus was removed
>>   PCI/AER: introduce pci_bus_ops_free to free pci_bus_ops
>>   PCI/AER: clean unused code pci_bus_ops_pop
>>
>>  drivers/pci/pcie/aer/aer_inject.c |  149 ++++++++++++++++++++++++++++++++-----
>>  1 files changed, 131 insertions(+), 18 deletions(-)
>>
> After reviewing the whole patch series, I hava a feeling that you don't
> desrcibe the whole usage model very clearly. I suggest you update the
> description and express it more clearly and in detail, so other guys never touch
> aer-inject can understand it well. You patch is good but it doesn't mean
> others will like it because it is obscure to others never touching these codes.
> 
Sure, I will update the description of these patches.

-- 
Thanks!
Yijing

