Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 7 Nov 2017 21:01:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        "Chris Valean (Cloudbase Solutions SRL)" <v-chvale@microsoft.com>,
        "Adrian Suhov (Cloudbase Solutions SRL)" <v-adsuho@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        'Eyal Mizrachi' <eyalmi@mellanox.com>,
        Jack Morgenstein <jackm@mellanox.com>,
        Armen Guezalian <armeng@mellanox.com>,
        Firas Mahameed <firas@mellanox.com>,
        Tziporet Koren <tziporet@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>
Subject: Re: [PATCH] PCI: hv: use effective affinity mask
Message-ID: <20171108030133.GB28427@bhelgaas-glaptop.roam.corp.google.com>
References: <PS1P15301MB00112EE79DE499E8B2BA338BBF5F0@PS1P15301MB0011.APCP153.PROD.OUTLOOK.COM>
 <20171108010736.GA28427@bhelgaas-glaptop.roam.corp.google.com>
 <KL1P15301MB00061170992D6D998A590B9CBF560@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <KL1P15301MB00061170992D6D998A590B9CBF560@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 08, 2017 at 01:27:02AM +0000, Dexuan Cui wrote:
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: Tuesday, November 7, 2017 5:08 PM
> > On Wed, Nov 01, 2017 at 08:30:53PM +0000, Dexuan Cui wrote:
> > >
> > > Please consider this for v4.14, if it's not too late.
> > 
> > What would be the rationale for putting it in v4.14?  After the merge
> > window, I usually only merge fixes for problems introduced during the
> > merge window, or for serious regressions.  I can't tell if this fits
> > into that or not.
> 
> The patch was sent last Wednesday and I hoped it could catch the 
> merge window to be in v4.14 so we won't have to request a backport
> for the v4.14 stable kernel in future. And I was not exactly sure when
> the merge window was. Sorry :-)
> 
> The patch is not fixing a serious regression. It just fixes a long standing
> issue from the beginning of the Hyper-V vPCI driver: 1 of 7 Mellanox 
> VFs of a 32-vCPU VM running on Hyper-V may not receive interrupts.

No problem.  I added a stable tag so the backport should happen
automatically and put it on my pci/host-hv branch for v4.15, with Jake's
Reviewed-by.  Thanks!

Bjorn
