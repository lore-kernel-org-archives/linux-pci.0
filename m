Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: iproc: fix Stingray CRS defect handling
Date: Tue,  5 Sep 2017 09:19:45 +0200
Message-Id: <20170905072004.3959082-2-arnd@arndb.de>
In-Reply-To: <20170905072004.3959082-1-arnd@arndb.de>
References: <20170905072004.3959082-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The condition that was used to detect the PCI_EXP_RTCAP
flag access is wrong, as pointed out by gcc-8:

drivers/pci/host/pcie-iproc.c: In function 'iproc_pcie_config_read':
drivers/pci/host/pcie-iproc.c:531:22: error: bitwise comparison always evaluates to false [-Werror=tautological-compare]
   if ((where & ~0x3) == PCI_EXP_CAP + PCI_EXP_RTCAP)

This adds the same bit mask to the other end as well, so the
condition is evaluated correctly for any access.

Fixes: ac8d3e852f75 ("PCI: iproc: Work around Stingray CRS defects")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pcie-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index d7f4c29aed96..f2df9c2266b9 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -528,7 +528,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 			return ret;
 
 		/* Don't advertise CRS SV support */
-		if ((where & ~0x3) == PCI_EXP_CAP + PCI_EXP_RTCAP)
+		if ((where & ~0x3) == ((PCI_EXP_CAP + PCI_EXP_RTCAP) & ~0x03))
 			*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
 		return PCIBIOS_SUCCESSFUL;
 	}
-- 
2.9.0
