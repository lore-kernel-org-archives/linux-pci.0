Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A33ACA5A
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771956115; cv=none; b=Kscdj0YDNBniqn51KYNhFwoCyh3lZNOBEd+xdJZG+737hysAKrknyRa17w9tkndct+4QKTjsqhVucP6FGESBOtFD98fidK/Zj1JF9MYrbY9y5L0B47zGDQ/tXD4nQ3Jujmr8Bx8jFLFsXxC7RX5H1mNIdVyV3J+vzAn9YVuVrM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771956115; c=relaxed/simple;
	bh=yDVL4gKAZypp4ppC8zaZWRGpGoKycdHdgbImNQyCUOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3/kA3SMhR6Qt9yz3HSSGLBScAP+1yNYI7c7VtqvwjOVae82D58NOLUnJF1jVmUkB+srNmMjqq7AdgcQJSIXraIQda9aCV7SM4PUzWc56j9v7dkDXKnDv2KRa6TH7A0oeHXfqhqBnxyFr5Fy1Wi/e1MkjAjYUldQAV+8DeKwIsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObnkEYUr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObnkEYUr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso47282615e9.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771956112; x=1772560912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkG3SLuYSM5Di7ZiQlKD8ev6UndxJoHprPyam9JLEWo=;
        b=ObnkEYUrtgUOMjpytkmS4qU2XlK8M9UN/5FIvkOczvgyTAYiwgT1w1Uu2jqXBJW8uE
         dgHccnWNeyzWZuuAM7SlQRYO61p5nmp7qnBu6FY8sIfcV9fhPoOpcWFQRNDzzUYSKhsw
         0mUcV5o4VYwgMj8ltOY+57U+N7yxoXeJtLJYwdOR/4RP/2szDDks5eeHDlNOMt+cre4n
         E0/i2O+h/jJafXu4DNUmP11dLE1CEqHRv/4Oz0581sT0oPY42SErbO7SQGjdaTgVVA/w
         fds/dub8nYAbU4gmfcXW83kh3pQvlVWP3JYjuNm/cWpq9zqFus56/8QgPvBCWvydQt3M
         GyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771956112; x=1772560912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wkG3SLuYSM5Di7ZiQlKD8ev6UndxJoHprPyam9JLEWo=;
        b=dW6VE0TLPgtNYKfP5cfczS/9g58XVJ2Yh8JjfdixAxvoN4TWP9kYWTfVrFv1yeiYiK
         n+xlvCThmBehuTl8URE4F8QTO5pA/JSr1NhVprzh3BHCT6yOPxp5hSYFPFXy3t2AC4lr
         dhpMU5Li0IVgElitZxhSQAW9YQdGxVyDRQE1uhTbaVRLhbLGxTto1a6yVppGryDfmJ7A
         F2JhXddc9qwj19INYaqAKYn3u38TGgCk0+D0wiS0d5pJtrtxF84uYzewMBD3saqX/gFH
         gbHRuSm8OUgKJYgeHSK+2daa0642p8926ZEKBOtNI0E9xUzl3jHdJQVhfZ8g1W36CrCA
         fxoA==
X-Forwarded-Encrypted: i=1; AJvYcCX185edw6ceNVOqXLYZ4HtKdlADTDEdbvnL5/lMCUmyaRtH8Pm1VzejJH8sn27SQ9QxrcBLgUHgfws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQvwp13vRYIUmvSPUpAoe2UzoJ+2u2LjgJ9bSE/ijNRuzujRP
	7KgQnsN25BC85UcfjlDPGlh1sMhhaXRxSWlUK31mD0Csu12ZghkrrU/H
X-Gm-Gg: AZuq6aJiKlRUM6XDxDXl1JJRfxuJ0Z9kvxO0Ntb2Sozzphc2DQ09p0b1L8Xc0VVM6JA
	Wt9JextpZebx8nA1ZzeWm0ztFp4/v8Wl/rRd7743Lln2XDC1+LnrpoyIl68QKXCEGWpd1+pHpPt
	qsR8EMP/toEfY72knCiLLBw9FCPUEYTxfntWXS8+Kcg4nE/y07ZaJNUm5EAn3gelyD/E5bXLNzt
	j5msIVAVAjU7IV3sLcZFvTF/+RI2FJ2VhRfoasqlcv9fbJ5z4HKO2yv2gFEYqIXSOfa+P1M+xez
	DDgcBzvCEBreW2UrQ5TS2IZMRFcytpemJiyKhwfWay+yCZtKpYT22LeROhDT6bdnEgzo6l82SVD
	q8M+ADdWY+krirGziz3pIKm3G5ujCLMDpAbcxzzerogGHi11G6XFVl3DIYNzp2kqAP+hGVAok3w
	b8whfiYyIckQ/lr1MbZX3+PjSZfl1rWvFxnbw3DrN/wQWbftcxfieC
X-Received: by 2002:a05:600c:3508:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-483a95bf3d0mr244077395e9.15.1771956112226;
        Tue, 24 Feb 2026 10:01:52 -0800 (PST)
Received: from LAPTOP-B9QI2C1K.localdomain ([31.205.125.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6854c7sm42260965e9.0.2026.02.24.10.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:01:51 -0800 (PST)
From: Majed Alkhaleefah <majedalkhaleefah@gmail.com>
To: bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	scott@spiteful.org,
	Majed Alkhaleefah <majedalkhaleefah@gmail.com>
Subject: [PATCH v2] PCI: hotplug: Change return type of pci_hp_add_bridge() to void
Date: Tue, 24 Feb 2026 18:00:37 +0000
Message-ID: <20260224180036.361502-2-majedalkhaleefah@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223023645.344137-2-majedalkhaleefah@gmail.com>
References: <20260223023645.344137-2-majedalkhaleefah@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function pci_hp_add_bridge() currently returns an int error code.
However, none of its callers actually check or store the return value,
neither do they need to take any special action in the event of a
failure.

The execution path of pci_hp_add_bridge() already contains relevant
error logging. Therefore, adding additional logging/error checking is
redundant.

Make pci_hp_add_bridge() a void function.

Compile-tested only.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Majed Alkhaleefah <majedalkhaleefah@gmail.com>
---
Thank you for the review. Looking at the path of
pci_hp_add_bridge(), adding additional error checking is indeed
redundant, and the function could just be made to return void.

Changes in v2:
- Drop the v1 approach of checking the return value of
  pci_hp_add_bridge() in cpci_configure_slot()
- Remove relevant TODO items
- Make pci_hp_add_bridge() a void function

 drivers/pci/hotplug/TODO | 8 --------
 drivers/pci/pci.h        | 2 +-
 drivers/pci/probe.c      | 9 ++-------
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
index 7397374af171..2a4f44f9b629 100644
--- a/drivers/pci/hotplug/TODO
+++ b/drivers/pci/hotplug/TODO
@@ -1,9 +1,5 @@
 Contributions are solicited in particular to remedy the following issues:
 
-cpcihp:
-
-* Returned code from pci_hp_add_bridge() is not checked.
-
 cpqphp:
 
 * The driver spawns a kthread cpqhp_event_thread() which is woken by the
@@ -14,8 +10,6 @@ cpqphp:
 * A large portion of cpqphp_ctrl.c and cpqphp_pci.c concerns resource
   management.  Doesn't this duplicate functionality in the core?
 
-* Returned code from pci_hp_add_bridge() is not checked.
-
 ibmphp:
 
 * Implementations of hotplug_slot_ops callbacks such as get_adapter_present()
@@ -43,8 +37,6 @@ ibmphp:
 * A large portion of ibmphp_res.c and ibmphp_pci.c concerns resource
   management.  Doesn't this duplicate functionality in the core?
 
-* Returned code from pci_hp_add_bridge() is not checked.
-
 shpchp:
 
 * The hardirq handler shpc_isr() queues events on a workqueue.  It can be
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13d998fbacce..ee35f5582688 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -353,7 +353,7 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 #endif
 
 /* Functions for PCI Hotplug drivers to use */
-int pci_hp_add_bridge(struct pci_dev *dev);
+void pci_hp_add_bridge(struct pci_dev *dev);
 bool pci_hp_spurious_link_change(struct pci_dev *pdev);
 
 #if defined(CONFIG_SYSFS) && defined(HAVE_PCI_LEGACY)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd79..b4270e44a769 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3545,7 +3545,7 @@ void __init pci_sort_breadthfirst(void)
 	bus_sort_breadthfirst(&pci_bus_type, &pci_sort_bf_cmp);
 }
 
-int pci_hp_add_bridge(struct pci_dev *dev)
+void pci_hp_add_bridge(struct pci_dev *dev)
 {
 	struct pci_bus *parent = dev->bus;
 	int busnr, start = parent->busn_res.start;
@@ -3558,7 +3558,7 @@ int pci_hp_add_bridge(struct pci_dev *dev)
 	}
 	if (busnr-- > end) {
 		pci_err(dev, "No bus number available for hot-added bridge\n");
-		return -1;
+		return;
 	}
 
 	/* Scan bridges that are already configured */
@@ -3572,10 +3572,5 @@ int pci_hp_add_bridge(struct pci_dev *dev)
 
 	/* Scan bridges that need to be reconfigured */
 	pci_scan_bridge_extend(parent, dev, busnr, available_buses, 1);
-
-	if (!dev->subordinate)
-		return -1;
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_hp_add_bridge);
-- 
2.43.0

