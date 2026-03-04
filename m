Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1D3A451A
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633851; cv=none; b=oWJYqtzk6i2AZ++y9OUQiGUVlFKpdQO2CMBfRp40lqfqaweam/d4WmVcRL+vKZHU34NUFVfvaaWMgrTeNJfnB2O7Cke6LmXVoLXYpdrAhVPGz8Lemz0+mSxJrtdC+6+SbFaW1BmsQpf2r22nkqKEaclLn1RlA0Bdy1nXwrA1cD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633851; c=relaxed/simple;
	bh=PwMzJDaYmT2axJpaHt17C/g7mT2QkkzcDRg3A4Uz6ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDD3VUok2M0bgXGmiKXnsm7ArUjfqA1MhdPDe/hglAAOi88SL7fRGGs1d7rYava3m7wbkMCM/X0SE4WxebL30bITFuAFHe2PTIL99zRwSfWK6z95H6BmUb68d5DbhKsyitYxFXE5PioRGwTn0LHlAU8P98BUjiCeddTiWPDubD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFGgtW4n; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFGgtW4n"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70bfef17a4so4076447a12.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 06:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633849; x=1773238649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srUiyLQpcPURMgpIQ/orm3Jjpyz5IeQj0sKin7gLX5c=;
        b=TFGgtW4nMFcyGLiipi2KvaZHmgZG2hvPpb7a1DBC44l2H+5iSx0JbDL5f67mGQVUsD
         Ilw8bNkKP/2kkqcNhaOS67l/fsu6WIB6l8mZT/CmCWJRV4gDxz1Bork3GQLyXrE0Sea3
         Qimt0Xc8EhrNpBEVwfZS/84Vdkz9/pf+BkmTbAS50uJQEY7BFqEHySngvvdOaVF4Xlju
         V3unPLRgb7zuqnPH6fAS26Pu0QAyLxr3eqmQTk6j1fbqeUyNONV4hM2SsLX9j4o5nLci
         qLYqGvJCqJUGJ0wLcSwa7mLsU3CowcsyIJz4QtPzNnowt9xYuqjbwIxfqqAptSmznhq3
         hM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633849; x=1773238649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=srUiyLQpcPURMgpIQ/orm3Jjpyz5IeQj0sKin7gLX5c=;
        b=EgPvJE1CJogXSzTWLgPLGIGDoVUIxFaVHbA6FW2mC3egoTuQi6c00M1n/xUrexoai8
         UrbtjQi/1QWgYC64BzzkRE3P+5qWNgmMOKOPyRnNMeg56ae86UN3Kl4Tx20uLZez46F3
         SNNlEU6wQcl0CDyaf8RzOaZDrz3uPKD1IO3Bxbdps/PMNIHqyhpyc5HGvhLvnlz9QDyW
         pOeQ0z4StYHD/Paq4PSll0wXxpP78i+gtOMOKMvyoIamhpcJCC29bcHIRnL4XCxS7IOD
         DSBO2oGgEqhnihYWbc3tV/+t5rJBmDv+WQXppPCfepYhxXEMjMZe9MJY0iqV6r2NLCSS
         +xhg==
X-Forwarded-Encrypted: i=1; AJvYcCU1W4hUn8i3jTbl0DXDGukaXR3d85SdsQKbf4MYztEeU5m1FT1beHiNPug9tcAZZxtGvayu19nSZhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxucWUMY01lgF3LorXfL0Wq2zyjYi3obp1oNkHABO5ZAavXfs6H
	Yzc/XbYwPPKBuae9sfXS2nRFZ0vGEhjFUEXuapks8vT/EL2GdOkxoPYK
X-Gm-Gg: ATEYQzzcRmPUL6QCyWF4/PN46a0TKJtRw/O6U3Uz4ZqlY5kH179drx4w/CL+AooeF3o
	dlmrQkkv0NAFZNNYzzIlcOpmlNPe8h7cpIrei3Y3DOm/cZgTYBFVYbdoVizyXsBpgBMwTylTLr/
	Vbt3pT4M+VC3bXgYPSCCwMINpPOIYJyrl++6i2A5JhBgImJNG2t8dGuvPfHhHhoEmJVQGltvkj0
	4V3wQAbQp6Vi7Iu/hhstLzMP8xN+KI+PFKmCiDCTsVaXSk2lGR8n8mdlhJMb36lbCuNN49zyz0g
	HpyZRZaWlgLqkkMJgncNuqGD85XkPbkNX5XbzynXEaPkVTEGQdpRYjjsepqHLxMeqId5Otwtj8d
	a4iGIl/UjAVPHNI7Tj3hF4pem3CPgOd+qzWYX14eFyOmqWJxfyjuIMCrZACgB7K8vIMtJs7e11M
	PiU0haK4URCn1JcAohJsFR
X-Received: by 2002:a17:90a:d2ce:b0:359:849a:7357 with SMTP id 98e67ed59e1d1-359a6a3bc3cmr1764561a91.20.1772633849089;
        Wed, 04 Mar 2026 06:17:29 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:17:28 -0800 (PST)
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
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Koichiro Den <den@valinux.co.jp>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Frank Li <Frank.Li@nxp.com>,
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
Subject: [RFC v1 17/18] PCI: uniphier: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:22:00 +0530
Message-ID: <20260304140329.7089-18-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pcie-uniphier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 297e7a3d9b36..53f3bc9f5ba7 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -404,6 +404,7 @@ static struct platform_driver uniphier_pcie_driver = {
 	.driver = {
 		.name = "uniphier-pcie",
 		.of_match_table = uniphier_pcie_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 builtin_platform_driver(uniphier_pcie_driver);
-- 
2.50.1

