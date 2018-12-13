Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A130C67839
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DAD20811
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BuYqOYAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DAD20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeLMKdg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:33:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46739 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbeLMKdc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 05:33:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so1407854wrt.13
        for <linux-pci@vger.kernel.org>; Thu, 13 Dec 2018 02:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KsLuq/w2+4wqAK3w1JgIljoenhpHR4ZyQN2xHQt5mAo=;
        b=BuYqOYAGhory4gRz4+f3zZ1cpevXvNvZRNWlLzPUD53iF/w8IlaDeHT0wOw3Vplr10
         6WUvAg/kMiKqusZhcf9IU0jadnGSg4OflOBOPghzbU3NISvlQNgUpSKLZQ7ybqK/VRd0
         BraSgBOqy1xDUlmAwu2nFtf7JJTravNmW8z6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KsLuq/w2+4wqAK3w1JgIljoenhpHR4ZyQN2xHQt5mAo=;
        b=Xk4NfVzZkW6XeSAY1EGFSFXy61wh3Ev8C5i38Y4Sh0KcSPJIFjSFmnr51Jk0XAEPgI
         NplP+94Z2Pg31t0HD3yypKXCaR/DWQNPh+nMmkplOexuxkMNEJbJWMEKv06/0dOpZjxk
         OsNU9eE5m6FPT3ugCYEG/5cI8LhzTpzHqtEJJMIcaGY9AVeK4IeIxg0uw8O/8Di7w6kF
         A/gfKHbrNZGq0LZ526C0zf3C0GigGuzyh7seAw7vr7dUrKQYHKs6YGl1HntaRCelAh+q
         gL/PCCrchnG4hvystIhyYY1XMMHi/voCPxoCShRfRGzI6h6rfK81wz7W/HQKfxnQExKm
         Is1g==
X-Gm-Message-State: AA+aEWa50H4ROjnKrquBzrbF/PafnixQ+YUK7j4f6ETWRy1ewhQbgnIl
        dlzbfrj4VzHIeT/J9RixaC+pOA==
X-Google-Smtp-Source: AFSGD/UELeyC7vWsdTldPryopCXnyHUgRP0R9wNEeFAeaSxQ5osycF83oKahNPiRilY7IcU8mZWnIQ==
X-Received: by 2002:adf:84e4:: with SMTP id 91mr20254748wrg.237.1544697209674;
        Thu, 13 Dec 2018 02:33:29 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x76sm3327058wmd.27.2018.12.13.02.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 02:33:28 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>, poza@codeaurora.org,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 3/3] PCI: iproc: Add dma reserve resources to host
Date:   Thu, 13 Dec 2018 16:02:54 +0530
Message-Id: <1544697174-6029-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544697174-6029-1-git-send-email-srinath.mannam@broadcom.com>
References: <1544697174-6029-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IPROC host has the limitation that it can use only those address ranges
given by dma-ranges property as inbound address.
So that the memory address holes in dma-ranges should be reserved to
allocate as DMA address.

Inbound address of host accessed by pcie devices will not be translated
before it comes to IOMMU or directly to PE.
But the limitation of this host is, access to few address ranges are
ignored. So that IOVA ranges for these address ranges have to be reserved.

All such addresses ranges are created as resource entries by parsing
dma-ranges DT parameter and add to dma_resv list of pci host bridge.

Ex:
dma-ranges = < \
  0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
  0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
  0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>

In the above example of dma-ranges, memory address from
0x0 - 0x80000000,
0x100000000 - 0x800000000,
0x1000000000 - 0x8000000000 and
0x10000000000 - 0xffffffffffffffff.
are not allowed to use as inbound addresses.
So that we need to add these address ranges to dma_resv list to reserve
corresponding IOVA address ranges.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 51 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 3160e93..636e92d 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1154,25 +1154,74 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
 	return ret;
 }
 
+static int
+iproc_pcie_add_dma_resv_range(struct device *dev, struct list_head *resources,
+			      uint64_t start, uint64_t end)
+{
+	struct resource *res;
+
+	res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	res->start = (resource_size_t)start;
+	res->end = (resource_size_t)end;
+	pci_add_resource_offset(resources, res, 0);
+
+	return 0;
+}
+
 static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
 {
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
 	int ret;
+	uint64_t start, end;
+	LIST_HEAD(resources);
 
 	/* Get the dma-ranges from DT */
 	ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
 	if (ret)
 		return ret;
 
+	start = 0;
 	for_each_of_pci_range(&parser, &range) {
+		end = range.pci_addr;
+		/* dma-ranges list expected in sorted order */
+		if (end < start) {
+			ret = -EINVAL;
+			goto out;
+		}
 		/* Each range entry corresponds to an inbound mapping region */
 		ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_MEM);
 		if (ret)
-			return ret;
+			goto out;
+
+		if (end - start) {
+			ret = iproc_pcie_add_dma_resv_range(pcie->dev,
+							    &resources,
+							    start, end);
+			if (ret)
+				goto out;
+		}
+		start = range.pci_addr + range.size;
 	}
 
+	end = DMA_BIT_MASK(sizeof(dma_addr_t) * BITS_PER_BYTE);
+	if (end - start) {
+		ret = iproc_pcie_add_dma_resv_range(pcie->dev, &resources,
+						    start, end);
+		if (ret)
+			goto out;
+	}
+
+	list_splice_init(&resources, &host->dma_resv);
+
 	return 0;
+out:
+	pci_free_resource_list(&resources);
+	return ret;
 }
 
 static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
-- 
2.7.4

