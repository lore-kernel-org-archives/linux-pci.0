Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:63917 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbaGKSVO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jul 2014 14:21:14 -0400
Received: by mail-vc0-f169.google.com with SMTP id la4so2873229vcb.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2014 11:21:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWUPd4d9DWeiuDqQ=tKKe+5ZofUEw3JViXYs6+9zBG6Sg@mail.gmail.com>
References: <20140611060118.GB3169@yanx>
	<CAE9FiQWe2bf7QbKn9kmZS34a4cMewsdD-9qAELdXs-dEtx70GQ@mail.gmail.com>
	<20140702210736.GB28852@google.com>
	<CAE9FiQU5Ltu89zmRG0h2aXfXH0oCcTEP=jF7b=zHi=SaOA2rKg@mail.gmail.com>
	<20140703131526.GG28852@google.com>
	<CAE9FiQWPGXMBYmpzyk8cicKZ1ELUZiARkZjr2vvgntmt3bt1jQ@mail.gmail.com>
	<20140703221152.GH28852@google.com>
	<CAE9FiQX69x_YgHihYM-+tahTvbuk6MATBXvm9Rz5kiQ9UpKNPg@mail.gmail.com>
	<CAErSpo4DzJ112NxfjXT=NbXMxNqre_Vo61fS0Mem=MWCz+OvcA@mail.gmail.com>
	<CAE9FiQWUPd4d9DWeiuDqQ=tKKe+5ZofUEw3JViXYs6+9zBG6Sg@mail.gmail.com>
Date: Fri, 11 Jul 2014 11:21:13 -0700
Message-ID: <CA+55aFwyfaAa3opKsDth7b4RXb7E2_Thb581VWvg9V-GvJCYbg@mail.gmail.com>
Subject: Re: [PATCH] pci: Allow very large resource windows
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guo Chao <yan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 11, 2014 at 11:09 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> If the BAR have all 0, cpu can not access it as hw will forward access to ram
> controller according to routing table.

On PC's, yes (also likely with many devices - there are definitely
devices out there were setting the BAR to zero disables it).

On other platforms? Not necessarily at all, and some devices have no
way of disabling the BAR (even clearing the IO/MEM bits in the
control/status register does *not* necessarily disable things like
root bridge BARs). I'm pretty sure we had it actually happen (I'd like
to say "Powerpc", but I wouldn't really bet on it)

Anyway, the rule is that "r->flags = 0" means that it doesn't exist.
And that rule makes sense, and is completely unambiguous. Relying on
the BAR _value_ being zero is bogus and wrong.

Probing that finds a valid BAR, but an unassigned one, will set the
UNSET bit. Plus IORESOURCE_MEM or IO should also always be set for a
valid bar. So a value of zero really is completely unambiguous - it
does not exist. It's not unassigned, it really isn't there.

Of course, it's possible that we get this wrong, and initial probing
will obviously start out with a zero value, so there is clearly one
valid situation where we go from "does not exist" to something else,
but in general, "r->flags == 0" really is special.

           Linus
