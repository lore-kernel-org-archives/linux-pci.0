Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2751F30A4
	for <linux-pci@vger.kernel.org>; Sat, 28 Feb 2026 00:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772240113; cv=none; b=K/hxeTGqKylI9bkOEISxPU5bVee3qgzvpgHd8MBJLUOoqPbAJW2Zt0ccw/u/NY6oJJEyk9njso7i8tp2Jzbd1MtEVTy/hxqnm67wxwWVYr7BpYW339p3mvq4g17l5X8vg954fvzi2EL8i8aw6pAWqUkXS18R6am9yj4VIf/mLDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772240113; c=relaxed/simple;
	bh=dEE6VGsTSOYeekVC/927JnJzPCZGdsA6+ByrSiQA0sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ve5Qmb0QhdAK7GOsPYU26IjP/SMIiEAfwRLnf1HtyVg1/vsPJ+kBb1h/CeC08MvrT46u6SYmU66XQYLevMkokZYqTTNLHJUGBgFhXEtZG6vc34ENpubDP9/lCzfrxMEQj80JBjQsm/jUl2df2n312NQmGhpTuWNC3e3a6iDjqCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S07OIAxk; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S07OIAxk"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56a9076813bso1059654e0c.3
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 16:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772240110; x=1772844910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tR8qs9++9EnY6kiO3ZkloT5P8dh9BxfptB2pOEQ7BLA=;
        b=S07OIAxkMHNDqywrWCgshv+EXJ38goGfzcBwtTCam5CFFaTXCYQ4Dj4YpMJnVtuIRR
         GpCfX1qqssXXlxZXxoVjdzTk9anhHJcZ8Xd6bFSTbi8B3cv95KInjjOnoJg1Q3da1G19
         jsgU/Z6w66tGR22844MIGL4qlZqZQDuueKGzUnMJgOoXDUBniUIEIxd3AePp5GH949aI
         1wMwTuwY+HqBxTOx9ITRaikET7PNKisMrXemCN3+SfkHRVjsev/kP/gRHVjZdi9i7zYR
         tVH3heC5jXK7GZOV/9gI6+esx2rnnL6ikGFtoHOuEyZiWPweH8QDsth7B1RtDTjU0Eug
         /V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772240110; x=1772844910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tR8qs9++9EnY6kiO3ZkloT5P8dh9BxfptB2pOEQ7BLA=;
        b=TMaWihOCGXxfU0bqflggVp+e1kaaha43gGbFG05m6rjZPdrDB5Yc778BVZ6pM2nDVI
         Xp0AvdZNmO6S8/I1BUae6jaQbOGI//4JxRA0duVFkztIRdL7BIbaI+rqhOgw2J4VEOFu
         e7A/xgnN4nb6MHthCgM8PktnmkrjAdQoHEXIyOKO26Exe+JXhopmv4fqLAuxz4K0p8rl
         8e42sz8AhVJChq2KSfSOL9dxdcs1HB1Lf0O2Z3w7FIiRtaQAvD2vAOlRynA40yCXM7kr
         rRx+KTaJv1ypt8JBra3oeIYe8yGoujVRtluKu8NC8yT7HCxPvn8vNQFyKRCNkeIjjfLU
         6I7g==
X-Forwarded-Encrypted: i=1; AJvYcCW2HPiyFvUP7cS1lDsmJJqFcMWaMF0KMG9nqYiG/3YfV1cWIJcUQdKbF+XtdSjgnoHYasiiDi0Qqtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzziJKHDybwRMylWA8B7AJopjW0IKdguchIzhEAdXen4hb3Q/oS
	HBJg+K9z9ej718LmmKARvN5G56mnAuFuI0qZF82EAwY2levNwGcgIS3D
X-Gm-Gg: ATEYQzx9+1lmaePAhbRX2B7F3qCeSWoHwty9ILwYWC/35mCxJmcWQ2xB9l3PoGbAsCs
	NKmQg74L+iYvrjwIlikhxFWD1l6Ihb1sgHHyDdZwG6MCp/mqeE8n/NRpAwZUvWiCQnRf+LTuaxr
	EFWa9JlZwqIwBD1Ot7Fk7fdN7e7MithqUPrXz/Kb7ZIW6rihaCo8LZmnTdL2XZrWNndWtAFbbad
	PlC9e/oWYbS601XwEGk3kO81M9OaeS7a6Pd6wLf6TVBJ1UpXhawteJ6Xh81yLgtqCbqLQHm0Ozf
	js5DJ4aoH9Lp6fx0K/xzaXhX0RnrvE4altXkUiC+pLAh7VLdfMlom1WJ0MfVElXchHGZqmoAsFo
	6GPsQpbEgum63hZaDMVaXkP7btUB5YrFZXQjephAnHKmCjlCHr+CYc1kTuR2mEwEfyP9wYDM0eI
	qJjBfndwoUQA==
X-Received: by 2002:a05:6122:319c:b0:56a:995d:8a55 with SMTP id 71dfb90a1353d-56aa0aafaa0mr2391700e0c.12.1772240110383;
        Fri, 27 Feb 2026 16:55:10 -0800 (PST)
Received: from geday ([2804:7f2:800b:feb1::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91bb4fbesm8366399e0c.5.2026.02.27.16.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:55:09 -0800 (PST)
Date: Fri, 27 Feb 2026 21:55:03 -0300
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
Subject: [PATCH v5 1/4] PCI: rockchip-ep: do not attempt 5.0 GT/s retraining
Message-ID: <3391ff1386aafbee1754ca114d77961f23e2c09c.1772239598.git.geraldogabriel@gmail.com>
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

Drop the 5.0 GT/s Link Speed retraining code block from Rockchip PCIe
EP driver. The reason is that Shawn Lin from Rockchip has reiterated
that there may be danger of "catastrophic failure" in using their PCIe
with 5.0 GT/s speeds.

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
 drivers/pci/controller/pcie-rockchip-ep.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 799461335762..9ebc227a1ef8 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -553,19 +553,6 @@ static void rockchip_pcie_ep_link_training(struct work_struct *work)
 	if (ret)
 		goto again;
 
-	/*
-	 * Check the current speed: if gen2 speed was requested and we are not
-	 * at gen2 speed yet, retrain again for gen2.
-	 */
-	val = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
-	if (!PCIE_LINK_IS_GEN2(val) && rockchip->link_gen == 2) {
-		/* Enable retrain for gen2 */
-		rockchip_pcie_ep_retrain_link(rockchip);
-		readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
-				   val, PCIE_LINK_IS_GEN2(val), 50,
-				   LINK_TRAIN_TIMEOUT);
-	}
-
 	/* Check again that the link is up */
 	if (!rockchip_pcie_ep_link_up(rockchip))
 		goto again;
-- 
2.52.0

