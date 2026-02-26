Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794472E0B58
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092019; cv=none; b=swTWAoPMIX0PiJUbJc51BO89ZrZyzOSylSYsxFchbm8tWl2tTz9DuxItcWF1q67RFFobS2ore+n54e1N8ILdBWmqs812JnpP0xEroAJEYC8xnlYuC/yzlDIaU5hYkMWhYcE8ydtBTmyUtz9R3FxbCJx0vxOs5wUuxux94vAsWBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092019; c=relaxed/simple;
	bh=ox8NATtkYE0tkr9tJOefc2pJWXV/3MDxkq2VG6zVd7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asyfi7FpwSa2YnkozL5pLNzU+eZHYiGP0VZ7uG/Y8fP0TKNspWnFfwiYea9k5ClAT6bx0ux+WAVnFOEsK6camGTTsRFyeH8WJHI4lO0ch7KKlZ4KqwkuRv2hDCCJ9gB605XGuy5fAw4KFOyBGfT+9evFlVyyCH7ZUJiBY3yB8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lXqmsY0a; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lXqmsY0a"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2addb31945aso3834295ad.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772092017; x=1772696817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNr9GUXcZ2JMX/g86l+sUCt0HEQieC19OqXNz4Aux8Q=;
        b=lXqmsY0aNSKUSH0LgSbLRWI7GOvyxo6wk3VbW5h9+/YSxAgmyK2kv149x9bMk8pEH5
         agp5rJpnsGfWSye/IOhj+j4s0KvtcomRaK+oFyAbcefugUzWNkEVK1lPNfWBlaYSbRKf
         Vb8opiLooY2OjuoHGoe5z51ZAhe2wZrqtV6JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772092017; x=1772696817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rNr9GUXcZ2JMX/g86l+sUCt0HEQieC19OqXNz4Aux8Q=;
        b=g3qEBYbswFs3Qd6orB7rKjKRhh5xGmaBuqIcY7D0WzSRmaBEOhQrtpquXyba65h/0H
         lKlefkidmjbAHkgRrxPNNF+a1L42XLuQ5GZb0nPGJAsjWu4aWqqd6rcLhKvhGFhiZJe2
         ImRvCu7cnwgBB6Rnb/HJkPzjpHZ5oY0uZzNOEcJKZ175VEolqOju6WYEcpq9IC5oAQpk
         ZGQ1NiqV7H4Y7eGiQ+VbEAgxsw/c+yv/ZB//lVShLFI86AvKVrbofBHu1okicLXMz3+4
         J6s4sCjuz3uqSqsCmDPxlQvCx0GSpAAyFI8g5wQdOpEr1YHdQjgeub1I2qqighLYovLG
         BLGg==
X-Forwarded-Encrypted: i=1; AJvYcCXYoWpd54HXOccy0GkWr4DYTygAOf5wwe31lDnhlASeyhuxJp8v/dSMjCuST3d3yql/Kw/AhSsUrpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKyzwvOUXvd+HYFQA2IHvODOaaqSdSE+pZdNuin4oG8ZYthrcH
	o5v3qe+N3og4C0UIx6Ty15ltyNGd7+WpM6DO+SelWx2HAPfsRv5tVwgPxbnK54u0qg==
X-Gm-Gg: ATEYQzw4Sar3V1lNlgOR3kbPRX1lFcf45OGA7GTvXSFl+nDjKkcjb91eem2B6o75mEp
	iQuow1Wwysm9ZKCgUf4YWoUu/Xo2ek8npg1TShlWJd99Ti3jGcb2Bi/IJZjTRhfHIA/cbrjG8Q3
	jo/nPBlt+HOkH+5AcWxr5AJMUQTgJ++zJN58i1iHFLR7hoR2Sk40QV34ts+hx3sFx7ubmGHq+uE
	HfG7gHsUL7X0I/h19UpgA30ngbRPCR/J0tV1QpbkZXPZktf65U3GYchgEy9zPvs8NH6ISAb1DbM
	iPUXtiVDFHz9DULfFj3WdUjFY3nLRxh4gAhBxySTx1Jn1qn+CnKVqd+fDVFrrAsqT+CZ7RIidDL
	eV/pE64QjRqEDUOaLMeXgmdwtfdmv4S69ZSY/YCUUsMZdVUbRPcU4V0s0R6eoK++1718fJlol2W
	bYshVY+0w11hZ4kXFqMnAt12TLp3jJ0FfVzESMMCHt+etkbY9FrZMY3WXzf8nrhRj/nKCFR1psg
	8Kti31tl/0x0I8zWIA=
X-Received: by 2002:a17:903:1a8f:b0:2aa:e0d3:cad7 with SMTP id d9443c01a7336-2ad744dfa4cmr164499035ad.27.1772092016979;
        Wed, 25 Feb 2026 23:46:56 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bf01:7f64:477a:2f97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b22f3sm15238245ad.12.2026.02.25.23.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:46:56 -0800 (PST)
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
Subject: [PATCH v2 2/7] PCI: mediatek-gen3: Add error path for probe and resume driver callbacks
Date: Thu, 26 Feb 2026 15:45:18 +0800
Message-ID: <20260226074524.3808081-3-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260226074524.3808081-1-wenst@chromium.org>
References: <20260226074524.3808081-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe and resume callbacks currently do teardown in the conditional
block directly. This is going to get ugly when the pwrctrl calls are
added.

Move the teardown to proper error cleanup paths.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 22 ++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 1939cac995b5..f2bf4afbdc2f 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1189,13 +1189,15 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	host->sysdata = pcie;
 
 	err = pci_host_probe(host);
-	if (err) {
-		mtk_pcie_irq_teardown(pcie);
-		mtk_pcie_power_down(pcie);
-		return err;
-	}
+	if (err)
+		goto err_teardown_irq_and_power_down;
 
 	return 0;
+
+err_teardown_irq_and_power_down:
+	mtk_pcie_irq_teardown(pcie);
+	mtk_pcie_power_down(pcie);
+	return err;
 }
 
 static void mtk_pcie_remove(struct platform_device *pdev)
@@ -1301,14 +1303,16 @@ static int mtk_pcie_resume_noirq(struct device *dev)
 		return err;
 
 	err = mtk_pcie_startup_port(pcie);
-	if (err) {
-		mtk_pcie_power_down(pcie);
-		return err;
-	}
+	if (err)
+		goto err_power_down;
 
 	mtk_pcie_irq_restore(pcie);
 
 	return 0;
+
+err_power_down:
+	mtk_pcie_power_down(pcie);
+	return err;
 }
 
 static const struct dev_pm_ops mtk_pcie_pm_ops = {
-- 
2.53.0.414.gf7e9f6c205-goog

