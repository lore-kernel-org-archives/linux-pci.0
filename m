Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A93A30AD15;
	Thu, 28 May 2026 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779939006; cv=none; b=IUFYarTpcMwwKPpPICwA1jK3f1R4OXlXFhxbspn+1WSGqWpUhozd/EGYi9eUuakRj/sliZuf2Vz+f+0Yaoe6hedDl4KD9APrFqqzk6j7gGLjFMGjgV33zlJDMw81kBrJZfknegFAxjTE1/eXSQTKSjo/xiRpWKwi4t8GcEkqHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779939006; c=relaxed/simple;
	bh=UcfvJwpMxNQoHYDIJKCPXcxcMS04xsdCX2xRVZHpQLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4m6Kzcg8TK2IgflfFChSJ7UsAm1iAR1QKPCISlNUV4LfGG4pufLvfQspPWg1yV7R+KEjvW5P40CD9+c4inUuaL0kVEyeq3F9Qfsc4VLi1i1kbkIK9h2O+cX9yZjfxE5g7w9SrllNtGUmONlQaaUEZVxb5G/NHKOz+1SviaN1r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=f2V9wwtT; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="f2V9wwtT"
Received: from localhost.localdomain (unknown [10.101.193.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D0A783FB50;
	Thu, 28 May 2026 03:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1779938669;
	bh=lYSQ0BTYVGmf/Hu1BSADR2oxIBwOTwCgiaAujfeQhPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=f2V9wwtT6aT+2iG3y2D9NlG3kDInXxyavIfJWYp3NshQTgqizOFqYv2zkx/qXNH8g
	 t5KLM96uS0aJDRnBdDk13gaZQMimteJ/QxKL5V+Iq/M1Rs33uVKsSR6v90C6ZYYekv
	 oOu35GrqZWpWzxYuNaAW94v41YFM61DCGGMcFxEm363mNBC2LGjByncrwgmbMYV8gk
	 AKO/9pIncoAL0PrJreovMsM1I9oC4oi+HjAX429yljSDmtzYdoOb1UE71QJwhd+oAV
	 dsYQ35++Bt/hlJjMzW1gDEMD0uZm/9Xh/Q0cAif5Ph0Soqtd2QldDmtt7w59AbwHGz
	 DQ4UpGKb4lS5DDo8NuAoFtqBg9rXfO07QK8nuZOoQ4JH6n+4mZF59I8dEhxNt3jKwP
	 UWMFDxSRESj76IxafVg/HkoWurIpPx1E1XtJqwYGYcvPNRj5OuEXOjAGrkzvpzaRtg
	 iIN1c7W06/diJxSRE3h+LpkcKgr+FdMfP2kIx8U2L2fab+l4ZhOrKTtky70rPMmI7P
	 DEwjMlGx1K1VbQtJ6EEMWL2uLzPTnwucbezviaIjPlLAur25dVruAd5NTtWHFtd8eU
	 edipV9AL5/2PyWkQwFH+QxxDFPUy74Kt+Y+iHC0kg+O6dHpiqNBODuLpYMguMRIypI
	 zfwioAx55iHVBHH/FgjzfkKs=
From: Max Lee <max.lee@canonical.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acelan.kao@canonical.com,
	Max Lee <max.lee@canonical.com>
Subject: [PATCH] PCI: Mask Replay Timer Timeout for Realtek RTS525A
Date: Thu, 28 May 2026 11:23:47 +0800
Message-ID: <20260528032347.644365-1-max.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Realtek RTS525A PCI-Express SD card reader (10ec:525a) generates
excessive Correctable Error (Replay Timer Timeout) AER events during
PCIe link initialization. On systems where firmware enables AER
reporting (CERptEn+), this causes an AER storm of ~240K error events
within 11 seconds of boot, overwhelming the kernel's error handler and
blocking shutdown/reboot.

The root cause is a transient link training instability inherent to this
device -- even on BIOS versions that suppress reporting, the error
status register (CESta) shows Timeout+ set.

Unlike the GL9750/GL9755 fixup (which only masks the parent root port),
the RTS525A additionally requires masking the endpoint's own Correctable
Error Mask register bit 12 (PCI_ERR_COR_REP_TIMER) to prevent it from
sending ERR_COR messages upstream. Call pci_mask_replay_timer_timeout()
to mask the parent root port as well.

Signed-off-by: Max Lee <max.lee@canonical.com>
---
 drivers/pci/quirks.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc0..072d1456daad 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6380,4 +6380,23 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
+
+static void pci_mask_replay_timer_timeout_on_endpoint(struct pci_dev *pdev)
+{
+	u32 val;
+
+	if (!pdev->aer_cap)
+		return;
+
+	pci_info(pdev, "mask Replay Timer Timeout on endpoint due to hardware defect\n");
+
+	pci_read_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_MASK, &val);
+	val |= PCI_ERR_COR_REP_TIMER;
+	pci_write_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_MASK, val);
+
+	/* Also mask the parent root port */
+	pci_mask_replay_timer_timeout(pdev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x525a,
+			 pci_mask_replay_timer_timeout_on_endpoint);
 #endif
-- 
2.43.0

