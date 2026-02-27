Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95F02F12B3
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 05:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772170598; cv=none; b=m4L8mTYUBP6rsdCjOH4mFXVdx9FbLs0d4lT5IDVVNxHTV2VJZonC+FI0oEWqxFoujsf1sDKvBZzm274JNBWffSxOb4jfCFAYtWfYIHaSCypetZs54N/hU23klFhCgdTb6x7QVvEvA+ZHiHMzzZycTsNwXSDJkKLPe600IlTf6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772170598; c=relaxed/simple;
	bh=AJDezbdBSE4yYAAwHOt3MOZ3kgfMlnzZJDtkUSMJC2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wxm7bSmBkH8QfHD0Dp0q4hWxyy9KoJLWKoeoanXy0RKZ1V5/jyF9P8Ay2RDD+qyB1MNJaadjtfir3S0fkAih7pXaGf0PZlfz3aLLqDsy1nkC96m0Gudh3mhYNHEZ828kJZTxLpKNk1wliwBJmSd3tltqIcuSUbMDeI/KDK9+CtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCZu9AeE; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCZu9AeE"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5fdf6ad2517so935891137.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 21:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772170596; x=1772775396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ahdwK5YE/BVFVzjUz+/VzjFDN6Ot/+6hz0uB3cz4GE=;
        b=lCZu9AeEvwlnqyzvbQ+3w7MhcIU4VlCdRUy2sBiOTOlu2SyiQGEexznBbAHLZDj3cR
         37JzHMiHF/uRPclSZXQBRhBC6GaoBGJkPixStAFJAl3BYJYCPqQDWS6g4UrXyCNPR1P0
         eXfj4ecwu8y4mS8St0W3+BxQScT2je45Zt0D24fCc1i/UcgSCyE9Q+i1g8YzmOu4Psua
         bmyWp4PPxV0R2j8oHhyDPpF7o9WOYMMuSRoUmLuRsGJOv5lC77tNu9VI6ehdCOJmfbCh
         04srIholeF8Z34wbxJfCQM1CuIdZbUi1VkfZYag5aWXY8aHz5q9X9yUGqwwiWwIvg3KG
         3Ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772170596; x=1772775396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ahdwK5YE/BVFVzjUz+/VzjFDN6Ot/+6hz0uB3cz4GE=;
        b=uJAm7vo47wu1Yt25BYM558HI+x7AQZJaD+pGBL4FO2FhfiamSUwavukYTaqJVcRJmK
         FkexfQ4BY9Rd7RU1974xZPm60qqH4kdu3thCa33lSQ5R757uGCk7bnXtpuhMo6lzjf/A
         iau5dGX/uxjDH1rzmvXovMgvjYmmWn2vk/CRbo2qZfAYGmGhR5o099ezmOD7p/DIakkh
         7vsFXC8ske6MYkjBtG7Sq9eSUYmA9pQvLZc2va75yXgWZ4nIhwRXWB3qgQOl254loEZF
         k059FRzd8yplRijLHxvEMQayLR5U/oMCxBjbDiy4EKdytl1oua9Svx7PAJ0JhWMlS3h5
         lD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvsdimd/1xRDiCeSS+h2pVKKoHqEsLv6PXFEXDh0nVt8rQZLxn4JaBJWXmXZCQxKOoHzjydVvjcUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRpS2YmTEvHegFEP4jjehJ4rVmJmiAbyvxN5M/KZRnAl8mi1s9
	G3Dge4WKkBJ2WHtG57FLcr5uVUTuO9QbbQpgkI9NgBEz6Man4bLMBwqc
X-Gm-Gg: ATEYQzxEnGyETOw4GQATJWE99h3qAN8q5Ks66xfJwYoeWkktKXcYwjgk1+w+tAhUdiO
	boUHa81HQTFfVAPmSWT6OPM3rdu1YWcBhcu/0a1WJ+7q0aVa72jkbIVlI2ZjoVNZUGyBXabkicX
	xZmxTcDVwI+yiEYGTVat10oHYKc6QGhDlHEjxTyAP3W4L8bStv4LWeSCdh7nOqkwlRvJXsrg1Ea
	LI2nRPxnLgqvB9DymQ3zTQYR/KTjt1gLyRGZhxImJQIzbmHE1hy1SS6u15Kyh2IOLH+iuBwXiEY
	rrVEylII0M16tZy+TilGYazZ3so1S2r+AgqBIiLlZdwN/HW9S44S2ujki3AHnGSwMj3C8ITxmYF
	8QYnxnbeYeEan5EpTbZD9simV1T8HUqAU/NFcTnsbtnzZR3iKrfMhzQ3ZntChXa+zOCzHN4gLz3
	9qMTaCzmcB5A==
X-Received: by 2002:a05:6102:a4c:b0:5f7:2430:5340 with SMTP id ada2fe7eead31-5ff324986b1mr1096585137.21.1772170595887;
        Thu, 26 Feb 2026 21:36:35 -0800 (PST)
Received: from geday ([2804:7f2:800b:feb1::dead:c001])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1e8240d2sm4431027137.6.2026.02.26.21.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:36:34 -0800 (PST)
Date: Fri, 27 Feb 2026 02:36:27 -0300
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
Subject: [PATCH v4 3/4] PCI: rockchip-host: do not attempt 5.0 GT/s retraining
Message-ID: <92662fce5ebb28d21d0c68631a23ab8afb815a90.1772169998.git.geraldogabriel@gmail.com>
References: <cover.1772169998.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772169998.git.geraldogabriel@gmail.com>

Drop the 5.0 GT/s Link Speed retraining from Rockchip PCIe Root
Complex Mode Operation, so called host driver.

The reason is that Shawn Lin from Rockchip has reiterated that there
may be danger of "catastrophic failure" in using their PCIe with
5.0 GT/s speeds.

While Rockchip has done so informally without issuing a proper
errata, and the particulars are thus unknown, this may cause data
loss or worse.

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

