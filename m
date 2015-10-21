Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0056.outbound.protection.outlook.com ([157.56.111.56]:10624
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753535AbbJUPxE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 Oct 2015 11:53:04 -0400
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
To: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <hanjun.guo@linaro.org>, <thomas.lendacky@amd.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V4 2/8] device property: Introducing enum dev_dma_attr
Date: Wed, 21 Oct 2015 08:52:05 -0700
Message-ID: <1445442731-28819-3-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A device could have one of the following DMA attributes:
    * DMA not supported
    * DMA non-coherent
    * DMA coherent

So, this patch introduces enum dev_dma_attribute. This will be used by
new APIs introduced in later patches.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/property.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index a59c6ee..522c1bf 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -27,6 +27,12 @@ enum dev_prop_type {
 	DEV_PROP_MAX,
 };
 
+enum dev_dma_attr {
+	DEV_DMA_NOT_SUPPORTED,
+	DEV_DMA_NON_COHERENT,
+	DEV_DMA_COHERENT,
+};
+
 bool device_property_present(struct device *dev, const char *propname);
 int device_property_read_u8_array(struct device *dev, const char *propname,
 				  u8 *val, size_t nval);
-- 
2.1.0

