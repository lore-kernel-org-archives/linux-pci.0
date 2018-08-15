Return-Path: <SRS0=/dXs=K6=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=/dXs=K6=kernel.crashing.org=benh@kernel.org>
Message-ID: <2e4eaef24dda4ab209ccfa8ac1ee4b073856da41.camel@kernel.crashing.org>
Subject: Re: PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
 happening due to race condition)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hari Vyas <hari.vyas@broadcom.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, ray.jui@broadcom.com,
        Konstantin Khlebnikov
	 <khlebnikov@yandex-team.ru>,
        Jens Axboe <axboe@kernel.dk>
Date: Thu, 16 Aug 2018 09:23:56 +1000
In-Reply-To: <e3316c91ad722434360b4018b17cbfe265e97801.camel@kernel.crashing.org>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
	 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
	 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
	 <20180815185027.GE28888@bhelgaas-glaptop.roam.corp.google.com>
	 <e3316c91ad722434360b4018b17cbfe265e97801.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-08-16 at 07:52 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2018-08-15 at 13:50 -0500, Bjorn Helgaas wrote:
> > Yes, this is definitely broken.  Some folks have tried to fix it in
> > the past, but it hasn't quite happened yet.  We actually merged one
> > patch, 40f11adc7cd9 ("PCI: Avoid race while enabling upstream
> > bridges"), but had to revert it after we found issues:
> > 
> > https://lkml.kernel.org/r/1501858648-22228-1-git-send-email-srinath.mannam@broadcom.com
> > https://lkml.kernel.org/r/20170915072352.10453.31977.stgit@bhelgaas-glaptop.roam.corp.google.com
> 
> Ok so I had a look at this previous patch and it adds yet anothe use of
> some global mutex to protect part of the operation which makes me
> cringe a bit, we have too many of these.
> 
> What do you think of the one I sent yesterday ? (I can't find it in the
> archives yet)

I verified on my Thinkpad X1 Carbon Gen4, everything seems to be
working fine with the patch applied, including iwlwifi.

> [RFC PATCH] pci: Proof of concept at fixing pci_enable_device/bridge races
> 
> The patch itself needs splitting etc... but the basic idea is to move away
> from those global mutexes in a number of places and have one in the pci_dev
> struct itself to protect its state.
> 
> I would also like to use this rather than the bitmap atomics for is_added
> etc... (Hari's fix) in the long run. Atomics aren't significantly cheaper
> and imho makes thing even messier.
> 
> Jens, Konstantin, any chance you can test if the above also breaks iwlwifi
> (I don't see why it would but ...)
> 
> Cheers,
> Ben.
> 
