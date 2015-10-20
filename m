Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:46263 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbbJTXvb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Oct 2015 19:51:31 -0400
Subject: Re: [PATCH v7 02/60] sparc/PCI: Use correct bus address to resource
 offset
To: Yinghai Lu <yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
 <1444340359-8011-3-git-send-email-yinghai@kernel.org>
 <20151020195413.GH8224@localhost> <56269F0F.7000309@oracle.com>
 <CAE9FiQUTnG_fw9Y5VkwO7BmgYeJqQOKAyDh4JESOkOuOvjMThQ@mail.gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <5626D369.8020003@oracle.com>
Date: Tue, 20 Oct 2015 17:51:05 -0600
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUTnG_fw9Y5VkwO7BmgYeJqQOKAyDh4JESOkOuOvjMThQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/20/2015 02:34 PM, Yinghai Lu wrote:
> On Tue, Oct 20, 2015 at 1:07 PM, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>> I don't want to argue about pci_resource_to_user() right now, so I
>>> guess you can just panic if the mem64 offset is different from the
>>> mem32 offset.  But you should at least add a comment about why you're
>>> doing that.  Otherwise it looks like you were just lazy.
>
> I had one version for that, but it has big change to __pci_mmap_make_offset_bus
> for making pci_mmap_resource() working.
> And took it for granted that MEM/MEM64 should have same offet.
>
>>
>>
>> I just hit this condition on a sparc platform where mem32 offset != mem64
>> offset. We need to handle this case, and not just call panic. I had not seen
>> this on 5 platforms and another 3 ldoms I had tested this on when I tested
>> this code earlier. I have sent panic log to Yinghai separately.
>
> Did you get test result with updated patch2 and patch3?
>

Hi Yinghai,

The failing T4 booted up with updated patches.

Thanks,
Khalid

