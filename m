Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720F449ED6
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623538; cv=none; b=dMjBWwXJZYpi5DisxvszCTEuzA6VUGSwKhsSOqqAdbLISKTS6BqrjGKsVptrcgHIG+AMQM5LS7meWvd8lyfTTAa/5TQuVjWULkOn7NcQ8ZqQdl/Fgc7ts/CJGnMCDxAFYC8o88ZtpUHGV2xvqHfUYZbLm0kGtoAqnRI54H7omvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623538; c=relaxed/simple;
	bh=fgIo7UfPWRtYrXPLSBv62/AM988YKE4Nbo4xMqj8MRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjtTXvXMxFxTdXXeyIzHKqNpivqboVAINMqhDbD2uL1mlw6UGnzocS4dkj0XV0LFw/Wr+CSGBxHsn19QZ89MhxtOcGoFH6yiOZdPIIFkmjQOtBmeRfI/QOTmikCFsYzsC+Onze4YSaD6BSdSixSXBrTpChn+OogZj6A8nIpjISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Se4KD/Gr; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se4KD/Gr"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30bb7d20ad9so954154eec.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781623535; x=1782228335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLMumJf1RKl2eLxtJE2mfNPELwqfdC4TqjLEXDZKRSI=;
        b=Se4KD/GrMwqAx85qGx/ihmaNuEQDQRgkpNXRkK40y+TREfzXBrRMA/5a53lmCfcQeF
         EZXAXwr9A6gUsHpf9TiPMIKKtqSwfmC5rXXD2qYEjxw5WJ2YAYhpysrZ4C7QCMJzTqHP
         2YS98lZeksQmDZPfIHhpyVtWBx3WkM54gILoNbdzNEOlS9QrUAkAv2W57TzhBZbBmWn/
         vff1vrhHSjlJfECkN45l1nosarXVzsENAX1EQLE3xAE5f1OkVMJGX+Su0e23hffornBs
         nekc0GBo3NzEjr4uVIzyHGgBSY6ZWXkM8l3oijCKT19/3+D9swYk5jz9+1bodnaQbhh4
         cJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781623535; x=1782228335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLMumJf1RKl2eLxtJE2mfNPELwqfdC4TqjLEXDZKRSI=;
        b=EtNOiBE7yXyg4NfxWfCtofqyPKVnZr8btAvWe/G+2ofc1Nxw1sbHBDRB4CJmOF/gnd
         BLNQm9MkbPRtT7/Y/WBNi0owko29S10AZR964sp/B5fLrWanEg3y0AvkSLl2SjB/GGAA
         StlJyGO9Lahogm86NwPMVTcebUmwR/wwh2f+bOXqgDuWl9Nrnk/sqIzBRfyKNo1LQjJ1
         zxfJksjld9KCkthHmRkT5uJNT6m5QHKcBRk+I8JtBxS+nexiLjr2b1iicn9wM3gIeRYn
         +NODxxJDikgm33IGiuf+rGvnHKh862nDhiu3nOIWTo7ttU3wBG8YftfSzgqggMTFEL4c
         dSZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8oG6sIsxEV8PCcKlOeVR+D9tuxazU+0g8X21ESD4pqrENlUKC3rrf/XaqWI2P9YnMARDsnGxyRyR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzls0bGiPe+BcnyAAfg7P2/15sZf0LsVFCNmlTQ7WECmA81X0kk
	Mo0Tco+zVxWQ5JX89JhhWdRWeZzqjT5O26sLcrogZEkZISTilyATeEMs
X-Gm-Gg: Acq92OEo7SHlKr2jSo23lJ15PvACuTDNuZsDtONARo6yaZxMIrzSlVhjceKomlP0l6i
	cAYOTwvutfnnLbSqjkYQZlwdeSOdax+X90t0fYR5Jh9v/3rvmxKRT2ZLabuodOjfcdmnsIZVG6q
	mI0Xx/Bsfd800bRU8FwSg/3lzu1JLVotiZZJ5gY5KVmnc3f+lCqccKL73hiG1oa+L7Dc5hMqb6N
	zunHBb4COms9Q6JlBfpbiBsWKIqTooPBF8KnbeBuJl/EMg5szlxqx+RefhW+Vi8Ay6VRmpJEBfz
	ERL9hKhEyybQ0oax6Sv6HQtpuMgHxNjn6dgoS4pZIZlT+fU5KL8E6Yrgn0nKHl7mt5zfiyF4KGs
	hLdJJKsbC5CQM9uDZV4rF3QtDR0wooE2n+ecQ4rsCfbKAyxG1nUCaofErwlCN7gokrlZuxUtooY
	yqxWP9g32tyqljbvucjIt0
X-Received: by 2002:a05:7300:a887:b0:305:179:4dde with SMTP id 5a478bee46e88-3094044cbeemr8636687eec.35.1781623534764;
        Tue, 16 Jun 2026 08:25:34 -0700 (PDT)
Received: from geday ([189.115.92.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f88bsm19695217eec.16.2026.06.16.08.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:25:34 -0700 (PDT)
Date: Tue, 16 Jun 2026 12:25:28 -0300
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
Subject: [PATCH v7 1/3] PCI: rockchip-ep: do not attempt 5.0 GT/s retraining
Message-ID: <d994f8fb3481bbb8f3972f117334a6e8aea383fb.1781622998.git.geraldogabriel@gmail.com>
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

