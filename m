Return-Path: <mathias.koehrer@etas.com>
Return-Path: <mathias.koehrer@etas.com>
From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "hjk@hansjkoch.de"
	<hjk@hansjkoch.de>
Subject: [PATCH v2] Extending kernel option pci=resource_alignment to be able
 to specify PCI device/vendor IDs
Date: Wed, 22 Jun 2016 06:33:48 +0000
Message-ID: <685172904b71405b8db8ff01516cdade@FE-MBX1012.de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Some uio based PCI drivers (e.g. uio_cif) do not work if the assigned=20
PCI memory resources are not page aligned.
By using the kernel option "pci=3Dresource_alignment" it is possible to for=
ce
single PCI boards to use page alignment for their memory resources.
However, this is fairly cumbersome if multiple of these boards are in use a=
s=20
the specification of the cards has to be done via PCI bus/slot/function num=
ber
which might change e.g. by adding another board.
This patch extends the kernel option "pci=3Dresource_alignment" to allow to
specify the relevant boards via PCI device/vendor (and subdevice/subvendor)=
 ids.
The specification of the devices via device/vendor is indicated by a leadin=
g
string "pci:" as argument to "pci=3Dresource_alignment".
The format of the specification is
  pci:<vendor>:<device>[:<subvendor>:<subdevice>]

Examples:=20
  pci=3Dresource_alignment=3D4096@pci:1234:abcd:1234:bcde
  pci=3Dresource_alignment=3Dpci:1234:abcd

Signed-off-by: Mathias Koehrer <mathias.koehrer@etas.com>

---
 Documentation/kernel-parameters.txt |    2 +
 drivers/pci/pci.c                   |   66 +++++++++++++++++++++++++------=
-----
 2 files changed, 49 insertions(+), 19 deletions(-)

Index: linux-4.7-rc1/Documentation/kernel-parameters.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-4.7-rc1.orig/Documentation/kernel-parameters.txt
+++ linux-4.7-rc1/Documentation/kernel-parameters.txt
@@ -2998,12 +2998,17 @@ bytes respectively. Such letter suffixes
 		resource_alignment=3D
 				Format:
 				[<order of align>@][<domain>:]<bus>:<slot>.<func>[; ...]
+				[<order of align>@]pci:<vendor>:<device>\
+						[:<subvendor>:<subdevice>][; ...]
 				Specifies alignment and device to reassign
 				aligned memory resources.
 				If <order of align> is not specified,
 				PAGE_SIZE is used as alignment.
 				PCI-PCI bridge can be specified, if resource
 				windows need to be expanded.
+				To specify the alignment for certain types of devices, the
+				PCI vendor/device (and subvendor/subdevice) may be
+				specified. E.g. 4096@pci:1234:abcd:1234:bcde
 		ecrc=3D		Enable/disable PCIe ECRC (transaction layer
 				end-to-end CRC checking).
 				bios: Use BIOS/firmware settings. This is the
Index: linux-4.7-rc1/drivers/pci/pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-4.7-rc1.orig/drivers/pci/pci.c
+++ linux-4.7-rc1/drivers/pci/pci.c
@@ -4755,6 +4755,7 @@ static DEFINE_SPINLOCK(resource_alignmen
 static resource_size_t pci_specified_resource_alignment(struct pci_dev *de=
v)
 {
 	int seg, bus, slot, func, align_order, count;
+	unsigned short vendor, device, subsystem_vendor, subsystem_device;
 	resource_size_t align =3D 0;
 	char *p;
=20
@@ -4768,28 +4769,55 @@ static resource_size_t pci_specified_res
 		} else {
 			align_order =3D -1;
 		}
-		if (sscanf(p, "%x:%x:%x.%x%n",
-			&seg, &bus, &slot, &func, &count) !=3D 4) {
-			seg =3D 0;
-			if (sscanf(p, "%x:%x.%x%n",
-					&bus, &slot, &func, &count) !=3D 3) {
-				/* Invalid format */
-				printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: %s\n",
-					p);
+		if (strncmp(p, "pci:", 4) =3D=3D 0) {
+			/* PCI vendor/device (subvendor/subdevice) ids are specified */
+			p +=3D 4;
+			if (sscanf(p, "%hx:%hx:%hx:%hx%n",
+				&vendor, &device, &subsystem_vendor, &subsystem_device, &count) !=3D 4=
) {
+				if (sscanf(p, "%hx:%hx%n", &vendor, &device, &count) !=3D 2) {
+					printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: pci:%=
s\n",
+						p);
+					break;
+				}
+				subsystem_vendor =3D subsystem_device =3D 0;
+			}
+			p +=3D count;
+			if ((!vendor || (vendor =3D=3D dev->vendor)) &&
+				(!device || (device =3D=3D dev->device)) &&
+				(!subsystem_vendor || (subsystem_vendor =3D=3D dev->subsystem_vendor))=
 &&
+				(!subsystem_device || (subsystem_device =3D=3D dev->subsystem_device))=
) {
+				if (align_order =3D=3D -1)
+					align =3D PAGE_SIZE;
+				else
+					align =3D 1 << align_order;
+				/* Found */
 				break;
 			}
 		}
-		p +=3D count;
-		if (seg =3D=3D pci_domain_nr(dev->bus) &&
-			bus =3D=3D dev->bus->number &&
-			slot =3D=3D PCI_SLOT(dev->devfn) &&
-			func =3D=3D PCI_FUNC(dev->devfn)) {
-			if (align_order =3D=3D -1)
-				align =3D PAGE_SIZE;
-			else
-				align =3D 1 << align_order;
-			/* Found */
-			break;
+		else {
+			if (sscanf(p, "%x:%x:%x.%x%n",
+				&seg, &bus, &slot, &func, &count) !=3D 4) {
+				seg =3D 0;
+				if (sscanf(p, "%x:%x.%x%n",
+						&bus, &slot, &func, &count) !=3D 3) {
+					/* Invalid format */
+					printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: %s\n"=
,
+						p);
+					break;
+				}
+			}
+			p +=3D count;
+			if (seg =3D=3D pci_domain_nr(dev->bus) &&
+				bus =3D=3D dev->bus->number &&
+				slot =3D=3D PCI_SLOT(dev->devfn) &&
+				func =3D=3D PCI_FUNC(dev->devfn)) {
+				if (align_order =3D=3D -1)
+					align =3D PAGE_SIZE;
+				else
+					align =3D 1 << align_order;
+				/* Found */
+				break;
+			}
 		}
 		if (*p !=3D ';' && *p !=3D ',') {
 			/* End of param or invalid format */
