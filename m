Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38880 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752955AbbIWTM2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Sep 2015 15:12:28 -0400
Subject: [PATCH 2/2] PCI: Clear IORESOURCE_UNSET when reverting to
 firmware-assigned address
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <helgaas@kernel.org>
Cc: kordikmarek@gmail.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	airlied@linux.ie, zermond@gmail.com, gob_iron@hotmail.com,
	weiyang.kernel@gmail.com, alexander.deucher@amd.com,
	niaminbox@gmail.com, Yinghai Lu <yinghai@kernel.org>
Date: Wed, 23 Sep 2015 14:12:24 -0500
Message-ID: <20150923191224.21781.65185.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150923191159.21781.66169.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150923191159.21781.66169.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

If pci_assign_resource() fails to assign space for a BAR, we may restore
the BAR to whatever firmware left there at boot-time (this depends on
whether the arch implements pcibios_retrieve_fw_addr()).  The messages we
print are not as useful as they could be:

  pci 0000:00:01.0: BAR 15: assigned [mem 0xc0000000-0xc01fffff 64bit pref]
  pci 0000:01:00.0: BAR 0: no space for [mem size 0x10000000 pref]
  pci 0000:01:00.0: BAR 0: trying firmware assignment [mem size 0x10000000 pref]
  pci 0000:01:00.0: BAR 0: [mem size 0x10000000 pref] conflicts with PCI Bus 0000:00 [mem 0xc0000000-0xffffffff window]

The last two lines should contain the actual BAR address, not the size.
Clear IORESOURCE_UNSET so we print the address.  If requesting the
firmware-assigned resource fails, mark it IORESOURCE_UNSET again.

This is a cosmetic change to clarify the message: previously, if
pci_revert_fw_address() succeeded, pci_assign_resource() cleared
IORESOURCE_UNSET anyway, so this isn't really a functional change.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=85491#c50
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-res.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 232f925..54c4f4f 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -177,6 +177,7 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 	end = res->end;
 	res->start = fw_addr;
 	res->end = res->start + size - 1;
+	res->flags &= ~IORESOURCE_UNSET;
 
 	root = pci_find_parent_resource(dev, res);
 	if (!root) {
@@ -194,6 +195,7 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 			 resno, res, conflict->name, conflict);
 		res->start = start;
 		res->end = end;
+		res->flags |= IORESOURCE_UNSET;
 		return -EBUSY;
 	}
 	return 0;

