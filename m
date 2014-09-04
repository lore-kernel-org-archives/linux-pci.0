Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:39854 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbaIDEcH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 00:32:07 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so590344pdj.38
        for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2014 21:32:05 -0700 (PDT)
Date: Wed, 3 Sep 2014 22:32:52 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Edward Cree <ecree@solarflare.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH trivial] PCI: convert struct pci_sriov comments to
 kernel-doc
Message-ID: <20140904043252.GH26073@google.com>
References: <alpine.LFD.2.03.1407311546190.19970@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.03.1407311546190.19970@solarflare.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 31, 2014 at 03:56:19PM +0100, Edward Cree wrote:
> No changes to the field descriptions, just move them.
> 
> Signed-off-by: Edward Cree <ecree@solarflare.com>
> ---
>  drivers/pci/pci.h | 50 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 16 deletions(-)

I don't think this is an improvement.  It adds 18 lines of code and moves
the description away from the actual field.  Does this make a major
improvement in kernel-doc somehow?  I have to admit that I only read the
code and never the kernel-doc.

> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 0601890..28fcce8 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -221,23 +221,41 @@ static inline int pci_ari_enabled(struct pci_bus *bus)
>  void pci_reassigndev_resource_alignment(struct pci_dev *dev);
>  void pci_disable_bridge_window(struct pci_dev *dev);
> 
> -/* Single Root I/O Virtualization */
> +/**
> + *     struct pci_sriov - Single Root I/O Virtualization
> + *
> + *     @pos:           capability position
> + *     @nres:          number of resources
> + *     @cap:           SR-IOV Capabilities
> + *     @ctrl:          SR-IOV Control
> + *     @total_VFs:     total VFs associated with the PF
> + *     @initial_VFs:   initial VFs associated with the PF
> + *     @num_vfs:       number of VFs available
> + *     @offset:        first VF Routing ID offset
> + *     @stride:        following VF stride
> + *     @pgsz:          page size for BAR alignment
> + *     @link:          Function Dependency Link
> + *     @driver_max_VFs:max num VFs driver supports
> + *     @dev:           lowest numbered PF
> + *     @self:          this PF
> + *     @lock:          lock for VF bus
> + */
>  struct pci_sriov {
> -       int pos;                /* capability position */
> -       int nres;               /* number of resources */
> -       u32 cap;                /* SR-IOV Capabilities */
> -       u16 ctrl;               /* SR-IOV Control */
> -       u16 total_VFs;          /* total VFs associated with the PF */
> -       u16 initial_VFs;        /* initial VFs associated with the PF */
> -       u16 num_VFs;            /* number of VFs available */
> -       u16 offset;             /* first VF Routing ID offset */
> -       u16 stride;             /* following VF stride */
> -       u32 pgsz;               /* page size for BAR alignment */
> -       u8 link;                /* Function Dependency Link */
> -       u16 driver_max_VFs;     /* max num VFs driver supports */
> -       struct pci_dev *dev;    /* lowest numbered PF */
> -       struct pci_dev *self;   /* this PF */
> -       struct mutex lock;      /* lock for VF bus */
> +       int pos;
> +       int nres;
> +       u32 cap;
> +       u16 ctrl;
> +       u16 total_VFs;
> +       u16 initial_VFs;
> +       u16 num_VFs;
> +       u16 offset;
> +       u16 stride;
> +       u32 pgsz;
> +       u8 link;
> +       u16 driver_max_VFs;
> +       struct pci_dev *dev;
> +       struct pci_dev *self;
> +       struct mutex lock;
>  };
> 
>  #ifdef CONFIG_PCI_ATS
> --
> 1.7.11.7
> The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
