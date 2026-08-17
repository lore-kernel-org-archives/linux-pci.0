Received: from mta0.migadu.com (out-63.mta0.migadu.com [91.218.175.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1683BB108
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957361; cv=none; b=RM2pgasCxRBq/+cEheAxpQy4JI973ZqLSzj5f0TEmcc2TX4asfQ8HekT5zXd6a863qugxGQD0pIiA6bQxPpIRqPW+kQdgCa16UbHv2H4b5PPO46SAFgUslm4Xdq1s65xij8YgxnBH/nlrt2BnFPhgPAhZgkoPd66T6a22SKrdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957361; c=relaxed/simple;
	bh=smVKQVnwoSgc8LF1yoi6hDlpcXoQQ6qbB6uAo7sRJGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXy/8ifmdY1i7pQ3RZ/S8f6zODe8Lzkr7E0iHv1vEVGXcUjRN4hjSFkgUHQB+RNC9Yr9TIpWDyUykS912vu6NjeVbPlwODXVCFGPwhTAyre7rpIWZlg5uc7U0SR0QHB2JotAQr6nEj2Y/QnSHOsx7hbrhFbZteCgcNdaYCaAP8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dLQsjtMZ; arc=none smtp.client-ip=91.218.175.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dLQsjtMZ"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=smVKQVnwoSgc8LF1yoi6hDlpcXoQQ6qbB6uAo7sRJGQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786957356; v=1; x=1787562156;
 b=dLQsjtMZR9fo59JXM7eyVl0OA4TBTDtEr4TiObxjpH+DdhkOq5cNDSBM+lgURQr8VuxBvPlH
 GV9QdnQWhnNh9Rnac4PBUThXICdr9f+aeFST4MJPHUuUQdalncrTVslyw2f1kBv5uMZ1l9J8hBG
 32XA5a3SHW7lQDy08vEF6MKY=
X-Envelope-To: linux-pci@vger.kernel.org
Received: from fedora.fritz.box (62.216.208.217)
	by mta11.migadu.com with ESMTPS id a864c9d369a41f86;
	Mon, 17 Aug 2026 09:02:25 +0000
X-Migadu-Flow: FLOW_OUT
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [PATCH v2] x86/early-quirks: Scan all functions in early_pci_scan_bus()
Date: Mon, 17 Aug 2026 11:00:13 +0200
Message-ID: <20260817090011.26011-3-thorsten.blum@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2313; i=thorsten.blum@linux.dev; h=from:subject; bh=smVKQVnwoSgc8LF1yoi6hDlpcXoQQ6qbB6uAo7sRJGQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlNZ+cc9p01sdi4mW+NjXFq19WEwkDeozKrzq4OWqR3e l5BQadHRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEyE6x/D/9xnOYcf/tz7NOfk Ca39kr8CeEKX2YveMHZffMHmarIU51SG/ylp/yQ38Ryp/VOSaPzy4znZ015rD79tSo05cerCeak JzCwA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
returns nonzero, which avoids probing functions 1-7 on single-function
devices, but also stops scanning when a function is absent on a
multifunction device.

This can skip early quirks on multifunction devices with holes in their
function numbering.

On iMac13,1 and iMac13,2, the BCM4331 AirPort card is behind root port
00:1c.3, also documented by the model list in commit abb2bafd295f
("x86/quirks: Add early quirk to reset Apple AirPort card").

Public lspci output for 2012 iMacs [1][2] shows that 00:1c.0, 00:1c.2,
00:1c.3 and 00:1c.4 are present, but 00:1c.1 is missing. The old code
stops at 00:1c.1 and never reaches 00:1c.3, so the AirPort reset quirk
is silently skipped on these machines.

Check function 0 first, and if it indicates a multifunction device, scan
functions 1-7 independently so that absent functions do not cause later
ones to be skipped.

Fixes: 15650a2f644a ("x86/PCI: fixup early quirk probing")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://forum.libreelec.tv/thread/26799-wifi-not-detected-on-2012-imac-in-11-0/ [1]
Link: https://zoringroup.com/forum/5/7170/ [2]
---
Changes in v2:
- Add iMac13,x background information and supporting links (Lukas)
- v1: https://lore.kernel.org/r/20260807094601.263450-2-thorsten.blum@linux.dev/
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
