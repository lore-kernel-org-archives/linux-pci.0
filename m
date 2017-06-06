Return-Path: <SRS0=KJCd=5L=linaro.org=ard.biesheuvel@kernel.org>
Return-Path: <SRS0=KJCd=5L=linaro.org=ard.biesheuvel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170606085936.GB20085@red-moon>
References: <20170517215611.GJ31462@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu9T7vH_LbKfS_40JUbLNK4PYrMi++eKbCq_MzBsuQxUDQ@mail.gmail.com>
 <20170518140553.GA22106@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_cug6cVrWP-zkptvNn3LxYk7b4Gd=iTzHHe3us3KwL3Q@mail.gmail.com>
 <20170518154708.GA30182@red-moon> <CAKv+Gu-NDR1PYUfOs4z-T9WoeBrYvFTTBt3XMiMg+AU76MbYBg@mail.gmail.com>
 <20170518174612.GA31373@red-moon> <CAKv+Gu8hVhpNrXG+JUQu8XYZtQE86d0O66J8AORWDC6Ttcp3iA@mail.gmail.com>
 <20170601161511.GB19003@red-moon> <CAKv+Gu9FyLuQk3hkauoRzGME1FxHPgusWQe0v8eSJaKfaX7LMA@mail.gmail.com>
 <20170606085936.GB20085@red-moon>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 6 Jun 2017 09:14:26 +0000
Message-ID: <CAKv+Gu-jVGvEJY7YBxSQHu+0jtnDHG7_6Gdpac8ca4PbPggw3Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: acpi/pci: allow the firmware BAR configuration
 to be preserved
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	linux-pci <linux-pci@vger.kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Leif Lindholm <leif.lindholm@linaro.org>, Sinan Kaya <okaya@codeaurora.org>,
	Tomasz Nowicki <tn@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On 6 June 2017 at 08:59, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> Hi Ard,
>
> On Thu, Jun 01, 2017 at 04:18:54PM +0000, Ard Biesheuvel wrote:
>> On 1 June 2017 at 16:15, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> > On Thu, Jun 01, 2017 at 03:04:09PM +0000, Ard Biesheuvel wrote:
>> >> On 18 May 2017 at 18:46, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> >> > On Thu, May 18, 2017 at 05:51:44PM +0100, Ard Biesheuvel wrote:
>> >> >> On 18 May 2017 at 16:47, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> >> >> > On Thu, May 18, 2017 at 04:10:28PM +0100, Ard Biesheuvel wrote:
>> >> >> >
>> >> >> > [...]
>> >> >> >
>> >> >> >> >> Re _DSM: I think it makes sense to honour it, because it puts the
>> >> >> >> >> allocation under the control of the firmware, which completely removes
>> >> >> >> >> the burden of having to reason about a policy in the kernel. That
>> >> >> >> >> leaves the question which will be the default, but that is of minor
>> >> >> >> >> importance IMO.
>> >> >> >> >
>> >> >> >> > I agree; we should try to follow the spec unless we have a good reason
>> >> >> >> > not to, which argues for honoring the _DSM, so I think it's worth a
>> >> >> >> > try.  Booting with "pci=realloc" could override the _DSM and taint the
>> >> >> >> > kernel (because we don't know the effect of reassigning something the
>> >> >> >> > firmware told us not to touch).
>> >> >> >> >
>> >> >> >>
>> >> >> >> I'd like to hear Lorenzo's view on this first, but I can certainly
>> >> >> >> respin my _DSM patch to take pci=realloc into account, and move the
>> >> >> >> handling to generic code as well.
>> >> >> >
>> >> >> > I agree with both of you on _DSM implementation and interpretation.
>> >> >> >
>> >> >> > Now, if we use it correctly (ie by the FW standard) on ARM64 systems we
>> >> >> > are going to trigger regressions, that's certain (ie we can then boot
>> >> >> > with pci=realloc - still, we are breaking systems), that's the reason
>> >> >> > why for patch(2) I'd like to create a branch and send a CFT for ARM64
>> >> >> > ACPI testing before queuing it (either I can set-up a testing branch
>> >> >> > or we ask Bjorn to do it - as you guys prefer - as long as we have
>> >> >> > a branch for people to test patch(2) on ARM64 ACPI systems).
>> >> >> >
>> >> >> > You still need to assign resources that could not be claimed though
>> >> >> > so patch(2) still needs updating:
>> >> >> >
>> >> >> > PCI FW spec 3.1 - 4.6.5
>> >> >> >
>> >> >> > "...However, the operating system is free to configure the devices in this
>> >> >> > hierarchy that have not been configured by the firmware."
>> >> >> >
>> >> >> > Which in kernel-speak it means that you have to assign resources that
>> >> >> > could not be claimed.
>> >> >> >
>> >> >>
>> >> >> Right. AFAICT this is the part that is typically handled by
>> >> >> pcibios_resource_survey() et al, whose default __weak implementations
>> >> >> are empty functions. Shall I override those for arm64 to host this
>> >> >> logic?
>> >> >
>> >> > I think it makes sense yes unless Bjorn spots something wrong with that
>> >> > but you should also call it in ARM64 pci_acpi_scan_root() since it is
>> >> > not called by PCI core on non-hot-added bridges, I reckon you figured
>> >> > that out already though.
>> >> >
>> >>
>> >> Another data point for this discussion: currently, when booting arm64
>> >> via DT, we set PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS (unless
>> >> PCI_PROBE_ONLY is requested), which forces not only resource
>> >> allocations but also the bus numbering to be reconfigured from
>> >> scratch.
>> >>
>> >> On arm64/ACPI, we never set those flags, which will cause
>> >> pci_scan_bridge() to preserve the secondary and subordinate bridge
>> >> numbers if they are non-zero. This actually prevents log messages like
>> >>
>> >> pci_bus 0000:02: busn_res: can not insert [bus 02-ff] under [bus
>> >> 00-7f] (conflicts with (null) [bus 00-7f])
>> >>
>> >> which I see on AMD Seattle as well as QEMU when booting via DT (and I
>> >> suspect on any DT PCI root whose bus range != {0x0 0xff>). However, it
>> >> also means that we already have different behavior between ACPI and DT
>> >> boot on arm64, which makes it ambiguous what the behavior should be if
>> >> _DSM indicates that the configuration should not be preserved. IOW,
>> >> 'reconfigure everything' currently means different things between DT
>> >> and ACPI boot.
>> >
>> > IMO they should mean the same thing which implies setting those flags
>> > (ie PCI_REASSIGN_ALL_RSRC has no effect though on ARM64) on ARM64
>> > ACPI systems as a starting point and then changes in this thread can
>> > be applied on top.
>> >
>>
>> OK
>>
>> > Having said that, I am not sure the message you get above is really
>> > effective (not sure I undestand the net effect of that resource
>> > conflict) so I should look into this.
>> >
>>
>> It appears to be behavior that is known to be incorrect but is
>> preserved for historical reasons.
>>
>> Please refer to
>> 12d8706963f0 Revert "PCI: Make sure bus number resources stay within
>> their parents bounds"
>> 1820ffdccb9b PCI: Make sure bus number resources stay within their
>> parents bounds
>
> Do you want me to create a branch out of these patches (inclusive of
> another patch to fix this bus reallocation policy discrepancy) for
> ARM64 folks to test ? Let me know, thanks !
>

Hi Lorenzo,

Bjorn has already picked up #1, which is now in -next. I will get back
to this topic today or tomorrow, so let me respin (including the bus
range fix) first, ok?

Thanks,
Ard.
