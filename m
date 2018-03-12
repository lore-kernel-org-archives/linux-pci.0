Return-Path: <SRS0=wZJV=GC=suse.de=jthumshirn@kernel.org>
Return-Path: <SRS0=wZJV=GC=suse.de=jthumshirn@kernel.org>
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Michael Moese <mmoese@suse.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-pci@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	=?UTF-8?q?Andreas=20Gei=C3=9Fler?= <andreas.geissler@men.de>
Subject: [PATCH v3 2/2] mcb: add Altera PCI ID to mcb-pci
Date: Mon, 12 Mar 2018 10:41:19 +0100
Message-Id: <20180312094119.5298-3-jthumshirn@suse.de>
In-Reply-To: <20180312094119.5298-1-jthumshirn@suse.de>
References: <20180312094119.5298-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Some older PCI attached MEN FPGAs use an Altera PCI Vendor ID instead
of the MEN one. Add it to the PCI ID table so the driver automatically
attaches to it.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reported-by: Ben Turner <ben.turner@21net.com>
Tested-by: Ben Turner <ben.turner@21net.com>
Cc: Andreas Geißler <andreas.geissler@men.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---
Changes to v2:
- Add Andy's review

Changes to v1:
- Removed redundant include of pci_ids.h
---
 drivers/mcb/mcb-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index af4d2f26f1c6..c2d69e33bf2b 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -117,6 +117,7 @@ static void mcb_pci_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id mcb_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEN, PCI_DEVICE_ID_MEN_CHAMELEON) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ALTERA, PCI_DEVICE_ID_MEN_CHAMELEON) },
 	{ 0 },
 };
 MODULE_DEVICE_TABLE(pci, mcb_pci_tbl);
-- 
2.13.6
