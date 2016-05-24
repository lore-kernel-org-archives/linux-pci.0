Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 24 May 2016 14:00:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
Message-ID: <20160524190048.GA4288@localhost>
References: <3d4aae09-51c4-f007-5100-191a4a85e27a@redhat.com>
 <CAKv+Gu8fdeJ9OvRSmtu9zyvcjK3O-4WU=jG=6-7t4xZwvV8d2g@mail.gmail.com>
 <95b1d06e-f9c5-39f3-1003-f536b65eef60@redhat.com>
 <CAKv+Gu-_xp_t_Ze3Pw_-82-fmy=tCy-h=4FbP98eLbuXVk2hHQ@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EDAF6AC@lhreml503-mbs>
 <CAKv+Gu_zpoFsDr7e8zPCDKPpRdKDVH+vnC0nfvmGaJ7xcP3Zng@mail.gmail.com>
 <20160523105655.GA22902@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EDB35A5@lhreml503-mbs>
 <20160523233918.GA32555@localhost>
 <20160524172423.GA15855@red-moon>
MIME-Version: 1.0
In-Reply-To: <20160524172423.GA15855@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 Wangyijing <wangyijing@huawei.com>,
 "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>,
 Tomasz Nowicki <tn@semihalf.com>,
 "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
 "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "msalter@redhat.com" <msalter@redhat.com>,
 "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "mw@semihalf.com" <mw@semihalf.com>, Jon Masters <jcm@redhat.com>,
 "jchandra@broadcom.com" <jchandra@broadcom.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, "dhdang@apm.com" <dhdang@apm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 24, 2016 at 06:24:23PM +0100, Lorenzo Pieralisi wrote:
> Hi Bjorn,
> 
> On Mon, May 23, 2016 at 06:39:18PM -0500, Bjorn Helgaas wrote:
> 
> [...]
> 
> > On Mon, May 23, 2016 at 03:16:01PM +0000, Gabriele Paoloni wrote:
> > I don't think of ECAM support itself as a "driver".  It's just a
> > service available to drivers, similar to OF resource parsing.
> > 
> > Per PCI Firmware r3.2, sec 4.1.5, "PNP0A03" means a PCI/PCI-X/PCIe
> > host bridge.  "PNP0A08" means a PCI-X Mode 2 or PCIe bridge that
> > supports extended config space.  It doesn't specify how we access that
> > config space, so I think hardware with non-standard ECAM should still
> > have PNP0A03 and PNP0A08 in _CID or _HID.
> > 
> > "ECAM" as used in the specs (PCIe r3.0, sec 7.2.2, and PCI Firmware
> > r3.2, sec 4.1) means:
> > 
> >   (a) a memory-mapped model for config space access, and
> >   (b) a specific mapping of address bits to bus/device/function/
> >       register
> > 
> > MCFG and _CBA assume both (a) and (b), so I think a device with
> > non-standard ECAM mappings should not be described in MCFG or _CBA.
> > 
> > If a bridge has ECAM with non-standard mappings, I think either a
> > vendor-specific _HID or a device-specific method, e.g., _DSM, could
> > communicate that.
> > 
> > Jon, I agree that we should avoid describing non-standardized hardware
> > in Linux-specific ways.  Is there a mechanism in use already?  How
> > does Windows handle this?  DMI is a poor long-term solution because it
> > requires ongoing maintenance for new platforms, but I think it's OK
> > for getting started with platforms already shipping.
> > 
> > A _DSM has the advantage that once it is defined and supported, OEMs
> > can ship new platforms without requiring a new quirk or a new _HID to
> > be added to a driver.
> > 
> > There would still be the problem of config access before the namespace
> > is available, i.e., the MCFG use case.  I don't know how important
> > that is.  Defining an MCFG extension seems like the most obvious
> > solution.
> 
> Your summary above is a perfect representation of the situation.
> 
> We had an opportunity to sync-up on the current status of ACPI PCI
> for ARM64 (and talked about a way forward for this series, which
> includes quirks handling), let me summarize it here for everyone
> involved so that we can agree on a way forward.
> 
> 1) ACPI PCI support for PNP0A03/PNP0A08 host bridges on top of MCFG
>    ECAM for config space is basically ready (Tomasz and JC addressed
>    Rafael's concerns in relation to ARM64 specific code, and managed
>    to find a way to allocate domain numbers in preparation for Arnd
>    pci_create_root_bus() clean-up, v8 to be posted shortly and should
>    be final). This provides support for de-facto ACPI/PCI ECAM base
>    standard for ARM64 (with a clean-split between generic code and ARM64
>    bits, where ARM64, like X86 and IA64, manages in arch code IO space and
>    PCI resources, to be further consolidated in the near future).
>    I do not think anyone can complain about the generality of what we
>    achieved, for systems that are PCI standard (yes, PCI STANDARD) this
>    would just be sufficient.

Sounds good to me.

> 2) In a real world (1) is not enough. Some ARM64 platforms, not entirely
>    ECAM compliant, already shipped with the corresponding firmware that
>    we can't update. HW has ECAM quirks and to work around it in the kernel
>    we put forward many solutions to the problem, it is time we found a
>    solution (when, of course, (1) is completed and upstream).
>    Using the MCFG table OEMID matching floated around in this thread
>    would work fine for most of the platforms (and cross-OS) that have
>    shipped with HW ECAM quirks, so I think that's the starting point for
>    our solution and that's how we can sort this out, _today_.
> 
>    The solution is a trivial look-up table:
>    MCFG OEMID <-> PCI config space ops

Sounds reasonable to me.

> 3) (2) does not just work on some platforms (and we can't predict the
>    future either - actually I can, it is three letters, ECAM), simply
>    because MCFG OEMID matching does not provide a way to attach further
>    data to the MCFG (eg if config space for, say, bus 0 domain 0, is not
>    ECAM compliant, the config region can't be handled and must not be
>    handled through a corresponding MCFG region.

Couldn't this be handled by custom pci_ops that do something special
for bus 0 domain 0, and default to some different pci_ops for the
rest?

>    That's the problem Gabriele is facing and wants to solve through
>    something like:
> 
>    https://lkml.org/lkml/2016/3/9/91
> 
>    in the respective ACPI tables-bindings. It may be an idea worth
>    pursuing, it does not solve (2) simply because that FW has shipped,
>    we can't patch it any longer.

(2) is for quirks to deal with MCFG.  Gabriele's post is a proposal
for ACPI namespace.  We can't use anything in the namespace to
implement MCFG quirks because MCFG is needed before the namespace is
available.

I think Gabriele's post is a good proposal for the namespace, but I
would propose the following modifications:

  - Add PNP0A08 to the PCI1 _CID since this is a PCIe host bridge
  - Add a PCI1 _DSM describing the ECAM space
  - Remove the HISI0081 _HID

The result would be:

  Device (PCI1) {
    Name(_HID, "HISI0080")
    Name(_CID, "PNP0A03,PNP0A08")
    Method(_CRS) { ... }
    Method(_DSM) { <describe ECAM base and mapping function> }
  }
  Device (RES0) {
    Name(_HID, "PNP0C02")
    Name(_CRS) { <describe ECAM base and size> }
  }

RES0 could also be contained within PCI1, as Gabriele suggested.  I
don't really care whether it's contained or not, and making it
contained might make it easier for firmware, because addition/removal
of PCI1 and RES0 should always happen together.

I think the _DSM is important because it is really ugly if the
HISI0080 driver has to look for a separate HISI0081 device to learn
about the ECAM space.  There are several PCI drivers that do something
similar, using for_each_pci_dev(), and I cringe every time I see them,
because this totally screws up the driver model.  A driver should
claim a device via a .probe() method called by the core, and it
shouldn't look at devices it hasn't claimed.  This is required to make
hotplug work correctly.

> Hence to finally support ACPI PCI on ARM64 I suggest we carry out the
> following steps, in order:
> 
> - Let's complete/merge (1), that's fundamental to this whole thread
> - On top of (1) we apply a quirking mechanism based on (2) that allows
>   us to boot mainline with boxes shipping today with no FW update required.
> - We devise a way to handle quirks that is more generic than (2) so that
>   can we can accomodate further platforms that can't rely on (2) but
>   have more leeway in terms of FW updates.
> 
> I hope that's a reasonable plan, Tomasz's v8 series coming to kick it off.

Sounds very good to me; I'm looking forward to v8.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
