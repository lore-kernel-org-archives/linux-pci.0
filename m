Return-Path: <SRS0=DeKn=DC=ellerman.id.au=mpe@kernel.org>
Return-Path: <SRS0=DeKn=DC=ellerman.id.au=mpe@kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>, Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, Bjorn Helgaas <helgaas@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] SB600 for the Nemo board has non-zero devices on non-root bus
In-Reply-To: <20171202230052.34y2ivxgpgr3osct@localhost>
References: <87tvxl15qx.fsf@concordia.ellerman.id.au> <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de> <CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com> <28b43e1a-3643-9edb-7123-be1cb0dc846a@xenosoft.de> <CAErSpo7fup7+doD6A7RKh8kdE8HQaQrEh=gq35+nC-dBeOQ1uA@mail.gmail.com> <527175f7-8a13-37a1-9f0a-0b918aeebd64@xenosoft.de> <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com> <406ba7c4-7305-4069-227f-81afed202e47@xenosoft.de> <20171201232716.GA18780@bhelgaas-glaptop.roam.corp.google.com> <6d2505ab-a985-bdb0-ad3a-e7659cc2c54d@xenosoft.de> <20171202230052.34y2ivxgpgr3osct@localhost>
Date: Wed, 06 Dec 2017 23:44:44 +1100
Message-ID: <87indkdo03.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Olof Johansson <olof@lixom.net> writes:

> On Sat, Dec 02, 2017 at 01:54:41PM +0100, Christian Zigotzky wrote:
>> On 02 December 2017 at 00:27AM, Bjorn Helgaas wrote:
>> >=20
>> > Thanks for testing that.  I'll merge a similar patch for v4.16.
>> >=20
>> > I don't think using "pci=3Dpcie_scan_all" is really an acceptable
>> > long-term answer for you, though.  Is there some way we can identify
>> > at run-time whether we're on a Nemo system?  If so, we can make this
>> > happen automatically.
>> >=20
>> > Bjorn
>> >=20
>> Hi Bjorn,
>>=20
>> Many thanks for your effort! I appreciate it very much. :-)
>>=20
>> We can identify the Nemo board at the boot time. See dmesg output: [=C2=
=A0=C2=A0=C2=A0
>> 0.061592] NEMO SB600 IOB base e0000000
>>=20
>> @linuxppc-dev
>> Any other ideas? Maybe the same as we can identify the other P.A. Semi
>> boards (Electra, Chitra, and Athena).
>>=20
>> @Olof
>> Maybe you know how we can identify the P.A. Semi Nemo board at the run-t=
ime.
>>=20
>> @Darren
>> Do you have an idea?
>
>
> The below patch, together with Bjorn's, should do it. Christian, can you =
test
> and report back?
>
> I'm guessing it won't do any harm to set this on non-X1000 platforms. My
> test system is currently powered down so I can't check.

My pasemi board had been powered off for a while and when I turned it
back on something popped, the power supply blew up and tripped a
breaker.

So I also can't test this, at least for now, until I get my "allowed to
use hardware" license back from my colleagues in the office.

cheers
