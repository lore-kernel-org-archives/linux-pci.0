Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43127 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932199AbbLSL2Q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 19 Dec 2015 06:28:16 -0500
Date: Sat, 19 Dec 2015 12:27:17 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: KY Srinivasan <kys@microsoft.com>
cc: Jake Oshins <jakeo@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v9 0/7] PCI: hv: New paravirtual PCI front-end for Hyper-V
 VMs
In-Reply-To: <BY2PR0301MB16545331BCB31D708A74C583A0EE0@BY2PR0301MB1654.namprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.11.1512191220180.28591@nanos>
References: <1449701697-6366-1-git-send-email-jakeo@microsoft.com> <BY2PR0301MB16545331BCB31D708A74C583A0EE0@BY2PR0301MB1654.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 15 Dec 2015, KY Srinivasan wrote:
> 
> Of these 7 patches, Greg has committed all of the VMBUS
> related supporting patches (3 patches). Thomas, can you 
> take the IRQ related patches through your tree.

That does not make any sense.

> > Jake Oshins (7):
> >   drivers:hv: Export a function that maps Linux CPU num onto Hyper-V
> >     proc num
> >   drivers:hv: Export hv_do_hypercall()
> >   PCI: Make it possible to implement a PCI MSI IRQ Domain in a module.
> >   PCI: Add fwnode_handle to pci_sysdata
> >   PCI: irqdomain: Look up IRQ domain by fwnode_handle
> >   drivers:hv: Define the channel type of Hyper-V PCI Express
> >     pass-through
> >   PCI: hv: New paravirtual PCI front-end for Hyper-V VMs

That series cannot be ripped apart. The PCI part does not even compile
w/o the drivers/hv part in place.

Thanks,

	tglx
