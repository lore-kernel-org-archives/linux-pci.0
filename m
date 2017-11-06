Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752822AbdKFTaW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Nov 2017 14:30:22 -0500
Date: Mon, 6 Nov 2017 13:30:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pankaj Dubey <pankaj.dubey@samsung.com>
Cc: David Laight <David.Laight@ACULAB.COM>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] PCI: dwc: designware: don't sleep in atomic context
Message-ID: <20171106193021.GE31930@bhelgaas-glaptop.roam.corp.google.com>
References: <CGME20171012075438epcas2p32599c2db4ed1512c81d1039bb1ed5607@epcas2p3.samsung.com>
 <1507794889-11148-1-git-send-email-pankaj.dubey@samsung.com>
 <063D6719AE5E284EB5DD2968C1650D6DD00924BC@AcuExch.aculab.com>
 <70cd34bd-01db-cd93-ddf7-d82114ccc61a@samsung.com>
 <20171020181917.GL6332@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171020181917.GL6332@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 20, 2017 at 01:19:17PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 13, 2017 at 09:10:38AM +0530, Pankaj Dubey wrote:
> > 
> > 
> > On 10/12/2017 04:09 PM, David Laight wrote:
> > >From: Pankaj Dubey
> > >>Sent: 12 October 2017 08:55
> > >>In pcie-designware.c many places we are calling "usleep_range" which
> > >>are in atomic context. This patch fixes these potential BUGs and
> > >>replaces "usleep_range" with mdelay calls.
> > >>
> > >>Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > >>---
> > >>  drivers/pci/dwc/pcie-designware.c | 8 ++++----
> > >>  drivers/pci/dwc/pcie-designware.h | 3 +--
> > >>  2 files changed, 5 insertions(+), 6 deletions(-)
> > >>
> > >>diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
> > >>index 88abddd..35d19b9 100644
> > >>--- a/drivers/pci/dwc/pcie-designware.c
> > >>+++ b/drivers/pci/dwc/pcie-designware.c
> > >>@@ -138,7 +138,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
> > >>  		if (val & PCIE_ATU_ENABLE)
> > >>  			return;
> > >>
> > >>-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> > >>+		mdelay(LINK_WAIT_IATU_MIN);
> > >>  	}
> > >Spinning for 9ms (possibly 10 times) isn't really a good idea.
> > 
> > Yes. It may not be a good idea, however in our experiment it never
> > hit maximum retry count.  I just converted usleep_range to mdelay
> > keeping min time limitation as it is, though I am not sure, how do
> > we arrived on these numbers in original code, may be Joao Pinto from
> > Synopsys have some idea, I will try to do few experiment and try to
> > find out what is sufficient minimum time in our hardware for these
> > mdelay.
> 
> Just based on the preceding comment, it looks like the wait is
> essential because subsequent config and I/O accesses won't work
> correctly until the ATU enable takes effect.
> 
> If we timeout here, I suspect it's because something is seriously
> wrong in the hardware, so I doubt there's any point in trying to
> minimize the timeout period.  If something is that broken, it doesn't
> matter whether we wait 9ms or 900ms.
> 
> Maybe the message should be more strident or maybe we should even
> return failure so the caller can do something, e.g., fail an access,
> instead of just printing an error and continuing on.
> 
> I'm also looking for an ack from Joao and/or Jingoo.

Dropping for lack of ack.
