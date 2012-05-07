Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 20/21] PCI: Register busn_res for iov bus
Date: Mon,  7 May 2012 13:30:05 -0700
Message-Id: <1336422606-4244-21-git-send-email-yinghai@kernel.org>
In-Reply-To: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Insert that to tree.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/iov.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index e873060..74bbaf8 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -47,7 +47,7 @@ static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
 	if (!child)
 		return NULL;
 
-	child->busn_res.end = busnr;
+	pci_bus_insert_busn_res(child, busnr, busnr);
 	child->dev.parent = bus->bridge;
 	rc = pci_bus_add_child(child);
 	if (rc) {
-- 
1.7.7

