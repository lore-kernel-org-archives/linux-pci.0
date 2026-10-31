Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793432186;
	b=Ad6L5BgqNDw66DyN7Xhtrqq2ODccWKMGiZ+V/Sri/EhD5j47rJNICLXgpH7iVz6BlMDx
	 ia1pbfflfGDmTukFBDbEcaPOlWiFlTFRFtFgNoYmkW04Rbw0LG4X8wMHZ/Kw7xdHtn5Xb
	 Be3JKSqpNPZ+BaGog+DXYm2d2YgeO8KdvvYvGpqAUMmlGBTXg6VAWOgo9AssRzfGIs2e+
	 iVe9NR7pDi8Es3duOkKTYVmOyzSHw4t34HR6kI9tfogdGSDd0MuEMSAn9f1sfDYHTkZbT
	 8xzEmOHAuG9y1q/TCv6F/Ro4tb8nX6sCVLeQQ0BL+basjKBrhQR5OTSHOQg9BsY4fAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793432186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OfB8s4kz59lXGKWlIIVOfEeGW2vmcfTHDgtk/qzATWs=;
	b=qTDJe/aetKPLf46gExel+BsF4vpxlBdLDUH+BCGYkVaGabhgz32/sU7CN1WhXVW8HcEg
	 espZXnxuq2w3MEUCshsQ4Hbmi2CD+38vcc1/m9xyR2hBCjnB+tdal/AOK4StQ/evHa9tu
	 +ytuaoDiSJVuNwrOo7ndv0Fg5jnz3H5fisHsgag2970shjdR6azX2GUgeTMEHSyc923sb
	 9g3LzGgCQaIJpZCAG2ziqFq7xQnNh8iyDlGYpzOACP4lQua9cnvcgRaMa0zte5gB+dVFS
	 MIZKBPlH6Vaaa07BNG/3pyVB7iCzZOK84s3MQXvsErkVP2R73nJRistxRrRDmGw2h9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=npXBoT+U;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE9E606A31A
	for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2026 07:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CE9E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=npXBoT+U
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35829219da8so2973411eec.0
        for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2026 00:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793432185; x=1794036985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OfB8s4kz59lXGKWlIIVOfEeGW2vmcfTHDgtk/qzATWs=;
        b=npXBoT+US4fm5AFe8zGzlAZyfbOLm8wWAsh7y9vD17unPK6rLjrRSEJYAj7D5CTnSB
         M7lShLWPgD/c7G4+j4viQCenS9WU/ScR2B2Sn6MM2s3+AkLq6W1CmFpjla9Rqznnfe9n
         G0sLZY7NJGNXju3EFVa9L053EkJSLjlJ3mi7cHJzwHyfL0PkZLOqIWZ2qMi7yc8rT53X
         uoueS3O4RPsElSXJINmEAe1z4DQ2MAHs7PmydGH+kJ/T2OjqYKckh6qncw05O33EVDqu
         3NOzkV8npJQAjLEWAhLwAkqCBH0RWsyHcPqSqoldACc9C81+fve8ShPodH9/lh0Jkgb9
         v4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793432185; x=1794036985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OfB8s4kz59lXGKWlIIVOfEeGW2vmcfTHDgtk/qzATWs=;
        b=LfeCQhOjMwoI/CscmrSN++CKvwfUkZDouxketkB9xxGLxMeqSTiYIpqLzOhAt2H/GQ
         /cA9VskF9sHBnan1E/fcALqk1w8jAQL644vaJR0diSPoJDe4BH8rnD40Bo7IQSIl2qDf
         FIu/U4fFPDCmj9Bw9UUBz8b2tETRHrKiJQaB6jOLWdyxCEq+mHBpQSbVhNxirRgsANKs
         ofHfASC56JJiE79S9MMUOdkrp0PBgT/JTQIDMSIbLsuMaF1yRLi9ZQ3hbcty3H6tOPhC
         uGIYrju/W2b+5910SItA+RN+VGozD/7ZPagPEQgPTJ7aJz1PWKtG5jQeZqpIWVaFX8hJ
         dCCg==
X-Forwarded-Encrypted: i=1; AKwUvBzLUes4HHh5ExGyxoQqtLVWr18MRsaEF4M4NLsRUyXwxRlRDBO74554o/caLmAxSK7bQAbhZkg7Q/4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2nMXHJD9dtdw6rjQRgiu/KV+FzAOAvjSJJUtgi6qPSkiB2bdp
	W9ESTHVJHBzMvR+Hdiokgba6/AaaFBZNvyVJsMmSLjbZL4Z5dlx3AFKz
X-Gm-Gg: AYBFou1MYiobSJyHMs9yQRU1DiMg/wyz/LiOFqfeNhHiQVtH3lzEMWPjTMsyveTL69N
	yn646mwXf4v7b/jsLZzHlVlEPosnkgSncrMT4JgekMhk8XtnZ5Jm+Jr8d2s3TB3xIZxiQQSs5ob
	JoV+UNlXyZMdUUzk6vmXnLsMcQMCucRzIuOTOuT+8/9ocqlZg4bQEAScmh5yjCrRK3pk6Rhivx1
	v7rIsXYWaTGoQEYmvDa+PQLXkpx2vj0kkBbK7MAVsuHF0c5HfXecxkKKqwtl+qovhqCi1IngBT8
	Tc7QvqS08SbIwIOi4DmILi4EozWjbwmN4jbHXys96UQcRuURLdBP02pHyyHk9viarOLDEDGUUG3
	Tey+A7UkMa+J43mh+tDB2HHGtPxaStYurpBorOakyMEJBNEiSr6nE+ImxPf5YBBQGHziKke4Ken
	bdlCFJDvOHrDtjiXDxOlQ2q5cVf3puFEIIfkFN0BMEuy0h5GagINju4xT0AnDZidoBuQ6Xf6c4W
	Jtih4gvTna+XAZqr75PEMDPZgvLWbH7tJwWdd0fbTnmwysOP58fkEefBRbZdT0JJZlcQ9BmExh/
	K8Sp04rXPjcK+ZvGY5f4W6hlDjm7Hijl0KgrfxuKEeX1937gXw==
X-Received: by 2002:a05:701b:4549:20b0:143:1bb1:3305 with SMTP id a92af1059eb24-1a94abded94mr9977794c88.22.1793432185124;
        Sat, 31 Oct 2026 00:36:25 -0700 (PDT)
Received: from localhost.localdomain ([103.170.55.71])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4a04esm13303278c88.15.2026.10.31.00.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 00:36:24 -0700 (PDT)
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
Subject: [PATCH v8] PCI: exynos: Handle PCIe PHY initialization errors
Date: Sat, 31 Oct 2026 07:35:48 +0000
Message-ID: <20261031073548.3916-1-sreekuttan2156239@gmail.com>
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

Check the return values of phy_init() and phy_power_on() to avoid
continuing PCIe host initialization when PHY setup fails.

Track PHY initialization, PHY power, and regulator enable state
across probe, remove, suspend, and resume to ensure cleanup is
performed only when appropriate and to prevent unbalanced
reference counts.

Assert core reset on probe failure after PHY initialization has
been reached, and handle cleanup errors during teardown and
suspend.

Also check the return value of exynos_pcie_host_init() during
resume and abort the resume sequence if PHY initialization fails.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
v8:
 - Fix state desynchronization in exynos_pcie_phy_exit() by returning
   early if phy_power_off() fails, preventing calls to phy_exit() on a
   still-powered PHY
 - Prevent PM core desynchronization and orphaned controller states
   during suspend-abort sequences in exynos_pcie_suspend_noirq() by
   logging teardown errors and returning 0 instead of aborting system
   suspend
v7:
 - Guard PHY initialization and power-on against duplicate calls
 - Guard regulator enable against duplicate calls during resume
 - Preserve PHY and regulator state when cleanup operations fail
 - Update commit message to describe regulator tracking and core
  reset handling
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

 drivers/pci/controller/dwc/pci-exynos.c | 126 +++++++++++++++++++++---
 1 file changed, 112 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index e3c05ade381b..45163b1dad81 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -11,6 +11,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -55,8 +56,34 @@ struct exynos_pcie {
 	struct clk_bulk_data		*clks;
 	struct phy			*phy;
 	struct regulator_bulk_data	supplies[2];
+	bool phy_initialized;
+	bool phy_powered;
+	bool supplies_enabled;
 };
 
+static int exynos_pcie_phy_exit(struct exynos_pcie *ep)
+{
+	int ret;
+
+	if (ep->phy_powered) {
+		ret = phy_power_off(ep->phy);
+		if (ret)
+			return ret;
+
+		ep->phy_powered = false;
+	}
+
+	if (ep->phy_initialized) {
+		ret = phy_exit(ep->phy);
+		if (ret)
+			return ret;
+
+		ep->phy_initialized = false;
+	}
+
+	return 0;
+}
+
 static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
 {
 	writel(val, base + reg);
@@ -225,13 +252,27 @@ static int exynos_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
+	int ret;
 
 	pp->bridge->ops = &exynos_pci_ops;
 
 	exynos_pcie_assert_core_reset(ep);
 
-	phy_init(ep->phy);
-	phy_power_on(ep->phy);
+	if (!ep->phy_initialized) {
+		ret = phy_init(ep->phy);
+		if (ret)
+			return ret;
+
+		ep->phy_initialized = true;
+	}
+
+	if (!ep->phy_powered) {
+		ret = phy_power_on(ep->phy);
+		if (ret)
+			return ret;
+
+		ep->phy_powered = true;
+	}
 
 	exynos_pcie_deassert_core_reset(ep);
 	exynos_pcie_enable_irq_pulse(ep);
@@ -314,6 +355,7 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ep->supplies_enabled = true;
 	platform_set_drvdata(pdev, ep);
 
 	ret = exynos_add_pcie_port(ep, pdev);
@@ -323,8 +365,22 @@ static int exynos_pcie_probe(struct platform_device *pdev)
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
@@ -332,22 +388,42 @@ static int exynos_pcie_probe(struct platform_device *pdev)
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
+
+		ep->supplies_enabled = false;
+	}
 
 	return 0;
 }
@@ -358,13 +434,35 @@ static int exynos_pcie_resume_noirq(struct device *dev)
 	struct dw_pcie *pci = &ep->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	int ret;
+	int err;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
-	if (ret)
-		return ret;
+	if (!ep->supplies_enabled) {
+		ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
+		if (ret)
+			return ret;
+
+		ep->supplies_enabled = true;
+	}
 
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

