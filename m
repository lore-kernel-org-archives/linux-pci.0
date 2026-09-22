Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E84756B4;
	Tue, 22 Sep 2026 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099744; cv=none; b=pQHpfwK0rHvDWqKEzegUoglLrGckXd8Nn80TOftURgsskcQT5F0zvdkgbn94tU2Uuy+Usavh5J52keY4OdmVkYcQodMOwKVxWYa9SpIyN3IzLomwJZ3eVbOMeFmNeZWX7w0dAcN6n5SA0nFRamWbRlNC6i1Udr62v2so53kb+fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099744; c=relaxed/simple;
	bh=MzQ+E6HAaFkUh+IMBq5XOW3qQ/PNyhcLU3rSMAwQMsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qIjHQZztboejS4jLJJKRystBjlV/nFWLO4bGvYZuPskwubiXFpEobClQsLUe6fr94pb8lm8XoSCRfzofJwGhj8W+b49M+rWiKTVMvAP0KzaXcFhorSe7IgHoTDMflxb+ViKXj8FZj/eaw+qbHjypd9dWkG7EhnzhyRCEOuWa/1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VlsBvBEL; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qi02R3XV; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VlsBvBEL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qi02R3XV"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hq76s3lthz8txm;
	Tue, 22 Sep 2026 19:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790099733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q36xhhQZhPtTV6582ASzwCX3bBOPwedu0RxCQ0wH5FQ=;
	b=VlsBvBELRxD6wuWMIE9LLzZyOcAkpJddwLVrX+KYTYJBepMsJ5uTjB6FNtWGhHUwxnrzu3
	GF4/925KgSgvReuc55erIx4iRJIlClO+vle2Nocd/oXRnfYINZYUalYsqzoWtf/z1rkFLV
	shoVZTLrGMyA+UB34pE1CX3nv1TFXmSVX+LaR0i9tu9/eI5c91p+nyQM3uDaqXUtPVUb1p
	dqCTPqpfjHbqLpCKt1MBsA3lhwTe7Jar0wFNBxgL+oqiDiqRefj/o2CD/13n0U7Bidr/zm
	EPnKF/DVwIDJpq5TdS6kISkcpasF894S/ATjFxSVTzb/VOhjnPJauuoqxWhGcw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790099731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q36xhhQZhPtTV6582ASzwCX3bBOPwedu0RxCQ0wH5FQ=;
	b=qi02R3XV+FdygdVKvitdvjT3PHfYfo4CAwwjjjHQ7VxrSn+Fy0ACmyTf5eSORXSvfw5Sw9
	kXoVFTDTZwyQes+b0M5brZudRQcrm9HrarezSlxJJ2zMa2D7eb+3bNhWIvE3q0IyCGM/nP
	nZyofKmBp/WWSuFDIr1vGSuj2kDRumrsKb2+JgoJmLn51tFx2ghj2iqJrdpru5V8CxN1HY
	lNqyV3j4Hl6S654K4vvBjsB/5xOHgyZCcG09pIxqzdCpkr4upj0vy5MFmHq+6Y7S3VYIFq
	EI3cwuM5o+1uHY6VvZ2K9bon/2LctRvm7N2GflKY2jExUA3Q/YuSJtbokA+BnA==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Koichiro Den <den@valinux.co.jp>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4] PCI: rcar-gen4: Add missing PM ops
Date: Tue, 22 Sep 2026 19:54:59 +0200
Message-ID: <20260922175525.288106-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e7e2f252a8933886838
X-MBO-RS-META: bhzj6p5j66po138xqpp4otmaghpdmrbk

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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Koichiro Den <den@valinux.co.jp>
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
V2: - Add TB from Geert for RC mode
    - Use pm_sleep_ptr()
    - Call HOST suspend/resume ops only in case the controller is in RC mode
V3: - Add RB from Geert
    - Make rcar_gen4_pcie_pm_ops() static
    - Pull the mode from driver data
V4: - Add TB from Den-san
    - Rebase on top of controller/dwc-rcar-gen4
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 25 +++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 21c3dd9b88910..1f8821e3a4242 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -1062,6 +1062,26 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 	return 0;
 }
 
+static int rcar_gen4_pcie_suspend_noirq(struct device *dev)
+{
+	struct rcar_gen4_pcie *rcar = dev_get_drvdata(dev);
+
+	if (rcar->drvdata->mode != DW_PCIE_RC_TYPE)
+		return 0;
+
+	return dw_pcie_suspend_noirq(&rcar->dw);
+}
+
+static int rcar_gen4_pcie_resume_noirq(struct device *dev)
+{
+	struct rcar_gen4_pcie *rcar = dev_get_drvdata(dev);
+
+	if (rcar->drvdata->mode != DW_PCIE_RC_TYPE)
+		return 0;
+
+	return dw_pcie_resume_noirq(&rcar->dw);
+}
+
 static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
 	.init = rcar_gen4_pcie_common_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
@@ -1127,10 +1147,15 @@ static const struct of_device_id rcar_gen4_pcie_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
 
+static DEFINE_NOIRQ_DEV_PM_OPS(rcar_gen4_pcie_pm_ops,
+			       rcar_gen4_pcie_suspend_noirq,
+			       rcar_gen4_pcie_resume_noirq);
+
 static struct platform_driver rcar_gen4_pcie_driver = {
 	.driver = {
 		.name = "pcie-rcar-gen4",
 		.of_match_table = rcar_gen4_pcie_of_match,
+		.pm = pm_sleep_ptr(&rcar_gen4_pcie_pm_ops),
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = rcar_gen4_pcie_probe,
-- 
2.53.0

