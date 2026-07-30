Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC3D425879
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414061; cv=none; b=gagPAWOmqYVPxaMYZd0GlniEji8NGgLTXrJcKsT2+7yY0z8Gp3RGgDMfq1y9DsSs+1Ol+p5And2CRF2xCdwgiMvUxWLTLvYj/VlZiXwf30wtCIatcesw17N85otxDSKK34OYKPVdRZ+ED5zzqa7zIHgC+xbaHAarWdiDiCrWt6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414061; c=relaxed/simple;
	bh=ZYBIv9EMkZnmI12SrxNuXRUx1sv8DNkVCGFEWsKwnJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khftR9XfQG5tJIah5NXX6PvgRLxfuMOPF7wcn6sbFwXdtmRPcHAwtxUY/TN0Iu6N4gJ9g6uhqboE5FrmSwKgpk0rjmgsPksWg9E9rCdyvmTKw8rIVix/ZUS3Dhx80TwI0AxBg7dMN0aCFuoDfmWOyYhukoYLeLcqRh01k3WF1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlWlmYNq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlWlmYNq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE601F000E9;
	Thu, 30 Jul 2026 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414060;
	bh=aQL0IGhySamwx384E1R+EJhYmgONnIqiTksKxCm6wAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YlWlmYNq+FFnfu5CDfj7kyj7LWujYRgIiAT+PDFoilL+nBN3V5Q7WXmGgNns0o8hy
	 PHzElwwxLHiLUONWq8b3AYWZMcm1Zdks8+PYL4Pj9KdLaeLQjw7VqOWn9kYW1B+waU
	 LVEGx5e6B4IOFoP0SrKXcD2hrNFlLtdBjO8aVAIFnMisQMAWTtyGaItjHQ450rL9dj
	 2Fy6H5wdWc3G/X72hbKHuEFI2Rd49+8ZiACgYxj0CFxNITaK2ODVW9es6pVqpfphl8
	 84+Sg9kAGQVlYVN/uWHPMNbzNlo2eGhlOuISGolX80H3ncqTT4ix2DpUQQrnmzgzGe
	 UElNCOkVg/6sA==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Koichiro Den <den@valinux.co.jp>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/2] misc: pci_endpoint_test: Improve logic to check status for doorbell test case
Date: Thu, 30 Jul 2026 14:20:48 +0200
Message-ID: <20260730122045.1382749-6-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730122045.1382749-4-cassel@kernel.org>
References: <20260730122045.1382749-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=cassel@kernel.org; h=from:subject; bh=ZYBIv9EMkZnmI12SrxNuXRUx1sv8DNkVCGFEWsKwnJs=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLKyHRf2yhSIsq9YO7diz4E3Mn3uyvt41u2Xuchxdn7x/ aNJUlc4OkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCR/8IM/wzKvwWw67yTV3Bb f4Kr8fqcOdFXlSSSV+/fedWho8M1uYXhf3n5s9/zyj2v2n8wsZ76pfaz+olFJnMfJX/aO2uz915 fKX4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The EPF driver drivers/pci/endpoint/functions/pci-epf-test.c
only sets STATUS_DOORBELL_ENABLE_SUCCESS as the final step in
pci_epf_test_enable_doorbell()

Likewise it only sets STATUS_DOORBELL_DISABLE_SUCCESS as the final step in
pci_epf_test_disable_doorbell().

The safest way is therefore to check if the SUCCESS bit was set,
not to check if the FAIL bit was set.

Because, during a wait_for_completion_timeout() timeout, if we did not
receive an IRQ, obviously the FAIL bit will not be set.

For the STATUS_DOORBELL_ENABLE case, the if-statement also fails if there
was a timeout ('left' == 0). However, we've seen an issue where a buggy EPC
driver was sending two IRQs in response to a single DOORBELL_ENABLE
command, and in this case the second wait_for_completion() will return
immediately (i.e. no timeout - 'left' != zero) and the SUCCESS bit will not
be set. Thus, the safest way is to simply check if the SUCCESS bit is set.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 26ab9252251f..1019bcd0628f 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -1094,7 +1094,7 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
 	left = wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
 
 	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
-	if (!left || (status & STATUS_DOORBELL_ENABLE_FAIL)) {
+	if (!left || !(status & STATUS_DOORBELL_ENABLE_SUCCESS)) {
 		dev_err(dev, "Failed to enable doorbell\n");
 		return -EINVAL;
 	}
@@ -1133,7 +1133,7 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
 
 	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
 
-	if (status & STATUS_DOORBELL_DISABLE_FAIL) {
+	if (!(status & STATUS_DOORBELL_DISABLE_SUCCESS)) {
 		dev_err(dev, "Failed to disable doorbell\n");
 		return -EINVAL;
 	}
-- 
2.55.0

