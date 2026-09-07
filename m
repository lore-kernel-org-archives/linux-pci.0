Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4662264A9;
	Mon,  7 Sep 2026 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788798971; cv=none; b=pn7mWF7tuZ+NjMTB/+2n3/ByrItvd2kFplt9y7kf9r0//hInt8sgjUSWcuOSsHCC8BQAE1paoEs8TB1gFyl0mC8EeGeNQdyZxUfb6GB6SJnelokKaqT2Qu48g4Spp5pwkeraePRclccaaPeXCw9UEPdUZs/XbZMUU/jA4elHX4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788798971; c=relaxed/simple;
	bh=ptGDUYDjTMupmTnbstt2zJP4xE1vw7AsSBgYtQC72/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JWVAR/rrFzWgzZxpNNU3Js0/KF+RU4tAwocjFQFGvgqxXgdpHnK0ehR3WdTtHSsS8gXncZsNiGJXYq//4VpySNx1Sxe47wWsicfEOROd6nIzzh4kBsHMqs2Ud4Tw2Nm7BmiyelI/6KKfZD5u0AjPvXbChYBOYSNUan3MVGOquIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NWUGR3eL; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=stIx+RjZ; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NWUGR3eL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="stIx+RjZ"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hdt463vrczMlDZ;
	Mon, 07 Sep 2026 18:36:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788798966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SGejP6nOdYl5DK/7H1L4X0NlGPSqKJjetUNljJqP5fE=;
	b=NWUGR3eLjpMI+SO0apjn1harukArd9wIACVFRFMNKhqT9A0L7z25ciikfHAikwhxxc7DjP
	yKBhY9riu1xJ97jFPbnWIFFN0K3PMbiRfC64XKs++fTKihHVwVY1NHusdoJwRk5DfbucDT
	D1DgJrOrkj2V7ZLjsHsKpahz3VdZt4pskGmt7hZIjYtvdjAc0ZOQjNGxuwO/x8rxplKe3Z
	evRJugesyLssnK82EruHf/9/tHFPY3V1/2j+Xlz99W/Lk19X1osYAER3VPa2fAOPNueu/z
	E9jDTuNW/Me4s+z9hOKgY/yh7XGt9QayhmnHGe5Y+FIGJMFxXMfPpYvZvALTPA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788798963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SGejP6nOdYl5DK/7H1L4X0NlGPSqKJjetUNljJqP5fE=;
	b=stIx+RjZFzZLWOk/3yDpNvTFMDc5NkDHpDA5paJH2uRY5UCSo6XzRnDd1DJFAjEy6lvX+y
	V4rD6aXoBNPPtmVoOMJf/dUcPz1cJBplZOz2A1wGvYeg4TuYJsuZVG9TzmCOwnvPrhxfWQ
	haGCDPoOyQoTEhtmCEbCkWpEBwrDMs9sUpd2QoGGxVUExsp1RGv8dRuB2u6hNww0sUTmOG
	vFEToqEcjknZgoh0r/4CSWQRP6MCDaE6qte1EaGCEzfcggQb+oKH2oj9Ug7sFSzlKTPLag
	qOHr58i8C+HAh9fgdef1CGnIMVM2vfzv9H9vQuRLNeCRkD+p/wzsvVV2lQq3qQ==
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
Subject: [PATCH v3] PCI: rcar-gen4: Add missing PM ops
Date: Mon,  7 Sep 2026 18:35:22 +0200
Message-ID: <20260907163554.725127-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kz8cjdq7az9gimy5tf1tzpjbb99rf17k
X-MBO-RS-ID: 97eeeb6b23e73cbd595

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
---
NOTE: Depends on series
      https://lore.kernel.org/linux-pci/20260903205153.283553-1-marek.vasut+renesas@mailbox.org/
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 25 +++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 5690dc32f47e0..8b6a6cab1b83e 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -909,6 +909,26 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
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
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
 	.mode = DW_PCIE_RC_TYPE,
@@ -952,10 +972,15 @@ static const struct of_device_id rcar_gen4_pcie_of_match[] = {
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

