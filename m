Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF336B048
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633028; cv=none; b=Rum1gub61p4mg4xZik5MsyPXGA7IQNt1XMvo+/Rx2/cUML5HZPvLEoINDzbTK4JkstL5ofgGG/FAoCIpdu+WCYWav7okHFwaeAUO2ljAN96ylWLzoKQG8F3hhJrkt83GqlRZNeHY3H6t37FNKRJCYWfb9ynSZjUpDkMUr+veetw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633028; c=relaxed/simple;
	bh=Ea39uNzoOXcUgiTO5xa3wS8NidKAL1a3PPM4jAgctJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VlPGY0PySXr1KkJBR5a3HmBaHBE58VoGlzKMw1YmjcW1BhSV+tsrPz5Pyt8lPv+jOKT76B8FTIvTwvQ2QdLGGKuDv3Wo3THfaw+HvoT1FXKwokYXMPrTD93O7yzhpBpAV6JDNLex2cSGQQY3nOZhKByrDkAMrdC4dn3bC49ADIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFr4RiqM; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFr4RiqM"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c736261ee8dso1114345a12.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 06:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633026; x=1773237826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wMG/35vxQWRecO7x0lChQ2qa5zQ+cEwiNdTCEbyqm04=;
        b=HFr4RiqMx42QNes5t7UrornKGqmxlGl1G/VSa2JVSjNEVisz2vz5Mz8yeQ8iP4Q+uZ
         NP/u7b9tRKB64QNL+0dil1PNQuYHnIS0LsTptLuIrE64IKUnUnBcTQ+K75gHEabVQYsW
         83U/n4TySDrpUbYSBW0qCjnAk2iMT32bPgIiZxHnDpj98LO1tOEOlszNJUI14I8xGBeM
         cEeYfmD1Nqb+jAsiz4d3IWe+32rDInTE5hPTl8WNmYEZkphwKJs0PMvWYo5bVHvwUIbl
         BglZrwq+cyWeyiN9mNfeZd4SsDxal/ICMExq4xw4/HAuJFGP0xvj05bSQJq8qoXgyt0m
         x1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633026; x=1773237826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMG/35vxQWRecO7x0lChQ2qa5zQ+cEwiNdTCEbyqm04=;
        b=ZRqXRuuA1FI106LwPx3kHXOFTje2tE4m/q+PtduhH02xoWwz6mLhaGWuchJog6CKib
         Ub28HTTHZwC+V+fA4hi2t0/z2E1M+mzenmJq8AB3msTjG2r6RUhZMED/niMOvgVNmyYf
         IOkUAPEcRrn95TwmslpU/XcsVRve/YF/SWioN9ro2mykwKezvLzNkGmWLF5C4L9Ik0BU
         PPpBUhiJtkHhHBtWMCzWPF1ea5XrR9EzMAbsen2xS4Q9LZQoHRCMW5lQCRgj1G2TD+HU
         TsvF7ECXU5NNBVtdi8YEDr/lw43gKIhSEzL++7UaeXHDU0Wt2SvB4p1cK9Le2LjeU2a4
         fH5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhdZPiMJj3zcmb9Xga9a5z5eOg57R2lzhsKLeHK+o70CGS0a7Knp6WQi5hjXzxqWB9zDLuaEUQuvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCP8dr88r20InFfswtDMDL1grY6GaMLZCjRSLCY2lvZ+yiHq5
	jtJOtd7bGD3GtJiIiZ6XjUMNbYPTtFWqXrx5IFTQbCTvWxTec/79XX5S
X-Gm-Gg: ATEYQzwBJco8QfB3o1UH58f/ABD2RsNps80vSJn0TZCiuBSyN7cTgc3lJktHxJbMEBy
	hT0v6bH/gZZoe1Ri+UZimVOcqz7zHzLo7d8+8Av8i4vk/LghjqDuxZccPnEALvui3VYVB3WAuIf
	DPiua01i3iy8s1EoKxH307jKomF7/vOY8ptJQ3DK+R7aSJnCCOX9XEGN05ybNG/vmM5y2FumIqP
	O10OCDu23aPeAj0WPCwaKBhq2J0J/QC5+6w/8K0dlf1BaO79Ctn4uaQ+liQhIT9ziPviJafRqi+
	DgRfRJeHEs/QqFG1QSJ7a5rvUTF5bT+0FviSAOqn6HnEarkByBUaOSS07ItDTspuIKaOjlqjtE9
	UmcNNf3dJfZG60FXqy3KmS5FDE/pV8h+eITT5h8E+9SfFvpQwEfxuNCYIrljL0N8AeleHYOBFiF
	MYw4M6bqQBrA8wjUUr2wBI5M1Q+oQEZtM=
X-Received: by 2002:a17:90b:3d50:b0:356:2fc5:30f5 with SMTP id 98e67ed59e1d1-359a69cad3amr2158954a91.13.1772633026479;
        Wed, 04 Mar 2026 06:03:46 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:03:45 -0800 (PST)
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
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Koichiro Den <den@valinux.co.jp>,
	Hans Zhang <18255117159@163.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
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
Subject: [RFC v1 00/18] PCI: Enable async probe by default
Date: Wed,  4 Mar 2026 19:21:43 +0530
Message-ID: <20260304140329.7089-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following recent asynchronous probing updates to the Rockchip PCIe
controller, this change enables default async probe functionality for
all DesignWare Core (DWC) based controllers to optimize boot times [0]. 

[0] https://lore.kernel.org/all/20260226101032.1042-1-linux.amoon@gmail.com/

This PROBE_PREFER_ASYNCHRONOUS flag help to parallelize device initialization.

Thanks
-Anand

Anand Moon (18):
  PCI: al: Allow asynchronous probing for background link training
  PCI: amd-mdb: Allow asynchronous probing for background link training
  PCI: armada8x: Allow asynchronous probing for background link training
  PCI: artpec6: Allow asynchronous probing for background link training
  PCI: bt1: Allow asynchronous probing for background link training
  PCI: dra7xx: Allow asynchronous probing for background link training
  PCI: exynos: Allow asynchronous probing for background link training
  PCI: fu740: Allow asynchronous probing for background link training
  PCI: intel-gw: Allow asynchronous probing for background link training
  PCI: keystone: Allow asynchronous probing for background link training
  PCI: keembay: Allow asynchronous probing for background link training
  PCI: kirin: Allow asynchronous probing for background link training
  PCI: layerscape: Allow asynchronous probing for background link
    training
  PCI: meson: Allow asynchronous probing for background link training
  PCI: sophgo: Allow asynchronous probing for background link training
  PCI: tegra194: Allow asynchronous probing for background link training
  PCI: uniphier: Allow asynchronous probing for background link training
  PCI: visconti: Allow asynchronous probing for background link training

 drivers/pci/controller/dwc/pci-dra7xx.c     | 1 +
 drivers/pci/controller/dwc/pci-exynos.c     | 1 +
 drivers/pci/controller/dwc/pci-keystone.c   | 1 +
 drivers/pci/controller/dwc/pci-layerscape.c | 1 +
 drivers/pci/controller/dwc/pci-meson.c      | 1 +
 drivers/pci/controller/dwc/pcie-al.c        | 1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c   | 1 +
 drivers/pci/controller/dwc/pcie-armada8k.c  | 1 +
 drivers/pci/controller/dwc/pcie-artpec6.c   | 1 +
 drivers/pci/controller/dwc/pcie-bt1.c       | 1 +
 drivers/pci/controller/dwc/pcie-fu740.c     | 7 ++++---
 drivers/pci/controller/dwc/pcie-intel-gw.c  | 1 +
 drivers/pci/controller/dwc/pcie-keembay.c   | 1 +
 drivers/pci/controller/dwc/pcie-kirin.c     | 1 +
 drivers/pci/controller/dwc/pcie-sophgo.c    | 1 +
 drivers/pci/controller/dwc/pcie-tegra194.c  | 1 +
 drivers/pci/controller/dwc/pcie-uniphier.c  | 1 +
 drivers/pci/controller/dwc/pcie-visconti.c  | 1 +
 18 files changed, 21 insertions(+), 3 deletions(-)


base-commit: 0031c06807cfa8aa51a759ff8aa09e1aa48149af
-- 
2.50.1

