Return-Path: <SRS0=zLRQ=DK=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=zLRQ=DK=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 14 Dec 2017 10:37:22 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vidya Sagar <vidyas@nvidia.com>, treding@nvidia.com,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	kthota@nvidia.com, mmaddireddy@nvidia.com, robh+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH V3 0/2] Tegra PCIe end point config space map code
 refactoring
Message-ID: <20171214103722.GC697@e107981-ln.cambridge.arm.com>
References: <1512410030-21038-1-git-send-email-vidyas@nvidia.com>
 <20171211105431.GI10671@ulmo>
 <20171211175452.GC16032@bhelgaas-glaptop.roam.corp.google.com>
 <20171212110158.GA30601@e107981-ln.cambridge.arm.com>
 <20171212122252.GA29883@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171212122252.GA29883@ulmo>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 12, 2017 at 01:22:52PM +0100, Thierry Reding wrote:

[...]

> > > > Hi Bjorn,
> > > > 
> > > > there's a bunch of PCI related patches for Tegra floating around on the
> > > > lists. I'm wondering if you'd be okay if I pick those up into the Tegra
> > > > tree after they've been reviewed and send you a pull request later on
> > > > (say around v4.15-rc6). That would allow me to get things cooking in
> > > > linux-next for a bit and get broader testing in addition to the
> > > > flexibility to patch things up if they break.
> > > 
> > > Lorenzo will be merging the Tegra stuff, so this is more a question
> > > for him.
> > > 
> > > Just to clarify, I think your questions is about putting those patches
> > > in
> > > git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git#for-next.
> > > If you put them there they will show up in linux-next, and then when
> > > Lorenzo merges them, you'll have to coordinate so they don't get
> > > merged into linux-next twice (once via the usual PCI tree route and
> > > again via the Tegra tree).
> > > 
> > > If you wait until after they've been reviewed to put them into the
> > > Tegra tree, I'm not sure what the gain is, because I assume Lorenzo
> > > would merge them at about that same point.
> > 
> > I think that after the review, the Tegra patches that are considered for
> > upstream they should go to -next via the PCI tree as any other platform PCI
> > patches; the relevant patches need ACKs from the respective platform
> > maintainer - I am getting to them as fast as I can.
> 
> Just to clarify: I wasn't suggesting that these patches are merged for
> v4.16 via the Tegra tree, only that I carry them in the Tegra tree for a
> little while so that we can get broader testing and fix things up in
> case they break. My proposal was to then send a pull request for
> inclusion in the PCI tree. linux-next can deal with this type of
> scenario just fine because it will simply see the same branch twice and
> ignore the second one.
> 
> If you prefer to merge directly via the PCI tree that works for me too.

We would end up merging the patches into -next at the same time, so there
is not much point in queuing them via Tegra if they go via the PCI tree
eventually; we should not add to -next patches that are not ready to
be merged anyway.

I need your help (ACKs) though to queue them up - I review the patches
but I can neither test them nor get access to HW TRMs so for some of them
there is not much I can do.

Thanks,
Lorenzo
