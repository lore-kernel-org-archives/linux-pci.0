Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B910C282CD
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 23:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25322184D
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 23:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548717206;
	bh=ISEzza5mNxX3l49QusFzQbp+Ra+VKTi58BCF2alqY1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zCRo52gNIkDszPKicwGAfEmv5yJ6w7wCXJflVLmjYnsWUR6vQRFt5PKEK5WB6udmR
	 GoGgwGxi9jYU7vLfXkVqp8qz20Jjr5ZB6Z+rUU9ybeDh7OB99LxUU2hm5qtu2WXI/y
	 coYmynCAQlw9pLie4QPo9Ao8cq1zdFbkSQ3pSLO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfA1XNZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:13:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfA1XNZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jan 2019 18:13:25 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D72F82148E;
        Mon, 28 Jan 2019 23:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548717204;
        bh=ISEzza5mNxX3l49QusFzQbp+Ra+VKTi58BCF2alqY1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JakVoSot9lGyNbMf6+AhZ6BT+h/eroU2ffzkcZucP9Ngl3x9l4OzNlETNsHjz1HeC
         VmEL4L5ZtyxNt3sCO/AEf9+5MOjC0U6M0WAjHZ/+3V85SrM/5cLPU4DhIFqKnn66lW
         bmiy4tGL/AZG03ggkiPfpfEZzVEq4puFFwSGBTzg=
Date:   Mon, 28 Jan 2019 17:13:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-pci@vger.kernel.org,
        x86@kernel.org, linuxarm@huawei.com,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH V2] x86: Fix an issue with invalid ACPI NUMA config
Message-ID: <20190128231322.GA91506@google.com>
References: <20181211094737.71554-1-Jonathan.Cameron@huawei.com>
 <a5a938d3-ecc9-028a-3b28-610feda8f3f8@intel.com>
 <20181212093914.00002aed@huawei.com>
 <20181220151225.GB183878@google.com>
 <65f5bb93-b6be-d6dd-6976-e2761f6f2a7b@intel.com>
 <20181220195714.GE183878@google.com>
 <20190128112904.0000461a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128112904.0000461a@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 28, 2019 at 11:31:08AM +0000, Jonathan Cameron wrote:
> On Thu, 20 Dec 2018 13:57:14 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Dec 20, 2018 at 09:13:12AM -0800, Dave Hansen wrote:
> > > On 12/20/18 7:12 AM, Bjorn Helgaas wrote:  
> > > >> Other than the error we might be able to use acpi_map_pxm_to_online_node
> > > >> for this, or call both acpi_map_pxm_to_node and acpi_map_pxm_to_online_node
> > > >> and compare the answers to verify we are getting the node we want?  
> > > > Where are we at with this?  It'd be nice to resolve it for v4.21, but
> > > > it's a little out of my comfort zone, so I don't want to apply it
> > > > unless there's clear consensus that this is the right fix.  
> > > 
> > > I still think the fix in this patch sweeps the problem under the rug too
> > > much.  But, it just might be the best single fix for backports, for
> > > instance.  
> > 
> > Sounds like we should first find the best fix, then worry about how to
> > backport it.  So I think we have a little more noodling to do, and
> > I'll defer this for now.
> > 
> > Bjorn
> 
> Hi All,
> 
> I'd definitely appreciate some guidance on what the 'right' fix is.
> We are starting to get real performance issues reported as a result of not
> being able to use this patch on mainline.
> 
> 5-10% performance drop on some networking benchmarks.

I guess the performance drop must be from calling kmalloc_node() with
the wrong node number because we currently ignore _PXM for the NIC?
And to get that performance back, you need both the previous patch to
pay attention to _PXM (https://lore.kernel.org/linux-pci/1527768879-88161-2-git-send-email-xiexiuqi@huawei.com)
and this patch (to set "numa_off=1" to avoid the regression the _PXM
patch by itself would cause)?

> As a brief summary (having added linux-mm / linux-acpi) the issue is:
> 
> 1) ACPI allows _PXM to be applied to pci devices (including root ports for
>    example, but any device is fine).
> 2) Due to the ordering of when the fw node was set for PCI devices this wasn't
>    taking effect. Easy to solve by just adding the numa node if provided in
>    pci_acpi_setup (which is late enough)
> 3) A patch to fix that was applied to the PCIe tree
>   https://patchwork.kernel.org/patch/10597777/
>    but we got non booting regressions on some threadripper platforms.
>    That turned out to be because they don't have SRAT, but do have PXM entries.
>   (i.e. broken firmware).  Naturally Bjorn reverted this very quickly!

Here's the beginning of the current thread, for anybody coming in
late: https://lore.kernel.org/linux-pci/20181211094737.71554-1-Jonathan.Cameron@huawei.com).

The current patch proposes setting "numa_off=1" in the x86 version of
dummy_numa_init(), on the assumption (from the changelog) that:

  It is invalid under the ACPI spec to specify new NUMA nodes using
  _PXM if they have no presence in SRAT.

Do you have a reference for this?  I looked and couldn't find a clear
statement in the spec to that effect.  The _PXM description (ACPI
v6.2, sec 6.1.14) says that two devices with the same _PXM value are
in the same proximity domain, but it doesn't seem to require an SRAT.

But I guess it doesn't really matter whether it's invalid; that
situation exists in the field, so we have to handle it gracefully.

Martin reported the regression from 3) above and attached useful logs,
which unfortunately aren't in the archives because the mailing list rejects
attachments.  To preserve them, I opened https://bugzilla.kernel.org/show_bug.cgi?id=202443
and attached the logs there.

> I proposed this fix which was to do the same as on Arm and clearly
> mark numa as off when SRAT isn't present on an ACPI system.
> https://elixir.bootlin.com/linux/latest/source/arch/arm64/mm/numa.c#L460
> https://elixir.bootlin.com/linux/latest/source/arch/x86/mm/numa.c#L688

There are several threads we could pull on while untangling this.

We use dummy_numa_init() when we don't have static NUMA info from ACPI
SRAT or DT.  On arm64 (but not x86), it sets numa_off=1 when we don't
have that static info.  I think neither should set numa_off=1 because
we should allow for future information, e.g., from _PXM.

I think acpi_numa_init() is being a little too aggressive when it
returns failure if it finds no SRAT or if it finds an SRAT with no
ACPI_SRAT_TYPE_MEMORY_AFFINITY entries.

Also from your changelog:

  When the PCI code later comes along and calls acpi_get_node() for
  any PCI card below the root port, it navigates up the ACPI tree
  until it finds the _PXM value in the root port. This value is then
  passed to acpi_map_pxm_to_node().

  As numa_off has not been set on x86 it tries to allocate a NUMA
  node, from the unused set, without setting up all the infrastructure
  that would normally accompany such a call.  We have not identified
  exactly which driver is causing the subsequent hang for Martin.

So the problem seems to be that when we get the _PXM value (in the
acpi_get_node() path), there's some infrastructure we don't set up?
I'm not sure what exactly this is -- I see that when we have an SRAT,
acpi_numa_memory_affinity() does a little more, but nothing that
would account for a problem if we call acpi_map_pxm_to_node() without
an SRAT.

Maybe it results in an issue when we call kmalloc_node() using this
_PXM value that SRAT didn't tell us about?  If so, that's reminiscent
of these earlier discussions about kmalloc_node() returning something
useless if the requested node is not online:

  https://lkml.kernel.org/r/1527768879-88161-2-git-send-email-xiexiuqi@huawei.com
  https://lore.kernel.org/linux-arm-kernel/20180801173132.19739-1-punit.agrawal@arm.com/

As far as I know, that was never really resolved.  The immediate
problem of using passing an invalid node number to kmalloc_node() was
avoided by using kmalloc() instead.

> Dave's response was that we needed to fix the underlying issue of
> trying to allocate from non existent NUMA nodes.

Oops, sorry for telling you what you obviously already know!  I guess
I didn't internalize this sentence before writing the above.

Bottom line, I totally agree that it would be better to fix the
underlying issue without trying to avoid it by disabling NUMA.

> Whilst I agree with that in principle (having managed to provide
> tables doing exactly that during development a few times!), I'm not
> sure the path to doing so is clear and so this has been stalled for
> a few months.  There is to my mind still a strong argument, even
> with such protection in place, that we should still be short cutting
> it so that you get the same paths if you deliberately disable numa,
> and if you have no SRAT and hence can't have NUMA.

I guess we need to resolve the question of whether NUMA without SRAT
is possible.

> So given I have some 'mild for now' screaming going on, I'd
> definitely appreciate input on how to move forward!
> 
> There are lots of places this could be worked around, e.g. we could
> sanity check in the acpi_get_pxm call.  I'm not sure what side
> effects that would have and also what cases it wouldn't cover.
> 
> Thanks,
> 
> Jonathan
