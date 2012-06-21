Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Myron Stowe <myron.stowe@redhat.com>
Subject: [PATCH 5/9] parisc/PCI: move final fixup quirks from __init to
	__devinit
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux@arm.linux.org.uk,
	ralf@linux-mips.org, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, linux-kernel@vger.kernel.org
Date: Thu, 21 Jun 2012 14:24:47 -0600
Message-ID: <20120621202447.16865.32486.stgit@amt.stowe>
In-Reply-To: <20120621202415.16865.6226.stgit@amt.stowe>
References: <20120621202415.16865.6226.stgit@amt.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI subsystem's final fixups are executed once during boot, after the
pci-device is found.  As long as the system does not support hot-plug,
specifying __init is fine.

With hot-plug, either physically based hot-plug events or pseudo hot-plug
events such as "echo 1 > /sys/bus/pci/rescan", it is possible to remove a
PCI bus during run time and have it rediscovered which will require the
call of the fixups again in order for the device to function properly.

This patch prepares specific quirk(s) for use with hot-plug events.

Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
---

 drivers/parisc/superio.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/parisc/superio.c b/drivers/parisc/superio.c
index 5003458..2d24cf2 100644
--- a/drivers/parisc/superio.c
+++ b/drivers/parisc/superio.c
@@ -149,8 +149,7 @@ superio_interrupt(int parent_irq, void *devp)
 }
 
 /* Initialize Super I/O device */
-static void
-superio_init(struct pci_dev *pcidev)
+static void __devinit superio_init(struct pci_dev *pcidev)
 {
 	struct superio_device *sio = &sio_dev;
 	struct pci_dev *pdev = sio->lio_pdev;

