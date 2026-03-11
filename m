Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEC434C9AB
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215565; cv=none; b=EAwZOJV0LFh0W35UUpBL7b4pFKluciYJ3Nt1BkDrrDCTkTffzdZRyfbX3+LIW/vX+qiyHQgwHd3CV0E5Qzvri9Re6bU554sPm4bzcm5Q+z5wi89EX4BuSc+i2zC0kiuLsbJ01bQjXbHLlZJASfLIeK1SQ7yZ46gV2t8ZZga5qYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215565; c=relaxed/simple;
	bh=sPilm9ruKuGewnbtA2jeOf/ucQBHTQeO8HOZykuVTW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3Tbas0wR2zTeT9BqvU2bKzKkKt4WDLfE8svARi1Y1CSzmw4TKlSuNfOVEPvNsoHfDAtDuTFQzIxiZUFix1XWLjtu1OY2JCMY8ah8O5Yzs3CTMRiAUwraODf8HUEQ2Cm/QC8yskKZ7pTQfvr8IV0dT5h7bIKB9yMcY7EW7kMNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KUTXKifN; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KUTXKifN"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c73bbdc01b7so974459a12.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 00:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773215561; x=1773820361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+k9XHKdzt+xrme3N3sFqf/9kOYEeHBPbN54N+TXv9c=;
        b=KUTXKifN0EN4MXdtqWurTjBT3qZYN7KpokOCYyjSsToUDlodCiVGllrKATvm/s2CDd
         ZKTisK0kZVpZ7NEkdP5dPH3+Fe7eSOWyOgcXdaTyKXcKCsydokZXk0i3aUg16bSQcC+m
         Ib+zben4FB/frmvJqDa+83ULX6H+h5m4j5y2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215561; x=1773820361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J+k9XHKdzt+xrme3N3sFqf/9kOYEeHBPbN54N+TXv9c=;
        b=RoBbAMhCSqSabNyP62uq4YE2OC8LgeO7AI9j4KxSx2NSJ/WZIWu8ffp9NNX5rionGS
         CvtDuMt1/MvdHGnoGVsw6wfU4mtN1Emq8o9S23zL2fHQdZ9cQuRARX6F+4SIk8oDpHvs
         aw2laUZfLxH9MdQ12Gt05GI2v8YLXWrt38vEzJ7yJVQ5wK11D7q5ie9xMOcb6GrKVRMn
         BJMl8B4lfmMGjikxHX1j5G5VcL4iM8ZB/UO4zlTxTPN7duBs5ZJ9PNY/2R8xcUHkRkP0
         C3I1DkzjS3ic5A8zL5f4X4DDzhlGrKOBPArktnW4RlSEdmgS0Nd3atT2YgnnwxmqaKBH
         6XDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTFOHqGXE9s1d/NU9P6AwAmSpQ9kSZVi7PNbvE8BigJuat7bM2tKvsc/kOIJ/jaHKbW1KAZIC7rYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQKkaL2bqQZJ1C2CLBebZ+ZVTxRLWHmz6N+z8SPc8S9yaRUJ6Z
	JnMBCykXDnCeCSBDY/W1rfvb+RmXKoOXv0yUfKeDPyKyg+2zU/8y5phaRCk/vAMUCw==
X-Gm-Gg: ATEYQzybbjqOwRVLD+gJXtUUmkhG4g16Wjmk9yM0pX/0S9y6WMlqh+xEA2U9IY6bxhX
	ptIxTALIclYAJmHNZbhG11btZRFZ7YyVdHQKdpIeJAdXk/YsllpLeiSBjAG6AEgwvspsBFoQ59J
	wVoEmWzXfJ/Z4jMg1OV7myHI4svRQ3NMuVXdRfuqBrNfDngcaFoHeUZ1EGBl7vwmeNZKRJVP/i+
	kAPw9R8D5MqAVBzIArz5UowjfSI9DGtOBHzl3GLo038tIDGRhtI2PwDfbX7LEHvGAzjsQzrSqvt
	tBx2t7B6RYrmkn0JhR0B6tVKELri+c/RGJ7iDr/d5JekJBnMZjAGXI68b7moUinmLBj5Ao57F2V
	91up0DSMQndF5CLMVa/mgU/6reaw/X9b7V5J6nFbmrHaIgMpfFKB2VAhZHU84EI0pi7YSi9LdKF
	eapFnTM6I7r1biUXgEc0DQrgy0fyeoM8roX2Y0plOQ44EebjuJdlYdZgoBIJ+xz6y63JGaXgA/s
	HCWt+ov
X-Received: by 2002:a17:90b:3d01:b0:340:66f9:381 with SMTP id 98e67ed59e1d1-35a0121613emr1654777a91.10.1773215561374;
        Wed, 11 Mar 2026 00:52:41 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:805b:14e9:f783:bcae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a0236f79asm727816a91.6.2026.03.11.00.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:52:40 -0700 (PDT)
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v5 1/7] PCI: mediatek-gen3: Clean up mtk_pcie_parse_port() with dev_err_probe()
Date: Wed, 11 Mar 2026 15:52:16 +0800
Message-ID: <20260311075223.3303497-2-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260311075223.3303497-1-wenst@chromium.org>
References: <20260311075223.3303497-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_pcie_parse_port() in the pcie-mediatek-gen driver has a bunch of

    if (err) {
        dev_err(dev, "error message\n");
        return err; # or goto
    }

patterns.

Simplify these with dev_err_probe(). The system also gains proper
deferred probe messages that can be seen in

    /sys/kernel/debug/devices_deferred

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes in v5:
- expanded tabs in commit message into spaces for better formatting in
  git log view (Bjorn)
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 36 ++++++---------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 75ddb8bee168..1939cac995b5 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -876,10 +876,8 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 	if (!regs)
 		return -EINVAL;
 	pcie->base = devm_ioremap_resource(dev, regs);
-	if (IS_ERR(pcie->base)) {
-		dev_err(dev, "failed to map register base\n");
-		return PTR_ERR(pcie->base);
-	}
+	if (IS_ERR(pcie->base))
+		return dev_err_probe(dev, PTR_ERR(pcie->base), "failed to map register base\n");
 
 	pcie->reg_base = regs->start;
 
@@ -888,34 +886,20 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 
 	ret = devm_reset_control_bulk_get_optional_shared(dev, num_resets,
 							  pcie->phy_resets);
-	if (ret) {
-		dev_err(dev, "failed to get PHY bulk reset\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get PHY bulk reset\n");
 
 	pcie->mac_reset = devm_reset_control_get_optional_exclusive(dev, "mac");
-	if (IS_ERR(pcie->mac_reset)) {
-		ret = PTR_ERR(pcie->mac_reset);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get MAC reset\n");
-
-		return ret;
-	}
+	if (IS_ERR(pcie->mac_reset))
+		return dev_err_probe(dev, PTR_ERR(pcie->mac_reset), "failed to get MAC reset\n");
 
 	pcie->phy = devm_phy_optional_get(dev, "pcie-phy");
-	if (IS_ERR(pcie->phy)) {
-		ret = PTR_ERR(pcie->phy);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get PHY\n");
-
-		return ret;
-	}
+	if (IS_ERR(pcie->phy))
+		return dev_err_probe(dev, PTR_ERR(pcie->phy), "failed to get PHY\n");
 
 	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
-	if (pcie->num_clks < 0) {
-		dev_err(dev, "failed to get clocks\n");
-		return pcie->num_clks;
-	}
+	if (pcie->num_clks < 0)
+		return dev_err_probe(dev, pcie->num_clks, "failed to get clocks\n");
 
 	ret = of_property_read_u32(dev->of_node, "num-lanes", &num_lanes);
 	if (ret == 0) {
-- 
2.53.0.473.g4a7958ca14-goog

