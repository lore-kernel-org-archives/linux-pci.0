Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793430107;
	b=wPx279oDuYwYvzONnKlncnT6h/Q9M9Y2Q7xpVMiobXAE7vQrUcU34x4Q4e8LMuBGK2ZO
	 L8/EOYRGSDut7zF5VLwwgiVsvkg1eYkPW3VBMQXEnggp72sp2I6wER16JdiPS68ee4c9y
	 X4X4PZFiYPYMvVyjqk1itKwqRGC1j1xp6iyj4zwHQvqLeITkewYtjCoGfsSDB3WdIaii3
	 vTJo9XaNziNgDIBRAkkHhY0XbaD+AnVqA/nWrLDpeF2ULgUztY9d8qYXfYv4HFmFd0OHC
	 fvjzrS90h+ocTUbZ7G1EKktaaG/TlW+xSNhfYtKWlqx/yJvGHeHxm03klgp6Y3V3yvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793430107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ADQcrm8YvdoyGGOqaxYX7L9xoyUfoiCcnIaPiCNu+Wc=;
	b=PNSxypz2QtG+LfXzbF5NqgNnPVwujPpJW9QFrP/rCxybq17WQP1qstwDZFI6HJmo10TI
	 GZrbKEAs9NlW9j0e7UFeJ8tXIyQs89Ab1ARKBw+v59N//RgydT146nVVRgA723yU6c/dw
	 +WNJIdBsK4G7/kftHdJu2rY0cdYvj3e3vY9TisvgjcuWIngcDSI0G0IKiBhA91uF6gx4w
	 K3b5GQ7a2OchzcFKSpPYyODalCmp/8it6CKr2RtfOziJyzjg3xFujfNPHkNj16ynGhC1H
	 KEhp1pbPQbSy7RsM0ooCX4wIntei6L/Mxd5A4opy85FOuovkK6OdtTwmKBeiDgpSj7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="EdO3/FEh";
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE0606A31C
	for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2026 07:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DFE0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EdO3/FEh
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1931ff67a29so1050525c88.1
        for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2026 00:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793430107; x=1794034907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ADQcrm8YvdoyGGOqaxYX7L9xoyUfoiCcnIaPiCNu+Wc=;
        b=EdO3/FEhYJcmAFyJRCDfby7H2ialJiK9oLcCKZpNeBRfc2lAi8OO58Oyb9ZU6mqrOL
         TTx2oE9DmEWNW1b8jaoh8XeBXFVtrx1fRiq8ctKmJ1eh0v+4+REUCNIC535ucSbKsMM1
         DnDvL337fYyFzl/hfigGgVwH8KPVPUggvRv/7Sy2SRt+lOtja+ek8cw0m7WBUr2Hh9bG
         5L8yhjBtjUq6KjsObZfxtRgAZ2ZuwT3mFJb6o8zTEeBAm80Un9rqyR8/K+u3Sbb76i+J
         hu9fC+KSaDv56khxXiFQB60dAziQz81DHdjoYpjdBLY3TiIrzMsZJLFBQTE7qSCnFdBi
         +zXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793430107; x=1794034907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ADQcrm8YvdoyGGOqaxYX7L9xoyUfoiCcnIaPiCNu+Wc=;
        b=ho+VWEGz7nXB9sNZtqt8raiUiTUBcMvt+mMKs3t/citWFYjKGi+DA8oJ0h9aXBYnrw
         tXL7V4kL+lK+pajCkLoizyolOoR7mGLWHzr5AkZ+bRTbQ7xb6+1zYA+UywsBLZq8ojfo
         ViAl9d0RJayf0EQuVP/zGmmU5HFD/VFu36tGuiqH+2JcZ118u9x40cLpFfTvKR/snvkC
         JjUyTsS1nvYrfmR9jcB+2yULwbhCVKECsR4ILrChowhBRDe9XlYwZuTH2i4rFgwq90W8
         GM311cMkYWYVx7LSJgiNH4QbJ9mUhmmYS2Qx1r40EF7zug/UIMD/cuMp4DRKacuIp9tr
         GdxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxO7rJ70gcNfBzeVssyMFBL0Tq915X42kjqWUEkIT5aZKsHljoJ6V/dCbU5IzbSfPnPzDPEmFRFz7U=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5mi0OwIACLG0eHMxHMfcK1SBkHgiqBjGgQ6qSG7kg5wdddh/D
	vy1qKuKQq1GeaDrlZpyWkTOrHlkPZLGy3HzNEwnvpT3o6Utx05K3DEBc
X-Gm-Gg: AYBFou26JAejVudjo1FHiXiq7aqfvz8D3ue92WZoQYA1Wzi88KwsbUOhemtVqbQMqj/
	WIUSFHNNc76ILKt6twaUXr7LQWB2Zl2zBlOdXjorQzYg5mUdRtqTndkkzDiCLU9fzWSubJA2A9e
	fApmusr+O3XUzKEuwt2SLy97uzTGqwFn3Jfm0gDZ4UVbxxldBZkVBcXPTok5dFvmsyKzOWf5LiG
	EuMS9ff3QhN2k/+knnzr1JigZNYV3mkAQnN9THrwR+eoQvddDmavb2dssuKNbEB3wz9lJ5mcY9k
	O6iEpENoV4Gxr9Y1hHdVm0CjxzAiH4/SxwKVR9V0ZR0yAGge9f0evyVWyXpO5npEONRorScFt3n
	tGto9cJFCrC1iXsHu4tLtuUbScGl7xC+m0UlmJ0glvnAqwpmCQUDs8U8lPfewOvClkQuMGKj3dy
	6ep8gfRZoMeC7jMySgr5j08JTuzOp7HB8kysA/901KPheroMoYOGkkvjYxMr6OAd1Fuk6hqg1o6
	OKn1BN9kU48nE/dqLNuhsmxN5/m9Z6v/LF7syDuSVVuYTzvf4l/A3e6eBSjOi6J1qATNd/VO8gx
	WHz/TfV1DKnQsrsa6OAvpohPi885r+VRIRgzMpksRPdGW84HiQ==
X-Received: by 2002:a05:7022:68a1:b0:1a5:9abb:fdd7 with SMTP id a92af1059eb24-1ac5a0b5af5mr8832094c88.9.1793430106458;
        Sat, 31 Oct 2026 00:01:46 -0700 (PDT)
Received: from localhost.localdomain ([103.170.55.71])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm5185987c88.12.2026.10.31.00.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 00:01:45 -0700 (PDT)
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
Subject: [PATCH v7] PCI: exynos: Handle PCIe PHY initialization errors
Date: Sat, 31 Oct 2026 07:01:11 +0000
Message-ID: <20261031070111.3130-1-sreekuttan2156239@gmail.com>
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

 drivers/pci/controller/dwc/pci-exynos.c | 131 +++++++++++++++++++++---
 1 file changed, 117 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index e3c05ade381b..3e76a818a45c 100644
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
@@ -225,13 +253,27 @@ static int exynos_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -314,6 +356,7 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ep->supplies_enabled = true;
 	platform_set_drvdata(pdev, ep);
 
 	ret = exynos_add_pcie_port(ep, pdev);
@@ -323,8 +366,22 @@ static int exynos_pcie_probe(struct platform_device *pdev)
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
@@ -332,22 +389,46 @@ static int exynos_pcie_probe(struct platform_device *pdev)
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
+	if (ret) {
+		dev_err(dev, "failed to exit PCIe PHY during suspend: %d\n", ret);
+		return ret;
+	}
+
+	if (ep->supplies_enabled) {
+		ret = regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+		if (ret) {
+			dev_err(dev, "failed to disable regulators during suspend: %d\n", ret);
+			return ret;
+		}
+
+		ep->supplies_enabled = false;
+	}
 
 	return 0;
 }
@@ -358,13 +439,35 @@ static int exynos_pcie_resume_noirq(struct device *dev)
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

