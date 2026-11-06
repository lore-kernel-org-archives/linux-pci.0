Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925848;
	b=HLs6xc0mZQZIxrkv3w/b2fX/cyDG3wWGGyUqnQqVmexVykBT28Uj32j++M1AKOAfOEEw
	 TJt7sSUqdb/RkYPj3mvpyqaFNmbE+VbNcxS7pZ0F5h+8uF9xhfQFs1+DSoD7tY/P0OhQB
	 wqCQc/Dh3CGVF6CLxV9/mDljm33eYjwtuD5PXGH1CiXqz/AxIIkl3U+RU7aUfbbaHMhvH
	 bHWmKIfaaXaLGFoYCDYMN50aRQUUNlYZppHHLDZpu4xoyn/ULwd5KjbTs0rwCH6G9i9U6
	 FA13KAiAMuZ0GVVTjYMsFOywuePJnhHBCog5T1sz5q8maM2ph/pdDaMM4y0bvCbG/Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925848;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=LonyDGSMNo1cshI3n77tZmRLppaf6+iUyvRxeeFyyNE=;
	b=coPZYZdV2TAo3yCE4uFJaOREwm+DvvK4XIKbLVP0tVlve2GV9XXwPDr6qSg80q+QRRk3
	 wlbQWVbGpLOj9Yak29hJcIog0NoqxO2EpyvlkQm0mdxqANbajfMDGm5FLLa0N2D0glwM9
	 bwa1/2QN4OxnJTgtK2epTNgdEGxvjg7y/J4sOyl/R1vywHbO1rHDsZHb1Cf5aBQShj3h0
	 8xhLGMzpxYsarD2PAYbcU7p8srx4pcVqFeE+0akqsyOQlkjz1+VvmiTk9N19QapGBfFRV
	 7aMbGTnrl+bFc2uLiXB1ZhtAv60i98AF/FlDXRVYS8BCnTgImZNwnjHejZgNzoCG48w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVjTGT+o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5F6606A328;
	Fri,  6 Nov 2026 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVjTGT+o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B271F0089F;
	Fri,  6 Nov 2026 00:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793925847;
	bh=LonyDGSMNo1cshI3n77tZmRLppaf6+iUyvRxeeFyyNE=;
	h=From:To:Cc:Subject:Date;
	b=BVjTGT+oadobSHndwg/1oavJ7kUPjsLO0ArWkysOrIHwjG5M/J9jIB4/L0Ecyl83r
	 KqycKqOjQlpKoiyQ5qV01AikFavNcuTmGAlKJuXN+TS3vQtfJJQSyqkDXEX0ilbVfd
	 pyUq4Pmd58y5ttOevEgC+3KwCT3yjdPM3t4UO3Zyqfj0/CsuMoR7adajMQtO7TpO+x
	 UERKu9JdejKgxpoO8srEm2Yo79qEzN+5mWfmaNuPq/N6Z3TDJUZrsv7HRz8z42g9nR
	 8jwl2tNbut7ni8O6NNvbPOH2d2+XRKb7VxOwiXvwAPZ4SjvkIZUAv3HvkyIEYAqV6y
	 gFSlSr9ChRDIg==
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
Date: Fri,  6 Nov 2026 01:43:43 +0100
Message-ID: <20261106004343.457087-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506; i=blum@kernel.org; h=from:subject; bh=pMjnV642ADW4Rvw0xiZQq6q4f7GHuDxRp/P1rQrG5bs=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlvlfbP+iAUsyDN6L1w3r7WW/2M7ifU32e53Ag7OyXex teq/0pSRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEwkcDcjw9VnNy9feLNzr8mM X6rOMSVcn0qPc4kFZFka67d3cN/mlWb4pxdzcPVFjpOn/vVU6Nj6/fnw4dlL3rvZO5oty4oefv5 fww0A
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
Link: https://forum.libreelec.tv/thread/26799-wifi-not-detected-on-2012-imac-in-11-0/ [1]
Link: https://zoringroup.com/forum/5/7170/ [2]
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: H. Peter Anvin (Rosaic) <hpa@zytor.com>
Tested-by: Thorsten Blum <blum@kernel.org> # on an iMac13,1
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Changes in v2:
- Add iMac13,x background information and supporting links (Lukas)
- v1: https://lore.kernel.org/r/20260807094601.263450-2-thorsten.blum@linux.dev/

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
