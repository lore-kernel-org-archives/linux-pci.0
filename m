Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66AF3101D2
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429488; cv=none; b=GlUi75o2d8ebO8rPqorS/kH6hlQi6nWtbQUyx+v8o3wzfR5pO21jHzwezzv9vhoSsxUhVQNqWp2yQ3IFH/EjJl4xHsfBp50zs7WEA5RnLJhj4RDPrAQn+jtJAENQllbUwIE4zq/JrwbvAo3ICScU8xLObtnrS/s8/0YLrv6KHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429488; c=relaxed/simple;
	bh=P2Y4QQxvaOUU75xMq/fkXWByug3Tfi/xVoYZkJnGDHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFhLoF8Ej/Xh0hfZ2g6Wxh47RtPpgCv6aw/QFpYRexGos5PDbalOG5al92Q//LIV2KFUvJe0mZVVYCxXxhhNyVOYleV+VXGNQlSSayY18wifI6xZGEDCK8fVSxDzragE/imqCJ1H3r7jEYgnjm/DnTUK3dVngTDmL3AbVnDevJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RJ8KsLKd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RJ8KsLKd"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad21f437eeso30102455ad.0
        for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 21:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772429483; x=1773034283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnRLakFFOm81oUmP2rKumROQ+VIkSIJ/KocU0Q9JzsU=;
        b=RJ8KsLKdXrNcDAAhhLNWzZHmQ+miun4oGvTFtrGWZ7gHN1aO76/xO+Qv/VV+j87xjR
         8G+25FAESVSSWCQTrWtu/BQ/mCiY3kjxSxpiPKMvY23owjzBgn+B+Gd3SRNN1ciK7/Q8
         fuSSvV1nn9rfmGQM0OQ7LuxF9Ux6NRLyEdFlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772429483; x=1773034283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TnRLakFFOm81oUmP2rKumROQ+VIkSIJ/KocU0Q9JzsU=;
        b=W+XcHlPHGWWpEFOEOpjtZbpNJwe9CzYWNqMm9voruVjsFAkyiSOGuVHGDcRblxoD2x
         Bh5NV6ZjZKdAoZy3Mxj7JM3+A0nTUyqAm8FO8fbs1bDp6xMWLQj6Hg9HUH6dGQ69eCVE
         9xysKPKiH3JKZQ8caWYo84OLDi9RHfd3sa7dRnqBktHuj0mPynXI1klcvz5aLg8M3HUe
         ny2R1I96NvxKsK4uenQxYKhEj5c3/5EYY22MDI1CLKSyXffYZt/T0++gRhAzyxmKknLZ
         Su6mSzSzIZj40cXEMkHPBNoy24nCGjNHUQwvynzH9krgf+Xf4IvTenxUgQEvYZ5Vptk2
         +ccg==
X-Forwarded-Encrypted: i=1; AJvYcCVB1IPu0E53IbXIwEYgJkvRcyCWp+7+jvX/VkS+mpASrWvAjQa/FhJJZl3GVYZxaxYqdFGc5Ne4gSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGyfGRebloPCOXZqfTscKCYc3pNp/a+FPFyOA8MiejXA+YZtpv
	IHoICCUHk/VnYl7Qow/BPPb2Rkef3ixLgmO6VwPPvd0cTDv5qOHIAhHFOy+2mti1yQ==
X-Gm-Gg: ATEYQzwUfvbxwVeP59kSzp4HyxcIlJ6KXlJwlbDljC2ZN/dgFZoA+Pumnh2MrNyboeJ
	qmjj7C7Ky9IOV6JRUGIvxIQVPy1XtKH0xlAPZ7JWvoAdTop+HVkdg50l9S20iJFQHaWxTvhyWmb
	X+mPFlZZuD7agP59gZWKxoT+QjqAbL5ZUT6UxhMddQqSTOEdB/grt5SjR+zqb1sL/KrjJsmLEGo
	+5noHKkYSg1ntgsFKOfp2NR6wBSS5IiU91yBW1L4PBuSwQKS9skjbhsCW7qVTl/DT2lJMdP5Amz
	okeRNxjyzz7HVRRQqpGAUIshP/XIQ9iDrWTzwJxK4BCSEPcLCShfHRass1nsvv5yY/r+IJ3KCZj
	YZYaNyQ8SALTea55tdtYCy/QayKT1E2opP4Xf7vY3/dVrGh5wqPe0hljn8RhsMNN5hY29hW0A6b
	prNQANJA0ba/YOeecqI+P6+/YFIuI4eI1mUNaEbfwa0YBHVxoe4V2BIohgQ9aNp/oaqqjkjMOdX
	oL3Qt9DHp11/wiEoRI=
X-Received: by 2002:a17:903:234c:b0:2a7:80bf:3125 with SMTP id d9443c01a7336-2ae2b8d4c4dmr117315385ad.13.1772429483143;
        Sun, 01 Mar 2026 21:31:23 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b9b7:93f7:8c3c:59d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5229cda1sm15196435ad.23.2026.03.01.21.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:31:22 -0800 (PST)
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
Subject: [PATCH v3 2/7] PCI: mediatek-gen3: Add error path for probe and resume driver callbacks
Date: Mon,  2 Mar 2026 13:31:02 +0800
Message-ID: <20260302053109.1117091-3-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260302053109.1117091-1-wenst@chromium.org>
References: <20260302053109.1117091-1-wenst@chromium.org>
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
2.53.0.473.g4a7958ca14-goog

