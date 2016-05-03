Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu.Dudau@arm.com
Cc: Thierry Reding <thierry.reding@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>, catalin.marinas@arm.com, linux-pci@vger.kernel.org, will.deacon@arm.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tn@semihalf.com>, ddaney@caviumnetworks.com, robert.richter@caviumnetworks.com, msalter@redhat.com, jchandra@broadcom.com, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com
Subject: Re: [PATCH 1/3] [RFC] pci: add new method for register PCI hosts
Date: Tue, 03 May 2016 14:12:34 +0200
Message-ID: <2557793.QTjSAUMHc9@wuerfel>
In-Reply-To: <20160503100422.GZ28464@e106497-lin.cambridge.arm.com>
References: <1461970899-4150603-1-git-send-email-arnd@arndb.de> <20160502070943.GB27465@ulmo.ba.sec> <20160503100422.GZ28464@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 03 May 2016 11:04:23 Liviu.Dudau@arm.com wrote:
> > > +   list_splice_init(&bridge->windows, &resources);
> > > +   b->sysdata = bridge->sysdata;
> > 
> > Does the sysdata not become effectively obsolete after this series? My
> > understanding is that it's primarily used to store driver-specific data
> > along with a PCI bus, but if drivers can embed struct pci_host_bridge
> > they can simply upcast bus->bridge. 
> 
> I second that. If we do this change (which is long overdue and I fully support),
> let's kill sysdata now. Generic host bridge code doesn't use sysdata on purpose.

I think we still need it in the intermediate time for any remaining users of
the existing interfaces (pci_scan_bus, pci_scan_root_bus, pci_create_root_bus).

It may take a while until those are all gone, but I agree that it makes sense
to not even set the pointer for any driver we convert to the new interface.

	Arnd
