Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7F9390600;
	Sun, 11 Oct 2026 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791745340; cv=none; b=NyegxG0Li+gfqnlJKeWTfijTY8Rl+pXwVj/Go0/4LxsX071TLfgd5TyjQoK+6+kMuc17gMnaJyx8zlg0isFui673jO6ZMoYSZQc6flmHRAEWm3vhCGM1hxBSpVdG1Hlu9uwaZHToanBbUSx8NmF9M8QA5+SuAuKxHkRCFsfi6ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791745340; c=relaxed/simple;
	bh=GXMxAQ0oomRQDquDMHM5zq4YEEzq94Rnx+YqZoolgEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8rsfLENcob0i0eKgVlR1Rl10FZZBeoyX8mBDh5KmvHpDOZmUcRig9KmIpsgg/093jAK52EzCxMcCzH9Epi6c68s4Z39DnUazrgMW4xXTkWZfn/SMSXRUOQdnlzaaHUqU6XnjUu0TBm3qZIE9nApCoaQi4TwJSKPcdEaUWvHuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qLvfDEKO; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qLvfDEKO"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j2qhy0FWfzMlPN;
	Sun, 11 Oct 2026 21:02:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791745330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/Hn6xj3FRPjQ3cFYoHb+hNfCUOuBV5bvsCl69uhV4c=;
	b=qLvfDEKOK+AHaTfh3/jiDOhW9Q2Z2BZ/ZZcBqcfGgoolSfHRCCOpDTxnLJH7nImAxJhxuo
	ZWVhY77QB0LanZArB5y0sIdJlkufa6G1IaVsZeL9g+T1io/pklT4OeS9Uzozr6ioTO3rYe
	4WyUATOMrdzoxl8EsA3Do1A2Tzx2h0j2xlo08Yf58UlFTvYoVXtpGamQdsUxShJ6FFiXWx
	KZBPi/cosAj7kgPHZU+nmG5Fpolo/v5nm1JQY6senNXcRvvdxfSyAwp+bSOknMLtdE4zG7
	u+o+jVStYU1vg4jecKL84Vq9l6IvHosX1WtO9MmNmrIBnPFLs7f6oJBTdMXvRw==
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
Subject: [PATCH v3 1/2] PCI: Ignore Immediate Readiness on Samsung 990 PRO NVMe
Date: Sun, 11 Oct 2026 21:01:44 +0200
Message-ID: <20261011190145.23621-2-gruhlke@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261011190145.23621-1-gruhlke@mailbox.org>
References: <20261011190145.23621-1-gruhlke@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: a49y3m7m95iqyjub9wjbwwdcb3jb1k3p
X-MBO-RS-ID: 63c636e6d683b28b9df

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
Reviewed-by: Lukas Wunner <lukas@wunner.de>
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

