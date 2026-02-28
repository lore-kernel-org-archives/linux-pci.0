Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712F423ABBD
	for <linux-pci@vger.kernel.org>; Sat, 28 Feb 2026 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772240127; cv=none; b=WXX3WWjHQ44xEdwkeXIEckkEWv2DUMhPqV0XplvVnjCl+l4vq0v8TffbxHrjQJi2REKxv8dUzxqDay5Q2kti35paYYrM6psXs+2MqZaqaM9STV4+b7qAGPhwGEpTeo3ncikxgC7vvOe4jIf01UFOmVg9s5AGWPnEFVB3l2cy7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772240127; c=relaxed/simple;
	bh=GFndJvD0S3ipzYYAdq+4KgS0M9aqAQasboqVroQdCZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDgy6kyQbnm2EjgpoLJSswTtYeMxQsTglpPwyfCGJi0OelkK3mWOHrbg013QKhYfJYzWzsFz0CdobHqfoamvy+3pBEFvygQph0J7z21PmZS7dDjvtLbnfViLwAaNOhO8Rf10wX2G7NooQxyXeEEvarZNc2DXKCDJqGJ5+kMPdS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=celMQwMr; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="celMQwMr"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5674f3e80edso2771032e0c.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 16:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772240125; x=1772844925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3by8dItpKgMsvPGS2Pus1C94W5lhtexananCbnyqhcM=;
        b=celMQwMr94Le3hC7Qy5ifsVgt77NHUcTs8kA+3ASHkQxfrAjCZbJhEqONbPPRQX8oH
         jYlwSTOmfvNIXD98YEFRUVnW5Z/iNSWl/va00oHp2UmkIrKprmV237ZzfTmZLHZ0iKq/
         ZNaNgv4Z0Zr+kcu9aebvLEXrZek05FNTdLomqGlQFKXKqfW8EI+IMZWo55lYzus5t2e4
         Z0byeAAzl4ei4u1U0u0rUEhSdjGJSP4ONdWwRodPvrceJmAMk8BLke5SHtNzvaNDkGba
         LIVVI9pPs3DeAPNe6gv7BXiZAjRzsvRA9g4VoBBrTZT5+KKBCG7DGA9ifJ8V0Q/xlDId
         xDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772240125; x=1772844925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3by8dItpKgMsvPGS2Pus1C94W5lhtexananCbnyqhcM=;
        b=TIBaWNWpUzRnQJ/QSPFWDRY+8xNnYN99+9890Qj/wKaa4mm2UvUnm5Fmk9QWHkP+XH
         NP/ixxOn32SWar5V21kVLz1n7fno2CWG0D+i1ES31nA6f5pmzJr2241dGpooAGhoFypO
         yWjEp/bbt5LLdni4SfcdpUrK2HjwUEizZNhl3b2xT64Cmp1yRr0I1fztITZKyG4aVCDi
         I4slLko3VCZtsJ3W1motstvTy2eVlRdFvHRRvHvW4kiPE96tFexTZ8Kkml760hu2zEcV
         FH2XnY8D7SO1YFfu6ZllAIUAxL1bkDtBm+p1qkcYQhQG2FP1zmgVFZg/GMMHJDDVatDx
         4fhA==
X-Forwarded-Encrypted: i=1; AJvYcCWiBCprJAkAAx5YNMa6qAS9lCm/BTMeDqX/RCl4HDeXLcMNJ0fn3ALFBGRCl4xpjaABCwjRitPrvsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq0j1PPcKZPxOEVihx7YtjWZQdbM8NAvdZnRDVMCFU8dg7XntF
	1o+H2ZhOLKjU/AoZR3zZSbB/u6gwgwUf4t58eZVw+vC4SCt2vxP66LqG
X-Gm-Gg: ATEYQzxHfiFkWMfwihDfKVKEihkF32n1yME0mLXSxWPrZ+cl50HlzcwxfmkeOJ2DTD6
	xaodms37V53U2YRWdE33NINtxqyzu551wg3W9xcBahyHra9D0D29gbdfJ0Lm6bK2Q1gMlEcOhCo
	3TsTiZHCH9pyrMFQ3uFYpNP1Ix+3puPnnMgoY5Bvzzd3aTeAXfVovVNn9LN3QlkTEk8lXVt6Jri
	0Ndpq1WTZTPDieBIjAHkIea66K02+CuOLR81l6uxb4LOOx0RsN02SI8mOuPOC0Y7T2GUlv54S85
	YTSqJSXOeWnUmu0S4IXJfj5M3vRUnWxtIssgRXzRvgTnat/OJ4N0wWhihswfGp2y3rdKHRNQCjs
	jZqAtt0EuEDTWsePrbDcSeWossBGCi+QzNHT3D4amJ498HLJ3Wbbso125CKQ3i4RNwLuObTW4TF
	Z3YE4SoNq72Q==
X-Received: by 2002:a05:6102:3047:b0:5fe:f592:1626 with SMTP id ada2fe7eead31-5ff1cda9994mr5177242137.3.1772240125413;
        Fri, 27 Feb 2026 16:55:25 -0800 (PST)
Received: from geday ([2804:7f2:800b:feb1::dead:c001])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df63d6695sm6182090241.1.2026.02.27.16.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:55:25 -0800 (PST)
Date: Fri, 27 Feb 2026 21:55:19 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Geraldo Nascimento <geraldogabriel@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] PCI: rockchip-host: do not attempt 5.0 GT/s retraining
Message-ID: <4fa2c439482725bb191a225a3966300cea253db1.1772239598.git.geraldogabriel@gmail.com>
References: <cover.1772239598.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772239598.git.geraldogabriel@gmail.com>

Drop the 5.0 GT/s Link Speed retraining from Rockchip PCIe Root
Complex Mode Operation, so called host driver.

The reason is that Shawn Lin from Rockchip has reiterated that there
may be danger of "catastrophic failure" in using their PCIe with
5.0GT/s speeds.

While Rockchip has done so informally without issuing a proper errata,
and the particulars are thus unknown, this may cause data loss or
worse.

This change is corroborated by RK3399 official datasheet [1], which
states maximum link speed for this platform is 2.5 GT/s.

[1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf

Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
Cc: stable@vger.kernel.org
Reported-by: Dragan Simic <dsimic@manjaro.org>
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..1374a2c92b56 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -328,26 +328,6 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		goto err_power_off_phy;
 	}
 
-	if (rockchip->link_gen == 2) {
-		/*
-		 * Enable retrain for gen2. This should be configured only after
-		 * gen1 finished.
-		 */
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
-		status &= ~PCI_EXP_LNKCTL2_TLS;
-		status |= PCI_EXP_LNKCTL2_TLS_5_0GT;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
-		status |= PCI_EXP_LNKCTL_RL;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
-
-		err = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
-					 status, PCIE_LINK_IS_GEN2(status), 20,
-					 500 * USEC_PER_MSEC);
-		if (err)
-			dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
-	}
-
 	/* Check the final link width from negotiated lane counter from MGMT */
 	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
 	status = 0x1 << ((status & PCIE_CORE_PL_CONF_LANE_MASK) >>
-- 
2.52.0

