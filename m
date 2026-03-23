Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8439182F
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288687; cv=none; b=cre+NpuNKD7D3FkVhw5CupR1g1q2jdjaRPbZu70VT/QbvSsmmOGIrWTSTgTjD0EcIQUeIAujgjO08tdeIgW30FIe0iftCuEnMxRCrh21avNzgEsivt5lJ1zl57Fxnxe9e85eRdnu6pgomonOld1+9jvbtYPrBpNS1CYtQ9zsUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288687; c=relaxed/simple;
	bh=cYrcg8cZ1OOgmV+TAbZ97fcCPC0PWmH/iybgc6SDMxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VWdsuaoW8UJSXwhczeI8MguaUPa0NKebD2MIuBbAVs3cP0c8OhguKejw3uMygBdxD2NXnIyz5C92R3gq+6SkcWSFF5/Dpnx7vTXrY6knZOGBhqMRXdaQ+8hm9gTKvf6ro5jI6qmef7nlZCxd/SvCEqhuvM9NzkC8HQhMbP+HtUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaukIa+4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaukIa+4"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b05761bec1so24848075ad.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774288685; x=1774893485; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAFVmIYqCpTk7YHQuUKCiaGw6d7SaBhhkzvznBNGhns=;
        b=kaukIa+4csz/mtudT0nzcnsT0ZN3TVoF8ndd6mwSfypW8xu/NZAgVcKvbbDv6uVmy6
         Emts4ZGA8HxlTa9KNfJ39ZHGii6Cvd8/Z/rLlNmab1PFnZnYx4dhXftq5e42bSXjD9HR
         TG7fNQf9zwTkPWRAbi4DGhEFPvYcM6he3w88DIMZahXZwwWg+b3DODp/N8/25ZwV2vYU
         KY0SDJcfG4XezeLhxpjLlME++wp8KawBJk4PUkx+rt3oRUCaaAFVOfd53UlyoFg7Wjr6
         KFsX+wHA5qmSxew0+HS8Id1aieNK6vnSlmwFqkGPH580w0Pm0GVj/ftbCfhSkV9npmXC
         pFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288685; x=1774893485;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAFVmIYqCpTk7YHQuUKCiaGw6d7SaBhhkzvznBNGhns=;
        b=mRXB2rtCEVsGAOGWB8w9DHdukJ+sKQX8wQW/ihZ12yJuaHmNRShSxq1+zLxuxmaQs8
         Ku31PjDb0hZ+huX6UaP/hsUJ1WyrWpNOTKiFywLo6i5gOxo2qsJ9yo7k0XJXUY+hh0Qc
         41jua9E4IqNyySVRxbQg3ME+nFXspW9K2tzcKxv87wtmtdU4EKLYdX7vY9q5JNJ3A9yJ
         BUxVkYUDhQXvnqlbsfC6DaLep1dMWrG4mospeN1PAsvDC+8uPH+ePsvgZu8odIChGb2Z
         jQn824S3bNr9cjB5j4YUcBrWZFDJuB++NDTw9IT5cx2+WHJZBQk5AaDElChekytWExgu
         hT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBNXKH8JbCwMc2NForWgZ+Xe7smtCve3x3nwXGMVbSQIKlJzdlOCOz+YRnn9wCXf7Ycg1hAqWHggo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGCydjgWvlYNJtlxcpt231Sv4egcDBzSDxizAl3fnDkuvQlhaM
	+agfi56TGCG1F/dZvM2ZQu2kytEWKxm8bhpn8o+faSzRCyaZrM+NGDQV
X-Gm-Gg: ATEYQzw6SA8OZLWgB6+4XvH7Z/6yM75dBIP8owtex3FfLnu5CloVi8fqyyDzMtXr0j4
	FkVuCIbmzZD9IAoBYjJOcKtgehwRfLkU8RuyUwUUb6/Nya0CGvIJsl1GBUPMGzlGcFOQQuLNqoN
	+2tvXPECGxES6m/nRjdnzRDN0rFX7N8BlTQuIKPMtdeSbEsemWcG/+BTYqgKFl3VKekEGLoQQE8
	m8BHVSrBIhJCzMFRsMlrkk1ZJhSDOUMpcBeAnzsjsbj1M2HtSKMBG5gXpmHvdgL7Ks0kPDrAe6s
	C3XeG+3DpjnrAXjGxu0ecxu9SFbPexxSjjFo9D0Ad9/2ueNYvlY1i1jUEtjaix9+2AqS5EFvy7Y
	1VYA0yfREg3vSlub1MsOeOEgpi1EtPhdGoc6MiqNfx6ETDIO0jXsRiLYrH1XLyrk1YS7HYcl00t
	RI8mT0PeG9LikNK7MVquICAeqKM1WOO1DAbQDh
X-Received: by 2002:a17:903:2acc:b0:2ae:7f85:33d1 with SMTP id d9443c01a7336-2b0a4cd49e4mr4562165ad.0.1774288684737;
        Mon, 23 Mar 2026 10:58:04 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835551c3sm113415065ad.35.2026.03.23.10.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 10:58:04 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 24 Mar 2026 01:57:59 +0800
Subject: [PATCH] PCI: aspeed: Fix IRQ domain leak on platform_get_irq()
 failure
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-aspeed-v1-1-354181624c00@gmail.com>
X-B4-Tracking: v=1; b=H4sIACZ/wWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMT3cTigtTUFN0kA1MTUxNLM8MUc1MloOKCotS0zAqwQdGxtbUAgHK
 gQ1gAAAA=
X-Change-ID: 20260324-aspeed-b05454961d75
To: Jacky Chou <jacky_chou@aspeedtech.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774288681; l=1574;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=cYrcg8cZ1OOgmV+TAbZ97fcCPC0PWmH/iybgc6SDMxs=;
 b=l+RPKAQMkKB3prPtTq61GiYDOiTZZEVvZpdPRmil5aMf0ygzxdGhIKpTojXIdqk8Guifwxe3Y
 UOj7efLJOKnAPRYwxbJvxbBY6Iz1Z6VcYRmZbAzVLfAw5weD9l6RPeg
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The aspeed_pcie_probe() function calls aspeed_pcie_init_irq_domain()
which allocates pcie->intx_domain and initializes MSI. However, if
platform_get_irq() fails afterwards, the cleanup action was not yet
registered via devm_add_action_or_reset(), causing the IRQ domain
resources to leak.

Fix this by registering the devm cleanup action immediately after
aspeed_pcie_init_irq_domain() succeeds, before calling
platform_get_irq(). This ensures proper cleanup on any subsequent
failure.

Fixes: 9aa0cb68fcc1 ("PCI: aspeed: Add ASPEED PCIe RC driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/pci/controller/pcie-aspeed.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-aspeed.c b/drivers/pci/controller/pcie-aspeed.c
index 3e1a39d1e648..6acfae7d026e 100644
--- a/drivers/pci/controller/pcie-aspeed.c
+++ b/drivers/pci/controller/pcie-aspeed.c
@@ -1052,14 +1052,14 @@ static int aspeed_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
 	ret = devm_add_action_or_reset(dev, aspeed_pcie_irq_domain_free, pcie);
 	if (ret)
 		return ret;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	ret = devm_request_irq(dev, irq, aspeed_pcie_intr_handler, IRQF_SHARED,
 			       dev_name(dev), pcie);
 	if (ret)

---
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
change-id: 20260324-aspeed-b05454961d75

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

