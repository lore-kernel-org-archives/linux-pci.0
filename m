Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E9E2FC01B
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051269; cv=none; b=hjwoTIj32Vsi/qyzwy6pDX8ny9Je1BqcEHRotprYXqpYIyvv9AoaPh1ZBB+DwBzb6zZY81VWY1yxuYBbUObC+FyldOz7KTsTYOuHnIubzTF6Idkw4JSpz/myV0Cok6Qg7Xbod+owHxN+qEg/5QqjaTvV2W+gF1aLNyXWS22usOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051269; c=relaxed/simple;
	bh=QEgwM4+/RhGOMdSlpWGlH6KNEi9GHlqz5GurH9laiK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nhZvM0n+CZu6eJScqaTWJ688JWEWie7Ru1fCWEy3fbFD3X0MNCtQywNMvqWnjAYvh19Jaei0AV//gVmtN6Y73SitGqeTz8gah+8pJcbnz+JFfePZr+gPiYKE4OGpxMeYCsCJBAzLooWA1O4LVW8ljFViX+go2cJ0q85nv12+8ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qn59xMRG; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn59xMRG"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-381072761d4so2805884a91.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784051239; x=1784656039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=48m7ZUVyAh4340rgEn6wpMS/OciDAanVDkT1mjQlqdA=;
        b=Qn59xMRGQoDXGEFG8R81E4empLv/p3UDGJSkdB23AojYOuta9uDtld5f2KsCjg9DO1
         jCQ5qqMb3Z/WpAtI3XKHf+yjAks6l6Ck6dxCW1moNrIaGY3oYVQnXgpt2IKacKtulWM/
         CT6Jd5cmXv/I8op5dkaCj6SUZ5UThOV9vuL+4qpfko4zdDLbfZg5WWkQiwCdIDJ928GD
         ypWEcMcE51mNNt3n4RkNL5nbujbuKaamIanDEbzcQAdrF96sOJtKAp0piA/EiE75lJf4
         /n45gXTmUUSf8cqTFd7t/zjZqe8r9HYZUkcw49qsafVxAt1RnZ4ZOvSOp/46hp5SSc0T
         tbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051239; x=1784656039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=48m7ZUVyAh4340rgEn6wpMS/OciDAanVDkT1mjQlqdA=;
        b=KG9N6deQ+e6m4WVnjkoSPSuILROVRXmCgC+O5bub8M0zS1/e3DUJdkCjZCuP1caVyH
         pVNnzbld8k4/Ll4E2hnqSsdY4o3AWsjDEOhJrOuRfUbF317IfAr6OCkhAW+Jgc74U3BL
         9PO0J2szoM9Utjqg+1YAQk9a35+dLfaZRdX1ZQGRmOxJwPuNSCIW6XthYdtF+BsmqHMD
         S7clAUMoe2n+rs/EoszzPkeY1hX+Zun5nOo9UamkmOwkXu6KXTpXa+J7OqzI3SGGcgkt
         IvhxF2lQ2+Xwu7enNE/eov0aOfGu4LQsqoWnkEaBc1Pvxp7ikRgRzXG9FNP6dcWhH4be
         Rvsw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4c7/NsD2rYC4FFtlOS4LDPbliWyvwl4+7gWZiUAsZyntz3ODtP48tdp2K6naomGO0O3B0m68bInY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxELNN9QVbfnSYk8UYnLVTG43xTw2VaVC8ybpNSI3hyUv985IgO
	HpFG14DkxLiJWICiWNuLiRUumuGWz4b6rRyuePjq0Y+TqY2c5MD8SQsJ
X-Gm-Gg: AfdE7cmLPvYiaxaikTIq5ogw5t1xuHYxjE7FhBgV0bcI5w3YK3ZnrkGXtFwYoZ2fzFu
	7d0yHXmepWDPkLXeuQ9S7MSqGmpfN2XhFJlMZnLWlwbC6qW1YWTty5PjIKDME9lp0OIhqDKtwwE
	zJY8k15g6CladhfFObu41emo6XcBP+zDAAF776eqR8vVVR7zwHj/KcqCIRvzbHAxsq4H0CO+LW2
	wWERv9kGqjSUXRPfBtj+abvd67oI0/13oobgY6W7rIPfT0qlLaXWnck06zQqmgrpCoDSsFDyYIm
	9rdwDx2lTv1UBHACjgCEm+f1fYpAUvPZi2CWBfpoy9ZZaucULNzQc+/ucxmIGMIymVmtNKEDnkW
	gLv5BhA2hYSQn6Xh546lqHsR3T6Y7CkdgN4I0VFScBwuhCV8dXXQAC5aF66eQEz9C7TYasqUvDZ
	b+nA/GXGlvhxqfc/yuo7I=
X-Received: by 2002:a17:90b:4f48:b0:36b:a2cc:485b with SMTP id 98e67ed59e1d1-38dc7769d4bmr13734883a91.21.1784051239110;
        Tue, 14 Jul 2026 10:47:19 -0700 (PDT)
Received: from workstation.. ([182.180.105.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf8c12sm120691975ad.26.2026.07.14.10.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:47:18 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: Daire McNamara <daire.mcnamara@microchip.com>
Cc: Ali Tariq <alitariq45892@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mason Huo <mason.huo@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR PLDA PCIE IP),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: plda: Synchronize chained IRQs during deinitialization
Date: Tue, 14 Jul 2026 22:43:45 +0500
Message-Id: <20260714174345.1073909-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During driver unbind or probe failure teardown,
plda_pcie_irq_domain_deinit() unlinks the chained interrupt
handlers for the main, MSI, and INTx interrupts using
irq_set_chained_handler_and_data(). However, this function
only updates the handler pointers and does not wait for any
in-flight interrupt handlers running on other CPUs to finish.

If a PCIe interrupt fires concurrently with the teardown
process, the handler could continue running on another CPU.
If the hardware clocks are disabled shortly after in
host_deinit(), the executing handler will attempt to read
un-clocked PCIe registers, triggering a fatal system bus
fault (external abort) or kernel panic.

Add synchronize_irq() after clearing each chained handler to
guarantee that any executing handlers have fully completed
before proceeding with interrupt domain removal and hardware
deinitialization.

Fixes: 76c911396807 ("PCI: plda: Add host init/deinit and map bus functions")
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
---
 drivers/pci/controller/plda/pcie-plda-host.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index f9a34f323ad8..f6759e255c75 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -560,8 +560,13 @@ EXPORT_SYMBOL_GPL(plda_pcie_setup_iomems);
 static void plda_pcie_irq_domain_deinit(struct plda_pcie_rp *pcie)
 {
 	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
+	synchronize_irq(pcie->irq);
+
 	irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
+	synchronize_irq(pcie->msi_irq);
+
 	irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);
+	synchronize_irq(pcie->intx_irq);
 
 	irq_domain_remove(pcie->msi.dev_domain);
 
-- 
2.34.1

