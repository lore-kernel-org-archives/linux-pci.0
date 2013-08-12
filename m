Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22514 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755995Ab3HLQWa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2013 12:22:30 -0400
Date: Mon, 12 Aug 2013 12:22:27 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 00/14] Rewrite Tegra PCIe driver
Message-ID: <20130812162227.GA14590@titan.lakedaemon.net>
References: <1376059772-16669-1-git-send-email-treding@nvidia.com>
 <20130809150831.GF25111@titan.lakedaemon.net>
 <20130812161612.GA8282@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130812161612.GA8282@ulmo>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 12, 2013 at 06:16:13PM +0200, Thierry Reding wrote:
> On Fri, Aug 09, 2013 at 11:08:31AM -0400, Jason Cooper wrote:
> > On Fri, Aug 09, 2013 at 04:49:18PM +0200, Thierry Reding wrote:
> > > Hi Stephen,
> > > 
> > > This is the latest version of the Tegra PCIe driver patch series. I've
> > > dropped the PCI xclk clamping code as discussed and successfully tested
> > > on Beaver. The patches that touch the PCI subsystem have Bjorn's
> > > Acked-by and I've tested this on top of next-20130809, which has Jason's
> > > common branch. Once he's comfortable with making the branch stable you
> > > should be able to merge that branch and apply these patches on top.
> > 
> > Just an FYI, I'm mostly happy with what we have now, except that I'd
> > like to confirm that the build failure Randy discovered isn't caused by
> > us:
> > 
> > Randy wrote some time later:
> > > On 08/08/13 00:08, Stephen Rothwell wrote:
> > > > Hi all,
> > > >
> > > > Changes since 20130807:
> > > >
> > > 
> > > on i386 and x86_64:
> > > when CONFIG_PCI_MSI is not enabled:
> > > 
> > > There are many of these errors:
> > > include/linux/msi.h:65:6: error: expected identifier or '(' before 'void'
> > > include/linux/msi.h:65:6: error: expected ')' before numeric constant
> > > 
> > > because arch/x86/include/asm/pci.h defines:
> > > #define default_teardown_msi_irqs NULL
> > 
> > I'm having a helluva time reproducing it :(
> > 
> > The next run of linux-next isn't until Sunday evening (AUS Monday
> > morning), so we have some time to figure it out.
> > 
> > Also, I've renamed the branch mvebu/msi_pci to more accurately describe
> > the changes it contains.
> 
> Has there been any progress on this? If not I'll take a look at it
> tomorrow.

Yes, Thomas fixed it by properly implementing weak across the archs.  I
got wrapped around the axle yesterday, so I'm working on it today.
Should have a stable branch for you in an hour or so.

thx,

Jason.
