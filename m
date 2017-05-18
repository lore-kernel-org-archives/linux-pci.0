Return-Path: <SRS0=AMQT=4Y=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=AMQT=4Y=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 18 May 2017 16:47:08 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Graeme Gregory <graeme.gregory@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Leif Lindholm <leif.lindholm@linaro.org>,
	Sinan Kaya <okaya@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] arm64: acpi/pci: allow the firmware BAR
 configuration to be preserved
Message-ID: <20170518154708.GA30182@red-moon>
References: <20170411163313.18577-1-ard.biesheuvel@linaro.org>
 <20170517215611.GJ31462@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu9T7vH_LbKfS_40JUbLNK4PYrMi++eKbCq_MzBsuQxUDQ@mail.gmail.com>
 <20170518140553.GA22106@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_cug6cVrWP-zkptvNn3LxYk7b4Gd=iTzHHe3us3KwL3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKv+Gu_cug6cVrWP-zkptvNn3LxYk7b4Gd=iTzHHe3us3KwL3Q@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 18, 2017 at 04:10:28PM +0100, Ard Biesheuvel wrote:

[...]

> >> Re _DSM: I think it makes sense to honour it, because it puts the
> >> allocation under the control of the firmware, which completely removes
> >> the burden of having to reason about a policy in the kernel. That
> >> leaves the question which will be the default, but that is of minor
> >> importance IMO.
> >
> > I agree; we should try to follow the spec unless we have a good reason
> > not to, which argues for honoring the _DSM, so I think it's worth a
> > try.  Booting with "pci=realloc" could override the _DSM and taint the
> > kernel (because we don't know the effect of reassigning something the
> > firmware told us not to touch).
> >
> 
> I'd like to hear Lorenzo's view on this first, but I can certainly
> respin my _DSM patch to take pci=realloc into account, and move the
> handling to generic code as well.

I agree with both of you on _DSM implementation and interpretation.

Now, if we use it correctly (ie by the FW standard) on ARM64 systems we
are going to trigger regressions, that's certain (ie we can then boot
with pci=realloc - still, we are breaking systems), that's the reason
why for patch(2) I'd like to create a branch and send a CFT for ARM64
ACPI testing before queuing it (either I can set-up a testing branch
or we ask Bjorn to do it - as you guys prefer - as long as we have
a branch for people to test patch(2) on ARM64 ACPI systems).

You still need to assign resources that could not be claimed though
so patch(2) still needs updating:

PCI FW spec 3.1 - 4.6.5

"...However, the operating system is free to configure the devices in this
hierarchy that have not been configured by the firmware."

Which in kernel-speak it means that you have to assign resources that
could not be claimed.

Thanks !
Lorenzo
