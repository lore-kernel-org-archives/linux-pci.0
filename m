Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Myron Stowe <myron.stowe@redhat.com>
Subject: [PATCH -v2 1/3] PCI: Fix starting basis for resource requests
To: jbarnes@virtuousgeek.org
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org
Date: Mon, 21 Nov 2011 11:54:07 -0700
Message-ID: <20111121185407.9603.70264.stgit@amt.stowe>
In-Reply-To: <20111121185401.9603.34587.stgit@amt.stowe>
References: <20111121185401.9603.34587.stgit@amt.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Myron Stowe <mstowe@redhat.com>

pci_revert_fw_address() is used to reinstate a PCI device's original
FW-assigned BIOS BAR value(s) if normal resource assignment fails.

When attempting to reinstate an address, the point within the resource
tree from which to attempt the new resource request should be the parent
resource corresponding to the device, not the base of the resource tree
(ioport_resource or iomem_resource).  For PCI devices this would
typically be the resource corresponding to the upstream PCI host bridge
or P2P bridge aperture.

This patch sets the point within the resource tree to attempt a new
resource assignment request to the PCI device's parent resource and only
if that fails does it fall back to the base ioport_resource or
iomem_resource.

Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
---

 drivers/pci/setup-res.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 51a9095..cdfed4f 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -164,15 +164,19 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 	resource_size_t start, end;
 	int ret = 0;
 
-	if (res->flags & IORESOURCE_IO)
-		root = &ioport_resource;
-	else
-		root = &iomem_resource;
-
 	start = res->start;
 	end = res->end;
 	res->start = dev->fw_addr[resno];
 	res->end = res->start + size - 1;
+
+	root = pci_find_parent_resource(dev, res);
+	if (!root) {
+		if (res->flags & IORESOURCE_IO)
+			root = &ioport_resource;
+		else
+			root = &iomem_resource;
+	}
+
 	dev_info(&dev->dev, "BAR %d: trying firmware assignment %pR\n",
 		 resno, res);
 	conflict = request_resource_conflict(root, res);

