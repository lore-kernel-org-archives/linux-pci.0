Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:8902 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966006AbdGTWuP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jul 2017 18:50:15 -0400
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
To: Roland Dreier <roland@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] PCI: Update ACS quirk for more Intel 10G NICs
Date: Thu, 20 Jul 2017 22:50:13 +0000
Message-ID: <87618083B2453E4A8714035B62D67992B3EABA2F@FMSMSX105.amr.corp.intel.com>
References: <20170720214101.7449-1-roland@kernel.org>
In-Reply-To: <20170720214101.7449-1-roland@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>-----Original Message-----
>From: Roland Dreier [mailto:roland@purestorage.com] On Behalf Of Roland
>Dreier
>Sent: Thursday, July 20, 2017 2:41 PM
>To: Bjorn Helgaas <bhelgaas@google.com>
>Cc: linux-pci@vger.kernel.org; netdev@vger.kernel.org; Tantilov, Emil S
><emil.s.tantilov@intel.com>
>Subject: [PATCH] PCI: Update ACS quirk for more Intel 10G NICs
>
>From: Roland Dreier <roland@purestorage.com>
>
>Add one more variant of the 82599 plus the device IDs for X540 and X550
>variants.  Intel has confirmed that none of these devices does peer-to-peer
>between functions.  The X540 and X550 have added ACS capabilities in their
>PCI config space, but the ACS control register is hard-wired to 0 for both
>devices, so we still need the quirk for IOMMU grouping to allow assignment
>of individual SR-IOV functions.
>
>Signed-off-by: Roland Dreier <roland@purestorage.com>
>---
> drivers/pci/quirks.c | 21 +++++++++++++++++++++
> 1 file changed, 21 insertions(+)

Acked-by: Emil Tantilov <emil.s.tantilov@intel.com>

Thanks,
Emil 
