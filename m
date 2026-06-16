Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA8C43E4B4
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623581; cv=none; b=JD2ljLPN+vc1KJf09eCUmn47xRRcGqekjJcyfOn6y0gtgYz4RnyvGZenJNWdpYSE0RKQzhQ9ONE/uAz3Cw5JZFvB3i7heARBGrmPR3HyAYWypxSY5fW51K+oxkIie1KAFVM5Tg4g1lc0lCY5TRWoFPCe/qju8Ng+FE7d3u9/3XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623581; c=relaxed/simple;
	bh=c70ejIA1HHPGti0LlpJc+AUieY8UjrbXfOG5k/75a0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HS2MoU94yeJ1lskK8SWEc+5TuJrldnyznLAOZpKxIzu5E6mge6tuC6MyhyNgEYRNpiiYe0P5L5yNS9AsBLje7yxkQTbdVEMSbZsMaJ7/38KhAmL+MjnAlyop1ySUqW61qZ01Y/jtu2EW63UbpvXgS+wZEU/44iBenllV/w9cC1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3YzBpy4; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3YzBpy4"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30bc871ecdfso4670eec.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781623579; x=1782228379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f7vROs9UN075gs/8U/5ZvrOcUcap23dqy0WHrqzNyCg=;
        b=I3YzBpy48d+HYg6vJjd8ZuRQG7xCwP1LDIp+1hVpLCKoks2h1JkouCUFCc8HYzWlPn
         ljfSdQqPpXbeOL0t/qxgFkOQxFsRQgCXhXs0c1yt5UH+1c/3utBogIv/MOT/RBG//gIg
         s3BcN/c8zcVEzf70jLocFlPWs9laboRdMr8ViFH2NYVwwowNXrua4OpBDSlzKZy+2vB0
         C5C/fcv2Kflc2+KuDWTgVIjdOYpSJqlsD9+OYxG5GBw7nmFeZ/3oGmnPseeep08o83IQ
         de0tSLhncIHmRNsm6EFiSwPM0pt4e4hzjJkG/VLl1FXI1xKHd8rPcJDxkobN0pHqzB/i
         lQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781623579; x=1782228379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7vROs9UN075gs/8U/5ZvrOcUcap23dqy0WHrqzNyCg=;
        b=HJaTwIatHgbcM29Md5qxbnTvGrq0OL9MzeRT32YT234X7USIfe/BXj/+qom6NnU/iJ
         5TofZMCmcL9lB+dauk8fulcd8t9Vr/KEwjHewkJ4xX/qfu4Rb/s8er2iQy2qIwiLBah3
         qifhtaOILPgXjuo0wT0i9oCAQFRkpsOUdUFg0FrvZVCQl/Z1+YidPe/tex2CCeDWZ1aL
         bsN4x3pkbtokUuUEDrgFwssl8Nnf2ZN7MIba1UXE089HZ5BP+pQoXpIduvn6NeJ9/XYN
         ow4z3uzrEmtJAIX34Df2wwRv2hjPgS32UdSIlWpSmFboHcSFQzxzyCvY/lb3wc1xfoEy
         CFNw==
X-Forwarded-Encrypted: i=1; AFNElJ/uOk5YCOrjWqxeegIm23gkwuau0ENWKybX14jV7cEStn6s0ETs31dKqayD5uJPhUk4Irhl5jf6FEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaIUP2pJ1N85/9CujiomK0xaM5D5jxW+3RYZZkrbetGb1gJ68F
	GvB8BFDo+9HIEoGb4mh1lE87oVHhZr8q2Bo86YsAb6inRaA8xPKium5b
X-Gm-Gg: Acq92OGPLYq6JkR0IwpBCTVx7o8cHBGiLU8ZJiitvIGN16QFNh3MzL+UnhQO9rI+SIy
	MNrMa2TpJ4oNDiRVoAIe02e7anoDBszfldwrCw6k6nSCy8iWH0eFSl+NkzCIWbfv0xNYjlQOYfT
	wNuMw0l6faScxfC3nK/Dz10wEEoCi/GI/TE9mPN7bek8gAoMm1Eqtu8qyzgZFuiQV3NCD4cqrJg
	+YuGS2omV1uYyKkQj9xPY0zDc6WWFK0J4/EArmuugEVNgatxykMloql7/yKeQ7Yg6eQmznDHeEt
	mN6MJPdUiGE0UuNXFGnv48RCaHSkSVegf786AB59TZ/qLjcKO7YueQXD8u6+yypdR2Pxw8rnG46
	EjCjORI6JaoD0+1kCsBkGDnYwyNxfijFACGNWFJ7vHALKgUWwQGU7niQcu/Tq9MaZ20xal5GIxT
	9AgEUp9HdX52bOQi4W38gdvZrFObLr/7w=
X-Received: by 2002:a05:7300:7b95:b0:2d9:6373:ad24 with SMTP id 5a478bee46e88-30ba5f7020emr2626182eec.26.1781623576725;
        Tue, 16 Jun 2026 08:26:16 -0700 (PDT)
Received: from geday ([189.115.92.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0357sm18116553eec.11.2026.06.16.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:26:16 -0700 (PDT)
Date: Tue, 16 Jun 2026 12:26:10 -0300
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
Subject: [PATCH v7 3/3] PCI: rockchip: drive at 2.5 GT/s, error other speeds
Message-ID: <7421df7a7b7778ee99363cccfdfabbfa8aa6ab5e.1781622998.git.geraldogabriel@gmail.com>
References: <cover.1781622998.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781622998.git.geraldogabriel@gmail.com>

Configure the core to be driven at 2.5 GT/s Link Speed and ignore
any other speed with a warning. Also drop the 5.0 GT/s Link Speed
defines from Rockchip PCIe header.

The reason is that Shawn Lin from Rockchip has reiterated that there
may be danger of "catastrophic failure" in using their PCIe with
5.0 GT/s speeds.

While Rockchip has done so informally without issuing a proper errata,
and the particulars are thus unknown, this may cause data loss or
worse.

This change is corroborated by RK3399 official datasheet [1], which
states maximum link speed for this platform is 2.5 GT/s.

[1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf

Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
Cc: stable@vger.kernel.org
Reported-by: Dragan Simic <dsimic@manjaro.org>
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip.c | 14 ++++++--------
 drivers/pci/controller/pcie-rockchip.h |  3 ---
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 0f88da3788054..456dcfd676ed7 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -66,8 +66,10 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	}
 
 	rockchip->link_gen = of_pci_get_max_link_speed(node);
-	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
-		rockchip->link_gen = 2;
+	if (rockchip->link_gen < 0 || rockchip->link_gen >= 2) {
+		rockchip->link_gen = 1;
+		dev_warn(dev, "invalid max-link-speed, limited to 2.5 GT/s\n");
+	}
 
 	for (i = 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
 		rockchip->pm_rsts[i].id = rockchip_pci_pm_rsts[i];
@@ -147,12 +149,8 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		goto err_exit_phy;
 	}
 
-	if (rockchip->link_gen == 2)
-		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
-				    PCIE_CLIENT_CONFIG);
-	else
-		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
-				    PCIE_CLIENT_CONFIG);
+	rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
+			    PCIE_CLIENT_CONFIG);
 
 	regs = PCIE_CLIENT_ARI_ENABLE |
 	       PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes);
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 3e82a69b9c006..b5da15601b585 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -42,7 +42,6 @@
 #define   PCIE_CLIENT_MODE_RC			HWORD_SET_BIT(0x0040)
 #define   PCIE_CLIENT_MODE_EP			HWORD_CLR_BIT(0x0040)
 #define   PCIE_CLIENT_GEN_SEL_1			HWORD_CLR_BIT(0x0080)
-#define   PCIE_CLIENT_GEN_SEL_2			HWORD_SET_BIT(0x0080)
 #define PCIE_CLIENT_LEGACY_INT_CTRL	(PCIE_CLIENT_BASE + 0x0c)
 #define   PCIE_CLIENT_INT_IN_ASSERT		HWORD_SET_BIT(0x0002)
 #define   PCIE_CLIENT_INT_IN_DEASSERT		HWORD_CLR_BIT(0x0002)
@@ -197,8 +196,6 @@
 	(((x) & PCIE_CORE_PL_CONF_LS_MASK) == PCIE_CORE_PL_CONF_LS_READY)
 #define PCIE_LINK_UP(x) \
 	(((x) & PCIE_CLIENT_LINK_STATUS_MASK) == PCIE_CLIENT_LINK_STATUS_UP)
-#define PCIE_LINK_IS_GEN2(x) \
-	(((x) & PCIE_CORE_PL_CONF_SPEED_MASK) == PCIE_CORE_PL_CONF_SPEED_5G)
 
 #define RC_REGION_0_ADDR_TRANS_H		0x00000000
 #define RC_REGION_0_ADDR_TRANS_L		0x00000000
-- 
2.54.0

