Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B27D38E5F7
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 05:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772170615; cv=none; b=fPcT6ODDCGf1ObvGD8/zDWhm3iqLmVWpIM3dDZgMwyo9GCRZxqWIOR8qjQJUxZf8m3sZb34zVh+Jmk9jthkiLtRrGaEUROJZTXjy14HgWf8SzfqegJTACOqYrtZO03+2AO/Ba+xhs6jH5QtXH28qroKMiEX4DGVwiQx/RxsGi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772170615; c=relaxed/simple;
	bh=jViPzIcft5VoLeQ9+SfcLyXaFyUHi5qvqa74q063aIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDEVkzxFPC4i3HPnzTnnsSE3wr/9LIwEoEShoTPOpHCt5uN1Bm+3tQO/18s4PPrUx+Ti4gUslW3F1+AcT2bQACwVejNHDLna/Qdq8hghduZ5lGR0t0hGptYyz4bM3+RtAvMET9aEWhjh3r1bdQtm4NxcjNxRROxlC+rZUYkYfzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhE/3gA8; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhE/3gA8"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94de68feaf4so1058113241.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 21:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772170611; x=1772775411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmPKR2Yyu/CowlCAVgHjCUwCb1vpQWAYSrI2qG/n3xg=;
        b=KhE/3gA8o3muIt8b0k6iK0XVp4ZjeUbccy2hfBbpOD0A3y5PENT3altpYB29T8yLbF
         0wYt4OrEbRvPbK3vcb9dNncRSVwrM6U1PS394SJk62lY6VWGOiW7Ba1yJsOx8WQjuzHP
         u7AjDAQdEO1USGW3lDoYqvj41pZ5qyrjeaU+6Q+fFgqiEV7AAgSRD5mHThzlprv1Mcul
         xzxU2QdFzyO5tSxRYCjB+5vqhny3oWktxKmMl2IqA6Ol6e1Hfbv8ggCKIFlRmHaVjy7S
         BjKc5ZjRZE3sxwBykpC3+ItQc57RU+vKzQpKGeHdHng2VnHV9hnQ1FCoyDyjpchJH8km
         Y8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772170611; x=1772775411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmPKR2Yyu/CowlCAVgHjCUwCb1vpQWAYSrI2qG/n3xg=;
        b=DGjKRMEalosINQmoJM485KcsQ4AOxKddZR3iJ+DFKYrBHaxVhUAtiI0T5sebBuALzE
         CtfVIuK9fyyyB0Ogh2hirjiqHYffsFRhTdyx0HQz4RioqNXgoKsVfQrXVA2X4AxnAh/p
         4iJdp30nc7Oyl+2W9FGuulzXdltQcTsjkqABYll+DsUyvaFji6yCKSYoR/UKYtM/3Tfb
         fpAOfyr4PnnTXlo+4Z492RoLvRGknmvQ/4K+GgJcWADONsqb66cnKIRiIoZkxBS3aEFG
         lXPSN5xFh0gk8qGdQfeA6Oz9IvteLdil2XQfuCCaXUi0ZFBtPl+uQfGZfl0RjIAbnPX9
         EV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGos+GwOnlhkEWFMuMztnlQMMGGNO6b9dxUA9jiVoq8JcOEn2CUkS0pWRXBsses/2wt4bUD900DPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx26BWyxdtYkRwznKivrkJKs7VJDwuXCI32V6qMSVNipCUVZaLj
	TCcAhpaNemC2GzO2q+Tmbstl4QfkI/wu63xBgb4Fg/spUJpsbCNr83Dy
X-Gm-Gg: ATEYQzwsLvCp9Bk6qS+p7yr5UhzyxRciKYXXzXyJxD+3PLocEwdZ+oRFHKHRNbd8T4v
	F0+iwJs4t0UoRgWxlSmUd0j9kFOK2UUCvjDEoKj4icQ1DbhpF4jN1281BrkwkQp7nCcIUa4sQAK
	UPYPHjRYMc1YpKOzPfFzb9vbpotwvLBjHyzGrc4TPRj4RNwZlF1n6A9syhhY6EFExxez1INPaG9
	a4L1w+gDbA27ucaMQJTvBSeea5GRasbtYJGfhoUiIps6H7exL3yeBGOeRH9Zsios53+eL+aJ45F
	uaCgLyGrlohfU6LTt9AOSHeiAhnZY8NLWrlpsqdrteWt8zVv5vPIr6YpO8USjWbyNtNueXU5RRq
	73i4xJFymJWuASJ7dxz7Cdk+j9adAXAikbwY7tspBbcASQ84DPGyEDcD/n3NnWie2669M/j+ayZ
	9GTM9oO0B/fbhi7cRJfqtw
X-Received: by 2002:a05:6102:32d1:b0:5ff:a1e:ee66 with SMTP id ada2fe7eead31-5ff32271334mr1111779137.2.1772170611497;
        Thu, 26 Feb 2026 21:36:51 -0800 (PST)
Received: from geday ([2804:7f2:800b:feb1::dead:c001])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1e3e6013sm4496101137.0.2026.02.26.21.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:36:51 -0800 (PST)
Date: Fri, 27 Feb 2026 02:36:44 -0300
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
Subject: [PATCH v4 4/4] PCI: rockchip-ep: do not attempt 5.0 GT/s retraining
Message-ID: <c51c804bea56d772a59fd29fcb080541b7a367d2.1772169998.git.geraldogabriel@gmail.com>
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

Drop the 5.0 GT/s Link Speed retraining code block from Rockchip PCIe
header definitions. The reason is that Shawn Lin from Rockchip has
reiterated that there may be danger of "catastrophic failure" in
using their PCIe with 5.0 GT/s speeds.

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

