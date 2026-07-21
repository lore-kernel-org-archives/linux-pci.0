Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891242DFEC
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662403; cv=none; b=lAJCld53wynfFVXdXdazHAbALcC8bL6WAOG1Dy46d+kiabNxKdXcMWVtH04gooB4aHagKo6OlDs2Wu9jc6hlLDgxKfJ5mcdtzwjBBZD6JGo+BpoHfmaWG10nPW8BXgSjSUk82NUnx24m41pqxRjEIIvF5bDMblZaRobGo3xpykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662403; c=relaxed/simple;
	bh=DOyzqGanUpt++cBhhu0vNvcfSNWl9oIRKU4Wm95lP78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9ptSsjUreKypgNgi5jKlKwyAj77aQiMTThVa2Smz2lMXrdQmjRw6+Lk3LtmLJIK4lnm9u4pLXzVgdxrrWuWqE1creFAIgckSndkTR+XJ3osfFPZI/LyLAdMl8EVg+r/eZ/EqhFghaxbFRZHcYTffAwB14qZzjquqbO58doXT1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtOfXauu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtOfXauu"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so17614675e9.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 12:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784662400; x=1785267200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TedH6DZIw0iIku/jI16FhHpwD7ZfCo0oG7EAmvGAzsI=;
        b=YtOfXauusHv+h2avYpD9+kUb3zmqfR4Uv30qGeTiXs5Jlr0O1rCQVZW789eZ0g0Lok
         734FXtmZYA7l/HDaV60eeJ8B4ahsSJ594XINk0Cmiw9bNwJZ7XLlCFKzJHL4eMZ2sY1r
         XP5be4boGENGXMsRm0efE7aHMniY/rtDlfUFhGmTNjbBMDtTHLV+0HekD1+xquFpxqe8
         RbxRZlQEY1jAgxrSRiV1MI7Wi+6WMacIw8hqp6WO59JQGDijdtukaXmaNR7wFJXj1s05
         uWUn9JM2xMgj6C5JIzcdMyCiviXnQxjXu3fjLwYfQ9QGptXwmC1bcKUZp8tbVCzXaBOU
         JA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784662400; x=1785267200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TedH6DZIw0iIku/jI16FhHpwD7ZfCo0oG7EAmvGAzsI=;
        b=BUDoBS7J2Vx6kmcjiUQvGTNYpe28fvo3X5/tM2PdgSQKuqq0FprSAq761Mbt5k1HGo
         5k5oNykw3vQAJWRD7Q/Uo4+i8lFv1mt6JSufztEZmzMikpBSxo51RfAv6AqgjkMz0N5r
         0kLcXUfDFdy04HryY2FqFAK1Q4061YcZINmCH76X0SMPUHac1SXf8aBiQ1z2TsO6A0hk
         jSnJblTR+CDnCF/oz01+NIIuv2mmb7FCSlSfqtUqH4ZU2YqkuKlUcevyblLBLFZzuBV/
         XXczfeJMfpfl9WpQI3dkRomcvE0yzzeVF8VMhyNJ31Iw6aZJwgVRIIxsuYYdXKushIiS
         AXAw==
X-Gm-Message-State: AOJu0YykOsSzugykAH4H0facJ+0+/tVpiFZ9DGc402MkjPdDxbNFveCk
	f43FvXAuJiGT5nDw1cKeTSOvaCgM/YD+owA3ZiZZukxDVhpbI5MxsC3I
X-Gm-Gg: AfdE7ckW3B64vRSFu9jQ8jPt+fUVcMJXgbT0eeP/59evb1AN4BRjJTD+JUwrnGwIDUn
	6BpZxyZnb9/PzPoqjMIDJyjTHniS3H3DnwXq6sspyytG5Fz2BayjLnFTsB12QV7cCbsMQVzwp5x
	d53/1qK5ZEdxCdXZmMg5eL7IhF9A8YAVNDYywDYXELprdf5G3XDAXd7kGphkLuFdaDrWRdYnaIN
	wSpdia1KO9muVs9so95eq929oyAnS/l2lQwEhQbLTXoCV1Lmwwz1HbXDJK1VQLVxOEMbL5XQ2h2
	UBeDGfZFsaOs2ONcddLeWhH0wy5YIBo5PNJJnt55Pvgj3xnCRYVEcWbUxfnol2xhK0NpsdhoFaI
	kkdHyE2ufMbNZoe8ndF3ydUh+DgnSSbs9CMfkLLDSeaYyinWxU2iWgebTm0kEemM60dE8NWcf12
	XTPCGIklvEZUA5D7eQHUNbb+EfjdqK9Xyq0MvDDCPzDJBPFeZjuzl2ab7vVF7g9GJyBKOydQp5
X-Received: by 2002:a05:600c:4755:b0:495:4a34:16e3 with SMTP id 5b1f17b1804b1-4954a3d0d04mr237398735e9.1.1784662400112;
        Tue, 21 Jul 2026 12:33:20 -0700 (PDT)
Received: from c64.fritz.box (p200301048f0fe900a0f9605663da8872.dip0.t-ipconnect.de. [2003:104:8f0f:e900:a0f9:6056:63da:8872])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f6fa848fcsm31159705f8f.0.2026.07.21.12.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:33:19 -0700 (PDT)
From: Saverio Miroddi <saverio.pub2@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saverio Miroddi <saverio.pub2@gmail.com>
Subject: [PATCH] PCI/DOE: Add debug messages for transaction failures
Date: Tue, 21 Jul 2026 21:33:10 +0200
Message-ID: <20260721193310.1179300-1-saverio.pub2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DOE feature discovery reports only -EIO when several distinct mailbox
status and response-validation failures occur. The abort used to recover
the mailbox can then clear the status before it is captured, leaving the
existing failed-to-cache-features message insufficient to identify the
failing phase.

Add dynamic-debug messages immediately before the silent error returns.
Log the transaction phase and raw status or response length, but do not
change mailbox behavior or expose payload contents.

On a WD_BLACK SN8100 NVMe device (15b7:5050, firmware 830ZRR0A), whose
mailbox creation fails on every boot, these messages identified the
failure: the device accepts the Discovery request but never presents a
response, and the transaction times out with the Busy bit still set:

  pci 0000:05:00.0: DOE: [500] response timeout, status: 0x00000001
  pci 0000:05:00.0: DOE: [500] failed to cache features : -5
  pci 0000:05:00.0: DOE: [500] failed to create mailbox: -5

Signed-off-by: Saverio Miroddi <saverio.pub2@gmail.com>
---
 drivers/pci/doe.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 7b41da4ec11a..3c376add3293 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -282,8 +282,11 @@ static int pci_doe_abort(struct pci_doe_mb *doe_mb)
 
 		/* Abort success! */
 		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
-		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val))
+		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
+			pci_dbg(pdev, "[%x] Abort completed, status: %#010x\n",
+				offset, val);
 			return 0;
+		}
 
 	} while (!time_after(jiffies, timeout_jiffies));
 
@@ -323,13 +326,19 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 	if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
 		return -EBUSY;
 
-	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
+	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
+		pci_dbg(pdev, "[%x] status error before request: %#010x\n",
+			offset, val);
 		return -EIO;
+	}
 
 	/* Length is 2 DW of header + length of payload in DW */
 	length = 2 + DIV_ROUND_UP(task->request_pl_sz, sizeof(__le32));
-	if (length > PCI_DOE_MAX_LENGTH)
+	if (length > PCI_DOE_MAX_LENGTH) {
+		pci_dbg(pdev, "[%x] request length %zu DW exceeds maximum\n",
+			offset, length);
 		return -EIO;
+	}
 	if (length == PCI_DOE_MAX_LENGTH)
 		length = 0;
 
@@ -369,6 +378,10 @@ static bool pci_doe_data_obj_ready(struct pci_doe_mb *doe_mb)
 	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
 	if (FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val))
 		return true;
+
+	pci_dbg(pdev,
+		"[%x] Data Object Ready cleared prematurely, status: %#010x\n",
+		offset, val);
 	return false;
 }
 
@@ -400,8 +413,11 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
 	/* A value of 0x0 indicates max data object length */
 	if (!length)
 		length = PCI_DOE_MAX_LENGTH;
-	if (length < 2)
+	if (length < 2) {
+		pci_dbg(pdev, "[%x] invalid response length: %zu\n",
+			offset, length);
 		return -EIO;
+	}
 
 	/* First 2 dwords have already been read */
 	length -= 2;
@@ -447,8 +463,11 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
 
 	/* Final error check to pick up on any since Data Object Ready */
 	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
-	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
+	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
+		pci_dbg(pdev, "[%x] status error after response: %#010x\n",
+			offset, val);
 		return -EIO;
+	}
 
 	return received;
 }
@@ -515,12 +534,17 @@ static void doe_statemachine_work(struct work_struct *work)
 retry_resp:
 	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
 	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
+		pci_dbg(pdev,
+			"[%x] status error while waiting for response: %#010x\n",
+			offset, val);
 		signal_task_abort(task, -EIO);
 		return;
 	}
 
 	if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
 		if (time_after(jiffies, timeout_jiffies)) {
+			pci_dbg(pdev, "[%x] response timeout, status: %#010x\n",
+				offset, val);
 			signal_task_abort(task, -EIO);
 			return;
 		}
@@ -564,8 +588,12 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u1
 	if (rc < 0)
 		return rc;
 
-	if (rc != sizeof(response_pl_le))
+	if (rc != sizeof(response_pl_le)) {
+		pci_dbg(doe_mb->pdev,
+			"[%x] invalid Discovery response size: %d\n",
+			doe_mb->cap_offset, rc);
 		return -EIO;
+	}
 
 	response_pl = le32_to_cpu(response_pl_le);
 	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
-- 
2.54.0

