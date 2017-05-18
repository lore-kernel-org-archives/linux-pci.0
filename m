Return-Path: <SRS0=ZFmV=4Y=linuxonhyperv.com=jloeser@kernel.org>
Return-Path: <SRS0=ZFmV=4Y=linuxonhyperv.com=jloeser@kernel.org>
From: Jork Loeser <jloeser@linuxonhyperv.com>
To: jloeser@microsoft.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com
Subject: [PATCH 1/4] Hyper-V vPCI: Minor format and semantic fix
Date: Thu, 18 May 2017 12:14:27 -0700
Message-Id: <1495134870-18225-2-git-send-email-jloeser@linuxonhyperv.com>
In-Reply-To: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
References: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
Reply-To: Jork Loeser <jloeser@microsoft.com>
List-ID: <linux-pci.vger.kernel.org>

From: Jork Loeser <jloeser@microsoft.com>

Fix comment formatting and use proper integer fields.

Signed-off-by: Jork Loeser <jloeser@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 8493638..7bebdc6 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -245,7 +245,7 @@ struct pci_packet {
 
 struct pci_version_request {
 	struct pci_message message_type;
-	enum pci_message_type protocol_version;
+	u32 protocol_version;
 } __packed;
 
 /*
@@ -1513,12 +1513,12 @@ static void pci_devices_present_work(struct work_struct *work)
 		put_pcichild(hpdev, hv_pcidev_ref_initial);
 	}
 
-	switch(hbus->state) {
+	switch (hbus->state) {
 	case hv_pcibus_installed:
 		/*
-		* Tell the core to rescan bus
-		* because there may have been changes.
-		*/
+		 * Tell the core to rescan bus
+		 * because there may have been changes.
+		 */
 		pci_lock_rescan_remove();
 		pci_scan_child_bus(hbus->pci_bus);
 		pci_unlock_rescan_remove();
-- 
1.7.1
