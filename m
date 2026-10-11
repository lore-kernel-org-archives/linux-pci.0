Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96902335BDB;
	Sun, 11 Oct 2026 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791736387; cv=none; b=CdFOSAycKl6K/I5JcAtXzufNjFIkmJRmDCPunBQqpyjkmJ9fyLmdwJUDZyxOjGiRnNP0khU2WSB+r2Ahz/9OhYTm9snmbZ/mI3AWhHvUmcCbYgb7o9RPMBqiADz/aUUrXHt5NyfLTPcBwcCCUn+0I+O+YTYOeXh2KLQ8+ZjGxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791736387; c=relaxed/simple;
	bh=fMafDQIFWPaE7spjh6pRwedU15wzqygRH9nYU8fJPpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Izpp0jOTFXePndQmdj5VUq1p6jGShbyDpdfpu+u/5pX3TVMe2k2EsXwfsl8EFo/ugZ1DDXm7S0MOKM4ZkDsUlhJ6BLNFPemxtvFIisbuFGOcGneVkAzqWWBxCAxpcovd9uzSiMWEBpjMrzZ0sMOfbIKdNZORtX8WtuOxGm/clAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hlJK/jXe; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hlJK/jXe"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j2mNn3lMzzKp4f;
	Sun, 11 Oct 2026 18:32:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791736377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zG5W5tU4hitsYMAYjfqimE9j+s84hGDNovLwBuNU7co=;
	b=hlJK/jXeyeIrAJjZaEOQpwlY3rWg56UsXPydS1f845/sbN/koa5TEIT7Jxyh0zEs46mD6d
	s0zGtZwKJgKeAVQHiR8e0KfzllLeVmlY91ka7B7GKPDOXNXONy46gSvCKfSqqH2To3Vo/t
	Q2h0k8Y0DLChuxC6ZfFzj8IjZIs65ISftKF0Xwhh50NZlRtty1pu8JV0bp41rFl2z9ObO7
	bfoV1f43LePsyovLYVL3NxCxgvwObW/H27EUC4w7iPgK3bUOL9q5GiMspXvbUGPKKd8lnu
	VJmHkZBwilvNULCAqQBh7QKt7E7eMCJ/mW3qV9RdC0FwGq8gD9mrgA/3nFgHiw==
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
Subject: [PATCH v2 2/2] PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV
Date: Sun, 11 Oct 2026 18:32:49 +0200
Message-ID: <20261011163249.18479-3-gruhlke@mailbox.org>
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
X-MBO-RS-META: cemfi3pmh9mm4uzax7w7uung5wp46exh
X-MBO-RS-ID: 3e4afb7381bff1ab49d

With RRS Software Visibility, pci_dev_wait() considers a device ready as
soon as reading the Vendor ID doesn't return the RRS value.  Devices
aren't required to respond with RRS while they aren't ready, so the read
may return ~0 and pci_dev_wait() stops waiting too early.  This was seen
with Intel [8086:0a54] and Samsung [144d:a80c] NVMe SSDs.

Also wait for a Vendor ID other than ~0, except on VFs, whose Vendor ID
normally reads ~0.

Fixes: d591f6804e7e ("PCI: Wait for device readiness with Configuration RRS")
Link: https://lore.kernel.org/r/20250611101442.387378-1-hui.wang@canonical.com
Suggested-by: Lukas Wunner <lukas@wunner.de>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Alexander Gruhlke <gruhlke@mailbox.org>
---
 drivers/pci/pci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 350bae907e..fef8a799c1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1213,9 +1213,10 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	 * initialize.
 	 *
 	 * If the device is below a Root Port with Configuration RRS
-	 * Software Visibility enabled, reading the Vendor ID returns a
+	 * Software Visibility enabled, reading the Vendor ID may return a
 	 * special data value if the device responded with RRS.  Read the
-	 * Vendor ID until we get non-RRS status.
+	 * Vendor ID until we get non-RRS status and, unless it's a VF,
+	 * something other than ~0.
 	 *
 	 * If there's no Root Port or Configuration RRS Software Visibility
 	 * is not enabled, the device may still respond with RRS, but
@@ -1235,7 +1236,8 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 
 		if (root && root->config_rrs_sv) {
 			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
-			if (!pci_bus_rrs_vendor_id(id))
+			if (!pci_bus_rrs_vendor_id(id) &&
+			    (!PCI_POSSIBLE_ERROR(id) || dev->is_virtfn))
 				break;
 		} else {
 			pci_read_config_dword(dev, PCI_COMMAND, &id);
-- 
2.56.0

