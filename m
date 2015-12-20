Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0127.outbound.protection.outlook.com ([207.46.100.127]:1340
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932104AbbLTFRh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Dec 2015 00:17:37 -0500
From: KY Srinivasan <kys@microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Jake Oshins <jakeo@microsoft.com>,
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
Date: Sun, 20 Dec 2015 05:03:14 +0000
Message-ID: <SN1PR0301MB1662C3B88AFAB732813B2626A0E30@SN1PR0301MB1662.namprd03.prod.outlook.com>
References: <1449701697-6366-1-git-send-email-jakeo@microsoft.com>
 <BY2PR0301MB16545331BCB31D708A74C583A0EE0@BY2PR0301MB1654.namprd03.prod.outlook.com>
 <alpine.DEB.2.11.1512191220180.28591@nanos>
 <BY2PR0301MB1654386EBABB31E51CC6E55BA0E20@BY2PR0301MB1654.namprd03.prod.outlook.com>
 <alpine.DEB.2.11.1512192119060.28591@nanos>
In-Reply-To: <alpine.DEB.2.11.1512192119060.28591@nanos>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx@linutronix.de]
> Sent: Saturday, December 19, 2015 12:21 PM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: Jake Oshins <jakeo@microsoft.com>; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; vkuznets@redhat.com; Haiyang Zhang
> <haiyangz@microsoft.com>; marc.zyngier@arm.com;
> bhelgaas@google.com; linux-pci@vger.kernel.org
> Subject: RE: [PATCH v9 0/7] PCI: hv: New paravirtual PCI front-end for Hyper-
> V VMs
> 
> On Sat, 19 Dec 2015, KY Srinivasan wrote:
> > > From: Thomas Gleixner [mailto:tglx@linutronix.de]
> > > On Tue, 15 Dec 2015, KY Srinivasan wrote:
> > > >
> > > > Of these 7 patches, Greg has committed all of the VMBUS
> > > > related supporting patches (3 patches). Thomas, can you
> > > > take the IRQ related patches through your tree.
> > >
> > > That does not make any sense.
> > >
> > > > > Jake Oshins (7):
> > > > >   drivers:hv: Export a function that maps Linux CPU num onto Hyper-V
> > > > >     proc num
> > > > >   drivers:hv: Export hv_do_hypercall()
> > > > >   PCI: Make it possible to implement a PCI MSI IRQ Domain in a
> module.
> > > > >   PCI: Add fwnode_handle to pci_sysdata
> > > > >   PCI: irqdomain: Look up IRQ domain by fwnode_handle
> > > > >   drivers:hv: Define the channel type of Hyper-V PCI Express
> > > > >     pass-through
> > > > >   PCI: hv: New paravirtual PCI front-end for Hyper-V VMs
> > >
> > > That series cannot be ripped apart. The PCI part does not even compile
> > > w/o the drivers/hv part in place.
> >
> > What I was proposing was that after you pick up the hv related patches in
> > Greg's tree in the next cycle, would you be willing to take the IRQ related
> > patches through your tree. Sorry for the confusion.
> 
> You mean: PCI: Make it possible to implement a PCI MSI IRQ Domain in a
> module.
> 
> Right? Aside from the misleading subject line, I can pick that one
> up. The rest wants to go through the PCI tree.

That is what I meant. Thanks Thomas.

K. Y
