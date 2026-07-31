Received: from mail-ej2-f3.google.com (mail-ej2-f3.google.com [74.125.228.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2C221D96
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505515; cv=none; b=dSmm7uKI/3NP2nuv1FVvArOVD6jb7RfMtf8y0UN1FMwGOqW96TvWrHH25SsTE9QLB05Npe+lUcTXj0O5yqVVMfwDQ8HxkGUOs9VO5vCEb5ifHzkO1pYfw7T/gn9niQbpNcFLKFkpyQJCV3nsfxcqNROi5omPDfMIdts4l+xlFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505515; c=relaxed/simple;
	bh=xwQHtsrljpLUNJTTWYKrxa5N2l9IwyucZA1Mt1aK1Dg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aVxmDjitnN9XE0WZbtxHaBFbaIEsH8y1p78jq8xkSzlOlCF/WFe+okqUKWO5nBGMLgKj+fYks80jpx7hYGervPwF1vViIdBvq1Pnf7hP8nz9bQfTYMvpEtZ41CbaY6uU3l0EBX/1Aj6XRb8hZoPemlloVS2raNNCt084bBIkXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Or0JBsG3; arc=none smtp.client-ip=74.125.228.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Or0JBsG3"
Received: by mail-ej2-f3.google.com with SMTP id a640c23a62f3a-c160e831693so30156166b.1
        for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785505510; x=1786110310; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tbqtOFs9zlL8i8nLzqSqayZV4ABdonTOL9PAP1vFtvs=;
        b=Or0JBsG3Hncb9F6TnagxsPxswLQxeaIBbP5Y9jYCvNYM1PdVkctvDxvTJtEJKKZWUV
         lYWZrEzo3RAimAcnFRKC8xb/nxtjLWTtjrGmZQFlf3q9Wc1KBvr4Zv813lZxnkE+reBN
         uXv+KtyOVWfdaELgFxR5o/PrAecnwnV1gOGl9TTRxnW+23GMeaQtG4QJajyIKzZOutcd
         ww8whVLkgjFleFGUA+rNAnj8xsYXXc9sNGgWUW7DE5N+yLtPcs6iea5SRPOgfaCiNnbI
         7gRZQCBJMe2alCCF9E4u24qZapE1nlW78yoae28JALrp0Qq9HBqK345iyFY4OBFM4Q3n
         Q+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785505510; x=1786110310;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tbqtOFs9zlL8i8nLzqSqayZV4ABdonTOL9PAP1vFtvs=;
        b=szWkUXGdrbfUFjL61toxDj6aeEJrBK8Z5iHpL3qMeOEwjqLRqFaJ574CuwGYu9DlzC
         /1hhKksFZtyW15yj4rWh4XDv9WPiuOYE+06bYLGWlx+o+8XEC8rgh0xh+XHQDvzj4XDw
         u92D7IiQoft7mEQJKGPC7yyh5T6yNtY9LxmhTJrp0S1sy0YPhdmpqbt2UCfcnWxh3Jp8
         DF/w2+zV99KbXMUM0OzkxOjnMDyzhYZarXmL65PMGj2MuCKiXEyoPtbpTnl1u0HupotU
         bpirw4tcqNLB1Soq242ep+cnkpYiA0MR0so6rUybu8J/TQl8y7GR55+hSHXpkQNWsuqw
         Z0yw==
X-Gm-Message-State: AOJu0Ywkr9ctnZ9GEXMkSpQE0ZBp1HPeMpSJabmlEdiKalZcmVQI6ENd
	O5nDuk68UecPni6NTC8ib1mDRrWHPm48mm0pKzXYioi8A7JF/ytM9BM6nxn2YetSRQ==
X-Gm-Gg: AR+sD12FWK+h0FcIX7anY8PF7MwvcXJQZNCHk1tLHSzZGKneD6PwGTAd8IINCTgKkmV
	8xCTajDCgKWxFhd0pupP61H1aR4HIUKQfVNbjcTtHTk9gJ/6VCDYoEwYiprsEByCOCtpOax1l6l
	jJhifj1vU9ntvzb85qal2a4lrvb1fDzTZQvmdMSECLAnzl1mDfQwWHuih+oNCVe7dK/d7Hw5zE7
	WinzcZFpcfSjXRlJEGU1/zip+BpDJhsGgi6WrMTp863EjqNEjNyK6aN0COzf4HZhb3eVqk9/Kov
	JXxWc16sfd2WTSRCmz9Z3SILA780c5qjWd0mfkjMUyFnTEH60lnUlBnb4DTzPV/39Dgc3Vw9Y9n
	I2qTNOw/0UCD5YPm7yY32AMyIvtp2YieJ1hUPL41F2wcCom/MIQmuOestt8srL1PUvq449shTD3
	rwQWPuLcY4rj7QpfhngiN4c9xNADVXURBMbbPIzlvl46huqW8LrV4r8XKU8fLxQRzeJKck
X-Received: by 2002:a17:907:9621:b0:c11:efec:6ca9 with SMTP id a640c23a62f3a-c1fd200e918mr139538366b.8.1785505509645;
        Fri, 31 Jul 2026 06:45:09 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c63d9aesm2059189a12.19.2026.07.31.06.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 06:45:09 -0700 (PDT)
From: Michal Gorlas <michal.gorlas@9elements.com>
Date: Fri, 31 Jul 2026 15:44:56 +0200
Subject: [PATCH v2] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is supported
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-l1-conditional-imx-v2-1-6016ee9148b2@9elements.com>
X-B4-Tracking: v=1; b=H4sIANimbGoC/22Nyw6CMBBFf4V07Zi2pjxc+R+GRSmDjIGWtJVgC
 P9uwbhzeZJz71lZQE8Y2DVbmceZAjmbQJ4yZnptHwjUJmaSy5wX4gKDAONsSzGJegAaFzCy6Vr
 JNfJSsTScPHa0HKf3+svh1TzRxP1pN3oK0fn3UZ3F7v0C1b/ALECAVkqrohLK5OWtwgFHtDGcj
 RtZvW3bB3cEs5zKAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3162;
 i=michal.gorlas@9elements.com; h=from:subject:message-id;
 bh=xwQHtsrljpLUNJTTWYKrxa5N2l9IwyucZA1Mt1aK1Dg=;
 b=owEBbQKS/ZANAwAKAWKaksyA3pPLAcsmYgBqbKbhd6STa3KbItAP4bOK6R6qv/8owrUVZ79/l
 eT+DTQOAE+JAjMEAAEKAB0WIQTgoC0bQQLz7jVH2W9impLMgN6TywUCamym4QAKCRBimpLMgN6T
 y8Z2EACdH7Z5EH7boQzskJW/YN42hEYIIeBVjKVlmUM5wxvYFMpm1VAa/kUE6COvGUX/shm1MrD
 Pl12ztVFe+ywQbXWGHaWc98cSB2najzZbS6/Q7A+4fDw3g/KX7bpwK8RxTSO37ksnzWs3zGIWFv
 wjKqY0831tZ8ZRCgFrWVCTnX+TVA+/yvocB48PPfdMvaHXrjHAwBFUbGFh1VSwofLjjy88EFzdR
 wQJ8BmXNfwmoX13f59mp3qCv8Q2xjD7kyOsIl4roIIFAf/Ti21EV/BtvtB56IaSMXF891Vdmk2N
 4rk+MYeJjsSMSjv9pwCsQO1c8bIP0P/+r7p8PFbWFZK7HkXkz9dTb9kkVhSqI3+APUHdHHq3TlR
 xX1wPGRByfHAEpueR6jogS0qiap0fwyTi6XocSUOLd0YF/ZjewO2tDR/TU396bXdfgg+JIThOik
 qiZ+S/pCBBrXGPjAS50z0moC/+lJ0M4eNPvAhljCXAgFnWXC3tZVh0vdi3uFAxz+quixD+JmG/Z
 6nY+402vHF9tq9AggXeomWSpPMQyfHMhZPmrGsg+2cDcsynUWomq++EoC+flKa2bodLXY1Ta/xJ
 mOyIX8FwVfEOj/CjJ6mPY//v1+2e8X1sPiwSyvlZLEbETs35Ph/iOgNCA42D9oMkSe1DxJuLsem
 lRJ0Aw80WCRfWLA==
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
---
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

