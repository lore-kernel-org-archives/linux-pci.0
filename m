Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C558425879
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414059; cv=none; b=QazZk2xp1EjlylPvRG1mpcpo5+Scakomvh82q7qx+Pk8wHSjTbYMDoz0egYVKbQLeWo+Q2He+MQSjEOWxfZWQa3ujGPJyTRv28i6PA9vza9U97TuhUQ4+F5D53mjpsQwMq1e4ri60XshZqAFAxZjTkxRuvthyPadM2eK0ulomWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414059; c=relaxed/simple;
	bh=aHBfBIqjJPLPXefCxVodjgyFWcn+96/nv98DRL4jp+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkYQ6j0zp17ThJHYHoUuei/LiWifTrwKUjnTlISOhLa8EnL7Xw1CtEZKUdIaIcw2rTrvmMexOTBeap4H8pofaRmaMi0LDOzf1XyG0VsOK0lxTUAbMPLdh6PhIM7GqdDK0hkTUQut0nGJOSduDLnbwSTZtgDvWloFk91UrQikRLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4bZtNf1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4bZtNf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA411F00A3A;
	Thu, 30 Jul 2026 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414058;
	bh=eCaz/63OQFEsMME/2fS3kcRS59FfzI/f7jlmpxh0hIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m4bZtNf1I8zE4Fx8VKlhRFc/46PrX0IFAgoTP3i97U6VH2h6H0cLigV6veK6nzIxm
	 ILTdwOG2bUb4kIJ2YfglXDhJ3V9Swsx2kBdvjfIFimgccJsCxwr/PIVuvQWW7x/B1M
	 //yzrZiHmYBLyjGHt+vKNTs12ilbhQ3ydyZzn1FSivCdz30GGtx+2WomMgLkAMwBoc
	 1h4NKt4ZQtT+TdhLrHR09sAuSzn3HDWxH5nahIssRQREQtdu0WfyZOtVXT2Sk15Nbp
	 hmH2kXiCiHQ4XEiIYuqTmMUBf3RunsV+S2eGjtYTkuyuqaTyXQxydVRmGIqbhsSguV
	 Isymn+Ao7O7ig==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Koichiro Den <den@valinux.co.jp>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/2] misc: pci_endpoint_test: Fix doorbell success logic
Date: Thu, 30 Jul 2026 14:20:47 +0200
Message-ID: <20260730122045.1382749-5-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730122045.1382749-4-cassel@kernel.org>
References: <20260730122045.1382749-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2425; i=cassel@kernel.org; h=from:subject; bh=aHBfBIqjJPLPXefCxVodjgyFWcn+96/nv98DRL4jp+g=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLKyHRf6Xf/Caidyuo6DLfjShLIe9Qvys4snR75h/BR6Z /dPfr/THaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhIkQgjw+rcnbGPeBLOrHBY lbh1wsNShZtzTpR6v3rv9mFehMJJpQcM/xOUg88oN1517a++fMLjmPf83ae9W/9KHdt7R/vMzf+ fuDkB
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The following was observed:
pci-endpoint-test 0000:01:00.0: Failed to trigger doorbell in endpoint
ok 23 pcie_ep_doorbell.DOORBELL_TEST

We observed a bug where an EPC driver would send two IRQs during ENABLE
DOORBELL command.

Because we got two IRQs for a single command, test->irq_raised.done was
never decreased to zero by complete(), so the
wait_for_completion_timeout() after the writel() that rings the doorbell
would return immediately, before the endpoint had managed to set
STATUS_DOORBELL_SUCCESS and triggered an IRQ corresponding to that write.

Later, when re-reading the status after disabling the doorbell,
STATUS_DOORBELL_SUCCESS will have been set by the endpoint, thus we would
not fail the test case.

Improve the test case logic such that if we failed to trigger the doorbell
in the endpoint, we make sure that we also fail the test case.

Fixes: eefb83790a0d ("misc: pci_endpoint_test: Add doorbell test case")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3635741c3e7a..26ab9252251f 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -1071,6 +1071,7 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
 	int irq_type = test->irq_type;
+	int ret = 0;
 	enum pci_barno bar;
 	u32 data, status;
 	u32 addr;
@@ -1119,8 +1120,11 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
 
 	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
 
-	if (!left || !(status & STATUS_DOORBELL_SUCCESS))
+	if (!left || !(status & STATUS_DOORBELL_SUCCESS)) {
 		dev_err(dev, "Failed to trigger doorbell in endpoint\n");
+		/* Store error code, but continue to disable doorbell. */
+		ret = -EINVAL;
+	}
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
 				 COMMAND_DISABLE_DOORBELL);
@@ -1134,10 +1138,7 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
 		return -EINVAL;
 	}
 
-	if (!(status & STATUS_DOORBELL_SUCCESS))
-		return -EINVAL;
-
-	return 0;
+	return ret;
 }
 
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
-- 
2.55.0

