Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41E236165F
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028771; cv=none; b=G1QxlygJZt6k2OeHi9LlJ3izd109Ofh4aSoQ6pTNfL/UxiXY47BVHT4ObkGJTeQwTnxy2esy4GJSDIhofgwAyslP/eARYtpEYD+AHAPm7HFoHuU1cLls+1JQCgcixtYdK2lf+iPuya/+Pmwusefx+XWI8f96fQ3x87i+P2+eK6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028771; c=relaxed/simple;
	bh=nk6ij8m7Zpi2wCCb+1Qocqv0IWRRM/FTiNUiT4mA4+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VUzzwlTyfGqWy0yJXl95aS1lvf3MGg+TrGgVUTYhEWPNSpdeWurtGgNTxtqfdvdSaJm4E6+D0FiHm4lS17+LwlhEAnhs+hSB8XraCk25m0+XEBwkVxUhfTT26/Gfh1sbzEwNE0M5tycf5LVy+vZwTFfBu/Bgn2TAwtHaRMTqmb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qj/eBqtJ; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj/eBqtJ"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca7fcfe1669so2287068a12.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784028769; x=1784633569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lZ7+kvUeHIUnK6IkwGO8eHuMPv0cKv2pkPNX/MO8DzI=;
        b=Qj/eBqtJxIOgntDmTM6tFVyNjya9Y/x2fNuhj2giXBU2WPBAJxX3AbSpWkwpvEZ7qz
         VhCiY8YjQkG3tO8lH9EeKE5L/cVMK04eEML3Ox8/6kItkhWg1LqJk/LkSWKdjHUgO5H7
         be30koElmKAKmyAqBYGfmqoZDDtbkGtvivJ20KA8jcVrk/DWvAnev4D4+j5N72NywLt4
         2LVU3tJ/GCujDwsKCkThZ6bNTHYVTh3/M8A18cvh+yzqmDlk2iwrM4kWA0i6Z8RvCnFg
         SIU+0SAiCb7Kds2JCyf0n90xN9Auavj3fNkBTuX3kaZIySpy4zOPaxwgOBNrF4tIi5JF
         lcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784028769; x=1784633569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lZ7+kvUeHIUnK6IkwGO8eHuMPv0cKv2pkPNX/MO8DzI=;
        b=JKojVOa6nptKZMv1gefx5wr+3h6OYespGu/kTrcVZX8w1kBEiEs9/DRqdreO9z/5KP
         1Pc6lfU7BOcxSJs9jTN4BX8TXa8KmQPxFol22lpjHluiNd9Xv+lgqjRXcljGXdeJrGeW
         IFcCXEZixFJd3jdW6B+kw7tnTzIsFKde5ERsigxAFhwQDOFs8TbS0/2UduWm3BXveLqd
         n7ZfhSSGGzQG1SCXrWtF5zzzJDZt0GWnBqY/5PuKm/1c7i5/GllN8Nkt1D86Mhcobl3i
         wA8AuaPJhSlGrtK1X4tUvaPady6FO21fLU+nFADiUOoatxzvj90mkCf5FwQEAMj0RLk/
         C6yA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2PUgW+QsXmWdt/KfmVIsvxlx/0AaqahEEMNwmJEUmJg+dMPHIKokdKITe7CwXsEIzZhemP+vXb50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh0YTGfBnPJEqqK7o0RhjBBTJhHLR5H9JVCObwas6iywD8uw8B
	fqACghLSM5/3Gf0bh5SPisHSALPAtxvsLakbh+LnPig9oXaU37SeOWdeMIj0fzw6
X-Gm-Gg: AfdE7ckxsPbDB/2komsuirAc/OhVyjasEJmXUDxjCMK4lA3NhxKMM1ZdGo7G+c1x7OF
	0ZhJqiDQ7dGBMQN+YLFs9hSjvxXdD9DEW0FMhwIcN8Z6G2fHSILptTNGq4rb088JgrxilM7bZHo
	HrZZ88mb5pcUnmLe8P7zJ1SOemkF5LVCDgXcuMFtxTQpsQJss7VFD3Sz2iISRB6RTeZcqIBRy91
	g0fJmzFhlRY4f9DNJAH0yP8A6WigBcgFCYyuJ4FV+vximYCjV62eXDxv6Ds3KB2PTUL7VZJZgXL
	yoaZZoYDcahjt5f09Sol/Ej7/Ep7SbZARhXizUpWTFiUQDLSKckO94AT2dPColXLH95yvtWWuoP
	qipMG57I2v7Yu/shkZ9FHYr8aojFFPK2ZP0XiA1lm97CnMvFeDY/X2LiaKK551VKvrDiG+JS2wE
	sC2XWy9krc/zEKXqPctA==
X-Received: by 2002:a05:6a00:855:b0:848:4ff5:5311 with SMTP id d2e1a72fcca58-84a51467aedmr3389711b3a.28.1784028769162;
        Tue, 14 Jul 2026 04:32:49 -0700 (PDT)
Received: from workstation.. ([110.93.227.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3b251eesm9508600a12.31.2026.07.14.04.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:32:48 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: Kevin Xie <kevin.xie@starfivetech.com>
Cc: Ali Tariq <alitariq45892@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR STARFIVE JH71x0),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: starfive: Fix resource leaks on error paths in host_init()
Date: Tue, 14 Jul 2026 16:30:29 +0500
Message-Id: <20260714113029.326207-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

starfive_pcie_host_init() acquires the PHY, clocks/resets, and an
optional regulator in sequence, but does not correctly unwind these
resources when a later step fails.

If starfive_pcie_clk_rst_init() fails after the PHY has already been
successfully enabled, the function returns directly without disabling
the PHY, leaking it and leaving it powered.

If regulator_enable() fails for the optional vpcie3v3 regulator, the
failure is only logged; the function falls through and returns
success, leaving the driver believing the regulator is enabled while
continuing to configure PCIe hardware that may be unpowered. This
also leaves the clocks and PHY enabled with nothing to clean them up.

Disable the PHY on the clk/reset failure path, and disable the
clocks/resets and PHY, then return the error, if the regulator fails
to enable.

Build-tested and boot-tested on StarFive VisionFive 2 v1.2A

Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
---
 drivers/pci/controller/plda/pcie-starfive.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index ba8ef7842e35..156b31eef868 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -303,13 +303,19 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 			   STG_SYSCON_CLKREQ, STG_SYSCON_CLKREQ);
 
 	ret = starfive_pcie_clk_rst_init(pcie);
-	if (ret)
+	if (ret) {
+		starfive_pcie_disable_phy(pcie);
 		return ret;
+	}
 
 	if (pcie->vpcie3v3) {
 		ret = regulator_enable(pcie->vpcie3v3);
-		if (ret)
+		if (ret) {
 			dev_err_probe(dev, ret, "failed to enable vpcie3v3 regulator\n");
+			starfive_pcie_clk_rst_deinit(pcie);
+			starfive_pcie_disable_phy(pcie);
+			return ret;
+		}
 	}
 
 	if (pcie->reset_gpio)
-- 
2.34.1

