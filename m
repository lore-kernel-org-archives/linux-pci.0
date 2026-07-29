Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7963B4E83
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356920; cv=none; b=Hl1cy4MJODexRhSGdjAKC9nt9h/5bgissJ0Mim5ER4uyGiUOqA98Ep+x6DjrKRzYWT27MPnYHXmfWUGciF0+H9YjqPjYSjvl5LyofGOIpfFWL8hrMV/ZIZYKWqfm6jw/WWOQqu53nopZcwuIddYMxJz2Ycf487X+2me+OnhjhQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356920; c=relaxed/simple;
	bh=Gub1Jk0ad6isyk1qQ/UNRq2L81OCUddDS+Cq3pDGY70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UVKBJmC25S4mwfMyzbfLwfoQQZRI4c4jn6L4CO7GrkHlyN6OlgFhcRB9tNp7zf94u3CTDaqtQT5fiFRuSbXm3dOmC0V/y0Dlgm0CNDv0f8jKFmLjCIfM3PNZaVXUUPylCzv3P6qIJAaBRI9/yBoJo+Lg7ooBn8GNA3o0I9QImsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja759t2E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja759t2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A666F1F000E9;
	Wed, 29 Jul 2026 20:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785356914;
	bh=rbMFrjdL7q+gDzIWpJSEdCz4gwpvZGlUONNiO5LB0A4=;
	h=From:To:Cc:Subject:Date;
	b=ja759t2EFwloG7wZH8388Q1LOY0nW+HPq32UA2t/3VtgCe9irkFiNE0W0msf0kafD
	 TpyEKSlq3HHpbh7AIUMjpyaloAy/OL29Ne25sHzC1I9aS0mAR+Rl7I6oDeV6NS14qC
	 WACgVxlVXMynlcUzU64j7Ab2gyjZmhsWH26t/t/kSziyDsRXe3Z6UxKxdAihtwYHcG
	 5vAiUGYz+NOeJzbHbYNaAMjIgPtKxVII604LrWOD93xSyQZrkfDR9RDNjw8zQ/pXZ+
	 g1iJfWq2mxHPEezq4KaRrVaKDutEka45sdbgQu6cka4uxtbKiv4fCHbrykhlLyiVqG
	 8oVtoOLQBc0+A==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Koichiro Den <den@valinux.co.jp>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] misc: pci_endpoint_test: Add WARN_ON() to detect broken EPC drivers
Date: Wed, 29 Jul 2026 22:28:22 +0200
Message-ID: <20260729202821.1153443-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394; i=cassel@kernel.org; h=from:subject; bh=Gub1Jk0ad6isyk1qQ/UNRq2L81OCUddDS+Cq3pDGY70=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLKyklK/L/4y+V4j26dLX9qnmFrvmN9XUPDHbnLQ+xflR x5ZR7891FHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJyJ9n+O/LtmOvtf8c4SZB 0yM5Lg8DHl86E9mwp9Ro57PZk08581gx/FOoveBpeEST1fC6+L5YnntLslUnr1LeeFc9lsP03vx nMUwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Getting two IRQs when we are only expecting a single IRQ is a very
serious error, and suggests that something is very wrong in the EPC
driver.

Scream loudly so that EPC driver developers can see the problem,
which might otherwise be very hard to detect.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3635741c3e7a..a212e53654c6 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -178,6 +178,19 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
 	if (reg & STATUS_IRQ_RAISED) {
 		test->last_irq = irq;
 		complete(&test->irq_raised);
+		/*
+		 * The endpoint test driver performs all testing sequentially.
+		 * This means that test->irq_raised.done should never exceed 1.
+		 * If it does, then we received two IRQs in a row, without a
+		 * successful wait_for_completion_timeout() call in between.
+		 *
+		 * While complete() increases test->irq_raised.done by one,
+		 * wait_for_completion_timeout() reduces test->irq_raised.done
+		 * by one on success.
+		 *
+		 * Please debug your EPC driver if you see this warning.
+		 */
+		WARN_ON(test->irq_raised.done > 1);
 	}
 
 	return IRQ_HANDLED;
-- 
2.55.0

