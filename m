Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56797 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594AbbHLJPz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 12 Aug 2015 05:15:55 -0400
Date: Wed, 12 Aug 2015 10:15:51 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jayachandran C <jchandra@broadcom.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v4 1/3] PCI: generic: remove dependency on hw_pci
Message-ID: <20150812091551.GA23483@red-moon>
References: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
 <20150804234956.GF17327@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150804234956.GF17327@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 05, 2015 at 12:49:56AM +0100, Bjorn Helgaas wrote:
> On Wed, Aug 05, 2015 at 02:23:38AM +0530, Jayachandran C wrote:
> > The current code in pci-host-generic.c uses pci_common_init_dev()
> > from arm architecture to do some part of the PCI setup, and this
> > prevents it from being used with arm64 architecture.
> > 
> > The part of pci_common_init_dev() that is really needed by
> > pci-host-generic.c is very limited and can be done in the same
> > file without using hw_pci API of ARM. The ARM platform requires
> > a pci_sys_data as sysdata for the PCI bus, this can be handled by
> > setting up gen_pci to have a pci_sys_data variable as the first
> > element.
> > 
> > Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Tested-by: Pavel Fedin <p.fedin@samsung.com>
> 
> I applied all three of these to my pci/enumeration branch for v4.3.
> 
> I made a few changes, the most important being to call
> pcie_bus_configure_settings() before pci_bus_add_devices(), because drivers
> may claim devices in pci_bus_add_devices(), and the PCI core shouldn't
> touch devices after drivers claim them.
> 
> I dropped the acks and tested-by because of that change, but I'll happily
> add them back if Lorenzo and Pavel confirm.  The patches are here if you
> want to review/test them:
> 
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/enumeration
> 

I am happy with your changes so you can certainly add my acked-by/tested-by
tags back, with thanks.

Thank you !
Lorenzo

> I'm sure the other patches on that branch will need some tweaks, too, so I
> don't have any problem with updating these.
