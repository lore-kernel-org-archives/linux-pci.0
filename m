Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B4D43DA3C
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623553; cv=none; b=OivG+OXxZZ4DuWiI87zEy2BNTNJLvgnX6YJtmW98oRThZAYq1nvJkC2ArwJRwmnGNjmdgdFBiLhXlZ3dTWRWv9gSxDZdcc1FexJzf+bILpQta5nj2thf5SbXoihhAjpgLfgKCACSHXrjr7ui8dg864Q2cxjzvo+6GBsDX8PyIs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623553; c=relaxed/simple;
	bh=TFTAot1IKWMOYgZRmrw+FhVwE6dd6IS9bop8XrNJ0Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+ASUIfRC3yZjqyVN1aTaewN1oZXXOhg3gYmx1ktbxn5O0ureB3nIaYIafhRTTHKUpAERnnGmUTGOr0eNga6HwjGF6uPQfeYG1C5lBGrptJbvC1l62p1Fw2ildumjvMhhv6jnCjCHjVKslg8yVbnEkj9JKFUgPyThjv0GznLlys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVDnVA1V; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVDnVA1V"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30bc871ecdfso3571eec.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781623552; x=1782228352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OIfDLIkJhbaUkdh0HltZEozEAObCZ7mgl0RsbHOTNY=;
        b=DVDnVA1V8Sdfcp+uKqYwF8FLRCpE0Xw3POyJjsHrs+zP/TaCC/EWaN5bZP+b3abIt3
         L9Y7Btezi6cYYFwjwJxDbgDh0+WnkHNmUYgq+IXNd1ZWmzprKOJEsctfSAE9W8hiSTTY
         4LCSL0A3W1dBHqP4H416zhJvcFD5lbKJs6k1qPdnoCOY5xpZNjyQTyV2Ir0qRAGjuIkd
         Z+no2GqyiLh6B/plEXYvqY3Ck/9Iz2Axnha2RJlrYZqEwLtDRgeJX1kV2G8KKfGgujq1
         fe/FxxoMjs7hves9qGn85tu4IrOXHHnnqqZNf3+5+Z2A2bgBgIbDDqcrlBU/5VV4TQ21
         R8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781623552; x=1782228352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OIfDLIkJhbaUkdh0HltZEozEAObCZ7mgl0RsbHOTNY=;
        b=pdYrVk0AyCqnEyTwvdFjd8V6kHuet/8nVpqUTBEmx+NVTYCdZOGHpYXhEdMpjJTok3
         dUxUYcQ3qJ8hqCrwN12yXFK15u+oD2SiGyGzDKGi45Oy+u4/ASrqkJ3HaxZ7j3jWYCPZ
         OhYcBuUx2Wj47GG/KqL+MO3utaEozBEhY01PQQZfEFMC6px8Mq5+7cQJ3RRLU4232auF
         LMtnfyP0CRiEjMioYqs8PfZZ2bMTE1l4jJQ89dEnTL2b3qnwAJFHC9C5bLpFrMBSO+4g
         gwzyH28SvkCq/A6r42syTN8ONzbSZrQEq97iLBb1CjHyO7OnP9a/L1z47cR+v2BsRyyR
         OD1A==
X-Forwarded-Encrypted: i=1; AFNElJ+DF4ntpetYTnjRlKGQ7ctlgFM2JZPuQOs81hX+GUKbZPJfQfIFs3EMPkFPRVRF42Ad5D0OOEmFQAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxev7k3SXwGLcC+wlObBgNg9n70UTp9650uSn2CSoOntVBljycV
	Z4lAvS9BonhutAn5SraJZ7GK2hg+UlevxAh0ggf2r6u1qwZKCUSyIih8
X-Gm-Gg: Acq92OE1trBAgRoInivAC40qPX4y5tkSzTQ4JaYTaW3PQCS2T1WeAstdGe5ytvHoeYM
	3AYPOTzUKCJ2sdx2YzFg1jPxj6b8hWenxczGzHqJBj0fK5fP8HJQBVBf/MIOGFt5Z+AZtNNyfSi
	ifnVBD9WUurtl7aM4dSRXfclh+5fEZT2AACe2rYevjwaJPLblP2zgZTeYvx16NF9R6r47kq592e
	dfoCHzoDLfajut7Ij887GK9ynnGS64qMQDThLg51pNfHm5C3ak5gRARiO6WCTFgB5RTj43ge8Ui
	+moMb8d58XGkczHS4U5x0g3WBqq14Drqk1F3O3KAVoJoWaUrvkkdxmvCCPN5w6aNontiuvf8vDl
	y9v6MZk9DikhdyXU3mYom9BX2ySYUY5TAoZP2s+yA/7zJ2D22WC3vOJgK1Jxs3K/hi+N0sW2cRV
	iPqDeZ0NnnABpp81YgG55C
X-Received: by 2002:a05:7300:6c15:b0:2ed:e14:e954 with SMTP id 5a478bee46e88-30ba5fcc635mr2325529eec.30.1781623551532;
        Tue, 16 Jun 2026 08:25:51 -0700 (PDT)
Received: from geday ([189.115.92.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bbbd636fasm1525643eec.22.2026.06.16.08.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:25:51 -0700 (PDT)
Date: Tue, 16 Jun 2026 12:25:45 -0300
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
Subject: [PATCH v7 2/3] PCI: rockchip-host: do not attempt 5.0 GT/s retraining
Message-ID: <68f6353e3a2ea4914de36c42b6906e41282adad3.1781622998.git.geraldogabriel@gmail.com>
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

