Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbdLKRyy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Dec 2017 12:54:54 -0500
Date: Mon, 11 Dec 2017 11:54:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>, treding@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V3 0/2] Tegra PCIe end point config space map code
 refactoring
Message-ID: <20171211175452.GC16032@bhelgaas-glaptop.roam.corp.google.com>
References: <1512410030-21038-1-git-send-email-vidyas@nvidia.com>
 <20171211105431.GI10671@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171211105431.GI10671@ulmo>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Lorenzo]

On Mon, Dec 11, 2017 at 11:54:31AM +0100, Thierry Reding wrote:
> On Mon, Dec 04, 2017 at 11:23:48PM +0530, Vidya Sagar wrote:
> > PCIe host controller in Tegra SoCs has 1GB of aperture available
> > for mapping end points config space, IO and BARs. In that, currently
> > 256MB is being reserved for mapping end points configuration space
> > which leaves less memory space available for mapping end points BARs
> > on some of the platforms.
> > This patch series attempts to map only 4K space from 1GB aperture to
> > access end points configuration space.
> > 
> > Currently, this change can benefit T20 and T186 in saving (i.e. repurposed
> > to use for BAR mapping) physical space as well as kernel virtual mapping space,
> > it saves only kernel virtual address space in T30, T124, T132 and T210.
> > 
> > NOTE: Since T186 PCIe DT entry is not yet present in main line (it is currently
> > merged to 'for-4.15/arm64/dt' branch), nothing gets broken with this change for T186.
> > For older platforms (T20, T30, T124, T132, T210), this change works fine without any
> > DT modifications
> > 
> > Testing Done on T124, T210 & T186:
> >  Enumeration and basic functionality of immediate devices
> >  Enumeration of devices behind a PCIe switch
> >  Complete 4K configuration space access
> > 
> > Vidya Sagar (2):
> >   PCI: tegra: refactor config space mapping code
> >   ARM64: tegra: limit PCIe config space mapping to 4K for T186
> > 
> >  arch/arm64/boot/dts/nvidia/tegra186.dtsi |   8 +-
> >  drivers/pci/host/pci-tegra.c             | 125 ++++++++++---------------------
> >  2 files changed, 44 insertions(+), 89 deletions(-)
> 
> Hi Bjorn,
> 
> there's a bunch of PCI related patches for Tegra floating around on the
> lists. I'm wondering if you'd be okay if I pick those up into the Tegra
> tree after they've been reviewed and send you a pull request later on
> (say around v4.15-rc6). That would allow me to get things cooking in
> linux-next for a bit and get broader testing in addition to the
> flexibility to patch things up if they break.

Lorenzo will be merging the Tegra stuff, so this is more a question
for him.

Just to clarify, I think your questions is about putting those patches
in
git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git#for-next.
If you put them there they will show up in linux-next, and then when
Lorenzo merges them, you'll have to coordinate so they don't get
merged into linux-next twice (once via the usual PCI tree route and
again via the Tegra tree).

If you wait until after they've been reviewed to put them into the
Tegra tree, I'm not sure what the gain is, because I assume Lorenzo
would merge them at about that same point.

This cycle isn't going to be ideal timing with all the holidays
coming up.  I know I'm going to be traveling and on vacation quite a
bit in the rc5, 6, 7 timeframe.

Bjorn
