Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C0DC433B4
	for <linux-pci@archiver.kernel.org>; Thu, 22 Apr 2021 17:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0260F61435
	for <linux-pci@archiver.kernel.org>; Thu, 22 Apr 2021 17:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbhDVRF5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Apr 2021 13:05:57 -0400
Received: from mx.socionext.com ([202.248.49.38]:12518 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236287AbhDVRFy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Apr 2021 13:05:54 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 23 Apr 2021 02:05:09 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 83F1C2059027;
        Fri, 23 Apr 2021 02:05:09 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 23 Apr 2021 02:05:09 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 26143B1D40;
        Fri, 23 Apr 2021 02:05:09 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v11 1/3] PCI: portdrv: Add pcie_port_service_get_irq() function
Date:   Fri, 23 Apr 2021 02:04:55 +0900
Message-Id: <1619111097-10232-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619111097-10232-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1619111097-10232-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pcie_port_service_get_irq() that returns the virtual IRQ number
for specified portdrv service.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv.h      |  1 +
 drivers/pci/pcie/portdrv_core.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 2ff5724..628a3de 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -144,4 +144,5 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
+int pcie_port_service_get_irq(struct pci_dev *dev, u32 service);
 #endif /* _PORTDRV_H_ */
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e1fed664..93027d3 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -478,6 +478,22 @@ struct device *pcie_port_find_device(struct pci_dev *dev,
 EXPORT_SYMBOL_GPL(pcie_port_find_device);
 
 /**
+ * pcie_port_service_get_irq - get irq of the service
+ * @dev: PCI Express port the service is associated with
+ * @service: For the service to find
+ *
+ * Get irq number associated with given service on a pci_dev
+ */
+int pcie_port_service_get_irq(struct pci_dev *dev, u32 service)
+{
+	struct pcie_device *pciedev;
+
+	pciedev = to_pcie_device(pcie_port_find_device(dev, service));
+
+	return pciedev->irq;
+}
+
+/**
  * pcie_port_device_remove - unregister PCI Express port service devices
  * @dev: PCI Express port the service devices to unregister are associated with
  *
-- 
2.7.4

