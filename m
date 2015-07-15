Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:22499 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbbGOFQg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2015 01:16:36 -0400
Message-ID: <55A5EC94.4090507@huawei.com>
Date: Wed, 15 Jul 2015 13:16:04 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/36] PCI: Add support for more than two alt_size under
 same bridge
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>	<1436225966-27247-18-git-send-email-yinghai@kernel.org>	<55A5CE68.90007@huawei.com> <CAE9FiQVZogYHKuXwkjQmCqFatBOAJYaQF=39_-Z9=FnWkbNHkQ@mail.gmail.com>
In-Reply-To: <CAE9FiQVZogYHKuXwkjQmCqFatBOAJYaQF=39_-Z9=FnWkbNHkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/7/15 13:08, Yinghai Lu wrote:
> On Tue, Jul 14, 2015 at 8:07 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>> On 2015/7/7 7:39, Yinghai Lu wrote:
>>> Need to increase size to make sure it could fit all alt entries.
>>>
>>> So at last, we use 8M/17M as parent bridge alt_align/alt_size.
>>
>> Tested-by: Yijing Wang <wangyijing@huawei.com>
> 
> Thanks for testing.
> 
>>
>> Hi Yinghai, does this patch depend on the previous items in this patchset ?
> 
> Yes, it depends most of patches from patch1 to this patch.
> 
>> Could you provide another version of this patch for stable branch, eg. 3.10 stable ?
> 
> That is RHEL 7 kernel, right ?

Yes.

> 
> After those patches get into upstream, I will try to port them to 3.10 stable.

Thanks very much!

> 
> Thanks
> 
> Yinghai
> 
> .
> 


-- 
Thanks!
Yijing

