Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB7B43E9F4
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134416; cv=none; b=KcLVdDQgoqvhfPJJY5BWQWsXrceITOK2TECFDzQPSGf7SkWxBnaicELU+FAFQQcJpytyH8L9gHs/6ZRKbR2qMMTWD3Y9g2ZWz+ZPz92YEHYoWWT1pB1NxkyQxfvhcP6LjHcZKUMVP9cretp+tY5IZErATrjwZSAYYkfuMJH0bQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134416; c=relaxed/simple;
	bh=QBdzYysaaQkUcvRADn2zPVz9rZjaIa7yreyOYyJaWT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwDSmHnB3c/dyaw1CWVmWMJxgZhNl9SM4o+y9MG5wqz5XHDebJTsxdez4PeomVcE1EFu27YebadxAvuj902LEnz9Z4/6+p3p0EosrdHRlKVyBvLwD8pSGKDyvuaZwq+9F3Ofe0lipaS4qSj1fDNSaZVRmO481C2aEi77/ND/7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hBNinlZf; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hBNinlZf"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-823c56765fdso6285805b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 02:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773134414; x=1773739214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hRZKxmDkekxeTijUMv0DHtFKCuWghYPEZ/UxQrV0i0=;
        b=hBNinlZfz5/Ao5mSaRXBGBzRgPjfWNKYH89I75APg7w+1gmJzipZBItBz3g1JWBtqO
         vP/q1XZPZL9E7Nrgs7kQ/qg8Dcsf4rgBX6sau1c/x2EZgo17hhJtmUah92p+LjPEPYLL
         BaGGrCyEYyyjZXqgSuOIXZs4s5fjfFEbkfZmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134414; x=1773739214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7hRZKxmDkekxeTijUMv0DHtFKCuWghYPEZ/UxQrV0i0=;
        b=gtN5hstPg1NKSj37tlPUKhgRRgE6uWZ7SgAj2ARLHv58Jw7+0dWCflWzlFBFr8yCFd
         yYd70FUhTfFpE3cXcybeQ4gQSLFSgxujwddQDdMrgnScX6zzIGai3qV8BdTAVHk4ILPL
         /S2G/6TLfDR+Npg+1ZD+YNixN2I4tZHZ4xxjwggQT95G+nQSSRKOLOZDo1QjuJGFLX6P
         a2tb4b1sQsrVmqZE8JG5tll+89TM3s5RZF9xedRzdMgJZL+/RwvvRume1kzMIuZdiy9V
         RG7rjoLhP2TpmFq1ATIf4py7iBGA9ifpmhMLnN+e76zKh88ZBXaDdoPxWgyMghCRxLLv
         imjw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ6cjmtQdzSjsm1Fy2e5IuBHm0mv/LpkIJEtj9EyT54+6d4zboH5agQ3yOkh0ha/T6v3UbkRchBac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXNYOfjmBSqjQbKob20ZXYNY+lIXvOYEcCy3F+icJO0Z8/612
	iyogPmJSJ+J/YoZz6M6g7dpPWmJIBd9Os7q1eGb9NCqm7Ou3KI5CLI5a4osdeeQrhQ==
X-Gm-Gg: ATEYQzyQbGenKbacxQyCF0Rbd4q1zg98UH9wRXOiSoJ8drWm432rYMB86zpZh2+3ajB
	TfhL7YTo/Zgqqus08tCSGbzd+I4FELFRRZ/f0oQ6Baysw18BSyXBP0vTalz32SBCbYfROF8YsYw
	Cx8pdzpCdK0LZtchkPBffoFAHAUjYInHa7H6HQQKgC3w190tFt38HjmLDfJjcuZFs0A9QSHophe
	vc9CL2xdQrc7bV0eHFRcmnWZIkReTuwML3qJMOK/PFUiPBVSXefoGNRk7MNF1EmcmtF1AbcYCM4
	sgOGvkMw45XsSmfaEfjOzXhOVU1sfwy4/M1JDkfmHKOJcyeYZKa++OfbPzBq/BkdgS1ek19H18Q
	1jBZme86z8ru9ppAocn6g+HHnssX2ARXmzRf4qPSsXyeeK8xYrSZXx68hA5Huf4FGg0cV3pUfw+
	kvgSNthZhq0L/xM6Z5geSxV4JkvCIKFmzC9sxIbJpFxpQbPX/EcJtNgKJeYrUOjlhRrCJprFYlh
	Q5dx5O0
X-Received: by 2002:a05:6a00:13a4:b0:827:32d7:6690 with SMTP id d2e1a72fcca58-829a2d88478mr12094733b3a.13.1773134413720;
        Tue, 10 Mar 2026 02:20:13 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:ee38:e01e:e888:6900])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48a3b74sm16965190b3a.45.2026.03.10.02.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:20:13 -0700 (PDT)
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
Subject: [PATCH v4 6/7] PCI: mediatek-gen3: Disable device if further setup fails
Date: Tue, 10 Mar 2026 17:19:45 +0800
Message-ID: <20260310091947.2742004-7-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260310091947.2742004-1-wenst@chromium.org>
References: <20260310091947.2742004-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If further setup fails after the device is powered on and link training
succeeds, we want to place the device back in a quiescence state to
avoid unintended activity and save power. This also helps with power
state tracking and balancing once pwrctrl API is integrated.

Power down the device in the error paths of mtk_pcie_startup_port() and
mtk_pcie_probe().

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- Adapted to movement of existing setup code
  - Cleanup in mtk_pcie_setup() moved to mtk_pcie_probe()
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 3e5386c4cb35..f1a70b92cc9f 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -556,10 +556,14 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		dev_err(pcie->dev,
 			"PCIe link down, current LTSSM state: %s (%#x)\n",
 			ltssm_state, val);
-		return err;
+		goto err_power_down_device;
 	}
 
 	return 0;
+
+err_power_down_device:
+	mtk_pcie_device_power_down(pcie);
+	return err;
 }
 
 #define MTK_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
@@ -1219,6 +1223,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 err_power_down_pcie:
+	mtk_pcie_device_power_down(pcie);
 	mtk_pcie_power_down(pcie);
 err_tear_down_irq:
 	mtk_pcie_irq_teardown(pcie);
-- 
2.53.0.473.g4a7958ca14-goog

