Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D6386C1C
	for <linux-pci@vger.kernel.org>; Sat, 18 Jul 2026 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784382018; cv=none; b=QTUNZEp9Q3RCKh04TtLBHOLTIqzZzD7TBAkhxQeJIeDQsj/k4DaiC/OTmlsT0U2oe5nn3RVCKcfCHL9FKlMJcCOHg7B/RzHbNWfdxBig9kNfmJyeiqb2mijSJpWZ0xLxgQO9W6pamxqb+A2126msWt7YZNMcpbN23tHZcqF/CuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784382018; c=relaxed/simple;
	bh=Vr70OKF73HRcxxONsAAc5wyRqN8OnzNDUibnMbNiOYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ok+NEOSeVX6VLwDB2g3SgmnGr86XCgR2YfvY05QiHKndJVZ3xe/posPvoP0QsSYBKAdA0w+MMsWzhUcNw41HxYVq9H+sA6TQ3vlYQ1W/hmyEN4ciSpW+6mH20Bs9JnGV/egFFy6/txrCu5XTTe96I0ViujC3DPKaAjODohbNgho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSl7bQk7; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSl7bQk7"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495459712d2so6425685e9.1
        for <linux-pci@vger.kernel.org>; Sat, 18 Jul 2026 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784382016; x=1784986816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ew/Mri6rzDrFehp5hGcw5HQsP8kSiZwlWHmbV5SwxfE=;
        b=sSl7bQk7XHrZPpM0EoxfQDejrd5cY7tNwvbCS0UJRCz7a6CQ5B0U1HKFlauHC0QqV5
         9qQbr+xgKCcoj90Mn+7zIhUymk+CYQjiocXDLyu74+zLVkgv6ewoZqbv43z44Asgb5mN
         nMuDOSpcT3e7dV+F7yH3Bx/sJQRyalcND6BI2xxbkxTjWO33K7k0qjDk3Iq7MbMXz2qy
         sqx0Tp6dYZWKeeekwP/fWqQ3GOjgTF52XYrFUqGndusA7/IjxjK1bgbSSl+uoREmgluT
         ft3VrtdgjmkIfJv7YL0DkPyJyIE4jbl4SSf+Sv69vdGLMAXoyr3tVAtaF3Ur9DatGieY
         LRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784382016; x=1784986816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ew/Mri6rzDrFehp5hGcw5HQsP8kSiZwlWHmbV5SwxfE=;
        b=kBCQWeuQqLfwllu4oWwUXOEPFGUNUWpHNMnfYqbUtsM2QCxXbWr5X7ZJ0gdELXZZfa
         wvy7vn43c08NkPh29POLA0uJY8vnlOwTWn1w/xZODTl+U3QBj13+FR+9rl5/WJ3iLGVH
         VMMemp5jjSg8Oj75ceLkX/WOus3dIE7INLHBgmPyVnw8AwcG1rWU9x4ehXLx5smzQwhm
         4PtaNLkoPRL3Q0czbn4Yx8wpu1f4psfHUhWfFCygpo+9EE+GSCEU3LCEifn1FP7jIgZQ
         w1lyQgLp9DBjsY32Veh+mDcZPMbtfjb7lGiCsSmwTy5fmcO5RL5GIGiJL4Y8Qyg06w1G
         ikfg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5PLTK6Dn3A36CJxEIv9zNGAV8cpwIwJptuTG5Xu6kVpdxvWE633srHTa/3gKhZ704+fomZDVpxTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5mU19gtUUn1p427mKobRyAqj+65EVh8Ox4m7QIyfJBj1Q0hXl
	PTEL5fC3UWcpfAcUHd9AdvWlUs4W7nM2nzdi81UiE29RSPg48xUzjsjv
X-Gm-Gg: AfdE7ckgWwNkPFk4Ii8jgzOoegaT8K3uSKYAjJNHqo27NOXKqyGeAor17GF5o6pI959
	2r0T0X8baXzf3Vo+ksSgg8KO8lzRpfLF1eyH2b4hvp182Hvod/Km7+jCG/cdbsxkQQceD7bwIar
	CphmpZRi0yKyG8NwSCyk09BTC6cPI50LQKOO+W84eSP/lPGS7rAmM0AKtDU40dAkg4vYqkpJANB
	UdI67TnfJnMJJxyzTiK8L0/wGairbyi/TntV7nIXbT7+gbn2YLv3A2zzOKCw6SvSG3d4tR16x8J
	rRNQg4OM9JGY4Rgn9kQKeyiWJRld1xFtUM6/T0qcQGucdPyv3gY6ebXX4mnXSPlUKrtqE5DnPpa
	SJ0rMZ1KBC7NP1YWLikp4k2SfoL6bX3L64g3CVwXyk52T9EmpztvOLoygvlnaRX4imtlDsJjD74
	gpmXLsGG1K
X-Received: by 2002:a05:600d:6454:10b0:493:bfbf:1da4 with SMTP id 5b1f17b1804b1-4954a403910mr58891185e9.22.1784382015328;
        Sat, 18 Jul 2026 06:40:15 -0700 (PDT)
Received: from workstation.. ([202.163.123.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954aa1a231sm72913345e9.1.2026.07.18.06.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 06:40:14 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: Kevin Xie <kevin.xie@starfivetech.com>
Cc: Ali Tariq <alitariq45892@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Mason Huo <mason.huo@starfivetech.com>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR STARFIVE JH71x0),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] PCI: starfive: Fix Runtime PM handling and teardown ordering
Date: Sat, 18 Jul 2026 18:38:25 +0500
Message-Id: <20260718133825.445041-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713145014.740898-1-alitariq45892@gmail.com>
References: <20260713145014.740898-1-alitariq45892@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The starfive_pcie_remove() path incorrectly disabled runtime PM
before executing plda_pcie_host_deinit(),
which can cause unmanaged hardware register access
while power domains or clocks are disabled.

Fix this by restructuring starfive_pcie_remove() to deinitialize
the host hardware first while runtime PM is active,
followed by a synchronous pm_runtime_put_sync() and pm_runtime_disable().

This bug was found in automated AI review by sashiko-bot.

Fixes: 39b91eb40c6a ("PCI: starfive: Add JH7110 PCIe controller")
Link: https://lore.kernel.org/linux-pci/20260712180440.423421F000E9@smtp.kernel.org/
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
---
Changes in v2:
- Added Fixes tag to commit message
- Added reference link to the bug found by sashiko-bot
---
 drivers/pci/controller/plda/pcie-starfive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index e9a472985b8a..ba8ef7842e35 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -440,9 +440,9 @@ static void starfive_pcie_remove(struct platform_device *pdev)
 {
 	struct starfive_jh7110_pcie *pcie = platform_get_drvdata(pdev);
 
-	pm_runtime_put(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 	plda_pcie_host_deinit(&pcie->plda);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	platform_set_drvdata(pdev, NULL);
 }
 
-- 
2.34.1

