Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:63825 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab3HFNjh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2013 09:39:37 -0400
Received: by mail-qa0-f42.google.com with SMTP id bv4so1648556qab.15
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2013 06:39:35 -0700 (PDT)
Date: Tue, 6 Aug 2013 07:39:29 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in
 pbus_size_io()
Message-ID: <20130806133929.GB31970@google.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
 <CAE9FiQU3DSZGFSENxy84bQ_URurWUAh2secoq5KN7c3BVXb9OQ@mail.gmail.com>
 <20130805195149.GA19127@google.com>
 <CAE9FiQXjL+=9XqUiFCmJNkU8vedbjs82cvxjGGBZnzaWN0HgTg@mail.gmail.com>
 <CAErSpo4ANAE3ggEcaJhFvGEpP48y37CxnXedn6cFt1gscPR-gw@mail.gmail.com>
 <CAE9FiQVJZWFBvOJPna_CFo=Pt2hGXmx39Q278f+0BOwV_38oRQ@mail.gmail.com>
 <20130805222135.GA29875@google.com>
 <20130806061534.GA10876@weiyang.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130806061534.GA10876@weiyang.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 06, 2013 at 02:15:34PM +0800, Wei Yang wrote:
> On Mon, Aug 05, 2013 at 04:21:35PM -0600, Bjorn Helgaas wrote:
> >On Mon, Aug 05, 2013 at 02:09:27PM -0700, Yinghai Lu wrote:
> >> On Mon, Aug 5, 2013 at 1:59 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> >> then, we should drop that 4k capping.
> >> >> I was thinking there could be strange or wild res with bigger than 4k.
> >> >
> >> > If there *were* an I/O BAR larger than 4KB, how should it be handled?
> >> > I don't think capping the alignment to 4KB sounds like the best way.
> >> > For example, a 16KB I/O BAR would still need to be aligned on 16KB.
> >> >
> >> > And I think capping to 4KB as you did above will break the powerpc
> >> > pcibios_window_alignment() implementation.  For example, if
> >> > pcibios_window_alignment() returned 16KB, and we later capped it to
> >> > 4KB, we're going to allocate space for the bridge window with the
> >> > wrong alignment.
> >> 
> >> Agree.
> >
> >OK.  Can you guys try this out and see whether it fixes the problem?
> >I don't know what the actual problem *is*, so I can't tell whether
> >this is a possible fix.
> >
> 
> Thanks all for the comments, this makes me re-consider the cases. Let me do a
> summary. Maybe I misunderstand the idea, please fix me~
> 
> Requirement from PCI Spec
> ============================================================================
> 1. I/O BAR for non-bridge PCI devices are limited to 256 bytes
> 2. Most I/O window for PCI bridge is 4k aligned
> 3. Some bridge support 1k aligned I/O window
> 
> Ancient time -- when 1k aligned I/O window is not there
> ============================================================================
> The alignment is 4k in all cases. (As it is hard coded.)
> 
>     For devices under this bridge, I/O BAR is less then 256.
>     
>     For downstream port, I/O window is 4k aligned, since the IORESOURCE_STARTALIGN
>     is set. This means even the downstream port connects other bridge, the
>     alignment is still 4k.

Right.

> Middle Age -- when 1k aligned I/O window is introduced
> ============================================================================
> This introduce two other cases: 
> 1. All downstream port is 1k aligned
> 2. One of the downstream port is 4k aligned.
> 
> Case 1: the "min_align" should be set to 1k. This could save some I/O resource.
> Case 2: the "min_align" should be set to 4k, even itself anounced could support
>         1k alignment.
> 	               ^--- Fix me, if not correct.

Right.

> The "min_align" could be set to other value? Previously, I thought it could
> be, for example 2k. Now I think no, the list_for_each_entry loop will iterate
> on two kinds of resources: 1. Device I/O BAR; 2. Bridge I/O window.
> 
> Device I/O BAR is less then 256 bytes, it won't contribut to the alignment.
> Bridge I/O window will be 1k or 4k aligned.
> 
> This means only two possible value for "min_align": 1k or 4k.
> 	               ^--- Fix me, if not correct.

Right.

> Back to Yinghai's commit(fd5913411), the "min_align" is set to 1k at the
> beginning. During the list_for_each_entry loop, (align > min_align) is true
> means align is 4k.
> 
> And this (min_align > 4096) will never be true, since at most "min_align" is
> 4k. So, I think, this comparison could be removed in commit(fd5913411).
> 	               ^--- Fix me, if not correct.

Right.  I think Yinghai was considering the case of an I/O BAR larger
than 4K.  But that's illegal per spec, and I think we would want to keep
the larger alignment even if it were legal.

> Present Age -- when architecture require specific alignment for bridge window
> ============================================================================
> This introduce 3 cases:
> 1. 1k < 4k < arch_align
> 2. 1k < arch_align < 4k
> 3. arch_align < 1k < 4k
> 
> Case 1: the "min_align" should be arch_align.
> Case 2: this is a little complicated. downstream port could be all 1k aligned
>         or one of the downstream port is 4k aligned.
> 	a. all 1k aligned, the "min_align" should be arch_align
> 	b. one is 4k aligned, the "min_align" should be 4k
> Case 3: this is the same as before
> 
> The final result of "min_align" in these three cases are all the biggest one
> of upstream/downstream/arch alignment. So the algorithm could be changed to
> calculate the biggest one of the three.

Right.

> Personal Conclusion
> ============================================================================
> I think Bjorn's patch works.
> Will test on powernv platform and give the result.

Great, let me know what happens.

Bjorn
