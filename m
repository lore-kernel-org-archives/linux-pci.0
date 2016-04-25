Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32843 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932143AbcDYNzg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Apr 2016 09:55:36 -0400
Date: Mon, 25 Apr 2016 07:55:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Majd Dibbiny <majd@mellanox.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	"Noa Osherovich" <noaos@mellanox.com>
Subject: Re: [PATCH] PCI: Refine broken INTx masking for Mellanox devices
Message-ID: <20160425075535.6c297c26@ul30vt.home>
In-Reply-To: <cf7d745d-a43c-dcf7-e2e0-00afbbe26a72@mellanox.com>
References: <1461083616-30099-1-git-send-email-majd@mellanox.com>
	<20160419130435.7d681f6d@t450s.home>
	<7b67ed14-516d-aae9-2b72-6dae420caa65@mellanox.com>
	<cf7d745d-a43c-dcf7-e2e0-00afbbe26a72@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 25 Apr 2016 15:45:37 +0300
Majd Dibbiny <majd@mellanox.com> wrote:

> Hi Bjorn,
> 
> Can you please merge this?
> 
> Thanks
> 
> On 4/21/2016 10:12 AM, Majd Dibbiny wrote:
> >
> >
> > On 4/19/2016 10:04 PM, Alex Williamson wrote:  
> >> On Tue, 19 Apr 2016 19:33:36 +0300
> >> Majd Dibbiny <majd@mellanox.com> wrote:
> >>  
> >>> From: Noa Osherovich <noaos@mellanox.com>
> >>>
> >>> Mellanox devices were marked as having INTx masking ability broken.
> >>> As a result, the VFIO driver fails to load when the device was
> >>> passed-through to a VM.
> >>>
> >>> This patch excludes ConnectX-4, ConnectX4-Lx and Connect-IB from the
> >>> list of Mellanox devices marked as having broken INTx masking:
> >>>
> >>> - ConnectX-4 and ConnectX4-Lx either declare INTx are not supported
> >>>    (FW versions 12.14.2036 / 14.12.2036) or support them properly
> >>>    (starting May 2016 firmware release). Users having earlier firmware
> >>>    versions will have to update to either one.
> >>> - Connect-IB does not support INTx currently so will not cause any
> >>>    problem.  
> >> What's the user and support experience here?  A user gets a new kernel
> >> that no longer marks INTx masking as bad (note that if the device does
> >> not support INTx by returing 0 in the pin register, it doesn't matter
> >> whether it's marked bad or not), they try to assign the device and get
> >> an interrupt storm on the guest and go complain to support. Support
> >> tries to reproduce, maybe can, maybe can't, depending on the firmware
> >> version they happen to have running, everyone gets very unhappy until
> >> the thing that almost never works, "are you running the latest
> >> firmware", actually works.  Can we instead add a new function for
> >> mellanox that can probe the firmware version and continue marking INTx
> >> masking bad with a warning noting that a firmware update will resolve
> >> it?  Thanks,
> >>
> >> Alex  
> > Hi Alex,
> > I understand your concern and therefore we have documented this in our 
> > Release notes to ease the troubleshooting experience for everyone.. We 
> > have also added the Firmware versions in the commit messages to make 
> > it clearer...
> >
> > What do you think?

My comment is trying to highlight the problem that users are not likely
to check for updated firmware for every device *before* installing a new
kernel, so there's a reasonable chance that a user will see this change
first as a regression in the kernel.  So documentation in the firmware
release notes is really only going to help very meticulous users.  For
everyone else it still looks like a kernel regression and a detailed
commit log is an after the fact aid to resolving the problem.  So, is
there some way we can detect the firmware from the quirk and make a
determination whether to enable broken intx, with a dmesg entry
indicating to update device firmware?  Thanks,

Alex

> >>> Fixes: 11e42532ada31 ('PCI: Assume all Mellanox devices have ...')
> >>> Signed-off-by: Noa Osherovich <noaos@mellanox.com>
> >>> Signed-off-by: Majd Dibbiny <majd@mellanox.com>
> >>> ---
> >>>   drivers/pci/quirks.c    | 61 
> >>> ++++++++++++++++++++++++++++++++++++++++++++++++-
> >>>   include/linux/pci_ids.h | 14 ++++++++++++
> >>>   2 files changed, 74 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >>> index 8e67802..6a1856e 100644
> >>> --- a/drivers/pci/quirks.c
> >>> +++ b/drivers/pci/quirks.c
> >>> @@ -3147,7 +3147,66 @@ DECLARE_PCI_FIXUP_HEADER(0x1814, 0x0601, /* 
> >>> Ralink RT2800 802.11n PCI */
> >>>    */
> >>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8169,
> >>>                quirk_broken_intx_masking);
> >>> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
> >>> +
> >>> +/*
> >>> + * Mellanox devices that fail under PCI device assignment using 
> >>> DisINTx masking
> >>> + */
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 
> >>> PCI_DEVICE_ID_MELLANOX_TAVOR,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_TAVOR_BRIDGE,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 
> >>> PCI_DEVICE_ID_MELLANOX_ARBEL,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 
> >>> PCI_DEVICE_ID_MELLANOX_SINAI,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_SINAI_OLD,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_HERMON_SDR,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_HERMON_DDR,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_HERMON_QDR,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_HERMON_DDR_GEN2,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_HERMON_QDR_GEN2,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_HERMON_EN,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_HERMON_EN_GEN2,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_CONNECTX_EN,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_T_GEN2,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_GEN2,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_5_GEN2,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_CONNECTX2,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_CONNECTX3,
> >>> +             quirk_broken_intx_masking);
> >>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> >>> +             PCI_DEVICE_ID_MELLANOX_CONNECTX3_PRO,
> >>>                quirk_broken_intx_masking);
> >>>     static void quirk_no_bus_reset(struct pci_dev *dev)
> >>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> >>> index 247da8c..bc8918e 100644
> >>> --- a/include/linux/pci_ids.h
> >>> +++ b/include/linux/pci_ids.h
> >>> @@ -2262,6 +2262,20 @@
> >>>   #define PCI_DEVICE_ID_MELLANOX_ARBEL    0x6282
> >>>   #define PCI_DEVICE_ID_MELLANOX_SINAI_OLD 0x5e8c
> >>>   #define PCI_DEVICE_ID_MELLANOX_SINAI    0x6274
> >>> +#define PCI_DEVICE_ID_MELLANOX_HERMON_SDR 0x6340
> >>> +#define PCI_DEVICE_ID_MELLANOX_HERMON_DDR 0x634a
> >>> +#define PCI_DEVICE_ID_MELLANOX_HERMON_QDR 0x6354
> >>> +#define PCI_DEVICE_ID_MELLANOX_HERMON_DDR_GEN2 0x6732
> >>> +#define PCI_DEVICE_ID_MELLANOX_HERMON_QDR_GEN2 0x673c
> >>> +#define PCI_DEVICE_ID_MELLANOX_HERMON_EN 0x6368
> >>> +#define PCI_DEVICE_ID_MELLANOX_HERMON_EN_GEN2 0x6750
> >>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN 0x6372
> >>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_T_GEN2 0x675a
> >>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_GEN2 0x6764
> >>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_5_GEN2 0x6746
> >>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX2 0x676e
> >>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX3 0x1003
> >>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX3_PRO 0x1007
> >>>     #define PCI_VENDOR_ID_DFI        0x15bd  
> >  
> 

