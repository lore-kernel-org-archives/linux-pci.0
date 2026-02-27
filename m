Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B702136215F
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772170565; cv=none; b=UHCyUteUXaw4/uItta0i3G1RiPfEe+6SEPecSXaA91tAeY3ZQp7Pm+e0rMLzcXxbKdp3wE9x4X+3+X3c2tqCR92IMxW5NZfzmsm/gi6F64NcA7mniPFyXnEVzeAGdnL3knlf3jevl6R+VAmRAwDxM2i5kUg1ymVdEbT0Xgfci7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772170565; c=relaxed/simple;
	bh=7D+t6AZUYiHvvmGQ1ox/DgSRaKhS+kPTO4Semp3A/Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCPy5uBGAkxLf32Py8wQmzMCxzTzxzwiq41BJGTZWYGlZB2EhsJzHshyaW8uXRUklH+okVQYWweBQhZvRUAsDwhv0bFZhOnLizhO5T9hBYfZO3WUisBc8tng0UxSVE1GYhXdsOP2hh+EbGIC+mP2eKkXcEugoDvJ++ecPRgS/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXjoXkYQ; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXjoXkYQ"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94ac3958788so864879241.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 21:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772170563; x=1772775363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MDesqVRO1Tim7+gISdrskbEX51kvM+tTCym0v98yq+w=;
        b=mXjoXkYQzf1kcddtfcCcIwhDd15HOtO3IT8DODrJDVZO6NxFIcquGsy3TlKfArOEkq
         v1i+FEPxOQBbtu8szf9FnyOIoVlToxbREcDYo7GSFYRaS/anitJPRy4leYnBcDZq4Nn3
         Xru8hNNexcTZM+I7xePTNz7atj55Y9sZzq90jDgqvLoBHhI85DKSA5O0EdstAAtLL2n0
         kUizhdiV6eMQoz+PVdIrsDNDWD6mdJOUm3OzUlEkFEZ6IghPhg8Su1ygrWWJrjIJp5xv
         Z6Yz47/S4P81ti7pNfkQOmcURUfzbHT4ceDsqNXwQsybIUHqIAoG56d7URDz1hWVYblk
         gr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772170563; x=1772775363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDesqVRO1Tim7+gISdrskbEX51kvM+tTCym0v98yq+w=;
        b=S8USVXjOzvA5GEgU6J3ZUa+ao6+DqxyytcjnzdtiXE7KLbD7BG3pHYwH4/vcIIBYqb
         dT8jX0i/bY0f4Wi7kuh+dEkVG57Wz4BE1eOvfjnbthSwp9ADzRgZkunjIw/0JQ1EQJKw
         HsOL8mmcOM+/RBFFLaK9JNS2uCN13PGiotDNnJ/CK/5sz0F0nixN2DO7uS+ZaIzyTuWz
         Pq6hlskn/NxYvaweRmzWqEHDWVIGhPrj0ogH6bBaJeeRnjl0pCghlgXmzIj+3xEGuLjq
         TNBmhEcoAaICkE55fd0Zu4cDPl2IylTszAyZfHSDe5WG6wwPyus5vYNIiridEGg9GJrP
         uMLA==
X-Forwarded-Encrypted: i=1; AJvYcCWm6R+N6FqaYfldi0puViGBcBAvNq1eQ/v0QzWYz/kyZJfbULikwgcRzdFs4C2gJR1NTy4FX8f/Ow4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/csn/C0TiIDeRP2ETkKkerahWfL1AxlaaN6WGvj5qSrypXLUi
	sYWHHpknl+yE1JyAvaSFZrAYfeXYf16zDizz2omC6Adcw1BaBrjS4jMR
X-Gm-Gg: ATEYQzzcPS2kit7WX0iUtqdB+VdNOzhc/zTGyTtMxg1ELmugVMB8p9kwLCbWLriYkH1
	XdQZOhsXRoQd3VEiHfuVz5evSE09rpd1eGD8IRqRQo5RF9uOSm0j1h5NM/VLuexwh5uVSPKorN4
	RxsX/UyXGDIkMI45dS6Cm7jtCszvFGr9YLjYT9Rks4M2Ed6AifqiORkvhmlQkYZBc+BhfZThph8
	pOYjCxYdtzbB3pt9o7MqN4i5VFfWALACQn3Ey1V+Q25zNGHQzwdS72/lmZQZAPIy0BfOLKjRbJX
	xMI/I8ohcCVMOfB61r9CkSNeSLyYY2ZpVOHAKI16Lct0S8BOQOOmvFCieTo8boQpTRi0oYNJiGy
	1Tg4V0O4bemQCY3F4ziU51OhsQrvpArvEzktVGtSZ767RAHGJ8EriyMURlCcWPnJzXmPDL9ga2C
	q/fw4xHs9UTA==
X-Received: by 2002:a05:6102:a48:b0:5ff:11dc:2ed7 with SMTP id ada2fe7eead31-5ff33712140mr755878137.16.1772170562643;
        Thu, 26 Feb 2026 21:36:02 -0800 (PST)
Received: from geday ([2804:7f2:800b:feb1::dead:c001])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1ea1596asm4361324137.9.2026.02.26.21.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:36:01 -0800 (PST)
Date: Fri, 27 Feb 2026 02:35:54 -0300
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
Subject: [PATCH v4 1/4] PCI: rockchip: drop 2.5 GT/s defines
Message-ID: <5172389ba8d291fe05bc0887bc97fe73f110c5c0.1772169998.git.geraldogabriel@gmail.com>
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

Drop the 2.5 GT/s Link Speed defines from Rockchip PCIe header
definitions. The reason is that Shawn Lin from Rockchip has
reiterated that there may be danger of "catastrophic failure"
in using their PCIe with 5.0 GT/s speeds.

While Rockchip has done so informally without issuing a proper
errata, and the particulars are thus unknown, this may cause
data loss or worse.

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

