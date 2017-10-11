Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752130AbdJKNex (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Oct 2017 09:34:53 -0400
Date: Wed, 11 Oct 2017 08:34:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Dongdong Liu' <liudongdong3@huawei.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
        "charles.chenxin@huawei.com" <charles.chenxin@huawei.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH V4 2/2] PCI/portdrv: Add #defines for the AER and DPC
 Interrupt Message Number masks
Message-ID: <20171011133451.GG25517@bhelgaas-glaptop.roam.corp.google.com>
References: <1507719178-112556-1-git-send-email-liudongdong3@huawei.com>
 <1507719178-112556-3-git-send-email-liudongdong3@huawei.com>
 <063D6719AE5E284EB5DD2968C1650D6DD0091277@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD0091277@AcuExch.aculab.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 11, 2017 at 01:01:26PM +0000, David Laight wrote:
> From: Dongdong Liu
> > Sent: 11 October 2017 11:53
> > In the AER case, the mask isn't strictly necessary because there are no
> > higher-order bits above the Interrupt Message Number, but using a #define
> > will make it possible to grep for it.
> > 
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> > ---
> >  drivers/pci/pcie/portdrv_core.c | 4 ++--
> >  include/uapi/linux/pci_regs.h   | 2 ++
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> > index 9692379..2b48297 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -116,7 +116,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
> >  		 */
> >  		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> >  		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
> > -		entry = reg32 >> 27;
> > +		entry = (reg32 & PCI_ERR_ROOT_AER_IRQ) >> 27;
> 
> You've still got the hard coded 27 - which is almost more important than the mask.
> Perhaps define things so this is:
> 		entry = PCI_ERR_ROOT_AER_IRQ(reg32);
> 
> Think I'd shift then mask with 0x1f.

Personally, I prefer to have the mask unshifted so it's easy to see
where the fields are in the register and to compare them with the
spec, e.g.,

  #define  PCI_EXP_DEVCAP_PAYLOAD 0x00000007 /* Max_Payload_Size */
  #define  PCI_EXP_DEVCAP_PHANTOM 0x00000018 /* Phantom functions */
  #define  PCI_EXP_DEVCAP_EXT_TAG 0x00000020 /* Extended tags */

Should there be a #define for the shift?  Maybe.  It doesn't bother me
unless it's used in many places.  Here I think there'd only be one
use, so having it hard-coded along with the symbolic mask is enough
for me.  Sometimes too many #defines clutter up the include file.

Just my personal preferences.

Bjorn
