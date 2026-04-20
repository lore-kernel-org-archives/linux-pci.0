Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294E3192B75
	for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 04:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776658202; cv=none; b=Q1ifK7u2VuU399OvwTj+6Yuj3MBuAC3+Gp0DbdTNwZD2hFsEP+wlUCTXMhZbM85IXKbyrYQm3c5xJQcJgU36qvWqAaatzf5fAhRxM8pJLkU0jNNzEQNVazXLlDg7ec5JxFlT3+nh4AK0OA7d61TpyMllkFELq2/SMku0Qo70DgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776658202; c=relaxed/simple;
	bh=bZ2ry1xfP2UeocaW7TLRpAHTsNMxxx+8b53nzvK38NU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sVRtCofY0Yd3UGufQvwyp7YMSyIGyM/eZ9hJ0F4p4RxqwAzYl7YqisMkuargbIrcn+nJUJYfKvvybpB4U0KwFfvuWgm1vtv1BB2WZ43QGA5YZ3eHErOpIJall+lpLeGz0oNUoQBv5W4KqTBZ7UMfglFY2MFmuVgNI3GEnP//8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdJuD4gt; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdJuD4gt"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c736261ee8dso810715a12.1
        for <linux-pci@vger.kernel.org>; Sun, 19 Apr 2026 21:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776658199; x=1777262999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GG9gvbqL+uVEpWZ2SVlw3MTaiPM/Nzs0ORA3YODGzCo=;
        b=IdJuD4gt4grt9XCk2Xya3wDnbP8uJZyLFB5gTUwvfwi1ye0dIdRTSoEAjeJhTT0OBL
         R3EBDZKWqcTzcM6ozQmRF61CFPKJo7/7JLgv8oeVgpT5u6f1CDLlxcp9Qd/YN5/W3CgB
         jtPmgc4pisjaaQN3j4Tqhs/1h5UKk+Z0o0bZ40XTKsnn5msOBCi85/60ChkwIf1Z03vI
         3npaaDiLtADh1EoeDLhC2IFUnQuKEMnEy1Mi1QNCstbfGOEzmTfxhSjgRICgJwEtQ/aR
         jO7I0+c7JZc06xIcffrWRvxNB+P7phtkCnqRzWToYX69vd5vDzpWpw/HPewGgmXy8BF2
         zD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776658199; x=1777262999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GG9gvbqL+uVEpWZ2SVlw3MTaiPM/Nzs0ORA3YODGzCo=;
        b=PEVkEJPGoosxc0cAUHalVFeMeCOwy7+noJ8hgCCr4Pe2vy+pMQqWmiDjIpw5wPppOq
         RS86xvCZ26Gj1vl9T1tC45FtEHYW8ywnwTSftSdnRFL7Df86hN0ykUT0h04zVDs5XUAL
         g9uKQBhCiuc85nL9cDd6u9O4Wj7XTyNyyRE8IdNGhigWu7OHjwkH0ovdJhszpR4kZ2Gh
         JasybeebixzDTNwQtCNDpxjRDkQkifm018CkBNtkMQrH8ZzV+HTwOF5gIM0vxcdn8Pyi
         tpo0jozsl+t+kbNevSUrCdURos3dqLnKEVIAkszPBhVzTyQiufX6BusLWfp2W5jvJBn9
         MLWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9d700cNa8oysSlDg1MGEFa9tVqrLSKhkn8G5wWYoTnvDRJ1YWqG5jqGK/lEfENWGIwH0GTh9fHR/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ZctTHJ9TKdGh2MJiKPS1TTNAiZzjrMbcUJfTpwZBe+d9DaJ1
	muPZ+NWjsoog9JwvxQsRCj157ZHXhpoHwAb06SpyFu9Dr4KlpSIwWxu5
X-Gm-Gg: AeBDievPk8+sHQd6NoLbKzTWBpUyBa4H0ABqCFGbgPMPZc3JtzCwpWA+HJdlY8tFb7n
	ODUdIAF5SLVgO0IovgK5aErGg6UEUMy4IH/j2zjFd6a5ph7CQI+AU0nTo8wHqsik80oDOLllvfj
	h07n7NvVeV/HQU4sE2FVsqmAyqgcIXF5nB40VfgdZKf36qniSOtYERt8FAL3j9umJNY8XSBX/cF
	Pz78Tad03PC4aMcxIVLfM2G2tp9etIxS4Wr05GJGvhKxugzOl+pL19cLqNy98rxpSwnXOnciXBj
	KomRZ6L+P2loI4MzOGrqDL8YTGk1cFagNPlPA/utDCv3ikq7DfvX+La3ll8MqQvrwCl//xZPken
	F8QObAuoM5Os+vqi9oM1fmQngGZgX1/60MCKEBtsg8IRu/h34rhNX0shfNEn/yOG07c70I7ZKaJ
	9L9y8kKiBwgJRX0x78eZEW4KyPMz4b4tw8xBCdKYHSrXecZcbWh1TFQl8rLtnb6zM91x0=
X-Received: by 2002:a05:6a20:7faa:b0:3a1:90ef:7e31 with SMTP id adf61e73a8af0-3a190ef81d8mr3758746637.54.1776658199433;
        Sun, 19 Apr 2026 21:09:59 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797702fbfcsm6800160a12.22.2026.04.19.21.09.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Apr 2026 21:09:58 -0700 (PDT)
From: neilfsun <loyou85@gmail.com>
X-Google-Original-From: neilfsun <neilfsun@tencent.com>
To: bhelgaas@google.com,
	shawn.lin@rock-chips.com,
	hans.zhang@cixtech.com,
	tglx@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: neilfsun <neilfsun@tencent.com>,
	Sun Feng <loyou85@gmail.com>
Subject: [PATCH] PCI/MSI: Fix memory leak in pci_alloc_irq_vectors_affinity INTx path
Date: Mon, 20 Apr 2026 12:09:40 +0800
Message-ID: <20260420040940.14824-1-neilfsun@tencent.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the INTx fallback path of pci_alloc_irq_vectors_affinity(),
affinity masks are created and never freed.

Signed-off-by: neilfsun <neilfsun@tencent.com>
Signed-off-by: Sun Feng <loyou85@gmail.com>
---
 drivers/pci/msi/api.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index c18559b6272c..c1377f74b8f3 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -280,14 +280,17 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	/* use INTx IRQ if allowed */
 	if (flags & PCI_IRQ_INTX) {
 		if (min_vecs == 1 && dev->irq) {
+			struct irq_affinity_desc *masks = NULL;
+
 			/*
 			 * Invoke the affinity spreading logic to ensure that
 			 * the device driver can adjust queue configuration
 			 * for the single interrupt case.
 			 */
 			if (affd)
-				irq_create_affinity_masks(1, affd);
+				masks = irq_create_affinity_masks(1, affd);
 			pci_intx(dev, 1);
+			kfree(masks);
 			return 1;
 		}
 	}
-- 
2.52.0

