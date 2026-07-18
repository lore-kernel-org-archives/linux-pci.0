Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D42222A7F0
	for <linux-pci@vger.kernel.org>; Sat, 18 Jul 2026 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784388900; cv=none; b=TZBSbIJ6Lqhek61mly6tRpbEBBdbvz3xm8gIhr3E0rVYuCxgWhr8TZWbAw1cZMQpiN6gBVmvyCPwIgM4FDXfzrnAQc3F3GcsjS2i31vX475lJjm+2Q48e0MuiJV5GUv5Y49/I6s4ckJA99s3NiHIVSVqnbh1/pLN0Nys6xvTaVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784388900; c=relaxed/simple;
	bh=RXH67XQYaj8yFexNZXJHDT/aJmpSTvaEfVdKelbE4fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qtX5E5Gx37J8dzxqr+pkZB/fJGlTrhkefdCZB5Iz6LSEbAatPLt9yDxWQpNVqt3j+YZHCnJcjHeCBvgxLLuwfoOT7TP54StwNHbuO+RCHrDqaS2h+vhu7hhLKBhxnfUkba16ywhI4Bpb+a1Fc7f0rgD6yHFdsErk07jRrCuWCVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJRCYA8/; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJRCYA8/"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495459712d2so6564325e9.1
        for <linux-pci@vger.kernel.org>; Sat, 18 Jul 2026 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784388898; x=1784993698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3a973xC5amOryjVCsDpkO9j+SVYzCFx1FsPCT4lS0xs=;
        b=QJRCYA8/2rgzhs7+wIMKupKOHNncXO424Wd4zBNKELp21PcZayF+mvG22r/T4ttEAX
         YfJKdaYdkVkITltPXQ/6naMJ5K1nqTXt97GcRmLiUp6DZKjQ373T708NKckdmAL8/ZsR
         XB6Wef2y39KSoms6CZoNZ9bJxRGq7P+16E69DtkdC0P48ZAKAj56OgypsXd5L/TeUp++
         RbMBMHaS4ouEywHR0d7SJwiCVA6QufQTPGqjIhUvylMXIzbIrrU8iIkTg9gS/y0T4QXC
         9W1EpDIHtfO6SkG10oLxeikzWhevz5SFyvEkRY37Ns4H7BqrsdkHFf9JWq8cCHbr0flJ
         v3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784388898; x=1784993698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3a973xC5amOryjVCsDpkO9j+SVYzCFx1FsPCT4lS0xs=;
        b=LBXKBGaF2B2gxTjj0rjPeK/ldCKw3O0gf2HVDTrJOWRXCArjRgAdJRGhsGl5+3Aj6L
         C1xgKIyQPSNxVzuQj/pqsz8Ctn2rSMD4iy7P1idMgEzeRtSAzYCTNKeezwcYqpajzLtX
         aFjk8TRGve8LmmX3uu+8qddT+Vvh3D2jjBH+TtpnTLVoRXUVAZVRhDBbCj473xIAIdiz
         liJN/8tblbP+vjRzsuaUaupR3Bj2Zcx1qAmAeIN32HmsbgrPqGntyep0URP1wYTWs+i3
         cZk3PqjM2hkbIOBvLjmPjbA5p9DuZKpJpOopwGThSq+JH62TTXaeCiszKLw/IcpMA2EH
         7IJg==
X-Forwarded-Encrypted: i=1; AHgh+RpYqGcaIcgoYGdUvxfGlE9HEtKp2PcG7PgzIX8rjTBi8tCQpOuSfAvpy0qtm/aSclIa6AXGE94tUe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqrZmfB7XLLBg9stMKNDtH5YjMkW++jDKDK3wI9I6cgtXN/Yk
	xQ78EZebuGvRWeWeziyKe+6aT2k+onnCf4UiuzUEMtzhuZM1+OkyOQhf
X-Gm-Gg: AfdE7cliellVRFcc0E68hhgW3NJl/hJ2XPLVeANiJt0rH1aQSU9+ZO0uiaz2GlS1zSv
	ImBdZ+m0F2C/T6CGRy9qq6F5R1e86OVB7AI8QWAlo+uDebHyBpbIl21ccKHbY0s+Mznkimnp7kv
	kTqRS0Xi1JNhGN9+AgLet/Flh5g05SzJJRzFyakldZ8QbmusyYimdZYY64X5LJzEUCE7ecb4AxO
	jX43lcyVaWzcElBhHqWUiGuca/rhFnGWHrobbR5zdHH3+wBkgUy6hlw5lZ4AkOvstpTwRmexZ7N
	vHgDQXrwB8ELBsAtGhc78PTsyUqM/YO5CM9wEH4isMurLYwCrGJKPrTEl2D3ueldqwtbqfNSkX/
	TKPS4IXqoE2SZYjyeXYIM/E6arIDFbJwzRfia8m14Qadugd6pinaDggtqTY8F0KN1/KeS18qmO0
	DeL+rIE4I3ByggNuVU12Q=
X-Received: by 2002:a05:600c:1c28:b0:493:bd2a:93bb with SMTP id 5b1f17b1804b1-4954a3d0be6mr85791885e9.3.1784388897569;
        Sat, 18 Jul 2026 08:34:57 -0700 (PDT)
Received: from workstation.. ([202.163.123.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e0fcdbsm128818655e9.2.2026.07.18.08.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 08:34:57 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: Kevin Xie <kevin.xie@starfivetech.com>
Cc: Ali Tariq <alitariq45892@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mayank Rana <quic_mrana@quicinc.com>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR STARFIVE JH71x0),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] PCI: starfive: Fix unchecked pm_runtime_get_sync() in probe
Date: Sat, 18 Jul 2026 20:33:51 +0500
Message-Id: <20260718153352.661930-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260712175427.232234-1-alitariq45892@gmail.com>
References: <20260712175427.232234-1-alitariq45892@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_get_sync() is called in starfive_pcie_probe() without
checking its return value. If runtime resume fails, the driver
proceeds to configure PCIe hardware through regmap_update_bits(),
enable clocks and resets, and power on the PHY, even though the
device may not actually be powered.

pm_runtime_get_sync() also increments the usage counter even when
resume fails, which would leave the counter unbalanced if this
error path were later handled without additional cleanup.

Switch to pm_runtime_resume_and_get(), which balances the usage
counter internally on failure, and bail out of probe before any
hardware is touched if resume does not succeed.

Tested on StarFive VisionFive 2 v1.2A board.

Fixes: 6168efbebace ("PCI: starfive: Enable controller runtime PM before probing host bridge")
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
---
Changes in v2:
- Added Fixes tag to commit message
---
 drivers/pci/controller/plda/pcie-starfive.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 298036c3e7f9..e9a472985b8a 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -410,7 +410,11 @@ static int starfive_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0) {
+		pm_runtime_disable(&pdev->dev);
+		return dev_err_probe(dev, ret, "failed to resume device\n");
+	}
 
 	plda->host_ops = &sf_host_ops;
 	plda->num_events = PLDA_MAX_EVENT_NUM;
-- 
2.34.1

