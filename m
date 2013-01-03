Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <liuj97@gmail.com>,
	Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [Alternative 2][PATCH] ACPI / PCI: Set root bridge ACPI handle in advance
Date: Thu, 03 Jan 2013 21:44:43 +0100
Message-ID: <10445889.QtJkhQJqYm@vostro.rjw.lan>
In-Reply-To: <20130102230732.GB31813@google.com>
References: <1558789.gX8cmBgyDV@vostro.rjw.lan> <2816571.07LqOj3EJg@vostro.rjw.lan> <20130102230732.GB31813@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, January 02, 2013 04:07:32 PM Bjorn Helgaas wrote:
> On Thu, Dec 27, 2012 at 10:32:13PM +0100, Rafael J. Wysocki wrote:
> > To that end, split pci_create_root_bus() into two functions,
> > pci_alloc_root() and pci_add_root(), that will allocate memory for
> > the new PCI bus and bridge representations and register them with
> > the driver core, respectively, and that may be called directly by
> > the architectures that need to set the root bridge's ACPI handle
> > before registering it.
> 
> I'm trying to *reduce* the interfaces for creating and scanning PCI
> host bridges, and this is a step in the opposite direction.

I'm actually unsure why reducing should mean just leaving one function that
will do the allocation and registration in one piece?

Why don't we have, for example,

struct pci_root {
	struct pci_host_bridge bridge;
	struct pci_bus bus;
};

that's supposed to be allocated in advance by the platform and then

pci_root_init(struct pci_root *);
pci_root_add(struct pci_root *);
pci_root_register(struct pci_root *);

that will do the common initialization, the registration with the driver core
and both these things at a time, respectively?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
