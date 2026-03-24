Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A2242D60
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 05:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774329620; cv=none; b=tZoBcamTZwPwbbSFEqiI2uc3mm1aNsE9KVLtrNeBH9f/mAHjhR6DqOySkEmH/gQfMD95tjAkxIVHIqn1RSKllBjQjUdCCQj7w9YxUB5v5QmZJFwiCSsihxgxBB8+S5CQxZXWwgpTM4e2E5DPGS7+GdzjuUsIA9Xf6gW3C6qm4Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774329620; c=relaxed/simple;
	bh=+ezN/B2ZMUl15YakQPOJzFUOlgdtwdAcENxCtoQ+AHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BO5Mm3OLKK7Gwzf6p9deKIWOGLItp4WSQTmO46i0DKzrhDwlu9l5ncb567vMWCr8gEYdG+jA6osBgPAxQjotapC1tBLKGKamzarAHIfebVBDhCrIiVrmIZ/Fdn/ToPm3S4E5sqfcSvJHQcdDTNfSsGijqBIC+0rlZnNKZZyEASk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nMzSZzL6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nMzSZzL6"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-359fea895b5so585735a91.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 22:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774329618; x=1774934418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O74W4ZMgDpT3MGQ+8wcjX/PqoiKfeKCvLKILcQ8L8Jc=;
        b=nMzSZzL6KctTDmOxd0axnyBeVoFdgAekcU7DOLQjCEZ3T1gkygbymQaW0SackruzZe
         A2nP4zCia/o9NvV7REW7deyysbSCKX2KTEtHZxigJDPa8ICgEBbRXB5B5/uFpfHil7wI
         zgC3a2N2lcnNkGrW9fMAsxbem3H0vmRUcFOmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774329618; x=1774934418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O74W4ZMgDpT3MGQ+8wcjX/PqoiKfeKCvLKILcQ8L8Jc=;
        b=pmMuwbd4JeyzqX842GZvt7PiY4oggb8LoWMUJge2Ecwr54YfM92ngW2eEt3vCb9AZJ
         +ihEj0T6mOlyxcO0B71hYoqKF2cWOCfG0vurrRNEurqzZaByprUUmXntPLDXNMQOMS/E
         kGLlr5Kdt3wWyjDOO1DXkLBaW92bvPg+Howsy0X0rV3YuHHTKxRpQoxWsWCXCtuJPOG2
         myKKE83Pj4PSngCppAcFyGKr+yIpbHYM8OFFJCOtMTEF+PRtIKQfp5BZpSqL7ZbAofMH
         gx6hFIWd4PN0ZKurPlRumg7sz34QkMh1FcBSzbQV0dyAzwp3zcoHZmZ1xlpNKj6zM6V7
         04Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWS2TjaD+Nx4EZxSBypQvnPRXxdlyfKJwttjL4MVwVsAbqea4mIglPgAnio6nO8nXoB37b8zRfnkS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqBqWB5SZedoxAY2quq8AefpdSQame7x2q06uff7Dx6Hn/T6Xo
	02bx6vjLVkhy2gFMDNvPCRxkSuTFIUjJnwT14Ap0r+LWiKEk9UDc+5OA2syQXzl4Hg==
X-Gm-Gg: ATEYQzxQb2Q6Y/bNlQ7KMPmw/rU+ohDz8sXto+sIyTPLOmBJk0Jq5Fn3ExtpaG/2WxR
	hssTTGvGacG0cyHPt1Fa8USo6/OCbOfujs5X2+lZ7h2hb15oVOl4HkU/XKhjz5+Ksy0IBO5xNAh
	s7iCk06a8XDEz67X70GodQeZxlrouXcQDtHpIQDUMcNM7VBmlP+Hd7j4D8URjmL/zX1QEgXWm18
	jY3Zwk6b4PPLKVioFEMbRa6aMEjfuYKvXCBDkiKgTwSUK0h10Hw+AWWMS7HSAFg2ePOywIa6Sel
	3LH51ClAB+CCJtMaizZfpZWwWl8ZYHeeIUjgUesog1GMa4UO3QtTyHz4jw0OKycXjIVMIZ9djO0
	NscDRjXeiaHJ6ds9/dnrGViuwUzAIH5xNMucvgmwn2u+RBXjxjcSECEwOgESrPICQgEGfu5P1aM
	SWNxj3VwHYk83pHlthZXW18+Q2jyRiKgAwx1+OrTNfC0YIWIgfgx7io438ZeQT3SDiBwkDaJ8FN
	SREIk1J
X-Received: by 2002:a17:90b:4c8e:b0:34c:fe57:2793 with SMTP id 98e67ed59e1d1-35bd2cec778mr11788613a91.20.1774329618496;
        Mon, 23 Mar 2026 22:20:18 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:19a5:8f2f:d584:8078])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03124a87sm1068647a91.3.2026.03.23.22.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 22:20:18 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v6 2/7] PCI: mediatek-gen3: Move mtk_pcie_setup_irq() out of mtk_pcie_setup()
Date: Tue, 24 Mar 2026 13:19:54 +0800
Message-ID: <20260324052002.4072430-3-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
In-Reply-To: <20260324052002.4072430-1-wenst@chromium.org>
References: <20260324052002.4072430-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_pcie_setup_irq() just sets up the IRQ domains for PCI INTx and MSI,
and chains them to the controller's interrupt. It's not really related
to the setup of the actual PCIe controller.

Move the mtk_pcie_setup_irq() call out of and before mtk_pcie_setup(),
and add a proper error message for when it fails. Reorder
mtk_pcie_irq_teardown() in the remove callback to follow. Also create
an error path in the probe function.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Link: https://lore.kernel.org/all/20260309215056.GA603013@bhelgaas/
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 25 ++++++++++++---------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 1939cac995b5..04ae195d36c2 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1152,10 +1152,6 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 	if (err)
 		goto err_setup;
 
-	err = mtk_pcie_setup_irq(pcie);
-	if (err)
-		goto err_setup;
-
 	return 0;
 
 err_setup:
@@ -1181,21 +1177,28 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	pcie->soc = device_get_match_data(dev);
 	platform_set_drvdata(pdev, pcie);
 
+	err = mtk_pcie_setup_irq(pcie);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to setup IRQ domains\n");
+
 	err = mtk_pcie_setup(pcie);
 	if (err)
-		return err;
+		goto err_tear_down_irq;
 
 	host->ops = &mtk_pcie_ops;
 	host->sysdata = pcie;
 
 	err = pci_host_probe(host);
-	if (err) {
-		mtk_pcie_irq_teardown(pcie);
-		mtk_pcie_power_down(pcie);
-		return err;
-	}
+	if (err)
+		goto err_power_down_pcie;
 
 	return 0;
+
+err_power_down_pcie:
+	mtk_pcie_power_down(pcie);
+err_tear_down_irq:
+	mtk_pcie_irq_teardown(pcie);
+	return err;
 }
 
 static void mtk_pcie_remove(struct platform_device *pdev)
@@ -1208,8 +1211,8 @@ static void mtk_pcie_remove(struct platform_device *pdev)
 	pci_remove_root_bus(host->bus);
 	pci_unlock_rescan_remove();
 
-	mtk_pcie_irq_teardown(pcie);
 	mtk_pcie_power_down(pcie);
+	mtk_pcie_irq_teardown(pcie);
 }
 
 static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
-- 
2.53.0.983.g0bb29b3bc5-goog

