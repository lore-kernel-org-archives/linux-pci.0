Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792970306;
	b=D2aV3rJxAtEminEzgM/WUT/uvOOg50Rn72jQKWR8TZ2Q9tgGZx5Oq6IZTE+bgiTeVXbB
	 Nrn/GhzFp8J6M4ZRyiQ9nSw+5eJjFo8lUZbq/64RQP7FE9t7wPnLAy45a0b8sGbGjXgfp
	 ULJibayadIIZf3S4An0Y/RjWX7aNHMacqDHC4wiOdc1FboZ62uMlfR6DnAsC6hBqqI+Dy
	 jpYSjvdPjEz1ZksthHPuuYn8tF49QjGYaMQdVmi/ir0Uu70LOxU5oTCG/qdU478RxvCG1
	 FoxXAt20SBzrO5flyBaijpb4/bk2clo0Hr+dnVoRmMevpgoh4+a8E0w2purI4xhb8Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792970306;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ehMGySnrqaN0YWzDWec38aBOi7Rp4XTn6bNu22+y/ms=;
	b=O610HdO46vzOYj8BWuUvU8HE2PNeo3/Be3+wuO6Gxaieh+/Hy54zDVnF9cpuOqvCqkXq
	 XhvuxmNe3X7nSB+6pm3v25DqbnoRsxLLAjsAKiIIq7CFBKm2G0W7P62a0Ftwc8t481qGr
	 MoFVgvwdwjXtI5E7K5XoO3BUQrRxeTULLGCcYY687EB+X6dTrq/JtyqlhkS0amd1A6bSp
	 FCgSLi7x9BVoj+h/K7YNBbawNZHzmPyf9CPDNmbmjGnXrtT1Vl960qA1tD4Xn/GywbFs0
	 +UOPgH0cY4CZUyQsqZzAUUw9QzUDa32BvyZqlGkOM4C6wvvHl1O3PPXldRzV4GUAxYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AiVfIe45;
	arc=none smtp.remote-ip=91.218.175.227
Received: from mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF3C606A321
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 23:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEF3C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AiVfIe45
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=chKyVn8X74QzrmO8tV7hinMLk5vYZWfhs3dWy8GlRfo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792970302; v=1; x=1793575102;
 b=AiVfIe455Tajto/YTxkJMROq/5ftZS9pEw4Qqz5UzDQkPYouRyeO+T61IzwiNUxeust9tjET
 z2jUnZED1/78sDCNdGRlbA+7qQ9dOBxRdKdnWkyorYvPapCBkTNBf+50F3GUa/SdlpZIrc+uvzZ
 KWGC7Rwf6dFmR1mAT/b4cly0=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 28900203f15348be;
	Sun, 25 Oct 2026 23:18:22 +0000
X-Mizu-Trace-ID: 28900203f15348be
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	linux-wireless@vger.kernel.org,
	miriam.rachel.korenblit@intel.com,
	emmanuel.grumbach@intel.com,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH 1/1] PCI: Disable D3cold for Killer BE200-family WiFi on MSI Claw A1M
Date: Sun, 25 Oct 2026 23:18:13 +0000
Message-ID: <20261025231813.128649-2-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025231813.128649-1-denis.benato@linux.dev>
References: <20261025231813.128649-1-denis.benato@linux.dev>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During s2idle the platform removes power from the WiFi slot (D3cold).
The Killer BE1750 (Intel BE200, 8086:272b) installed in the MSI Claw A1M
fails to resume from that state: the PCIe link does not retrain
("pcieport 0000:00:1c.0: Data Link Layer Link Active not set in
100 msec") and every device register reads back as 0xffffffff, so the
card disappears from the bus and the machine must be power-cycled.

Keeping the device in D3hot with the link in L1.2 during system sleep
makes suspend and resume work reliably: the package still reaches >99%
S0ix residency and the card survives every cycle (verified over multiple
suspend/resume tests with an RTC-timed wake).

Disable D3cold for the BE200-family device on this board. This mirrors
the udev-level workaround distributions already ship for the AX200/AX210
(8086:2725), which suffers from the same class of problem, and moves it
into the kernel where it belongs.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220223
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/pci/quirks.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7572b358b50f..60156e6c3e49 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6593,3 +6593,24 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * MSI Claw A1M: during s2idle the platform removes power from the WiFi slot
+ * (D3cold). The Killer BE1750 (Intel BE200, 8086:272b) fails to resume from
+ * that state: the PCIe link does not retrain ("Data Link Layer Link Active
+ * not set in 100 msec") and every device register reads back as 0xffffffff,
+ * so the card disappears from the bus and the machine must be power-cycled.
+ *
+ * Keeping the device in D3hot with the link in L1.2 during system sleep makes
+ * suspend and resume work reliably: the package still reaches >99% S0ix
+ * residency and the card survives.
+ */
+static void quirk_msi_claw_be200_d3cold(struct pci_dev *pdev)
+{
+	if (!dmi_match(DMI_BOARD_NAME, "MS-1T41"))
+		return;
+
+	pci_d3cold_disable(pdev);
+	pci_info(pdev, "disabling D3cold: slot power removal during s2idle prevents resume on this system");
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x272b, quirk_msi_claw_be200_d3cold);
-- 
2.55.0

