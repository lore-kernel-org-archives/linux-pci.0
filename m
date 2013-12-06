Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db8lp0189.outbound.messaging.microsoft.com ([213.199.154.189]:43548
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756607Ab3LFTAI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Dec 2013 14:00:08 -0500
Message-ID: <1386356393.7375.118.camel@snotra.buserror.net>
Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
From: Scott Wood <scottwood@freescale.com>
To: Bharat Bhushan <Bharat.Bhushan@freescale.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"agraf@suse.de" <agraf@suse.de>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 6 Dec 2013 12:59:53 -0600
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D07251EE4@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
	 <1384973243.2879.361.camel@ul30vt.home>
	 <6A3DF150A5B70D4F9B66A25E3F7C888D0721D9AC@039-SN2MPN1-012.039d.mgd.msft.net>
	 <1385066603.2879.414.camel@ul30vt.home>
	 <1385066835.1403.489.camel@snotra.buserror.net>
	 <1385067648.2879.421.camel@ul30vt.home>
	 <6A3DF150A5B70D4F9B66A25E3F7C888D0722C180@039-SN2MPN1-012.039d.mgd.msft.net>
	 <1385397493.2879.557.camel@ul30vt.home>
	 <6A3DF150A5B70D4F9B66A25E3F7C888D0723624C@039-SN2MPN1-012.039d.mgd.msft.net>
	 <1386289316.7375.107.camel@snotra.buserror.net>
	 <6A3DF150A5B70D4F9B66A25E3F7C888D07251EE4@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-12-05 at 22:11 -0600, Bharat Bhushan wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, December 06, 2013 5:52 AM
> > To: Bhushan Bharat-R65777
> > Cc: Alex Williamson; linux-pci@vger.kernel.org; agraf@suse.de; Yoder Stuart-
> > B08248; iommu@lists.linux-foundation.org; bhelgaas@google.com; linuxppc-
> > dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
> >
> > On Thu, 2013-11-28 at 03:19 -0600, Bharat Bhushan wrote:
> > >
> > > > -----Original Message-----
> > > > From: Bhushan Bharat-R65777
> > > > Sent: Wednesday, November 27, 2013 9:39 PM
> > > > To: 'Alex Williamson'
> > > > Cc: Wood Scott-B07421; linux-pci@vger.kernel.org; agraf@suse.de;
> > > > Yoder Stuart- B08248; iommu@lists.linux-foundation.org;
> > > > bhelgaas@google.com; linuxppc- dev@lists.ozlabs.org;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: RE: [PATCH 0/9 v2] vfio-pci: add support for Freescale
> > > > IOMMU (PAMU)
> > > >
> > > > If we just provide the size of MSI bank to userspace then userspace
> > > > cannot do anything wrong.
> > >
> > > So userspace does not know address, so it cannot mmap and cause any
> > interference by directly reading/writing.
> >
> > That's security through obscurity...  Couldn't the malicious user find out the
> > address via other means, such as experimentation on another system over which
> > they have full control?  What would happen if the user reads from their device's
> > PCI config space?  Or gets the information via some back door in the PCI device
> > they own?  Or pokes throughout the address space looking for something that
> > generates an interrupt to its own device?
> 
> So how to solve this problem, Any suggestion ?
> 
> We have to map one window in PAMU for MSIs and a malicious user can ask
> its device to do DMA to MSI window region with any pair of address and
> data, which can lead to unexpected MSIs in system?

I don't think there are any solutions other than to limit each bank to
one user, unless the admin turns some knob that says they're OK with the
partial loss of isolation.

-Scott



