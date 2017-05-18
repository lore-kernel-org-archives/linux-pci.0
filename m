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
Subject: [PATCH 3/4] Hyper-V vPCI: Add vPCI version protocol negotiation
Date: Thu, 18 May 2017 12:14:29 -0700
Message-Id: <1495134870-18225-4-git-send-email-jloeser@linuxonhyperv.com>
In-Reply-To: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
References: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
Reply-To: Jork Loeser <jloeser@microsoft.com>
List-ID: <linux-pci.vger.kernel.org>

From: Jork Loeser <jloeser@microsoft.com>

Hyper-V vPCI offers different protocol versions. This patch creates the
the infra for negotiating the one to use.

Signed-off-by: Jork Loeser <jloeser@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c |   72 +++++++++++++++++++++++++++++-----------
 1 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index aa836e9..5f4e136 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -64,22 +64,37 @@
  * major version.
  */
 
-#define PCI_MAKE_VERSION(major, minor) ((u32)(((major) << 16) | (major)))
+#define PCI_MAKE_VERSION(major, minor) ((u32)(((major) << 16) | (minor)))
 #define PCI_MAJOR_VERSION(version) ((u32)(version) >> 16)
 #define PCI_MINOR_VERSION(version) ((u32)(version) & 0xff)
 
-enum {
-	PCI_PROTOCOL_VERSION_1_1 = PCI_MAKE_VERSION(1, 1),
-	PCI_PROTOCOL_VERSION_CURRENT = PCI_PROTOCOL_VERSION_1_1
+enum pci_protocol_version_t {
+	PCI_PROTOCOL_VERSION_1_1 = PCI_MAKE_VERSION(1, 1),	/* Win10 */
 };
 
 #define CPU_AFFINITY_ALL	-1ULL
+
+/*
+ * Supported protocol versions in the order of probing - highest go
+ * first.
+ */
+static enum pci_protocol_version_t pci_protocol_versions[] = {
+	PCI_PROTOCOL_VERSION_1_1,
+};
+
+/*
+ * Protocol version negotiated by hv_pci_protocol_negotiation().
+ */
+static enum pci_protocol_version_t pci_protocol_version;
+
 #define PCI_CONFIG_MMIO_LENGTH	0x2000
 #define CFG_PAGE_OFFSET 0x1000
 #define CFG_PAGE_SIZE (PCI_CONFIG_MMIO_LENGTH - CFG_PAGE_OFFSET)
 
 #define MAX_SUPPORTED_MSI_MESSAGES 0x400
 
+#define STATUS_REVISION_MISMATCH 0xC0000059
+
 /*
  * Message Types
  */
@@ -1796,6 +1811,7 @@ static void hv_pci_onchannelcallback(void *context)
  */
 static int hv_pci_protocol_negotiation(struct hv_device *hdev)
 {
+	size_t i;
 	struct pci_version_request *version_req;
 	struct hv_pci_compl comp_pkt;
 	struct pci_packet *pkt;
@@ -1816,28 +1832,44 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev)
 	pkt->compl_ctxt = &comp_pkt;
 	version_req = (struct pci_version_request *)&pkt->message;
 	version_req->message_type.type = PCI_QUERY_PROTOCOL_VERSION;
-	version_req->protocol_version = PCI_PROTOCOL_VERSION_CURRENT;
 
-	ret = vmbus_sendpacket(hdev->channel, version_req,
-			       sizeof(struct pci_version_request),
-			       (unsigned long)pkt, VM_PKT_DATA_INBAND,
-			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
-	if (ret)
-		goto exit;
+	for (i = 0; i < ARRAY_SIZE(pci_protocol_versions); i++) {
+		version_req->protocol_version = pci_protocol_versions[i];
+		ret = vmbus_sendpacket(
+			hdev->channel, version_req,
+			sizeof(struct pci_version_request),
+			(unsigned long)pkt, VM_PKT_DATA_INBAND,
+			VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+		if (ret)
+			goto exit;
 
-	wait_for_completion(&comp_pkt.host_event);
+		wait_for_completion(&comp_pkt.host_event);
 
-	if (comp_pkt.completion_status < 0) {
-		dev_err(&hdev->device,
-			"PCI Pass-through VSP failed version request %x\n",
-			comp_pkt.completion_status);
-		ret = -EPROTO;
-		goto exit;
-	}
+		dev_info(&hdev->device,
+			"PCI VMBus probing result version %x: %#x\n",
+			pci_protocol_versions[i], comp_pkt.completion_status);
 
-	ret = 0;
+		if (comp_pkt.completion_status >= 0) {
+			pci_protocol_version = pci_protocol_versions[i];
+			break;
+		}
+
+		if (comp_pkt.completion_status != STATUS_REVISION_MISMATCH) {
+			dev_err(&hdev->device,
+				"PCI Pass-through VSP failed version request: %#x\n",
+				comp_pkt.completion_status);
+			ret = -EPROTO;
+			break;
+		}
+
+		reinit_completion(&comp_pkt.host_event);
+	}
 
 exit:
+	dev_info(&hdev->device,
+		"PCI VMBus probing: Using version %#x\n",
+		pci_protocol_version);
+
 	kfree(pkt);
 	return ret;
 }
-- 
1.7.1
