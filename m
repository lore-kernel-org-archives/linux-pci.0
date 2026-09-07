Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29030C16D;
	Mon,  7 Sep 2026 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795450; cv=none; b=JtI/p4zHrqAX+bsuHM+d3qjcRPE83UdGnRSP7lJo6TrBJY8opxESy9801gEpI775y97l71+zstJI/3GmimQrTOezKIf+P84qocOIqUQ7Bo+9tA78YpcHdZj9m8bGY5nqENEkkfThUo73s02Ugjc2DCPYXRvisQAUew3ASHm2TN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795450; c=relaxed/simple;
	bh=8D/k82+jwR5ZvlIaXMjCXAygVNMBjGF6AuIgs4jrM30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tmn+fIM9JkpK2MibJ1+K5k4idZrY1fLbbim89U8MtVw1ChhMuhiNtA7fV1YZ7uY241Tf9ELsM9iaTH4hZv977mea4+I+NU+dU/NPWdvQNSmqdDsHcmN4Co/Mc+bSSNOSqGf6tNZ2FBbu2dgbUKPDCvoUfb09N1fLoMetB7v73xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BVhW6yPd; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=K6k+w/To; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BVhW6yPd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="K6k+w/To"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hdrmH5NMTzKmjC;
	Mon, 07 Sep 2026 17:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788795439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qEIbHyu+N1Q2A0abia4DMbUFCvULT/jhq8PP20+UuSQ=;
	b=BVhW6yPdjt68ivCEQjjVxkgCuG4cGgd+wzzGB40xqA6qd1XYRNhyOMp/sG2LoPs83cf/Mq
	wLTWLaXGSnLaMbGnRgjHYGEihLWLl6yvjTkS5P9qBx0WqbMyCg9mcgy4WCUp/hrCPcsZNN
	XHXPPOLbqTsmjVE4cy5LrixiXIxnJSV9VpuMcBGHkdnp29TzOBy5odxk1mKZg3MfDLO7at
	XW9TbVQ1WXwG0nkiYsr97vUmxZGuBYW8nmT1/eU8iy5GDSVYIz6n+dQwYYgncQ4qPj2iv+
	ps2tQ8AIp9CLh8Gc5mhEfHa+n9MZlZK+OeYy7OELJJ5GxLU9VpVLhQ5pI0PRbw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788795437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qEIbHyu+N1Q2A0abia4DMbUFCvULT/jhq8PP20+UuSQ=;
	b=K6k+w/Tol1TZDf5W+RVLsnscX3GW1DjnowypOXthWYKLeIrVBGy41WLP5+aezWEdPHB1dk
	lVGeVMF7Psuksi2/Ob49dLZn3MUB3stndTB/CQ/HnJW8KrUlJPOY4qVyMV6Yr3esuIXkIS
	HIbcVCIY0cWo9UcwJJ58vGTbS304uIVP+oAu7eKLr/yWqzTCQZzns6CZjat54rTBbcSZ61
	nq/DjNFEQlmtVlK+FCchAH+skC4tPV+Obl+WpqY6CWWNcmyJbMx7Y4MxoralQ1CbCySyOF
	SEbqkG2c/f+HxGh/XFlqOuEjYjOM4x9wzq7CpZWadnp2cfFK3006DfEugNrP6w==
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
Subject: [PATCH v2] PCI: rcar-gen4: Add missing PM ops
Date: Mon,  7 Sep 2026 17:36:40 +0200
Message-ID: <20260907153711.653861-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9f1e02c9252aada81e2
X-MBO-RS-META: ifu4aft7cqoki4jpfg3k35tc3sqjt5te

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
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
---
NOTE: Depends on series
      https://lore.kernel.org/linux-pci/20260903205153.283553-1-marek.vasut+renesas@mailbox.org/
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 26 +++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 5690dc32f47e0..7269e08284360 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -909,6 +909,28 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 	return 0;
 }
 
+static int rcar_gen4_pcie_suspend_noirq(struct device *dev)
+{
+	struct rcar_gen4_pcie *rcar = dev_get_drvdata(dev);
+	struct dw_pcie *dw = &rcar->dw;
+
+	if (dw->mode != DW_PCIE_RC_TYPE)
+		return 0;
+
+	return dw_pcie_suspend_noirq(dw);
+}
+
+static int rcar_gen4_pcie_resume_noirq(struct device *dev)
+{
+	struct rcar_gen4_pcie *rcar = dev_get_drvdata(dev);
+	struct dw_pcie *dw = &rcar->dw;
+
+	if (dw->mode != DW_PCIE_RC_TYPE)
+		return 0;
+
+	return dw_pcie_resume_noirq(dw);
+}
+
 static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
 	.mode = DW_PCIE_RC_TYPE,
@@ -952,10 +974,14 @@ static const struct of_device_id rcar_gen4_pcie_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
 
+DEFINE_NOIRQ_DEV_PM_OPS(rcar_gen4_pcie_pm_ops,
+			rcar_gen4_pcie_suspend_noirq, rcar_gen4_pcie_resume_noirq);
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

