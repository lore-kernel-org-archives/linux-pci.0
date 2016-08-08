Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39566 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295AbcHHOBk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Aug 2016 10:01:40 -0400
Date: Mon, 8 Aug 2016 09:01:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"hjk@hansjkoch.de" <hjk@hansjkoch.de>
Subject: Re: [PATCH] Extending kernel option pci=resource_alignment to be
 able to specify PCI device/vendor IDs
Message-ID: <20160808140127.GA14630@localhost>
References: <9224b5d57cf14c5da4979251742b838b@FE-MBX1012.de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9224b5d57cf14c5da4979251742b838b@FE-MBX1012.de.bosch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 08, 2016 at 07:39:01AM +0000, Koehrer Mathias (ETAS/ESW5) wrote:
> Hi Bjorn,
> 
> > On Tue, Jun 07, 2016 at 02:24:17PM +0000, Koehrer Mathias (ETAS/ESW5) wrote:
> > > Some uio based PCI drivers (e.g. uio_cif) do not work if the assigned
> > > PCI memory resources are not page aligned.
> > > By using the kernel option "pci=resource_alignment" it is possible to
> > > force single PCI boards to use page alignment for their memory resources.
> > > However, this is fairly cumbersome if multiple of these boards are in
> > > use as the specification of the cards has to be done via PCI
> > > bus/slot/function number which might change e.g. by adding another board.
> > > This patch extends the kernel option "pci=resource_alignment" to allow
> > > to specify the relevant boards via PCI device/vendor (and subdevice/subvendor)
> > ids.
> > > The specification of the devices via device/vendor is indicated by a
> > > leading string "pci:" as argument to "pci=resource_alignment".
> > > The format of the specification is
> > >   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
> > >
> > > Signed-off-by: Mathias Koehrer <mathias.koehrer@etas.com>
> > >
> > > ---
> > >  Documentation/kernel-parameters.txt |    2 +
> > >  drivers/pci/pci.c                   |   66 +++++++++++++++++++++++++-----------
> > >  2 files changed, 49 insertions(+), 19 deletions(-)
> > >
> > > Index: linux-4.7-rc1/Documentation/kernel-parameters.txt
> > >
> > ============================================================
> > =======
> > > --- linux-4.7-rc1.orig/Documentation/kernel-parameters.txt
> > > +++ linux-4.7-rc1/Documentation/kernel-parameters.txt
> > > @@ -2998,6 +2998,8 @@ bytes respectively. Such letter suffixes
> > >  		resource_alignment=
> > >  				Format:
> > >  				[<order of
> > align>@][<domain>:]<bus>:<slot>.<func>[; ...]
> > > +				[<order of align>@]pci:<vendor>:<device>\
> > > +						[:<subvendor>:<subdevice>][; ...]
> > 
> > Can you include a little example here so we know whether to use "pci:8086:1234" or
> > "pci:0x8086:0x1234"?
> > 
> > Bjorn
> 
> I have provided an example and extended the docu (sent in  http://marc.info/?l=linux-pci&m=146657769505684&w=2 and http://marc.info/?l=linux-pci&m=146918412704107&w=2 ).
> It would be great if you could comment on the modified patch...

It looks like I applied the patch, but I forgot to include the updated
documentation.  Can you confirm that?  If you send a documentation
patch to add the example, I can add that.

Bjorn
