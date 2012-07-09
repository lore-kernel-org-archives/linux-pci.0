Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Myron Stowe <myron.stowe@redhat.com>
Subject: [PATCH -v2 4/8] alpha/PCI: Move final fixup quirks from __init to
	__devinit
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, rth@twiddle.net,
	ink@jurassic.park.msu.ru, mattst88@gmail.com, ralf@linux-mips.org,
	tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
	yinghai@kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Jul 2012 15:36:21 -0600
Message-ID: <20120709213621.8975.97156.stgit@amt.stowe>
In-Reply-To: <20120709213554.8975.60552.stgit@amt.stowe>
References: <20120709213554.8975.60552.stgit@amt.stowe>
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

 arch/alpha/kernel/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 1a62963..a4681fe 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -106,7 +106,7 @@ quirk_cypress(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693, quirk_cypress);
 
 /* Called for each device after PCI setup is done. */
-static void __init
+static void __devinit
 pcibios_fixup_final(struct pci_dev *dev)
 {
 	unsigned int class = dev->class >> 8;

