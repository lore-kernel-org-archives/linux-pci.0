Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7508C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 12:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A6020855
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 12:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfAQMtm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:49:42 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:38348 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbfAQMtm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 07:49:42 -0500
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 17 Jan 2019 04:49:17 -0800
Received: from akaher-lnx-dev.eng.vmware.com (unknown [10.110.19.203])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 67EC6B1341;
        Thu, 17 Jan 2019 07:49:38 -0500 (EST)
From:   Ajay Kaher <akaher@vmware.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>
CC:     <devel@linuxdriverproject.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ajay Kaher <akaher@vmware.com>,
        Jork Loeser <jloeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/3] PCI: hv: Add vPCI version protocol negotiation
Date:   Fri, 18 Jan 2019 02:17:17 +0530
Message-ID: <1547758038-5255-3-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547758038-5255-1-git-send-email-akaher@vmware.com>
References: <1547758038-5255-1-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: akaher@vmware.com does not
 designate permitted sender hosts)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hyper-V vPCI offers different protocol versions.  Add the infra for
negotiating the one to use.

Signed-off-by: Jork Loeser <jloeser@microsoft.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: K. Y. Srinivasan <kys@microsoft.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Ajay Kaher <akaher@vmware.com>
---
 drivers/pci/host/pci-hyperv.c | 72 +++++++++++++++++++++++++++++++------------
 1 file changed, 53 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 9e44adf..6eed85b 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -65,22 +65,37 @@
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
@@ -1789,6 +1804,7 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev)
 	struct hv_pci_compl comp_pkt;
 	struct pci_packet *pkt;
 	int ret;
+	int i;
 
 	/*
 	 * Initiate the handshake with the host and negotiate
@@ -1805,26 +1821,44 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev)
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

