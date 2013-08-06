Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:45901 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783Ab3HFGPo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2013 02:15:44 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 6 Aug 2013 15:59:24 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2E2A43578051
	for <linux-pci@vger.kernel.org>; Tue,  6 Aug 2013 16:15:39 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r765xxlG9306412
	for <linux-pci@vger.kernel.org>; Tue, 6 Aug 2013 15:59:59 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r766FaPW023258
	for <linux-pci@vger.kernel.org>; Tue, 6 Aug 2013 16:15:38 +1000
Date: Tue, 6 Aug 2013 14:15:34 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in
 pbus_size_io()
Message-ID: <20130806061534.GA10876@weiyang.vnet.ibm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130805222135.GA29875@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 05, 2013 at 04:21:35PM -0600, Bjorn Helgaas wrote:
>On Mon, Aug 05, 2013 at 02:09:27PM -0700, Yinghai Lu wrote:
>> On Mon, Aug 5, 2013 at 1:59 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> >> then, we should drop that 4k capping.
>> >> I was thinking there could be strange or wild res with bigger than 4k.
>> >
>> > If there *were* an I/O BAR larger than 4KB, how should it be handled?
>> > I don't think capping the alignment to 4KB sounds like the best way.
>> > For example, a 16KB I/O BAR would still need to be aligned on 16KB.
>> >
>> > And I think capping to 4KB as you did above will break the powerpc
>> > pcibios_window_alignment() implementation.  For example, if
>> > pcibios_window_alignment() returned 16KB, and we later capped it to
>> > 4KB, we're going to allocate space for the bridge window with the
>> > wrong alignment.
>> 
>> Agree.
>
>OK.  Can you guys try this out and see whether it fixes the problem?
>I don't know what the actual problem *is*, so I can't tell whether
>this is a possible fix.
>

Thanks all for the comments, this makes me re-consider the cases. Let me do a
summary. Maybe I misunderstand the idea, please fix me~

Requirement from PCI Spec
============================================================================
1. I/O BAR for non-bridge PCI devices are limited to 256 bytes
2. Most I/O window for PCI bridge is 4k aligned
3. Some bridge support 1k aligned I/O window

Ancient time -- when 1k aligned I/O window is not there
============================================================================
The alignment is 4k in all cases. (As it is hard coded.)

    For devices under this bridge, I/O BAR is less then 256.
    
    For downstream port, I/O window is 4k aligned, since the IORESOURCE_STARTALIGN
    is set. This means even the downstream port connects other bridge, the
    alignment is still 4k.

Middle Age -- when 1k aligned I/O window is introduced
============================================================================
This introduce two other cases: 
1. All downstream port is 1k aligned
2. One of the downstream port is 4k aligned.

Case 1: the "min_align" should be set to 1k. This could save some I/O resource.
Case 2: the "min_align" should be set to 4k, even itself anounced could support
        1k alignment.
	               ^--- Fix me, if not correct.

The "min_align" could be set to other value? Previously, I thought it could
be, for example 2k. Now I think no, the list_for_each_entry loop will iterate
on two kinds of resources: 1. Device I/O BAR; 2. Bridge I/O window.

Device I/O BAR is less then 256 bytes, it won't contribut to the alignment.
Bridge I/O window will be 1k or 4k aligned.

This means only two possible value for "min_align": 1k or 4k.
	               ^--- Fix me, if not correct.


Back to Yinghai's commit(fd5913411), the "min_align" is set to 1k at the
beginning. During the list_for_each_entry loop, (align > min_align) is true
means align is 4k.

And this (min_align > 4096) will never be true, since at most "min_align" is
4k. So, I think, this comparison could be removed in commit(fd5913411).
	               ^--- Fix me, if not correct.


Present Age -- when architecture require specific alignment for bridge window
============================================================================
This introduce 3 cases:
1. 1k < 4k < arch_align
2. 1k < arch_align < 4k
3. arch_align < 1k < 4k

Case 1: the "min_align" should be arch_align.
Case 2: this is a little complicated. downstream port could be all 1k aligned
        or one of the downstream port is 4k aligned.
	a. all 1k aligned, the "min_align" should be arch_align
	b. one is 4k aligned, the "min_align" should be 4k
Case 3: this is the same as before

The final result of "min_align" in these three cases are all the biggest one
of upstream/downstream/arch alignment. So the algorithm could be changed to
calculate the biggest one of the three.


Personal Conclusion
============================================================================
I think Bjorn's patch works.
Will test on powernv platform and give the result.

Last but not the least, please fix me, if I am not correct. :-)

-- 
Richard Yang
Help you, Help me

