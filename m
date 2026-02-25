Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7372330652
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 22:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058444; cv=none; b=sm0zG5qAg4cfQrYbq9iz0Z8B4QNPreE3xlRdfhmxUdVeJf0mJI4M86CTQCm+xOfCYICZIb/qvOyr64D5Is2pYbtkXEfo9IsK7lmu46YQAzUGTu2gKN8xLKusWNFRoX+mZcQELiE0jF2ER09tW1izKeRbzzbczMogW2jL5tzSRBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058444; c=relaxed/simple;
	bh=l0H724e9NQ6AE2z4R41tH3LSIG79C+xWDlNOKExlgdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgXDKWJCeIVqPVw+xLFyotWAoDSRLy28SYNrSz9JVlf1T6exkyLgaad2SDHdk6VmFx4lhOYd0cHuyKGmCrIXDm/4AhQ3nTz13t42czX+8Y+woIZvcKkaBYV4afR3ZrpQQL+g0poBo1muMllHG+ZoFDS9xnlUi+msf+2PivAQflo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDe71/w4; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDe71/w4"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5ff196450feso160481137.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 14:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772058442; x=1772663242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uboqhfp40Aonx6VAcop9KiDSGvsRTqn5HTahIQ0GvEU=;
        b=SDe71/w46NsaaLnjWf+n9ftZAL37dF/OJOMnO1VFZGPtVETXL3W7sBeSsEuJuwD29O
         aXCEj1mLfUfSE97mLidZ4yLgS9db5AxDmNMpHUoYG891mi+P0fjUwLBwrDpf6zdzBsOF
         vWx7OIHCJGz3xqg9H2svTvLIuWkoCYzVPIk3cEOYnyCSReXPmbxQcJ2eq38L6zyOsFGU
         SXEcc2PemINmeFGrCTXDVRS6zpIyPbptfKMKKEFWf+jlgkKXN/TIY/0QpBlUjlrP9J+3
         6Bx+TpdQptT0bYpQynOelxOQcHLjwSm8d++t+olnbj5e8C4AZw78lUKTeuDRVYAnKG7l
         OpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058442; x=1772663242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uboqhfp40Aonx6VAcop9KiDSGvsRTqn5HTahIQ0GvEU=;
        b=P+Se2DlIar11MDniMqg4AQf3+4VT3MLY+MNsRs4gNV3TtYFvLnQ7e5p89nCpS7PIoF
         Zi08qv0sZmDVFDXjcYEk/pg+FdArImHcR07lzaKkAXl9R+WrTgTwWgRTofseOUvudTkZ
         ltA2EcuIPsvR8H39m7bpcXiWcWvCbSMvfrzYzJ68FSQmW1SxBrX1UIZcObqniH3SriKp
         +GfHYy3eG2f22wID5rYQ8vQSS+tsJXjCuLay6NDeVgIdq+5YQi7PBPG0B3rAjMB+NSKo
         5hRo605S3fdmG/cB3ztvCGKTZ33Gb/VnZ0pyIh7SwyW9eh4oAz1LpHPprc2cfXdc+YXJ
         7zkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+YQvQlclAHkIwpPp7St4pIuEu7WUSzPuFHFlQ+J34Njd+WgFx6qb12qBacjHwlngfivlzAQGfzis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaRkqTbRlKgMH21mU/Zypfmcqsfyd5JTezWXKIaCpuH1zUfUVi
	aPzMrTHAX7nu/1ZYJf8ywZaCdh3Wdljg4b7CG59iFc2aXMM8Y7kHggoP
X-Gm-Gg: ATEYQzx8wnmRB+uYEOgsPNJMN+QDaBqqM/4GOqBHfTYuXe8or0E0hJtRTwJbhzBSljE
	S3nIhzOlh7KH9UsS0jLUZ08hgqEor93uo4x/sEEYLM3Zm9Dk5P7NRSHfic8xY4Kr8AD0ROmfYAO
	Z7UAEAoWBW3R1M8m3FfDTpG7Vc+qJP3gyALECQHfERpEWq05kljegxlyJCxbq9tYcs0Y1MdiiXK
	FqwIHdioxJ5v+oazMp/VLplcn6+LMjkD9Ck+Y4YN7ldOWDgzI9JTqBD6kYdh+s8lhEeLMkz4oeg
	gcrwinOl4vDb6ya9XxSWlsOD+q+n1FDwTeTEFcfsw8BNyI9gHsCgKmTgY3qX9o+uRpgF5c13RsC
	NZsbdxTtsMSUKMCUSO1f3NG4ylYNQm9/e2GpuQnTvun8DgGcJjNhAU2htZCMssSYVeKry2QJBKN
	DTUx2G8FD7CA==
X-Received: by 2002:a05:6102:c49:b0:5ef:a1ea:bd33 with SMTP id ada2fe7eead31-5ff1ce3253dmr369646137.9.1772058441734;
        Wed, 25 Feb 2026 14:27:21 -0800 (PST)
Received: from geday ([2804:7f2:800b:f14d::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91659421sm593526e0c.0.2026.02.25.14.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:27:21 -0800 (PST)
Date: Wed, 25 Feb 2026 19:27:14 -0300
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
Subject: [PATCH v3 1/2] PCI: rockchip: limit RK3399 to 2.5 GT/s to avoid data
 loss
Message-ID: <6238f93890ede7726c342e81f2726c909dabbad7.1772057799.git.geraldogabriel@gmail.com>
References: <cover.1772057799.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772057799.git.geraldogabriel@gmail.com>

Shawn Lin from Rockchip has reiterated that there may be danger of
"catastrophic failure" in using their PCIe with 5.0 GT/s speeds.

This may cause data loss or worse. Warn the user if they make a DT
change from the default and drive at 2.5 GT/s only, even if the DT
max-link-speed property is invalid or inexistent.

This change is corroborated by RK3399 official datasheet [1], which
states maximum link speed for this platform is 2.5 GT/s.

[1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf

Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
Cc: stable@vger.kernel.org
Reported-by: Dragan Simic <dsimic@manjaro.org>
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 0f88da378805..25a6f67af839 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -66,8 +66,14 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	}
 
 	rockchip->link_gen = of_pci_get_max_link_speed(node);
-	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
-		rockchip->link_gen = 2;
+	if (rockchip->link_gen < 0 || rockchip->link_gen > 2) {
+		rockchip->link_gen = 1;
+		dev_warn(dev, "invalid max-link-speed, set to 2.5 GT/s\n");
+	}
+	else if (rockchip->link_gen == 2) {
+		rockchip->link_gen = 1;
+		dev_warn(dev, "5.0 GT/s may cause data loss, force 2.5 GT/s\n");
+	}
 
 	for (i = 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
 		rockchip->pm_rsts[i].id = rockchip_pci_pm_rsts[i];
-- 
2.52.0

