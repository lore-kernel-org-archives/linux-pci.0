Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:28249 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbbLAVXs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2015 16:23:48 -0500
Subject: Re: [PATCH v8 00/61] PCI: Resource allocation cleanup for v4.4
To: Yinghai Lu <yinghai@kernel.org>
References: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
 <5633E570.6040906@oracle.com>
 <CAE9FiQU5YkwFVuEiDOCT+BDrrSLGhTiDfW7GZV6qVtBRKDBpDw@mail.gmail.com>
 <1448314314.15591.1.camel@oracle.com>
 <CAE9FiQWiWvOuW3gKRKSDWwPTzNAE7w=u2UiA=XSAXMscxJe2SQ@mail.gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <565E0FC6.9040209@oracle.com>
Date: Tue, 1 Dec 2015 14:23:18 -0700
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWiWvOuW3gKRKSDWwPTzNAE7w=u2UiA=XSAXMscxJe2SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/23/2015 07:39 PM, Yinghai Lu wrote:
> On Mon, Nov 23, 2015 at 1:31 PM, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>> Looks like only the device BAR6 is not assigned form OF?
>>
>> Any progress on this? Do you need any more information from me?
>
> Should be one warning about this device in that system.
>
> We don't need to do anything about it if the device is working with
> this patch set.

Hi Yinghai,

Picking this up again after thanksgiving.......

The device does work with this patch. Doesn't this warning mean BAR6 
resources could not be reserved which means the device driver may not be 
able to get the BAR6 resource at some point if another device grabs the 
unreserved resource?

David M had pointed out an issue with how OF driver uses the same 
address range for all ROMs enabling them only one at a time. That seems 
to be in play here in the issue I am seeing. Does this patch series need 
to address this?

Thanks,
Khalid
