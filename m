Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Wed, 1 Jun 2016 13:42:35 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, Peter Wu <peter@lekensteyn.nl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] PCI: Wait for 50ms after bridge is powered up
Message-ID: <20160601114235.GA15191@wunner.de>
References: <1576190.gfFb6HhZV6@vostro.rjw.lan>
 <20160530093326.GH1789@lahna.fi.intel.com>
 <20160530144445.GC1743@lahna.fi.intel.com>
 <CAMxnaaXhapETZYMVe6EUoBGaMtxL_fP+uzc30SQpM+6EqPF3CQ@mail.gmail.com>
 <20160531083349.GG1743@lahna.fi.intel.com>
 <20160531085805.GI1743@lahna.fi.intel.com>
 <20160531104051.GA13958@wunner.de>
 <20160531104714.GL1743@lahna.fi.intel.com>
 <20160531110757.GB14008@wunner.de>
 <20160601091145.GP1743@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160601091145.GP1743@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 01, 2016 at 12:11:45PM +0300, Mika Westerberg wrote:
> I'm going to change the code to look like following (pm_runtime_mark_last_busy()
> gets called before pm_runtime_put_autosuspend() even if not strictly needed):
> 
> 	pm_runtime_set_autosuspend_delay(&dev->dev, 100);
> 	pm_runtime_use_autosuspend(&dev->dev);
> 	pm_runtime_mark_last_busy(&dev->dev);
> 	pm_runtime_put_autosuspend(&dev->dev);
> 	pm_runtime_allow(&dev->dev);
> 
> Note I'm still increasing default autosuspend delay from 10ms to 100ms.
> 
> Does the above work for you?

Yes, tested it and couldn't spot any issues.

Thanks,

Lukas
