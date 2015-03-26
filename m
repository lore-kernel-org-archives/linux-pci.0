Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57290 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbbCZLh1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 26 Mar 2015 07:37:27 -0400
Date: Thu, 26 Mar 2015 12:37:24 +0100
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>
Subject: [PATCH v4 00/10] pci: fix unhandled interrupt on shutdown
Message-ID: <1427369811-11721-1-git-send-email-mst@redhat.com>
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

Patches 1-6 work well for me.
Given they affect all pci devices, and the bug has been there since 2.6 times,
I think there's no rush: we can merge them for 4.1.

At the same time, once merged, patches 1-4 will likely make a good stable
candidate.

Patches 7-10 compiled only, will need maintainer ack.

Please review, and consider at least 1-6 for 4.1.

Changes from v3:
	fix a copy-and-paste error in
	  pci: drop some duplicate code
	other patches are unchanged
	drop Cc stable for now
Changes from v2:
	move code from probe to device enumeration
	add patches to unexport pci_msi_off

Michael S. Tsirkin (11):
  pci: export functions for msi/msix ctrl
  pci: move pci_msi_init_pci_dev to pci.c
  pci: drop some duplicate code
  pci: don't disable msi/msix at shutdown
  pci: make msi/msix shutdown functions static
  virtio_pci: drop msi_off on probe
  ntb: drop pci_msi_off call on probe
  mic: drop pci_msi_off call on probe
  pci: drop pci_msi_off calls from quirks
  pci: unexport pci_msi_off

 drivers/pci/pci.h                  | 25 +++++++++++++--
 include/linux/pci.h                |  5 ---
 drivers/misc/mic/host/mic_intr.c   |  2 --
 drivers/ntb/ntb_hw.c               |  2 --
 drivers/pci/msi.c                  | 62 ++++++++------------------------------
 drivers/pci/pci-driver.c           |  2 --
 drivers/pci/pci.c                  | 24 +++------------
 drivers/pci/probe.c                | 16 ++++++++++
 drivers/pci/quirks.c               |  2 --
 drivers/virtio/virtio_pci_common.c |  3 --
 10 files changed, 56 insertions(+), 88 deletions(-)

-- 
MST

