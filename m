Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7275AC43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 18:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506142133F
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 18:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfCRSYq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:24:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39506 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfCRSYq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Mar 2019 14:24:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FFBE1682;
        Mon, 18 Mar 2019 11:24:46 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE3923F614;
        Mon, 18 Mar 2019 11:24:44 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Grant.Likely@arm.com,
        Jeremy.Linton@arm.com, Robin.Murphy@arm.com
Subject: [PATCH 2/2] PCI: OF: Support external-facing property
Date:   Mon, 18 Mar 2019 18:21:24 +0000
Message-Id: <20190318182124.53859-3-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318182124.53859-1-jean-philippe.brucker@arm.com>
References: <20190318182124.53859-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set the "untrusted" attribute to any PCIe port that has an
"external-facing" device tree property. Any device downstream of this
port will inherit the attribute and have only the strictest IOMMU
protection.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/pci/of.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3d32da15c215..3e7ac7748d90 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -35,6 +35,9 @@ void pci_set_bus_of_node(struct pci_bus *bus)
 		bus->dev.of_node = pcibios_get_phb_of_node(bus);
 	else
 		bus->dev.of_node = of_node_get(bus->self->dev.of_node);
+
+	if (of_get_property(bus->dev.of_node, "external-facing", NULL))
+		bus->self->untrusted = true;
 }
 
 void pci_release_bus_of_node(struct pci_bus *bus)
-- 
2.21.0

