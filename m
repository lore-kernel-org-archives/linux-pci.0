Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 10 Nov 2016 11:42:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Christopher Covington <cov@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Tomasz Nowicki <tn@semihalf.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Jayachandran C <jchandra@broadcom.com>,
        Duc Dang <dhdang@apm.com>,
        Robert Richter <robert.richter@caviumnetworks.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        David Daney <ddaney@caviumnetworks.com>,
        "wangyijing@huawei.com" <wangyijing@huawei.com>,
        Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
        Jon Masters <jcm@redhat.com>,
        Andrea Gallo <andrea.gallo@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Jeff Hugo <jhugo@codeaurora.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] PCI: QDF2432 32 bit config space accessors
Message-ID: <20161110174253.GC10384@bhelgaas-glaptop.roam.corp.google.com>
References: <20160921173129.GA20006@localhost>
 <20160921223805.21652-1-cov@codeaurora.org>
 <20161031214833.GB14603@bhelgaas-glaptop.roam.corp.google.com>
 <dbf40b73baa71155f39e13d6e51073aa@codeaurora.org>
 <20161102160820.GA6568@bhelgaas-glaptop.roam.corp.google.com>
 <aa37ca67-9909-e8f2-1a3e-b724cdb46c7b@codeaurora.org>
 <20161109200635.GM14322@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu82+5oHMeSvcOL1VG4vw-kVnhq4LjCRtLMw4Nmn0rK2CA@mail.gmail.com>
 <20161109224955.GO14322@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu9_sdcoN7rjQp-R=2vKY3rECt0BC3eWGpse32o2Q4LHXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKv+Gu9_sdcoN7rjQp-R=2vKY3rECt0BC3eWGpse32o2Q4LHXg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 10, 2016 at 06:25:16PM +0800, Ard Biesheuvel wrote:
> On 10 November 2016 at 06:49, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Nov 09, 2016 at 08:29:23PM +0000, Ard Biesheuvel wrote:
> >> Hi Bjorn,
> >>
> >> On 9 November 2016 at 20:06, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> > On Wed, Nov 09, 2016 at 02:25:56PM -0500, Christopher Covington wrote:
> >> >> Hi Bjorn,
> >> >>
> >> [...]
> >> >>
> >> >> We're working to add the PNP0C02 resource to future firmware, but it's
> >> >> not in the current firmware. Are dmesg and /proc/iomem from the
> >> >> current firmware interesting or should we wait for the update to file?
> >> >
> >> > Note that the ECAM space is not the only thing that should be
> >> > described via these PNP0C02 devices.  *All* non-enumerable resources
> >> > should be described by the _CRS method of some ACPI device.  Here's a
> >> > sample from my laptop:
> >> >
> >> >   PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
> >> >   system 00:01: [io  0x1800-0x189f] could not be reserved
> >> >   system 00:01: [io  0x0800-0x087f] has been reserved
> >> >   system 00:01: [io  0x0880-0x08ff] has been reserved
> >> >   system 00:01: [io  0x0900-0x097f] has been reserved
> >> >   system 00:01: [io  0x0980-0x09ff] has been reserved
> >> >   system 00:01: [io  0x0a00-0x0a7f] has been reserved
> >> >   system 00:01: [io  0x0a80-0x0aff] has been reserved
> >> >   system 00:01: [io  0x0b00-0x0b7f] has been reserved
> >> >   system 00:01: [io  0x0b80-0x0bff] has been reserved
> >> >   system 00:01: [io  0x15e0-0x15ef] has been reserved
> >> >   system 00:01: [io  0x1600-0x167f] has been reserved
> >> >   system 00:01: [io  0x1640-0x165f] has been reserved
> >> >   system 00:01: [mem 0xf8000000-0xfbffffff] could not be reserved
> >> >   system 00:01: [mem 0xfed10000-0xfed13fff] has been reserved
> >> >   system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
> >> >   system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
> >> >   system 00:01: [mem 0xfeb00000-0xfebfffff] has been reserved
> >> >   system 00:01: [mem 0xfed20000-0xfed3ffff] has been reserved
> >> >   system 00:01: [mem 0xfed90000-0xfed93fff] has been reserved
> >> >   system 00:01: [mem 0xf7fe0000-0xf7ffffff] has been reserved
> >> >   system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> >> >
> >> > Do you have firmware in the field that may not get updated?  If so,
> >> > I'd like to see the whole solution for that firmware, including the
> >> > MCFG quirk (which tells the PCI core where the ECAM region is) and
> >> > whatever PNP0C02 quirk you figure out to actually reserve the region.
> >> >
> >> > I proposed a PNP0C02 quirk to Duc along these lines of the below.  I
> >> > don't actually know if it's feasible, but it didn't look as bad as I
> >> > expected, so I'd kind of like somebody to try it out.  I think you
> >> > would have to call this via a DMI hook (do you have DMI on arm64?),
> >> > maybe from pnp_init() or similar.
> >>
> >> We do have SMBIOS/DMI on arm64, but we have been successful so far not
> >> to rely on it for quirks, and we'd very much like to keep it that way.
> >>
> >> Since this ACPI _CRS method has nothing to do with SMBIOS/DMI, surely
> >> there is a better way to wire up the reservation code to the
> >> information exposed by ACPI?
> >
> > I'm open to other ways, feel free to propose one :)
> >
> > If you do a quirk, you need some way to identify the machine/firmware
> > combination, because you don't want to apply the quirk on every
> > machine.  You're trying to work around a firmware issue, so you
> > probably want something tied to the firmware version.  On x86, that's
> > typically done with DMI.
> >
> 
> I think I misunderstood the purpose of the example: that should only
> be necessary if the _CRS methods are missing from the firmware, right?
> If we update the firmware to cover all non-enumerable resources by
> such a method, we shouldn't need any such quirks at all IIUC

Right: if the firmware provides a PNP0C02 device with _CRS that
includes the ECAM area, we don't need any PNP/ACPI quirks.  We will
still need the MCFG quirks since the hardware doesn't fully support
ECAM.

For the PNP/ACPI quirks, there are two interesting cases:

  1) Firmware provides a PNP0C02 device, but its _CRS doesn't include
     the ECAM space, and

  2) Firmware doesn't provide a PNP0C02 device at all.

For case 1, we could consider adding the ECAM space to the existing
device.  This is essentially what quirk_amd_mmconfig_area() does.

For case 2, we would have to fabricate the PNP0C02 device itself, then
add the ECAM space to it.  I don't think there's any existing code
that does this, so this is what the example I proposed in this thread
does.  

One could argue that it might be cleaner to use case 2 instead of the
case 1 approach because it avoids mucking with an ACPI device from
firmware.  For devices that support _SRS, case 1 might break things
because _CRS and _SRS are supposed to use the same resource descriptor
buffer, and if we add resources the firmware doesn't know about, I
don't think we'll encode the _SRS buffer correctly.  But this is only
a theoretical risk because we basically never use _SRS today.

In either case, there has to be a mechanism to do the quirk only on
the machine/firmware that needs it, of course.

Bjorn
