Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0088.outbound.protection.outlook.com ([157.56.111.88]:39472
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753109AbcAGXxR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jan 2016 18:53:17 -0500
From: "Ananth, Rajesh" <Rajesh.Ananth@smartm.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: FW: [PATCH 4.4-rc8] pci: Make 4K config space available for non
 PCI-e/PCI-X devices
Date: Thu, 7 Jan 2016 23:20:01 +0000
Message-ID: <BLUPR0401MB168387B77DBE972BC1723D6894F50@BLUPR0401MB1683.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Resending this in PLAIN TEXT.

Description:

The Kernel PCI driver that probes the devices always reports the config space as 256 bytes for the PCI devices that are not PCI-e or PCI-X.  
There are some vendor devices that are not PCI-e or PCI-X, but might have the configuration space data that is more than 256 bytes  in size to
be made accessible through the standard sys-fs "/sys/bus/pci/devices/./config" link.  

Currently, the current Kernel does not provide the extended config space access for those devices, and a proprietary mechanism is
oftentimes used by the vendor utilities to address that. As the problem could be seen, use of proprietary tools and utilities automatically
leads to user confusion of using non-standard tools across different vendor devices.

Patch:

--- linux-4.4-rc8/drivers/pci/probe.c.orig      2016-01-07 13:30:54.310392700 -0800
+++ linux-4.4-rc8/drivers/pci/probe.c   2016-01-07 13:32:14.586392700 -0800
@@ -1119,28 +1119,8 @@ static int pci_cfg_space_size_ext(struct

int pci_cfg_space_size(struct pci_dev *dev)
{
-       int pos;
-       u32 status;
-       u16 class;
-
-       class = dev->class >> 8;
-       if (class == PCI_CLASS_BRIDGE_HOST)
-               return pci_cfg_space_size_ext(dev);
-
-       if (!pci_is_pcie(dev)) {
-               pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
-               if (!pos)
-                       goto fail;
-
-               pci_read_config_dword(dev, pos + PCI_X_STATUS, &status);
-               if (!(status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ)))
-                       goto fail;
-       }
-
        return pci_cfg_space_size_ext(dev);

- fail:
-       return PCI_CFG_SPACE_SIZE;
}

#define LEGACY_IO_RESOURCE     (IORESOURCE_IO | IORESOURCE_PCI_FIXED)


Developer's Certificate of Origin 1.1

By making a contribution to this project, I certify that:

(a) The contribution was created in whole or in part by me and I
    have the right to submit it under the open source license
    indicated in the file; or

(b) The contribution is based upon previous work that, to the best
    of my knowledge, is covered under an appropriate open source
    license and I have the right under that license to submit that
    work with modifications, whether created in whole or in part
    by me, under the same open source license (unless I am
    permitted to submit under a different license), as indicated
    in the file; or

(c) The contribution was provided directly to me by some other
     person who certified (a), (b) or (c) and I have not modified
     it.

(d) I understand and agree that this project and the contribution
     are public and that a record of the contribution (including all
     personal information I submit with it, including my sign-off) is
     maintained indefinitely and may be redistributed consistent with
    this project or the open source license(s) involved.

    Signed-off-by: Rajesh A Developer <rajesh.ananth@smartm.com>


