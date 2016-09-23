Return-Path: <gabriele.paoloni@huawei.com>
Return-Path: <gabriele.paoloni@huawei.com>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas
	<helgaas@kernel.org>
CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tomasz Nowicki
	<tn@semihalf.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Will Deacon
	<will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael
 Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Hanjun Guo
	<hanjun.guo@linaro.org>, Sinan Kaya <okaya@codeaurora.org>,
        Jayachandran C
	<jchandra@broadcom.com>,
        Christopher Covington <cov@codeaurora.org>, Duc Dang
	<dhdang@apm.com>,
        Robert Richter <robert.richter@caviumnetworks.com>,
        "Marcin Wojtas" <mw@semihalf.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Wangyijing <wangyijing@huawei.com>, Mark Salter <msalter@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        Linaro ACPI Mailman List
	<linaro-acpi@lists.linaro.org>,
        Jon Masters <jcm@redhat.com>, Andrea Gallo
	<andrea.gallo@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        Jeff Hugo
	<jhugo@codeaurora.org>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Subject: RE: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe PEM-specific
 register range for ACPI case
Date: Fri, 23 Sep 2016 10:58:28 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F884340@lhreml507-mbx>
References: <20160920140518.GD13855@localhost>
 <CAKv+Gu-j-gKiNMx-TvSxezJth1619FN8W1rAy7DKpkmfX9ii6A@mail.gmail.com>
 <20160920191744.GA4941@localhost> <20160921140549.GA11968@red-moon>
 <20160921180457.GB20006@localhost> <20160922094955.GB18637@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8815A9@lhreml507-mbx>
 <20160922124446.GA21681@red-moon> <20160922183101.GA14510@localhost>
 <20160922221042.GA1514@localhost> <20160923101145.GA31120@red-moon>
In-Reply-To: <20160923101145.GA31120@red-moon>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Lorenzo Pieralisi
> Sent: 23 September 2016 11:12
> To: Bjorn Helgaas
> Cc: Gabriele Paoloni; Ard Biesheuvel; Tomasz Nowicki; David Daney; Will
> Deacon; Catalin Marinas; Rafael Wysocki; Arnd Bergmann; Hanjun Guo;
> Sinan Kaya; Jayachandran C; Christopher Covington; Duc Dang; Robert
> Richter; Marcin Wojtas; Liviu Dudau; Wangyijing; Mark Salter; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Linaro ACPI
> Mailman List; Jon Masters; Andrea Gallo; Jeremy Linton; liudongdong
> (C); Jeff Hugo; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Rafael J. Wysocki; rui.zhang@intel.com
> Subject: Re: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe PEM-
> specific register range for ACPI case
>=20
> [+ Zhang Rui]
>=20
> On Thu, Sep 22, 2016 at 05:10:42PM -0500, Bjorn Helgaas wrote:
> > On Thu, Sep 22, 2016 at 01:31:01PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Sep 22, 2016 at 01:44:46PM +0100, Lorenzo Pieralisi wrote:
> > > > On Thu, Sep 22, 2016 at 11:10:13AM +0000, Gabriele Paoloni wrote:
> > > > > Hi Lorenzo, Bjorn
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> > > > > > Sent: 22 September 2016 10:50
> > > > > > To: Bjorn Helgaas
> > > > > > Cc: Ard Biesheuvel; Tomasz Nowicki; David Daney; Will Deacon;
> Catalin
> > > > > > Marinas; Rafael Wysocki; Arnd Bergmann; Hanjun Guo; Sinan
> Kaya;
> > > > > > Jayachandran C; Christopher Covington; Duc Dang; Robert
> Richter; Marcin
> > > > > > Wojtas; Liviu Dudau; Wangyijing; Mark Salter; linux-
> > > > > > pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Linaro ACPI
> > > > > > Mailman List; Jon Masters; Andrea Gallo; Jeremy Linton;
> liudongdong
> > > > > > (C); Gabriele Paoloni; Jeff Hugo; linux-acpi@vger.kernel.org;
> linux-
> > > > > > kernel@vger.kernel.org; Rafael J. Wysocki
> > > > > > Subject: Re: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe
> PEM-
> > > > > > specific register range for ACPI case
> > > > > >
> > > > > > On Wed, Sep 21, 2016 at 01:04:57PM -0500, Bjorn Helgaas
> wrote:
> > > > > > > On Wed, Sep 21, 2016 at 03:05:49PM +0100, Lorenzo Pieralisi
> wrote:
> > > > > > > > On Tue, Sep 20, 2016 at 02:17:44PM -0500, Bjorn Helgaas
> wrote:
> > > > > > > > > On Tue, Sep 20, 2016 at 04:09:25PM +0100, Ard
> Biesheuvel wrote:
> > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > > > > None of these platforms can be fixed entirely in
> software, and
> > > > > > given
> > > > > > > > > > that we will not be adding quirks for new broken
> hardware, we
> > > > > > should
> > > > > > > > > > ask ourselves whether having two versions of a quirk,
> i.e., one
> > > > > > for
> > > > > > > > > > broken hardware + currently shipping firmware, and
> one for the
> > > > > > same
> > > > > > > > > > broken hardware with fixed firmware is really an
> improvement
> > > > > > over what
> > > > > > > > > > has been proposed here.
> > > > > > > > >
> > > > > > > > > We're talking about two completely different types of
> quirks:
> > > > > > > > >
> > > > > > > > >   1) MCFG quirks to use memory-mapped config space that
> doesn't
> > > > > > quite
> > > > > > > > >      conform to the ECAM model in the PCIe spec, and
> > > > > > > > >
> > > > > > > > >   2) Some yet-to-be-determined method to describe
> address space
> > > > > > > > >      consumed by a bridge.
> > > > > > > > >
> > > > > > > > > The first two patches of this series are a nice
> implementation
> > > > > > for 1).
> > > > > > > > > The third patch (ThunderX-specific) is one possibility
> for 2),
> > > > > > but I
> > > > > > > > > don't like it because there's no way for generic
> software like
> > > > > > the
> > > > > > > > > ACPI core to discover these resources.
> > > > > > > >
> > > > > > > > Ok, so basically this means that to implement (2) we need
> to assign
> > > > > > > > some sort of _HID to these quirky PCI bridges (so that we
> know what
> > > > > > > > device they represent and we can retrieve their _CRS). I
> take from
> > > > > > > > this discussion that the goal is to make sure that all
> non-config
> > > > > > > > resources have to be declared through _CRS device
> objects, which is
> > > > > > > > fine but that requires a FW update (unless we can
> fabricate ACPI
> > > > > > > > devices and corresponding _CRS in the kernel whenever we
> match a
> > > > > > > > given MCFG table signature).
> > > > > > >
> > > > > > > All resources consumed by ACPI devices should be declared
> through
> > > > > > > _CRS.  If you want to fabricate ACPI devices or _CRS via
> kernel
> > > > > > > quirks, that's fine with me.  This could be triggered via
> MCFG
> > > > > > > signature, DMI info, host bridge _HID, etc.
> > > > > >
> > > > > > I think the PNP quirk approach + PNP0c02 resource put forward
> by Gab
> > > > > > is enough.
> > > > >
> > > > > Great thanks as we take a final decision I will ask Dogndgong
> to submit
> > > > > another RFC based on this approach
> > > > >
> > > > > >
> > > > > > > > We discussed this already and I think we should make a
> decision:
> > > > > > > >
> > > > > > > > http://lists.infradead.org/pipermail/linux-arm-
> kernel/2016-
> > > > > > March/414722.html
> > > > > > > >
> > > > > > > > > > > I'd like to step back and come up with some
> understanding of
> > > > > > how
> > > > > > > > > > > non-broken firmware *should* deal with this issue.
> Then, if
> > > > > > we *do*
> > > > > > > > > > > work around this particular broken firmware in the
> kernel, it
> > > > > > would be
> > > > > > > > > > > nice to do it in a way that fits in with that
> understanding.
> > > > > > > > > > >
> > > > > > > > > > > For example, if a companion ACPI device is the
> preferred
> > > > > > solution, an
> > > > > > > > > > > ACPI quirk could fabricate a device with the
> required
> > > > > > resources.  That
> > > > > > > > > > > would address the problem closer to the source and
> make it
> > > > > > more likely
> > > > > > > > > > > that the rest of the system will work correctly:
> /proc/iomem
> > > > > > could
> > > > > > > > > > > make sense, things that look at _CRS generically
> would work
> > > > > > (e.g,
> > > > > > > > > > > /sys/, an admittedly hypothetical "lsacpi", etc.)
> > > > > > > > > > >
> > > > > > > > > > > Hard-coding stuff in drivers is a point solution
> that doesn't
> > > > > > provide
> > > > > > > > > > > any guidance for future platforms and makes it
> likely that
> > > > > > the hack
> > > > > > > > > > > will get copied into even more drivers.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > OK, I see. But the guidance for future platforms
> should be 'do
> > > > > > not
> > > > > > > > > > rely on quirks', and what I am arguing here is that
> the more we
> > > > > > polish
> > > > > > > > > > up this code and make it clean and reusable, the more
> likely it
> > > > > > is
> > > > > > > > > > that will end up getting abused by new broken
> hardware that we
> > > > > > set out
> > > > > > > > > > to reject entirely in the first place.
> > > > > > > > > >
> > > > > > > > > > So of course, if the quirk involves claiming
> resources, let's
> > > > > > make
> > > > > > > > > > sure that this occurs in the cleanest and most
> compliant way
> > > > > > possible.
> > > > > > > > > > But any factoring/reuse concerns other than for the
> current
> > > > > > crop of
> > > > > > > > > > broken hardware should be avoided imo.
> > > > > > > > >
> > > > > > > > > If future hardware is completely ECAM-compliant and we
> don't need
> > > > > > any
> > > > > > > > > more MCFG quirks, that would be great.
> > > > > > > >
> > > > > > > > Yes.
> > > > > > > >
> > > > > > > > > But we'll still need to describe that memory-mapped
> config space
> > > > > > > > > somewhere.  If that's done with PNP0C02 or similar
> devices (as is
> > > > > > done
> > > > > > > > > on my x86 laptop), we'd be all set.
> > > > > > > >
> > > > > > > > I am not sure I understand what you mean here. Are you
> referring
> > > > > > > > to MCFG regions reported as PNP0c02 resources through its
> _CRS ?
> > > > > > >
> > > > > > > Yes.  PCI Firmware Spec r3.0, Table 4-2, note 2 says
> address ranges
> > > > > > > reported via MCFG or _CBA should be reserved by _CRS of a
> PNP0C02
> > > > > > > device.
> > > > > >
> > > > > > Ok, that's agreed. It goes without saying that since you are
> quoting
> > > > > > the PCI spec, if FW fails to report MCFG regions in a PNP0c02
> device
> > > > > > _CRS I will consider that a FW bug.
> > > > > >
> > > > > > > > IIUC PNP0C02 is a reservation mechanism, but it does not
> help us
> > > > > > > > associate its _CRS to a specific PCI host bridge
> instance, right ?
> > > > > > >
> > > > > > > Gab proposed a hierarchy that *would* associate a PNP0C02
> device with
> > > > > > > a PCI bridge:
> > > > > > >
> > > > > > >   Device (PCI1) {
> > > > > > >     Name (_HID, "HISI0080") // PCI Express Root Bridge
> > > > > > >     Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
> > > > > > >     Method (_CRS, 0, Serialized) { // Root complex
> resources
> > > > > > (windows) }
> > > > > > >     Device (RES0) {
> > > > > > >       Name (_HID, "HISI0081") // HiSi PCIe RC config base
> address
> > > > > > >       Name (_CID, "PNP0C02")  // Motherboard reserved
> resource
> > > > > > >       Name (_CRS, ResourceTemplate () { ... }
> > > > > > >     }
> > > > > > >   }
> > > > > > >
> > > > > > > That's a possibility.  The PCI Firmware Spec suggests
> putting RES0 at
> > > > > > > the root (under \_SB), but I don't know why.
> > > > > > >
> > > > > > > Putting it at the root means we couldn't generically
> associate it
> > > > > > with
> > > > > > > a bridge, although I could imagine something like this:
> > > > > > >
> > > > > > >   Device (RES1) {
> > > > > > >     Name (_HID, "HISI0081") // HiSi PCIe RC config base
> address
> > > > > > >     Name (_CID, "PNP0C02")  // Motherboard reserved
> resource
> > > > > > >     Name (_CRS, ResourceTemplate () { ... }
> > > > > > >     Method (BRDG) { "PCI1" }  // hand-wavy ASL
> > > > > > >   }
> > > > > > >   Device (PCI1) {
> > > > > > >     Name (_HID, "HISI0080") // PCI Express Root Bridge
> > > > > > >     Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
> > > > > > >     Method (_CRS, 0, Serialized) { // Root complex
> resources
> > > > > > (windows) }
> > > > > > >   }
> > > > > > >
> > > > > > > Where you could search PNP0C02 devices for a cookie that
> matched the
> > > > > > > host bridge.o
> > > > > >
> > > > > > Ok, I am fine with both and I think we are converging, but
> the way
> > > > > > to solve this problem has to be uniform for all ARM partners
> (and
> > > > > > not only ARM). Two points here:
> > > > > >
> > > > > > 1) Adding a device/subdevice allows people to add a _CRS
> reporting the
> > > > > >    non-window bridge resources. Fine. It also allows people
> to chuck in
> > > > > >    there all sorts of _DSD properties to describe their PCI
> host bridge
> > > > > >    as it is done with DT properties (those _DSD can contain
> eg clocks
> > > > > >    etc.), this may be tempting (so that they can reuse the
> same DT
> > > > > >    driver and do not have to update their firmware) but I
> want to be
> > > > > >    clear here: that must not happen. So, a subdevice with a
> _CRS to
> > > > > >    report resources, yes, but it will stop there.
> > > > > > 2) It is unclear to me how to formalize the above. People
> should not
> > > > > >    write FW by reading the PCI mailing list, so these
> guidelines have
> > > > > > to
> > > > > >    be written, somehow. I do not want to standardize quirks,
> I want
> > > > > >    to prevent random ACPI table content, which is different.
> > > > > >    Should I report this to the ACPI spec working group ? If
> we do
> > > > > >    not do that everyone will go solve this problem as they
> deem fit.
> > > > > >
> > > > >
> > > > > Do we really need to formalize this?
> > > > >
> > > > > As we discussed in the Linaro call at the moment we have few
> vendors
> > > > > that need quirks and we want to avoid promoting/accepting
> quirks for
> > > > > the future.
> > > > >
> > > > > At the time of the call I think we decided to informally accept
> a set
> > > > > of quirks for the current platforms and reject any other quirk
> coming
> > > > > after a certain date/kernel version (this to be decided).
> > > > >
> > > > > I am not sure if there is a way to document/formalize a
> temporary
> > > > > exception from the rule...
> > > >
> > > > - (1) will be enforced.
> > >
> > > I'm not sure it's necessary or possible to enforce a "no future
> > > quirks" rule.  For one thing, there's already a pretty strong
> > > incentive to avoid quirks: if your hardware doesn't require quirks,
> > > it works with OSes already in the field.
> > >
> > > MCFG quirks allow us to use the generic ACPI pci_root.c driver even
> if
> > > the hardware doesn't support ECAM quite according to the spec.
> > >
> > > PNP0C02 usage is a workaround for the failure of the
> Consumer/Producer
> > > bit.  PNP0C02 quirks compensate for firmware that doesn't describe
> > > resource usage accurately.  It's possible the ACPI spec folks could
> > > come up with a better Consumer/Producer workaround, if that's
> needed.
> > > Apparently x86 hasn't needed it yet.
> > >
> > > If people add _DSD methods for clocks or whatnot, the hardware
> won't
> > > work with the generic pci_root.c driver, so there's already an
> > > incentive for avoiding them.  x86 has managed without such methods;
> > > arm64 should be able to do the same.
> >
> > Re-reading this, I'm afraid my response sounds a little dismissive,
> > and I feel like I'm missing some important information.  So I
> > apologize if I missed your whole point, Lorenzo.
>=20
> No you are spot on, I just wanted to emphasize, given that we are
> adding an _HID and a subdevice, that developer should not be tempted
> to use it to match against a PCI host driver to reuse the DT code,
> we should not use the quirk mechanism as a backdoor to re-using DT
> drivers in ACPI context.
>=20
> Anyway, there is a review process to spot these possible misuses,
> mine was just a heads-up, quirks will happen, I just do not want
> to wreak the standard ACPI PCI firmware model to support them.
>=20
> Given that there are already PNP0c02 bindings out there where the
> PNP0c02 is used as in Gab's example:
>=20
> https://patchwork.kernel.org/patch/4757111/
>=20
> I think the only pending question I have is whether we are allowed
> to define a PNP0A03 subdevice with a _CRS resource space that is
> not contained in its parent _CRS, if we answer this question I
> think we are done.

FMU part of your question is answered in the PCI Firmware specs
https://members.pcisig.com/wg/PCI-SIG/document/download/8232

Where from note 2 of 4.1.2 I quote:=20
"For most systems, the motherboard resource would appear at the root
of the ACPI namespace (under \_SB) in a node with a _HID of EISAID=20
(PNP0C02), and the resources in this case should not be claimed in the
root PCI bus's _CRS"

My interpretation is that the resource claimed in the PNP0C02 node
must never be in the PNP0A03 _CRS.

Now about having the PNP0C02 node under \_SB or as a sub-device we see
that the note above points out that most of system have it under \_SB
but I read it as a quite relaxed condition....

BTW this is just my interpretation...

Thanks

Gab=20


>=20
> I will raise the PNP0c02 usage issue with the ASWG anyway.
>=20
> Thanks !
> Lorenzo
