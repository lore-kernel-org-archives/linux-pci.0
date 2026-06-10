Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6900198E91;
	Wed, 10 Jun 2026 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059681; cv=none; b=m7/2bHx+t/3128Uzvwre7Nbbv9e/31flJgnkYTbQcsyiya7y4Hvo2lq8s55a+x7u9MgWSHshqYp6iQf8qkiY63WAjHZf4VEuGb1JPA20NzFesBCGcusuT5u2/6IiuC5h1P6THeJ1q8FmVTZyvaoyZajC/Dkz0fAOjDS365LawHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059681; c=relaxed/simple;
	bh=olaUuKXpiCh1TbSdWWMNu1voIE5JY3jpkUbSSeYnCBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsIfFMDa/fJKNqgRKzhTgMJrYklbJambhg4V4i3DJXrDxfg6nC8dEe1yHZMZ0eV15JbB3VdGfE9KpHTAMvqlWx8h0SG2TFn1O0IWUThcOtrrh4XOoN6Ag11KT28o/9736OMXhfgoEeYeNc7LJtqUAxaXypgETlh9eDeTtvKIGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=POofzIKH; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="POofzIKH"
Received: from localhost.localdomain (unknown [10.101.193.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 913EA41DEF;
	Wed, 10 Jun 2026 02:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781059671;
	bh=wDYW66smIT7S/HJGtqBSas/PTlj/KzWMicRvgaE9H0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=POofzIKH+VSCMeBKKXNCNPUT7GR0+c6rYIVn1BmPKcv09Pw9C6p6y+awQ+0tFvarU
	 8ef7SGqd3CpNF54YsMAencf/XHropJAnEP7vhjIZj53ipNzbykS+TAFjMm1o2l18aV
	 +QBPlFUrLySXcwFAd+g55K8W34zw7HvvvhZwMW0yRhkUNtPJwy0j5ksjT0JviWQSBK
	 RrjNA5uVD9WqdKRWGCjvU1As1BXw3iftcndlmZy43iTp4sXfXeJUtpwamaz1st7VII
	 UWyvcsS6fOHKBU3VqFH+Yu2E9XB50ATMCLb7DxVeW6JdfKtvag2gfTMNIMKMymeLXL
	 qlGgJ7hzT+N7ApMaCd4GC7zS9yJ5SBPE9GLww3KGSiupXKAcQfi+19hMXHd8Zk4Lwl
	 vi/MXqPyw1rIYWerunxKIDFxyIRyE9aFQpxkpHacFW5fIk6tXBJwjpjZ7zMIitCeNs
	 sOSLSMwyIGIfNmrkLCw78shc8iiqbHZf9VBUVfT9POnkzDIIQvM1ByGweO3qSwokaN
	 D3DInkVfDVr81w8lRNhw8tcVm7g5PEw8vDaaJJ7xbOvhlMFZi+rjav9ACMwec4MrLi
	 w5cBwo52rmZxVWAoDuXSw3xzSJKjsqR7X3d7axyf1hG3Z6uDIGsv2vgi9YoGgfwfzJ
	 auOvVCZAWYA8Cbv125d15Yq0=
From: Max Lee <max.lee@canonical.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acelan.kao@canonical.com,
	Max Lee <max.lee@canonical.com>
Subject: [PATCH v2] PCI: Mask Replay Timer Timeout for Realtek RTS525A
Date: Wed, 10 Jun 2026 10:47:23 +0800
Message-ID: <20260610024723.188514-1-max.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528032347.644365-1-max.lee@canonical.com>
References: <20260528032347.644365-1-max.lee@canonical.com>
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
within 11 seconds of boot, overwhelming the kernel error handler and
blocking shutdown/reboot.

The root cause is a transient link training instability inherent to this
device -- even on BIOS versions that suppress reporting, the error
status register (CESta) shows Timeout+ set.

Unlike the GL9750/GL9755 fixup, which only masks the parent root port,
the RTS525A also needs its endpoint Correctable Error Mask bit 12
(PCI_ERR_COR_REP_TIMER) masked when the endpoint exposes AER, so it does
not send ERR_COR messages upstream. Also mask the parent root port to
cover root-port reporting of link errors caused by the endpoint.

Signed-off-by: Max Lee <max.lee@canonical.com>
---
Changes in v2:
  - Mask the parent root port even when the endpoint lacks AER capability.
  - Remove the early return before parent root port masking.

 drivers/pci/quirks.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc0..6597536a4c70 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6380,4 +6380,26 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
+
+static void pci_mask_replay_timer_timeout_on_endpoint(struct pci_dev *pdev)
+{
+	u32 val;
+
+	if (pdev->aer_cap) {
+		pci_info(pdev, "mask Replay Timer Timeout on endpoint due to hardware defect\n");
+
+		pci_read_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_MASK, &val);
+		val |= PCI_ERR_COR_REP_TIMER;
+		pci_write_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_MASK, val);
+	}
+
+	/*
+	 * Also mask the parent root port. Do this even if the endpoint lacks
+	 * AER capability because the root port may still report link errors
+	 * caused by the endpoint.
+	 */
+	pci_mask_replay_timer_timeout(pdev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x525a,
+			pci_mask_replay_timer_timeout_on_endpoint);
 #endif
-- 
2.43.0

