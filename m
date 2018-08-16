Return-Path: <SRS0=veIH=K7=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=veIH=K7=kernel.crashing.org=benh@kernel.org>
Message-ID: <9730c02c56b43bbaaea3f93306a83560a2d40b3e.camel@kernel.crashing.org>
Subject: Re: PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
 happening due to race condition)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hari Vyas <hari.vyas@broadcom.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Bjorn Helgaas
	 <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>, Jens Axboe
	 <axboe@kernel.dk>
Date: Thu, 16 Aug 2018 20:11:18 +1000
In-Reply-To: <f7aa5f1904f56beb3d202033089449a45f86e6d3.camel@kernel.crashing.org>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
	 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
	 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
	 <20180815185027.GE28888@bhelgaas-glaptop.roam.corp.google.com>
	 <e3316c91ad722434360b4018b17cbfe265e97801.camel@kernel.crashing.org>
	 <fa218ce2-c337-e776-d958-f1f8a1129c9a@yandex-team.ru>
	 <6f76eb5f54fdc780dac744773d836214d7844346.camel@kernel.crashing.org>
	 <CAM5rFu-QCBq9TdoiFtvfNENUaS5Tpay5f0H9_BenEqK8nDgoNg@mail.gmail.com>
	 <f7aa5f1904f56beb3d202033089449a45f86e6d3.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-08-16 at 20:10 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2018-08-16 at 14:52 +0530, Hari Vyas wrote:
> > 
> > There was an issue reported by my colleague srinath while enabling pci
> > bridge and a race
> > condition was happening while setting memory and master bits i.e. bits
> > were over-written.
> > As per my understanding is_busmaster and is_added bit race issue was
> > at internal data
> > management and is quite different from pci bridge enabling issue.
> > Am I missing some thing ? Would be interested to know what exactly was
> > affected due to
> > is_busmaster fix.
> 
> The is_busmaster fix isn't I think affecting anything, however I don't
> like the use of atomics for these things. It's a band-aid. If we grow a
> proper pci_dev mutex, which is what I'm introducing here, it should be
> able to also handle the is_added race etc..
> 
> > In any case, one bug is already filed and may propose a patch soon
> > about pci bridge enabling scenario.
> 
> I already did, see the patch I posted earlier.

https://lore.kernel.org/lkml/08bc40a6af3e614e97a78fbaab688bfcd14520ac.camel@kernel.crashing.org/

> >  In summary, bit manipulation is not working fine due to race
> > conditions in SMP
> > environment.
> 
> Right, among other things.
> 
> My proposed patch (which I will try to break down tomorrow or next week
> into smaller bits) introduces a per-pci_dev mutex and uses it to fix
> the enable & set_master races.
> 
> My proposal is to then progressively move more things under the
> umbrella of that mutex in order to properly protect the pci_dev
> internal state.
> 
> Cheers,
> Ben.
> 
> > Regards,
> > hari
