Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723469;
	b=uvVSbigI6KhJ7wNH+cio1jrRe2SQIz1dSypY1Z/le4s7n7lHyp8OW0DYC+81tN6pcbWQ
	 o1DMRst2ZQzDgB+ZmjVUa2PtJTS2Ref+DuapRA7rrykYUM1ON5BMEopLvaKl857o9shDz
	 5eevSsbOf0d5TxZLfSF8PvNBZcDWscGwPrJMG1yJaTukOQMiBxrFtbIf0k7WpGWm5g4bQ
	 wX9tI5RYQvNp23/tB+HEwU5SbiWfqd1701oWAlQHoUxjWH7e0QMdD+nI5pff4/ZOESM0k
	 jWIaH7jK2CbVIBoy49AvO0qwcfuaCHSoyXro8NBmlitC9jobhayZKeJWDgy5jfgFtiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=VDOlP1yYgCTkepByMon6CVwjX5f86IPmFVoSMeSOXbQ=;
	b=iQBw9B8Yaf62bKrSE5QTHIQh5P5FnmaAZEpZAM5xynxI8hFZ9NbUylKLlri6rPdjAC98
	 ZrjN4P7piMfAhxJ6ZIXq4pA0UpXzyTlANJltuLbiaX5vkNZ7ZeU4HQyTJ/WMItog78enL
	 ucFbqQcBZ8kC5aBRbxhxNNBM2ZT1uxsovWHtKj5M395FBMe5sKkcz2psX1KKfTuWTFxbE
	 1TINS5uEUhPyYgWDWcGPFtI5Iplae59lzI+RHurJ6a/sU0Syh9ZusBf4ptpTfdkbMmzYP
	 cfJMz+EgOsQwSK0KWwBWzmvnghYM0Il+OubBd5idUeWGNW+H0wXlRDdYu6ehTivGOTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XIQYKkEO;
	arc=none smtp.remote-ip=209.85.208.71
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAA8606A333
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 16:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AAA8606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XIQYKkEO
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b1d43907c2so5504530a12.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Nov 2026 08:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793723467; x=1794328267; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VDOlP1yYgCTkepByMon6CVwjX5f86IPmFVoSMeSOXbQ=;
        b=XIQYKkEOmfor/xIJT1jjiUlev5I3Ci0zf/GK2GU+8W/1zq4AsvXsb3EgnxxF38mT7V
         7S1c/kioDJ/5ZIPt8qBYRHJ47QeVi2lWTSlpTYTlH0zKMvGHQ/OKCB3iITI+mhnPfqQK
         bA4r8usE2EN4u7NC74X9iOcvLgmqjExCuLxk7dR8NfWyfZJQIdaER88Va2btu3C3m6RS
         YKC0P7X49JfkRxwoBrxOzbAoPUOJCX2Sfh7vDUk3Q04vlF9q2VX7qqoR098FT4mXPG7b
         LxcSazK2G43e+ZbIw04ayWz9/T+f2QWYmtcT4YSdzzBhXWGWAoZgyEFnK6+SlbRshwad
         Pbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723467; x=1794328267;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VDOlP1yYgCTkepByMon6CVwjX5f86IPmFVoSMeSOXbQ=;
        b=XpEeE8GmpY+P3K2WyrJQqU8QCUJmpm0MZCZdYq41uu065JXdFXLWpqdZh/hxMN7szG
         PasybSmPnFbyA6ncy+SpGu2l+EIplXOtEMVzLeg5xBNO2I/g2KB6ssnmr9hVDkQeyJUv
         XSl2Opb12KsKJqZyZJi+gXqL/Of3lZNqZ7KCGxyLnaENlC8R+8eeWbYiXejexXqpVmbv
         OMIuYTiBrTpyDlCyyTMMNoQgmtlV9A8AuEAsjxJPD/aV2ZEDeU5o2o1Uzno3j0PA1LHQ
         sFnK/9JVW+KqJediCiyC1PJAkc/KMUmST+G1RuYz6vOd3brBWQ52ZPht7qBxVC7SsRyb
         r9FQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCL23ilYoOXaYZEMrRbRVCT6WArCoeUvKKPx6ttWBLkN4J6hHKWYsvNtwM+J1uoUw6i79oc88g+PQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z92oqmTwRH9mOjWKVpaYFHaeju7JtoGm5LINEZ9PHaF423SFMpc
	BjZTdUqgoBLL1hJ86AvbuIiENjUCyV1aAljD82nUjA2iDQZc6gGorSwP8AVBGow22+B53fOVlqh
	nMKL+YoLqmyRTDBAmmd9pqA==
X-Received: from eddo25.prod.google.com ([2002:a05:6402:5619:b0:6b4:20bc:f86])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:42cf:b0:6b4:6464:8a9 with SMTP id 4fb4d7f45d1cf-6b4d4677539mr8592397a12.18.1793723467260;
 Tue, 03 Nov 2026 08:31:07 -0800 (PST)
Date: Tue,  3 Nov 2026 16:31:01 +0000
In-Reply-To: <20261103163101.1696520-1-mclapinski@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103163101.1696520-1-mclapinski@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103163101.1696520-3-mclapinski@google.com>
Subject: [PATCH v2 2/2] PCI/DOE: Poll briefly for a response before sleeping
From: Michal Clapinski <mclapinski@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

doe_statemachine_work() and pci_doe_abort() wait for the mailbox by
sleeping PCI_DOE_POLL_INTERVAL (PCI_DOE_TIMEOUT / 128) between status
reads, which is 7 ms at HZ=1000 and 4 ms at HZ=250. Mailbox operations
are served from the device's local mailbox logic and complete much
faster: on NVIDIA B200 GPUs, an abort completes in ~70 us and a
discovery exchange in ~110 us, including the status reads polling for
them. Every DOE-capable endpoint pays the sleep once for the abort
issued during mailbox creation and once per supported feature during
enumeration.

Make pci_doe_wait(), which both paths use, back off exponentially:
start with a 1 us delay and double it on every poll until it reaches
PCI_DOE_POLL_INTERVAL, then fall back to the existing jiffies-based
wait.

Enumeration at boot runs before high resolution timers are enabled, so
any sleep lasts until the next tick, which at HZ=250 is no shorter than
PCI_DOE_POLL_INTERVAL. Until they are enabled, busy-wait instead of
sleeping for delays of up to 128 us. Operations that complete within
~255 us of accumulated delay, like the ones above, then finish without
sleeping, while slower ones waste at most that much CPU time before
sleeping anyway. Once high resolution timers are enabled, short sleeps
are accurate and no busy-wait beyond what fsleep() does is needed.

Time spent in pci_device_add() for a B200 GPU drops from 45.9 ms to
6.4 ms.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 drivers/pci/doe.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 6d258f751318..3f2f0b181f25 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -15,6 +15,7 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/hrtimer.h>
 #include <linux/jiffies.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
@@ -27,6 +28,8 @@
 /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
 #define PCI_DOE_TIMEOUT HZ
 #define PCI_DOE_POLL_INTERVAL	max(PCI_DOE_TIMEOUT / 128, 1)
+#define PCI_DOE_POLL_MIN_US	1
+#define PCI_DOE_POLL_SPIN_MAX_US	128
 
 #define PCI_DOE_FLAG_CANCEL	0
 #define PCI_DOE_FLAG_DEAD	1
@@ -244,11 +247,45 @@ void pci_doe_sysfs_init(struct pci_dev *pdev)
 }
 #endif
 
-static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
+/*
+ * Wait before the next poll of the DOE Status register.
+ *
+ * Mailbox operations are usually served from the device's local mailbox
+ * logic within a few hundred microseconds, far below the jiffies
+ * granularity of PCI_DOE_POLL_INTERVAL.  Start with a short delay and
+ * double it on every call, so that a response is noticed soon after it
+ * becomes available.
+ *
+ * Until high resolution timers are enabled, any sleep lasts until the next
+ * tick.  At boot, that is the case during PCI enumeration.  Busy-wait for
+ * delays of up to PCI_DOE_POLL_SPIN_MAX_US instead, so that typical
+ * operations complete without sleeping.  Slower operations waste at most
+ * that much CPU time before sleeping anyway.  Once the delay reaches
+ * PCI_DOE_POLL_INTERVAL, fall back to waiting on the wait queue.
+ *
+ * @delay_us must be initialized to PCI_DOE_POLL_MIN_US by the caller.
+ */
+static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned int *delay_us)
 {
+	if (test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags))
+		return -EIO;
+
+	if (*delay_us <= PCI_DOE_POLL_SPIN_MAX_US &&
+	    !hrtimer_highres_enabled()) {
+		udelay(*delay_us);
+		*delay_us *= 2;
+		return 0;
+	}
+
+	if (*delay_us < jiffies_to_usecs(PCI_DOE_POLL_INTERVAL)) {
+		fsleep(*delay_us);
+		*delay_us *= 2;
+		return 0;
+	}
+
 	if (wait_event_timeout(doe_mb->wq,
 			       test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
-			       timeout))
+			       PCI_DOE_POLL_INTERVAL))
 		return -EIO;
 	return 0;
 }
@@ -266,6 +303,7 @@ static int pci_doe_abort(struct pci_doe_mb *doe_mb)
 	struct pci_dev *pdev = doe_mb->pdev;
 	int offset = doe_mb->cap_offset;
 	unsigned long timeout_jiffies;
+	unsigned int delay_us = PCI_DOE_POLL_MIN_US;
 
 	pci_dbg(pdev, "[%x] Issuing Abort\n", offset);
 
@@ -276,7 +314,7 @@ static int pci_doe_abort(struct pci_doe_mb *doe_mb)
 		int rc;
 		u32 val;
 
-		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
+		rc = pci_doe_wait(doe_mb, &delay_us);
 		if (rc)
 			return rc;
 		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
@@ -486,6 +524,7 @@ static void doe_statemachine_work(struct work_struct *work)
 	struct pci_dev *pdev = doe_mb->pdev;
 	int offset = doe_mb->cap_offset;
 	unsigned long timeout_jiffies;
+	unsigned int delay_us = PCI_DOE_POLL_MIN_US;
 	u32 val;
 	int rc;
 
@@ -525,7 +564,7 @@ static void doe_statemachine_work(struct work_struct *work)
 			signal_task_abort(task, -EIO);
 			return;
 		}
-		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
+		rc = pci_doe_wait(doe_mb, &delay_us);
 		if (rc) {
 			signal_task_abort(task, rc);
 			return;
-- 
2.56.0.385.gac671c819a-goog

