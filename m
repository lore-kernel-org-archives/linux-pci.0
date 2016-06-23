Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51736 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbcFWWQv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Jun 2016 18:16:51 -0400
Subject: [PATCH] PCI: PCI_PROBE_ONLY clean-up
To: Ralf Baechle <ralf@linux-mips.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-mips@linux-mips.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jayachandran C <jchandra@broadcom.com>,
	Ganesan Ramalingam <ganesanr@broadcom.com>,
	David Daney <david.daney@cavium.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Andy Isaacson <adi@hexapodia.org>,
	Yinghai Lu <yinghai@kernel.org>
Date: Thu, 23 Jun 2016 17:16:47 -0500
Message-ID: <20160623221441.3154.31310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ralf, et al,

Lorenzo is doing some nice cleanup of the PCI_PROBE_ONLY case.  Previous
situation:

  - PCI_PROBE_ONLY: all PCI BARs and windows are immutable, and we don't
    put those resources in the iomem_resource tree, and they don't show up
    in /proc/iomem.

  - !PCI_PROBE_ONLY: we use whatever existing BAR settings may have been
    done by firmware, we change them if we find conflicts, and we insert
    them all in the iomem_resource tree.

Lorenzo is changing the PCI_PROBE_ONLY case so the BARs and windows remain
immutable, but we insert the resources into the iomem_resource tree.

The ideal thing would be to remove the use of PCI_PROBE_ONLY completely,
and allow Linux to program BARs as necessary.  If the firmware *has*
programmed the BARs, we don't change them unless we find something broken,
so in most cases PCI_PROBE_ONLY is unnecessary.

There are several MIPS platforms (bcm1480, ip27, sb1250, virtio_guest, xlp,
xlr) that set PCI_PROBE_ONLY for reasons I don't know.  These were added
by:

  bcm1480
    Andrew Isaacson <adi@broadcom.com>
    dc41f94f7709 ("Support for the BCM1480 on-chip PCI-X bridge.")

  ip27
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>
    96173a6c4ebc ("[MIPS] IP27: misc fixes")

  virtio
    David Daney <david.daney@cavium.com>
    ae6e7e635c2c ("MIPS: paravirt: Add pci controller for virtio")

  xlp
    Ganesan Ramalingam <ganesanr@netlogicmicro.com>
    9bac624b0fe0 ("MIPS: Netlogic: XLP PCIe controller support.")

  xlr
    Jayachandran C <jayachandranc@netlogicmicro.com>
    9b130f8004e5 ("MIPS: XLR, XLS: Add PCI support.")

I suspect some of these uses are copied and not actually necessary.  If we
need to keep them, that's fine, but I would like to at least insert the
resources into the tree, as with the following patch.

Any thoughts on this would be appreciated.

The whole series as I propose to merge it is on my pci/resource branch
at [2].

[1] http://lkml.kernel.org/r/1465383890-13538-1-git-send-email-lorenzo.pieralisi@arm.com
[2] https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/resource

---

Bjorn Helgaas (1):
      MIPS/PCI: Claim bus resources on PCI_PROBE_ONLY set-ups


 arch/mips/pci/pci.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)
