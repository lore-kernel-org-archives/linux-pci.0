Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E98253B42
	for <linux-pci@vger.kernel.org>; Sat, 28 Feb 2026 00:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772240156; cv=none; b=Xrn/XNz5oZoTHVh+5QcNtExmgAR1sQ8Yc4nGME5gNZWE0Bh5Hqq+xZ+LoIfU/Qfd/ptEuC1CjMBDBU1tL4hyQ8kCWgc91nuEML9YrbFw+LVU54CJ7zMXX1nNv5fRuQ5Jh1hMY3H3uG3wMGQ8jEYTaGP/8Oj7GvM/iZddbDxHcvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772240156; c=relaxed/simple;
	bh=UtSvzYAQcA41IBGRV3oYLTiVcRrKHBSoX3j1aPJPYH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBnU/J2MwADTwGriPiKGfi0dwa7t24wshnEZGTsbJiPvDJ4MfL2d+URaFef8Bqft9Abhkub6ssoO9PExxAeA1ILubqG5C6Uq8KMXHTcYt/pyGB7G2quVAfwHlrV3RRGmBZly49BbPdnN3F2rMx2EQ9Cv4cQQHDOVBVh590/vse8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts/0iq4B; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts/0iq4B"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5688b9e4e80so2651328e0c.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 16:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772240154; x=1772844954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vjfco02/smFUClEsqTheeyjpW86+y48auZFweZaaMU4=;
        b=Ts/0iq4BvTOPkmtyhlN0uNxEzyU3XvNoPdllIji1On19OYWrzuz8JIwGpplSzmwgvL
         yrqGSNAt5s2pU1Tng9mtJVsKKDVInH3/qmFjhhg6uEzN6EWJt1DTF1RmbxvQaVIrLoSx
         Dmh1zfOKucIfWfyLOPxck0md5m+/KFfQ/WLmDcTIn1MyzwESq9DqObqf02WMqwQepthi
         9Tz+jykQIEeldLURlu+0uH/rly8fyesV7nfSxc2mdITYJzRRErSunt4j1F8l82v9/T2a
         dcWczcUGmT8zjBpsqtoM40BNx20bcxMprlq4GK5K0/cldmj44DUs+14LOxWnYwUjoKmP
         +2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772240154; x=1772844954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vjfco02/smFUClEsqTheeyjpW86+y48auZFweZaaMU4=;
        b=LqouQzcXopz/d5DPB9DSkZCRgK2lcpNzwA8QHXGqrHz0TeoDpi494wSACq0quRU54c
         g03qJt1aH7072EiCWL/e7aYl2nm4NiJ7GcMxi0YKyzv1vNlg5MlDxJlAaSJBKikXztd8
         DUroHDoYnSxfjgbupdXOiyV/PFUVxsNeULU8xqWnSR9i/jQYD6to0WMKvrhhnw/5Yqwr
         F/26hevnOWlitAmeqMW9i8b07y7/NdLhHFE+x+s1mwhJfKRTxUdi+EA1PGRqh3VyDUU4
         yZyQ+L+bV3xdm4TutiLvl6FgycDoSrRUwzQYiltYbCaTzzjRFclkvCc7K5RwEYFWmZ1f
         xTOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2/0jsrcI/mprVlCf1uoqntktBu+GemTQKc5ORjjja0o481JVzqnvL3lWirTZMsi05qMhcxjHRqSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSp99i4NyMd0ag5845F4l++YTW98NTaS9YYIUIp8g5wq2Ajdmc
	yOUtc319MocvAhFNy/XgdHQR9bW2NvLbnSTjkT2prIjf8EBl7NFYRwtZ
X-Gm-Gg: ATEYQzyCRRK5s2kVMyrgsJp/6ykZM85kAPgwkhL9YPwMARyGkm5V33xlWuHnsy6E6/3
	BAVfeFyGhUDHh45tEfpNbxe27fXXfRHOuwtxwLPPBvlzRdSDxDCC/y6WXNNAhDbWgoUc9C9uuZB
	P3qGHB7a3/YhtRgt84idTd1zlikIX01xTj8Av1Kwvo3ik8E9YgvNn/c7jJnO7Zsg6iBGS6bLxd+
	Em5sTw3dQ471UED1TUOW3snly2VgsGllJrfU8Wsk3dimdJmlGcXcZp9Si7t2+dBm1hrLdsgLr+z
	HJI824cOgUQz9enw9SG9omfFMh8MhxjOkRIokO7fg+ekHKnV3GofwMk3T+ufqZV8IObikg/0KdT
	ePSxzyVFKFL3EEnAb3KXii2/wzean51CtAKs0yrD1V0Fj79onfx+5HB0ZpYS+LcaNnTSBYSqlPy
	8Qdeq2ydCpmA==
X-Received: by 2002:a05:6122:1da0:b0:567:4838:8e4c with SMTP id 71dfb90a1353d-56aa10046d4mr2709747e0c.8.1772240154391;
        Fri, 27 Feb 2026 16:55:54 -0800 (PST)
Received: from geday ([2804:7f2:800b:feb1::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91bb4fbesm8368019e0c.5.2026.02.27.16.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:55:54 -0800 (PST)
Date: Fri, 27 Feb 2026 21:55:47 -0300
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
Subject: [PATCH v5 4/4] PCI: rockchip: drop 5.0 GT/s defines
Message-ID: <d0ccf2b80715e956f15720ebe45880705272ba43.1772239598.git.geraldogabriel@gmail.com>
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

Drop the 5.0 GT/s Link Speed defines from Rockchip PCIe header.
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
 drivers/pci/controller/pcie-rockchip.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 3e82a69b9c00..b5da15601b58 100644
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
2.52.0

