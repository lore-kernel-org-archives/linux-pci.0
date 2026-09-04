Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9885470E82
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520434; cv=none; b=TH8vUHoNXjava7APLOngW0q5gErRaQPZ5tRbuWUa0uE451+2kolsFSYo7034ccKOBK0RXDpy0uIccqn5K73v1dCed5khMYZsJw1Goeq+mq7mzrKYShDUWrfCrLXncqLr+TvYKgRnp7QJ8SoBgsy8vVtfH1QnY6YC6MdyPoGq/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520434; c=relaxed/simple;
	bh=Y8T6yLy2yGEI+APB3IYjDn3KveHumya5KjHfGlJCvyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnuC59ygZQ7RjVs4EwhrARRIrXglwkr1m2NepdJGiGuLEZSqgZMbW0DPEOqU4hSa2Rw04+XSaGWQZPIOYNYog2t11Yr8khMyXUhVOPKFCRrVHvAv6ZSiSHjEb50tgh/ueJNlJf7Bnq0bkkuV3ZvsOg4rmlTJVrcDjZm0mEG1XXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Bf5aRlps; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Bf5aRlps"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso771183a12.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 04:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1788520432; x=1789125232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fOtfsRW4UXMS4fgRA6s6kxtseIqwUyKdipeNtq+aXP8=;
        b=Bf5aRlpsGP6FsVqN4x34nJ57jo3Q3NVEUZgRcbC0F4TR7my4lAvQ4qhHUxamL6SKct
         IgWafYRfeFezh6HQDxeG3/aSCbR/yF9LeKpmHI4WYAG55t09I0yXEeiHwr0bx/vGmxyn
         Vb8xvQ2vnqIavgt5QfULQhvKlnmG80HkW7T9nLxPcnG2p8l/FPimB4q5ZDYXVmfH1F/z
         EBylCAbQJJ0XCLCBURghZLdj+iAC6Dz5aehneBER9VWC/Uhd6WOimmxA/oraok9JGJR7
         bOc3k1t+kRkkU0TWNRyTte9LzsJ+d+TgDCcdgXRI+caxGQJ+W8K5qb6vDrgefRRApjYv
         wZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520432; x=1789125232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fOtfsRW4UXMS4fgRA6s6kxtseIqwUyKdipeNtq+aXP8=;
        b=L7fvqD3vfumyk4N8VHjPk6TdIwZFLnmiMVDyrpaoY1btCdBQptsZO6/utM6cdSIpS/
         PNy8wW4148yO4cxwxAfvWWIdiBIONu09b7DsY8KqrQNVBV+/AuIqqT6Utdd2xR/Flosq
         TneMxEiKY8qgMfiOZ1+Sl8Dg+luEJJd7jWZyqO64gnPQKkPOeLCOOSu+MkfBshCdHTKI
         VJx0IyfK+0c8Q7uW0zedVczQkNQvU8UYAkG7ZPSkddUUJux2cgd4LchxMXdGUemtau5K
         NfuPcGs0+WtTi+aHYEvKV04ZDZssaqNOVmMZBc2Y2TOsNRhRc3siQP/1jnwivOTQ7Wao
         6UmQ==
X-Gm-Message-State: AFuF++keBiDxHDGIbrEDCV74YWdy6+EkfXEwwOnuJkZUnh3LueDmx3LH
	qFwPGqaJubYpdkqdIzUmsOo73Cyl8Kor/EaWJVL5ylgrtkJ4x2UPLb4kTp3PAOgPCA==
X-Gm-Gg: AYBFou3aq+3iUhUeRLxmQ/WQTM7wSpllEIn4u+ODB2nbUaiIB/H3TnkkwtVxnINU455
	3b6QTQlYWZf9ohYysVHuRx59p+y/vSB/qdD+33mvE4LBusavgVkDDsGabMsHvWdYe6bqRVoBMIc
	sUVkUlAM6qEAp1IXp8R9SvRkbPkIpgydcQZsIRG/arkGP9T2cMpEMEXs39HqMQP+MBkbQxn/p+b
	mHrCOwIVlKR3GltbZlr4cDzg8i2UnHRoti/5CVnruMOZ8RYrPPbHUCv3AS7Gcd6TyiieU23W038
	Lbq7Rg2zLtIa6lMXE9HWySsbpUzsxwXFD4ffu3j9I1dFyjUPrCjRUhK77JCSiN+hys8bshb6ukf
	wDXpURNA3Pa/pWypwrd9A6VauaiCmTllEF3LARXpGjgbZ9+b5xnfgbekcl4xlRpDqOX1gGMc4cT
	8EJrUbJoZDjBKBOOMttZNKDmyjOSgniymeYar49JCoeTMtVGIDFAM8MP/VYYZT9PpBM671p4uma
	QnvobZHVY+Q/WIEDNvb
X-Received: by 2002:a17:90b:2b43:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-39b25ed34f3mr9646311a91.0.1788520432198;
        Fri, 04 Sep 2026 04:13:52 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.10])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm6037999c88.11.2026.09.04.04.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:13:51 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Murashka <yurypm@arista.com>,
	James Sewart <jamessewart@arista.com>
Subject: [PATCH] PCI: Stop waiting for link status after config read failure
Date: Fri,  4 Sep 2026 11:13:18 +0000
Message-ID: <20260904111318.1063858-1-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
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

Return immediately when reading the link status fails so event processing
can continue.

Signed-off-by: Yury Murashka <yurypm@arista.com>
Co-authored-by: James Sewart <jamessewart@arista.com>
---
 drivers/pci/pci.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be..a568d5ac1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4565,8 +4565,9 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
  * @use_lt: Use the LT bit if TRUE, or the DLLLA bit if FALSE.
  * @active: Waiting for active or inactive?
  *
- * Return 0 if successful, or -ETIMEDOUT if status has not changed within
- * PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds.
+ * Return 0 if successful, -ENODEV if the link status cannot be read, or
+ * -ETIMEDOUT if status has not changed within PCIE_LINK_RETRAIN_TIMEOUT_MS
+ * milliseconds.
  */
 static int pcie_wait_for_link_status(struct pci_dev *pdev,
 				     bool use_lt, bool active)
@@ -4580,7 +4581,8 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
 
 	end_jiffies = jiffies + msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
 	do {
-		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
+		if (pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta))
+			return -ENODEV;
 		if ((lnksta & lnksta_mask) == lnksta_match)
 			return 0;
 		msleep(1);
@@ -4603,8 +4605,9 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
  * according to @use_lt.  It is not verified whether the use of the DLLLA
  * bit is valid.
  *
- * Return 0 if successful, or -ETIMEDOUT if training has not completed
- * within PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds.
+ * Return 0 if successful, -ENODEV if the link status cannot be read, or
+ * -ETIMEDOUT if training has not completed within
+ * PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds.
  */
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 {

base-commit: a500db7819c50db59e55f1b4fa1c3baa5a2616f3
-- 
2.51.0
