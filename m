Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0513ACF00
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805342; cv=none; b=rmdj8PEibMSoimRQZLkoM7NQWsCGeK43qR7MCehIgVJ2xK6SG/VY/qmf8J4on2vidhSHSbXLY7soWYszRqR54PR1RCicA1DhjUh2w2feE6xCxkaDDTlvdGJWE73UdAm5pJmmj0TsmfKsPBjOul2o+CWV61nAB9PZe5TdZkbRIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805342; c=relaxed/simple;
	bh=VKI97pXXbDOPAdJtvmTPkLbLkX30Qa+ghl895QoxYZc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QS3phI/TXqCYTUe2yPi4zXRuRI96SWHZ2xrUDMB4sRlOY3wYFKXhH52DwT0gD0f7+EV8xZOpFxBlUDoCwCkmDNdSdj2V5WNefLO+5l+IhufgOP45n37Bvk43TaviJIIaGODIBICZ35PMfbAS3IBu0g93qRR5pmDJI2ZmG0+7bcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gvW+AzwV; arc=none smtp.client-ip=209.85.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gvW+AzwV"
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b1b5ea276bso1269610a12.2
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 04:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791805339; x=1792410139; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g+XeNA9wYZ+w0/rnkp+EWuJy/8oZE7v6bL2HMqqjnD8=;
        b=gvW+AzwVyFZ8wnvJ5TfFai6m9hi4XTNoXxWNffvrh6/hTtXNg6SSYFwA14VWb3mrL9
         AhOA4dwHBOOJx08UqqDG0yc8pmaTynzl9rul3DpUjmc+ozJ/shymOHoTA1zawyW3fqyD
         e1EPbeRXbsoYWhwj3WuDRn6wqxbqz7wpAE2kPM6mFKrGoIDnzPnQgSEOD1XNVvs70o1C
         MLa/95c1b5MB2kNede+UxNGGXrx+FHsyTOTcT30vk/d2C4TJIaGQ/gy2KD2yDifnjqoA
         9UlxVyPXmgdJDr+SXyyp6epZyGhzgJduM2FEK5ZBAFsu6sypnVr98D8G6x1L7ELih+19
         m4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791805339; x=1792410139;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g+XeNA9wYZ+w0/rnkp+EWuJy/8oZE7v6bL2HMqqjnD8=;
        b=t0DT+Pon9J3/8mx4hgHNubcyeyHgVESXHnvD1W5eXOiNG/P5xb9JTEi1uhoEVG/pNx
         64IoVWy6HErr2KX9TOgFy0j0iW023WkgAVuKF1x9l+daMc12YZldaA/5kwqN7L3Kq99x
         sEUeXZLrPEtMuHukJW+7bRmrap02obqaUtc1CtigVooEwPYk3fJ2/Kb8KPPOWLxpwGjD
         6Tiyu918X5/kho0rBjOhJNHohvB/feCZqWpo1rjb+eWbGIJ6n4QkCuIZytynjQwIWeIt
         dv3kEyQffkwfmKf7FWb5cedbW5gFYZxZNWtO66pwELXuShsJHW6qTCPYzCgDqzpuWUyX
         kn8w==
X-Forwarded-Encrypted: i=1; AKwUvBz8RXyhPiIKt9fjLUFeI8fVyPP3NNawhSZx41rj2fQ/x0OphTReVEIwYTn/g+1UrJ+Lw79RNmorxZ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL51Cgzu2DKKF11+hW+5QDz8TuOF3++yPNb/zRAWkBBlqNgdygW
	eYvEGyb07LZBbF8SOz2wsWu+yBD/tUk34mt+O+s5+bM3BSF7C77pFnLORIfJXbfNz51crreXAQl
	KERAFqFP8HWCmewjlJMRrRw==
X-Received: from edl6-n2.prod.google.com ([2002:a05:6402:4246:20b0:6aa:e587:e1c1])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4341:b0:6a7:ee56:814b with SMTP id 4fb4d7f45d1cf-6b17c27a61bmr7787882a12.25.1791805338876;
 Mon, 12 Oct 2026 04:42:18 -0700 (PDT)
Date: Mon, 12 Oct 2026 13:42:13 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012114213.1757207-1-mclapinski@google.com>
Subject: [PATCH RESEND] PCI/DOE: Poll briefly for a response before sleeping
From: Michal Clapinski <mclapinski@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Michal Clapinski <mclapinski@google.com>
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
I was asked if I can do this with interrupts instead. I don't see a way
to do that during device enumeration that won't collide with the
drivers.
---
 drivers/pci/doe.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 6b5d9ba8e969..5e93d78a1a97 100644
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
@@ -487,7 +490,7 @@ static void doe_statemachine_work(struct work_struct *work)
 	int offset = doe_mb->cap_offset;
 	unsigned long timeout_jiffies;
 	u32 val;
-	int rc;
+	int rc, tries = 0;
 
 	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
 		signal_task_complete(task, -EIO);
@@ -525,10 +528,25 @@ static void doe_statemachine_work(struct work_struct *work)
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
2.56.0.385.gd3acb90ef8-goog

