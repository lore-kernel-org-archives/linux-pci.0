Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:56358
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933004AbaBURqA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 21 Feb 2014 12:46:00 -0500
From: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Architectural question regarding IOV support in Linux 3.13.4
Date: Fri, 21 Feb 2014 17:45:50 +0000
Message-ID: <B756807489D6244883AC0B799A6EEC15EAB2E8@storexdag02.amd.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


I am working with SR-IOV and I have a question regarding the function
sriov_init() in ../drivers/pci/iov.c (linux versions 3.4.9 and 3.13.4)

In sriov_init() the code first checks whether the PF is a Root complex 
 endpoint (0x9) or an Express Endpoint (0x0) as shown in the code 
 snippet below.  If it is neither it returns the No device error.

static int sriov_init(struct pci_dev *dev, int pos)
{
         int i;
         int rc;
         int nres;
         u32 pgsz;
         u16 ctrl, total, offset, stride;
         struct pci_sriov *iov;
         struct resource *res;
         struct pci_dev *pdev;

       if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END &&
             pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT)
                 return -ENODEV;

My question is why PCI_EXP_TYPE_LEG_END (0x1) is omitted as being a 
 valid endpoint.  By excluding Legacy endpoints it fails enabling 
 SR-IOV on a VGA PF.

Is there a design/specification reason why legacy was excluded or was 
 it just an assumption that VGA would never support SR-IOV?

If there is no valid reason to exclude PCI_EXP_TYPE_LEG_END, I would 
 like to discuss having it included as a valid endpoint for SR-IOV.

Thanks,
Kelly


