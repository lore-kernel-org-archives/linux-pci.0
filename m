Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED727442;
	Sun,  4 Oct 2026 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791076742; cv=none; b=W1vyyf4Rit13zWVPt3S7xabqSMixWF4thsLeIMn7opFpLCdJPXiU0kuqpeXzikSAax/pbs5OPGkL/mCch6dehAhoQvTBnVPxL3BL4xVeWSkH+8ze8oWmEpPnP6PZ4GMBharQrzuy80b5fUUFuvW0uY/5ktzSCWZMB6CX1n+FiWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791076742; c=relaxed/simple;
	bh=1h/gWQQiJHoKYSKzX/YmfMFxjxyr1KmmDEENQ283Fe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a+yuVQo9BKG5NdZUYrGxv4ib/LVp8fOSE35dCaO65+nxI3LUoV1YTY4Jz/gOO7EO+DJKKJsDj8h5FVz9IbE6hWdgrIZXLp3jjck3kK/3d4mo82ykuX6QCvB9KvMMP5hIF9112n/jKCQEBAcltHDtJ7P/brkeNWCQF0hNyRtxPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TSV/DXMD; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TSV/DXMD"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hy4RN2n8lzMlSH;
	Sun, 04 Oct 2026 03:18:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791076736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6K74zQYOJYJRfcBo9UYqdfObKDdq20Wwv5QO1BflE2k=;
	b=TSV/DXMDv106tQWNK2BtS+6YDbbRj8nn5gD1Vxw6A6LgOMYcNBZ7agDCQOr2sm70L2nIzl
	Yqw5rdiGgtAZ+NLhQg/OPmubHSAlfMIxyDPTaotajXnfyLuG7u11F66LddGTbqpWaL18ox
	Lk+938V5RLOcVO5gl36UYr0xBNT4rAAH83cKAucuQKR30/zZ49/FVMiG4hdnfy48KLww14
	gGi+hUCWc2ntyPwu811gbXJ8g6Sp+cc089prqhhdzGRZhWJdkj/uUbpFUlhibx3j91k5Wd
	ycHA+lsnkITHi0HtuesT0MCRoeal9d745rIAbznBwWQnrwSVEsW0gDsEoH/gKA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
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
Subject: [PATCH v5] PCI: rcar-gen4: Add missing PM ops
Date: Sun,  4 Oct 2026 03:18:13 +0200
Message-ID: <20261004011851.866833-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zg3sma315nhdrqi1ieqacsgbsgn4a7yc
X-MBO-RS-ID: 576233e560cbda28b14

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
V5: - Set pp->use_atu_msg = true to use generic MSG TLP for sending PME_Turn_Off
      (as suggested by Den-san)
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 27 +++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 2e7a8d85c0060..fceecbd16355c 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -671,6 +671,8 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 		return -ENODEV;
 
 	pp->num_vectors = MAX_MSI_IRQS;
+	/* Reserve an iATU window for the generic PME_Turn_Off implementation. */
+	pp->use_atu_msg = true;
 	pp->ops = &rcar_gen4_pcie_host_ops;
 
 	return dw_pcie_host_init(pp);
@@ -1062,6 +1064,26 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
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
@@ -1127,10 +1149,15 @@ static const struct of_device_id rcar_gen4_pcie_of_match[] = {
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

