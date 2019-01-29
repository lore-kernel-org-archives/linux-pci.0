Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82642C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5346021473
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfA2Tp7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:45:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727056AbfA2Tp7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 14:45:59 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 19DA032BE61AA7381D8D;
        Wed, 30 Jan 2019 03:45:57 +0800 (CST)
Received: from localhost (10.47.86.165) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 03:45:46 +0800
Date:   Tue, 29 Jan 2019 19:45:34 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Dave Hansen <dave.hansen@intel.com>, <linux-pci@vger.kernel.org>,
        <x86@kernel.org>, <linuxarm@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH V2] x86: Fix an issue with invalid ACPI NUMA config
Message-ID: <20190129194534.00004087@huawei.com>
In-Reply-To: <20190129190556.GB91506@google.com>
References: <20181211094737.71554-1-Jonathan.Cameron@huawei.com>
        <a5a938d3-ecc9-028a-3b28-610feda8f3f8@intel.com>
        <20181212093914.00002aed@huawei.com>
        <20181220151225.GB183878@google.com>
        <65f5bb93-b6be-d6dd-6976-e2761f6f2a7b@intel.com>
        <20181220195714.GE183878@google.com>
        <20190128112904.0000461a@huawei.com>
        <20190128231322.GA91506@google.com>
        <20190129095105.00000374@huawei.com>
        <20190129190556.GB91506@google.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.165]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 29 Jan 2019 13:05:56 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Jan 29, 2019 at 09:51:05AM +0000, Jonathan Cameron wrote:
> > On Mon, 28 Jan 2019 17:13:22 -0600
> > Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > > On Mon, Jan 28, 2019 at 11:31:08AM +0000, Jonathan Cameron wrote:  
> > > > On Thu, 20 Dec 2018 13:57:14 -0600
> > > > Bjorn Helgaas <helgaas@kernel.org> wrote:    
> > > > > On Thu, Dec 20, 2018 at 09:13:12AM -0800, Dave Hansen wrote:    
> > > > > > On 12/20/18 7:12 AM, Bjorn Helgaas wrote:      
> 
> > > The current patch proposes setting "numa_off=1" in the x86 version of
> > > dummy_numa_init(), on the assumption (from the changelog) that:
> > > 
> > >   It is invalid under the ACPI spec to specify new NUMA nodes using
> > >   _PXM if they have no presence in SRAT.
> > > 
> > > Do you have a reference for this?  I looked and couldn't find a clear
> > > statement in the spec to that effect.  The _PXM description (ACPI
> > > v6.2, sec 6.1.14) says that two devices with the same _PXM value are
> > > in the same proximity domain, but it doesn't seem to require an SRAT.  
> > 
> > No comment (feel free to guess why). *sigh*  
> 
> Secret interpretations of the spec are out of bounds.  But I think
> it's a waste of time to argue about whether _PXM without SRAT is
> valid.  Systems like that exist, and I think it's possible to do
> something sensible with them.
> 
> > > Maybe it results in an issue when we call kmalloc_node() using this
> > > _PXM value that SRAT didn't tell us about?  If so, that's reminiscent
> > > of these earlier discussions about kmalloc_node() returning something
> > > useless if the requested node is not online:
> > > 
> > >   https://lkml.kernel.org/r/1527768879-88161-2-git-send-email-xiexiuqi@huawei.com
> > >   https://lore.kernel.org/linux-arm-kernel/20180801173132.19739-1-punit.agrawal@arm.com/
> > > 
> > > As far as I know, that was never really resolved.  The immediate
> > > problem of using passing an invalid node number to kmalloc_node() was
> > > avoided by using kmalloc() instead.  
> > 
> > Yes, that's definitely still a problem (or was last time I checked)
> >   
> > > > Dave's response was that we needed to fix the underlying issue of
> > > > trying to allocate from non existent NUMA nodes.    
> 
> > > Bottom line, I totally agree that it would be better to fix the
> > > underlying issue without trying to avoid it by disabling NUMA.  
> > 
> > I don't agree on this point.  I think two layers make sense.
> > 
> > If there is no NUMA description in DT or ACPI, why not just stop anything
> > from using it at all?  The firmware has basically declared there is no
> > point, why not save a bit of complexity (and use an existing tested code
> > path) but setting numa_off?  
> 
> Firmware with a _PXM does have a NUMA description.

Most of the meaning is lost.  It applies some grouping but no info
on the relative distance between that any anywhere else.
So perhaps 'some' description.

> 
> > However, if there is NUMA description, but with bugs then we should
> > protect in depth.  A simple example being that we declare 2 nodes, but
> > then use _PXM for a third. I've done that by accident and blows up
> > in a nasty fashion (not done it for a while, but probably still true).
> > 
> > Given DSDT is only parsed long after SRAT we can just check on _PXM
> > queries.  Or I suppose we could do a verification parse for all _PXM
> > entries and put out some warnings if they don't match SRAT entries?  
> 
> I'm assuming the crash happens when we call kmalloc_node() with a node
> not mentioned in SRAT.  I think that's just sub-optimal implementation
> in kmalloc_node().
> 
> We *could* fail the allocation and return a NULL pointer, but I think
> even that is excessive.  I think we should simply fall back to
> kmalloc().  We could print a one-time warning if that's useful.
> 
> If kmalloc_node() for an unknown node fell back to kmalloc(), would
> anything else be required?

It will deal with that case, but it may not be the only one.
I think there are interrupt related issues as well, but will have to check.

> 
> > > > Whilst I agree with that in principle (having managed to provide
> > > > tables doing exactly that during development a few times!), I'm not
> > > > sure the path to doing so is clear and so this has been stalled for
> > > > a few months.  There is to my mind still a strong argument, even
> > > > with such protection in place, that we should still be short cutting
> > > > it so that you get the same paths if you deliberately disable numa,
> > > > and if you have no SRAT and hence can't have NUMA.    
> > > 
> > > I guess we need to resolve the question of whether NUMA without SRAT
> > > is possible.  
> > 
> > It's certainly unclear of whether it has any meaning.  If we allow for
> > the fact that the intent of ACPI was never to allow this (and a bit
> > of history checking verified this as best as anyone can remember),
> > then what do we do with the few platforms that do use _PXM to nodes that
> > haven't been defined?  
> 
> We *could* ignore any _PXM that mentions a proximity domain not
> mentioned by an SRAT.  That seems a little heavy-handed because it
> means every possible proximity domain must be described up front in
> the SRAT, which limits the flexibility of hot-adding entire nodes
> (CPU/memory/IO).
> 
> But I think it's possible to make sense of a _PXM that adds a
> proximity domain not mentioned in an SRAT, e.g., if a new memory
> device and a new I/O device supply the same _PXM value, we can assume
> they're close together.  If a new I/O device has a previously unknown
> _PXM, we may not be able to allocate memory near it, but we should at
> least be able to allocate from a default zone.

I would like to know if this is real before we support it though.
We have a known platform that does it.  That platform might as well
not bother as I understand it as it doesn't have memory in those nodes.

I'll be honest though I'm happy with fixing it the hard way and
dropping the numa_off = 1 for arm if that is the consensus.

Jonathan

> 
> Bjorn


