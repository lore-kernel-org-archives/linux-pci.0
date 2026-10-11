Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE86451982;
	Sun, 11 Oct 2026 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791745337; cv=none; b=rVpi7h6tulj7p+gMhnO8Ef28hgUqvp4CUifdfrQRkm39uUtYG+o2T3Md0rHVfRgL4mrCtce03xkMnoMzhTZUhRgjkVRO060AJwn+lzrbTY5W4vZH0gXWmE9vAmzddjVJIQ/CYWlqKY8+YEMkxEEnJNFABcYI+SveDWaBvtOsF54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791745337; c=relaxed/simple;
	bh=MHxlrs8yNHN8FujBwBQKjzVgs3IhjQN55tOEKo1WdHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mj98xV74S5NdCqF/5nYybuAvHTVwKsYmpjuOqrVoGtQU3u69Mx4UepeEiV2fhYIjI10CnW+dOs8hkUn5REBmLAEA3wS9Wghhdc5XNcpmZf/k+CTOxBhlAeSgLZOcBKWnjbB/ptip9NEHj94WGCdbF5LpMq5ceTeMZfwTeouryv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xi5FHoHA; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xi5FHoHA"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j2qhz60qCzMlQ3;
	Sun, 11 Oct 2026 21:02:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791745331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQOotMRD1xTxlw0GzaibAnBuTjzP2tVA00ijOKzUXWs=;
	b=xi5FHoHA2VFJFM/8nsH7ry4JFBrdfSf7EhebScVzj86qD/YZYPB0SqcxXjJVvwJyoKyYlE
	dYW4NQD3tsey/+2gadTrI973d3OflOBM1V18Npk1tNPqyZkAps+5kxDXHfjTnDovodDcXl
	v6NDsME4HHlXntEe0y/CahSKI0roX5kqU2GAimS08cy8jPT3rxe/Law2QmBdWmwLu50aT1
	VUMEz2QDHeGofSE5TTw5sPWeW+/+SLlaHmlD9mWrB0RcItgNWbU93L+zeRkeNdBObfghFS
	RX4X+OtnQPrEb3lUJFbI95tq6ETsHYQ81B6Pe/QY3bo3ppqezilC8z95b4P7fg==
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
Subject: [PATCH v3 2/2] PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV
Date: Sun, 11 Oct 2026 21:01:45 +0200
Message-ID: <20261011190145.23621-3-gruhlke@mailbox.org>
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
X-MBO-RS-ID: a3c6aca1851649ec033
X-MBO-RS-META: yrf7ponqutpkw93pknpe466wk4gmzqhz

With RRS Software Visibility, pci_dev_wait() considers a device ready as
soon as reading the Vendor ID doesn't return the RRS value.  Devices
aren't required to respond with RRS while they aren't ready, so the read
may return ~0 and pci_dev_wait() stops waiting too early.  This was seen
with Intel [8086:0a54] and Samsung [144d:a80c] NVMe SSDs.

Also wait while the Vendor ID reads ~0.  A VF's Vendor ID always reads
~0, so check its Command register instead, as is done without RRS SV.

Fixes: d591f6804e7e ("PCI: Wait for device readiness with Configuration RRS")
Link: https://lore.kernel.org/r/20250611101442.387378-1-hui.wang@canonical.com
Suggested-by: Lukas Wunner <lukas@wunner.de>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Alexander Gruhlke <gruhlke@mailbox.org>
---
 drivers/pci/pci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 350bae907e..d3d6e682fd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1213,9 +1213,11 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	 * initialize.
 	 *
 	 * If the device is below a Root Port with Configuration RRS
-	 * Software Visibility enabled, reading the Vendor ID returns a
+	 * Software Visibility enabled, reading the Vendor ID may return a
 	 * special data value if the device responded with RRS.  Read the
-	 * Vendor ID until we get non-RRS status.
+	 * Vendor ID until we get non-RRS status and something other than
+	 * ~0.  The Vendor ID of VFs reads ~0, so check their Command
+	 * register instead.
 	 *
 	 * If there's no Root Port or Configuration RRS Software Visibility
 	 * is not enabled, the device may still respond with RRS, but
@@ -1235,8 +1237,12 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 
 		if (root && root->config_rrs_sv) {
 			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
-			if (!pci_bus_rrs_vendor_id(id))
-				break;
+			if (!pci_bus_rrs_vendor_id(id)) {
+				if (PCI_POSSIBLE_ERROR(id) && dev->is_virtfn)
+					pci_read_config_dword(dev, PCI_COMMAND, &id);
+				if (!PCI_POSSIBLE_ERROR(id))
+					break;
+			}
 		} else {
 			pci_read_config_dword(dev, PCI_COMMAND, &id);
 			if (!PCI_POSSIBLE_ERROR(id))
-- 
2.56.0

