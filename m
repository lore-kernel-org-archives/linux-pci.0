Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006E92628D
	for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2026 00:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784422098; cv=none; b=bxdda9vtu5oGltbdjo2uTULVUJ/I7Y+Ji7QVADs/jsVOLLPLQMLY+LjN/QFqPtN4cNmju+eVB4RQPVx5WAC9Dq0Bakhl2H6JQQP5J0SXmu98+xpSBoXJvJQvaaqRxkvgb17lEBH7VX4sOqGKXRk39U2s+j1/lUN2n+BdrWpR1bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784422098; c=relaxed/simple;
	bh=8Dy6qNmKS8/8LS04fDzhefwfpJnXc37CXJeUp6zA7iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C1BR/4/T83WCT//pOEKyr/ZIq32IJ1oZTZVGqwavWqIKKSFWMLAj42eazD9jOYlpsCDIGvhTUtCI3kKytXPwPKJT7Q8uFQPOZgy/oDYGVJXoFbpxEFM4JQad9KUcGatPFYuw6dUPRQl8HhH80n2/qz/dpo93hTIV3psf4Ye6NOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=ApTVS9wz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="ApTVS9wz"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15d111ca99so927337966b.0
        for <linux-pci@vger.kernel.org>; Sat, 18 Jul 2026 17:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784422095; x=1785026895; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7EWwsWIADyuXSEEcPix4PovWy/AjCSESwW0LVKRsciM=;
        b=ApTVS9wzOHZmt8yS3StYK3/JS2C29oVpBqEoaGxQ6kRb2QE5zdyvIr7yLX+lx1MqF8
         tQ0O8rJt5Gs/xT98UafncrUM6vMRqE/yvH7tfDFPWKh93V8gvvLXM4I5lryAZ1bWII9a
         M4NnOdxshPs/ablMPpXRRb9Mt7dipU/yJPQXezHgG6sSyxz7zP8knjr/ayGFaBBvdKNl
         fTTpt6IVGXDai5PuargD/TbI2ox4AiLg0Vp40jnXjDXgxBYOiER0rvkPj+c/mGlAAggn
         mPdJLuxI6sIDC+r0P8Q7K51UX3FsgmCrbEqnLHlIGb9sdSzbEBcHZjw8w1qjQSOSijGb
         OtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784422095; x=1785026895;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7EWwsWIADyuXSEEcPix4PovWy/AjCSESwW0LVKRsciM=;
        b=Uyw+VAEOAjcssXqQrLnVpeYQXTmAZoP4MckXC6t3JXJnRX42JoImqvNhNBv/gIKtiv
         h4UeNC7n7zWzt9grdvIZV03LfE5x3avgTp0bUNfLajG99lBEDyXpNpwYVFxPE2igswJr
         RRSStl9q55QlnTbE+9McPdjkFU2Q9g3qHz2ydljeXiyITQuXXcPR6D2TdWSZTBwFqzpp
         RwwBsuS8g3xGuS8YrFmhCCEPxo0cGgMOFQ9KaBkin48bibHkhIsZvQNn2ZV5HHKh8NO9
         fxry0bzykbVUS3yPKPTADdZ6PxDx7e5o3OYhhgvApPqk43MmKMDfTWgtiitLqidUyFTS
         fq1g==
X-Gm-Message-State: AOJu0Yy7ihy4IiF30ZL0zSsB49YFjwbzL9VWnnjNpnO8bHmrCbSUDZiD
	sjFaKFcYm2KPvpEIvRMosOn+AIn++krklYEdg8xIooxugKtpegyEGdlaBIJg1Ii7TWR5d1hwHlS
	iKOxj5bR5ugJiew==
X-Gm-Gg: AfdE7ckXMcNBH9/Z00M7Ao1NGiwmF4yJL4PPfzfOQkiUEG7Men1yO5vcnXFe7mLuSu7
	IqvrQajVqDVIEKehh1b7x9wFSP+KpnFvHZQN0g4oqodgYE6o5yLN2iYdpqXSVGbp/KZ2yQ//iDB
	32Lxc2ngeTPnGT1h1tRIhuLwirRcLyON+LoDlYGoLDaQlhfIyflx9+rfva78RrH+IouXd7XxzK1
	HbwHqwDlQWTQRCgsxgcjzolWSnjiwO6TZjUcikwvziwVk17nVc18nsPSb3pTqvYrjVY+XdfNyOW
	wf/KKBGR7ulAr9kJEwcqR9NYmQ/8+CthsHSOAyA9eOWqcSnJ5ewmcCAI/ukI+uUu12P9zL2nV+7
	k8v/NHTEsqgZfT3+3VPF+OfVFplPkUVWVC9TN3Pov32YP/58MjnHTLqFnEyRXuoS5Fyd0hQT9qI
	r1xXpLzfLMKBrvRyFZCt6a78E=
X-Received: by 2002:a17:906:9c83:b0:c16:67d8:79e1 with SMTP id a640c23a62f3a-c16b46ab93amr334444066b.7.1784422094905;
        Sat, 18 Jul 2026 17:48:14 -0700 (PDT)
Received: from [127.0.0.2] ([185.213.155.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1712a62e79sm270250066b.30.2026.07.18.17.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 17:48:14 -0700 (PDT)
From: Michal Gorlas <michal.gorlas@9elements.com>
Date: Sun, 19 Jul 2026 02:47:54 +0200
Subject: [PATCH] PCI: imx6: enable ASPM L1 only iff CLKREQ# is supported
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-l1-conditional-imx-v1-1-a55a57915c68@9elements.com>
X-B4-Tracking: v=1; b=H4sIALkeXGoC/yXMywrDIBCF4VcJs86AGnqhr1Ky8DJpp1gtaosgv
 ntsu/zgnL9BpsSU4TI1SPThzDEMyHkCe9fhRshuGJRQR3GSC3qJNgbHZQy1R35WtMpsTglN4ny
 AcXwl2rj+otf17/w2D7LlW4Led1B9dBB2AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2389;
 i=michal.gorlas@9elements.com; h=from:subject:message-id;
 bh=8Dy6qNmKS8/8LS04fDzhefwfpJnXc37CXJeUp6zA7iw=;
 b=owEBbQKS/ZANAwAKAWKaksyA3pPLAcsmYgBqXB7KH3m1ik9qYpuspVJBQkL8K/R/s7ZipXoyz
 NDJmhIbCdOJAjMEAAEKAB0WIQTgoC0bQQLz7jVH2W9impLMgN6TywUCalweygAKCRBimpLMgN6T
 yzUPD/9oPKNRqS9GxYGjqWNGDtsU8QIMyrii7nok9dJ2lQMYAfa13pVUQMpHlvF+jmPWBG+am31
 4qTo/4Wrol4fEBMS4GxoCtc9OcahIcvd3GKR6UBdEm/8uTaAg+ooA8+XZF5JtEEbqvX+zL6hq7U
 v05X5N0vyrVGl5ebf2lQQ1cTzln+ZasaS7NynA9DDQL+nXPbmYX+6hSK3C8sMvMHkJxXswXZAxV
 4hy3Ta7ZNwe/Qp+51ns3A6km+hXSJOZKEy8nwyaLpe4XNzFk5uneFbdzIG+kylbIPPkSDCzUPrG
 9NYvgWVZwAm4ZAPG+pO2UTJvLPrpMfL9KTYKDpd8wQcjZToBQgRA+/x5EFP8qc3oV9PsQ+eF2Zr
 MXCimhOClJGj45c+ACTfP5PY7TmX/hiwk7icuDK4RqAljjYXYSHEGtMSb6FXrNSo4oqDd7VCCwF
 81PHQ4FsYfGVAiDh8pi8XtM/cdZ7JR/rZ7GsTg+VZ4iCBIQJmeanHGaG7kLli6NgZzFqRK4XXrT
 ywrbiSNkIEiA7rtp5kJoPK5k67Rz2qxxMRznl1iJ1VBFJ8aZACeNspLmFN8PnbKawWF6IYaw6q5
 oZj/HelhlljJE+RyAxM8axJqL0Rx5tzM0CIDW95/ywdf5WlEpz5Ca1NbHKmxVXq83LXJAPkdqBL
 Hs/qeMJGbHP+7wQ==
X-Developer-Key: i=michal.gorlas@9elements.com; a=openpgp;
 fpr=B4EB74EA41969D1140A4D1791596726986433F8C

Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
states for devicetree platforms"), ASPM states are force enabled
on all devicetree platforms. This causes PCI devices on some iMX SoCs
(for e.g. iMX 8M Plus Kontron SMARC eval carrier) to enter L1 even
though CLKREQ# is not supported (and consequently supports-clkreq is
not set in pcie controller node of their DT), which causes the device to
never wake up from L1.

Hence, disable L1 capability in the LINKCAP register if supports-clkreq
is not set in the DT explicitly.

Note, the logic here is very similar to 613f3255a35a, only difference
is that leaving L0s enabled does not cause issues (at least
I never encountered them myself when testing on the device) as its
not dependent on CLKREQ# being physically there.
Since there is already a way of specifying its presence in the DT,
the driver should be aware and disable L1.

Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 98e1db751132..7471501fbf04 100644
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

---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260713-l1-conditional-imx-c2bfd20ae085

Best regards,
--  
Michal Gorlas <michal.gorlas@9elements.com>

