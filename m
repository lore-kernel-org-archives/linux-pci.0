Return-Path: <linux-kernel-owner@vger.kernel.org>
From: <suravee.suthikulpanit@amd.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>,
	Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>,
	Borislav Petkov <bp@suse.de>,
	"Robert Richter" <rric@kernel.org>,
	Daniel J Blueman <daniel@numascale.com>,
	Andreas Herrmann <herrmann.der.user@googlemail.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V4 3/4] ACPI/PCI: Warn if we have to "guess" host bridge node information
Date: Thu, 8 May 2014 11:44:20 -0500
Message-ID: <1399567461-15928-4-git-send-email-suravee.suthikulpanit@amd.com>
In-Reply-To: <1399567461-15928-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1399567461-15928-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Myron Stowe <myron.stowe@redhat.com>

The vast majority of platforms are not supplying ACPI _PXM (proximity)
information corresponding to host bridge (PNP0A03/PNP0A08) devices
resulting in sysfs "numa_node" values of -1 (NUMA_NO_NODE) [1]:
  # for i in /sys/devices/pci0000\:00/*/numa_node; do cat $i; done | uniq
  -1

  # find /sys/ -name "numa_node" | while read fname; do cat $fname; \
    done | uniq
  -1

AMD based platforms provide a fall-back for this situation via amd_bus.c.
These platforms snoop out the information by directly reading specific
registers from the Northbridge and caching them via 'alloc_pci_root_info'.

Later during boot processing when host bridges are discovered -
'pci_acpi_scan_root' - the kernel looks for their corresponding ACPI _PXM
method - drivers/acpi/numa.c::acpi_get_node().  If the BIOS supplied a
_PXM method then that node (proximity) value is associated.  If the BIOS
did not supply a _PXM method *and* the platform is AMD based, the
fall-back cached values obtained directly from the Northbridge are used;
otherwise, "NUMA_NO_NODE" is associated.

There are a number of issues with this fall-back mechanism the most
notable being that amd_bus.c extracts a 3-bit number from a CPU register
and uses it as the node number.  The node numbers used by Linux are
logical and there's no reason they need to be identical to settings in the
CPU registers.  So if we have some node information obtained in the normal
way (from _PXM, SLIT, SRAT, etc.) and some from amd_bus.c, there's no
reason to believe they will be compatible.

This patch warns when this situation occurs:
  pci_root PNP0A08:00: [Firmware Bug]: no _PXM; falling back to node 0 from hardware (may be inconsistent with ACPI node numbers)

[1] https://bugzilla.kernel.org/show_bug.cgi?id=72051

Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 arch/x86/pci/acpi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 01edac6..5075371 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -489,8 +489,12 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	}
 
 	node = acpi_get_node(device->handle);
-	if (node == NUMA_NO_NODE)
+	if (node == NUMA_NO_NODE) {
 		node = x86_pci_root_bus_node(busnum);
+		if (node != 0 && node != NUMA_NO_NODE)
+			dev_info(&device->dev, FW_BUG "no _PXM; falling back to node %d from hardware (may be inconsistent with ACPI node numbers)\n",
+				node);
+	}
 
 	if (node != NUMA_NO_NODE && !node_online(node))
 		node = NUMA_NO_NODE;
-- 
1.9.0

