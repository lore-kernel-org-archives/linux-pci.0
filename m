Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:63235 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbbA3SSb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jan 2015 13:18:31 -0500
Received: by mail-qa0-f46.google.com with SMTP id j7so21124079qaq.5
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2015 10:18:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+8MBbLprQgbOo_aTaafHzEVcOPR3vp2gxFPDTX3YYS2Ywh6zg@mail.gmail.com>
References: <20150123203145.GA6691@google.com> <CA+8MBbKnT=mE3kev8BRPq0GeTgHx8WVa6o54tJuBX_XXLpHdYQ@mail.gmail.com>
 <CAErSpo7y1wWStjcEOH9xTiM-As8+QeMynZ5ENrL9v3X2PvQCcw@mail.gmail.com>
 <CA+8MBb+bWiX2eayjBQHsvCjTp3t8H9=AviF9AkV6CC--cC_fYQ@mail.gmail.com>
 <CAE9FiQXj07CtOJ6uBZomNyhAH9ANanbbUSo51td6G-UB5Rmmow@mail.gmail.com>
 <CA+8MBbLVgfk3LEAnuAx_MRJpHkQO-cEQnuCrcbxcyOezr5RLcg@mail.gmail.com>
 <CAE9FiQXnTPO2tM252zvTGJF9Nmc-R+6z65Kq3aXC3jvxtAK2Qw@mail.gmail.com>
 <CAErSpo5CmVTw1-jQ2cwZS27nWH6zEyO5yqaedPN8jeRiU=JUfQ@mail.gmail.com> <CA+8MBbLprQgbOo_aTaafHzEVcOPR3vp2gxFPDTX3YYS2Ywh6zg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 30 Jan 2015 12:18:11 -0600
Message-ID: <CAErSpo6W2oa2SvfhATGTtRrrgcmQQh6H+-BSxin_OQR+_JqYMQ@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v3.19
To: Tony Luck <tony.luck@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Marek Kordik <kordikmarek@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andreas Hartmann <andihartmann@freenet.de>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 30, 2015 at 12:01 PM, Tony Luck <tony.luck@gmail.com> wrote:
> On Fri, Jan 30, 2015 at 8:56 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> Tony, does the system work as it did before?  Is the only problem that
>> now we have more warnings than we did before?
>
> Yup - things seem to be working. Just have a bunch of new console messages.
>
> It seems that at least some of them are valid - the BIOS isn't describing some
> things that it should.  I don't think we need to re-apply code that
> used to paper
> over this problem. I can just add these to the list of "harmless" messages to
> ignore when running new kernels on this old machine.
>
> Or did I misunderstand some part of this thread?

Nope, I think the complaints about BARs 0 and 8 on bus 80 are
legitimate errors, and adding them to the list of "harmless" messages
is the right thing to do.

The ones complaining about BAR 6 (an option ROM) are the ones I'm more
concerned about.  There's no address space assigned to them, but I
don't think that indicates a firmware defect, and the message is sort
of cryptic, so I don't want to emit it more often than we have to.

But if ia64 is handling these ROMs the same way as x86, this is just
an opportunity for future improvement, and we don't need to do
anything right now.

Bjorn
