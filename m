Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B897427A1A
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954328; cv=none; b=HT1XQWF+6bxaYRzl+TmKfdFuii+88NcUOhHPLSlMfNhGpDEtu+c0lAJCzX0eaCPw2wtFE3bmpq1hh9oS8SZDjGAx1yl85RbdsgFCXeUR40ny65PlMjhLOu7D9VYLUlhPPRdvF572rzNXIjGTXbKPlYX3gReclv70hOvAHxdQtrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954328; c=relaxed/simple;
	bh=79YO/wfHgd/0O6mQKwHAioRHxkqGkaQ4vgsQuubKFP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uKIyNWVKMGEgSSg7NvPyzREWd5ssUIbHTS1X8ibcJYIW12U0Ns26EiG7OfUuQUwy52v2kqifzffINGJomlcRsVaYRHzZkWs8b6mftYzOB1O93If2OA4gGoGAkq672pAEDCJwEIXnWG4pXE8gkMnam/6lB6ifkq1vALcbhnPhmO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID3tsAc1; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID3tsAc1"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-473ba029526so377566f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783954325; x=1784559125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YNR4lJereWmoqdda1rZEj7eFGTOnLHHANTTIU33C4F8=;
        b=ID3tsAc1bqsTf8l/JtUoeQvF7OFA8xXHT2l6z1yTmg7FX3+K4wjRZ2YnDf+bkWjni1
         MKAlucpidjPuXFs+AuDQkNf/2hGuK2qyPQri8EpyWpRLq4x9XtGCFKQ0E8w9hn2X+geP
         FKxuOplICsKhRB9R3JCTgKSMocdx0PRnDS5/QY5e7/+N08CkDYD7RE/ikMpIVgRz+cIx
         gelAFL1aRuRmcUWGTuE9U03xP5HzpWf4UWDaWguioIYRYEaXOUeJYW1dBjEVh9xSeOL0
         Y/XjPiO8Xo7BlpB8fJKqr9HU9jyIYZaabNrLNjPm8ReEU+2BgtEMO1yLhIvFLWFP0bWy
         lT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783954325; x=1784559125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YNR4lJereWmoqdda1rZEj7eFGTOnLHHANTTIU33C4F8=;
        b=QHkTL8I50lC1vO6qPwD4QH2jqddHluagF7lv3Cnld2MU9QK5+QkgVupInv3RUHZmGS
         yRs9FmbY7oE/mdzh1UTBS5C7RkJ47K0MsxNn9p7g4WNJ4E9q5TtjBruTzYRmshgoMYKV
         IxFsCD+xRkX+lTbS7CuAiMb5Osnp6u/YAqqHwFSJOYJvWMJfQXZgK2GPtwLexwwRYzDr
         cn6RAD5oEzu+rFGW6m2MEKgPDzIbyGRiF9SeLeXjyP6dMWtWa8TG0r8A9iitXCTc564W
         L4MFW2i+o+BY1Hg4OLyBxfoQI8E29GtFXCLPtsMmQa0XX9lrdO1IIE+FhuOiLu71riWy
         XkCA==
X-Forwarded-Encrypted: i=1; AHgh+RoM3rAfafUsFxxH/ahpi+UtLklcEmBm4d3DU/2tlouwlIPVDrzUizvPLHAWZ8TFPMAuoOWoedh8MyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY+R/qdmzmAx2vZn6yybXliwQhS6ztzt8ggy8b1NsuoZlyMFiO
	OUCQ/gGpJxI6mErVhZSdR9mFld/dCeEs1YakrRzzPLU/JEUKpR2HMZP9
X-Gm-Gg: AfdE7cmOP7Qz15sGm7M8Ls3TwI0eTDL0e4JRcfBHj3ms6Td6yldS/kS9GD3pVtTEl9o
	acUIQVoAi2IHSOqyssRtZ+2gdzQbXLNUbfROV4QLUjbagB0Q981w1avdWHNTQrFnJ2iigcE3MdA
	GxTp7AmJO10E4zl4p7K53HRE72QrH8nUM4WotH5YR2mKJZrHTMObTOQf/NAGwtTgVaGS+Fgyrn4
	GQs+d1sKc99dojLSI70Gr4BM2m5dVaBvEHc/Tz/XLR2phGsrIyZ6IN9P/oXs7qQ8QaoJiFdcVNW
	Rn+dmFmZVSjduDYYWEGxCm/ujOYp5WcVrWsoQS0R8cWB0e7yUAQERoWVxm3bdXjfOWNAgvzylAz
	kJnXeE8+zZeHS2rosZ/CSpJej5ZiQ+UIFJxaiwHFKgkyAosks7tPbzqIK4KyTIuc/3gfKl2rdJt
	CL4WrtLdZLLC77zTQ2Ew==
X-Received: by 2002:a05:6000:250d:b0:473:fc10:f675 with SMTP id ffacd0b85a97d-47f2dcc0fe2mr9317908f8f.18.1783954324427;
        Mon, 13 Jul 2026 07:52:04 -0700 (PDT)
Received: from workstation.. ([110.93.227.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f25b23b7esm30983183f8f.18.2026.07.13.07.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:52:03 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: Kevin Xie <kevin.xie@starfivetech.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Tariq <alitariq45892@gmail.com>
Subject: [PATCH] PCI: starfive: Fix Runtime PM handling and teardown ordering
Date: Mon, 13 Jul 2026 19:50:14 +0500
Message-Id: <20260713145014.740898-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
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

