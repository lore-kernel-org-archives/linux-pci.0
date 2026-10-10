Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AAC3AEB5C;
	Sat, 10 Oct 2026 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791648349; cv=none; b=f0mLy6ZThocfOHKV28vExfu1BvdL7z2luoxEURb8i+vchU+6DqBJW48NwXEyACcQuaUK5R3GWgnL4PIfJPgrqUr6CtzhD7EgapX4LE05rR22H5VFnYx/MkJX7vKW57ZVuCMlSACgrLpwNzfjgQRrBtVoSskIzXAEfB2ZaPsg3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791648349; c=relaxed/simple;
	bh=qfrKkcrGUPaYwApM/YXJnTsgE0egSdGM8JLfe1iiEfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dggEcs/4NiOwKco/i0zE4ePNc92eZGa7DrZ7ETTzBmsFk4phLVlFKH+YjBQKhXY4Up62QJwOVjMvFmsdZBh3ZMg8k3hnzEuUsHDpHIBDcq/73wqgiC9Ux1PNRNGdWFuKuxFHbNyR2eD+jLolALrphRcniQdHxvVfW2qKcTlYjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UPYit/MY; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UPYit/MY"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j27qk0f2szKnQV;
	Sat, 10 Oct 2026 18:05:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791648338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJWaRD0455o2NwnlxpsJRVpp0gFnTqUxDLyLRnUpKT4=;
	b=UPYit/MY5h+EpJGkbJJEmxmIdhd3CLdPEhJdRHIvd5X9SGPUTJDbQXo38l3JHx1clNRH3c
	8PtXwHGZuYKNIzoxZBGAy5x9+XYAc6jZWhhpJ+rhB5N3l+/+/Hui6gPxkScdGLyhU3PsRV
	AOVdDTKhP+z9UGV61h8rXFZXUsVgIeIhlKvOAyqKM+v4yreyHmlD0ib4A2EQc6DnBpqmJT
	O4KiEiTBfEPXop06807BgSgzuTcy+BhDXOJXbClaq4GJLxVnkZGAEZ4gtgqfwIBrMlZmb1
	WmH+VTflMcBBewYwLJwjYmMx6NyLY6v1oIlBcLJLj9IWoLmevXQ2OJ25k9GT7w==
From: Alexander Gruhlke <gruhlke@mailbox.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Hui Wang <hui.wang@canonical.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Alexander Gruhlke <gruhlke@mailbox.org>
Subject: [PATCH 1/2] PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV
Date: Sat, 10 Oct 2026 18:05:28 +0200
Message-ID: <20261010160529.27974-2-gruhlke@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010160529.27974-1-gruhlke@mailbox.org>
References: <20261010160529.27974-1-gruhlke@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: prekrie7qoa7b5qw884imkafn95i66kr
X-MBO-RS-ID: 25219a152566ad9b750

With RRS Software Visibility, pci_dev_wait() considers a device ready as
soon as reading the Vendor ID doesn't return the RRS value.  Some devices
don't respond with RRS while they aren't ready, so the read returns ~0
and pci_dev_wait() stops waiting too early.  This was seen with Intel
[8086:0a54] and Samsung [144d:a80c] NVMe SSDs.

Also check the Command register for ~0, as without RRS Software
Visibility.

Fixes: d591f6804e7e ("PCI: Wait for device readiness with Configuration RRS")
Link: https://lore.kernel.org/r/20250611101442.387378-1-hui.wang@canonical.com
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Alexander Gruhlke <gruhlke@mailbox.org>
---
 drivers/pci/pci.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 350bae907e..26be5d1ca9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1215,7 +1215,8 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	 * If the device is below a Root Port with Configuration RRS
 	 * Software Visibility enabled, reading the Vendor ID returns a
 	 * special data value if the device responded with RRS.  Read the
-	 * Vendor ID until we get non-RRS status.
+	 * Vendor ID until we get non-RRS status, then the Command register
+	 * as below.
 	 *
 	 * If there's no Root Port or Configuration RRS Software Visibility
 	 * is not enabled, the device may still respond with RRS, but
@@ -1235,8 +1236,11 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 
 		if (root && root->config_rrs_sv) {
 			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
-			if (!pci_bus_rrs_vendor_id(id))
-				break;
+			if (!pci_bus_rrs_vendor_id(id)) {
+				pci_read_config_dword(dev, PCI_COMMAND, &id);
+				if (!PCI_POSSIBLE_ERROR(id))
+					break;
+			}
 		} else {
 			pci_read_config_dword(dev, PCI_COMMAND, &id);
 			if (!PCI_POSSIBLE_ERROR(id))
-- 
2.56.0

