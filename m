Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35224378D63
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 03:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595973; cv=none; b=fPaypnjKW3GSv2/mFd39TLReZ/1lqqEUht0F0Um8qxBdrjRjKuibCtK86HQG+gVU824bwPSugbC1zzrBAf2JgVTPzmb5ef7LH1gePs/pyNAphBZTNda9Aur745Db38mXmqnfE4ofvfydFnZ7IScgudloFwsccCrNZeNyfls1/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595973; c=relaxed/simple;
	bh=h+mTLN6n6mBPr7PqYqmQSCCs2jhafXeB0NRdyOd/a60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDd292uTkk1cs6XSlEPh08/9O8pTRfb2VLHPaR4FBzZTZUrDk0J+gyJi/E4LeO9cAX/qNEdHoFjNsnLvgTn+56/Ph+FdpOG34qxSnqgklV1h8yJ2s/7O9jcg6eIHSwkhG+/jtXy88o73kANzdz1ZVq2S1HbpmaY0eGGuglIu+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBbNteYp; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBbNteYp"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3598cab697eso1714270a91.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2026 19:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772595971; x=1773200771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNQTswAIlkxtACM2d1rPkaE1OkOxjlH5iieRYDqA/Dk=;
        b=OBbNteYpY1DBBXckQkQx4cC1VHUezD5E0OaN6uyerrRWL0XhbOo1es6evUjMW1xUgl
         teAFFzf3R26V7LxgoAD4PPEpbRL/p24Xhad1aTJr2C7fFjJwWwPUYognXQcTxViky7SA
         QxgOQiFlJYTOiWPfJoLbrfWZh4AyVkckAcvY3HwCXFr0JRtDta+CwAkofpaAlODWf7cu
         aWnOMMEoMO5r1b+KR1LqSwG1VhfeUHVcKILR8abAp5N7fGkfM0/1TFRXL3RegczxRN7H
         jF8Ce+3JVf3fVJCDGGDGHVBhgb5rQQ9YS/GyxwWXOzD+FHtlM02FVm6RDOBYKzvZbEpF
         2d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772595971; x=1773200771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNQTswAIlkxtACM2d1rPkaE1OkOxjlH5iieRYDqA/Dk=;
        b=rW3SH6Aw/fHIPZ44N97Vy8kMHIjeKs//mw3z3q09sV6nV5IMF5MWdY45PtxXm6ieyG
         VnD+gBkAkVlbambIKTYWMuIvhUvyF2LJ5iHwQWFen4FLxrCuPZeNsghQBsyxQb5GN7cl
         RDmKQvu+jr5GECTIqHxt+BJu47A0J8Wfsz6tK8cPTfl8pGo76XhZRRYKzrMeIjrItfEG
         KO0MlUrKefrPKbRVL85+Ss7OTWt1c0GXgiRiLwphUMxiZhuT++OR0ag3iOy+OrTzBka+
         Q/3WF+z9hbmaMRdYtmHWMccN2svwuoAQidE8ejohnUocWmAjB/XqVWAZD0/Kkn6oo5qw
         apMQ==
X-Gm-Message-State: AOJu0YzmAgk+FqwZvMl6SVSvzp0Un7a0H7WDqu3VbysmHHJ2j3lpLObW
	BWO3kKYrWPvb0IJLeoNjq+HReHLXKMcFNPFS9QqgJoGOhS/J6t+e5CE4
X-Gm-Gg: ATEYQzwAOUugxnY4Q32uSwgaW3Kwa2E9KFlNwYWQ9XJbRxQ1T7B1gNwDJjeo6rp8RPk
	8CBSBbQJhXlQlUUYJ3oB77Jby9X7zEN1GbJ9jhaZ1WpXamb25+uQzKJDSGFWN61Sr4EECpzKtpI
	pTorRD7Bu19edfbZsRRMjAZAibQzvLNeg2swRZb7mZYerL82UUYHS2AglTzLN/FwWFu6KZklhKp
	WgJ+LjqFP6PzIDL4/FglAHocih7hwhVLcT08sWEOU45tN1DSHOTZN12kSyJ2GVf9eMcFS59PBlA
	5HZeaTXDRox/w6OA0uEHBCXmsNExAQ2h5BXGp4pkF8PAct2dJiRgLudzkwaxqtwQOMnp29UBhS0
	mYmuVygx0Jz7l96NGngID39GBXFKKPS82NFyeWkVQ0jwUFqkuBia8msGL8iRraOIALBxtossXPG
	emDOa4+XVWBeQ4MGGO/voaycO9jPDbHCG9ctuxXjxf8z42RPaymbtWUHwGFh/RZUo=
X-Received: by 2002:a17:90b:4e88:b0:359:8c5a:a564 with SMTP id 98e67ed59e1d1-359a6d8efbfmr685242a91.13.1772595971456;
        Tue, 03 Mar 2026 19:46:11 -0800 (PST)
Received: from ZC-202510311500 ([123.139.95.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359a8f3c1absm5742a91.4.2026.03.03.19.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 19:46:11 -0800 (PST)
From: hechushiguitu666@gmail.com
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"haoyu.lu" <hechushiguitu666@gmail.com>
Subject: [PATCH v2] PCI: probe: Use helper macros and constants
Date: Wed,  4 Mar 2026 11:46:04 +0800
Message-ID: <20260304034604.1598-1-hechushiguitu666@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "haoyu.lu" <hechushiguitu666@gmail.com>

Replace direct resource array access with the pci_resource_n() helper
macro and use MSEC_PER_SEC instead of the bare number 1000.

Changes in v2:
- Use pci_resource_n() for resource array access (Bjorn)
- Use MSEC_PER_SEC (Bjorn)

Signed-off-by: haoyu.lu <hechushiguitu666@gmail.com>
---
 drivers/pci/probe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd79..d5b27d03355c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -119,7 +119,7 @@ static u64 pci_size(u64 base, u64 maxbase, u64 mask)
 	 * Get the lowest of them to find the decode size, and from that
 	 * the extent.
 	 */
-	size = size & ~(size-1);
+	size = size & ~(size - 1);
 
 	/*
 	 * base == maxbase can be valid only if the BAR has already been
@@ -594,7 +594,7 @@ void pci_read_bridge_bases(struct pci_bus *child)
 
 	pci_bus_remove_resources(child);
 	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
-		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
+		child->resource[i] = pci_resource_n(dev, PCI_BRIDGE_RESOURCES + i);
 
 	pci_read_bridge_io(child->self,
 			   child->resource[PCI_BUS_BRIDGE_IO_WINDOW], false);
@@ -2600,7 +2600,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	struct pci_dev *dev;
 	u32 l;
 
-	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
+	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60 * MSEC_PER_SEC))
 		return NULL;
 
 	dev = pci_alloc_dev(bus);
-- 
2.53.0.windows.1

