Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFC433A9F3;
	Sun, 11 Oct 2026 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791736382; cv=none; b=i3FNULrxqaM7Gu7NpwD8rrN3/BhDhHxh+Fk2zr6gADjsMOPAfjDtpNupZey5oBPAKTLY+knehjAui5WfkCOxh0NaDhZk+cOrRsubkElOV2M60q4RE4BG7X+t/MkSjjFtOynLyYM/s+ZMoC30PW/K/tLEOiD2gf4o/reiKVATnzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791736382; c=relaxed/simple;
	bh=dUo2m5gk+GlS5pV3bYwmC3MVOWrIbj2LnwDi2wkGG8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYifb0EyCLBWyX3lS/jDW3uHMtKnTyT0+wcLn8TfeuQY4s7wP7QfOmII/SgAvJsZxJDaSv9xVp8jfhF4DwMZuZrTkxiUJ1uh79MpW+Yf8GSYfz1zMAJJ0lv8yC7JXZAiSMSE9yCVHSDtU3NPT2z5JS8gPJbLJiagh6SzG5MCVC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZiU/1/kf; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZiU/1/kf"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j2mNl6sQSz8t5N;
	Sun, 11 Oct 2026 18:32:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791736375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXkjnXUU+A8iMJWWfiXN7NNTGFPmHduyaxMXTJYmC1Q=;
	b=ZiU/1/kffm3NfmA+qzU/aawv1VislbMysnPADU2W8mxnrNPNwnDmMR7Ln4bZapDIGZvDuk
	xmEopPKOvE0qoYzLoeyr5ociVMOBF1T3a/6D7iN2eYtp8cqmEl8oESu4GGuv249oZ3cCwT
	cu0U1rHrIHg9cuW8icdX9Av9P/fOBkXWeOTYMzkx65aDx5CmwA+Qn1zL9Q7KgCo1FOz9QW
	WvGhntCzOkRn2t+k0oboS2koOkgJDDo8ACgxJd4FdzZSEVr1QZkBZRFMYU38lB7I28TN/M
	b22xSVCmMNSgzVBq8f1lD3D4TXwZsTZCLsjDV2tNbjRTZHCTgc3To3lFMTeWjA==
From: Alexander Gruhlke <gruhlke@mailbox.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Hui Wang <hui.wang@canonical.com>,
	Linux-Fan <info@masysma.net>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Alexander Gruhlke <gruhlke@mailbox.org>
Subject: [PATCH v2 1/2] PCI: Ignore Immediate Readiness on Samsung 990 PRO NVMe
Date: Sun, 11 Oct 2026 18:32:48 +0200
Message-ID: <20261011163249.18479-2-gruhlke@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261011163249.18479-1-gruhlke@mailbox.org>
References: <20261011163249.18479-1-gruhlke@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: h4uup36wf164mdpgbgmumet5of5wae55
X-MBO-RS-ID: ae8421e972b8714a85c

The Samsung 990 PRO [144d:a80c] advertises Immediate Readiness, so
pcie_flr() doesn't wait after FLR, but the drive returns ~0 for up to
7 ms.  Since commit 10baa9b4df40 ("PCI: Drop unnecessary retries when
restoring BARs"), the config restore after FLR is lost, which breaks
VFIO passthrough of the drive.  Firmware 8B2QJXD7 responds right after
FLR, but older firmware such as 1B2QJXD7 doesn't, and the firmware
version isn't visible here.

Ignore Immediate Readiness on this device, so pcie_flr() waits.

Fixes: 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs")
Link: https://bbs.archlinux.org/viewtopic.php?id=314833
Link: https://lore.kernel.org/r/20261010160529.27974-1-gruhlke@mailbox.org
Suggested-by: Lukas Wunner <lukas@wunner.de>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Alexander Gruhlke <gruhlke@mailbox.org>
---
 drivers/pci/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0500d5fd4f..e8597d1209 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5623,6 +5623,17 @@ static void quirk_no_flr_snet(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLIDRUN, 0x1000, quirk_no_flr_snet);
 
+/* Samsung 990 PRO advertises Immediate Readiness, but isn't ready after FLR */
+static void quirk_no_imm_ready(struct pci_dev *dev)
+{
+	if (!dev->imm_ready)
+		return;
+
+	pci_info(dev, "Ignoring incorrectly advertised Immediate Readiness support\n");
+	dev->imm_ready = 0;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80c, quirk_no_imm_ready);
+
 static void quirk_no_ext_tags(struct pci_dev *pdev)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
-- 
2.56.0

