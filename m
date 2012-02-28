Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:48917 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964808Ab2B1CLX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2012 21:11:23 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 07/18] PCI, sparc: Register busn_res for root buses
Date: Mon, 27 Feb 2012 18:09:58 -0800
Message-Id: <1330395009-29260-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330395009-29260-1-git-send-email-yinghai@kernel.org>
References: <1330395009-29260-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/pci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 253e8ac..57ffe31 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -705,6 +705,7 @@ struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	}
 	bus->secondary = pbm->pci_first_busno;
 	bus->subordinate = pbm->pci_last_busno;
+	pci_bus_insert_busn_res(bus, pbm->pci_first_busno, pbm->pci_last_busno);
 
 	pci_of_scan_bus(pbm, node, bus);
 	pci_bus_add_devices(bus);
-- 
1.7.7

