Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388109AbeGWX1h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Jul 2018 19:27:37 -0400
Subject: [PATCH 0/2] PCI: NVMe reset quirk
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Date: Mon, 23 Jul 2018 16:24:14 -0600
Message-ID: <20180723221533.4371.90064.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As discussed in the 2nd patch, at least one NVMe controller sometimes
doesn't like being reset while enabled and another will timeout during
a subsequent re-enable if it happens too quickly after reset.
Introduce a device specific reset quirk for all NVMe class devices so
that we can try to get reliable behavior from them for device
assignment and any other users of the PCI subsystem reset interface.

Patches against current PCI next branch.  Thanks,

Alex

---

Alex Williamson (2):
      PCI: Export pcie_has_flr()
      PCI: NVMe device specific reset quirk


 drivers/pci/pci.c    |    3 +
 drivers/pci/quirks.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |    1 
 3 files changed, 115 insertions(+), 1 deletion(-)
