Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546E4BCADD;
	Wed, 16 Sep 2026 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552972; cv=none; b=T9IaHkTcDBT2DpiCNNHvk0c+LL2HTB7uVLgxrG9z5BoSFgIR5QTXTR3FeeqvZE3uajac4iiR2K6UnPiDlTWSQ6pbUyOjFbOaW2bsoS17gNIDUcFNekSW7mC9zIqxIM6LpMohNch7HsfEu5fWyY3kC3qXSIFDL3uRHYnGcG22804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552972; c=relaxed/simple;
	bh=pLDtuLhbAUaRhu5f/gk6EI60epdwBmxLvZxAAZxvEqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MbqbIf1WmQDYVQhBdBDLqQS59iW23hJ3E3xuT2+CnIDRS7YIjIkt2cqA82ccZoDCLb+o+TT64EskqZVomfBJn3298xuXjZgRCCJl5IURf02BtBMztgc3nlfxO3OeBFYdGsclQ0gK+2C88RWCGxpibqSXs7Td4SOKvuAoVoifrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLFJDiyv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLFJDiyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518DE1F00893;
	Wed, 16 Sep 2026 10:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789552952;
	bh=lEWZpaztRZh3VnEkTUtaM+9zTZcc/T4M22ejqBKvws4=;
	h=From:To:Cc:Subject:Date;
	b=hLFJDiyvIbk5VJQZTRoebBNI4x4sBw+V66Ai36yhls7cEpby2U5m5caujSkYmunu3
	 LKh6HQAHJHKZH1mNqZ+CyEdu3LZ4+z1Lmvx5oPUZPaMy2xAqKqfD5o8X+hHWNJKHcs
	 enIGHPhiHO8s36ZgUtOokOvcGjK+rvnlIuO9NYPDrl5HcVL9I++UYUpICrZmNyBs36
	 bJQbN2g+Izshj3XbvVnX2d3R7DLzywNPp8Q07274LACU/RQpHO716v4RJNpTwRD1WF
	 RQorrj1eY8XOPBBSimJqhSRgUCJ+iw1QoDw26462wgsJDH/af2EfKTsCWX5OuDD8mg
	 WCOlHwCZMsPig==
From: Thorsten Blum <blum@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jesse Barnes <jbarnes@hobbes.lan>
Cc: Thorsten Blum <blum@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Ingo Molnar <mingo@elte.hu>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2] x86/early-quirks: Scan all functions in early_pci_scan_bus()
Date: Wed, 16 Sep 2026 12:02:07 +0200
Message-ID: <20260916100206.92853-2-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350; i=blum@kernel.org; h=from:subject; bh=pLDtuLhbAUaRhu5f/gk6EI60epdwBmxLvZxAAZxvEqg=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmrMuWcuC8tif7HVhr5SMg56+pr9dt9T7fGCx7M+aOaf /jdz9lnOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAi1ysZ/icuccypt1nB1iev Jxj8vE2lT1mQ48/WlbbLzL7GKVv+2cTw34UjY6HWpQPpr3scZvqZnZ0+39LB+qxCnEgVg47dVqt rHAA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
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
Signed-off-by: Thorsten Blum <blum@kernel.org>
Link: https://forum.libreelec.tv/thread/26799-wifi-not-detected-on-2012-imac-in-11-0/ [1]
Link: https://zoringroup.com/forum/5/7170/ [2]
Reviewed-by: Lukas Wunner <lukas@wunner.de>
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
