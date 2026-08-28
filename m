Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74737448BBE
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922652; cv=none; b=iYjif7bFkD61YUdWC0/NU5Kp9sGur/Kwtr/1R7DE+0eyq1a4TXNeWnP4WrCYYeIcMXtevpZGqDwIKpw7dDpUSiSXajwez4/IZpys5oI4UjY0BDYvEuemIX6jR3JyzIVmWZYCMQsFL5H2b7rWOIkJXiYRAKsm0nE9f5R5UNRqbgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922652; c=relaxed/simple;
	bh=iFjL9XI9CHMHdv0QincBDDMEbFGBO5icuMXCstbvhdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z7JEtvBF6GreBAAVAVLZYmKUgB2vqBMpvdD5ifoMt5GRx0bG3l0Gm1dYgZF3MMT0XbdoQwW0daVsEJ/M5RDtYoUnRKzOAytXyDE/FC2Coe/rEe9TxTTUN/QQzLbnS7as8SjaiWNcGdVRBqtNxAw7Pz9stvf2UHOVfEXW/1Fa9pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=AKAqMOzR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="AKAqMOzR"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47fd66a094eso374344f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787922648; x=1788527448; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D9vn94z6fRxQMjXUuhba8xPlc8Nhl/43jHnKAHyxeqo=;
        b=AKAqMOzReIVUmXieuMkyu3uN4Roz3tDaThEUg28h9XVib4NrhGbkj/QvLUUrtg58Os
         A1WNJnFzPGUyK52oOVthazcWjk7oNh0lfZRs8VLheVFNQrlvjOFExld0zbOqDl7ykxmc
         aGJUT7aDzcUpXvsy+eApGI4JQpftYkc0kyXELD/7LwI6UuZ+0Mnp+YY0P0GeYW75S6f4
         7GtHLqkkR/eC1LOVoIbFM16hdNWgn6WgfLpC+q9BWybEOUBLrSnO/nPY6GkuXKLuVQqI
         9cyWSvLVV+fwge7PTUqp56jk87O1PTj8FJIYi5ZQRm5uJ4us3Vp1nMZtKS0jOuRR2oz8
         0+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922648; x=1788527448;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=D9vn94z6fRxQMjXUuhba8xPlc8Nhl/43jHnKAHyxeqo=;
        b=OsN7phTWgHlp3Q6faiErDofvUHZC56iOqhtg6Y8l2PR86Ae4Lcm854V1hNu9xOkxXz
         jMNLaAsHAh0Up6KVAyHqamkuCK1HLs2JnTq+QNFSG+W9/3zGDwOc2tyWMJSziOCaXQMY
         7rKRp0N9Is+riXD39/Xrl5K+pZUBO01GmVF9o48sb7xhUcnVaEun7yecPcyRSWxm1r9b
         fVkz+M9513kIaNQCD3r6RT2XoHjbkH0HRHPU1imbj0Iv3CtXeSXEiHMGdtlAIYaawEZB
         jx6eyYItGeziIghWiKdwMqq7JU+GQpdNb+256ugYd4TLC8/XzXfotQaW5G8RRBfCEDH4
         +ydQ==
X-Gm-Message-State: AFuF++lzMNivz8xQIpYfANKbS4y1DNZgZeVmju8POg5SFLm8V7IP7zzn
	kg1E1mGnlvSdEIxKD/y3pNj1CZ/jcxSCki2IaL8eym+EOciURgi2+Ju7hW2MbIRm0g==
X-Gm-Gg: AR+sD10K+7+dyM1FU++YhjAAhUzU9PmCgeaKvgl2/kKpB8QwdaqdUqvB920V57pACc4
	O1Ow0CMB81mroy04os45BcClwG0EhT2nYL03DfPt6f331mEr8oxTeZnCWa1HCxUxPjYn9I7h4bS
	gE8DtdeOfBvcfFut9S9XVDTNHKrZ/jzKY22OG5kBzNvlpI21/CkEo1KN9yWaFsOpwL9j5uCAWIh
	XQUP4LHkQnPrUmL3lqWHqTA6wGaCuyQhvzj8riAITjCQs087lnRMxt8YuL4jeLiXAr+jBNM4nUc
	GShEmrNddrAJ7bPbpsUgHBpj2Ecp18N2dkWVhw65rrbJr+KgF23uJMjJHdcv8ULRsJEhF+doH2X
	Hqcxu3e7+N2mArMRMUgKhQtXXSsq3PzCoRW27hvJ8384ZQJ9PBx8tqXlOm10VOz4ne/6+9Tbwmk
	qpsmfF9ZJf4hnLA9PooJ0Au5/54xZq7zwCn4ksBZPode2Ut9wcYH8cPT5MCElomFttYjIa
X-Received: by 2002:a05:600c:8106:b0:49b:9161:db26 with SMTP id 5b1f17b1804b1-49b91c5554bmr101629195e9.14.1787922647567;
        Fri, 28 Aug 2026 06:10:47 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9500c80asm56510265e9.9.2026.08.28.06.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 06:10:46 -0700 (PDT)
From: Michal Gorlas <michal.gorlas@9elements.com>
Date: Fri, 28 Aug 2026 15:10:27 +0200
Subject: [PATCH v3] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is supported
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-l1-conditional-imx-v3-1-6fbba62164d9@9elements.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NywrCMBBFf0WyNpJJTR+u/A9xkaZTO9KHJLFUS
 v/dpCKIdHnh3HNm5tASOnbazcziSI6GPoxkv2Om0f0NOVVhMylkKjJIeAvcDH1FPoC65dRN3Mi
 yrqTQKHLFwvFhsaZplV6un+2e5R2Nj6ZINOT8YF9rdYTIfQPFVmAEDlwrpVVWgDJpfi6wxQ577
 w5m6FiMjPJHk8CmRgZNKiBFLOCYl/JfsyzLG+PCBvIRAQAA
X-Change-ID: 20260713-l1-conditional-imx-c2bfd20ae085
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3353;
 i=michal.gorlas@9elements.com; h=from:subject:message-id;
 bh=iFjL9XI9CHMHdv0QincBDDMEbFGBO5icuMXCstbvhdQ=;
 b=owEBbQKS/ZANAwAKAWKaksyA3pPLAcsmYgBqkYjTmIJt8HzaDIwWBTuzO0XYQLVdHphGqgd9t
 Ozgk/OH9HiJAjMEAAEKAB0WIQTgoC0bQQLz7jVH2W9impLMgN6TywUCapGI0wAKCRBimpLMgN6T
 y9lAD/9Dpcx4rPTWIi/H3T+yE1CkO3UrBGGil0YZcJK6Nwmj5nficiQ2wPGBFmYcq5o3O18dOrj
 g45HsYt22VGBm/SZttLS5SZE4Uum5hB0fl4nLEb+0YII3xG5CUfWZOoKS2+5/vOT9ifd6NS+8mo
 fkvMprL8gXyydiPFz1egwgG2MTKlLrVzgsdMZqNxB5+FFcpVOBb25NHijfYQKJAdmf8NSy2oOme
 AShDxz3D8et5fE4nbWbw1TnAIFzaQJ9W2toAusfgFVs7UP4luI7nchOOKZMxDlCJxtYpdCM1l7w
 27lExhbVWpxcGxgha4JKvc3dhc3ZtJFSAYPnjhZyQkDZZXjDlmINs1+zdrJKttfENCUuO8Hp3N9
 nnHCBcvVDSoFRcHyMfpxQ7fbCL9BX7Rc0TGgEmOjfpOo/x/fdnGgyP+Yst8k/s7pREkYW7kuDLe
 xzrMrpCAQZ77ObhdrrNdzCQk3X4K+/LA0DeWhqY6Xx8+47gT5dhR9r3LdF0DwCzrPgGS+Q5wU6I
 KbXSiPeptwyiNId8PSIwsoXI8Wg5NobJkh+7BhjaZz26fTznFtYbbHUEttjdGhSGP4PWU4RP29S
 ypzhaVjUk98wp/0mbjFBz2vbvDTLo35xAebud6sOsNouJE79S92U/t6NWA9dEmTaLq1AgzOG05f
 x7dsOOE2HhA/VKQ==
X-Developer-Key: i=michal.gorlas@9elements.com; a=openpgp;
 fpr=B4EB74EA41969D1140A4D1791596726986433F8C

Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
states for devicetree platforms"), ASPM states are force enabled
on all devicetree platforms. This causes PCI devices on some i.MX SoCs
(for e.g. i.MX 8M Plus Kontron SMARC eval carrier) to enter L1 even
though CLKREQ# is not supported (and consequently supports-clkreq is
not set in pcie controller node of their DT), which causes the device to
never wake up from L1.

Hence, disable L1 capability in the LNKCAP register if supports-clkreq
is not set in the DT explicitly. For devices that set
IMX_PCIE_FLAG_BROKEN_SUSPEND, disable L1 on resume as well, as these
skip imx_pcie_host_init().

Note, the logic here is very similar to 613f3255a35a, only difference
is that leaving L0s enabled does not cause issues (at least
I never encountered them myself when testing on the device) as its
not dependent on CLKREQ# being physically there.
Since there is already a way of specifying its presence in the DT,
the driver should be aware and disable L1.

Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>
Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- pick up the reviewed-by tag
- Link to v2: https://patch.msgid.link/20260827-l1-conditional-imx-v2-1-40b324aa2a94@9elements.com

Changes in v2:
- disable L1 unconditionally on resume for platforms advertising
IMX_PCIE_FLAG_BROKEN_SUSPEND (Sashiko)
- typos in the commit message
- Link to v1: https://patch.msgid.link/20260719-l1-conditional-imx-v1-1-a55a57915c68@9elements.com
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 98e1db751132..1fdcbcd2422e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1318,6 +1318,22 @@ static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
 	}
 }
 
+static void imx_pcie_disable_l1(struct dw_pcie *pci)
+{
+	u32 val;
+	u8 offset;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+	val &= ~PCI_EXP_LNKCAP_ASPM_L1;
+	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1442,6 +1458,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 
 	imx_setup_phy_mpll(imx_pcie);
 
+	if (!imx_pcie->supports_clkreq)
+		imx_pcie_disable_l1(pci);
+
 	return 0;
 
 err_phy_off:
@@ -1748,6 +1767,7 @@ static int imx_pcie_resume_noirq(struct device *dev)
 			return ret;
 		imx_pcie_deassert_core_reset(imx_pcie);
 		imx_pcie_assert_perst(imx_pcie, false);
+		imx_pcie_disable_l1(imx_pcie->pci);
 
 		/*
 		 * Using PCIE_TEST_PD seems to disable MSI and powers down the

---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260713-l1-conditional-imx-c2bfd20ae085

Best regards,
--  
Michal Gorlas <michal.gorlas@9elements.com>

