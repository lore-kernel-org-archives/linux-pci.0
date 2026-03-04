Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2C3368B4
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633657; cv=none; b=mEMY2UylOipeUUy3PvswguethJ8PCExs0oDyr2+octkEV8M+5Iy80+T4GPFQs6ibM5E99QX3FBAWCC/aKwfvbX7pVku8htjtP7PzBM+jULTqaZ4FksBt9061ziPJ8bJxEg9AhtHhmTmcUiRIq8TlXz0FV0IJtqWairpF2Ayg6js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633657; c=relaxed/simple;
	bh=usU4AsKxYiL9wPQdX55tLEiVuRtsJkW47W4gt0QH30A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gp5RkJhv3Bwziet1wefyBA7GS2FTCDCOjZBCVI9+CH6y+a//KC56/NRI4/p7Smo4g569JOkC6eBQWVX6APOx1rbTmPfmVCCySoToITqisKL9QAixwkukpHIV4lsoGucwuxPGwyB+u9HhiLp+rQZzTXLeMrigX2pRfJOkxH3HDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArhD8jr8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArhD8jr8"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3598581ed7bso1408195a91.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 06:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633656; x=1773238456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iMM5LSmFDPAj9DIWsk4fCcz5M6Z1n4D1h8BmNreiQQ=;
        b=ArhD8jr84XISWVl9gGSrPW55hIVw3gBtgBKt477yhgWT45O36LWXe4aN0XIP6hcMj8
         mWAhK5n4JzP2AqnJsXs4O030F5lYx2A2hpJzmZ3eb6IqV5/CfnDzAHXTAS+t3L5l+N/4
         hmeJ5uEe1eia/mOH+QE6NdrbbXCZNK/H1oLcySWmwrRT7MsONmFNQ1nugQl70PiAwsIO
         UUuGDBikvkgVk5C+OJD9oxCwxfBKoQ3nsL1ApAwqPAg7EscfkUu+xwA5Oej/AXO8+NE/
         UwA9TY+F8i60eZH6hA7lFUTGC4B13JysNYlw52Dakhrzktky1O4vu/s5CIBbaeFaO0wA
         jG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633656; x=1773238456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/iMM5LSmFDPAj9DIWsk4fCcz5M6Z1n4D1h8BmNreiQQ=;
        b=J9v0974ubPZco+fiGqel6Q+IuMvZADYSebbXWxaORo5OPvFdBidXlF4EeRSQjK653l
         u8tbdjAnY6zhp7uWWE6GzZS/SBWXzqZHy22hL9FJTfvDIdGLJJTyjRpBYNckq7t0jsLU
         qNNb0IITTgZYfxgjp3PRKcAtI0FjMncHtMd54/1d39iz/tD3FMzO8vKGU2qN1IKGkrme
         ecgqhKCj4hcyzmeJLKHqQ7hEe4vsnvguR+PesAm/wHn2EyAGA4XeO4B3cruDTv6Cyxcq
         Qf48RAvirTzKcgZQ+2ZZYwCTiw+oC7lYDOtmEhpIzoyunKZ/GUkpdllnX2jGch1CbDfZ
         inMA==
X-Forwarded-Encrypted: i=1; AJvYcCW0Xk7dS5+4/qjTQMgJZwyg/BcNw58p5sJK9WhMRBwagZrvBOq1Lftrhs/zCocjV+Iu6WA9qg4QGHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1TnTXYw8SljRNryJ5J1LUQrSIC8L3VP/dnd3YLc8rPFCaDzh
	PCeXPL8TqD5TYgS1G4ZO6/3JdNgkBSl5d9WSFJ0TpYUS3cfzaazovnSG
X-Gm-Gg: ATEYQzzizlhRB5c3vQk1x+FFFjcFhCv/aZYzdUIYhTwXeVl2XMEyt+UOHMBNvk7xEvv
	i1FinSymCuzmmzhOWHKEUHHeugJVmKD09ibNRYIB14QDDmrZAj9fYSOtqQUN7Y/onkHqge64mIs
	T8lDDxm6x6LLYbX8u/X0s7ukQcobstNlo4SNsovh8yKltPqEZxwJ3D7Dnc2nIcDnzZedTKFsR/Z
	A6H6ktS+heHnjOVMvx6t1qBVsPXS2uwPU5Wm5iMhK5/5oaUUa6LPxDoLTNppFQyZ6uyMyxPFHkJ
	dcb/2+1nGZRKDp+fYhV/i+KW+wQbv/0eXfWnP1oEKEllZ1qPhcWDUEtsroYHzMI55jNi0h+QEBP
	sodGbC8pF4NSvF411In7rPo8crpXjvAsubjioOLg0iOPaEmPv0kLFq1sitjlbYnvHvZqBKjCl3w
	FWszQMJEZILXmsubPJJ9W7
X-Received: by 2002:a17:90b:278e:b0:359:8632:5e39 with SMTP id 98e67ed59e1d1-359a69adc3dmr1844903a91.5.1772633655971;
        Wed, 04 Mar 2026 06:14:15 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:14:15 -0800 (PST)
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
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Hans Zhang <18255117159@163.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
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
Subject: [RFC v1 13/18] PCI: layerscape: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:56 +0530
Message-ID: <20260304140329.7089-14-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pci-layerscape.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index a44b5c256d6e..43a28d9ea7b0 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -410,6 +410,7 @@ static struct platform_driver ls_pcie_driver = {
 		.of_match_table = ls_pcie_of_match,
 		.suppress_bind_attrs = true,
 		.pm = &ls_pcie_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 builtin_platform_driver(ls_pcie_driver);
-- 
2.50.1

