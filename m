Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:47653 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab3EHDmn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2013 23:42:43 -0400
Received: by mail-ia0-f179.google.com with SMTP id g4so1468673iae.38
        for <linux-pci@vger.kernel.org>; Tue, 07 May 2013 20:42:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5189c22b.45f7440a.0a88.6b75SMTPIN_ADDED_BROKEN@mx.google.com>
References: <1367732090.11982.38.camel@pasglop>
	<CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
	<1367740336.11982.41.camel@pasglop>
	<51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
	<CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
	<1367837311.15842.31.camel@pasglop>
	<CAE9FiQU=ZEfvVKeQgVOa0jeG5smJrKRaeLTOckR=v2vzTyTvLw@mail.gmail.com>
	<5188b791.a110420a.0bea.077eSMTPIN_ADDED_BROKEN@mx.google.com>
	<CAE9FiQUc2q0GfVumVrp3_ba0q6N_a_WxjKhMWbyqbLfO=WGaFQ@mail.gmail.com>
	<5189c22b.45f7440a.0a88.6b75SMTPIN_ADDED_BROKEN@mx.google.com>
Date: Tue, 7 May 2013 20:42:42 -0700
Message-ID: <CAE9FiQXok7_0x9hSVBxK7w1s=w6k72vVT5ST46Lqamr0DToT6g@mail.gmail.com>
Subject: Re: Resource assignment oddities
From: Yinghai Lu <yinghai@kernel.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 7, 2013 at 8:10 PM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> On Wed, May 08, 2013 at 10:38:00AM +0800, Gavin Shan wrote:
>>On Tue, May 07, 2013 at 03:21:42PM -0700, Yinghai Lu wrote:
>>>On Tue, May 7, 2013 at 1:11 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
>>>> Yinghai, thanks for the updated patch. It's working well with (v1 #1 and v2 #2), which
>>>> was applied on top of Ben's patch sent for review. The kernel log is attached in case
>>>> you want double-check.
>>>>
>>>Yes, that works.
>>>
>>>I just sent v3, please test that.
>>>
>>>That should be less invasive for v3.10. As it will skip adding failed
>>>resource to failed list when the resource is IORESOURCE_IO, and bus
>>>does not have IORESOURCE_IO.
>>>
>>
>>Yinghai, with all patches (5) applied on top of Ben's patchset for PowerPC.
>>I still see failure to assign IO ports, which shouldn't be seen. Please
>>check the attached kernel log.
>>
>
> After digging for more, here's what happened: pci_bridge_check_ranges() checks
> the specific bridge supports IO ports and set IORESOURCE_IO explicitly if that's
> the case. Then in pbus_size_io(), we always have valid IO window from that specific
> PCI bus and the corresponding resource of the P2P bridge will be added to "realloc_head".
> That eventually cause assignment of IO ports and it's to failure because the root
> PCI bus doesn't have IO port range.

that is intentionally,

pci 0001:02:01.0: BAR 7: can't assign io (size 0x1000)
pci 0001:02:08.0: BAR 7: can't assign io (size 0x1000)
pci 0001:02:09.0: BAR 7: can't assign io (size 0x1000)

those are just print out, and then those does not get inserted to failed list.
so it will not affect mmio-nonpref/mmio-pref allocation.

that will make sure all related bridge io port BAR get disabled for sure.

except those print out, do you find any function that does not work?

Thanks

Yinghai
