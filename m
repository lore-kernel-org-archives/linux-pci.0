Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF844E67F
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686219; cv=none; b=uK4gXwScIsI0nVT75VefXGFGJhDUo9Wsk072rYAGtHcYd3xelQoHXukMiBpUx30umLnIHa0Mm97mopKdxIq/D5/Zri47rbrUPu4DfqvPgZqXrB/0JZB0bxaNBCZ2jSbyHccQVgPOhP7nSqrwSZNsFddsF47UPbH5nlvN/AxOF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686219; c=relaxed/simple;
	bh=fX8Mv2j3jfcMNfxZ/Vvl78fSymNk3CAWNNUODUyuZUQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=svL6xwlkiReqTuUBgT/i5gToiOcvaSdquFjFbYcGUOaZneNh94CEcOV1XovGAXha4eYprtk2TJANGvfKb6PorvV6c6jfL298kr4JpaIWzIjELCB14xNYGM2axaP7Y7jyCwLs0Yusx0Q2Mj3jU4IOAkGfDW1Og2sAl6mFXca4Ovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m2bxTF44; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m2bxTF44"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cf5bd2f12so1917775e9.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 16:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789686212; x=1790291012; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oYAViEKIR6jmAp5mlWeLAMEKyuMg7x9lqO4x+CGM4FE=;
        b=m2bxTF44XTcKTpY3xqttoDLnQN4QjQHAEimEgc7Xu1QCNtCVZ7+4itg/IbrUaQHQoE
         gERpju5e6FjGobgSjq0jrR1froxe5iLWYu4KYGw9a82BowA+6m02Hm0iVp8qjHqJlf8o
         gL8puHyceBbzWE7VhHAnmvSg6c3DKTnTXpM8QIEd93sEWZevxYfmeGR3ICPEEUkJOnbW
         CuGPO2rAmL0SFPsfhYKn0h/PJMMZnuZDDbzQVsklDpAVDb17Ja4HPGbUKmakNkWHCnKu
         ff7IygsqHzcnn+SgOEaOFLmZE3gkcPtTWUlOlYqeHvutXbh7d2882WGS6rt2+gyzNg6C
         nCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789686212; x=1790291012;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oYAViEKIR6jmAp5mlWeLAMEKyuMg7x9lqO4x+CGM4FE=;
        b=XL/8AHCq85c7g5S0/x223qaWOsyVWFgvWrVLRfz84uIKLNr9kkdrMDrAB8IexD4s/x
         TsvztnIPMsu4NfnywDTM8mSbkZbP2kNjN4T3wmHDnOu2XaaejAZ6VSQu1K6aatBbORK3
         KBuSuA7tP9LORJT+hi6nFpDiKw64TaytDFJrWkMdO/TyGu3WZm4SYpBlA+sJNG2X3Lxt
         75vi3thtHLe+h1nfPU5SdwfDWOJKn+O0fdyTAdZJSgGwuEiXn/MFV98S4EC2Wladlx9c
         dirFlc2wL27D+MIfJKf/Ct4UW5c5r4huu+8NtWwvvmlBeeI11+qQKzldHX6jP3eWUPZx
         Ivdg==
X-Forwarded-Encrypted: i=1; AKwUvBysapbzoisAL+iQclqINvk51nal+Orp860ruRTel/Z1/zaOoORwDZVNtfP+E4tWg9b0OOLaQ9TSQ/Q=@vger.kernel.org
X-Gm-Message-State: AFuF++m0h2zwmEYcUWLrusvNVGUPa5vjs3yA3W5DcGECJK7yA/9gFvsG
	WHB0Zm+xfzrKUYo+y8izShuL9euO2M0L4gD/ZCi1xNwg28owxCLDwg+Ts0Ov50mPNq4nVgFlAoK
	gDx3IBwceiI/zEcz1KHt5BQ==
X-Received: from wmbds16.prod.google.com ([2002:a05:600c:6290:b0:49e:78cc:d2b])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4695:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-49fc55ac96emr5942785e9.0.1789686212281;
 Thu, 17 Sep 2026 16:03:32 -0700 (PDT)
Date: Fri, 18 Sep 2026 01:03:23 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917230323.3701743-1-mclapinski@google.com>
Subject: [PATCH] PCI/DOE: Poll briefly for a response before sleeping
From: Michal Clapinski <mclapinski@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	linux-kernel@vger.kernel.org, Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

doe_statemachine_work() waits for a response by sleeping
PCI_DOE_POLL_INTERVAL (PCI_DOE_TIMEOUT / 128) between status reads,
which is 7 ms at HZ=1000 and 4 ms at HZ=250. Exchanges are served from
the device's local mailbox logic and typically complete within tens of
microseconds, so nearly all of that sleep is wasted. Every DOE-capable
endpoint pays it once per supported feature during enumeration.

Poll with usleep_range(20, 50) for the first ~2 ms before falling back
to the jiffies-based wait. On an Intel Emerald Rapids system, time spent
in pci_device_add() for a DOE-capable endpoint drops from 41.8 ms to
14.0 ms.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 drivers/pci/doe.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index ac95b1d2d999..6dc85133a88e 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -27,6 +27,9 @@
 /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
 #define PCI_DOE_TIMEOUT HZ
 #define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
+#define PCI_DOE_POLL_FAST_MIN_US	20
+#define PCI_DOE_POLL_FAST_MAX_US	50
+#define PCI_DOE_POLL_FAST_TRIES		40
 
 #define PCI_DOE_FLAG_CANCEL	0
 #define PCI_DOE_FLAG_DEAD	1
@@ -486,7 +489,7 @@ static void doe_statemachine_work(struct work_struct *work)
 	int offset = doe_mb->cap_offset;
 	unsigned long timeout_jiffies;
 	u32 val;
-	int rc;
+	int rc, tries = 0;
 
 	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
 		signal_task_complete(task, -EIO);
@@ -524,10 +527,25 @@ static void doe_statemachine_work(struct work_struct *work)
 			signal_task_abort(task, -EIO);
 			return;
 		}
-		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
-		if (rc) {
-			signal_task_abort(task, rc);
-			return;
+		/*
+		 * Exchanges are served from the device's local mailbox
+		 * logic and usually complete in tens of microseconds, far
+		 * below the jiffies granularity of PCI_DOE_POLL_INTERVAL.
+		 * Poll for up to ~2 ms before falling back to it.
+		 */
+		if (tries++ < PCI_DOE_POLL_FAST_TRIES) {
+			if (test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags)) {
+				signal_task_abort(task, -EIO);
+				return;
+			}
+			usleep_range(PCI_DOE_POLL_FAST_MIN_US,
+				     PCI_DOE_POLL_FAST_MAX_US);
+		} else {
+			rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
+			if (rc) {
+				signal_task_abort(task, rc);
+				return;
+			}
 		}
 		goto retry_resp;
 	}
-- 
2.55.0.1082.g2b9226bbc0-goog

