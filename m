Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81405253B42
	for <linux-pci@vger.kernel.org>; Sat, 28 Feb 2026 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772240141; cv=none; b=ebd54kP2v6Ij2TrZep35w7/P4sIR6kE7NsTKjGslGV2sh79GTU/4FH9W8nDqaS9GHyP8hgRla8VR9U/vcvUaJ9geh2B9svMhXngpKBNf67scDKhEhD+fAOkPU0RsmhGIGRHz1E2pPJ651HG3k5li7Obeg4riFTNnP4RmeR7e0nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772240141; c=relaxed/simple;
	bh=hsxOxdrEY1PMfZN/TdsLyyMTLKH0THeR1ALrpzgaJVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VocPLOyx6qc/ollgs7tQ+npAJzW4GwDfLqwdjFL8wdO1QbixSEPYzEk7RjlyZteqHxbHn8HEyn0BXOvClkZbaRM7NdFp21LB/zaKmYjPvLyDZjBry6olxW0TOF67KhpWCGhC7sHMnxNWL8u8SoRUD3dg3nNqjsV8uax2FgHCGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzeli0dB; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzeli0dB"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56a9402b52fso2220387e0c.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 16:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772240139; x=1772844939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Cy6OANas5Ke7+g7WCbIZUx6sasEupi+10uNQ6dOOFA=;
        b=mzeli0dBp/aoHl9aabai19dq9wQ1TEE3dDi8aCgIIiZxLEk+rWGQ4Pe4vm1iffxih9
         BH6YQ22Cv6WoviPvsfReYADe/dT4/OXXas2F26jQ88PY13MMYcQr/8cLjwFphn6ZxYic
         fQ4DBtu88g+/xt4W0HkmEIHvzj9ahrHfjFCmSxJ502jnfevGIBJew1+t7D1tpCNyaism
         USxrgiZ1S1fPrTbhsLkoLlzMDh2KgdVlnPD9+2/VRLK/9tow+aa7EX7NsdGm8h+pkNfP
         Dzlcb6PBUrWaeC8AlY0i4546E7DXJ1gTeqVfoc5RyXAia4C9Vs6pqOpiMSp1V6jDYDAv
         s7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772240139; x=1772844939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Cy6OANas5Ke7+g7WCbIZUx6sasEupi+10uNQ6dOOFA=;
        b=byDP1mRXAnEyI3UWAaqagyKUvJhX2J43nhbRWZ0pbyUozZz/RAVkY9xEz02uaySfjK
         hCVU/5RIjYFRmN8SQ7bcgbdkDmZ0m4KTBMSgUFWIJcXMHTcjoftMCgTj3dME2kAPRJas
         A14kkCGSr6YNqubVq80Txvb/VL6la5e7dbV6pCiePVMR1UMcxDwV4X2zrvDAAV4W0bTf
         lOhr6KbotKR3zE2VK0BHEtfB0L23rnnzW9vr6isQphhmskE9ncxuL/IsCUQvMvHtMf6j
         o5mpIjThPGXn1X7MBi7lpaoX9dNSQFBT7XwaBWkgxBHJrr2lSH6L7SUAm2fyXrTMK5ca
         b7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUR4heQCdMXDv43Z1nZV5ZfBYcXqg1KEM4TI3Tr2tHqXC/AGL5FmcC5kT8ekCcUFdbI6rNZt2FRvng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOivLkIvLc1pI7wpipGqVaN7TbzOAFvtgOw1nrR//eUhwYLgnY
	wcsmSElUjSadvZT10xNafpZpHvQKjRRchk8ro7LjJxn8XnI31SYJ+65/
X-Gm-Gg: ATEYQzzXEyG4NZUFe8a9Ef610mk57f4cmQ2RidBhhP8mfrKfBsUIbGx+y5Yn47N6faZ
	RTM/g4Ak064kwZmOK6TQr34zdWFr2EJqeInJZVoe7/2mPAtg32y6PIEgARKZC0Bbs3GS9JQ9yxk
	1IPdYDpOVOAmP7X7t6zkt4bXiE1k/PA6NfDkZKUA2iRrxDQhxf0jn92akXklGd6ndT0qsdMAZNr
	YVhSUkWRQ0rdrOQpvhIZ4VuDuxNA0R5gzLwgpkLnq0cordm04J/i/lbwkhapXRmwGHEd3bM1lqe
	Bbv0wPTCZCdD6MNx6WAHe7v3geIx4TdnkEzCJea4RWNxjTbyMv5QySATM3x1nte7046ULC35CXI
	KysEabsAoG1wWF2LImWrpzL296exYyLr8mWaUywtqpicl48k9XCG9Wh7Nm3+p3nk3H03JBTEnRa
	l0CTTYvAK9pA==
X-Received: by 2002:a05:6122:6992:b0:557:c6d3:5c0f with SMTP id 71dfb90a1353d-56aa0a941c7mr3144441e0c.13.1772240139485;
        Fri, 27 Feb 2026 16:55:39 -0800 (PST)
Received: from geday ([2804:7f2:800b:feb1::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a9228d776sm8234832e0c.18.2026.02.27.16.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:55:39 -0800 (PST)
Date: Fri, 27 Feb 2026 21:55:33 -0300
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
Subject: [PATCH v5 3/4] PCI: rockchip: drive at 2.5 GT/s, error other speeds
Message-ID: <2a0a4aa97bb8b0cb511cb651c5d66c9ec8bab97a.1772239598.git.geraldogabriel@gmail.com>
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

Configure the core to be driven at 2.5 GT/s Link Speed and ignore
any other speed with a warning. The reason is that Shawn Lin from
Rockchip has reiterated that there may be danger of "catastrophic
failure" in using their PCIe with 5.0 GT/s speeds.

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
 drivers/pci/controller/pcie-rockchip.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 0f88da378805..2f211d1f4c7c 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -66,8 +66,10 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	}
 
 	rockchip->link_gen = of_pci_get_max_link_speed(node);
-	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
-		rockchip->link_gen = 2;
+	if (rockchip->link_gen < 0 || rockchip->link_gen >= 2) {
+		rockchip->link_gen = 1;
+		dev_warn(dev, "invalid max-link-speed, fix your DT\n");
+	}
 
 	for (i = 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
 		rockchip->pm_rsts[i].id = rockchip_pci_pm_rsts[i];
@@ -147,12 +149,13 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		goto err_exit_phy;
 	}
 
-	if (rockchip->link_gen == 2)
-		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
-				    PCIE_CLIENT_CONFIG);
-	else
+	if (rockchip->link_gen == 2) {
+		/* 5.0 GT/s may cause catastrophic failure for this core */
+		dev_warn(dev, "5.0 GT/s may cause data loss or worse\n");
+	} else {
 		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
 				    PCIE_CLIENT_CONFIG);
+	}
 
 	regs = PCIE_CLIENT_ARI_ENABLE |
 	       PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes);
-- 
2.52.0

