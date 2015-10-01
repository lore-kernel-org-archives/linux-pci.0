Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27437 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbbJAFyE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2015 01:54:04 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v6 04/53] OF/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
Date: Wed, 30 Sep 2015 22:52:38 -0700
Message-Id: <1443678807-786-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1443678807-786-1-git-send-email-yinghai@kernel.org>
References: <1443678807-786-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For device resource PREF bit setting under bridge 64-bit pref resource,
we need to make sure only set PREF for 64bit resource, so set
IORESOUCE_MEM_64 for 64bit resource during OF device resource flags
parsing.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 drivers/of/address.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 384574c..3399602 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -128,9 +128,11 @@ static unsigned int of_bus_pci_get_flags(const __be32 *addr)
 		flags |= IORESOURCE_IO;
 		break;
 	case 0x02: /* 32 bits */
-	case 0x03: /* 64 bits */
 		flags |= IORESOURCE_MEM;
 		break;
+	case 0x03: /* 64 bits */
+		flags |= IORESOURCE_MEM | IORESOURCE_MEM_64;
+		break;
 	}
 	if (w & 0x40000000)
 		flags |= IORESOURCE_PREFETCH;
-- 
1.8.4.5

