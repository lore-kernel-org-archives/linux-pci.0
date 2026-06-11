Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137FE367B73
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208235; cv=none; b=unSda236vJLUKuqDrM0luFCBCf6Mh16Izi/vdJhOrVZLF6sSdCrGqydoJbVOe2MTJCUeRP9j87JVGqXoU0BeEh1mO0rxXEN2jHvNniTexgVox1VitCyfPZ7a3BpKAHQSrbCOxw7shdPB8ZtUgzs0GHGyAOznhM1Ku3s/cDuUkrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208235; c=relaxed/simple;
	bh=TFTAot1IKWMOYgZRmrw+FhVwE6dd6IS9bop8XrNJ0Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5Qy8af72sqxiJ3DGt3sWxin1SRa6Uvl+SbegMqbBMU91GDNCXwkitTW9qdFjJyWQyVC5T55zHFDqCo8lCXYOrodOMNht0s4YjAAY9Pm95vMTFLMQ56Nt3clYIOcgC9+eR589NKlM2F3Ud8fDf+QNXRmPI66ddKDZvfJ9oxcD1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI8rakMp; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI8rakMp"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9159f631656so37760385a.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 13:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781208233; x=1781813033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OIfDLIkJhbaUkdh0HltZEozEAObCZ7mgl0RsbHOTNY=;
        b=kI8rakMp2FwOePWW0jXoMdXYSkwLWGtjFHeU3SfX2KdD0knUU1c879EbuAHrDc5M6Q
         73A2eWooA5rg9P3FpS5Bx2XBNP8fy8MHqwvZCJowvVxhPSjiTVHJYDX59q6h0f0dvDep
         3+oIMk8yvUYafWOkDqvLCRkdx7fl76UzSjIrMJDuuOSxF8OCfC4kOn0pTZptJOku0iCL
         RJbulWj9nzCriEArD5dAkxUkXQWgOb5EQruC4o9K7zsNGkSe+IGcj3NpaQKfeAbK3vEi
         e8/4ExnVsIN3aU30X60qDPr2dB6DVbuy+a5kU57PJo0YJz4xqrRzqXfgdBVR1GOtzQop
         qlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781208233; x=1781813033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OIfDLIkJhbaUkdh0HltZEozEAObCZ7mgl0RsbHOTNY=;
        b=G1axAfrdaZW9c6O63yIw4FJtWh7j92utOMDwVij2TG1B7iPslVib+qEEPzX1J3+wL0
         HD7pdmrqpwccAJ5r4rOjMvdQ2eBwfMkWTcxcQDdM0MwV1Fzf/1pCjXW1Lqahm86D2r0V
         TR/kiDQiQdebN5IQNwFI2e3HFAe5Hg1sa82xpUu23NaM30NHtjhQe54Ix5kW9UQG3HX4
         yk0Tg8cLlTO8IVby/M7llbiGQpMA5hMcGuzDI4xxdKHIuhoJmDd1C1NgBD6puZNveBVe
         xjrqTwG0omUHyj8IDi8p/ZSZLt02Oq1bc9HtSDzsN+3iMRBcxVD5fOdY1kCNbXE4I/Bs
         k34Q==
X-Forwarded-Encrypted: i=1; AFNElJ/noeWdOGBCL8sW+SzqLn3DvBJnsTbAUUJEtO+WHmpNXIpP3/5o/ZDEzCO5++BBi7SFPRQIUuT9dLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGAlP/y0t0Jv70ghavv41LeGsms4P8hyd4ZNmWjAx1FPWq5MRl
	JAdXgQ/8CLo1UTIhG2CvFV52Z5JGHiX4+I/DeXIsIpg7x7I/FozHZLxJ
X-Gm-Gg: Acq92OHLYSmtm7l1k4Pju88PNH1g5YGfswsC8dYQaAP4E72Gani74ll2T9Sujc9ziss
	dxfV3tBwKi88ND8Nn0f2rIMbWcAPUw6fnMPWKl3GzkDgzzoeAWlIu5/TlLyIWNepSpNybJMgfeV
	0/PD6mXuFpSU+to6PyOmvYSA9aMZC28aoHX6NfTPorDMbCQQ3iSqBKhAqSta1npMrz1/FnSNEx/
	C80LNn0WjC8FrSN1hZ/dXnYRoE5Y2UnzmctOo731DpTmPJYKOXzqeFUlfhWq1HFhvZSp9oatFa4
	+ljsSoVUMT4xITKv9OMNjbduTTrZiHm2BAD/RfNzf4kppBGxbgs7sExYkPrYt6jcVchHWuanEro
	H5mqF/op9tvsA0Q9iuo9bluN5SG0o8KdvBWQE6EjAzIbTIRTIqYlbb/tVZeiVcpspQ8Exdj7SqW
	fi8VpDYhtr
X-Received: by 2002:a05:620a:288d:b0:916:5f5:de22 with SMTP id af79cd13be357-91619dfb646mr39598985a.12.1781208232857;
        Thu, 11 Jun 2026 13:03:52 -0700 (PDT)
Received: from geday ([2804:7f2:800b:f09::dead:c001])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed7215sm11571185a.7.2026.06.11.13.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:03:52 -0700 (PDT)
Date: Thu, 11 Jun 2026 17:03:46 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geraldo Nascimento <geraldogabriel@gmail.com>
Subject: [PATCH v6 2/3] PCI: rockchip-host: do not attempt 5.0 GT/s retraining
Message-ID: <fa9ed4fc6d4531a9216473151ddaebdb70398c20.1781207474.git.geraldogabriel@gmail.com>
References: <cover.1781207474.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781207474.git.geraldogabriel@gmail.com>

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
index ee1822ca01db3..1374a2c92b563 100644
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
2.54.0

