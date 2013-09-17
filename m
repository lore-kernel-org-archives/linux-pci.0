Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Veaceslav Falico <vfalico@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Veaceslav Falico <vfalico@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 1/3] msi: add forgotten pci_dev_put(pdev) to populate_msi_sysfs()
Date: Tue, 17 Sep 2013 03:47:42 +0200
Message-Id: <1379382464-7920-2-git-send-email-vfalico@redhat.com>
In-Reply-To: <1379382464-7920-1-git-send-email-vfalico@redhat.com>
References: <1379382464-7920-1-git-send-email-vfalico@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Before trying to kobject_init_and_add(), we add a reference to pdev via
pci_dev_get(pdev). However, if it fails to init and/or add the kobject, we
don't return it back - even on out_unroll.

Fix this by adding pci_dev_put(pdev) before going to unrolling section.

CC: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Veaceslav Falico <vfalico@redhat.com>
---
 drivers/pci/msi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d5f90d6..14bf578 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -534,8 +534,10 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 		pci_dev_get(pdev);
 		ret = kobject_init_and_add(kobj, &msi_irq_ktype, NULL,
 				     "%u", entry->irq);
-		if (ret)
+		if (ret) {
+			pci_dev_put(pdev);
 			goto out_unroll;
+		}
 
 		count++;
 	}
-- 
1.8.4

