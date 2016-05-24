Return-Path: <gabriele.paoloni@huawei.com>
Return-Path: <gabriele.paoloni@huawei.com>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Jon Masters <jcm@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel
	<ard.biesheuvel@linaro.org>,
        Tomasz Nowicki <tn@semihalf.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rafael@kernel.org"
	<rafael@kernel.org>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "jchandra@broadcom.com"
	<jchandra@broadcom.com>,
        "linaro-acpi@lists.linaro.org"
	<linaro-acpi@lists.linaro.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "dhdang@apm.com" <dhdang@apm.com>,
        "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
        "ddaney@caviumnetworks.com"
	<ddaney@caviumnetworks.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
        "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
        "msalter@redhat.com" <msalter@redhat.com>,
        Wangyijing
	<wangyijing@huawei.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
Date: Tue, 24 May 2016 14:33:43 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1EDB4C52@lhreml503-mbs>
References: <EE11001F9E5DDD47B7634E2F8A612F2E1ED8DF51@lhreml503-mbs>
 <57331290.7070104@semihalf.com>
 <3d4aae09-51c4-f007-5100-191a4a85e27a@redhat.com>
 <CAKv+Gu8fdeJ9OvRSmtu9zyvcjK3O-4WU=jG=6-7t4xZwvV8d2g@mail.gmail.com>
 <95b1d06e-f9c5-39f3-1003-f536b65eef60@redhat.com>
 <CAKv+Gu-_xp_t_Ze3Pw_-82-fmy=tCy-h=4FbP98eLbuXVk2hHQ@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EDAF6AC@lhreml503-mbs>
 <CAKv+Gu_zpoFsDr7e8zPCDKPpRdKDVH+vnC0nfvmGaJ7xcP3Zng@mail.gmail.com>
 <20160523105655.GA22902@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EDB35A5@lhreml503-mbs>
 <20160523233918.GA32555@localhost>
 <426907D3-FBE7-458F-AB94-F64489AB0337@redhat.com>
In-Reply-To: <426907D3-FBE7-458F-AB94-F64489AB0337@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Jon

> -----Original Message-----
> From: Jon Masters [mailto:jcm@redhat.com]
> Sent: 24 May 2016 02:11
> To: Bjorn Helgaas
> Cc: Gabriele Paoloni; Lorenzo Pieralisi; Ard Biesheuvel; Tomasz
> Nowicki; arnd@arndb.de; will.deacon@arm.com; catalin.marinas@arm.com;
> rafael@kernel.org; hanjun.guo@linaro.org; okaya@codeaurora.org;
> jchandra@broadcom.com; linaro-acpi@lists.linaro.org; linux-
> pci@vger.kernel.org; dhdang@apm.com; Liviu.Dudau@arm.com;
> ddaney@caviumnetworks.com; jeremy.linton@arm.com; linux-
> kernel@vger.kernel.org; linux-acpi@vger.kernel.org;
> robert.richter@caviumnetworks.com; Suravee.Suthikulpanit@amd.com;
> msalter@redhat.com; Wangyijing; mw@semihalf.com;
> andrea.gallo@linaro.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH V7 00/11] Support for generic ACPI based PCI host
> controller
>=20
> Bjorn,
>=20
> Out walking so sorry about top posting. Quick reply though:
>=20
> 1. I checked with the Windows team. They usually avoid quirks entirely
> but when it has happened, it has been done via the MCFG/FADT not DSDT.
>=20
> 2. They would be ok if we were to key off the OEM  name and revision
> for the IP in the MCFG table.

I see some problems with this approach:

1) We would need to modify the ACPI specs to accommodate quirks in the MCFG=
,
   correct?

2) Just adding OEM info would not fit some other people (like us for Design=
ware
   based solutions). In our case for example the addresses defined in the M=
CFG
   are not compatible with the ones used by the Designware IP, therefore we=
 would
   also need specific quirk data

I think that we can use an approach where we use MCFG entries for the ECAM
address spaces and motherboard reserved resources for those BUSes that are
outside the MCFG table and therefore are non ECAM.

I think it is a more generic approach that would suit anybody and there
is no need to redefine the ACPI specs for MCFG... ?

Thanks

Gab

>=20
> 3. I have already verified existing shipping ARMv8 systems provide
> enough unique data in that entry, and have asked that vendors guarantee
> to rev it in future IP (which I will verify on models pre tapeout and
> certainly in early firmware builds). One vendor has a platform that
> isn't public yet that uses a non-public name in the MCFG but I spoke
> with them on Friday and they will shortly update their firmware so that
> a quirk could be posted.
>=20
> 4. I have requested (and Linaro are investigating) that Linaro (with
> ARM's assistance) begin to drive a separate thread around upstreaming
> (independent of this core effort) quirks that use the OEM fields in the
> MCFG as a more scalable approach than one per platform via DMI.
>=20
> 5. I will drive a clarification to the SBBR that does not encourage or
> endorse quirks but does merely reinforce that data must be unique in
> such tables. I am driving a separate series of conversations with
> vendors to ensure that this is the case on all future platforms -
> though just generally, there is no more high end top shelf "Xeon class"
> silicon needing common quirks in the pipeline.
>=20
> More later.
>=20
> Jon.
>=20
> --
> Computer Architect | Sent from my 64-bit #ARM Powered phone
>=20
> > On May 23, 2016, at 19:39, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> >> On Mon, May 23, 2016 at 03:16:01PM +0000, Gabriele Paoloni wrote:
> >> Hi Lorenzo
> >>
> >>> -----Original Message-----
> >>> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> >>> Sent: 23 May 2016 11:57
> >>> To: Ard Biesheuvel
> >>> Cc: Gabriele Paoloni; Jon Masters; Tomasz Nowicki;
> helgaas@kernel.org;
> >>> arnd@arndb.de; will.deacon@arm.com; catalin.marinas@arm.com;
> >>> rafael@kernel.org; hanjun.guo@linaro.org; okaya@codeaurora.org;
> >>> jchandra@broadcom.com; linaro-acpi@lists.linaro.org; linux-
> >>> pci@vger.kernel.org; dhdang@apm.com; Liviu.Dudau@arm.com;
> >>> ddaney@caviumnetworks.com; jeremy.linton@arm.com; linux-
> >>> kernel@vger.kernel.org; linux-acpi@vger.kernel.org;
> >>> robert.richter@caviumnetworks.com; Suravee.Suthikulpanit@amd.com;
> >>> msalter@redhat.com; Wangyijing; mw@semihalf.com;
> >>> andrea.gallo@linaro.org; linux-arm-kernel@lists.infradead.org
> >>> Subject: Re: [PATCH V7 00/11] Support for generic ACPI based PCI
> host
> >>> controller
> >>>
> >>>> On Fri, May 20, 2016 at 11:14:03AM +0200, Ard Biesheuvel wrote:
> >>>> On 20 May 2016 at 10:40, Gabriele Paoloni
> >>> <gabriele.paoloni@huawei.com> wrote:
> >>>>> Hi Ard
> >>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Ard Biesheuvel [mailto:ard.biesheuvel@linaro.org]
> >>>> [...]
> >>>>>>
> >>>>>> Is the PCIe root complex so special that you cannot simply
> >>> describe an
> >>>>>> implementation that is not PNP0408 compatible as something else,
> >>> under
> >>>>>> its own unique HID? If everybody is onboard with using ACPI, how
> >>> is
> >>>>>> this any different from describing other parts of the platform
> >>>>>> topology? Even if the SBSA mandates generic PCI, they already
> >>> deviated
> >>>>>> from that when they built the hardware, so pretending that it is
> a
> >>>>>> PNP0408 with quirks really does not buy us anything.
> >>>>>
> >>>>> From my understanding we want to avoid this as this would allow
> >>> each
> >>>>> vendor to come up with his own code and it would be much more
> >>> effort
> >>>>> for the PCI maintainer to rework the PCI framework to accommodate
> >>> X86
> >>>>> and "all" ARM64 Host Controllers...
> >>>>>
> >>>>> I guess this approach is too risky and we want to avoid this.
> >>> Through
> >>>>> standardization we can more easily maintain the code and scale it
> >>> to
> >>>>> multiple SoCs...
> >>>>>
> >>>>> So this is my understanding; maybe Jon, Tomasz or Lorenzo can
> give
> >>>>> a bit more explanation...
> >>>>
> >>>> OK, so that boils down to recommending to vendors to represent
> known
> >>>> non-compliant hardware as compliant, just so that we don't have to
> >>>> change the code to support additional flavors of ECAM ? It's fine
> to
> >>>> be pragmatic, but that sucks.
> >>>>
> >>>> We keep confusing the x86 case with the ARM case here: for x86,
> they
> >>>> needed to deal with broken hardware *after* the fact, and all they
> >>>> could do is find /some/ distinguishing feature in order to guess
> >>> which
> >>>> exact hardware they might be running on. For arm64, it is the
> >>> opposite
> >>>> case. We are currently in a position where we can demand vendors
> to
> >>>> comply with the standards they endorsed themselves, and (ab)using
> >>> ACPI
> >>>> + DMI as a de facto platform description rather than plain ACPI
> makes
> >>>> me think the DT crowd were actually right from the beginning. It
> >>>> *directly* violates the standardization principle, since it
> requires
> >>> a
> >>>> priori knowledge inside the OS that a certain 'generic' device
> must
> >>> be
> >>>> driven in a special way.
> >>>>
> >>>> So can anyone comment on the feasibility of adding support for
> >>> devices
> >>>> with vendor specific HIDs (and no generic CIDs) to the current
> ACPI
> >>>> ECAM driver in Linux?
> >
> > I don't think of ECAM support itself as a "driver".  It's just a
> > service available to drivers, similar to OF resource parsing.
> >
> > Per PCI Firmware r3.2, sec 4.1.5, "PNP0A03" means a PCI/PCI-X/PCIe
> > host bridge.  "PNP0A08" means a PCI-X Mode 2 or PCIe bridge that
> > supports extended config space.  It doesn't specify how we access
> that
> > config space, so I think hardware with non-standard ECAM should still
> > have PNP0A03 and PNP0A08 in _CID or _HID.
> >
> > "ECAM" as used in the specs (PCIe r3.0, sec 7.2.2, and PCI Firmware
> > r3.2, sec 4.1) means:
> >
> >  (a) a memory-mapped model for config space access, and
> >  (b) a specific mapping of address bits to bus/device/function/
> >      register
> >
> > MCFG and _CBA assume both (a) and (b), so I think a device with
> > non-standard ECAM mappings should not be described in MCFG or _CBA.
> >
> > If a bridge has ECAM with non-standard mappings, I think either a
> > vendor-specific _HID or a device-specific method, e.g., _DSM, could
> > communicate that.
> >
> > Jon, I agree that we should avoid describing non-standardized
> hardware
> > in Linux-specific ways.  Is there a mechanism in use already?  How
> > does Windows handle this?  DMI is a poor long-term solution because
> it
> > requires ongoing maintenance for new platforms, but I think it's OK
> > for getting started with platforms already shipping.
> >
> > A _DSM has the advantage that once it is defined and supported, OEMs
> > can ship new platforms without requiring a new quirk or a new _HID to
> > be added to a driver.
> >
> > There would still be the problem of config access before the
> namespace
> > is available, i.e., the MCFG use case.  I don't know how important
> > that is.  Defining an MCFG extension seems like the most obvious
> > solution.
> >
> > If we only expect a few non-standard devices, maybe it's enough to
> > have DMI quirks to statically set up ECAM and just live with the
> > inconvenience of requiring a kernel change for every new non-standard
> > device.
> >
> >>> Host bridges in ACPI are handled through PNP0A08/PNP0A03 ids, and
> >>> most of the arch specific code is handled in the respective arch
> >>> directories (X86 and IA64, even though IA64 does not rely on
> ECAM/MCFG
> >>> for
> >>> PCI ops), it is not a driver per-se, PNP0A08/PNP0A03 are detected
> >>> through
> >>> ACPI scan handlers and the respective arch code (ie
> pci_acpi_scan_root)
> >>> sets-up resources AND config space on an arch specific basis.
> >>>
> >>> X86 deals with that with code in arch/x86 that sets-up the
> pci_raw_ops
> >>> on a platform specific basis (and it is not nice, but it works
> because
> >>> as you all know the number of platforms in X86 world is contained).
> >>>
> >>> Will this happen for ARM64 in arch/arm64 based on vendor specific
> >>> HIDs ?
> >>>
> >>> No.
> >>>
> >>> So given the current state of play (we were requested to move the
> >>> arch/arm64 specific ACPI PCI bits to arch/arm64), we would end up
> >>> with arch/arm64 code requiring code in /drivers to set-up pci_ops
> >>> in a platform specific way, it is horrible, if feasible at all.
> >>>
> >>> The only way this can be implemented is by pretending that the
> >>> ACPI/PCI arch/arm64 implementation is generic code (that's what
> this
> >>> series does), move it to /drivers (where it is in this series), and
> >>> implement _DSD vendor specific bindings (per HID) to set-up the pci
> >>> operations; whether this solution should go upstream, given that it
> >>> is just a short-term solution for early platforms bugs, it is
> another
> >>> story and my personal answer is no.
> >
> > It seems like there should be a way to look for a _DSM before we call
> > acpi_pci_root_get_mcfg_addr() to look for _CBA.
> >
> > Currently we call acpi_pci_root_get_mcfg_addr() (to read _CBA) from
> > the generic acpi_pci_root_add(), but the result (root->mcfg_addr) is
> > only used in x86-specific code.  I think it would be nicer if the
> > lookup and the use were together.  Then it would be easier to
> override
> > it because the mapping assumptions would all be in one place.
> >
> >> I think it shouldn't be too bad to move quirk handling mechanism to
> >> arch/arm64. Effectively we would not move platform specific code
> into
> >> arch/arm64 but just the mechanism checking if there is any quirk
> that
> >> is defined.
> >>
> >> i.e.:
> >>
> >> extern struct pci_cfg_fixup __start_acpi_mcfg_fixups[];
> >> extern struct pci_cfg_fixup __end_acpi_mcfg_fixups[];
> >>
> >> static struct pci_ecam_ops *pci_acpi_get_ops(struct acpi_pci_root
> *root)
> >> {
> >>        int bus_num =3D root->secondary.start;
> >>        int domain =3D root->segment;
> >>        struct pci_cfg_fixup *f;
> >>
> >>        /*
> >>         * Match against platform specific quirks and return
> corresponding
> >>         * CAM ops.
> >>         *
> >>         * First match against PCI topology <domain:bus> then use DMI
> or
> >>         * custom match handler.
> >>         */
> >>        for (f =3D __start_acpi_mcfg_fixups; f <
> __end_acpi_mcfg_fixups; f++) {
> >>                if ((f->domain =3D=3D domain || f->domain =3D=3D
> PCI_MCFG_DOMAIN_ANY) &&
> >>                    (f->bus_num =3D=3D bus_num || f->bus_num =3D=3D
> PCI_MCFG_BUS_ANY) &&
> >>                    (f->system ? dmi_check_system(f->system) : 1) &&
> >>                    (f->match ? f->match(f, root) : 1))
> >>                        return f->ops;
> >>        }
> >>        /* No quirks, use ECAM */
> >>        return &pci_generic_ecam_ops;
> >> }
> >>
> >> Such quirks will be defined anyway in drivers/pci/host/ in the
> vendor
> >> specific quirk implementations.
> >>
> >> e.g. in HiSilicon case we would have
> >>
> >> DECLARE_ACPI_MCFG_FIXUP(NULL, hisi_pcie_match, &hisi_pcie_ecam_ops,
> >>            PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
> >>
> >> in "drivers/pci/host/pcie-hisi-acpi.c "
> >>
> >> Thanks
> >>
> >> Gab
> >
> > Sorry Gab, I guess I was really responding to earlier messages :)
> >
> > I don't really have much to say here, except that it doesn't seem
> > right to have an MCFG that describes a non-standard ECAM mapping.
> > I suppose there's already firmware in the field that does that,
> > though?
> >
> > Bjorn
