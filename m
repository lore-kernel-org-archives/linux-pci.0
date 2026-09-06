Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7893D450F2;
	Sun,  6 Sep 2026 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715968; cv=none; b=M+PwgxTVni38LSXwrIJuykQ1BGmysPAmfTmELGnYLZSmX26sIgfn5OAhqv95yNPvb04IB5HcFfemdkQCkPcYBNlrYXhMFmlSCOUKQM9N5oAsUqGy0KIlapesTiDnPNms4o0PUt1kwHAcK2MC4ILz0THTyK49Zd8vMJRg6oLlM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715968; c=relaxed/simple;
	bh=J1dMz04icOYOGAmumHJS85Ktsed4rBuh14zvQ8znmmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z32vpu0pV+Y1uqW9Qy8VSizfwPYnIGXUcy2Q6tL3Uxn7gm5Zt/mk473I8+O6tn9z7xbIaLPF9YneL0Cn75Z5okoiwLAh1cbQ4z1DXh3rysXcsNEpkR0z6etZfJzCzoWTeyZfGqw5g5HjLD5mU6jQgirTG6xBjAiJutiJcwvnPIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZTJ73u2L; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tYJWTvcg; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZTJ73u2L";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tYJWTvcg"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hdHMv6v0dzMlCx;
	Sun, 06 Sep 2026 19:32:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788715964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UIE+4XFoDu5qq6aHf4+F7XKm5AuUKo/qoPgcCZ8gvjc=;
	b=ZTJ73u2L7DxkAS+jaf4xMIn4+ZjQegXa6DOv21mu40gzUDHsJcdNAisT4FAn5Vz/FFqnDd
	T5tcl2nRTWqbWbKCfBwQzzKyq+NdwVGXiLRjz+a98rD8/gbwzXE78VBRNhsx2F55yBxIM1
	jNb3XS3isWmMhBXi0jfph3/yrDLJy+Z02ylCRxqg8xdlNAehe1MWsPjBc9pKt7oAemUptt
	l1sjvHgkkFdEx/pXEcViC0tWklA0KCCxyb7GZChT18DpNY+SVkIyGOPfy6fXvitL2C4BtN
	Z8acxQEsRSPs3mk851LRisqBJGEj0dMyiE/IaXM0wH6p+sCQ1TFOPo96TYp8tg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=tYJWTvcg;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788715961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UIE+4XFoDu5qq6aHf4+F7XKm5AuUKo/qoPgcCZ8gvjc=;
	b=tYJWTvcgvi2+duolqS8GmywFB5uDSzWo5qAjBCFdrEgLpEgZtSwulDIkUI7Qmp3zrIJ/dG
	kZ+2l+JtDcPGwjmp8hhihNth0RcPWKBNj7beT2ZPVntS8nlWZju51G0BKC+6YcGEiU5g2D
	77dK0zQ2Tib8Vos7IbA1dUv02eRHyN0elXEdO8M+nI3nLKwpGs+zBARw0q01gLdZ+obnvX
	QtUPQvn1LZXQ9RA1Ye/s7Pfz8y9ljXvgnGHyi2gDQ3pjvSYAVVojmtzQ9FgRQpe1QSTiOM
	3Ug0/ftEig9FLyDmZQjkWV+ofzP3PWfVt6om/aC40OdNJ7Iyfeb+lJ1qPs2DFQ==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [RFC][PATCH] PCI: rcar-gen4: Add missing PM ops
Date: Sun,  6 Sep 2026 19:31:00 +0200
Message-ID: <20260906173234.522400-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3jqaou8uymgyayakppbpdrp9mp3z45ow
X-MBO-RS-ID: e788f12618cacecb80a
X-Rspamd-Queue-Id: 4hdHMv6v0dzMlCx

The R-Car Gen4 PCIe controller is part of a power domain. On R-Car S4
and V4H, this is an always-on power domain which is not shut down in
suspend. On R-Car V4M, this is a dedicated A2PCIPHY power domain,
which is shut down during suspend, and the controller loses state,
which prevents the PCIe from working after resume.

Fix this by adding generic suspend/resume noirq ops for the controller,
which tear the link down on suspend, and restart it on resume. Use the
same PM ops on all of R-Car Gen4 to gracefully suspend and resume the
PCIe link on V4H and S4 too.

Test case which demonstrates the problem on R-Car V4M:
"
$ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/pre
$ echo s2idle > /sys/power/mem_sleep
$ echo platform > /sys/power/pm_test
$ echo mem > /sys/power/state
$ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/post
$ diff -Naru /tmp/pre /tmp/post
...
-00000000  12 19 32 00 07 05 10 00  00 00 04 06 00 00 01 00
+00000000  12 19 32 00 07 05 10 00  00 00 00 ff 00 00 80 00
                                          ^^^^^
                                    Class 0604->00ff
"

Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Koichiro Den <den@valinux.co.jp>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
NOTE: Depends on series
      https://lore.kernel.org/linux-pci/20260903205153.283553-1-marek.vasut+renesas@mailbox.org/
NOTE: I am sending this as an RFC, because I would like to get
      a TB from Geert before this might get applied
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 5690dc32f47e0..3bfb2bd53fe3b 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -909,6 +909,22 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 	return 0;
 }
 
+static int rcar_gen4_pcie_suspend_noirq(struct device *dev)
+{
+	struct rcar_gen4_pcie *rcar = dev_get_drvdata(dev);
+	struct dw_pcie *dw = &rcar->dw;
+
+	return dw_pcie_suspend_noirq(dw);
+}
+
+static int rcar_gen4_pcie_resume_noirq(struct device *dev)
+{
+	struct rcar_gen4_pcie *rcar = dev_get_drvdata(dev);
+	struct dw_pcie *dw = &rcar->dw;
+
+	return dw_pcie_resume_noirq(dw);
+}
+
 static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
 	.mode = DW_PCIE_RC_TYPE,
@@ -952,10 +968,14 @@ static const struct of_device_id rcar_gen4_pcie_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
 
+DEFINE_NOIRQ_DEV_PM_OPS(rcar_gen4_pcie_pm_ops,
+			rcar_gen4_pcie_suspend_noirq, rcar_gen4_pcie_resume_noirq);
+
 static struct platform_driver rcar_gen4_pcie_driver = {
 	.driver = {
 		.name = "pcie-rcar-gen4",
 		.of_match_table = rcar_gen4_pcie_of_match,
+		.pm = &rcar_gen4_pcie_pm_ops,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = rcar_gen4_pcie_probe,
-- 
2.53.0

