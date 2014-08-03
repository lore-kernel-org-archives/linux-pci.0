Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56530 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378AbaHCPIP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 3 Aug 2014 11:08:15 -0400
Message-ID: <1407078486.14674.5.camel@ul30vt.home>
Subject: Re: [PATCH v2] PCI: Mark broken INTx masking for Mellanox devices
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Eli Cohen <eli@mellanox.com>, Amir Vadai <amirv@mellanox.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yevgeny Petrilin <yevgenyp@mellanox.com>,
	Peter Paneah <peter@mellanox.com>
Date: Sun, 03 Aug 2014 09:08:06 -0600
In-Reply-To: <20140803143007.GA4692@shangw>
References: <1406868871-350-1-git-send-email-gwshan@linux.vnet.ibm.com>
	 <53DDE9EC.5040303@mellanox.com> <20140803082046.GA8962@shangw>
	 <CFE9BFE80FFE4D4892AA5D31387E310F014FC1968B@MTLDAG02.mtl.com>
	 <20140803143007.GA4692@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2014-08-04 at 00:30 +1000, Gavin Shan wrote:
> On Sun, Aug 03, 2014 at 08:57:39AM +0000, Eli Cohen wrote:
> >>>
> >>>What is the problem with masking the interrupts with the PCI command 
> >>>register? I'm asking because I want to understand in which devices we 
> >>>have the problem, and if it could be fixed by firmware guys.
> >>>What are the implications of having the quirk?
> >>>
> >
> >>The way to mask the interrupt through PCI command register isn't taking effect on IBM power platform. So we have to have the >quirk so that the interrupt could be masked from interrupt controller side with function disable_irq_nosync().
> >>
> >>If the interrupt can't be masked properly, we detect interrupt storm reported from host/guest when passing through those devices >via VFIO without suprise.
> >
> >Hi Gavin,
> >Does it have any effect on performance. Also, can you tell in which cases interrupts need to be masked?
> >
> 
> Eli, more code needed to be run for masking the LSI from interrupt controller
> side than from PCI command register.
> 
> I was passing through Mellanox devices from host to guest with VFIO, and I
> designated to use LSI in the guest side. More details could be found in
> drivers/vfio/pci/vfio_pci_intrs.c::vfio_intx_handler()

INTx is relatively high overhead already for device assignment since the
interrupt is level triggered and needs to be masked on the host while
the guest is processing it.  The more important restriction imposed by
marking broken INTx masking is that the device needs an exclusive
interrupt line in order to be assigned to a guest.  That may be common
practice on IBM power, but on x86 it can make it much harder to
configure the system for this use case.  Thanks,

Alex


