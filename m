Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A703271450
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771363697; cv=none; b=r5Q56RsqwNzeLQQAnnayLaU26voknI3gDCj2rXr8DZRBszqPkALyUR/D2mfMusvpToMwJuIuLMjHqbOKYia0gC1IBSwXXG/+PThiUtns9XO9vANuV1oswNPFSIEwJQDokOwyK6ChvhX6gxGTmX5fwlhympBe4kTUYxftKSkKOvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771363697; c=relaxed/simple;
	bh=NFw+Agt03b1wTzK1P1urv9xzEn8ld88gw4xziKa1WBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XapL70E9sHpF8FZFS1YZe+9B2FYcAKjGq5/BhcB6dLtErUMMnCpp/5e5Cu8dFvN5XPPyd34mJ7RIHVFXIvK+wXc9GVqLwgSVxWLIVfTnAJO1A4lpylQ+YfeB02DeS1UJXvuncFR2fcL6vRHgyO3mtR3UUtqtcYDOfvt6LK2koTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZ4ffOxP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZ4ffOxP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797E0C2BC86;
	Tue, 17 Feb 2026 21:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771363696;
	bh=NFw+Agt03b1wTzK1P1urv9xzEn8ld88gw4xziKa1WBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZ4ffOxPucN8jRimMOEFW7fiGcV+PT8nBplynLlwpSvQ05GFOV03LgYHtftPAosBA
	 LkprqtRE6LuI4Lta85zAuYEgimDeKwFt/OpvPiiCR89Hx9mHm5QvYmK/dDy0knKtVG
	 Tkbxr4xtV3YLrHPt1pyOzcwNYXk5nC2IyeiAddRX4BvqyItaOCXhTXdmWjM+rKQkpy
	 15f6jhnz/h92IvwNt3SYxdoeUPrfeJFSPHa94Yt7Ywdfde7tSutODuYJ/lkODnALSR
	 gWpwB9xOiDlx4BWeYuZnRIE4KJTlD71YEWNzYxrSzswTcUFj/BB34QQrT6jsPiKpfU
	 A/X/KEULKPALg==
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
Subject: [PATCH 8/9] misc: pci_endpoint_test: Give reserved BARs a distinct error code
Date: Tue, 17 Feb 2026 22:27:14 +0100
Message-ID: <20260217212707.2450423-19-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217212707.2450423-11-cassel@kernel.org>
References: <20260217212707.2450423-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2799; i=cassel@kernel.org; h=from:subject; bh=NFw+Agt03b1wTzK1P1urv9xzEn8ld88gw4xziKa1WBY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKn3DXw+uhUm8MQ+brz1bv8opueRn8mzLrn9C7w2MWNq Q0vl3Wu6yhlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEjjxnZHiWGmnklnj0+qH8 b18bHB5cfGQ6t3JPiGN5yjP79SYvcmczMvxucHNJ+7zC1FRtUpBYf8TdAM38lubf9/dmny1dcDJ uIwsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Give reserved BARs a distinct error code, such that the pci_endpoint_test
selftest will be able to skip test cases that are run against reserved
BARs.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 74ab5b5b9011..7cffb6e77c4d 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -84,6 +84,12 @@
 #define CAP_MSIX				BIT(2)
 #define CAP_INTX				BIT(3)
 #define CAP_SUBRANGE_MAPPING			BIT(4)
+#define CAP_BAR0_RESERVED			BIT(5)
+#define CAP_BAR1_RESERVED			BIT(6)
+#define CAP_BAR2_RESERVED			BIT(7)
+#define CAP_BAR3_RESERVED			BIT(8)
+#define CAP_BAR4_RESERVED			BIT(9)
+#define CAP_BAR5_RESERVED			BIT(10)
 
 #define PCI_ENDPOINT_TEST_DB_BAR		0x34
 #define PCI_ENDPOINT_TEST_DB_OFFSET		0x38
@@ -275,6 +281,23 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 	return ret;
 }
 
+static bool bar_is_reserved(struct pci_endpoint_test *test, enum pci_barno bar)
+{
+	if (bar == BAR_0 && test->ep_caps & CAP_BAR0_RESERVED)
+		return true;
+	else if (bar == BAR_1 && test->ep_caps & CAP_BAR1_RESERVED)
+		return true;
+	else if (bar == BAR_2 && test->ep_caps & CAP_BAR2_RESERVED)
+		return true;
+	else if (bar == BAR_3 && test->ep_caps & CAP_BAR3_RESERVED)
+		return true;
+	else if (bar == BAR_4 && test->ep_caps & CAP_BAR4_RESERVED)
+		return true;
+	else if (bar == BAR_5 && test->ep_caps & CAP_BAR5_RESERVED)
+		return true;
+	return false;
+}
+
 static const u32 bar_test_pattern[] = {
 	0xA0A0A0A0,
 	0xA1A1A1A1,
@@ -403,7 +426,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
 
 	/* Write all BARs in order (without reading). */
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
-		if (test->bar[bar])
+		if (test->bar[bar] && !bar_is_reserved(test, bar))
 			pci_endpoint_test_bars_write_bar(test, bar);
 
 	/*
@@ -413,7 +436,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
 	 * (Reading back the BAR directly after writing can not detect this.)
 	 */
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
-		if (test->bar[bar]) {
+		if (test->bar[bar] && !bar_is_reserved(test, bar)) {
 			ret = pci_endpoint_test_bars_read_bar(test, bar);
 			if (ret)
 				return ret;
@@ -1139,6 +1162,11 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
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

