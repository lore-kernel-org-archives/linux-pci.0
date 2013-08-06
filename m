Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:47359 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754953Ab3HFG0c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2013 02:26:32 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 6 Aug 2013 16:16:31 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id A082E2BB0052
	for <linux-pci@vger.kernel.org>; Tue,  6 Aug 2013 16:26:27 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r766Adug2884004
	for <linux-pci@vger.kernel.org>; Tue, 6 Aug 2013 16:10:39 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r766QQjX010274
	for <linux-pci@vger.kernel.org>; Tue, 6 Aug 2013 16:26:27 +1000
Date: Tue, 6 Aug 2013 14:26:24 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in
 pbus_size_io()
Message-ID: <20130806062624.GC10876@weiyang.vnet.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
 <CAE9FiQU3DSZGFSENxy84bQ_URurWUAh2secoq5KN7c3BVXb9OQ@mail.gmail.com>
 <20130805195149.GA19127@google.com>
 <CAE9FiQXjL+=9XqUiFCmJNkU8vedbjs82cvxjGGBZnzaWN0HgTg@mail.gmail.com>
 <CAErSpo4ANAE3ggEcaJhFvGEpP48y37CxnXedn6cFt1gscPR-gw@mail.gmail.com>
 <CAE9FiQVJZWFBvOJPna_CFo=Pt2hGXmx39Q278f+0BOwV_38oRQ@mail.gmail.com>
 <20130805222135.GA29875@google.com>
 <20130806032227.GA7736@shangw.(null)>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130806032227.GA7736@shangw.(null)>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 06, 2013 at 11:22:27AM +0800, Gavin Shan wrote:
>On Mon, Aug 05, 2013 at 04:21:35PM -0600, Bjorn Helgaas wrote:
>>On Mon, Aug 05, 2013 at 02:09:27PM -0700, Yinghai Lu wrote:
>>> On Mon, Aug 5, 2013 at 1:59 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> >> then, we should drop that 4k capping.
>>> >> I was thinking there could be strange or wild res with bigger than 4k.
>>> >
>>> > If there *were* an I/O BAR larger than 4KB, how should it be handled?
>>> > I don't think capping the alignment to 4KB sounds like the best way.
>>> > For example, a 16KB I/O BAR would still need to be aligned on 16KB.
>>> >
>>> > And I think capping to 4KB as you did above will break the powerpc
>>> > pcibios_window_alignment() implementation.  For example, if
>>> > pcibios_window_alignment() returned 16KB, and we later capped it to
>>> > 4KB, we're going to allocate space for the bridge window with the
>>> > wrong alignment.
>>> 
>>> Agree.
>>
>>OK.  Can you guys try this out and see whether it fixes the problem?
>>I don't know what the actual problem *is*, so I can't tell whether
>>this is a possible fix.
>>
>
>The code looks simpler, but it potentially breaks PowerNV platforms.
>Lets have inline description if I understand everything here.
>
>>diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>>index d4f1ad9..8333c92 100644
>>--- a/drivers/pci/setup-bus.c
>>+++ b/drivers/pci/setup-bus.c
>>@@ -749,12 +749,12 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>> 	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
>> 	resource_size_t size = 0, size0 = 0, size1 = 0;
>> 	resource_size_t children_add_size = 0;
>>-	resource_size_t min_align, io_align, align;
>>+	resource_size_t min_align, align;
>>
>> 	if (!b_res)
>>  		return;
>>
>>-	io_align = min_align = window_alignment(bus, IORESOURCE_IO);
>>+	min_align = window_alignment(bus, IORESOURCE_IO);
>> 	list_for_each_entry(dev, &bus->devices, bus_list) {
>> 		int i;
>>
>
>"min_align" here indicates the IO segment size on PowerNV platform.
>On PowerNV platform, the IO range of specific PHB (PCI controller)
>is divided evenly and each piece of that is called IO segment. For
>example, the IO segment size ("min_align") is 64K initially. If one
>of specific IO BAR has size of 96K (it's possible?), "min_align"
>becomes 96K eventually, which isn't IO segment aligned.

I think this caes will not happen. 

As I analysised in previous letter. During the list_for_each_entry loop, the
resources could be in two cased: 1. bridge I/O window(IORESOURCE_STARTALIGN);
2. device I/O BAR(IORESOURCE_SIZEALIGN).

    Bridge I/O window is 64k aligned, as the platform required.
    Device I/O BAR is less than 256 bytes according to the specification.

So the 96k size is not possible. 

Please fix me, if I am not correct.

>
>>@@ -781,9 +781,6 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>> 		}
>> 	}
>>
>>-	if (min_align > io_align)
>>-		min_align = io_align;
>>-
>> 	size0 = calculate_iosize(size, min_size, size1,
>> 			resource_size(b_res), min_align);
>> 	if (children_add_size > add_size)
>>
>
>Thanks,
>Gavin

-- 
Richard Yang
Help you, Help me

