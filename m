Return-Path: <SRS0=rB3A=LN=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=rB3A=LN=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Keith Busch <keith.busch@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sinan Kaya <okaya@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Stephen Bates <sbates@raithlin.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2] PCI: Equalize hotplug memory for non/occupied slots
Date: Thu, 30 Aug 2018 16:12:00 -0600
Message-Id: <1535667120-3002-2-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1535667120-3002-1-git-send-email-jonathan.derrick@intel.com>
References: <1535667120-3002-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Currently, a hotplug bridge will be given hpmemsize additional memory if
available, in order to satisfy any future hotplug allocation
requirements.

These calculations don't consider the current memory size of the hotplug
bridge/slot, so hotplug bridges/slots which have downstream devices will
get their current allocation in addition to the hpmemsize value.

This makes for possibly undesirable results with a mix of unoccupied and
occupied slots (ex, with hpmemsize=2M):

02:03.0 PCI bridge: <-- Occupied
	Memory behind bridge: d6200000-d64fffff [size=3M]
02:04.0 PCI bridge: <-- Unoccupied
	Memory behind bridge: d6500000-d66fffff [size=2M]

This change considers the current allocation size when using the
hpmemsize parameter to make the reservations predictable for the mix of
unoccupied and occupied slots:

02:03.0 PCI bridge: <-- Occupied
	Memory behind bridge: d6200000-d63fffff [size=2M]
02:04.0 PCI bridge: <-- Unoccupied
	Memory behind bridge: d6400000-d65fffff [size=2M]

The calculation for IO (hpiosize) should be similar, but platform
firmwares I've encountered (including QEMU) provide strict allocations
for IO and would not provide free IO resources for hotplug buses
in order to prove this calculation.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/setup-bus.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 79b1824..70d0aba 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -831,7 +831,8 @@ static resource_size_t calculate_iosize(resource_size_t size,
 
 static resource_size_t calculate_memsize(resource_size_t size,
 		resource_size_t min_size,
-		resource_size_t size1,
+		resource_size_t add_size,
+		resource_size_t children_add_size,
 		resource_size_t old_size,
 		resource_size_t align)
 {
@@ -841,7 +842,15 @@ static resource_size_t calculate_memsize(resource_size_t size,
 		old_size = 0;
 	if (size < old_size)
 		size = old_size;
-	size = ALIGN(size + size1, align);
+
+	/*
+	 * Consider the current allocation size when adding size for extra
+	 * hotplug memory. This ensures that occupied slots don't receive
+	 * unneccessary memory allocations in addition to their current size.
+	 * The calculation should be similar for calculate_iosize, but was
+	 * unable to be tested.
+	 */
+	size = ALIGN(max(size, add_size) + children_add_size, align);
 	return size;
 }
 
@@ -1079,12 +1088,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 	min_align = calculate_mem_align(aligns, max_order);
 	min_align = max(min_align, window_alignment(bus, b_res->flags));
-	size0 = calculate_memsize(size, min_size, 0, resource_size(b_res), min_align);
+	size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), min_align);
 	add_align = max(min_align, add_align);
-	if (children_add_size > add_size)
-		add_size = children_add_size;
-	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
-		calculate_memsize(size, min_size, add_size,
+	size1 = (!realloc_head || (realloc_head && !add_size && !children_add_size)) ? size0 :
+		calculate_memsize(size, min_size, add_size, children_add_size,
 				resource_size(b_res), add_align);
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
-- 
1.8.3.1
