Return-Path: <SRS0=xyCL=RH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88CFC43381
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 19:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BF62070B
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 19:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbfCDTVM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:21:12 -0500
Received: from ale.deltatee.com ([207.54.116.67]:48960 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfCDTVL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Mar 2019 14:21:11 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h0t9B-0002yA-OK; Mon, 04 Mar 2019 12:21:10 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kit Chow <kchow@gigaio.com>, Yinghai Lu <yinghai@kernel.org>
References: <20190214170028.27862-1-logang@deltatee.com>
 <20190304002351.GA26569@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3e45b4ab-e848-cf3b-624f-121ad58b0250@deltatee.com>
Date:   Mon, 4 Mar 2019 12:21:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304002351.GA26569@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: yinghai@kernel.org, kchow@gigaio.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/2] PCI: Prevent 64-bit resources from being counted in
 32-bit bridge region
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-03-03 5:23 p.m., Bjorn Helgaas wrote:
> Sorry for the delay.  This code gives a headache.  I still remember
> my headache from the last time we touched it.  Help me understand
> what's going on here.

Yes, this code gave me a headache debugging it too. And it's not the
first time I've tried to figure out what's going on with it because it
often just prints noisy messages that look like errors. I think I
understand it better now but it's something that's a bit fleeting and
easy to forget the details of. There may also be other solutions to this
problem.

> On Thu, Feb 14, 2019 at 10:00:27AM -0700, Logan Gunthorpe wrote:
>> The possible situations where this can happen will be quite varied and
>> depend highly on the exact hierarchy and how the realloc code ends up
>> trying to assign the regions. It's known to at least require a
>> large 64-bit BAR (>1GB) below a PCI bridge.
> 
> I guess the bug is that some BAR or window is unset when we actually
> have space for it?  We need to make this more concrete, e.g., with a
> minimal example of a failure case, and then connect this code change
> specifically with that.

The system we hit this bug on is quite large and complex with multiple
layers of switches though I suspect I might have seen it on a completely
different system but never had time to dig into it. I guess I could try
to find a case in which qemu can hit it.

> "Ignored BARs" doesn't seem like the best terminology here.  Can we
> just say they're "unset" as you do for windows?  Even that's a little
> squishy because there's really no such thing as a clearly "unset" or
> invalid value for a BAR.  All we can say is that Linux *thinks* it's
> unset because it happens to be zero (technically still a valid BAR
> value) or it conflicts with another device.

Yes. I used the "ignored" term because that's the terminology lspci uses
when it sees a resource like this. I'm not sure I like the "unset" term
because, in fact, the BAR registers in the configuration space are
typically still set to whatever the bios set them to[*1]. It's just that
the kernel doesn't create a struct resource for them and thus you wont
see a corresponding entry in /sys/bus/pci/.../resources or
/proc/bus/pci/devices. For example, here's the lspci and hex dump of the
config space for an example case; as you can see Region 0, is "ignored",
but the BAR register is still set to 0xf7100000.

05:00.0 PCI bridge: PLX Technology, Inc. Device 8733 (rev ca) (prog-if
00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 24
         NUMA node: 0
         Region 0: Memory at <ignored> (32-bit, non-prefetchable)
[size=256K]
         Bus: primary=05, secondary=06, subordinate=0a, sec-latency=0

05:00.0 PCI bridge: PLX Technology, Inc. Device 8733 (rev ca)
00: b5 10 33 87 07 01 10 00 ca 00 04 06 08 00 81 00
10: 00 00 10 f7 00 00 00 00 05 06 0a 00 11 21 00 00		f7100000
20: f0 ff 00 00 01 00 f1 ff 20 02 00 00 7f 02 00 00


> Strictly speaking, the result is that we can't enable decoding for
> that BAR type.  Often that does mean the device is unusable, but in
> some cases, e.g., an I/O BAR being unset and a driver using
> pci_enable_device_mem(), the device *is* usable.

Yes, though I think this bug will always apply to non-prefetchable
32-bit MEM BARs and not I/O BARs. So if the driver needs such a BAR
(which I expect is common) it will not function.

> Surely realloc can fail even without a large 64-bit BAR?  I don't
> think there's a magic threshold at 1GB.  Maybe an example would
> illustrate the problem better.

No, to hit this bug, we do require a large 64-bit BAR. Though the
threshold isn't necessarily 1GB, its more complicated (see below).

This is just really hard to explain because the code is so tricky. I'll
try to clarify it more below. Once we can clear it up so you understand
it I'll try to update my commit message to be clearer.

> There are actually three calls to pbus_size_mem():
> 
>   1) If bridge has a 64-bit prefetchable window, find the size of all
>      64-bit prefetchable resources below the bridge
> 
>   2) If bridge has no 64-bit prefetchable window, find the size of all
>      prefetchable resources below the bridge
> 
>   3) Find the size of everything else (non-prefetchable resources plus
>      any prefetchable ones that couldn't be accommodated above)

Yes, this is technically correct. I was just over-simplifying because,
to hit this bug, there must be a 64-bit prefetchable window and there
are no prefetchable 32-bit resources so (2) is irrelevant.

>> There are only two reasons for pbus_size_mem() to fail: if there is no
>> 64-bit/prefetchable bridge window, or if that window is already
>> assigned (in other words, its resource already has a parent set). We know
>> the former case can't be true because, in __pci_bus_size_bridges(), it's
>> existence is checked before making the call. So if the pbus_size_mem()
>> call in question fails, the window must already be assigned, and in this
>> case, we still do not want 64-bit resources trying to be sized into the
>> 32-bit catch-all resource.
> 
> I guess this question of putting a 64-bit resource in the 32-bit
> non-prefetchable window (legal but undesirable) is a secondary thing,
> not the chief complaint you're fixing?

Uh, yeah no. The 64-bit resource(s) are typically correctly assigned to
the 64-bit window. However the bug causes victim 32-bit Non-prefetchable
resources to not be assigned because when we calculate the size the code
to inadvertently thinks the 64-bit resource must fit into the 32-bit
non-prefetchable window.

--

Ok, so let me try to walk through this a bit more step by step. Lets
make the following assumptions:

1) Let's say we have a bridge that has a 64-bit prefetchable window,
such that (b_res[2].flags & IORESOURCE_MEM_64) is true. So the bridge
has three windows: the I/O window, the non-preftechable 32-bit window
and the prefetchable 64-bit window.

2) Let's also say that, under the bridge, we have a resource that's
larger than we'd expect to fit into the 32-bit window. (So, the actual
limit depends on the maximum size of that window, which is hardware
dependant, and the size of everything else that goes in it, but for
simplicity I estimated this to be at least 1GB). For the purposes of
this example, lets say it's very large: 64GB.

3) Now, the tricky thing is that this code tries to do things in
multiple passes, unassigning resources that didn't seem to fit and
recalculating window sizes on multiple passes. So lets say we are on the
second pass where, previously, the 64-bit prefetchable window on this
bridge was successfully assigned but, for whatever reason, this bridge
failed and the resources were released (see
pci_bus_release_bridge_resources()). In this case (bres[2].parent !=
NULL) and the large 64-bit resource now has (res->parent == NULL).

Walking through __pci_bus_size_bridges():

i) Per (1), we do have a prefetchable window, so the first call to
pbus_size_mem() happens. However, the first thing that function does is
call find_free_bus_resource() which should find bres[2], but does not
because, per (3) its parent is not NULL (see the comment above
find_free_bus_resource() which makes it seem important that parent not
be set). Thus this call to pbus_size_mem() fails with -ENOSPC, and
'type2' and 'type3' remain unset.

ii) Seeing type2 is unset, we go to the second call to pbus_size_mem().
This call fails because per (1), there is no 32-bit prefetchable
resource to find. So find_free_bus_resource() fails, as it should.
'type2' and 'type3' are now set to IORESOURCE_MEM.

iii) Next we do the third call to pbus_size_mem() for the
non-prefetchable window, however, because the first two calls failed, it
will calculate the size for the 32-bit window to be greater than 64GB.

As the code recurses up into the rest of the PCI tree, nothing will fit
into the 32-bit window seeing it's calculated to be much larger than it
needs to be so none of the 32-bit prefetchable BARs will be assigned and
thus will not have struct resources and they will be reported as ignored
by lspci. Drivers that try to use these resources will also fail and
there will be addresses in the IOVA space that may get routed to the
wrong PCI address.

My solution to this bug was to notice that pbus_size_mem() can only fail
for one of two reasons: either the resource doesn't exist at all or it
is already assigned (ie. the resource's parent is still set). However,
for the first call in (i), we know the resource does exist because we
check for it (ie. the condition in (1)). Therefore we can say that if
pbus_size_mem() fails in (i) there is a 64-bit window and we should not
try to size the 32-bit window to fit 64-bit resources. We do this simply
by setting 'mask', 'type2' and 'type3' even when pbus_size_mem() fails.

Another potential solution would be to always unassign the windows for
the failing bridges by setting it's resources parents to NULL. But this
makes me much more nervous because I don't understand what all the
implications would be and the comment above find_free_bus_resource()
makes me think this is important.

Let me know if this makes more sense or you have further questions.

Also, the second patch in this series is a similar bug with *very*
similar symptoms but I think it's easier to understand. It's a
completely different cause and only happens on one particular piece of
hardware that I'm aware of; and the driver for that hardware doesn't use
the BAR at all right now so the only real negative effect is on the IOVA
address space.

Thanks,

Logan

[*1] This is probably another big bug due to its affect on the IOVA
address space, but I'm not sure what to do about it and with these
patches we don't have any further issues. However, maybe we should be
scanning the tree after everything is said and done and unset any BARs
that do not have corresponding resources. That way, if there are other
bugs that can cause ignored regions, or if our algorithm does something
that doesn't match the bios there aren't random failures when using the
IOMMU.



