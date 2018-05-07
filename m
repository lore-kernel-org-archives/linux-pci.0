Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 7 May 2018 16:56:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gilles Buloz <Gilles.Buloz@kontron.com>
Subject: Re: [PATCH] PCI: Check whether bridges allow access to extended
 config space
Message-ID: <20180507215619.GA161390@bhelgaas-glaptop.roam.corp.google.com>
References: <20180504200600.GA9529@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <20180504200600.GA9529@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Frederick Lawler <fred@fredlawl.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sinan Kaya <okaya@codeaurora.org>,
 "Minghuan.Lian@nxp.com" <Minghuan.Lian@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 04, 2018 at 03:06:00PM -0500, Bjorn Helgaas wrote:
> On Fri, May 04, 2018 at 03:45:07PM +0000, Gilles Buloz wrote:
> > Le 04/05/2018 00:31, Bjorn Helgaas a =E9crit :
> > > [+cc LKML]
> > >
> > > On Thu, May 03, 2018 at 12:40:27PM +0000, Gilles Buloz wrote:
> > >> Subject:    [PATCH] For exception at PCI probe due to bridge reporti=
ng UR
> > >>
> > >> Even if a device supports extended config access, no such access mus=
t be
> > >> done to this device If there's a bridge not supporting that in the p=
ath
> > >> to this device. Doing such access with UR reporting enabled on the r=
oot
> > >> bridge leads to an exception.
> > >>
> > >> This is the case on a LS1043A CPU (NXP QorIQ Layerscape) platform wi=
th
> > >> the following bus topology :
> > >>    LS1043 PCIe root
> > >>      -> PEX8112 PCIe-to-PCI bridge (not supporting ext cfg on PCI si=
de)
> > >>        -> PMC slot connector (for legacy PMC modules)
> > >> With a PMC module topology as follows :
> > >>    PMC connector
> > >>      -> PCI-to-PCIe bridge
> > >>        -> PCIe switch (4 ports)
> > >>          -> 4 PCIe devices (one on each port)
> > >> In this case all devices behind the PEX8112 are supporting extended =
config
> > >> access but this is prohibited by the PEX8112. Without this patch, an
> > >> exception (synchronous abort) occurs in pci_cfg_space_size_ext().
> > >>
> > >> This patch checks the parent bridge of each allocated child bus to k=
now if
> > >> extended config access is supported on the child bus, and sets a fla=
g in
> > >> child->bus_flags if not supported. This  flag is inherited by all ch=
ildren
> > >> buses of this child bus and then is checked to avoid this unsupported
> > >> accesses to every device on these buses.
> > > Hi Gilles,
> > >
> > > Thanks for the patch!  I reworked it a little bit to simplify the code
> > > in pci_alloc_child_bus().  Can you test it and make sure I didn't
> > > break anything?
> > >
> > Hi Bjorn,
> > =

> > Your rework works as expected. Tested on LS1043A platform with kernel
> > 4.17-rc1, and with some backport on kernel 4.1.35

Thanks for testing it!  I applied it to pci/enumeration for v4.18.

I think the ASPM issue below is unrelated.  But I would like to figure out
what's going on there, too, if you have any more information.

> > Info : with kernel 4.17-rc1, it turns out I need pcie_aspm=3Doff to
> > have the PMC devices behind the PCI-to-PCIe bridge of the PMC safely
> > detected/configured. But this is not caused by the patch.
> =

> > Without pcie_aspm=3Doff I saw this at one boot :
> >     "pci 0000:02:0e.0: ASPM: Could not configure common clock" for this=
 bridge, but devices
> >     correctly detected/configured
> > but at most boots I get :
> >     no ASPM message but "pci 0000:04:02.0: bridge configuration invalid=
 ([bus ff-ff]), reconfiguring "
> >     instead, and some devices are missing. Also lspci show "rev ff" for=
 some devices.
> > I don't see this problem on 4.1.35 with the same backported patch.
> =

> This is interesting, especially since you have this unusual topology
> of a path to the device that is PCIe, then conventional PCI, then PCIe
> again.  We *should* be able to use ASPM on the PCIe links, but it's
> definitely not a well-tested scenario.
> =

> Can you tell if something is actually broken?  Sinan's recent change,
> 04875177dbe0 ("PCI/ASPM: Don't warn if already in common clock mode"),
> which appeared in v4.17-rc1, turns off the message in some cases.
> =

> The "bridge configuration invalid" message just means the firmware
> didn't configure the bridge.  We *should* still set it up correctly,
> but please report a bug if we don't.
> =

> lspci showing "ff" for some devices might be a symptom of the devices
> being powered off.  In that case config reads normally return ~0 data
> (though on your platform maybe it would cause exceptions).  I've seen
> this in other situations and wondered if it would be worth adding a
> hint to lspci so it could say "device may be powered off".
> =

> Anyway, if you are seeing something broken (more than just the
> messages), please start a new thread about each one.  If you do, could
> you please:
> =

>   - open a report at https://bugzilla.kernel.org/, in the Drivers/PCI
>     component (open a separate bug for each issue you see)
> =

>   - use kernel version 4.17-rc1 and mark it as a regression if
>     appropriate
> =

>   - attach (don't paste inline) the complete dmesg log and "lspci -vv"
>     output (as root) to the bug
> =

>   - post a note to linux-pci@vger.kernel.org, cc Fred, Sinan, and me,
>     and include the link to the bugzilla
> =

> Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
