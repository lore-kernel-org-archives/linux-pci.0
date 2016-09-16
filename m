Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        cov@codeaurora.org, alex.williamson@redhat.com,
        vikrams@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/5] PCI: handle CRS returned by device after FLR
Date: Fri, 16 Sep 2016 16:06:34 -0400
Message-Id: <1474056395-21843-6-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1474056395-21843-1-git-send-email-okaya@codeaurora.org>
References: <1474056395-21843-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

An endpoint is allowed to issue CRS following an FLR request to indicate
that it is not ready to accept new requests. Changing the polling mechanism
in FLR wait function to go read the vendor ID instead of the command/status
register. A CRS indication will only be given if the address to be read is
vendor ID.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e913467..1def11e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3729,7 +3729,8 @@ static void pci_flr_wait(struct pci_dev *dev)
 
 	do {
 		msleep(100);
-		pci_read_config_dword(dev, PCI_COMMAND, &id);
+		pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id,
+					   60 * 1000);
 	} while (i++ < 10 && id == ~0);
 
 	if (id == ~0)
-- 
1.9.1
