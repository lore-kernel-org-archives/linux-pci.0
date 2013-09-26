Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:29888
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754049Ab3IZWUv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2013 18:20:51 -0400
Message-ID: <1380234044.24959.339.camel@snotra.buserror.net>
Subject: Re: [PATCH 5/7] iommu: supress loff_t compilation error on powerpc
From: Scott Wood <scottwood@freescale.com>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"galak@kernel.crashing.org" <galak@kernel.crashing.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"agraf@suse.de" <agraf@suse.de>,
	Wood Scott-B07421 <B07421@freescale.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Date: Thu, 26 Sep 2013 17:20:44 -0500
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D07183CA4@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
	 <1379575763-2091-6-git-send-email-Bharat.Bhushan@freescale.com>
	 <1380127227.3030.316.camel@ul30vt.home>
	 <6A3DF150A5B70D4F9B66A25E3F7C888D07183CA4@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-09-25 at 22:53 -0500, Bhushan Bharat-R65777 wrote:
> 
> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Wednesday, September 25, 2013 10:10 PM
> > To: Bhushan Bharat-R65777
> > Cc: joro@8bytes.org; benh@kernel.crashing.org; galak@kernel.crashing.org; linux-
> > kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-
> > pci@vger.kernel.org; agraf@suse.de; Wood Scott-B07421; iommu@lists.linux-
> > foundation.org; Bhushan Bharat-R65777
> > Subject: Re: [PATCH 5/7] iommu: supress loff_t compilation error on powerpc
> > 
> > On Thu, 2013-09-19 at 12:59 +0530, Bharat Bhushan wrote:
> > > Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> > > ---
> > >  drivers/vfio/pci/vfio_pci_rdwr.c |    3 ++-
> > >  1 files changed, 2 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c
> > > b/drivers/vfio/pci/vfio_pci_rdwr.c
> > > index 210db24..8a8156a 100644
> > > --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> > > +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> > > @@ -181,7 +181,8 @@ ssize_t vfio_pci_vga_rw(struct vfio_pci_device *vdev, char
> > __user *buf,
> > >  			       size_t count, loff_t *ppos, bool iswrite)  {
> > >  	int ret;
> > > -	loff_t off, pos = *ppos & VFIO_PCI_OFFSET_MASK;
> > > +	loff_t off;
> > > +	u64 pos = (u64 )(*ppos & VFIO_PCI_OFFSET_MASK);
> > >  	void __iomem *iomem = NULL;
> > >  	unsigned int rsrc;
> > >  	bool is_ioport;
> > 
> > What's the compile error that this fixes?
> 
> I was getting below error; and after some googling I came to know that this is how it is fixed by other guys.
> 
> /home/r65777/linux-vfio/drivers/vfio/pci/vfio_pci_rdwr.c:193: undefined reference to `__cmpdi2'
> /home/r65777/linux-vfio/drivers/vfio/pci/vfio_pci_rdwr.c:193: undefined reference to `__cmpdi2'

It looks like PPC Linux implements __ucmpdi2, but not the signed
version.  That should be fixed, rather than hacking up random code to
avoid it.

-Scott



