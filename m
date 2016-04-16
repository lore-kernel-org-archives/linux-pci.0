Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: RFC: automatic interrupt affinity for MSI/MSI-X capable devices
Date: Fri, 15 Apr 2016 18:35:44 -0700
Message-Id: <1460770552-31260-1-git-send-email-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series enhances the irq and PCI code to allow spreading around MSI and
MSI-X vectors so that they have per-cpu affinity if possible, or at least
per-node.  For that it takes the algorithm from blk-mq, moves it to
a common place, and makes it available through a vastly simplified PCI
interrupt allocation API.  It then switches blk-mq to be able to pick up
the queue mapping from the device if available, and demostrates all this
using the NVMe driver.

There is still some work todo, mostly related to handling PCI hotplug,
more details are in the individual patches.
