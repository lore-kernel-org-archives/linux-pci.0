Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33753 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbbHOVqS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 15 Aug 2015 17:46:18 -0400
Received: by wijp15 with SMTP id p15so46471537wij.0
        for <linux-pci@vger.kernel.org>; Sat, 15 Aug 2015 14:46:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1439657841.22971.35.camel@rzhang1-mobl4>
References: <1438047747.1856.12.camel@rzhang1-mobl4> <20150728175848.GI5322@mtj.duckdns.org>
 <1438133951.1856.23.camel@rzhang1-mobl4> <20150814201752.GG26431@google.com> <1439657841.22971.35.camel@rzhang1-mobl4>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 15 Aug 2015 16:45:56 -0500
Message-ID: <CAErSpo4tkqLAjaR87L9JMyvdd4bsPFwt-v7Vd+w8N1i8JNMHOw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
To: Zhang Rui <rui.zhang@intel.com>
Cc: Tejun Heo <tj@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
	Chuansheng Liu <chuansheng.liu@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Aaron Lu <aaron.lu@intel.com>, Jay <MyMailClone@t-online.de>,
	Barto <mister.freeman@laposte.net>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 15, 2015 at 11:57 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> Hi, Bjorn,
>
> On Fri, 2015-08-14 at 15:17 -0500, Bjorn Helgaas wrote:
>> Hi Zhang,
>>
>> On Wed, Jul 29, 2015 at 09:39:11AM +0800, Zhang Rui wrote:
>> > From c6b063b2874b62466362a10b53097216b16e400d Mon Sep 17 00:00:00 2001
>> > From: Zhang Rui <rui.zhang@intel.com>
>> > Date: Sun, 26 Jul 2015 14:15:36 +0800
>> > Subject: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
>> >
>> > In https://bugzilla.kernel.org/show_bug.cgi?id=81551,
>> > we found that Jmicron chip 361/363 is broken after resume if async noirq
>> > (76569faa62 (PM / sleep: Asynchronous threads for resume_noirq)) is supported,
>> > thus commit e6b7e41cdd (ata: Disabling the async PM for JMicron chip 363/361)
>> > is introduced to fix this problem.
>> > But then, we found that Jmicron chip 368 also has this problem, and it is decided
>> > to disable the pm async feature for all the Jmicron chips.
>> >
>> > But how to fix this was discussed in the mailing list for some time.
>> > After some investigation, we believe that a proper fix is to disable
>> > the async PM in PCI instead of ata driver, because, on this platform,
>> > pci_resume_noirq() of IDE controller must happen after pci_resume_noirq()
>> > of AHCI controller. But as .resume_noirq() of the pata_jmicron driver is
>> > no-op, this suggests that it is the PCI common actions, aka,
>> > pci_pm_default_resume_early(), have the dependency.
>> > To fix this, using device_pm_wait_for_dev() in pata_jmicron driver can not
>> > solve the dependency because pci_pm_default_resume_early() is invoked before
>> > driver callback being invoked, plus, as it is the PCI common actions that
>> > have the dependency, it is reasonable to fix it in PCI bus code,
>> > rather than driver code.
>> >
>> > This patch is made based on the patch from Liu Chuansheng at
>> > https://lkml.org/lkml/2014/12/5/74
>> > it reverts commit e6b7e41cdd ("ata: Disabling the async PM for JMicron
>> > chip 363/361"), and introduces a PCI quirk to disable async PM for Jmicron
>> > chips.
>>
>> This changelog has a lot of text, but doesn't tell me what I really
>> want to know.
>>
>> We need to know what the problem is from the *device* point of view,
>> not in terms of kernel function names.  Function names are only
>> meaningful to a handful of experts, but a concrete problem description
>> may be useful to hardware designers and firmware writers who can
>> potentially fix the root issue.
>>
> Well, I sent this patch just because there is a regression since 3.15,
> and we already have two patches that have been verified to fix the
> problem, but none of them are pushed for upstream. I don't have many PCI
> background, thus I chose to use function names to make myself precise
> enough but apparently I failed :p

Yep.  If you use function names, they have to be real function names,
not "almost" function names.

> Maybe I should send this patch as a RFC patch to get a perfect fix.

RFC has nothing to do with it.  The problem is that the changelog
doesn't say what the problem is or how we're fixing it (except in such
abstract terms as to be useless).

>> This patch doesn't change the workaround: we still use
>> device_disable_async_suspend() on these devices.  This patch merely:
>>
>>   1) Changes the workaround so instead of doing this only for 361 and
>>   363 devices, we turn off async suspend on *all* JMicron devices, and
>>
>>   2) Moves the workaround from the AHCI and PATA drivers to the PCI
>>   core.
>>
>> For 1), I think it is probably overkill to penalize all JMicron
>> devices.  There's no reason to think NICs and SD/MMC/etc controllers
>> have the same issue.  Or if there *is* reason to think that, you
>> should give evidence for it.
>
> No, I don't have any evidence. It's just because the previous fix
> becomes insufficient, which makes people wondering if we should disable
> all of them.

It's reasonable to say "JMicron multi-function PATA controllers X, Y,
and Z have this problem; let's assume all JMicron multi-function PATA
controllers have it."  All those controllers are likely to share some
silicon design.  Saying "all JMicron adapters, even single-function
and NIC and SD/etc. adapters, have this problem" is not nearly such an
obvious conclusion.

>> For 2), you have not made a convincing argument for why the workaround
>> needs to be in the PCI core.  Such an argument would be of the form
>> "we need this quirk even if the driver hasn't been loaded yet
>> because ..."
>
> Good point, Jay and Barto, can you please verify this?

I don't know Jay or Barto, but I don't even know what you're asking
them to verify, so I think you are asking too much of them.  What
exactly would you like them to do?

The scenario where I can imagine the quirk would need to be in the
core is the following, and if I were you, this is the scenario I would
be asking them to test:

  - cold boot system with comment #72 patch (quirks in ahci & pata_jmicron)
  - load ahci driver to claim JMicron SATA device
  - suspend system, which powers down both SATA and PATA devices
  - resume system, which powers up PATA (function 1), then SATA (function 0)
  - verify that SATA works fine
  - load pata_jmicron driver to claim PATA
  - see whether PATA works

Now, the question is whether PATA works after resuming and loading
pata_jmicron.  If it does, then it should be fine to keep the quirks
in ahci and pata_jmicron.

If it doesn't work (and I think it's actually likely that it *won't*
work), then we probably need to put the quirks in the PCI core so they
will happen even before ahci and pata_jmicron are loaded.

>> Since you didn't say anything like that, I assume the patch in comment
>> #72 of bug #81551 (https://bugzilla.kernel.org/attachment.cgi?id=156301)
>> would work as well.  That has the advantage that it wouldn't penalize
>> non-storage controllers.
>>
> Yes, the fix in driver code also works. But let's wait for the test
> results from Jay and Barto because this problem really sounds like a
> dependency in PCI code.

It might "sound like" a dependency in PCI code, but that sort of
hand-waving makes me think you don't really understand the problem.
There might be something in the PCI specs that says you have to power
up function 0 before function 1.  I don't think that's the case,
because we don't see this problem with other multi-function devices.
But if it were the case, you should write a PCI patch to enforce that
ordering and include a spec citation in the changelog.  That would fix
this device as well as potentially others.

If the spec doesn't require that ordering, then it's probably a
hardware defect.  It's possible there's a way to describe the ordering
via ACPI; if there is, you could argue that the lack of that
description is a BIOS defect.  Either way, it's not a PCI core
problem.  We might still want a workaround in the PCI core, but we
need to be clear about what the problem is.

>> Other minor nits:
>>
>> - The function "pci_resume_noirq()" does not exist.  I assume you meant
>>   pci_pm_resume_noirq().  And as I mentioned earlier, I don't think the
>>   name is relevant in the changelog anyway.
>>
>> - You have a mix of SHA1 lengths and summary quoting above.  Please use
>>   the conventional commit reference style (with 12-char SHA-1)
>>   consistently, e.g.,
>>
>>     76569faa62c4 ("PM / sleep: Asynchronous threads for resume_noirq")
>>
>> - Please use http://lkml.kernel.org/r/... references when possible,
>>   not https://lkml.org/....
>>
> Thanks for pointing these out. I was not aware of such mistakes before.

I forgot to mention that your changelog has random line lengths.  New
paragraphs start after a blank line.  A new sentence does not start a
new line.  Fill the lines so they fit in 75 columns so they fit in 80
columns after git indents them.

Usually I fix things like that myself.  But there were other issues,
and your SHA-1 citations weren't even consistent with each other,
which I think is sloppy, and I get grumpy when people ask me to merge
sloppy work.

Bjorn
