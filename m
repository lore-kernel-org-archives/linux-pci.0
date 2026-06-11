Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF5238B7D2
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208203; cv=none; b=ds/tLA5/1qPv5ONSKs51H1rW7q2q2qs92EMw4gkqgLzVKC9MZKkQhKw9TZslL8UrVDr/lOdcssTn5cTfckeOGSCcejUtdHDnESptd6mEclYHQJHTTcXEknsmElP4xc17oQVcqHoGTgbOcaCQC1JW9nzZeA/HezPQcEtueVDDoAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208203; c=relaxed/simple;
	bh=fgIo7UfPWRtYrXPLSBv62/AM988YKE4Nbo4xMqj8MRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBevy5jBXEwyWQ8zVWzEcLRJkW7p6O2f7UEiDyvjOnJZ77EFI9+VUXrcyqD1ooo9NXa7pr6UH3sIeQb4T2gxj3WXJWHL1DxMRaCCMN8/yEf567T6OPTGNX0ZmYkxlMY7zaUsBmifNh6W8vSITiN/bX+npLN/JhopD2eTFGOi5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hf+pb6zI; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf+pb6zI"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ccf0fa0aacso3265206d6.2
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781208198; x=1781812998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLMumJf1RKl2eLxtJE2mfNPELwqfdC4TqjLEXDZKRSI=;
        b=hf+pb6zI2JdXtu7YSZrKrLFg4/Dqmsq/LYcPJTpVIjQsu4UKfIy5AAuWcMTefVUDB1
         ypfh5wXJQjdj/tKQBaoRRLLvxk8Ep8XwhISsqOdRykIdcEi6xHlmhLwXdh68Xr7r51mM
         fERD761F78eRjTzPlq5HpwPyfHmpxErM1Es3IrxCYTzff7gIVya64745rlMpjEAoKOe3
         jzXGn3wCMRQh+UwBqhnkd0WRIC16g5zeX6QAGjk9li1z5QI9bFQyObjNobKYUVTJhHxe
         d4J0orW7f7/kuo/P5LwdYDOl3UjpXqQhK5+d5RueDwD1qYrBIAbaAi8wDWhkRsTrO6uD
         ioXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781208198; x=1781812998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLMumJf1RKl2eLxtJE2mfNPELwqfdC4TqjLEXDZKRSI=;
        b=sF4i00EfMF+jSRojmVua40/2EPGS6Mx7UkJU7/kEjyZ9vHWbwEZgW4VvSOcFFrvcyM
         Z9jEgUdEzjjCXSvbMKXg2zCSASi+tf1huv3GGmLKnR20mkza4lhDB0W15X5obOO7nmNw
         h1YV43VcZIp3AAr45MX80P2G94MvvNrEHZjcYfP27h4o3ldsmutlz75T6QQGHM1nivaW
         yE62ogILsVYKaQHIFGCUelg+EAKO4KCLjkM6lSEQIAlKKUyhKaUIii6Rp+qklLv5jrNu
         s+cL6OUTofeuizrJqv5zGk00T/UhMqy71E4/Y1/wjlBtIosjjxAtKh22yqrLtrQgFJ0p
         LKHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pPYxicjHQauwk8jtzvOg4BVrOOwINV6T5ZjbUEzxKFEIG7hTrgjCajOD3/wMyYdbeZROXlfjGxNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0J7h+Wl5rjxOBo0UovqWhj52u4gB+C7DqPzC/LI8d9uA0UoGc
	nEsf3HExuc7VaZEPhgDTpfWjleAPCg3YraBS/OSLaC4SImjKlN4ddQYp
X-Gm-Gg: Acq92OHmArTKpJbLTVPtEsXzjyS9NRfYaHTdP4/y0xwjmIikyLptCLYpW/uazl8WSGN
	d1Ony61LaU/B6KTbzh0UTVtYZBtELuoFROhTFsx+l3hvlidu245cAOLBz7lzPXlXVTaDGwLpprj
	RBU2Ti9GdW5ndo091NCYeRpL12Er0o0x0sOTIBMxPqQp30YH39vysh/n6e4RwjwcjykC9mlupT2
	3IJerlmhIRTQnQnuTdULDAA52c2jUAot+78Zn5IH5GwjHtb+waEzjf+ga9TDofkJ4O8OkOr7XN3
	hvXjUd+1zF32yS8QcJNwGXdsNAnwbKm01eMjRhK2czrzMGnZXesPFmjxnifwLj/KDq6pHD6FhI6
	u/kHuiMSC93jMwxsnGq0QxnodL21rgEZYA2VMplymmb0imaLSrupY5ii/fwGHM9973ol7NB2u1k
	+vg5R80SBz
X-Received: by 2002:ad4:4ee6:0:b0:8cc:f135:529e with SMTP id 6a1803df08f44-8d1dc1a0cebmr77291506d6.34.1781208198118;
        Thu, 11 Jun 2026 13:03:18 -0700 (PDT)
Received: from geday ([2804:7f2:800b:f09::dead:c001])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301b2a79asm3229516d6.13.2026.06.11.13.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:03:17 -0700 (PDT)
Date: Thu, 11 Jun 2026 17:03:11 -0300
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
Subject: [PATCH v6 1/3] PCI: rockchip-ep: do not attempt 5.0 GT/s retraining
Message-ID: <76c828d29b0f05df0970b3a862ee1af8c96faf17.1781207474.git.geraldogabriel@gmail.com>
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
index 799461335762e..9ebc227a1ef84 100644
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
2.54.0

