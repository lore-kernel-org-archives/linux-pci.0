Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:52395 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbbEGA6T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2015 20:58:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Michael S. Tsirkin" <mst@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>, Yinghai Lu <yinghai@kernel.org>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20150426084739-mutt-send-email-mst@kernel.org>
	<20150506210327.GG24643@google.com>
Date: Wed, 06 May 2015 19:53:48 -0500
In-Reply-To: <20150506210327.GG24643@google.com> (Bjorn Helgaas's message of
	"Wed, 6 May 2015 16:03:27 -0500")
Message-ID: <871titfbs3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v6 00/10] PCI: Fix unhandled interrupt on shutdown
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas@google.com> writes:

> On Sun, Apr 26, 2015 at 08:50:06AM +0200, Michael S. Tsirkin wrote:
>> On Fri, Apr 10, 2015 at 05:54:19PM -0500, Bjorn Helgaas wrote:
>> > Hi Michael,
>> > 
>> > I put your patches on my pci/msi branch and I hope to merge them for v4.1.
>> > I didn't apply the acks from Fam and Eric because I made changes to those
>> > patches that weren't completely trivial.  I think the end result is
>> > equivalent, though.  The diff attached to this cover letter is the
>> > difference between your v5 series and this v6 series.
>> > 
>> > As far as I'm concerned, this is ready to go except that I would like a
>> > little more info about the virtio kernel hang to include in the changelog
>> > for "PCI/MSI: Don't disable MSI/MSI-X at shutdown".
>> 
>> 
>> Hi Bjorn,
>> do you have eveything you need to merge this?
>
> No.  I made the minor changelog edits you suggested and the result is on
> my pci/msi-v7 branch.  But I still have these open issues:
>
>   - The last thing I heard from Eric was that "not disabling MSI/MSI-X at
>     shutdown is the wrong fix, and someone needs to fix a buggy driver."
>     I want to hear Eric say "OK, we need to leave MSI/MSI-X enabled at
>     shutdown for this case."

So far this just sounds like a device that needs a shutdown method.

>   - One changelog says "Stop disabling MSIs at shutdown to avoid
>     conflicting with drivers."  But I don't know what the conflict is.
>
>   - The bugzilla has no dmesg log or detailed analysis.  Fam said the
>     scenario I came up with
>     (http://lkml.kernel.org/r/20150416194245.GB20701@google.com)
>     was fairly close, but it took me a lot of work to derive that.  Fixing
>     any errors in it and putting it in the bugzilla would be a big step.
>     The bugzilla should have the raw data and the analysis, so someone else
>     can validate the analysis and conclude that this patch is a reasonable
>     fix for it.  That's currently impossible because the bugzilla really
>     only contains the fix as a fait accompli.

What I saw in the bugzilla was:

An interrupt was stuck on, and being reasserted as quickly as we could
call iret for that interrupt.

We did not disable that interrupt because irq debugging was explicitly
disabled on the kernel command line.

The irq was asserted because the the device did not have a shutdown
method to stop the device doing things.

There is an argument that disabling bus mastering should have disabled
whatever the interrupting condition was (and thus there may also be a
bug in the qemu device emulation).

So I read this as the driver and maybe the "hardware" is buggy not that
the linux pci layer is buggy.

Eric

