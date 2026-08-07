Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6C3B42C1
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786095995; cv=none; b=G0tY1HjThaB9VFSZEXSnZde642m9hO4gJ8kzcpZaRRnewUv9o4woq7/r1JcJOfTUAPxjhImIpJzDVUXSGe6cWSHjJ/rufvXaUSVbhyMf+K6XoeW/rlXBmVkzlqueQgK9TuvSfMIHvJgFLWbTaR6nCyRNrdNpMmgp9AYimV6TJIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786095995; c=relaxed/simple;
	bh=PF9esledfCCh1JrG1GYBpu20FROlxSvsxoK8GTI5cws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltoG9rcPBc7mBvxPZ8Uk4IQpRZUzReQZdUAodYjBMeXqu89+Gz550NUTahD4QsWCj/StiolfmBs4TEVl20BYHMIa1p+5ERHn0x+T5McyTFWVULAoweQOgkVXbrBT2IYPby6ypcErEWUbfiCtYMDdoPC2oRjLwxzDxhSetuWpk2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lMu9uo/a; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lMu9uo/a"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786095981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Ddw1r7tb3o5DDPSUqEusnmuMZOUSfFPIExeHcyi8tM=;
	b=lMu9uo/a9JIzvfssJOUkBr3t8RslTeCv0T3fY4h8GStC0T3YEOXNL5QGH3SXbyfjSB3aKo
	ZYKrsfjEhixOj7YYxtT6GN5cSYUuJr5QdMplEgBF18X2BaGj02b16HO+hl2mJ2uF1Ddla4
	KHxjN3QZJwXknlj6SclHvjao/Or1Cfo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jesse Barnes <jbarnes@hobbes.lan>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Ingo Molnar <mingo@elte.hu>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/early-quirks: Scan all functions in early_pci_scan_bus()
Date: Fri,  7 Aug 2026 11:46:02 +0200
Message-ID: <20260807094601.263450-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=thorsten.blum@linux.dev; h=from:subject; bh=PF9esledfCCh1JrG1GYBpu20FROlxSvsxoK8GTI5cws=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmlKyPNZdLbmfJPvvv3YmrDN+bGqTHPiqdbryyy31bt2 jPp8N+MjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjIpPWMDCdTkjf16fqnfwmO uXfCauFKiRmx9juzLt/NKvz4/umkP2wM//TFWoz9hEoEqtmdNnCceXOn79pKz5Pzrv4TWM/iLHz yJCMA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
returns nonzero, which avoids probing functions 1-7 on single-function
devices, but also stops scanning when a function is absent on a
multifunction device.

This can skip early quirks on multifunction devices with holes in their
function numbering.

Check function 0 first, and if it indicates a multifunction device, scan
functions 1-7 independently so that absent functions do not cause later
ones to be skipped.

Fixes: 15650a2f644a ("x86/PCI: fixup early quirk probing")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/kernel/early-quirks.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 6b6f32f40cbe..c641f38eca3a 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -795,12 +795,14 @@ static void __init early_pci_scan_bus(int bus)
 	int slot, func;
 
 	/* Poor man's PCI discovery */
-	for (slot = 0; slot < 32; slot++)
-		for (func = 0; func < 8; func++) {
-			/* Only probe function 0 on single fn devices */
-			if (check_dev_quirk(bus, slot, func))
-				break;
-		}
+	for (slot = 0; slot < 32; slot++) {
+		/* Only multifunction devices may have functions 1-7 */
+		if (check_dev_quirk(bus, slot, 0))
+			continue;
+
+		for (func = 1; func < 8; func++)
+			check_dev_quirk(bus, slot, func);
+	}
 }
 
 void __init early_quirks(void)
