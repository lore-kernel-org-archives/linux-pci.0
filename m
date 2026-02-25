Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AEF30EF9B
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058476; cv=none; b=Il+2jRkQd76Ds6vTGbBTLUrfhz0kN/4JkemmxGA7c259JWytrFq3GbN4bkzb6ha9foI3VJs5az9LYmV8s+j7KRdRJT+S10zxx0BVOiVA1QwTMipuUZwh3iCthIuaOnB92ad5CSwnx7Cq6fcNnynDAEibyzG/PnuLuReKg7wsBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058476; c=relaxed/simple;
	bh=iyTeSfTJMYGYxdgoCrwsYsndSeF9ybjDDhtlwvg2Ytc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqkdGwUAoJNNjDNYwvRSBcu+NApKZ6VZ0Fk1alU1rhiWD5ppQbRXHbBTIaSz8UZIEvHFkcHIkjeybJu8Bb0a+1LnHZq423CESJti7yKx71uvmlvMcUtjDTtXS+2RsEG7WXg8aMcnSweDP5HYYt0w6j00YM5q31O5Wu8DXVJ7UHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBoZuO5K; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBoZuO5K"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56753dc51baso136337e0c.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 14:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772058471; x=1772663271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RbmElmhsWLmxkCWwbLCza2bJ6ctDAX0b+gZt/+eBHkg=;
        b=bBoZuO5KyP+4PLXPuu42xPJ8lUzGcdlNWo7aoycArjbY+fLwE1x8ukpY02aVIkwKfs
         1tUco5HIH7c+Bvz11U/my0A5l8KUK7dalPnL2cInjGFOTcRA/yPpR5HDPf7F10DOhgX4
         mblZEgxXdh8uf0vGhwhCwG3RxGFBdEO79BQWuFVM3oluL4k6dhsjTafgMzEQtq8JorEa
         FKt8bLZn4yrLfzo79qzjIB/VGBwQP6thKltG3gTQk372jtk0NbFHhnE24NfWcNQlRsLO
         aLe7mBrA/DuBnWoRPJ/aRQFQ3oTEE9rmz+yOkX3bfBFQxrt6YyHhHFxJwO94R41pOyLS
         niQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058471; x=1772663271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbmElmhsWLmxkCWwbLCza2bJ6ctDAX0b+gZt/+eBHkg=;
        b=oUxgMeaV2WDatOw/6eTlmmVMzxZzBfpXskMYQ91JLyEyf1I/FOIFEfDzx/Ul2rDsdR
         kMr5E461CQQO9XQmTPYLKehr+0y/7KQtZ6Ie/XQ+pUFY8GC8Olvuh4U7S2HYxgEvFMfh
         qQEXxbJe9jSFqFvBzKFnNHaoOJaj6t85Z16oY3IWGEBVADrLMH7/r9/3rKKe+cixleA5
         cLNgtI/1/yIv7CD7e+BCihqBREvnZ87vd2aL1BFEqpeAaoS5t1SZ+/VcKy2Z7TthGXI6
         fbLEZqAjOMCI8JJUCEkJQlcSJd99ZP/Z2rAHlkPVvjIe+pde/VSIgh0XKev8SVjfppWl
         FEAg==
X-Forwarded-Encrypted: i=1; AJvYcCVPNNN1igzaN7Twra+lHjUiiw2radb4ufLCZI2hSiJ3OOKuxY7kFF4fPuBSqADi/GN7cLi6rYaUSEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/GqGKFk/Vs0VPfAcOmlfA7xEwiFdT7p8y8kIHhyXRxR22c0J
	zEMPfnW0XaOso1m5QB5YDGGBe08Be8dUPc4MY52WwfBekNZihNSc1PEW
X-Gm-Gg: ATEYQzwD2A234iSbOPewD3WKaAMquZaHCo7iYHGvkGMoYIupuH4YicpiGNJd5Uwmxk7
	XeAgw05Tz1hvry2Sld16UL8HKT61xHnlI5LDy16l3A0PO3A9jCK0ppwluzAhdkiSDEcu9r/YHIS
	HxBeZg5OGdPRVD7DM5Cl6OCkravj6tsU67LGLg/8bfKmdD/kN7frK2e7ftv0yfFX6P8GN19cIOS
	awSV5LjLDAddiwC2xcMOx/7Ups9tbMprkUUx8h0urcvTe6g2JqHeBNJPOh7ZuP0PjP8flc5vYmq
	c+vJJlB5gzfyiZHOQZ7YuLiHeYHQyfnDGhzO2wiaUucCzNlUnPOrnlwG9sjZDnN07QH5m7v8IXr
	PVhGJDfiFS/1inX86k5XV3rSpRzisuf8kWErxQC8iSuTMgcVXTHqxn1BD3hVM2fwZXPWyLEj5Sg
	3RpPFM7ajknw==
X-Received: by 2002:a05:6122:3306:b0:566:37dc:e219 with SMTP id 71dfb90a1353d-568e48c946cmr7126900e0c.15.1772058470884;
        Wed, 25 Feb 2026 14:27:50 -0800 (PST)
Received: from geday ([2804:7f2:800b:f14d::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a922afe47sm399366e0c.20.2026.02.25.14.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:27:50 -0800 (PST)
Date: Wed, 25 Feb 2026 19:27:44 -0300
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
Subject: [PATCH v3 2/2] PCI: rockchip-host: comment danger of 5.0 GT/s speed
Message-ID: <8db835ffe384db63ee598a203751b298ad1cc267.1772057799.git.geraldogabriel@gmail.com>
References: <cover.1772057799.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772057799.git.geraldogabriel@gmail.com>

According to Rockchip sources, there is grave danger in enabling 5.0
GT/s speed for this core. Add a comment documenting this risk of
"catastrophic failure" and discouraging end-users from forcing
higher speed.

Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
Cc: stable@vger.kernel.org
Reported-by: Dragan Simic <dsimic@manjaro.org>
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..4faf3e29b7d5 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -332,6 +332,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		/*
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
+		 *
+		 * Dangerous and may lead to "catastrophic failure", with data loss
+		 * or worse!
+		 *
 		 */
 		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
 		status &= ~PCI_EXP_LNKCTL2_TLS;
-- 
2.52.0

