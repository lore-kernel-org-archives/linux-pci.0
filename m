Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34903 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760193AbbLCNgH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2015 08:36:07 -0500
Received: by wmuu63 with SMTP id u63so21386020wmu.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Dec 2015 05:36:06 -0800 (PST)
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
To: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 1/5] PCI: designware: add memory barrier after enabling region
Date: Thu,  3 Dec 2015 15:35:20 +0200
Message-Id: <1449149725-27607-2-git-send-email-stanimir.varbanov@linaro.org>
In-Reply-To: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add 'write memory' barrier after enable region in PCIE_ATU_CR2
register. The barrier is needed to ensure that the region enable
request has been reached it's destination at time when we
read/write to PCI configuration space.

Without this barrier PCI device enumeration during kernel boot
is not reliable, and reading configuration space for particular
PCI device on the bus returns zero aka no device.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/pci/host/pcie-designware.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 02a7452bdf23..ed4dc2e2553b 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -164,6 +164,11 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
 	dw_pcie_writel_rc(pp, upper_32_bits(pci_addr), PCIE_ATU_UPPER_TARGET);
 	dw_pcie_writel_rc(pp, type, PCIE_ATU_CR1);
 	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
+	/*
+	 * ensure that the ATU enable has been happaned before accessing
+	 * pci configuration/io spaces through dw_pcie_cfg_[read|write].
+	 */
+	wmb();
 }
 
 static struct irq_chip dw_msi_irq_chip = {
-- 
1.7.9.5

