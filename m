Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46211 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752634AbcAHCBS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Jan 2016 21:01:18 -0500
Message-ID: <1452218477.29599.171.camel@redhat.com>
Subject: Re: FW: [PATCH 4.4-rc8] pci: Make 4K config space available for non
 PCI-e/PCI-X devices
From: Alex Williamson <alex.williamson@redhat.com>
To: "Ananth, Rajesh" <Rajesh.Ananth@smartm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Thu, 07 Jan 2016 19:01:17 -0700
In-Reply-To: <BLUPR0401MB168387B77DBE972BC1723D6894F50@BLUPR0401MB1683.namprd04.prod.outlook.com>
References: <BLUPR0401MB168387B77DBE972BC1723D6894F50@BLUPR0401MB1683.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2016-01-07 at 23:20 +0000, Ananth, Rajesh wrote:
> Resending this in PLAIN TEXT.
> 
> Description:
> 
> The Kernel PCI driver that probes the devices always reports the
> config space as 256 bytes for the PCI devices that are not PCI-e or
> PCI-X.  
> There are some vendor devices that are not PCI-e or PCI-X, but might
> have the configuration space data that is more than 256 bytes  in
> size to
> be made accessible through the standard sys-fs
> "/sys/bus/pci/devices/./config" link.  
> 
> Currently, the current Kernel does not provide the extended config
> space access for those devices, and a proprietary mechanism is
> oftentimes used by the vendor utilities to address that. As the
> problem could be seen, use of proprietary tools and utilities
> automatically
> leads to user confusion of using non-standard tools across different
> vendor devices.
> 
> Patch:
> 
> --- linux-4.4-rc8/drivers/pci/probe.c.orig      2016-01-07
> 13:30:54.310392700 -0800
> +++ linux-4.4-rc8/drivers/pci/probe.c   2016-01-07 13:32:14.586392700
> -0800
> @@ -1119,28 +1119,8 @@ static int pci_cfg_space_size_ext(struct
> 
> int pci_cfg_space_size(struct pci_dev *dev)
> {
> -       int pos;
> -       u32 status;
> -       u16 class;
> -
> -       class = dev->class >> 8;
> -       if (class == PCI_CLASS_BRIDGE_HOST)
> -               return pci_cfg_space_size_ext(dev);
> -
> -       if (!pci_is_pcie(dev)) {
> -               pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
> -               if (!pos)
> -                       goto fail;
> -
> -               pci_read_config_dword(dev, pos + PCI_X_STATUS,
> &status);
> -               if (!(status & (PCI_X_STATUS_266MHZ |
> PCI_X_STATUS_533MHZ)))
> -                       goto fail;
> -       }
> -
>         return pci_cfg_space_size_ext(dev);
> 
> - fail:
> -       return PCI_CFG_SPACE_SIZE;
> }

Just no.  Use quirks if there are specific devices which provide
extended config space in non-standard ways, don't impose this broken
behavior everywhere.  Thanks,

Alex
