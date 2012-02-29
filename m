Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 22/39] PCI: release busn when removing bus
Date: Wed, 29 Feb 2012 15:07:21 -0800
Message-Id: <1330556858-11768-23-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
References: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/remove.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index fd77e2b..04a4861 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -68,6 +68,7 @@ void pci_remove_bus(struct pci_bus *pci_bus)
 
 	down_write(&pci_bus_sem);
 	list_del(&pci_bus->node);
+	pci_bus_release_busn_res(pci_bus);
 	up_write(&pci_bus_sem);
 	if (!pci_bus->is_added)
 		return;
-- 
1.7.7

