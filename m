Return-Path: <SRS0=/aB5=46=linuxonhyperv.com=jloeser@kernel.org>
Return-Path: <SRS0=/aB5=46=linuxonhyperv.com=jloeser@kernel.org>
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
Subject: [PATCH-v2 4/5] Hyper-V vPCI: Add vPCI version protocol negotiation
Date: Wed, 24 May 2017 13:41:27 -0700
Message-Id: <1495658488-13199-5-git-send-email-jloeser@linuxonhyperv.com>
In-Reply-To: <1495658488-13199-1-git-send-email-jloeser@linuxonhyperv.com>
References: <1495658488-13199-1-git-send-email-jloeser@linuxonhyperv.com>
Reply-To: Jork Loeser <jloeser@microsoft.com>
List-ID: <linux-pci.vger.kernel.org>

From: Jork Loeser <jloeser@microsoft.com>

Hyper-V vPCI offers different protocol versions. This patch creates the
the infra for negotiating the one to use.

Signed-off-by: Jork Loeser <jloeser@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 72 +++++++++++++++++++++++++++++++------------
 1 file changed, 53 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index ee70b1f..2d69b00 100644
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
@@ -1849,6 +1864,7 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev)
 	struct hv_pci_compl comp_pkt;
 	struct pci_packet *pkt;
 	int ret;
+	int i;
 
 	/*
 	 * Initiate the handshake with the host and negotiate
@@ -1865,26 +1881,44 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev)
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
+		ret = vmbus_sendpacket(hdev->channel, version_req,
+				sizeof(struct pci_version_request),
+				(unsigned long)pkt, VM_PKT_DATA_INBAND,
+				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+		if (ret) {
+			dev_err(&hdev->device,
+				"PCI Pass-through VSP failed sending version reqquest: %#x",
+				ret);
+			goto exit;
+		}
 
-	wait_for_completion(&comp_pkt.host_event);
+		wait_for_completion(&comp_pkt.host_event);
 
-	if (comp_pkt.completion_status < 0) {
-		dev_err(&hdev->device,
-			"PCI Pass-through VSP failed version request %x\n",
-			comp_pkt.completion_status);
-		ret = -EPROTO;
-		goto exit;
+		if (comp_pkt.completion_status >= 0) {
+			pci_protocol_version = pci_protocol_versions[i];
+			dev_info(&hdev->device,
+				"PCI VMBus probing: Using version %#x\n",
+				pci_protocol_version);
+			goto exit;
+		}
+
+		if (comp_pkt.completion_status != STATUS_REVISION_MISMATCH) {
+			dev_err(&hdev->device,
+				"PCI Pass-through VSP failed version request: %#x",
+				comp_pkt.completion_status);
+			ret = -EPROTO;
+			goto exit;
+		}
+
+		reinit_completion(&comp_pkt.host_event);
 	}
 
-	ret = 0;
+	dev_err(&hdev->device,
+		"PCI pass-through VSP failed to find supported version");
+	ret = -EPROTO;
 
 exit:
 	kfree(pkt);
-- 
2.7.4
