Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 19/29] PCI/syscall: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 17:49:14 -0500
Message-Id: <1511390964-9979-20-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Hard-coding the domain value as 0 because the domain information is not
coming from the userspace.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index 83efa00..e725f99 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -28,7 +28,7 @@
 		return -EPERM;
 
 	err = -ENODEV;
-	dev = pci_get_bus_and_slot(bus, dfn);
+	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
 	if (!dev)
 		goto error;
 
@@ -96,7 +96,7 @@
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	dev = pci_get_bus_and_slot(bus, dfn);
+	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
 	if (!dev)
 		return -ENODEV;
 
-- 
1.9.1
