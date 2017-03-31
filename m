Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933005AbdCaAJK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Mar 2017 20:09:10 -0400
Date: Thu, 30 Mar 2017 19:09:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Himanshu Madhani <himanshu.madhani@cavium.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] PCI/MSI: Only disable affinity settings if pre and post
 vector count is equal to max_vecs and not min_vecs
Message-ID: <20170331000905.GE3912@bhelgaas-glaptop.roam.corp.google.com>
References: <20170301233158.1035-1-himanshu.madhani@cavium.com>
 <20170323172928.GA23612@bhelgaas-glaptop.roam.corp.google.com>
 <20170330232120.GC2496@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.DEB.2.20.1703301622500.23529@dut5108.mv.qlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1703301622500.23529@dut5108.mv.qlogic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 30, 2017 at 04:25:54PM -0700, Himanshu Madhani wrote:
> 
> Hi Bjorn,
> 
> On Thu, 30 Mar 2017, 4:21pm, Bjorn Helgaas wrote:
> 
> > On Thu, Mar 23, 2017 at 12:29:28PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Mar 01, 2017 at 03:31:58PM -0800, Himanshu Madhani wrote:
> > > > From: Michael Hernandez <michael.hernandez@cavium.com>
> > > > 
> > > > min_vecs is the minimum amount of vectors needed to operate in MSI-X mode
> > > > which may just include the vectors that don't need affinity.
> > > > 
> > > > Disabling affinity settings causes the qla2xxx driver scsi_add_host
> > > > to fail when blk_mq is enabled as the blk_mq_pci_map_queues expects
> > > > affinity masks on each vector.
> > > > 
> > > > v2 --> v3
> > > > o fixed code as per review comments.
> > > > 
> > > > v1 --> v2
> > > > 
> > > > o Moved the check from pci_alloc_irq_vectors_affinity() to
> > > >   __pci_enable_{msi|msix}_range()
> > > > 
> > > > Fixes: dfef358 ("PCI/MSI: Don't apply affinity if there aren't enough vectors left")
> > > > Signed-off-by: Michael Hernandez <michael.hernandez@cavium.com>
> > > > Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
> > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > >  drivers/pci/msi.c |   25 ++++++++++++++++++-------
> > > >  1 files changed, 18 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > > > index 7f73bac..46c0cdd 100644
> > > > --- a/drivers/pci/msi.c
> > > > +++ b/drivers/pci/msi.c
> > > > @@ -1091,6 +1091,15 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
> > > >  
> > > >  	for (;;) {
> > > >  		if (affd) {
> > > > +			/*
> > > > +			 * If there aren't any vectors left after applying the
> > > > +			 * pre/post vectors don't bother with assigning
> > > > +			 * affinity.
> > > > +			 */
> > > > +			if (affd->pre_vectors + affd->post_vectors == nvec)
> > > > +				affd = NULL;
> > > > +		}
> > > 
> > > I don't really like this because affd->pre_vectors and
> > > affd->post_vectors are not PCI MSI concepts.  I think they really
> > > belong in irq/affinity.c, e.g., maybe this could be checked in
> > > irq_create_affinity_masks().
> > > 
> > > If that could be done, we wouldn't have to duplicate the checks here
> > > for both MSI and MSI-X.
> > > 
> > > I raised a similar question earlier:
> > > http://lkml.kernel.org/r/20170202173659.GD21267@bhelgaas-glaptop.roam.corp.google.com
> > 
> > I want to make progress on this, but that means a little conversation
> > here.  Maybe we want to merge this patch as-is, but I'd like to hear
> > the reasons why it wouldn't really work to move the checks to
> > irq/affinity.c.
> > 
> > For now I'll mark it as "changes requested" in patchwork, which means
> > it will fall off my to-do list until it's reposted.
> >
> 
> Sorry for going silent on this patch. We've been working internally to 
> update patch as per your suggestion. I am planning to repost new patch 
> once we have completed our testing.  I should be able to post updated 
> patch sometimes next week for your review. 

Great, thanks!  I just wanted to make sure we weren't each waiting for
the other.  I appreciate your willingness to investigate other
options.

Bjorn
