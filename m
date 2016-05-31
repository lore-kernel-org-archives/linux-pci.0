Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Tue, 31 May 2016 13:47:14 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, Peter Wu <peter@lekensteyn.nl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] PCI: Wait for 50ms after bridge is powered up
Message-ID: <20160531104714.GL1743@lahna.fi.intel.com>
References: <20160524162833.GA30762@localhost>
 <20160526104557.GA6816@wunner.de>
 <20160526110308.GX1789@lahna.fi.intel.com>
 <1576190.gfFb6HhZV6@vostro.rjw.lan>
 <20160530093326.GH1789@lahna.fi.intel.com>
 <20160530144445.GC1743@lahna.fi.intel.com>
 <CAMxnaaXhapETZYMVe6EUoBGaMtxL_fP+uzc30SQpM+6EqPF3CQ@mail.gmail.com>
 <20160531083349.GG1743@lahna.fi.intel.com>
 <20160531085805.GI1743@lahna.fi.intel.com>
 <20160531104051.GA13958@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160531104051.GA13958@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 31, 2016 at 12:40:51PM +0200, Lukas Wunner wrote:
> On Tue, May 31, 2016 at 11:58:05AM +0300, Mika Westerberg wrote:
> > To summarize the next steps. I will send new version of the
> > PCI PM patches with following changes.
> > 
> >   - Drop this 50ms patch, we should have the PCIe 100ms delay already
> >     covered.
> > 
> >   - Increase runtime PM autosuspend time from 10ms to 500ms (or whatever
> >     is the prefered default).
> 
> I did some tests, turns out the autosuspend delay need not be increased
> to prevent the Thunderbolt hotplug ports from suspending between
> "enabling device" and loading the pciehp driver, however the following
> is needed:
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 7860ab3..1d1fb1c 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -238,6 +238,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  		pm_runtime_set_autosuspend_delay(&dev->dev, 10);
>  		pm_runtime_use_autosuspend(&dev->dev);
>  		pm_runtime_put_autosuspend(&dev->dev);
> +		pm_runtime_mark_last_busy(&dev->dev);
>  		pm_runtime_allow(&dev->dev);
>  	}

I still prefer increasing the autosuspend delay. The above looks hackish
and does not work if it takes more than 10ms to get to the tbt driver
probe.

Did you try if it also works with 500ms delay?
