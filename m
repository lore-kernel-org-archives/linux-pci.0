Return-Path: <SRS0=veIH=K7=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=veIH=K7=kernel.crashing.org=benh@kernel.org>
Message-ID: <305a61080c60da17a1561b6891c91db5c439bb87.camel@kernel.crashing.org>
Subject: Re: PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
 happening due to race condition)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Hari Vyas <hari.vyas@broadcom.com>,
        Konstantin Khlebnikov
 <khlebnikov@yandex-team.ru>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui
 <ray.jui@broadcom.com>, Jens Axboe <axboe@kernel.dk>
Date: Fri, 17 Aug 2018 09:17:14 +1000
In-Reply-To: <20180816102645.btqgmnycprgyup4o@wunner.de>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
	 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
	 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
	 <20180815185027.GE28888@bhelgaas-glaptop.roam.corp.google.com>
	 <e3316c91ad722434360b4018b17cbfe265e97801.camel@kernel.crashing.org>
	 <fa218ce2-c337-e776-d958-f1f8a1129c9a@yandex-team.ru>
	 <6f76eb5f54fdc780dac744773d836214d7844346.camel@kernel.crashing.org>
	 <CAM5rFu-QCBq9TdoiFtvfNENUaS5Tpay5f0H9_BenEqK8nDgoNg@mail.gmail.com>
	 <f7aa5f1904f56beb3d202033089449a45f86e6d3.camel@kernel.crashing.org>
	 <20180816102645.btqgmnycprgyup4o@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-08-16 at 12:26 +0200, Lukas Wunner wrote:
> On Thu, Aug 16, 2018 at 08:10:28PM +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2018-08-16 at 14:52 +0530, Hari Vyas wrote:
> > > There was an issue reported by my colleague srinath while enabling pci
> > > bridge and a race condition was happening while setting memory and
> > > master bits i.e. bits were over-written.
> > > As per my understanding is_busmaster and is_added bit race issue was
> > > at internal data management and is quite different from pci bridge
> > > enabling issue.
> > > Am I missing some thing ? Would be interested to know what exactly was
> > > affected due to is_busmaster fix.
> > 
> > The is_busmaster fix isn't I think affecting anything, however I don't
> > like the use of atomics for these things. It's a band-aid. If we grow a
> > proper pci_dev mutex, which is what I'm introducing here, it should be
> > able to also handle the is_added race etc..
> 
> What is your rationale to introduce an additional mutex instead if
> utilizing the existing mutex in struct device via device_lock() /
> device_unlock() or alternatively pci_dev_lock() / pci_dev_unlock()?
> 
> This is also what Bjorn had suggested here:
> https://lore.kernel.org/lkml/20170816134354.GV32525@bhelgaas-glaptop.roam.corp.google.com/

The device_lock() is really meant for the core device model
(drivers/base/*) internal synchronization. I'm rather weary of
extending its use to drivers.

In the specific PCI case, the obvious reason is that probe() is already
called with that held. Thus we have an immediate deadlock if we try to
take it in pci_enable_device() for example on the device itself.

We could require that pci_enable_device() is always called with the
lock already held, and only take it for the parents when walking the
bus hierarchy but frankly, this sort of implicit locking requirements
are a rabbit hole and will lead to all sort of interesting bugs and
extra driver auditing requirements.

Cheers,
Ben.
