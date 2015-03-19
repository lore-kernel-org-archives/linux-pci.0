Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53763 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbbCSS5x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 19 Mar 2015 14:57:53 -0400
Date: Thu, 19 Mar 2015 19:57:38 +0100
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>
Subject: [PATCH v2 0/4] pci: fix unhandled interrupt on shutdown
Message-ID: <1426786724-22241-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fam Zheng noticed that pci shutdown disables msi and msix of a device while
device is still active. This was intended to fix kexec with fusion devices but
had the unintended effect of breaking even regular shutdown when using virtio.

The same problem would affect any driver which doesn't register
a level interrupt handler when using msix.

I think the fix is to avoid touching device on shutdown:
we clear bus master anyway, so we won't get any more
msi interrupts, and bus reset will clear the msi/msix
state eventually anyway.

The patches seems to all work well for me.  Given they affect all pci devices,
and the bug has been there since 2.6 times, I think there's no rush: we can
merge them for 4.1.

At the same time, once merged, they will likely make a good
stable candidate.

Michael S. Tsirkin (4):
  pci: disable msi/msix at probe time
  pci: don't disable msi/msix at shutdown
  pci: make msi/msix shutdown functions static
  virtio_pci: drop msi_off on probe

 include/linux/pci.h                | 4 ----
 drivers/pci/msi.c                  | 4 ++--
 drivers/pci/pci-driver.c           | 8 ++++++--
 drivers/virtio/virtio_pci_common.c | 3 ---
 4 files changed, 8 insertions(+), 11 deletions(-)

-- 
MST

