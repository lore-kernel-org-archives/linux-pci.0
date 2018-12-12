Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D9FC65BAF
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 05:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C6020811
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 05:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QlIG4Ltx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C6020811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeLLFqu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:46:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41772 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeLLFqu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 00:46:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so16325421wrs.8
        for <linux-pci@vger.kernel.org>; Tue, 11 Dec 2018 21:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o9zOKa7UZo6O1oSXPaMqPu6Fib6WbxYaMCsnJYZwlo8=;
        b=QlIG4Ltxek1NO4qTDSHC89YHHCe0sh1RmxOpdVMF0Otf8WCvUKyW9zfoBCzj5jJy1Z
         aRmRd7aLNA5vekwKNUtlK0IaM9Yv/gj9MEwrtjTg+JdtdrFOaDTMLbeauVSbxDKj1Syb
         HMgN+e8vXZT0sbLe38HQRH5SZ36vVljbjYyMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o9zOKa7UZo6O1oSXPaMqPu6Fib6WbxYaMCsnJYZwlo8=;
        b=RGdTOPBXjHdhNVVOWIi1aq7Po/r4mebvgQTH0DcbPxqinl04c+JxNW3uLnRqtP53Yb
         OunUG5CwW0n4HrCrM/AWHnM9BVpGcCxRuC3xFKyCeQmGQQBZzXJMe4qltkJ16evbL8iE
         kCsfLziKdzuyO0AaU9Nhnk0Q3KEqR89FIF0o/dRG92PNwSPFa6/As5S001T5fBJeW7Oj
         /K1TNkDy+JGS51RjRpvST7K+JtHgJJduWxYUC7RnEcgefrsDVg7+5Zzr3R46CG3gegqs
         ildf1jyvBz42LD0qIRAtrwIYtzOZ9P2WxcgRb/jPUFt64c6vKiVvk9XvvI3ycPbk6lsI
         GFdQ==
X-Gm-Message-State: AA+aEWa/1E6e/LmBXyfkFF9HYb8l7PPl+9jMos0DfCbmumC+YqdVTd4+
        pHj9CPANAGoxpqU60tLBIl1iJw==
X-Google-Smtp-Source: AFSGD/W5fvf+7cGlVD1coGF/72gVx5nYO/sHP4U40r0vjs5KfAPR1WO+tTEdFzJ7o4gqCxb6UJXG6g==
X-Received: by 2002:adf:ae41:: with SMTP id u1mr15101050wrd.20.1544593608138;
        Tue, 11 Dec 2018 21:46:48 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z206sm2015947wmc.18.2018.12.11.21.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Dec 2018 21:46:47 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH 3/3] PCI: iproc: Add dma reserve resources to host
Date:   Wed, 12 Dec 2018 11:16:09 +0530
Message-Id: <1544593569-8923-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544593569-8923-1-git-send-email-srinath.mannam@broadcom.com>
References: <1544593569-8923-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IPROC host has the limitation that it can use
only those address ranges given by dma-ranges
property as inbound address.
So that the memory address holes in dma-ranges
should be reserved to allocate as DMA address.

All such reserved addresses are created as resource
entries and add to dma_resv list of pci host bridge.

These dma reserve resources created by parsing
dma-ranges parameter.

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
So that we need to add these address range to dma_resv
list to reserve their IOVA address ranges.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 3160e93..43e465a 100644
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
 			return ret;
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
 
+	end = ~0;
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

