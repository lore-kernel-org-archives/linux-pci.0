Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA52D2385
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039071; cv=none; b=XtcOxPAgTXrwfEF9hIGkhjbezmouTjvTBMEaThitevFOV2CjyNZ4vMslfhIR9PP/w6pixOgII391rM/7Ty0OVg/kmgJTlrS6ACtoVZSMnHYwWdH2c2beH6IybG+4+Eei9JK6bdnWgSxzYceSIeuime8Gey8pwe9BShHzvDpQZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039071; c=relaxed/simple;
	bh=iN1ryjFVIWf/P5uxTayboHA/sy6NdQpYAaeYe5BinxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayGis3bjxRkDcInIrQQbQ6UhVF+KvGn9E3NxHdyvTNh1ZPC8ngatH++230JvmMfkuJthpKcbLgS8csbOia+jwbFGswXQx57ksYaXFeMJfXqFr9sJ7DSKISocHmUOzcJGa4Cc4gesNDyhO3Nh3ZRXP63AK5K5JvQhywPasNM5S/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feftiJDB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feftiJDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A071AC19421;
	Wed, 25 Feb 2026 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772039070;
	bh=iN1ryjFVIWf/P5uxTayboHA/sy6NdQpYAaeYe5BinxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=feftiJDB3CTQzNKh96mJgUo5N8MuUrBhmk3N7CI9fhkqK1xl84i1SLaJUBu7rHki7
	 iQeLwH+Cp9dABjazsYMgSF4pL55nh8BNCO/BBJKmV4lF15/VxQ35Nu0HCi1qH1OFXB
	 1fIncCTTf4/7TkKBliNhOmjD7EmRo6OV9QL/l3+wF/54zNoICaaJBd4cNN0YQrDCUW
	 HzA0JlPOvtQJIhudK4XFF92aQqTNlvnRvD6JM/hXpsggL4aPDhXmc/Bk9kThfwCwoM
	 yj7D6x8onKW6qXTxQnsW9NyD48vRfd1ZXwfxoEouWqnBY4DLLfaoz4NOS1IxqfG8ep
	 id41ohtGnYUYw==
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
	linux-pci@vger.kernel.org
Subject: [PATCH v2 8/9] misc: pci_endpoint_test: Give reserved BARs a distinct error code
Date: Wed, 25 Feb 2026 18:03:31 +0100
Message-ID: <20260225170324.4033466-19-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225170324.4033466-11-cassel@kernel.org>
References: <20260225170324.4033466-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662; i=cassel@kernel.org; h=from:subject; bh=iN1ryjFVIWf/P5uxTayboHA/sy6NdQpYAaeYe5BinxM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLna6dVMbQsqxC+8Wj+7Pc/UjznGn525Ou1WHJj/gQjn Qlh18NUOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjARPRuG/x5l96UjvmoXXtlj GLKk/fGDqz89NQ+ujr8+d+Oje1lTM74w/K973LzvTGTz85gnMomJ+UlLV5nurpj+fKL5oo4Yv73 6H5gB
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Give reserved BARs a distinct error code, such that the pci_endpoint_test
selftest will be able to skip test cases that are run against reserved
BARs.

Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
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

