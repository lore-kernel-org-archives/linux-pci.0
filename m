Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ey0-f202.google.com ([209.85.215.202]:40059 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688Ab2ARAfP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2012 19:35:15 -0500
Received: by eaaf1 with SMTP id f1so75968eaa.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2012 16:35:14 -0800 (PST)
Subject: [PATCH 3/4] PCI: restrict subordinate buses to those reachable via
	host bridge
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Tue, 17 Jan 2012 17:35:12 -0700
Message-ID: <20120118003512.467.60770.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
References: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When we scan the bus behind a bridge (pci_scan_bridge()), we sometimes
ignore any bus numbers assigned by the BIOS and try to assign our own
bus numbers.  But this can only work if the new bus number is inside
the range reachable via the host bridge.

This patch prevents us from creating a new bus under the wrong host
bridge.  (Obviously, if the arch doesn't tell the PCI core about the
host bridge configuration, we can't detect this problem, so this check
is only useful if the arch uses pci_scan_host_bridge() or similar.)

Here's a sample problem scenario:

    ACPI: PCI Root Bridge [VP18] (domain 0000 [bus 30-32])
    pci 0000:30:1e.0: PCI bridge to [bus 33-ff]
    pci 0000:33:00.0: PCI bridge to [bus 34-34]
    pci 0000:34:00.0: reg 10: [mem 0xe6100000-0xe613ffff 64bit]
    ACPI: PCI Root Bridge [VP10] (domain 0000 [bus 33-34])

We silently reconfigured 30:1e.0 (changing its subordinate buses from
[bus 31] to [bus 33-ff]) because the bridge looked "broken."  Devices on
bus 33 exist, but they are reached via the VP10 host bridge, *not* VP18.

The 33:00.0 resources must be allocated from VP10 host bridge windows,
not from VP18 windows.  We mistakenly think 33:00.0 is under VP18, so
we reallocate its resources from VP18 windows, and the device no longer
works.

Reference: https://bugzilla.novell.com/show_bug.cgi?id=735909
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 434475c..a0476b9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -616,8 +616,16 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 
 struct pci_bus *__ref pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr)
 {
+	struct pci_host_bridge *host_bridge = pci_host_bridge(dev);
 	struct pci_bus *child;
 
+	if (host_bridge &&
+	    (busnr < host_bridge->subordinate->start ||
+	     busnr > host_bridge->subordinate->end)) {
+		dev_info(&dev->dev, "secondary bus %02x unreachable via this host bridge\n", busnr);
+		return NULL;
+	}
+
 	child = pci_alloc_child_bus(parent, dev, busnr);
 	if (child) {
 		down_write(&pci_bus_sem);

