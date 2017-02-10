Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20997 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751847AbdBJSao (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Feb 2017 13:30:44 -0500
Date: Fri, 10 Feb 2017 13:38:52 -0500
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCHv6 3/5] pci: No config access for disconnected devices
Message-ID: <20170210183852.GD12778@localhost.localdomain>
References: <1486495957-26177-1-git-send-email-keith.busch@intel.com>
 <1486495957-26177-4-git-send-email-keith.busch@intel.com>
 <20170208060410.GA1026@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170208060410.GA1026@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 08, 2017 at 07:04:10AM +0100, Lukas Wunner wrote:
> On Tue, Feb 07, 2017 at 02:32:35PM -0500, Keith Busch wrote:
> > If we've  detected the PCI device is disconnected, there is no need to
> > attempt to access its config space since we know the operation will
> > fail. This patch has all the config reads and writes return -ENODEV
> > error immediately when in such a state.
> > 
> > If a config read is sent to a disconnected device, the value will be
> > set to all 1's. This is the same as what hardware is expected to return
> > when accessing a removed device, but software can do this faster without
> > relying on hardware.
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/pci/access.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > index d37b2ed..d63e9dd 100644
> > --- a/drivers/pci/access.c
> > +++ b/drivers/pci/access.c
> > @@ -892,12 +892,20 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
> >  
> >  int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
> >  {
> > +	if (pci_dev_is_disconnected(dev)) {
> 
> You used to have unlikely() here up until v4 but dropped it in v5.
> Why?  Seemed sensible to me.

Didn't mean to remove the unlikely. The micro-optimization isn't in a
performance path, but I'll build it back in.
