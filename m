Return-Path: <SRS0=tWbE=YN=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=tWbE=YN=quantumtechnology.info=kilian.singer@kernel.org>
Date: Fri, 30 Dec 2016 14:59:53 +0100 (CET)
From: Kilian Singer <kilian.singer@quantumtechnology.info>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Message-ID: <707035209.554.1483106393928.JavaMail.zimbra@quantumtechnology.info>
In-Reply-To: <1129781083.551.1483105037253.JavaMail.zimbra@quantumtechnology.info>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com> <2678604.V2vzbbOmVS@aspire.rjw.lan> <3319410.EGZrQ2GPBB@aspire.rjw.lan> <1942778.Cx2ycTbRkQ@aspire.rjw.lan> <1129781083.551.1483105037253.JavaMail.zimbra@quantumtechnology.info>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

The proposed patch alone did not change the issue.


----- Original Message -----
From: "Kilian Singer" <kilian.singer@quantumtechnology.info>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Lukas Wunner" <lukas@wunner.de>, "Bjorn Helgaas" <helgaas@kernel.org>, "linux-pci" <linux-pci@vger.kernel.org>, "Mika Westerberg" <mika.westerberg@linux.intel.com>
Sent: Friday, December 30, 2016 2:37:17 PM
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"

Yes,
the pci_port_pm=off
fixes both the firefox issue and the lock screen issue. Also suspend/resume work.
Tested on 4.9

----- Original Message -----
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Kilian Singer" <kilian.singer@quantumtechnology.info>
Cc: "Lukas Wunner" <lukas@wunner.de>, "Bjorn Helgaas" <helgaas@kernel.org>, "linux-pci" <linux-pci@vger.kernel.org>, "Mika Westerberg" <mika.westerberg@linux.intel.com>
Sent: Friday, December 30, 2016 2:52:59 AM
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"

On Friday, December 30, 2016 02:50:45 AM Rafael J. Wysocki wrote:
> On Friday, December 30, 2016 02:40:45 AM Rafael J. Wysocki wrote:
> > On Friday, December 30, 2016 01:45:53 AM Kilian Singer wrote:
> > > The touchpad and builtin keyboard of laptop fail.
> > > But also connected usb keyboard and usb mouse fail.
> > > 
> > > In both cases mouse pointer is still moveable.
> > 
> > It may just be too late to turn the ports "on" once they have been suspended at
> > least once on your system.
> > 
> > Please check if the appended patch makes any difference.
> 
> Actually, please first check if booting with pci_port_pm=off in the kernel
> command line makes any difference.

The command line option should be pcie_port_pm=off ("e" was missing), sorry.

Thanks,
Rafael
