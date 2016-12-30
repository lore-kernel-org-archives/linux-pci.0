Return-Path: <SRS0=K4fR=YN=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=K4fR=YN=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kilian Singer <kilian.singer@quantumtechnology.info>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Date: Fri, 30 Dec 2016 01:22:57 +0100
Message-ID: <2589829.sCArIQeDWm@aspire.rjw.lan>
In-Reply-To: <3ae00c72-a4e1-dd97-e9d4-2450ee274b72@quantumtechnology.info>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com> <1180505121.522.1483056977880.JavaMail.zimbra@quantumtechnology.info> <3ae00c72-a4e1-dd97-e9d4-2450ee274b72@quantumtechnology.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Friday, December 30, 2016 01:24:19 AM Kilian Singer wrote:
> The
> 
> echo on > /sys/bus/pci/devices/0000:00:1c.0/power/control
> 
> did not help neither.

So does it help if you do "echo on > .../power/control" for all devices under
/sys/bus/pci/devices/ ?

Thanks,
Rafael
