Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57020 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757951Ab2FOVNt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jun 2012 17:13:49 -0400
Received: by lahd3 with SMTP id d3so2380599lah.19
        for <linux-pci@vger.kernel.org>; Fri, 15 Jun 2012 14:13:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120615163823.GA14302@linux-mips.org>
References: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
 <1338749305-22558-8-git-send-email-sebastian@breakpoint.cc>
 <CAL-B5D1GEMd9TPMqbYBqDuzs5U2jo7ByRg73Z=dPsPcgTSyJJA@mail.gmail.com>
 <CAErSpo77vyUaGTzVNwFGzTHsOapYNFRy_KOvNnXo=jdU2kYLbA@mail.gmail.com> <20120615163823.GA14302@linux-mips.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 15 Jun 2012 15:13:26 -0600
Message-ID: <CAErSpo5kv_vE9D=AnyVdcXOAQpM6U3dyPpouE-NyNoU98R+syA@mail.gmail.com>
Subject: Re: [PATCH 7/9] mips: move PCI fixup hooks from __init to __devinit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Myron Stowe <myron.stowe@gmail.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	linux-pci@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Michal Marek <mmarek@suse.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 15, 2012 at 10:38 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Jun 15, 2012 at 10:33:15AM -0600, Bjorn Helgaas wrote:
>
>> > Doesn't the above line also need changed to __devinitdata if the
>> > function itself is being
>> > changed from __init to __devinit?
>>
>> I think so.  And pci_irq[] and piixirqmap[] also need to be moved,
>> since they're referenced by __devinit code.  I fixed these, audited
>> all the other patches, and updated the "next" branch.
>
> I'm going to patch that up.

Does this mean you're going to push it through your tree and I should
remove the mips patch from my "next" branch?  Either way is fine with
me; currently I'm planning to push all the other arch patches via my
tree.

Bjorn
