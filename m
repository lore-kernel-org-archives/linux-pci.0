Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 14 Nov 2016 11:26:25 +0000
From: "liviu.dudau@arm.com" <liviu.dudau@arm.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "minyard@acm.org" <minyard@acm.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuwei (O)" <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kantyzc@163.com" <kantyzc@163.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "bhelgaas@googl e.com" <bhelgaas@google.com>,
        "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Message-ID: <20161114112625.GO10219@e106497-lin.cambridge.arm.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <17821285.aIcTyCGn5n@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8F5D75@lhreml507-mbx>
 <10334260.ztLXZ2Oynd@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8F900A@lhreml507-mbx>
 <20161111144539.GL10219@e106497-lin.cambridge.arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8F9909@lhreml507-mbx>
 <20161111181606.GN10219@e106497-lin.cambridge.arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F90EA45@lhreml507-mbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F90EA45@lhreml507-mbx>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 14, 2016 at 08:26:42AM +0000, Gabriele Paoloni wrote:
> Hi Liviu
> 

[snip]

> > > >
> > > > Your idea is a good one, however you are abusing PCIBIOS_MIN_IO and
> > you
> > > > actually need another variable for "reserving" an area in the I/O
> > space
> > > > that can be used for physical addresses rather than I/O tokens.
> > > >
> > > > The one good example for using PCIBIOS_MIN_IO is when your
> > > > platform/architecture
> > > > does not support legacy ISA operations *at all*. In that case
> > someone
> > > > sets the PCIBIOS_MIN_IO to a non-zero value to reserve that I/O
> > range
> > > > so that it doesn't get used. With Zhichang's patch you now start
> > > > forcing
> > > > those platforms to have a valid address below PCIBIOS_MIN_IO.
> > >
> > > But if PCIBIOS_MIN_IO is 0 then it means that all I/O space is to be
> > used
> > > by PCI controllers only...
> > 
> > Nope, that is not what it means. It means that PCI devices can see I/O
> > addresses
> > on the bus that start from 0. There never was any usage for non-PCI
> > controllers
> 
> So I am a bit confused...
> From http://www.firmware.org/1275/bindings/isa/isa0_4d.ps
> It seems that ISA buses operate on cpu I/O address range [0, 0xFFF].
> I thought that was the reason why for most architectures we have
> PCIBIOS_MIN_IO equal to 0x1000 (so I thought that ISA controllers
> usually use [0, PCIBIOS_MIN_IO - 1] )

First of all, cpu I/O addresses is an x86-ism. ARM architectures and others
 have no separate address space for I/O, it is all merged into one unified
address space. So, on arm/arm64 for example, PCIBIOS_MIN_IO = 0 could mean
that we don't care about ISA I/O because the platform does not support having
an ISA bus (e.g.).


> 
> For those architectures whose PCIBIOS_MIN_IO != 0x1000 probably
> they are not fully compliant or they cannot fully support an ISA
> controller...?

Exactly. Not fully compliant is a bit strong, as ISA is a legacy feature and
when it comes to PCI-e you are allowed to ignore it. Having PCIBIOS_MIN_IO != 0x1000
is a way to signal that you don't fully support ISA.

> 
> As said before this series forbid IO tokens to be in [0, PCIBIOS_MIN_IO)
> to allow special ISA controllers to use that range with special
> accessors.
> Having a variable threshold would make life much more difficult
> as there would be a probe dependency between the PCI controller and
> the special ISA one (PCI to wait for the special ISA device to be
> probed and set the right threshold value from DT or ACPI table).
> 
> Instead using PCIBIOS_MIN_IO is easier and should not impose much
> constraint as [PCIBIOS_MIN_IO, IO_SPACE_LIMIT] is available to
> the PCI controller for I/O tokens...

What I am suggesting is to leave PCIBIOS_MIN_IO alone which still reserves
space for ISA controller and add a PCIBIOS_MIN_DIRECT_IO that will reserve
space for your direct address I/O on top of PCIBIOS_MIN_IO.

Best regards,
Liviu

> 
> Thanks
> 
> Gab
> 
> > when PCIBIOS_MIN_IO != 0. That is what Zhichang is trying to do now and
> > what
> > I think is not the right thing (and not enough anyway).
> > 
> > > so if you have a special bus device using
> > > an I/O range in this case should be a PCI controller...
> > 
> > That has always been the case. It is this series that wants to
> > introduce the
> > new meaning.
> > 
> > > i.e. I would
> > > expect it to fall back into the case of I/O tokens redirection rather
> > than
> > > physical addresses redirection (as mentioned below from my previous
> > reply).
> > > What do you think?
> > 
> > I think you have looked too much at the code *with* Zhichang's patches
> > applied.
> > Take a step back and look at how PCIBIOS_MIN_IO is used now, before you
> > apply
> > the patches. It is all about PCI addresses and there is no notion of
> > non-PCI
> > busses using PCI framework. Only platforms and architectures that try
> > to work
> > around some legacy standards (ISA) or HW restrictions.
> > 
> > Best regards,
> > Liviu
> > 
> > >
> > > Thanks
> > >
> > > Gab
> > >
> > >
> > > >
> > > > For the general case you also have to bear in mind that
> > PCIBIOS_MIN_IO
> > > > could
> > > > be zero. In that case, what is your "forbidden" range? [0, 0) ? So
> > it
> > > > makes
> > > > sense to add a new #define that should only be defined by those
> > > > architectures/
> > > > platforms that want to reserve on top of PCIBIOS_MIN_IO another
> > region
> > > > where I/O tokens can't be generated for.
> > > >
> > > > Best regards,
> > > > Liviu
> > > >
> > > > >
> > > > > >
> > > > > > > > Your current version has
> > > > > > > >
> > > > > > > >         if (arm64_extio_ops->pfout)
> > > > \
> > > > > > > >                 arm64_extio_ops->pfout(arm64_extio_ops-
> > > > >devpara,\
> > > > > > > >                        addr, value, sizeof(type));
> > > > \
> > > > > > > >
> > > > > > > > Instead, just subtract the start of the range from the
> > logical
> > > > > > > > port number to transform it back into a bus-local port
> > number:
> > > > > > >
> > > > > > > These accessors do not operate on IO tokens:
> > > > > > >
> > > > > > > If (arm64_extio_ops->start > addr || arm64_extio_ops->end <
> > addr)
> > > > > > > addr is not going to be an I/O token; in fact patch 2/3
> > imposes
> > > > that
> > > > > > > the I/O tokens will start at PCIBIOS_MIN_IO. So from 0 to
> > > > > > PCIBIOS_MIN_IO
> > > > > > > we have free physical addresses that the accessors can
> > operate
> > > > on.
> > > > > >
> > > > > > Ah, I missed that part. I'd rather not use PCIBIOS_MIN_IO to
> > refer
> > > > to
> > > > > > the logical I/O tokens, the purpose of that macro is really
> > meant
> > > > > > for allocating PCI I/O port numbers within the address space of
> > > > > > one bus.
> > > > >
> > > > > As I mentioned above, special devices operate on CPU addresses
> > > > directly,
> > > > > not I/O tokens. For them there is no way to distinguish....
> > > > >
> > > > > >
> > > > > > Note that it's equally likely that whichever next platform
> > needs
> > > > > > non-mapped I/O access like this actually needs them for PCI I/O
> > > > space,
> > > > > > and that will use it on addresses registered to a PCI host
> > bridge.
> > > > >
> > > > > Ok so here you are talking about a platform that has got an I/O
> > range
> > > > > under the PCI host controller, right?
> > > > > And this I/O range cannot be directly memory mapped but needs
> > special
> > > > > redirections for the I/O tokens, right?
> > > > >
> > > > > In this scenario registering the I/O ranges with the forbidden
> > range
> > > > > implemented by the current patch would still allow to redirect
> > I/O
> > > > > tokens as long as arm64_extio_ops->start >= PCIBIOS_MIN_IO
> > > > >
> > > > > So effectively the special PCI host controller
> > > > > 1) knows the physical range that needs special redirection
> > > > > 2) register such range
> > > > > 3) uses pci_pio_to_address() to retrieve the IO tokens for the
> > > > >    special accessors
> > > > > 4) sets arm64_extio_ops->start/end to the IO tokens retrieved in
> > 3)
> > > > >
> > > > > So to be honest I think this patch can fit well both with
> > > > > special PCI controllers that need I/O tokens redirection and with
> > > > > special non-PCI controllers that need non-PCI I/O physical
> > > > > address redirection...
> > > > >
> > > > > Thanks (and sorry for the long reply but I didn't know how
> > > > > to make the explanation shorter :) )
> > > > >
> > > > > Gab
> > > > >
> > > > > >
> > > > > > If we separate the two steps:
> > > > > >
> > > > > > a) assign a range of logical I/O port numbers to a bus
> > > > > > b) register a set of helpers for redirecting logical I/O
> > > > > >    port to a helper function
> > > > > >
> > > > > > then I think the code will get cleaner and more flexible.
> > > > > > It should actually then be able to replace the powerpc
> > > > > > specific implementation.
> > > > > >
> > > > > > 	Arnd

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
