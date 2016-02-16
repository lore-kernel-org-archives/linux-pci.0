Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:34078 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933325AbcBPXu0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 18:50:26 -0500
From: "Seymour, Shane M" <shane.seymour@hpe.com>
To: Hannes Reinecke <hare@suse.de>, Bjorn Helgaas <bhelgaas@google.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Babu Moger <babu.moger@oracle.com>,
	"Jordan Hargrave" <Jordan_Hargrave@dell.com>
Subject: RE: [PATCHv3 0/4] PCI VPD access fixes
Date: Tue, 16 Feb 2016 23:50:24 +0000
Message-ID: <DDB9C85B850785449757F9914A034FCB44531CFE@G4W3219.americas.hpqcorp.net>
References: <1455525722-122040-1-git-send-email-hare@suse.de>
In-Reply-To: <1455525722-122040-1-git-send-email-hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


For the series tested two PCIe cards that support VPD:

0d:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS2308 PCI-Express Fusion-MPT SAS-2 (rev 05)
1e:00.0 Fibre Channel: QLogic Corp. ISP2432-based 4Gb Fibre Channel to PCI Express HBA (rev 03)

The first card exposes 32KiB of NUL bytes as VPD and the second 154 bytes of non-NUL data repeating every 4KiB for 32KiB before the change. After the change the first  card returns no data for VPD (since it contains only NUL bytes) and the second the expected 154 bytes of data.

Using dyn debug also tested that this message comes out as expected for the LSI card (and it did):

[  289.539523] mpt3sas 0000:0d:00.0: invalid short VPD tag 00 at offset 1

lspci works correctly with the patch in the kernel. The only change on the system was that with the LSI card lspci with -vvvv as root it now says "Not readable"  instead of "Unknown small resource type 00, will not decode more." in the VPD section.
---
Tested-by: Shane Seymour <shane.seymour@hpe.com>

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Hannes Reinecke
> Sent: Monday, February 15, 2016 7:42 PM
> To: Bjorn Helgaas
> Cc: Alexander Duyck; linux-pci@vger.kernel.org; Babu Moger; Jordan
> Hargrave; Hannes Reinecke
> Subject: [PATCHv3 0/4] PCI VPD access fixes
> 
> the current PCI VPD page access assumes that the entire possible VPD data is
> readable. However, the spec only guarantees a VPD data up to the 'end'
> marker, with everything beyond that being undefined.
> This causes a system lockup on certain devices.
> 
> With this patch we always set the VPD sysfs attribute size to '0', and calculate
> the available VPD size on the first access.
> If no valid data can be read an I/O error is returned.
> 
> I've also included the patch from Babu to blacklists devices which are known
> to lockup when accessing the VPD data.
> 
> Changes to v2:
> - Spelling fixes as suggested by Bjorn Helgaas
> - Update to correct vpd size in pci_vpc_pci22_write
> - Pass in modified VPD size to pci_vpd_pci22_size() to make
>   quirk_brcm_570x_limit_vpd work
> 
> Babu Moger (1):
>   pci: Blacklist vpd access for buggy devices
> 
> Hannes Reinecke (3):
>   pci: Update VPD definitions
>   pci: allow access to VPD attributes with size '0'
>   pci: Determine actual VPD size on first access
> 
>  drivers/pci/access.c    | 84
> +++++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/pci/pci-sysfs.c | 22 +++++++------
>  drivers/pci/quirks.c    | 43 +++++++++++++++++++++++++
>  include/linux/pci.h     | 27 ++++++++++++++--
>  4 files changed, 162 insertions(+), 14 deletions(-)
> 
> --
> 1.8.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
