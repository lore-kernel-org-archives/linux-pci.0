Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFAE48AE17
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635105; cv=none; b=TVZWevCIH5gmPWuNJeccpOFJ07NE1W5whE9ZVb+U2kJ5xE9bq1oKxXhXprVGOj8rv9mANtxg/l1FKC+oDt2MXq3tOIF/7QyYrohndneLyt4+oxkD3EdNnMDzgoyGoj+uDJfHc4mPmhahqkwI2RTOyMFj6P5ZAL/o4BTQ2rWATOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635105; c=relaxed/simple;
	bh=p8Cr//oDiUoJH0T79C9Z0a9JvVqIL+9+JAC/XJMhYsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Chi84CKExmepFu08vhS2ODs2aKopMQh/7nVSl0HwszzOVj0UZ7UBtxqTxYJc5tHi4utQqabOymdBwGLitdeG7VHn/L70Cv0QoXvfp7GA6XntpReJUtx/dSSga7U9Gj8EZVIkUSjW+K8ZjCWMxnMvKBcHdSwL96bJR4t8Q55WnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyUK8tZZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyUK8tZZ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cee9b74ee1so433955ad.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786635103; x=1787239903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5PO43KtK1vinlhveejSpb/w0mOz3aVvtFpKxNKIjn3Q=;
        b=XyUK8tZZdGTHi+Ib25XijnnP/UJNhItJ8xxGkoW6cIeyMOtwXuHHD3lW3lhPzhPNwo
         f9Ftw9SAQTW6kRtD2+p37VUox6icE8gdl98XB4AkpMkgMqVg7M7NC3PhyI2JdI20Ycdo
         mHpwq3CsRgcg1DscgTUchLxOFKkO3BiOTzyaJ5s3INO0NcIIVYgcK/f2bW8FzAhGksIs
         Yuta6i8Kv11y+U45cj8eZ5knUt2xF3sOSRQox5UGnOASkKxLXbC4pHqhyEtk8Ls69hW8
         BVqKdoHbH1GtEB7/K9/rzwcysLwPsIBgXpmRap3Qm9rYDNeL4bRJ+ciwcBrEDWEYx0bU
         Nl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786635103; x=1787239903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5PO43KtK1vinlhveejSpb/w0mOz3aVvtFpKxNKIjn3Q=;
        b=N3BSJ5x+oscdnHfD+QoWep5jrMgYtChv2AlLSkHyTal5Dz0Z2H2uYCK5P+RxycucdT
         tbwwLYnuyRMHy7zaymve6yom3M2n9kDBXmH95rPGesNkJaVLNCQbl749jW8wkYeeII3W
         DA1sDUvRBCZLXwNLX7hbxsA3ZXCDQ9lChuEApM6tjUdMqORrUlfgl+//OQAWf2MfLEDX
         He4krK9SJs9L3o1MCLLAG4jiSwsJ6pu3QlbX62M65PfLep6aJ4iEAqx0R23P9TiaSkrH
         pU5IHciHVcMrUxXKrhjMbTxLFSbtOEOjGSHWFNZFfzKPrF06F9LrIecAtPT12HvI9aIN
         o8tg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4B+wneyTfwMIhlnFbXvH0pdqCzpfzK1kR+xQIdBYvS+9UioLhmF5/CofH5NKrPOjSGLIZwDVl/og=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOl60K8DkevfxYxOHqdLvuXLXDoJgbINiQcDBhsQXSlFPuhXzm
	dm7KqlIu9M2OlXJhndRZZuBqdFAXWHubbbLkSmjudbG1qRdbEF9lbnKW
X-Gm-Gg: AR+sD101yLWqXlJI5N0g7fpZfAv8r9s41xRimEkFYBYEr7RBCZ7eg4qu+jR2of/HtuB
	bvgrsavdP4jL5CIUcMpg6PuBT+WCYKtiBNOnQwh+4B5T+1maobZ/6OoAkT/LqpaCPRnJkSuhVyG
	zDD+xniLyJoJM4QIXwzmoFx/CDkdUvUaWpdPu8RV9wLpZQCNXQr82dqJEAcNGkvrOIYQUp0G8H9
	0TexiaEs7zrZIqFqRiBMmzS1h4xGmrCh9nFC7N0WWHpHJSsxLtVrWE1DkIVTjBP/Uu66+11h44f
	8Mp8+tD4DNxdHjJPAajO48qe6adB05RHgPdvApTlKGtXWst4UiCheMnefrN3IEsH+eyWYkz3MLc
	ZdF2mGEDcFQ8bAz4ZbLLGHFGfLo/YGppGqDq7A9TuQ+5hs2pgUekmzadPtcu2MUJogSUU9IiXRl
	+3yiXn/Y4Sy6T+QqWxo7pnQyWytPQ3iuVDTOoU6PjJi9VaVUEhN9oqebBm2rLyk0kAWLetNg6sj
	V3S8Sv8
X-Received: by 2002:a17:902:ea0b:b0:2c9:9a19:df with SMTP id d9443c01a7336-2d37ebb174cmr71789975ad.18.1786635103360;
        Thu, 13 Aug 2026 08:31:43 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:3b7:6da1:c188:d14f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c4e8098sm11911405ad.84.2026.08.13.08.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:31:42 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: xen-devel@lists.xenproject.org
Cc: jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] xen/pcifront: Fix PCI device reference leak in AER handling
Date: Thu, 13 Aug 2026 23:31:38 +0800
Message-ID: <20260813153138.3953222-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_get_domain_bus_and_slot() increments the reference count of the
returned PCI device. pcifront_common_process() drops that reference only
when the device or its driver is missing. All paths for a bound device
either return directly after invoking an error recovery callback or fall
through without calling pci_dev_put(). Consequently, each AER request for
a bound device leaks a reference and can keep the device allocated after
removal.

Store the callback result, release the reference after callback dispatch,
and then return the result. This keeps the device alive while its callback
runs and balances the lookup on every successful path.

This issue was found by a static analysis checker and confirmed by manual
source review.

Fixes: 956a9202cd12 ("xen-pcifront: Xen PCI frontend driver.")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/pci/xen-pcifront.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index cffc32d6603277..07263dfe22d538 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -575,6 +575,7 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 						struct pcifront_device *pdev,
 						pci_channel_state_t state)
 {
+	pci_ers_result_t result = PCI_ERS_RESULT_NONE;
 	struct pci_driver *pdrv;
 	int bus = pdev->sh_info->aer_op.bus;
 	int devfn = pdev->sh_info->aer_op.devfn;
@@ -597,21 +598,25 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 		pci_dbg(pcidev, "trying to call AER service\n");
 		switch (cmd) {
 		case XEN_PCI_OP_aer_detected:
-			return pdrv->err_handler->error_detected(pcidev, state);
+			result = pdrv->err_handler->error_detected(pcidev, state);
+			break;
 		case XEN_PCI_OP_aer_mmio:
-			return pdrv->err_handler->mmio_enabled(pcidev);
+			result = pdrv->err_handler->mmio_enabled(pcidev);
+			break;
 		case XEN_PCI_OP_aer_slotreset:
-			return pdrv->err_handler->slot_reset(pcidev);
+			result = pdrv->err_handler->slot_reset(pcidev);
+			break;
 		case XEN_PCI_OP_aer_resume:
 			pdrv->err_handler->resume(pcidev);
-			return PCI_ERS_RESULT_NONE;
+			break;
 		default:
 			dev_err(&pdev->xdev->dev,
 				"bad request in aer recovery operation!\n");
 		}
 	}
 
-	return PCI_ERS_RESULT_NONE;
+	pci_dev_put(pcidev);
+	return result;
 }
 
 
-- 
2.51.0

