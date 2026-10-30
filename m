Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383788;
	b=2DRL142Mi6Tso36qEiY1DBdDiLdGH/yL5Qsp21GDaMj24lz/+rO5VoJNn67fCzuETiwS
	 DKZU7oZTTM5TCowKUxthWTN0HCxA1ozp43w64E014nTOUDMlU20mJVivmimLzN3uddXeE
	 8+k2Cd8zv8XlUBChT6S8L+bOeTbsY+jr/TvE6c4r9Ol6/JcKOw9aK7KdY7lyywlXJrQ9Y
	 SnLVIPcxr4aSmw0cy+IxvzlzVafJvg5hL6G3GdIbO4GW33G2aogeHWwmmTbT5/Y5/QwuN
	 ebhLeK6O7w+O4LXAJ2u+SeQ5Al+t6knBwXg+RPNfx4mNeGNMbe7QqkX6P0QoBdgIxeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vqkl7ANx1lNN2+P4c0UcTgWL5h2sI3titmgKVx7tV7s=;
	b=QqpwodqIla9hx4yKols8Bo9sexLrCNIctZ8MfRE1uBLVGuk/03BPE44MxrBE9+U43njd
	 /rO4/qpkIzCCmkahwt2NQm/TjOlXq3eQmbLH3pMzFjEvU7aD3ULfEWxVGj9X4bhluS+YM
	 oXKs7x7qTInN7wigBq1HuVWr6K55nDbvS83MtiYzTGFN+lCpfO7trY896sAJZwZfVsl3n
	 p57J2W3fF+se4pHazRo4MjROf6akkbqq+O/7+p0kHrjz+7ZyIrnEGcjL60Z3AlNTrMNmV
	 YPo39/wjhEY0blMjzcHrzQI6Utyhm2jD/BiRr7/fEkwxOGKbOcBrmz24zTCP+BC0ZSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZB0sNyCS;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6688B606A31D
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 18:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6688B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZB0sNyCS
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a2af4c8d00so14786c88.0
        for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 11:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793383787; x=1793988587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vqkl7ANx1lNN2+P4c0UcTgWL5h2sI3titmgKVx7tV7s=;
        b=ZB0sNyCSxhJsCJ673miFRQ4KDpfbxclGphz5djJP4RL5Lx443eRSDPw0ID9EKWCHuO
         Qf2LKh12HngOoVSEs6BvBen+vQEhQZlUiAUdjImZRv5UqHmFtWRrWA2EP7haOyliIgeB
         me7SIIKcfJ4+RiPYVIS0THhNkaWsHFmGdbwgaHGB4LJOrxcaJRNxp1cxXL4ke1PXKVjg
         0LIKjDrbrVXiVLnoAKYUklWR8grEUgWdxuA+GVxzaw7prut48sJ75YvEfYpj+hvLm+eC
         /XzxcNCsznvRXFm0DkyX8OoN4WvkrukVUCI2anoWFyo227jaHkm8CHYaRCd8QLz9ZFsk
         S+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793383787; x=1793988587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vqkl7ANx1lNN2+P4c0UcTgWL5h2sI3titmgKVx7tV7s=;
        b=OInEMfEJ1C8xNR5uE7XgfT45WTY5FmJwDfVLofDCFe2J2kvjYfYFoCE6Cv11BGXLYH
         RFfO8AwnJwNf65DQD7ZSZ5SeeH6TbaL/xGZiG1WuuIEFtBqTEMRpbe8xRXsPsO34dTyG
         SxPFk+Maqvq7i9SlfrR7irnAF/4r9bM1TWTM0pl55RgCkyOCjKPOomBPUZahdmAFp0mQ
         e+BCgAZvyR2RJ2SPqLRdd5P4Nuq+PcZKwYSCEYY/Avx6lJImRySh+t/9yAW03nvrNrE5
         3dE2Cjt9rnL/7RAZJYYD+jjjF2564Qzna9fVbOMxqwlm4yxrvGso4YLLrFlx//k7eQ2C
         P5qQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0ECmdTYeuJRRahN/lq4tM0h8fZzjerLbdONrGOgvTMBgTRX9mPYMSuwIGnhxO6Hhmcp/iUW12VaM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqlFak5ONk/lhq7VE2KSSg+ru7HCZFhVdVrKIyotibKlfJ1gns
	WT9PXu5QMCAr3FXZ3Gmylj84B5ApWIk4fQKvBoc+ySdT8R0rbThYcQiN
X-Gm-Gg: AYBFou0pgABhJNUL5wBoBUeUz5A+pDnVJtzy98VdMnzHpf1wL8dTNzBWxI+l6kNyYi9
	044ypfV03ji0cvWscVytHLFrF5CcxT3KxKJon4ntfvJxHMlDmPT4UyxC8EotQl2fo5MmI8TcSYo
	zYOFABI6rud7WYzc6cPKACN4DDW3/LiOTGBGYPPIpENZgetk9ceAwuaWp92FRtaIvTqOxhqPHM+
	fYq1IGw3Mni+njlUnDYJFNCDPN2hUjfgT1WBMWdESFk+mnlKwEODO89GiTq1YWSVZ+pzGAPoSVW
	dH1StRvlLryMjKYVpD8Vr4sg+7Tm9zXDtubktotHd6oFcqbJ9Lj1fSQZTIPYoHiOV+LnOodCSYB
	ClMNqLrs4l6hV/Tj36CyYfrHPeiBXkgb9+dr3fFNrrCjJ6wJSUbSJFy+BIWxa7FJy+7u8uPLC/5
	nF4jU0YVwMK5jDGK/8dth67bnU6vPcdaOCNvQGXRC+6u/6yPJ3aXXTCDbhHMzqa9Ldxt0+WVRfC
	LStlx8yx7ILEyUOYV/A5Tx7OwJ/Oa4EdWM9rmEZsUFH4xJZV3IsI8PZhXKl+cWAfYueZYql86qI
	hxwGCJaV8ww5Qh4zop2by/ikZm3tuLHCE6Y74p5qBKko4xit5YXhLO1wAaekZoQxwJxTkfE=
X-Received: by 2002:a05:701b:42d1:10b0:188:9ae5:162e with SMTP id a92af1059eb24-1ac5cdf9ae0mr4451889c88.40.1793383787373;
        Fri, 30 Oct 2026 11:09:47 -0700 (PDT)
Received: from localhost.localdomain ([103.170.55.71])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458fa3sm9695510c88.4.2026.10.30.11.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:09:46 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: sreekuttan2156239@gmail.com
Cc: alim.akhtar@samsung.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	krzk@kernel.org,
	kwilczynski@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	peter.griffin@linaro.org,
	robh@kernel.org
Subject: [PATCH v6] PCI: exynos: Handle PCIe PHY initialization errors
Date: Fri, 30 Oct 2026 18:09:01 +0000
Message-ID: <20261030180902.2589-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029131006.2744-1-sreekuttan2156239@gmail.com>
References: <20261029131006.2744-1-sreekuttan2156239@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return values of "phy_init()" and "phy_power_on()" to
avoid continuing PCIe host initialization when PHY setup fails.

Track the PHY initialization and power state to ensure cleanup is
performed only when appropriate, avoiding double calls to
"phy_exit()" on probe failure.

Also check the return value of "exynos_pcie_host_init()" during
resume and abort the resume sequence if PHY initialization fails.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
v6:
 - Prevent state/reference count desynchronization in exynos_pcie_phy_exit()
 by ensuring both phy_power_off() and phy_exit() attempt cleanup even if one
 fails
 - Assert core reset on post-init probe failures in fail_probe if PHY/host
 initialization was reached
v5:
 - Avoid PM core state desynchronization in exynos_pcie_suspend_noirq()
 by logging teardown errors and returning 0 instead of aborting suspend
 on teardown failure
v4:
 - Fix invalid return in void exynos_pcie_remove() and ensure regulator cleanup
 - Add core reset deassertion on error in exynos_pcie_suspend_noirq()
 - Prevent regulator leaks in exynos_pcie_resume_noirq() error recovery path
v3:
 - Address review feedback on PHY and regulator state tracking
 - Avoid powering down the controller when link detection fails
v2:
 - Track PHY initialization and power state to prevent duplicate cleanup
 - Handle host initialization failures during resume

 drivers/pci/controller/dwc/pci-exynos.c | 115 +++++++++++++++++++++---
 1 file changed, 104 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index e3c05ade381b..0085c3ed0c2f 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -11,6 +11,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -55,8 +56,35 @@ struct exynos_pcie {
 	struct clk_bulk_data		*clks;
 	struct phy			*phy;
 	struct regulator_bulk_data	supplies[2];
+	bool phy_initialized;
+	bool phy_powered;
+	bool supplies_enabled;
 };
 
+static int exynos_pcie_phy_exit(struct exynos_pcie *ep)
+{
+	int ret = 0;
+	int err;
+
+	if (ep->phy_powered) {
+		err = phy_power_off(ep->phy);
+		if (err)
+			ret = err;
+		else
+			ep->phy_powered = false;
+	}
+
+	if (ep->phy_initialized) {
+		err = phy_exit(ep->phy);
+		if (err)
+			ret = err;
+		else
+			ep->phy_initialized = false;
+	}
+
+	return ret;
+}
+
 static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
 {
 	writel(val, base + reg);
@@ -225,13 +253,23 @@ static int exynos_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
+	int ret;
 
 	pp->bridge->ops = &exynos_pci_ops;
 
 	exynos_pcie_assert_core_reset(ep);
 
-	phy_init(ep->phy);
-	phy_power_on(ep->phy);
+	ret = phy_init(ep->phy);
+	if (ret)
+		return ret;
+
+	ep->phy_initialized = true;
+
+	ret = phy_power_on(ep->phy);
+	if (ret)
+		return ret;
+
+	ep->phy_powered = true;
 
 	exynos_pcie_deassert_core_reset(ep);
 	exynos_pcie_enable_irq_pulse(ep);
@@ -314,6 +352,7 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ep->supplies_enabled = true;
 	platform_set_drvdata(pdev, ep);
 
 	ret = exynos_add_pcie_port(ep, pdev);
@@ -323,8 +362,22 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 fail_probe:
-	phy_exit(ep->phy);
-	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	if (ep->phy_initialized || ep->phy_powered)
+		exynos_pcie_assert_core_reset(ep);
+
+	if (exynos_pcie_phy_exit(ep))
+		dev_err(&pdev->dev, "failed to exit PCIe PHY\n");
+
+	if (ep->supplies_enabled) {
+		int err;
+
+		err = regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+		if (err)
+			dev_err(&pdev->dev, "failed to disable regulators: %d\n", err);
+		else
+			ep->supplies_enabled = false;
+
+	}
 
 	return ret;
 }
@@ -332,22 +385,42 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 static void exynos_pcie_remove(struct platform_device *pdev)
 {
 	struct exynos_pcie *ep = platform_get_drvdata(pdev);
+	int ret;
 
 	dw_pcie_host_deinit(&ep->pci.pp);
 	exynos_pcie_assert_core_reset(ep);
-	phy_power_off(ep->phy);
-	phy_exit(ep->phy);
-	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+
+	ret = exynos_pcie_phy_exit(ep);
+	if (ret)
+		dev_err(&pdev->dev, "failed to exit PCIe PHY: %d\n", ret);
+
+	if (ep->supplies_enabled) {
+		ret = regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+		if (ret)
+			dev_err(&pdev->dev, "failed to disable regulators: %d\n", ret);
+		else
+			ep->supplies_enabled = false;
+	}
 }
 
 static int exynos_pcie_suspend_noirq(struct device *dev)
 {
 	struct exynos_pcie *ep = dev_get_drvdata(dev);
+	int ret;
 
 	exynos_pcie_assert_core_reset(ep);
-	phy_power_off(ep->phy);
-	phy_exit(ep->phy);
-	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+
+	ret = exynos_pcie_phy_exit(ep);
+	if (ret)
+		dev_err(dev, "failed to exit PCIe PHY during suspend: %d\n", ret);
+
+	if (ep->supplies_enabled) {
+		ret = regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+		if (ret)
+			dev_err(dev, "failed to disable regulators during suspend: %d\n", ret);
+		else
+			ep->supplies_enabled = false;
+	}
 
 	return 0;
 }
@@ -358,13 +431,33 @@ static int exynos_pcie_resume_noirq(struct device *dev)
 	struct dw_pcie *pci = &ep->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	int ret;
+	int err;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
 	if (ret)
 		return ret;
 
+	ep->supplies_enabled = true;
+
 	/* exynos_pcie_host_init controls ep->phy */
-	exynos_pcie_host_init(pp);
+	ret = exynos_pcie_host_init(pp);
+	if (ret) {
+		err = exynos_pcie_phy_exit(ep);
+		if (err)
+			dev_err(dev, "failed to exit PCIe PHY during resume error: %d\n", err);
+
+		if (ep->supplies_enabled) {
+			err = regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+			if (err)
+				dev_err(dev, "failed to disable regulators: %d\n", err);
+			else
+				ep->supplies_enabled = false;
+		}
+
+		return ret;
+
+	}
+
 	dw_pcie_setup_rc(pp);
 	exynos_pcie_start_link(pci);
 	return dw_pcie_wait_for_link(pci);
-- 
2.55.0

