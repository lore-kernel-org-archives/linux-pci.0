Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38287 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbbGOFIH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2015 01:08:07 -0400
MIME-Version: 1.0
In-Reply-To: <55A5CE68.90007@huawei.com>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
	<1436225966-27247-18-git-send-email-yinghai@kernel.org>
	<55A5CE68.90007@huawei.com>
Date: Tue, 14 Jul 2015 22:08:06 -0700
Message-ID: <CAE9FiQVZogYHKuXwkjQmCqFatBOAJYaQF=39_-Z9=FnWkbNHkQ@mail.gmail.com>
Subject: Re: [PATCH 17/36] PCI: Add support for more than two alt_size under
 same bridge
From: Yinghai Lu <yinghai@kernel.org>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 14, 2015 at 8:07 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> On 2015/7/7 7:39, Yinghai Lu wrote:
>> Need to increase size to make sure it could fit all alt entries.
>>
>> So at last, we use 8M/17M as parent bridge alt_align/alt_size.
>
> Tested-by: Yijing Wang <wangyijing@huawei.com>

Thanks for testing.

>
> Hi Yinghai, does this patch depend on the previous items in this patchset ?

Yes, it depends most of patches from patch1 to this patch.

> Could you provide another version of this patch for stable branch, eg. 3.10 stable ?

That is RHEL 7 kernel, right ?

After those patches get into upstream, I will try to port them to 3.10 stable.

Thanks

Yinghai
