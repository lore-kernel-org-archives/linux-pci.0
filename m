Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:47741 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956Ab2FPSp7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2012 14:45:59 -0400
Received: by lbbgm6 with SMTP id gm6so3528047lbb.19
        for <linux-pci@vger.kernel.org>; Sat, 16 Jun 2012 11:45:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120616085049.GA2723@breakpoint.cc>
References: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
 <1338749305-22558-8-git-send-email-sebastian@breakpoint.cc>
 <CAL-B5D1GEMd9TPMqbYBqDuzs5U2jo7ByRg73Z=dPsPcgTSyJJA@mail.gmail.com>
 <CAErSpo77vyUaGTzVNwFGzTHsOapYNFRy_KOvNnXo=jdU2kYLbA@mail.gmail.com>
 <20120615163823.GA14302@linux-mips.org> <CAErSpo5kv_vE9D=AnyVdcXOAQpM6U3dyPpouE-NyNoU98R+syA@mail.gmail.com>
 <20120616085049.GA2723@breakpoint.cc>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 16 Jun 2012 12:45:37 -0600
Message-ID: <CAErSpo4o-Zh8-8Ut7Q3T3rtFRtetCu84RauVpoM_vSr0oS-ZdQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] mips: move PCI fixup hooks from __init to __devinit
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Myron Stowe <myron.stowe@gmail.com>, linux-pci@vger.kernel.org,
	linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 16, 2012 at 2:50 AM, Sebastian Andrzej Siewior
<sebastian@breakpoint.cc> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> On Fri, Jun 15, 2012 at 03:13:26PM -0600, Bjorn Helgaas wrote:
>> On Fri, Jun 15, 2012 at 10:38 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> > On Fri, Jun 15, 2012 at 10:33:15AM -0600, Bjorn Helgaas wrote:
>> >
>> >> > Doesn't the above line also need changed to __devinitdata if the
>> >> > function itself is being
>> >> > changed from __init to __devinit?
>> >>
>> >> I think so.  And pci_irq[] and piixirqmap[] also need to be moved,
>> >> since they're referenced by __devinit code.  I fixed these, audited
>> >> all the other patches, and updated the "next" branch.
>> >
>> > I'm going to patch that up.
>>
>> Does this mean you're going to push it through your tree and I should
>> remove the mips patch from my "next" branch?  Either way is fine with
>> me; currently I'm planning to push all the other arch patches via my
>> tree.
>
> Ralf picked up my patch [0] and commited a few fixups on top [1] and a malta
> fixup [2].
>
> [0] http://git.linux-mips.org/?p=ralf/linux.git;a=commitdiff;h=184170a613f4bccf4d58a4e73fa5d3a1ee839f38
> [1] http://git.linux-mips.org/?p=ralf/linux.git;a=commitdiff;h=f54d03696bdc1a9457c11ed6ae61e8f001217b25
> [2] http://git.linux-mips.org/?p=ralf/linux.git;a=commitdiff;h=2ec8663f9c03a96f2c328c7c483603c31d62ad37

OK, I'll drop the MIPS patch from my branch.  Note that the three
patches you mention above don't yet include the pci_irq[] and
piixirqmap[] fixes.  I assume you'll include those, too, Ralf.

Bjorn
