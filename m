Return-Path: <mathias.koehrer@etas.com>
Return-Path: <mathias.koehrer@etas.com>
Subject: [PATCH] Extending kernel option pci=resource_alignment to be able to
 specify PCI device/vendor IDs - Documentation
To: Bjorn Helgaas <helgaas@kernel.org>
References: <9224b5d57cf14c5da4979251742b838b@FE-MBX1012.de.bosch.com>
 <20160808140127.GA14630@localhost>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
From: Mathias Koehrer <mathias.koehrer@etas.com>
Message-ID: <57A9955B.1050705@etas.com>
Date: Tue, 9 Aug 2016 10:33:31 +0200
MIME-Version: 1.0
In-Reply-To: <20160808140127.GA14630@localhost>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Extend the documentation for kernel option pci=resource_alignment

Some uio based PCI drivers (e.g. uio_cif) do not work if the assigned 
PCI memory resources are not page aligned.
By using the kernel option "pci=resource_alignment" it is possible to force
single PCI boards to use page alignment for their memory resources.
However, this is fairly cumbersome if multiple of these boards are in use as 
the specification of the cards has to be done via PCI bus/slot/function number
which might change e.g. by adding another board.
This patch extends the kernel option "pci=resource_alignment" to allow to
specify the relevant boards via PCI device/vendor (and subdevice/subvendor) ids.
The specification of the devices via device/vendor is indicated by a leading
string "pci:" as argument to "pci=resource_alignment".
The format of the specification is
  pci:<vendor>:<device>[:<subvendor>:<subdevice>]

Examples: 
  pci=resource_alignment=4096@pci:1234:abcd:1234:bcde
  pci=resource_alignment=pci:1234:abcd

Signed-off-by: Mathias Koehrer <mathias.koehrer@etas.com>

---
 pci/Documentation/kernel-parameters.txt |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pci-git/pci/Documentation/kernel-parameters.txt
===================================================================
--- linux-pci-git.orig/pci/Documentation/kernel-parameters.txt
+++ linux-pci-git/pci/Documentation/kernel-parameters.txt
@@ -3032,6 +3032,9 @@ bytes respectively. Such letter suffixes
 				PAGE_SIZE is used as alignment.
 				PCI-PCI bridge can be specified, if resource
 				windows need to be expanded.
+				To specify the alignment for certain types of devices, the
+				PCI vendor/device (and subvendor/subdevice) may be
+				specified. E.g. 4096@pci:1234:abcd:1234:bcde
 		ecrc=		Enable/disable PCIe ECRC (transaction layer
 				end-to-end CRC checking).
 				bios: Use BIOS/firmware settings. This is the
