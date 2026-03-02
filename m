Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA30B392C2D
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445640; cv=none; b=XrIeaHMdTulmCLWcjzw4aNuxakaCUj9vsTDE076ozU9bwZ0iDfQ5GnNaBjrUucYuORV2ZESQFIsBtNs2WGALj2RCLyXi3btF/3n825y2ZDLJBmAzDXqidMPH51ug89qpxoxI7vQk3ZZDNTVcBnFpnBP5C/NaG0des/4BUeCYl9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445640; c=relaxed/simple;
	bh=pqj0h1yrJV3Lh64JkE1Z6woV3gfkY518Q3B+5zYTAp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1mt+NSZWzzE9a2Ws6IcPb8jcmWpBPpRQguAeqj8MB2fPz8KC/ZMVUSjQcm2gclg3WtCNx9nit0w6KwEaGP+qkO2R0Tc4AWPnlKqZMHEqYHfuMCbShlbyUuC3A/f9C52xsOrRe3h/aVgAzqrTFvYGJcIJ0Oy4V6AUDvfVcoMyqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpcJi4cW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpcJi4cW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAD1C19425;
	Mon,  2 Mar 2026 10:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772445640;
	bh=pqj0h1yrJV3Lh64JkE1Z6woV3gfkY518Q3B+5zYTAp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpcJi4cWVcJrFk/VVo7qTC5WRaNsX5tCDej54dwYOvjASuKP8n+yT2XJo6/KSMQZz
	 a+FcqMI5yBxFlxXLlelV8NH+G/sOQll6aDfGc5bo52ZRU+AwdCGxP1poDFj0hKBkYc
	 Qe5ZcNZwJD2bXYqP21xltGGwtCVA/GnJ/i7zDclIpL/2brReSRJmdTPq3lOtn+vMsE
	 ZcxkHaFWYn4ty1yhhkrbLePamnwl4BsCqa1XhYvNSCfcebpkln5R/tHxIYRPUZzcP7
	 E/EMmg6EU+CLZXb8srctu5WsRWUdSL9Fyi3mGBw1tQUJFZsbCZGx2CYAIErZdmDFrM
	 iacpdwqECyNcQ==
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
Subject: [PATCH v3 8/9] misc: pci_endpoint_test: Give reserved BARs a distinct error code
Date: Mon,  2 Mar 2026 10:59:20 +0100
Message-ID: <20260302095913.48155-19-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302095913.48155-11-cassel@kernel.org>
References: <20260302095913.48155-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2749; i=cassel@kernel.org; h=from:subject; bh=pqj0h1yrJV3Lh64JkE1Z6woV3gfkY518Q3B+5zYTAp8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKXxlfHVMq9zb/YIpHjdS7v+P7Q6QdcgzUaaleUPwtn3 2e5asnDjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEwkkIuRoYtXpqp/6cYd08SW 5su+ufrxyp6mxa7smXwTSvpyBGLXr2ZkuDbjn0/2nAMyjmu8jrW+e5viP6PixsqVercfXExLmJU oww4A
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

