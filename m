Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:36274 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeCUEKE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Mar 2018 00:10:04 -0400
Date: Wed, 21 Mar 2018 05:10:02 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v4 0/5] PCI endpoint 64-bit BAR fixes
Message-ID: <20180321041001.GA29527@axis.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
 <20180319165234.GA12486@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180319165234.GA12486@e107981-ln.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 19, 2018 at 04:52:34PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Mar 08, 2018 at 02:33:25PM +0100, Niklas Cassel wrote:
> > PCI endpoint fixes to improve the way 64-bit BARs are handled.
> > 
> > 
> > There are still future improvements that could be made:
> > 
> > pci-epf-test.c always allocates space for
> > 6 BARs, even when using 64-bit BARs (which
> > really only requires us to allocate 3 BARs).
> > 
> > pcitest.sh will print "NOT OKAY" for BAR1,
> > BAR3, and BAR5 when using 64-bit BARs.
> > This could probably be improved to say
> > something like "N/A (64-bit BAR)".
> > 
> > Niklas Cassel (5):
> >   PCI: endpoint: BAR width should not depend on sizeof dma_addr_t
> >   PCI: designware-ep: Make dw_pcie_ep_set_bar() handle 64-bit BARs
> >     properly
> >   PCI: designware-ep: Make dw_pcie_ep_reset_bar() handle 64-bit BARs
> >     properly
> >   PCI: endpoint: Make pci_epc_set_bar() return the BAR width that was
> >     set-up
> >   misc: pci_endpoint_test: Handle 64-bit BARs properly
> > 
> >  drivers/misc/pci_endpoint_test.c              | 12 +++++++-----
> >  drivers/pci/cadence/pcie-cadence-ep.c         |  2 +-
> >  drivers/pci/dwc/pcie-designware-ep.c          | 22 ++++++++++++++++++----
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 22 +++++++++++++++-------
> >  4 files changed, 41 insertions(+), 17 deletions(-)
> 
> Niklas,
> 
> I am fine with the series but I'd need Kishon ACKs (and Greg's for the
> last patch), I am ready to queue them then.


Hello Kishon,

could you please have a look at this series?


Kind regards,
Niklas
