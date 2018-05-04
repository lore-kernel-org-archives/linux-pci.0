Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeEDUGD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 May 2018 16:06:03 -0400
Date: Fri, 4 May 2018 15:06:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gilles Buloz <Gilles.Buloz@kontron.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Minghuan.Lian@nxp.com" <Minghuan.Lian@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Sinan Kaya <okaya@codeaurora.org>
Message-ID: <20180504200600.GA9529@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bcc: 
Subject: Re: [PATCH] PCI: Check whether bridges allow access to extended
 config space
Reply-To: 
In-Reply-To: <5AEC8002.5000309@kontron.com>

[+cc Fred, Sinan]

On Fri, May 04, 2018 at 03:45:07PM +0000, Gilles Buloz wrote:
> Le 04/05/2018 00:31, Bjorn Helgaas a écrit :
> > [+cc LKML]
> >
> > On Thu, May 03, 2018 at 12:40:27PM +0000, Gilles Buloz wrote:
> >> Subject:    [PATCH] For exception at PCI probe due to bridge reporting UR
> >>
> >> Even if a device supports extended config access, no such access must be
> >> done to this device If there's a bridge not supporting that in the path
> >> to this device. Doing such access with UR reporting enabled on the root
> >> bridge leads to an exception.
> >>
> >> This is the case on a LS1043A CPU (NXP QorIQ Layerscape) platform with
> >> the following bus topology :
> >>    LS1043 PCIe root
> >>      -> PEX8112 PCIe-to-PCI bridge (not supporting ext cfg on PCI side)
> >>        -> PMC slot connector (for legacy PMC modules)
> >> With a PMC module topology as follows :
> >>    PMC connector
> >>      -> PCI-to-PCIe bridge
> >>        -> PCIe switch (4 ports)
> >>          -> 4 PCIe devices (one on each port)
> >> In this case all devices behind the PEX8112 are supporting extended config
> >> access but this is prohibited by the PEX8112. Without this patch, an
> >> exception (synchronous abort) occurs in pci_cfg_space_size_ext().
> >>
> >> This patch checks the parent bridge of each allocated child bus to know if
> >> extended config access is supported on the child bus, and sets a flag in
> >> child->bus_flags if not supported. This  flag is inherited by all children
> >> buses of this child bus and then is checked to avoid this unsupported
> >> accesses to every device on these buses.
> > Hi Gilles,
> >
> > Thanks for the patch!  I reworked it a little bit to simplify the code
> > in pci_alloc_child_bus().  Can you test it and make sure I didn't
> > break anything?
> >
> Hi Bjorn,
> 
> Your rework works as expected. Tested on LS1043A platform with kernel 4.17-rc1, and with some backport on kernel 4.1.35
> 
> Suggestion : maybe change the pci_info() string to have :
>      pci_bus 0000:xx: extended config space not accessible
> instead of
>      pci_bus 0000:xx: extended config space not accessible on secondary bus
> as xx is already the number of the secondary bus

Oops, when I wrote that I was thinking it would be printed for the
bridge device (not the bus).  I changed it as you suggest.

Interesting, I didn't think about the fact that pci_info() would work
on a struct pci_bus * as well as on a struct pci_dev *, since it's a
macro and they both have a "dev" member.

> Info : with kernel 4.17-rc1, it turns out I need pcie_aspm=off to
> have the PMC devices behind the PCI-to-PCIe bridge of the PMC safely
> detected/configured. But this is not caused by the patch.

> Without pcie_aspm=off I saw this at one boot :
>     "pci 0000:02:0e.0: ASPM: Could not configure common clock" for this bridge, but devices
>     correctly detected/configured
> but at most boots I get :
>     no ASPM message but "pci 0000:04:02.0: bridge configuration invalid ([bus ff-ff]), reconfiguring "
>     instead, and some devices are missing. Also lspci show "rev ff" for some devices.
> I don't see this problem on 4.1.35 with the same backported patch.

This is interesting, especially since you have this unusual topology
of a path to the device that is PCIe, then conventional PCI, then PCIe
again.  We *should* be able to use ASPM on the PCIe links, but it's
definitely not a well-tested scenario.

Can you tell if something is actually broken?  Sinan's recent change,
04875177dbe0 ("PCI/ASPM: Don't warn if already in common clock mode"),
which appeared in v4.17-rc1, turns off the message in some cases.

The "bridge configuration invalid" message just means the firmware
didn't configure the bridge.  We *should* still set it up correctly,
but please report a bug if we don't.

lspci showing "ff" for some devices might be a symptom of the devices
being powered off.  In that case config reads normally return ~0 data
(though on your platform maybe it would cause exceptions).  I've seen
this in other situations and wondered if it would be worth adding a
hint to lspci so it could say "device may be powered off".

Anyway, if you are seeing something broken (more than just the
messages), please start a new thread about each one.  If you do, could
you please:

  - open a report at https://bugzilla.kernel.org/, in the Drivers/PCI
    component (open a separate bug for each issue you see)

  - use kernel version 4.17-rc1 and mark it as a regression if
    appropriate

  - attach (don't paste inline) the complete dmesg log and "lspci -vv"
    output (as root) to the bug

  - post a note to linux-pci@vger.kernel.org, cc Fred, Sinan, and me,
    and include the link to the bugzilla

Bjorn
