Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF2D52F8B
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320617; cv=none; b=satqTTFw31Btds7z4S1Df7yrhpug/uW3ZFuDQBa7vw21T/cmGIZJErjHKvsjuJWK3ZsTioiYbh3P86holWP0B7+HKQ2eOeXcPpKPimhpZm2u/RQvf2Ry371MDpfnIwxyJpjUsfUs4QwP9VNOx8asgXxyNSPar7bzkxfwHJhhgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320617; c=relaxed/simple;
	bh=pqj0h1yrJV3Lh64JkE1Z6woV3gfkY518Q3B+5zYTAp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtZ9DRFW7PNoHk9UjQPGPdce8kQJKpXN4Fd5H6aQyiLclZSSdfRibLZealvtwV2S3oJzlGOkg9XO92oWkjEyoTpo8JFyOD39rBvyTrbs4nKom+jKlR5kGcwpWDUrZwXRF+bhvemTv3gDPv67n0e6XwKRGHsAV9yLpLXZHmvHhGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsHSlPKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsHSlPKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8568DC2BC86;
	Thu, 12 Mar 2026 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773320616;
	bh=pqj0h1yrJV3Lh64JkE1Z6woV3gfkY518Q3B+5zYTAp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hsHSlPKciBUfEuMiAPNHrD0/EJPofa2fmXbaTU2NtDQWc9o7DVmmpc/mCiLflEU++
	 /04xA23xjFccpX8HDmyL0vxSOskWI9ASJjfFAuI+aSwmAll7uXz3HiXos0gSBO6MFh
	 Q1x03K46v2vvTdX6guib+GWQhWkKyI1+7cdHsuX42i1JMlvgIfH6BuecB1lxmEvx8r
	 GYMT8d8032gvwDw/PGCN6I2WtyKk79r5a6aUd9P97XCIFFql5D5vJWk6lWdQeZ8a9j
	 FKw8zImnbXWYoE0ZcBbJq/txbuhCXcbPxt819Xfzgk7pmMFH7QiLDr6QKCIM8YWGQb
	 +Qsgc6bT5FXRA==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 09/10] misc: pci_endpoint_test: Give reserved BARs a distinct error code
Date: Thu, 12 Mar 2026 14:02:37 +0100
Message-ID: <20260312130229.2282001-21-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312130229.2282001-12-cassel@kernel.org>
References: <20260312130229.2282001-12-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2749; i=cassel@kernel.org; h=from:subject; bh=pqj0h1yrJV3Lh64JkE1Z6woV3gfkY518Q3B+5zYTAp8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI37cyPqZR7m3+xRSLH61ze8f2h0w+4Bms01K4ofxbOv s9y1ZKHHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjIeQ6GP3wP0p7G8iZfeiej tensjFdr9fhedk5W/Mi3cd4Bg9UW8/UY/ml1nDaq8Oc+7SyqnX312hJLEz5m8ceZ8+LrXyZO1rR 9zAQA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Give reserved BARs a distinct error code, such that the pci_endpoint_test
selftest will be able to skip test cases that are run against reserved
BARs.

Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 93cd57d20881..89d0aba059da 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -85,6 +85,12 @@
 #define CAP_INTX				BIT(3)
 #define CAP_SUBRANGE_MAPPING			BIT(4)
 #define CAP_DYNAMIC_INBOUND_MAPPING		BIT(5)
+#define CAP_BAR0_RESERVED			BIT(6)
+#define CAP_BAR1_RESERVED			BIT(7)
+#define CAP_BAR2_RESERVED			BIT(8)
+#define CAP_BAR3_RESERVED			BIT(9)
+#define CAP_BAR4_RESERVED			BIT(10)
+#define CAP_BAR5_RESERVED			BIT(11)
 
 #define PCI_ENDPOINT_TEST_DB_BAR		0x34
 #define PCI_ENDPOINT_TEST_DB_OFFSET		0x38
@@ -109,6 +115,7 @@
 #define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
 
 #define PCI_ENDPOINT_TEST_BAR_SUBRANGE_NSUB	2
+#define PCI_ENDPOINT_CAP_BAR0_RESERVED_BIT	6
 
 static DEFINE_IDA(pci_endpoint_test_ida);
 
@@ -276,6 +283,11 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 	return ret;
 }
 
+static bool bar_is_reserved(struct pci_endpoint_test *test, enum pci_barno bar)
+{
+	return test->ep_caps & BIT(bar + PCI_ENDPOINT_CAP_BAR0_RESERVED_BIT);
+}
+
 static const u32 bar_test_pattern[] = {
 	0xA0A0A0A0,
 	0xA1A1A1A1,
@@ -404,7 +416,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
 
 	/* Write all BARs in order (without reading). */
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
-		if (test->bar[bar])
+		if (test->bar[bar] && !bar_is_reserved(test, bar))
 			pci_endpoint_test_bars_write_bar(test, bar);
 
 	/*
@@ -414,7 +426,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
 	 * (Reading back the BAR directly after writing can not detect this.)
 	 */
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
-		if (test->bar[bar]) {
+		if (test->bar[bar] && !bar_is_reserved(test, bar)) {
 			ret = pci_endpoint_test_bars_read_bar(test, bar);
 			if (ret)
 				return ret;
@@ -1143,6 +1155,11 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 		if (is_am654_pci_dev(pdev) && bar == BAR_0)
 			goto ret;
 
+		if (bar_is_reserved(test, bar)) {
+			ret = -ENOBUFS;
+			goto ret;
+		}
+
 		if (cmd == PCITEST_BAR)
 			ret = pci_endpoint_test_bar(test, bar);
 		else
-- 
2.53.0

