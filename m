Return-Path: <SRS0=K4fR=YN=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=K4fR=YN=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kilian Singer <kilian.singer@quantumtechnology.info>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Date: Fri, 30 Dec 2016 02:50:45 +0100
Message-ID: <3319410.EGZrQ2GPBB@aspire.rjw.lan>
In-Reply-To: <2678604.V2vzbbOmVS@aspire.rjw.lan>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com> <ee766ef2-04a0-9014-9b82-5c507665ba5a@quantumtechnology.info> <2678604.V2vzbbOmVS@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Friday, December 30, 2016 02:40:45 AM Rafael J. Wysocki wrote:
> On Friday, December 30, 2016 01:45:53 AM Kilian Singer wrote:
> > The touchpad and builtin keyboard of laptop fail.
> > But also connected usb keyboard and usb mouse fail.
> > 
> > In both cases mouse pointer is still moveable.
> 
> It may just be too late to turn the ports "on" once they have been suspended at
> least once on your system.
> 
> Please check if the appended patch makes any difference.

Actually, please first check if booting with pci_port_pm=off in the kernel
command line makes any difference.

Thanks,
Rafael
