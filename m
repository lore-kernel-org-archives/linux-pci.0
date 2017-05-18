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
Subject: [PATCH 2/4] Hyper-V vPCI: Use page allocation for hbus structure
Date: Thu, 18 May 2017 12:14:28 -0700
Message-Id: <1495134870-18225-3-git-send-email-jloeser@linuxonhyperv.com>
In-Reply-To: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
References: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
Reply-To: Jork Loeser <jloeser@microsoft.com>
List-ID: <linux-pci.vger.kernel.org>

From: Jork Loeser <jloeser@microsoft.com>

The hv_pcibus_device structure contains an in-memory hypercall argument
that must not cross a page boundary. Allocate the structure as a page
to ensure that.

Signed-off-by: Jork Loeser <jloeser@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 7bebdc6..aa836e9 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -2204,7 +2204,13 @@ static int hv_pci_probe(struct hv_device *hdev,
 	struct hv_pcibus_device *hbus;
 	int ret;
 
-	hbus = kzalloc(sizeof(*hbus), GFP_KERNEL);
+	/*
+	 * hv_pcibus_device contains the hypercall arguments for retargeting in
+	 * hv_irq_unmask(). Those must not cross a page boundary.
+	 */
+	BUILD_BUG_ON(sizeof(*hbus) > PAGE_SIZE);
+
+	hbus = (struct hv_pcibus_device *)get_zeroed_page(GFP_KERNEL);
 	if (!hbus)
 		return -ENOMEM;
 	hbus->state = hv_pcibus_init;
@@ -2308,7 +2314,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 close:
 	vmbus_close(hdev->channel);
 free_bus:
-	kfree(hbus);
+	free_page((unsigned long)hbus);
 	return ret;
 }
 
@@ -2386,7 +2392,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 	irq_domain_free_fwnode(hbus->sysdata.fwnode);
 	put_hvpcibus(hbus);
 	wait_for_completion(&hbus->remove_event);
-	kfree(hbus);
+	free_page((unsigned long)hbus);
 	return 0;
 }
 
-- 
1.7.1
