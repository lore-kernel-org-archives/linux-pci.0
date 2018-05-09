Return-Path: <SRS0=MNFI=H4=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=MNFI=H4=h08.hostsharing.net=foo00@kernel.org>
Date: Wed, 9 May 2018 13:41:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
Message-ID: <20180509114124.GA20639@wunner.de>
References: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
 <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 27, 2018 at 02:22:07PM -0500, Bjorn Helgaas wrote:
> Sinan mooted the idea of using a "no-wait" path of sending the "don't
> generate hotplug interrupts" command.  I think we should work on this
> idea a little more.  If we're shutting down the whole system, I can't
> believe there's much value in *anything* we do in the pciehp_remove()
> path.
> 
> Maybe we should just get rid of pciehp_remove() (and probably
> pcie_port_remove_service() and the other service driver remove methods)
> completely.  That dates from when the service drivers could be modules that
> could be potentially unloaded, but unloading them hasn't been possible for
> years.

Every Thunderbolt device contains a PCIe switch with at least one
(downstream) hotplug port, so pciehp_remove() is executed on unplug
of a Thunderbolt device and the assumption that it's unnecessary
simply because it's builtin isn't correct.

Thanks,

Lukas
