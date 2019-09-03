Return-Path: <SRS0=pntK=W6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A9EC3A5A2
	for <linux-pci@archiver.kernel.org>; Tue,  3 Sep 2019 16:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D95E23431
	for <linux-pci@archiver.kernel.org>; Tue,  3 Sep 2019 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528292;
	bh=3bk7rFt5HcTeej2SS3c2IS5nrXPLOpumDWzrVcjV0iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sTFkuz9TdbPgQUfDuM3+bt+XULiWoFr0cPhJSzaoC8fH/ghHGpwkS6jc2y8SuthAL
	 JZ9sdkZ6H/gWI7bIUqj0l+zvTrFv78jAvUhgLIeOaghLueo6Z7kolaqSE9aLlzRfNT
	 zJra1iI+wy0d3Qwxi1qpGFm6WooRkJVLXotXdiNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfICQ2W (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731100AbfICQ2V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Sep 2019 12:28:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 084442343A;
        Tue,  3 Sep 2019 16:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567528100;
        bh=3bk7rFt5HcTeej2SS3c2IS5nrXPLOpumDWzrVcjV0iY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsnJSUOyLpL1NJ+XCOTX5JRbpRY6kA54Jnb7kNefKND/gkPgNNg8S0yqLGn+yscme
         7NcAMp9dgf81JHbZ3c8loYW1HPnT9sZd1RI0K+7QIS799ktLw3PLtdhO+MWLKAQoQC
         9qbwn8TNnRm9ExXj10MBl9J/aHP05FWYS08fhd1I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 108/167] PCI: dwc: Use devm_pci_alloc_host_bridge() to simplify code
Date:   Tue,  3 Sep 2019 12:24:20 -0400
Message-Id: <20190903162519.7136-108-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

[ Upstream commit e6fdd3bf5aecd8615f31a5128775b9abcf3e0d86 ]

Use devm_pci_alloc_host_bridge() to simplify the error code path.  This
also fixes a leak in the dw_pcie_host_init() error path.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC: stable@vger.kernel.org	# v4.13+
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index acd50920c2ffd..b57ee79f6d699 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -356,7 +356,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		dev_err(dev, "Missing *config* reg space\n");
 	}
 
-	bridge = pci_alloc_host_bridge(0);
+	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
 
@@ -367,7 +367,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	ret = devm_request_pci_bus_resources(dev, &bridge->windows);
 	if (ret)
-		goto error;
+		return ret;
 
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
@@ -411,8 +411,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						resource_size(pp->cfg));
 		if (!pci->dbi_base) {
 			dev_err(dev, "Error with ioremap\n");
-			ret = -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
 
@@ -423,8 +422,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 					pp->cfg0_base, pp->cfg0_size);
 		if (!pp->va_cfg0_base) {
 			dev_err(dev, "Error with ioremap in function\n");
-			ret = -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
 
@@ -434,8 +432,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						pp->cfg1_size);
 		if (!pp->va_cfg1_base) {
 			dev_err(dev, "Error with ioremap\n");
-			ret = -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
 
@@ -458,14 +455,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			    pp->num_vectors == 0) {
 				dev_err(dev,
 					"Invalid number of vectors\n");
-				goto error;
+				return -EINVAL;
 			}
 		}
 
 		if (!pp->ops->msi_host_init) {
 			ret = dw_pcie_allocate_domains(pp);
 			if (ret)
-				goto error;
+				return ret;
 
 			if (pp->msi_irq)
 				irq_set_chained_handler_and_data(pp->msi_irq,
@@ -474,7 +471,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		} else {
 			ret = pp->ops->msi_host_init(pp);
 			if (ret < 0)
-				goto error;
+				return ret;
 		}
 	}
 
@@ -514,8 +511,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 err_free_msi:
 	if (pci_msi_enabled() && !pp->ops->msi_host_init)
 		dw_pcie_free_msi(pp);
-error:
-	pci_free_host_bridge(bridge);
 	return ret;
 }
 
-- 
2.20.1

