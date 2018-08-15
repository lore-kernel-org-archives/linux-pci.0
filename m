Return-Path: <SRS0=/dXs=K6=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=/dXs=K6=kernel.crashing.org=benh@kernel.org>
Message-ID: <5e42f7990673d11e3a020e7efcfd333215d48138.camel@kernel.crashing.org>
Subject: Re: PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
 happening due to race condition)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Hari Vyas <hari.vyas@broadcom.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, ray.jui@broadcom.com
Date: Wed, 15 Aug 2018 14:16:33 +1000
In-Reply-To: <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
	 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
	 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2018-08-15 at 13:35 +1000, Benjamin Herrenschmidt wrote:
> What's really needed is a per device mutex covering all those operations
> on a given device. (This would also allow to get rid of those games with
> atomics).
> 
> Any comments ?

Note: I'm experienting with a per-pci_dev mutex to protect the device
state. If it works out, I suggest we add it, then progressively
move things one by one under the protection of the mutex.

Any objection to the approach ? If it fixes my problem, I'll send
preliminary patches that cover the basic enable/disable and bus
master settings to start with. We should try to get them into
stable as this is breaking real world stuff for us.

I suspect large x86 systems get lucky because their BIOSes do all
the enables. It would be possible to reproduce the races there by
hot-pluging a large external drawer using a cable card with a switch

Cheers,
Ben.
 
