Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35940 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbcCGHUN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2016 02:20:13 -0500
Received: by mail-wm0-f67.google.com with SMTP id l68so9156209wml.3
        for <linux-pci@vger.kernel.org>; Sun, 06 Mar 2016 23:20:12 -0800 (PST)
Date: Mon, 7 Mar 2016 08:20:54 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, linux-pci@vger.kernel.org,
	tiwai@suse.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, perex@perex.cz
Subject: Re: [PATCH resend] PCI: QEMU top-level IDs for (sub)vendor & device
Message-ID: <20160307072054.GB14170@phenom.ffwll.local>
References: <20160306220230.GB3720@orbis-terrarum.net>
 <20160307000837-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160307000837-mutt-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 07, 2016 at 12:09:51AM +0200, Michael S. Tsirkin wrote:
> On Sun, Mar 06, 2016 at 10:02:30PM +0000, Robin H. Johnson wrote:
> > Introduce PCI_VENDOR/PCI_SUBVENDOR/PCI_SUBDEVICE defines to replace the
> > constants scattered in the kernel already used to detect QEMU.
> > 
> > They are defined in the QEMU codebase per docs/specs/pci-ids.txt.
> > 
> > Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> > Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> PCI tree seems to make the most sense.
> Bjorn, can you merge this please?

Yeah, ack for merging through pci.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
-Daniel

> 
> > This change prompted by a near-miss in the review of recent change:
> > 'drm/i915: refine qemu south bridge detection'
> > 
> > This patch was previously sent to LKML 25 Jan 2016; and got some
> > reviews, but otherwise slipped through the cracks.
> > 
> > ---
> >  drivers/gpu/drm/bochs/bochs_drv.c   | 4 ++--
> >  drivers/gpu/drm/cirrus/cirrus_drv.c | 5 +++--
> >  drivers/virtio/virtio_pci_common.c  | 2 +-
> >  include/linux/pci_ids.h             | 4 ++++
> >  sound/pci/intel8x0.c                | 4 ++--
> >  5 files changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> > index 7f1a360..b332b4d3 100644
> > --- a/drivers/gpu/drm/bochs/bochs_drv.c
> > +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> > @@ -182,8 +182,8 @@ static const struct pci_device_id bochs_pci_tbl[] = {
> >  	{
> >  		.vendor      = 0x1234,
> >  		.device      = 0x1111,
> > -		.subvendor   = 0x1af4,
> > -		.subdevice   = 0x1100,
> > +		.subvendor   = PCI_SUBVENDOR_ID_REDHAT_QUMRANET,
> > +		.subdevice   = PCI_SUBDEVICE_ID_QEMU,
> >  		.driver_data = BOCHS_QEMU_STDVGA,
> >  	},
> >  	{
> > diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.c b/drivers/gpu/drm/cirrus/cirrus_drv.c
> > index b1619e2..7bc394e 100644
> > --- a/drivers/gpu/drm/cirrus/cirrus_drv.c
> > +++ b/drivers/gpu/drm/cirrus/cirrus_drv.c
> > @@ -33,8 +33,9 @@ static struct drm_driver driver;
> >  
> >  /* only bind to the cirrus chip in qemu */
> >  static const struct pci_device_id pciidlist[] = {
> > -	{ PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_5446, 0x1af4, 0x1100, 0,
> > -	  0, 0 },
> > +	{ PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_5446,
> > +	  PCI_SUBVENDOR_ID_REDHAT_QUMRANET, PCI_SUBDEVICE_ID_QEMU,
> > +	  0, 0, 0 },
> >  	{ PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_5446, PCI_VENDOR_ID_XEN,
> >  	  0x0001, 0, 0, 0 },
> >  	{0,}
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index 36205c2..127dfe4 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -467,7 +467,7 @@ static const struct dev_pm_ops virtio_pci_pm_ops = {
> >  
> >  /* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
> >  static const struct pci_device_id virtio_pci_id_table[] = {
> > -	{ PCI_DEVICE(0x1af4, PCI_ANY_ID) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID) },
> >  	{ 0 }
> >  };
> >  
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 37f05cb..6d249d3 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2506,6 +2506,10 @@
> >  
> >  #define PCI_VENDOR_ID_AZWAVE		0x1a3b
> >  
> > +#define PCI_VENDOR_ID_REDHAT_QUMRANET    0x1af4
> > +#define PCI_SUBVENDOR_ID_REDHAT_QUMRANET 0x1af4
> > +#define PCI_SUBDEVICE_ID_QEMU            0x1100
> > +
> >  #define PCI_VENDOR_ID_ASMEDIA		0x1b21
> >  
> >  #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
> > diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
> > index 42bcbac..12c2c18 100644
> > --- a/sound/pci/intel8x0.c
> > +++ b/sound/pci/intel8x0.c
> > @@ -2980,8 +2980,8 @@ static int snd_intel8x0_inside_vm(struct pci_dev *pci)
> >  		goto fini;
> >  
> >  	/* check for known (emulated) devices */
> > -	if (pci->subsystem_vendor == 0x1af4 &&
> > -	    pci->subsystem_device == 0x1100) {
> > +	if (pci->subsystem_vendor == PCI_SUBVENDOR_ID_REDHAT_QUMRANET &&
> > +	    pci->subsystem_device == PCI_SUBDEVICE_ID_QEMU) {
> >  		/* KVM emulated sound, PCI SSID: 1af4:1100 */
> >  		msg = "enable KVM";
> >  	} else if (pci->subsystem_vendor == 0x1ab8) {
> > -- 
> > 2.3.0
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
