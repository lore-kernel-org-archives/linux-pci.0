Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279460;
	b=DX6hZGRfZAT9bnMiiCcs03gSgrZ7IysWo2SlIb6GtfsbjIOpb168CswFfWty7B41eaTl
	 KHR1YaRgtavIYXJcEG+t9ducUXx8Hx0iWE01/l/kbosxheJTyBYkA91ppU9/8YVT7U7jt
	 RCWjksFmMA9CBHzMgEagxPvZH8AF3KBtlqSM7DM58vTrafVp3mYX46Vpno3ivEhmm9c/3
	 d/rDu2kDz2kvCcuF0apcZF13zEk4gd6Ahs6GE+1ayDXOLaghKLAfbhMhkJw3O52Q9Fux3
	 TUR7lduVDSGy4MTD2qZ9dqRyduewS6u6pPAEcpQ1KqURK9/pStMdiYZlBgQ6+nSoEiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Iop087FFjXWDSpJh+IBQzbRhDiBtg08vWO4Z3TycLbY=;
	b=rUYELBA0G1bWznH1mFr0+XocGMMMt7PX89VLu+nPT7ftivQoK6Ry7mg5tiaxhVMqOqPk
	 O+uSabkpSha8rOMBSdOcgGjttPAIkDU7sTAonJvUD2jgmNVc9Tyc1vkdfzaRENUGerGV2
	 7iht3qfOA6gVspmqe7ZPVfzVlCpJogGio01GYQDrdv66BxhqJ4qNXZwU8KXDrF7j3PI2E
	 rFsed0nQtTPqbaQAWOCDkq8Qn7hO5U0HZX6L2OwdSKRJoAJNt/l5Zx19zxVRTvyJOxk4E
	 Mr2ImcfpywARlNjEQ4Og36gpmTrgVFp9boH2qtUcDettdGAOvF6/qoKdLLlRUE0Q1VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NWDWRkH0;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C69606A322
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 13:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02C69606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NWDWRkH0
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15ea896ddc8so3119259c88.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 06:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793279459; x=1793884259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iop087FFjXWDSpJh+IBQzbRhDiBtg08vWO4Z3TycLbY=;
        b=NWDWRkH0HW6hakUMoF6M1i8MT5vj++Az7EvTQKb6Jb3QG6nnCe+Scwevic8JYigQ/w
         PgIi9u3+SgGmp05YZsfuFG+iG4b6XWruiN/SmceSgk9ATYVfosbCRrdUPNWRW0bSLZ0O
         /+kR+UW2PPRbulwMDCymqDR1OiglDiv0SIlqEwmzRAGtzdwVXYGsc3EQPX4Q6SMQjicX
         lO18runGwJpySM23jH24iRNXG+Erl6O7mYh5aLeIYoaclC8xSr2uXuHLEOr4nLo5/xBg
         Lml1bo/SSPWBkq60zGRae1/aa+Mym8T1UH8tXT1jGGmtn4cU9bSxUiFz3Jt0zxx19Jy/
         PFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793279459; x=1793884259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iop087FFjXWDSpJh+IBQzbRhDiBtg08vWO4Z3TycLbY=;
        b=ncQ1XoGoFIOH3KZSRWzsafKt4JGHUL3n+bAT2FaXRrjoU0B7ZwpAEiXPJFlp5AnR8x
         nvtUZnlY/zMvXAHI0To8KLrDnCTajrfyjp7TKXePTfrtM7oTHV+rEcsO5e9j0D1JRhj7
         mzlmPlHhsHGy7qWjBiNC7SCfNorJLn32ezfrFys6dS4Hn0qmJ8/5MhhkDKY5yEEa2iG1
         tcC5lByOeYJ+8hox3daPGjiVJbei3FrMbpBCXVpQEOV5z6aJHObWSzoNddJperq7M8UL
         LkF/uORiKhW7pJqy35o/PEumosdJPUEPzXCUWr4eoM4Gs497wmxJaW6pWqpBNA9KSj9W
         K3Pg==
X-Gm-Message-State: AFq9FYJkhA5By5W5+h6mVr/tQrdRD4pT6TPCgq8+fIbu2KLXXKkaxaGp
	kf0X7DTgS/gBCWQRlI4j6RrTLcB5DMlCrKi4Oc3uyKCufUDy7dk3qBKZtXgYCg==
X-Gm-Gg: AYBFou38MAzIVaYeuDsi3Fpx5xnJfFUI5nqkcFCP3TSNJbqOLFazj6P4iwerhWhKpOc
	cChcNuPQDF2t6qO0r/YhPdkX77Vskg3MjQbHmizaNafyddnVEsXL+tw9aP61cxeWWKH/vk0Rmsi
	ehyiAaQqhbWkXZip/5o4abmaVjNC/1+UXBAJuApIAIa2HcZxyFwi5iHgYf9jYGKwXIeS4RMFjvz
	Ovy/LfyurPcLUTynBR+hIUedril0LEdJy1MdR5LzDLp+leW3xxlHbiVRPd+O01g6jBzCwRtf51+
	0Q7daiPhFBPHyIyvrpx8yB/dwcgpdowSIJTuhWUmHzz/X4bUF2P3tCuqeHVpapa7uTAJh9Iz/H/
	7kEv/bwtLWHo+6AQi4dUcOtNaauzzCZMyiuR+A2sRRcT5CfU8wQtMg/tktkXzTj/eQ3L1WF2O1w
	JVSIx5kyveJkHMNL6uXsFudKs9RyEErbwl6eSv5ETy/ChZq/2bZcK8BF77n2xcoX9Cwd9a/ohBp
	8bOgAL561mww3lnQBuzWRx2D0wW/KsGojFcT0/U3ydsMkWMdCWWxYUIQfy38lWHwROztlGrJKcm
	KByk0SITWZ0mBnOQ0ay5vjis783ViSQb9l+w5ICchsakA5Z0dSI=
X-Received: by 2002:a05:7022:ed01:b0:141:5281:8a41 with SMTP id a92af1059eb24-1a6ce01cfb4mr7112570c88.9.1793279458889;
        Thu, 29 Oct 2026 06:10:58 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a76037e2b5sm22072457c88.21.2026.10.29.06.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:10:58 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: linux-pci@vger.kernel.org
Cc: jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk@kernel.org,
	peter.griffin@linaro.org,
	alim.akhtar@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH] PCI: exynos: Handle PHY initialization errors
Date: Thu, 29 Oct 2026 13:10:06 +0000
Message-ID: <20261029131006.2744-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Check the return values of phy_init() and phy_power_on() to
avoid continuing PCIe host initialization when PHY setup fails.

If phy_power_on() fails, call phy_exit() to release the PHY
resources initialized by phy_init() before returning the error.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index e3c05ade381b..5ad07c0be8e5 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -225,13 +225,21 @@ static int exynos_pcie_host_init(struct dw_pcie_rp *pp)
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
+	ret = phy_power_on(ep->phy);
+	if (ret) {
+		phy_exit(ep->phy);
+		return ret;
+	}
 
 	exynos_pcie_deassert_core_reset(ep);
 	exynos_pcie_enable_irq_pulse(ep);
-- 
2.55.0

