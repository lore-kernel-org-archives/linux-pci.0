Return-Path: <SRS0=bmG0=A5=linaro.org=ard.biesheuvel@kernel.org>
Return-Path: <SRS0=bmG0=A5=linaro.org=ard.biesheuvel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170928090339.GA21499@arm.com>
References: <20170828180437.2646-1-ard.biesheuvel@linaro.org>
 <20170828180437.2646-2-ard.biesheuvel@linaro.org> <20170926173200.GL15970@bhelgaas-glaptop.roam.corp.google.com>
 <20170928090339.GA21499@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 28 Sep 2017 08:57:28 -0700
Message-ID: <CAKv+Gu-7OWG0=7VcWxaVqtAYoWrmNd1xhweS+EhSZES3cNJ+Kw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] pci: designware: add driver for DWC controller in
 ECAM shift mode
To: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>,
	Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On 28 September 2017 at 02:03, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Sep 26, 2017 at 12:32:00PM -0500, Bjorn Helgaas wrote:
>> [+cc Will]
>>
>> On Mon, Aug 28, 2017 at 07:04:36PM +0100, Ard Biesheuvel wrote:
>> > Some implementations of the Synopsys Designware PCIe controller implement
>> > a so-called ECAM shift mode, which allows a static memory window to be
>> > configured that covers the configuration space of the entire bus range.
>> >
>> > If the firmware performs all the low level configuration that is required
>> > to expose this controller in a fully ECAM compatible manner, we can
>> > simply describe it as "pci-host-ecam-generic" and be done with it.
>> > However, it appears that in some cases (one of which is the Armada 80x0),
>> > the IP is synthesized with an ATU window size that does not allow the
>> > first bus to be mapped in a way that prevents the device on the
>> > downstream port from appearing more than once.
>> >
>> > So implement a driver that relies on the firmware to perform all low
>> > level initialization, and drives the controller in ECAM mode, but
>> > overrides the config space accessors to take the above quirk into
>> > account.
>> >
>> > Note that, unlike most drivers for this IP, this driver does not expose
>> > a fake bridge device at B/D/F 00:00.0. There is no point in doing so,
>> > given that this is not a true bridge, and does not require any windows
>> > to be configured in order for the downstream device to operate correctly.
>> > Omitting it also prevents the PCI resource allocation routines from
>> > handing out BAR space to it unnecessarily.
>>
>> This is a tangent, but does this mean the other drivers do not need to
>> expose a fake 00:00.0 device either?
>>
>> s/Designware/DesignWare/ in comments, changelogs, Kconfig text, etc.
>>
>> > Cc: Bjorn Helgaas <bhelgaas@google.com>
>> > Cc: Jingoo Han <jingoohan1@gmail.com>
>> > Cc: Joao Pinto <Joao.Pinto@synopsys.com>
>> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> > ---
>> >  drivers/pci/dwc/Kconfig                | 11 +++
>> >  drivers/pci/dwc/Makefile               |  1 +
>> >  drivers/pci/dwc/pcie-designware-ecam.c | 77 ++++++++++++++++++++
>>
>> This really doesn't have any DesignWare specifics in it, and it seems
>> more related to drivers/pci/host/pci-host-generic.c than to anything
>> in drivers/pci/dwc.  Maybe it should be
>> drivers/pci/host/pci-host-generic-quirks.c or something?  That's
>> unwieldy, I admit.
>>
>> Putting it in pci/dwc would make Jingoo and Joao the default
>> maintainers; I don't know how they feel about that.  We would probably
>> have to tweak MAINTAINERS if we *didn't* put it in pci/dwc.
>>
>> Any thoughts on this, Will?
>
> The idea of a "generic quirk" makes me smile, I must admit :)
>
> I think there are two options:
>
>   1. Use the full DWC driver, and don't rely on firmware
> -or-
>   2. Rely on firmware, but teach pci-host-generic to deal with the funny
>      config space
>
> For (2), we probably want to describe this as generically as possible
> in case some other SoCs run into the same problem.
>

I take it this implies a DT property. I could add one that consists of
an array of val/mask tuples or base/size tuples that allow us to
disable arbitrary subregions of the config space. I could also add a
simple boolean property that implements this exact quirk. Do you have
any preference?
