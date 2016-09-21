Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 21 Sep 2016 13:04:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe PEM-specific
 register range for ACPI case
Message-ID: <20160921180457.GB20006@localhost>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <1473449047-10499-4-git-send-email-tn@semihalf.com>
 <20160919180900.GB13775@localhost>
 <49f53bfc-4421-a8b0-694c-bce7e61e1c9e@semihalf.com>
 <20160920133327.GB13855@localhost>
 <CAKv+Gu-AE7fft_j2cqBCN=xrsf5Yh=mePf5x3dZJuKAmdxF-Gg@mail.gmail.com>
 <20160920140518.GD13855@localhost>
 <CAKv+Gu-j-gKiNMx-TvSxezJth1619FN8W1rAy7DKpkmfX9ii6A@mail.gmail.com>
 <20160920191744.GA4941@localhost> <20160921140549.GA11968@red-moon>
MIME-Version: 1.0
In-Reply-To: <20160921140549.GA11968@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Rafael Wysocki <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, Sinan Kaya <okaya@codeaurora.org>,
 Yijing Wang <wangyijing@huawei.com>, Andrea Gallo <andrea.gallo@linaro.org>,
 Jeff Hugo <jhugo@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>,
 Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
 David Daney <ddaney@caviumnetworks.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Robert Richter <robert.richter@caviumnetworks.com>,
 Dongdong Liu <liudongdong3@huawei.com>, Mark Salter <msalter@redhat.com>,
 Liviu Dudau <Liviu.Dudau@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Jon Masters <jcm@redhat.com>, Christopher Covington <cov@codeaurora.org>,
 Marcin Wojtas <mw@semihalf.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jayachandran C <jchandra@broadcom.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Duc Dang <dhdang@apm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 21, 2016 at 03:05:49PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Sep 20, 2016 at 02:17:44PM -0500, Bjorn Helgaas wrote:
> > On Tue, Sep 20, 2016 at 04:09:25PM +0100, Ard Biesheuvel wrote:
> 
> [...]
> 
> > > None of these platforms can be fixed entirely in software, and given
> > > that we will not be adding quirks for new broken hardware, we should
> > > ask ourselves whether having two versions of a quirk, i.e., one for
> > > broken hardware + currently shipping firmware, and one for the same
> > > broken hardware with fixed firmware is really an improvement over what
> > > has been proposed here.
> > 
> > We're talking about two completely different types of quirks:
> > 
> >   1) MCFG quirks to use memory-mapped config space that doesn't quite
> >      conform to the ECAM model in the PCIe spec, and
> > 
> >   2) Some yet-to-be-determined method to describe address space
> >      consumed by a bridge.
> > 
> > The first two patches of this series are a nice implementation for 1).
> > The third patch (ThunderX-specific) is one possibility for 2), but I
> > don't like it because there's no way for generic software like the
> > ACPI core to discover these resources.
> 
> Ok, so basically this means that to implement (2) we need to assign
> some sort of _HID to these quirky PCI bridges (so that we know what
> device they represent and we can retrieve their _CRS). I take from
> this discussion that the goal is to make sure that all non-config
> resources have to be declared through _CRS device objects, which is
> fine but that requires a FW update (unless we can fabricate ACPI
> devices and corresponding _CRS in the kernel whenever we match a
> given MCFG table signature).

All resources consumed by ACPI devices should be declared through
_CRS.  If you want to fabricate ACPI devices or _CRS via kernel
quirks, that's fine with me.  This could be triggered via MCFG
signature, DMI info, host bridge _HID, etc.

> We discussed this already and I think we should make a decision:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/414722.html
> 
> > > > I'd like to step back and come up with some understanding of how
> > > > non-broken firmware *should* deal with this issue.  Then, if we *do*
> > > > work around this particular broken firmware in the kernel, it would be
> > > > nice to do it in a way that fits in with that understanding.
> > > >
> > > > For example, if a companion ACPI device is the preferred solution, an
> > > > ACPI quirk could fabricate a device with the required resources.  That
> > > > would address the problem closer to the source and make it more likely
> > > > that the rest of the system will work correctly: /proc/iomem could
> > > > make sense, things that look at _CRS generically would work (e.g,
> > > > /sys/, an admittedly hypothetical "lsacpi", etc.)
> > > >
> > > > Hard-coding stuff in drivers is a point solution that doesn't provide
> > > > any guidance for future platforms and makes it likely that the hack
> > > > will get copied into even more drivers.
> > > >
> > > 
> > > OK, I see. But the guidance for future platforms should be 'do not
> > > rely on quirks', and what I am arguing here is that the more we polish
> > > up this code and make it clean and reusable, the more likely it is
> > > that will end up getting abused by new broken hardware that we set out
> > > to reject entirely in the first place.
> > > 
> > > So of course, if the quirk involves claiming resources, let's make
> > > sure that this occurs in the cleanest and most compliant way possible.
> > > But any factoring/reuse concerns other than for the current crop of
> > > broken hardware should be avoided imo.
> > 
> > If future hardware is completely ECAM-compliant and we don't need any
> > more MCFG quirks, that would be great.
> 
> Yes.
> 
> > But we'll still need to describe that memory-mapped config space
> > somewhere.  If that's done with PNP0C02 or similar devices (as is done
> > on my x86 laptop), we'd be all set.
> 
> I am not sure I understand what you mean here. Are you referring
> to MCFG regions reported as PNP0c02 resources through its _CRS ?

Yes.  PCI Firmware Spec r3.0, Table 4-2, note 2 says address ranges
reported via MCFG or _CBA should be reserved by _CRS of a PNP0C02
device.

> IIUC PNP0C02 is a reservation mechanism, but it does not help us
> associate its _CRS to a specific PCI host bridge instance, right ?

Gab proposed a hierarchy that *would* associate a PNP0C02 device with
a PCI bridge:

  Device (PCI1) {
    Name (_HID, "HISI0080") // PCI Express Root Bridge
    Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
    Method (_CRS, 0, Serialized) { // Root complex resources (windows) }
    Device (RES0) {
      Name (_HID, "HISI0081") // HiSi PCIe RC config base address
      Name (_CID, "PNP0C02")  // Motherboard reserved resource
      Name (_CRS, ResourceTemplate () { ... }
    }
  }

That's a possibility.  The PCI Firmware Spec suggests putting RES0 at
the root (under \_SB), but I don't know why.

Putting it at the root means we couldn't generically associate it with
a bridge, although I could imagine something like this:

  Device (RES1) {
    Name (_HID, "HISI0081") // HiSi PCIe RC config base address
    Name (_CID, "PNP0C02")  // Motherboard reserved resource
    Name (_CRS, ResourceTemplate () { ... }
    Method (BRDG) { "PCI1" }  // hand-wavy ASL
  }
  Device (PCI1) {
    Name (_HID, "HISI0080") // PCI Express Root Bridge
    Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
    Method (_CRS, 0, Serialized) { // Root complex resources (windows) }
  }

Where you could search PNP0C02 devices for a cookie that matched the
host bridge.

> > If we need to work around firmware in the field that doesn't do that,
> > one possibility is a PNP quirk along the lines of
> > quirk_amd_mmconfig_area().
> 
> You mean matching PNP0C01/PNP0c02 and create a resource (that has to
> hardcoded in a static array in the kernel anyway, there is no way to
> retrieve it otherwise) in the corresponding PNP quirk handler ?

Right.  On some hardware we can read the resource out of a
device-specific register, as we do in quirk_intel_mch().  But if
that's not possible, it would have to be hard-coded.

> And it is not a given we can match against PNP0c01/PNP0c02.
> 
> So it looks like the only solution is allocating an _HID for each
> host bridge that is not ECAM compliant to add resources to its _CRS
> (unless the MCFG quirk does not need any additional data/resource,
> eg "use different set of PCI accessorsi 32-bit vs byte-access").

It doesn't matter whether it's ECAM-compliant or not.  Any
memory-mapped config space should be reported via some device's _CRS.

The existing x86 practice is to use PNP0C02 devices for this purpose,
and I think we should just follow that practice.

> For FW that is immutable I really do not see what we can do apart
> from hardcoding the non-config resources (consumed by a bridge),
> somehow.

Right.  Well, I assume you mean we should hard-code "non-window
resources consumed directly by a bridge".  If firmware in the field is
broken, we should work around it, and that may mean hard-coding some
resources.

My point is that the hard-coding should not be buried in a driver
where it's invisible to the rest of the kernel.  If we hard-code it in
a quirk that adds _CRS entries, then the kernel will work just like it
would if the firmware had been correct in the first place.  The
resource will appear in /sys/devices/pnp*/*/resources and /proc/iomem,
and if we ever used _SRS to assign or move ACPI devices, we would know
to avoid the bridge resource.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
