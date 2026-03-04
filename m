Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F63B4E8B
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633512; cv=none; b=Yrn1a6Ko3vbLPDUzU0t6IBJR68cdBqqU3fbCZOYdT49QNzbnrHxob1wse6eRA0HHkrqQKLM1zfceIS5emfshh6wx89rWl+5654gQZY2ijR6fIJc16iehk8SzRVykgboKy6ftRL0KfIVLhy1VbvLvfwGGNsIr2qV1TIArS+Ekuf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633512; c=relaxed/simple;
	bh=sHoTROKxYE1tGVUpJLWua74R0Zndw2ipLQTGkl+pgQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTALzhtbLdbbfu/L+9U5zUthcdQ2w+AWajFA2Y+sEcMOmEQ8DWXRtZzUNgeasT28oqvkBmQQLeMvObttGPoZwce51MPHUD4MPoLOVfAzDtBUj3yr9Y9y2zg5rOJ0snhsVUusLD49Mdq5YN39DhkabwBJxZR24rvj7BOD9pJJ1vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du/ORrL1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du/ORrL1"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c6e1dc5c5edso2626678a12.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 06:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633511; x=1773238311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aROfauUNCfk0cLD7hgwZVAJeImYUlQkQwfOgm/TavYo=;
        b=Du/ORrL1KfTBAeWVAEeEMHu+KYevPCJ6Hj7d72cy1Sg3RSQZyYPfe4BFNhvn3Ex4jH
         v7deVtaig3lmuFmQ1d1X56TJ2Sw3DgPMjszSGhEx71BLkMV6IDI8L0FrJIVqsM3H1BLl
         BPeJg0D08P7mYdFOLvuehaMFhaTKJW/AFZ089F4/t+a1Fro3l5WeN1txpFu9kbXKYe8L
         Ah168yqLNqzgdPiRtP9RCGiEuywSiw00NKlVixnmm339pzFz3zaB2OaIjRn/uT4Al4aY
         zRS4CidaUayEOV7ATBfvBu63IPI2s9w5Rq7PL87YKpeKVPKDJTiKV4JclwAPN3vhGnE8
         X9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633511; x=1773238311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aROfauUNCfk0cLD7hgwZVAJeImYUlQkQwfOgm/TavYo=;
        b=GxK36QCxNWW0Rd/ari9u2IttsP1A5fJH4VFOwhZ+UZetgyZibsugmFFwj+PfPw5R8H
         npGvuKJKjSkuFhFJGgx9fOnF/1jBMf/imxt3yprmp4sCJ9k809Elze8pwp6HTsSSYZdA
         HAeDV1bg3Q1gwBUb8ggVsNP442e8spCv5RDzoPCCPzQsOQeRSpXYO5T3lCmiZC/kk8sx
         o7RRh4JPCURmHDagQw2nBlrhxf9z6TwoOoIwa99E13/tQ9ZPtcl/R4IgHfsTyxBY2fdT
         6s2GxhhvXgNNoEfLC8BnJWqyqsBPZthf+w3zF0FOGUmHrNbvINfzQi+kJM8KOvzugmPY
         JSzw==
X-Forwarded-Encrypted: i=1; AJvYcCW8fSkqqCFWgIxzuAmZG7A9EjYW1P0r0PGdsa77zIWAYW4mkXFqeqhagn0dfmeij0qznu1eVVewPDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy51W+QzupSr3hYawTVqaloiSzKUDhNsk3GrVWQ+9RS4E8Fus9W
	eovIXuZA5P/zXErH3Z3PnebOzYaGig4wflL6ZJdWKI3uMuh8zHIUxIm3
X-Gm-Gg: ATEYQzypCKypH+LbtZJNOMTp+FBmNrQU/rGBNT9AqpTP6D11bKGG93NgDQXCfJkGAzZ
	U3OHcY6ji04vx9P68OvwydbWDhzH/Jo6x3MUz1+RJwLAQbpazUnukGFo2iv5FthxFC83WLePPN5
	HeFG0n9aH7I+kmYUI8Ltl3pDzcLNjcxQDxdkhxn+ZwtiNqDO0lVFebGkJi9oopmg7PSLgzUYCP4
	DkhGpnIl8c13tWqjr9fjTGc141c9IlEmsclWKZS1iPZ7+bpzXhIMfEQ+ffi6tz7hMWbl6T72/Hg
	NW2nNKelVqUgiPfHeaEX6CVBNjTUlYZIYx+1pDKiqa9DY2EwyNm5dXh++bsywJS82RvQpGYDK4T
	naSGiWsKCwARYnj80NZXfZlOQjdhT3/6JmsAyeV2pdEtH++vqLGgCIAjYs4AS4KwAY77QQtpAQo
	/LsEKoeRFZDdM/K5YJ+Z2doCmtWOH5gV8=
X-Received: by 2002:a17:90b:4e84:b0:359:7eb:d91d with SMTP id 98e67ed59e1d1-359a6a575e7mr2125758a91.26.1772633510992;
        Wed, 04 Mar 2026 06:11:50 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:11:50 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>,
	Yue Wang <yue.wang@Amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jonathan Chocron <jonnyc@amazon.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Paul Walmsley <pjw@kernel.org>,
	Greentime Hu <greentime.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Niklas Cassel <cassel@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Vidya Sagar <vidyas@nvidia.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list),
	linux-samsung-soc@vger.kernel.org (open list:PCI DRIVER FOR SAMSUNG EXYNOS),
	linuxppc-dev@lists.ozlabs.org (open list:PCI DRIVER FOR FREESCALE LAYERSCAPE),
	imx@lists.linux.dev (open list:PCI DRIVER FOR FREESCALE LAYERSCAPE),
	linux-amlogic@lists.infradead.org (open list:PCIE DRIVER FOR AMLOGIC MESON),
	linux-arm-kernel@axis.com (open list:PCIE DRIVER FOR AXIS ARTPEC),
	sophgo@lists.linux.dev (open list:SOPHGO DEVICETREES and DRIVERS),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-riscv@lists.infradead.org (open list:SIFIVE DRIVERS:Keyword:fu[57]40)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [RFC v1 10/18] PCI: keystone: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:53 +0530
Message-ID: <20260304140329.7089-11-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260304140329.7089-1-linux.amoon@gmail.com>
References: <20260304140329.7089-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Establishing a PCIe link can take a while, allow asynchronous probing so
that link establishment can happen in the background while other devices
are being probed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 20fa4dadb82a..b5c0c690593e 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1351,6 +1351,7 @@ static struct platform_driver ks_pcie_driver = {
 	.driver = {
 		.name	= "keystone-pcie",
 		.of_match_table = ks_pcie_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
-- 
2.50.1

