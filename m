Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE68C282C2
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 10:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7291D2184B
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 10:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Walw7LEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfAYKOU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:14:20 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35559 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfAYKOT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2019 05:14:19 -0500
Received: by mail-yb1-f194.google.com with SMTP id h81so3626317ybg.2
        for <linux-pci@vger.kernel.org>; Fri, 25 Jan 2019 02:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aQQQit55QHmXJGswuIk2GPbriFh4OnO1XEAJH5iCl+Q=;
        b=Walw7LEmrY78/PaXGY6jSqrM8c54p67KPHDtUSooLKJuYtwU7JMxagTyaq7ukxU+/2
         MrRHR1Ypi+ofX4HJSEuvNLO0+KdgPVktntpdPyW8nNPoTLc2QwZ1fh/h9gjefDYKgmto
         6z9Clk39QInS9bM9kjuCJuEnidP5cOjsNPkIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aQQQit55QHmXJGswuIk2GPbriFh4OnO1XEAJH5iCl+Q=;
        b=a9Ej+XrM5N0jAteLnzZvEqYm+dM9pcWB52C0VAfDsr/igjp3EwjGndDsAylwMxmFkB
         Uqb/j70+ePswyceQjx32OVa2Fz0xK0C3cxMKYpO0C6lDzO1S0416HBMZCGbZa4bBsQyA
         bFfUXhk6AqLYAepKgefZyTbJw/Qbf3Wj/+8z/fRKkpVyhbZPkjWeEe+PZNU0IRnlNEDs
         EC1ECwUGaULL5Ax/z/j23deR7GnnVruDqB9ZNvTtN8QR3jRueZ576W8rEOdc9RZE1SMu
         iJ3eKKlJTb4nJAKwqO4zMkiEaRmYcsBwImhZDqg+27JU7c2fbML/uDTnJG+KfD5ECCkK
         i8/w==
X-Gm-Message-State: AJcUukf5MTETbirbSpZBK5/dI+FEQCWNryiaqGskapYp2RA2/AqR19aZ
        hIUJVLM+3R1BXb/+P04qkKV9VA==
X-Google-Smtp-Source: ALg8bN7zTpps7URaNCzKFj6K+J+PaB7zIuQ4bZaCs6mwJHsupOTkj7BfYrXE6cwu7eKmKwhgQJbWpQ==
X-Received: by 2002:a25:3852:: with SMTP id f79mr9926521yba.139.1548411258338;
        Fri, 25 Jan 2019 02:14:18 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x203sm11868695ywd.41.2019.01.25.02.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Jan 2019 02:14:17 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 3/3] PCI: iproc: Add dma reserve resources to host
Date:   Fri, 25 Jan 2019 15:43:51 +0530
Message-Id: <1548411231-27549-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
References: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IPROC host has the limitation that it can use only those address ranges
given by dma-ranges property as inbound address. So that the memory
address holes in dma-ranges should be reserved to allocate as DMA address.

Inbound address of host accessed by PCIe devices will not be translated
before it comes to IOMMU or directly to PE. But the limitation of this
host is, access to few address ranges are ignored. So that IOVA ranges
for these address ranges have to be reserved.

All such addresses ranges are created as resource entries by parsing
dma-ranges DT parameter and add to dma_resv list of PCI host bridge.

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
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
---
 drivers/pci/controller/pcie-iproc.c | 51 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index c20fd6b..b7bef1c 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1146,25 +1146,74 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
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

