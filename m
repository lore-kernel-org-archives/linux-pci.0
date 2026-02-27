Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5631E36215F
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772170579; cv=none; b=lL4rGgUMzYSN8fx8Ph4br0CyXD5ekWeQ+hXacp26TDVye7XoWwHeUAP55d1E5QcP3+3FWsckSP5XFiIHlafenmuaS1sjRfBO8Yydqv+RAelruZUM7Vm5BqADbZEl0FnMtDGDk7XbaGD8eQ+MxKHeNR4jSBP5EJqI6oMoBRikhmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772170579; c=relaxed/simple;
	bh=kPfTUrEw1DJYMp4hBuNTOxzjcE1/QMxV+oH3eKs6vQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBJDbQqIEPKc6arlA/RUvauT8YBkFXbpVshIfNZY8/E67xT9PR+XQ1ei5arGAhSESqc+8cniBKSSAsf0j29vsN54ZICe9IqTvj0g3RtscSNMchdvX4q5oiJOd2334FmQVjXZfHXwpD/O6XTybBh9H62zzKAT0Dkz2G3UV6AQn+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2prSChC; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2prSChC"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5ff19e74779so1151894137.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 21:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772170577; x=1772775377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mnj0Ip5rhMpZWME92U2V18suyVnTB8PfAkHzESqzgSg=;
        b=B2prSChCZxrbO+UmuAQpBDeDSlEV/2ka9gKSBZTrDv7JOfpGVlNfC+1a6rXnl0VO66
         eCdgFthrDS/6G2a2v0+DhDGqCP/6A7N6lOSJZHpJmCqTmideww7j0mo3mO1L9O/GVSV6
         8zUBG5kfJvA8id/lgYWmtN6ic4QrSPuDZXzcM7CdzIuqyipjdJ4WsEAIFN3TdwbJPfCA
         OXTCz0BWM/xuHzJqD57qRV49d6h9YFkPzzqdr4mX7BGckZvnr7Jyd7iu9Y4X4qvvxMyP
         Fa5Rfv1H0AhwBWhrbhsAinb09LeD9T+tDK60UY7KanM1Hf/uVAVfVTCXe0pKqStMc68E
         ELGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772170577; x=1772775377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnj0Ip5rhMpZWME92U2V18suyVnTB8PfAkHzESqzgSg=;
        b=QrYFj2WTNnxEG/fmsn0963/LRIvJDTD+o3peQHrHSpMvK5nZErP9H8ORqWvMb3cz5M
         kg/Ky6NEFZVwyEcyLqqSdTTinY0PDpHXtG37mZ8oxcdI2ukWWK/4V9ESPJ3lLQE48qwN
         Cv+OMRsMe21wiZb6I31AH2ipp/fWaerWRSQB8GbGY+zWGFJJKxk7mm7KwFTZWs+hMKjM
         10OFxDMnbsAcSde7vZsn8Op1860SaFwF2uam7YSUWsBmXNv2QqPZM2yVwZ2vLOqYDrwU
         I/iJOgw08TUMJWVrnSltsjANb7uoWqczmP1CLLvgFdZhdQU4n6fQ9LcHzpLCtb3XHLYY
         I0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUNyLgoBp2YNbtCwwC7JeHZSmWyy6Xf900YUOdUxRTT3DaIkhqwtUuy/5h94tjWU6y9N0WQDT8h8dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydkJRiMULAhPER+f+GONHpH0V6zcTF538UlqkY+9SMRoZ3JyDN
	AIJ3NBnSggM7FYaxs+9HjUdzIHoHrAb7nV7zzfydanxa7t2OkVp05C59
X-Gm-Gg: ATEYQzyWvyIPz3cBxZYM0UtSeyrMc1375kLeOhvl/h5UooIGFquvJ9WZ3Dd3UTFfArB
	EgLLlVhAosNNGGvftUBCyqPmJT9+rrl8TXDFQwr+I7I2r5gCKABkdL3W/aHWY2kHQO1FLgO2Xk9
	ANNa8eabtG7cwz6mclk4BenTk0WagRmRkQhVSKUAvUFkC8PQqYdqCOpHTxyFXAZNnjCuWdafcSw
	+5gBmdk007s/Zxh1MFJMH7xxn0sDhd+JYs6wxPt8TEgtRUmDyG+zHF4oQUF2e+9c5KJzIKqZG7A
	B1gFrFlFXxFz1DySkBIsLlRHO3Yrur+KWeLUuxBjwM+qG0wr7f0pGp2JsxgB1qQ3dMp5UikdLuD
	46QkzrY9ZjbISGlDAtJFmLdg5i0T0Q5ExPRTQuQt9tGS8e346NYZHlUnwWEwcWbYO8sT7ayH3I9
	kZ1pyJE2c9Yw==
X-Received: by 2002:a05:6102:c09:b0:5f7:2655:f2c1 with SMTP id ada2fe7eead31-5ff3235cdd6mr1120359137.13.1772170577277;
        Thu, 26 Feb 2026 21:36:17 -0800 (PST)
Received: from geday ([2804:7f2:800b:feb1::dead:c001])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1ea15925sm4631041137.8.2026.02.26.21.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:36:16 -0800 (PST)
Date: Fri, 27 Feb 2026 02:36:10 -0300
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
Subject: [PATCH v4 2/4] PCI: rockchip: drive at 2.5 GT/s only and error out
 other speeds
Message-ID: <9e3754ee0d1f5bc8051e28e1a5b8c046440456f5.1772169998.git.geraldogabriel@gmail.com>
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

Configure the core to be driven at 2.5 GT/s Link Speed and error
out on any other speed. The reason is that Shawn Lin from Rockchip
has reiterated that there may be danger of "catastrophic failure"
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
 drivers/pci/controller/pcie-rockchip.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 0f88da378805..26fc350a66c1 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -66,8 +66,9 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	}
 
 	rockchip->link_gen = of_pci_get_max_link_speed(node);
-	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
-		rockchip->link_gen = 2;
+	if (rockchip->link_gen < 0 || rockchip->link_gen >= 2)
+		return dev_err_probe(dev, rockchip->link_gen,
+				     "Invalid Link Speed\n");
 
 	for (i = 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
 		rockchip->pm_rsts[i].id = rockchip_pci_pm_rsts[i];
@@ -147,12 +148,8 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
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
-- 
2.52.0

