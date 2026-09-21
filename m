Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CDE4E2F28
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010415; cv=none; b=Sv6FzYJ0vDuPNRHTfFtWO4VPvcLuzDmnaUCj4khTFZxY/5Y7lH469DS8w2oktvSp4wnwMaHxXHjO/zBfqMdp2KSIY5A0BKds0unmzQurRKxuczbrDzkwaA6xZQSME741g7NiTB5n6Ydj8JK4ZKlW1HTeZiNu5B3CbhdrDSfxgw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010415; c=relaxed/simple;
	bh=Ol+o+JAXq5dYlZyih6PceXLRCemV4Y38mFGRIh0RFUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7h3zZUB8IKCGGt3hszqZvMfeblSzC+4zDYoQc5BUa5qDfw2wBH/bV1ecPKYLCobJhNIXW51DFyjon1GNLVIsAliJlAmZ0bJ3lBl4M3lzydnCWg0h2r1jaT4jkDDT4uI1AM18h57ghVCnlD4V+pg8xub7FTNm3sN8XMJkW4pZio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=YU3K7uay; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YU3K7uay"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f0135fso31225005ad.0
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1790010413; x=1790615213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GwcsKROG+rZVrILjrCxe0rMudS7EciJJq2bzjW9/XlI=;
        b=YU3K7uayuk5kfs+vI82j1LQyy5y6d9cas2nGw4+ndmzYKeOhr2gdeHKzqpac99qnLt
         a/J41Q9c4R4gh+T6lgbct06oNuhaiEkjYjU5MY9eJ5DyWMTK0QLsyvhyXYFuGaw3fTc/
         97E+SiZdY2nduImn6sjjGc5FBJxyJAWlD2eyr3mA5RlCEbLEUMr/bsDMADOkgiABrErF
         jH2VPhgjbReF/xUMVYXlc5ugUgXch7ceuyouuABO0tO8n7484OS5qQvjPDmdkRsBNZwY
         W039C/rbh+tKdrDkrCZLfUThY6he4SeBFtFVCzumnWQLOEmfkKbYuls8SUAoMBh4xA2V
         9iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790010413; x=1790615213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GwcsKROG+rZVrILjrCxe0rMudS7EciJJq2bzjW9/XlI=;
        b=aa4VxULBdWL2uD8VLkqTHOOHU63SLEpdpfRE/bUcL0JIroem47DHqFOK/AoNofH6pX
         0XdG9O21Ms1XyoTGXJSY9xfKIMkgj4e0WmcqD7CdnTxi9jw1fGymoo65tflQyCIRq15L
         5ZjvmkKIbtQE7TkQRoMhFM17WT44btI5jDmOYbEFirgL41wu4t0kFTFJF5wYlBVk9IEP
         8/sUqvePXUh2RUE82h5KtbP5CMqE0D9XpxV4PJeMRdPTWFlw6M1dA3tfu+2GZbUxduzv
         vmc+lpPpZUwfeZDytLbslHH2cNBhuDM+JBKBhBqCoVtfMmPNU4FbZ7TyxZyVR0Wb6o9N
         mgMw==
X-Gm-Message-State: AFuF++lUEDLq1B2ArZRvcwoymiMtGgXDZjED5gXcdW/Kbaou/DpF240R
	6ShD5S5DSkRcitGQf7I8xVJBTiaZJEc781h/JykEibIhIk2k4hddriksTJ2Szw2PNg==
X-Gm-Gg: AYBFou3ZNgEJ7E01toSzAVm07c2y+GfHTAnbD/xFgpcSIDkqCgq61wGjnQ0pk7TOUP6
	VgcoobWKjP/vscv24kfflx4JyYYB8zySCjiAhVlPEmq5C/GREvpgcEc0c2/OefYfIQ6hI5476Wn
	9DMzVCOuCg0pHQTSlamSCmksMPebbQHexizWTOQkFYTxUYerjoURh4QMQMSMQxknUyygWs/2lIh
	TetDStTmlYUvtcKHqqMU5J9ypB/mM6p21ZtkY3zwuLZTHP6NnVtYmtUM9RUzHVQab/vr8uKW8k5
	PGaa/1gxKx1yvMGb9uM7fqJwoZpuAX/ffAi6kcGv510KoFdZK8FZQ9uEjq49KHaEf6nIfCcF7qh
	6bKuIs6a4b50U4dhtP1bN31lkvq+85UeXt8cK4g948ZChdHYcHqrkIwU4rH8MJcsFD51Cv08+gi
	rmSBMcEGoQCZBAb48QHH/maZ3rZJaNyKaOLOFUlhfw/m+ocLzAun8G/OMs8ahDnI0lIBNZL5A/O
	Pl5C/wlG7OfrxrV9XC9yoTA3lHH9WYBRti0XeUQ6zI=
X-Received: by 2002:a17:902:d551:b0:2df:3a80:dcba with SMTP id d9443c01a7336-2df3a80dd6emr83493705ad.52.1790010412484;
        Mon, 21 Sep 2026 10:06:52 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc178889dsm37147495ad.18.2026.09.21.10.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 10:06:51 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com,
	lukas@wunner.de,
	ilpo.jarvinen@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Murashka <yurypm@arista.com>,
	James Sewart <jamessewart@arista.com>
Subject: [PATCH v3] PCI: Stop waiting for link status after config read failure
Date: Mon, 21 Sep 2026 17:06:46 +0000
Message-ID: <20260921170646.1201148-1-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260904111318.1063858-1-yurypm@arista.com>
References: <20260904111318.1063858-1-yurypm@arista.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With a nested PCIe topology with multiple layers of hotplug, a link can go
down near the bottom of the topology shortly before a link above it goes
down. In that case, pcie_wait_for_link_status() can wait for the full
timeout while every read of the link status register fails because the
device has disappeared.

Return immediately when reading link status fails so event processing can
continue.

Signed-off-by: Yury Murashka <yurypm@arista.com>
Co-authored-by: James Sewart <jamessewart@arista.com>
---
 drivers/pci/pci.c | 15 +++++++++++----
 1 file changed, 10 insertions(+), 5 deletions(-)

Changes in v3:
- Check the return value of pcie_capability_read_word() and stop retrying
  when the link status read fails.
- Do not use pci_dev_is_disconnected() because a read failure does not mean
  that the device will be marked as disconnected immediately.
- Update the kernel-doc return descriptions for errors from
  pcibios_err_to_errno() while retaining the -ETIMEDOUT description.

Changes in v2:
- Check pci_dev_is_disconnected() before reading link status instead of
  checking the return value of pcie_capability_read_word().

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8080e949f7abfc4bab39d791735b8..430ff08f4f4b30f12b1190ea9c5408a3a8505a5d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4565,8 +4565,9 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
  * @use_lt: Use the LT bit if TRUE, or the DLLLA bit if FALSE.
  * @active: Waiting for active or inactive?
  *
- * Return 0 if successful, or -ETIMEDOUT if status has not changed within
- * PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds.
+ * Return: 0 if successful, -ETIMEDOUT if status has not changed within
+ * PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds, or negative error code if
+ * reading of link status failed.
  */
 static int pcie_wait_for_link_status(struct pci_dev *pdev,
 				     bool use_lt, bool active)
@@ -4574,13 +4575,16 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
 	u16 lnksta_mask, lnksta_match;
 	unsigned long end_jiffies;
 	u16 lnksta;
+	int ret;
 
 	lnksta_mask = use_lt ? PCI_EXP_LNKSTA_LT : PCI_EXP_LNKSTA_DLLLA;
 	lnksta_match = active ? lnksta_mask : 0;
 
 	end_jiffies = jiffies + msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
 	do {
-		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
+		ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
+		if (ret)
+			return pcibios_err_to_errno(ret);
 		if ((lnksta & lnksta_mask) == lnksta_match)
 			return 0;
 		msleep(1);
@@ -4603,8 +4607,9 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
  * according to @use_lt.  It is not verified whether the use of the DLLLA
  * bit is valid.
  *
- * Return 0 if successful, or -ETIMEDOUT if training has not completed
- * within PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds.
+ * Return: 0 if successful, -ETIMEDOUT if training has not completed within
+ * PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds, or negative error code if
+ * reading of link status failed.
  */
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 {

base-commit: a500db7819c50db59e55f1b4fa1c3baa5a2616f3
-- 
2.51.0
