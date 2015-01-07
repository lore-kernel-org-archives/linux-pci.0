Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36036 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752233AbbAGO5d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Jan 2015 09:57:33 -0500
Message-ID: <1420642644.6345.6.camel@redhat.com>
Subject: Re: [PATCH] PCI: Mark broken INTx masking for BENET devices
From: Alex Williamson <alex.williamson@redhat.com>
To: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ajit Kumar Khaparde <Ajit.Khaparde@Emulex.Com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Date: Wed, 07 Jan 2015 07:57:24 -0700
In-Reply-To: <be483be7-96b7-4aaf-8c70-5fecb6fcb324@CMEXHTCAS2.ad.emulex.com>
References: <1420424274-3194-1-git-send-email-gwshan@linux.vnet.ibm.com>
	 <be483be7-96b7-4aaf-8c70-5fecb6fcb324@CMEXHTCAS2.ad.emulex.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-01-07 at 04:29 +0000, Venkat Duvvuru wrote:
> Can someone please explain, why interrupt storm issue doesn't occur in non-VFIO scenario?

In a host driver scenario, the driver hopefully knows how to handle the
device in a way that interrupt masking is not needed.  If you're
comparing to legacy KVM device assignment, the answer is likely that
that code supports emulation of INTx using MSI.  This is a fairly kludgy
mode of operation that I'm not all the keen on implementing in VFIO.
The pci-assign driver can be forced to not use this mode, as it's been
found not to work universally, with the option prefer_msi=off.  Thanks,

Alex

> > -----Original Message-----
> > From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> > owner@vger.kernel.org] On Behalf Of Gavin Shan
> > Sent: Monday, January 05, 2015 7:48 AM
> > To: linux-pci@vger.kernel.org
> > Cc: Ajit Kumar Khaparde; bhelgaas@google.com; Gavin Shan
> > Subject: [PATCH] PCI: Mark broken INTx masking for BENET devices
> > 
> > Similar to commit 11e4253 ("PCI: Assume all Mellanox devices have
> > broken INTx masking"), when passing through following PCI device
> > using VFIO infrastructure, interrupt storm are reported. After
> > marking its INTx masking is broken, the interrupt storm isn't
> > raised again:
> > 
> >  # lspci -s 0000::.
> >  0000:01:00.0 Ethernet controller: Emulex Corporation \
> >               OneConnect 10Gb NIC (be3) (rev 02)
> >  0000:01:00.1 Ethernet controller: Emulex Corporation \
> >               OneConnect 10Gb NIC (be3) (rev 02)
> >  # lspci -n -s 0000::.
> >  0000:01:00.0 0200: 19a2:0710 (rev 02)
> >  0000:01:00.1 0200: 19a2:0710 (rev 02)
> > 
> > Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > ---
> >  drivers/pci/quirks.c    | 2 ++
> >  include/linux/pci_ids.h | 2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index ed6f89b..e823ac0 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3027,6 +3027,8 @@
> > DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8169,
> >  			 quirk_broken_intx_masking);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
> >  			 quirk_broken_intx_masking);
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BE, PCI_ANY_ID,
> > +			 quirk_broken_intx_masking);
> > 
> >  #ifdef CONFIG_ACPI
> >  /*
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index e63c02a..df70b76 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2481,6 +2481,8 @@
> >  #define PCI_DEVICE_ID_KORENIX_JETCARDF2	0x1700
> >  #define PCI_DEVICE_ID_KORENIX_JETCARDF3	0x17ff
> > 
> > +#define PCI_VENDOR_ID_BE		0x19a2
> > +
> >  #define PCI_VENDOR_ID_QMI		0x1a32
> > 
> >  #define PCI_VENDOR_ID_AZWAVE		0x1a3b
> > --
> > 1.8.3.2
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



