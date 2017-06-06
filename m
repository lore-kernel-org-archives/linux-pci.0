Return-Path: <SRS0=dP42=5L=kalray.eu=mrybczyn@kernel.org>
Return-Path: <SRS0=dP42=5L=kalray.eu=mrybczyn@kernel.org>
Date: Tue, 6 Jun 2017 09:28:36 +0200 (CEST)
From: Marta Rybczynska <mrybczyn@kalray.eu>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, rakesh@tuxera.com,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Message-ID: <1383840912.76088794.1496734116252.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20170606053142.GA25064@bhelgaas-glaptop.roam.corp.google.com>
References: <20170601111039.8913-1-hch@lst.de> <20170601111039.8913-2-hch@lst.de> <20170606053142.GA25064@bhelgaas-glaptop.roam.corp.google.com>
Subject: Re: [PATCH 1/3] PCI: ensure the PCI device is locked over
 ->reset_notify calls
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

> 
> But I'm still nervous because I think both threads will queue
> nvme_reset_work() work items for the same device, and I'm not sure
> they're prepared to run concurrently.
> 
> I don't really think it should be the driver's responsibility to
> understand issues like this and worry about things like
> nvme_reset_work() running concurrently.  So I'm thinking maybe the PCI
> core needs to be a little stricter here, but I don't know exactly
> *how*.
> 
> What do you think?

>From what I can see the nvme_reset_work if run twice may disable the
controller (the out label) if run concurrently. If run twice it will
initialize twice what isn't best either.

I think that the double nvme_reset_work should be prevented. Maybe
a state information saying that the device is in the reset procedure
and after that run nvme_reset_work just once?

Marta
