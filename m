Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7D3B5822
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633465; cv=none; b=SSXA10IFnZ3rpiyb4nMKsFNaUJ2qR5CwKjgSM2uT7TkN0WWDOiPd3FqqZIHgOvBk3Oz7F1ARGKZIQqv4WNiUX+V2RJGUJ4evT7ke4IyGpfqHg+Bk4CIPpJnZGTgqZazmZgd3vg/xcHgDfAhDtb0PjvHFKQhrPZS/TgkFcbIH/Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633465; c=relaxed/simple;
	bh=dGHDNG1M30BMwVefPBCW8ENkGd1Eu9rEV3i7SZBHTKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5PUKFRY9cYeFU5otj6gh5RAhd2b+Vk385svU3eko8tsisyQziSZazNKo4Ulh9D63ccySdKQfgmnaTu6NmiWplFAiEwqk56+uZbBSxuw0wOFi6q6tvqHoTfTi/bo1n57aWof5iWzcIsItjh3+vmqr48m3K+nLAnrUs5LCZjjZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShJEYBH0; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShJEYBH0"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso3054622a91.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 06:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633463; x=1773238263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eksk2NaSU09NJtKXet9GHYtfaMBPJpP6oyy4wD9BvXA=;
        b=ShJEYBH0UB9Ray7VjyXCHI6fyNKvIlHbA+xrR4m/AGdpQH2whwgI7uRmfUjLqxyUdj
         IeI1kvLuJv9pZJ74g3sCEe/QyLPURPuMRjLJsXRqFf0VqmYQHgBMeLJfE7Ed+Pa6+NmH
         7XaC7sKjPG0DFY8sBmb/PhVT42QxtSVW/dLCLJxvpEnJiQWVcC/WYzmz87J7GM0vd0yf
         B9BKoTN4y/t5tWYOftwMt1K95cAWTSiesPWDtyr8t/GrC5tO6Z5e14GxLPWD6RBAuYVA
         e7J/VkSCwUASaRdb7ckRv+elx4KddU4ns/y5ya6iHk/fwL79amP8+rX5D21o8gq7iVBy
         npPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633463; x=1773238263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eksk2NaSU09NJtKXet9GHYtfaMBPJpP6oyy4wD9BvXA=;
        b=m4Vyu1VnpUpQX81rl9CLPNQ90e6f/2YerMjvk8A+j87fa/+9hhdzeI/9+CK5wduiOo
         XIV1uTHG76KmrG+noW+7ggND3z+lcmZ0E6hc6G/xGm37gQSZ/mitAdCSnW5HP9Mf+B3C
         cJMX/Y8GR1Hh30e09aspdj4FSDGhgD4wIyzL27Cmv15qH8M5OwcIZrXLOXXT/dkJPDnm
         2UY8txv9HcI45FrLAZ3t3f0HRubJlt8KbpTveYKF/6wnm7x5noBN8NUJNQs38ou44v8n
         dYhxLC5Dl/csjDqi800s3lh6RX8jHl6P0CUHUcwV99ISPj6UOhfNGJAMSopTGFzpUdZJ
         hh5w==
X-Forwarded-Encrypted: i=1; AJvYcCUsKRRp7nNoEj8SLQ36dmZKXCJKdZufdrH1HvxUgCwte676zpivMpZ8ohAICdgmKlksuO2kMs9j0QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFDgL34D7ISMP9TFnLYsc9qj52Gt624NQgzyUje+RXvmPl/WB
	K7SVLCJU6qZ7f2PjQJQsoJB410Ism+8M3m6+Bz4SjYT4xIR/OZWLWq+U
X-Gm-Gg: ATEYQzyq1H+UEGVSFALbNIt59R92e8jDErLziCPL7rEkEW3qckL6lMs+VUmQZE5mzZo
	vfdrZ4e5QvvXXtkcJRbwjFvgFGsSGggwWCujZF1dpgEKlmdIrMSWuVxzc5pX/7qjFX9veVe3TUX
	zLncMApxyWjtqVO7rK7hjq9IY/1tVHPw/oQXaygfnTMhrbo3zPORnANhE7cUiG47wRY/D9Hm1xx
	nzRPv9kDC7wdjM+BmCf0U5hkDIYdWL/9fC/b1O60wYgtJ02TodUA5g8dW1H1kX+ByH93uqXaqVu
	mLGYpPrOJEgjIhDUeylTEQEZ9f6xYoMZXq+kXxoWFmT6mq7M9vZ17DT0VK0O5hBYFYxTBRYpVPF
	jbw4K00AwT+6Wk3pkbWo0x4k788N4cqZeUzlLKcg4WlOq9GgZk/gbJbitdgAZ467/Jxy3JcU0ZZ
	sQq+oyuELtgo+d5kVoNHjXZ270S5uaMGw=
X-Received: by 2002:a17:90b:510d:b0:359:8c63:8ff2 with SMTP id 98e67ed59e1d1-359a6a4f880mr1548752a91.22.1772633463114;
        Wed, 04 Mar 2026 06:11:03 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:11:02 -0800 (PST)
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
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Nagarjuna Kristam <nkristam@nvidia.com>,
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
Subject: [RFC v1 09/18] PCI: intel-gw: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:52 +0530
Message-ID: <20260304140329.7089-10-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pcie-intel-gw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index c21906eced61..bc5d96dc12bf 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -442,6 +442,7 @@ static struct platform_driver intel_pcie_driver = {
 		.name = "intel-gw-pcie",
 		.of_match_table = of_intel_pcie_match,
 		.pm = &intel_pcie_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 builtin_platform_driver(intel_pcie_driver);
-- 
2.50.1

