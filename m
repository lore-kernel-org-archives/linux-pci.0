Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02166221721
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208271; cv=none; b=YGKnQykJF34W9gGwFJqJqA4Mpe5Ip0buko/y8qn3UsgcwnGnUSk/y/jsOb3f1uT80y5ViuT0WAy88LzfNOORz0kT11Oq4T2LKxx9+uoNhho4ei8riebJXo+noAN/wiZ+AWEAX0y942CiREf1BMk2zT8sJxEA+F16LZLPgZywwHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208271; c=relaxed/simple;
	bh=gXRE62zSwChwM3SXDcOyQCR3fTW92/QJIOV0+o1WzRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTwRQL/LbECW2F+zL9nDbhP2mwrPT+nrx75SUHOIIXFoo0mWgvfDahg5nwgsWQUvSptJrG9hQfyTtjuMFPaSnDiIwggyWrnjJAYFYK+VztWDRRHsvymJosipq8QbIlqsx10xpWphkiT2zuHnS0+dDk1mcAtxkCfJ1H8dnunG2MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=datUvr6T; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="datUvr6T"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5176465a4a4so1887681cf.2
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 13:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781208269; x=1781813069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPHgBrADPApAfZtc/YSxupn+3CjApqMQNAHkj/6KsE0=;
        b=datUvr6Tb6VgKh78CSoMIlgB3W5kBtOkB2l+yuQfKKroQYqNSRJc93vWEHV2Qjgcm2
         DJRAi/Sy0D5MC1TbkPAuI4fW8OJ8IHx7JabkWHrSFmufKXDGNLIrwQb6/J/zcOdoeBKZ
         F6lvx8SKQmTfdknK0/RYJdevdvxdRC/pG8UbBAmk9EBMMMdNzbkGeOZLcQIv7VUyu9xE
         4x0N7u2CSGKeY/VF5pzGloMohLgaaFXOEaf5aUOBW+aetOjKaeXYV0Pop/MFpLtGZYuL
         Y1M+2XEYIKj3HUONgksOExDjC6vqIu7K6rp49spfgjT7fiL2O/AGav4zcXWbUr+vauz8
         JFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781208269; x=1781813069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPHgBrADPApAfZtc/YSxupn+3CjApqMQNAHkj/6KsE0=;
        b=oOhT4KgG/3XlwlLNiA5v6YFt3kTHGlUERwl9Ck2/40f5XY95lh7O1uFQiJ8COtakA3
         lFZDrlP0CB/v2Ha0cLGFVMcM0uNJacuT6DSOm+qH4qDSSCNeO9J3bNjzGCOUR3pUGIRD
         +gaJJsyST7Atf+Zv4biYCoeZlgdhaDEfKAXG2qjYN+pDvfTWwQV2cLhOiIP+upDPu+rL
         Sx6JRjmWJr3DJYCa5VqN/7hwZ5nCCnMW4DSh890RpFA+AQmEyZgzh8V1jHRIFLMtI8sW
         i5ueRs/w5oGgcCzcLyOdBpwUfqcr292Rb7/ceYqqo33wCv3a8Ery1gbT9i6LZuJ2nhzF
         EDCw==
X-Forwarded-Encrypted: i=1; AFNElJ9uw1Mi3bxtsckp6/oca1YFcKKrCsx7JuFnsNQmgapMnQjcLeh+DWOr2jniBZ3gZWo52XttsZkdVU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylTPdvKUGxyfkD1Hgb8Y12xmey9RZABMcnBsUzsH40e1sdh8rh
	UWVWunB8/2nmBKBzswkTXI1RZE9vuK9byc654SsPiy/yYcDTxJtRTz7M
X-Gm-Gg: Acq92OGWTVum6rzme+9rsc3WGhQPvMD6ckXVAdwAkxfJyf8qmhg41OTYXwB5OFzJ/i6
	hSh/DH3+I2q0qyFq3BEAKVElBUjvOY4MWXKmHJu1wwAO2WOAxejH4A4MIks8SCMnWvpSuKwBxaN
	U60ZgW3UWYaaUiCXXWoe1Q7dKHBfzKALl0LbeWTid+FyHHf7jhkW6EpKYUNyNl4QEH0FJ0evF/q
	2ZUmr60a68bTg+OSVGqG/LYvyDOlsWytGVCULN1weMevQM0+k83lXjYr2O2dqQ62d3g2kF/5a2L
	kTlkSqzHSV/CysAEeSWRApbGGEV2Iz5/HnxYWrVvpg9sQhN6mYSgduPJabZdApMiySGKt4MrB3E
	HCxxkKoSh7r7TqpDWndw22eXrogLqKTOrojNbdyqPsAioeIBBPgz3+yhJwAeTRMPps7uKkKXWJL
	lrKK7N6M70
X-Received: by 2002:ac8:5e4d:0:b0:516:ddfa:23a4 with SMTP id d75a77b69052e-517ee27dfa4mr66606851cf.41.1781208268618;
        Thu, 11 Jun 2026 13:04:28 -0700 (PDT)
Received: from geday ([2804:7f2:800b:f09::dead:c001])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d300f6b962sm3322496d6.9.2026.06.11.13.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:04:28 -0700 (PDT)
Date: Thu, 11 Jun 2026 17:04:22 -0300
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
Subject: [PATCH v6 3/3] PCI: rockchip: drive at 2.5 GT/s, error other speeds
Message-ID: <4ac5cd7d2271df375ed6307f5c394247721395d9.1781207474.git.geraldogabriel@gmail.com>
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
 drivers/pci/controller/pcie-rockchip.c | 16 +++++++++-------
 drivers/pci/controller/pcie-rockchip.h |  3 ---
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 0f88da3788054..5a2876d7c8547 100644
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
@@ -147,12 +149,12 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		goto err_exit_phy;
 	}
 
+	/* 5.0 GT/s may cause catastrophic failure for this core */
 	if (rockchip->link_gen == 2)
-		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
-				    PCIE_CLIENT_CONFIG);
-	else
-		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
-				    PCIE_CLIENT_CONFIG);
+		dev_warn(dev, "5.0 GT/s may cause data loss or worse\n");
+
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

