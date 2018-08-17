Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Message-ID: <cc822c731d47fe527ca4f97130a98ebb5b52db72.camel@kernel.crashing.org>
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
Date: Fri, 17 Aug 2018 10:43:00 +1000
In-Reply-To: <305a61080c60da17a1561b6891c91db5c439bb87.camel@kernel.crashing.org>
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
	 <305a61080c60da17a1561b6891c91db5c439bb87.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-08-17 at 09:17 +1000, Benjamin Herrenschmidt wrote:
> 
> > What is your rationale to introduce an additional mutex instead if
> > utilizing the existing mutex in struct device via device_lock() /
> > device_unlock() or alternatively pci_dev_lock() / pci_dev_unlock()?
> > 
> > This is also what Bjorn had suggested here:
> > https://lore.kernel.org/lkml/20170816134354.GV32525@bhelgaas-glaptop.roam.corp.google.com/
> 
> The device_lock() is really meant for the core device model
> (drivers/base/*) internal synchronization. I'm rather weary of
> extending its use to drivers.
> 
> In the specific PCI case, the obvious reason is that probe() is already
> called with that held. Thus we have an immediate deadlock if we try to
> take it in pci_enable_device() for example on the device itself.
> 
> We could require that pci_enable_device() is always called with the
> lock already held, and only take it for the parents when walking the
> bus hierarchy but frankly, this sort of implicit locking requirements
> are a rabbit hole and will lead to all sort of interesting bugs and
> extra driver auditing requirements.

In addition, there are additional uncertainties about whether
the device_lock of the parent is held or not.

Generally this only happens for USB but there are some cases when
the device has busy consumer links where remove() will hold it too.

That would make the walking-up-the-bus for pci_enable_bridge()
rather tricky.

That leads to crazy things like pci_reset_function() vs
pci_reset_function_locked(). Whenever we end up doing that, that's
usually a sign that we didn't think things through.

I think we would benefit greatly from the clarity of having a dedicated
mutex for pci_dev that handles all of our state management. We can
start with the enable_cnt (and as a result stop using atomics) and
is_busmaster, we can extend to is_added thus making Hari's patch
unnecessary, and then start looking at everything else.

We still need the actual device_lock for some things, like the whole
pci_bus_reset() business which we really want to exclude from
concurrent driver binding/unbinding I suppose.

We mostly get away with the lack of locking today because the bulk of
the :1 fields in there tend to be only use either at discovery time
or by the driver init, so in a single threaded manner, but as we saw
already, that assumption breaks on bridges and is generally rather
unsafe.

Cheers,
Ben.
