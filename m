Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4618C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 19:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DC020838
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 19:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DC020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389495AbeKWGUo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:20:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56588 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731412AbeKWGUo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Nov 2018 01:20:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 946562F27;
        Thu, 22 Nov 2018 11:39:55 -0800 (PST)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 364CD3F575;
        Thu, 22 Nov 2018 11:39:52 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, joro@8bytes.org, mst@redhat.com
Cc:     jasowang@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com,
        bhelgaas@google.com, frowand.list@gmail.com,
        kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com
Subject: [PATCH v5 7/7] iommu/virtio: Add event queue
Date:   Thu, 22 Nov 2018 19:38:01 +0000
Message-Id: <20181122193801.50510-8-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
References: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The event queue offers a way for the device to report access faults from
endpoints. It is implemented on virtqueue #1. Whenever the host needs to
signal a fault, it fills one of the buffers offered by the guest and
interrupts it.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/virtio-iommu.c      | 115 +++++++++++++++++++++++++++---
 include/uapi/linux/virtio_iommu.h |  19 +++++
 2 files changed, 125 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 0c7a7fa2628d..e6ff515d41c0 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -29,7 +29,8 @@
 #define MSI_IOVA_LENGTH			0x100000
 
 #define VIOMMU_REQUEST_VQ		0
-#define VIOMMU_NR_VQS			1
+#define VIOMMU_EVENT_VQ			1
+#define VIOMMU_NR_VQS			2
 
 struct viommu_dev {
 	struct iommu_device		iommu;
@@ -41,6 +42,7 @@ struct viommu_dev {
 	struct virtqueue		*vqs[VIOMMU_NR_VQS];
 	spinlock_t			request_lock;
 	struct list_head		requests;
+	void				*evts;
 
 	/* Device configuration */
 	struct iommu_domain_geometry	geometry;
@@ -82,6 +84,15 @@ struct viommu_request {
 	char				buf[];
 };
 
+#define VIOMMU_FAULT_RESV_MASK		0xffffff00
+
+struct viommu_event {
+	union {
+		u32			head;
+		struct virtio_iommu_fault fault;
+	};
+};
+
 #define to_viommu_domain(domain)	\
 	container_of(domain, struct viommu_domain, domain)
 
@@ -503,6 +514,68 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 	return ret;
 }
 
+static int viommu_fault_handler(struct viommu_dev *viommu,
+				struct virtio_iommu_fault *fault)
+{
+	char *reason_str;
+
+	u8 reason	= fault->reason;
+	u32 flags	= le32_to_cpu(fault->flags);
+	u32 endpoint	= le32_to_cpu(fault->endpoint);
+	u64 address	= le64_to_cpu(fault->address);
+
+	switch (reason) {
+	case VIRTIO_IOMMU_FAULT_R_DOMAIN:
+		reason_str = "domain";
+		break;
+	case VIRTIO_IOMMU_FAULT_R_MAPPING:
+		reason_str = "page";
+		break;
+	case VIRTIO_IOMMU_FAULT_R_UNKNOWN:
+	default:
+		reason_str = "unknown";
+		break;
+	}
+
+	/* TODO: find EP by ID and report_iommu_fault */
+	if (flags & VIRTIO_IOMMU_FAULT_F_ADDRESS)
+		dev_err_ratelimited(viommu->dev, "%s fault from EP %u at %#llx [%s%s%s]\n",
+				    reason_str, endpoint, address,
+				    flags & VIRTIO_IOMMU_FAULT_F_READ ? "R" : "",
+				    flags & VIRTIO_IOMMU_FAULT_F_WRITE ? "W" : "",
+				    flags & VIRTIO_IOMMU_FAULT_F_EXEC ? "X" : "");
+	else
+		dev_err_ratelimited(viommu->dev, "%s fault from EP %u\n",
+				    reason_str, endpoint);
+	return 0;
+}
+
+static void viommu_event_handler(struct virtqueue *vq)
+{
+	int ret;
+	unsigned int len;
+	struct scatterlist sg[1];
+	struct viommu_event *evt;
+	struct viommu_dev *viommu = vq->vdev->priv;
+
+	while ((evt = virtqueue_get_buf(vq, &len)) != NULL) {
+		if (len > sizeof(*evt)) {
+			dev_err(viommu->dev,
+				"invalid event buffer (len %u != %zu)\n",
+				len, sizeof(*evt));
+		} else if (!(evt->head & VIOMMU_FAULT_RESV_MASK)) {
+			viommu_fault_handler(viommu, &evt->fault);
+		}
+
+		sg_init_one(sg, evt, sizeof(*evt));
+		ret = virtqueue_add_inbuf(vq, sg, 1, evt, GFP_ATOMIC);
+		if (ret)
+			dev_err(viommu->dev, "could not add event buffer\n");
+	}
+
+	virtqueue_kick(vq);
+}
+
 /* IOMMU API */
 
 static struct iommu_domain *viommu_domain_alloc(unsigned type)
@@ -885,16 +958,35 @@ static struct iommu_ops viommu_ops = {
 static int viommu_init_vqs(struct viommu_dev *viommu)
 {
 	struct virtio_device *vdev = dev_to_virtio(viommu->dev);
-	const char *name = "request";
-	void *ret;
+	const char *names[] = { "request", "event" };
+	vq_callback_t *callbacks[] = {
+		NULL, /* No async requests */
+		viommu_event_handler,
+	};
 
-	ret = virtio_find_single_vq(vdev, NULL, name);
-	if (IS_ERR(ret)) {
-		dev_err(viommu->dev, "cannot find VQ\n");
-		return PTR_ERR(ret);
-	}
+	return virtio_find_vqs(vdev, VIOMMU_NR_VQS, viommu->vqs, callbacks,
+			       names, NULL);
+}
 
-	viommu->vqs[VIOMMU_REQUEST_VQ] = ret;
+static int viommu_fill_evtq(struct viommu_dev *viommu)
+{
+	int i, ret;
+	struct scatterlist sg[1];
+	struct viommu_event *evts;
+	struct virtqueue *vq = viommu->vqs[VIOMMU_EVENT_VQ];
+	size_t nr_evts = vq->num_free;
+
+	viommu->evts = evts = devm_kmalloc_array(viommu->dev, nr_evts,
+						 sizeof(*evts), GFP_KERNEL);
+	if (!evts)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_evts; i++) {
+		sg_init_one(sg, &evts[i], sizeof(*evts));
+		ret = virtqueue_add_inbuf(vq, sg, 1, &evts[i], GFP_KERNEL);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -963,6 +1055,11 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	/* Populate the event queue with buffers */
+	ret = viommu_fill_evtq(viommu);
+	if (ret)
+		goto err_free_vqs;
+
 	ret = iommu_device_sysfs_add(&viommu->iommu, dev, NULL, "%s",
 				     virtio_bus_name(vdev));
 	if (ret)
diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index ae6145cf5928..ba1b460c9944 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -139,4 +139,23 @@ struct virtio_iommu_req_probe {
 	 */
 };
 
+/* Fault types */
+#define VIRTIO_IOMMU_FAULT_R_UNKNOWN		0
+#define VIRTIO_IOMMU_FAULT_R_DOMAIN		1
+#define VIRTIO_IOMMU_FAULT_R_MAPPING		2
+
+#define VIRTIO_IOMMU_FAULT_F_READ		(1 << 0)
+#define VIRTIO_IOMMU_FAULT_F_WRITE		(1 << 1)
+#define VIRTIO_IOMMU_FAULT_F_EXEC		(1 << 2)
+#define VIRTIO_IOMMU_FAULT_F_ADDRESS		(1 << 8)
+
+struct virtio_iommu_fault {
+	__u8					reason;
+	__u8					reserved[3];
+	__le32					flags;
+	__le32					endpoint;
+	__u8					reserved2[4];
+	__le64					address;
+};
+
 #endif
-- 
2.19.1

