Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98CB3B4E96
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633899; cv=none; b=gI8Q2wOfei22CeH9/ppb7StwfDgRAE/L21qQlEwG95wOhL8dfSCbalZmY8vfDnLIHfW+YtDYKtd8WKad7rGPkodpLL7sV51iGjxoXC2xCCXlS4xRP8vKnrJBhiNTGfJd4tONhiB2r4KPdh81aJYUE68aU9HpdYRxaznyStIYTio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633899; c=relaxed/simple;
	bh=MFtn++fehPz2bcYxQs56cfdjtPdPajpg8F67EhLU4r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsYwyFF5dR02DnXvXhK96pjH6wnKP4wlku9FSFmYwCj0ogtFh72lVhb8VW7F+7vJJzImzy14ZkssJqp2kHXVLWd0pjlAQzZ2GTz9+ZCYvbPA4/3xgizDvx9tZRTj5JWIJe48GnBAx0lJuOqUPE269qRxdm7kwXPn42So+12u3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCY2yi9f; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCY2yi9f"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35994d84c6dso1234936a91.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 06:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633897; x=1773238697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOqiu9rk3pfbNQbzbq46fMvxLJFiDFeJ6tCyKh6dPNk=;
        b=dCY2yi9fpzXaTO93FzvbGxrN5zrVrSNiKzsDjv9krXAuw5iO51gCedPntI1sFcvvYc
         JpTZ4oW4MZq7ZurW9PuZzqwvfHTvhugisL7lA+iKfObo7nclFMfJBrlGhrBcrgrXIPHT
         8pTdOjnvKOA0jUjneAozr4wA3OKDOrglg8ircrZpe7OnthMFybZ27QqrbzekBnW/Bn7K
         zddU2DHhlNBSUesgzyK+jjI1PCEiii+dPXPJfInTOsXArVXLZ3zeDpe16VbtGG0dgs4d
         Fba/6mJq5/uk9WbDsdzfX8wxqijN1B0hJ89OHpI36VWClKD/jBWKcbZS2Bq8oS0X3VnW
         qGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633897; x=1773238697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gOqiu9rk3pfbNQbzbq46fMvxLJFiDFeJ6tCyKh6dPNk=;
        b=cWrzkk6BAuBRz9M9Zl2hXk4I5VIF/itrk/ee5lb9GMHPu/UMiiB6T6cdCzr1XJh7lQ
         tjeJeY3R3B4fMkeBHLdbsOq3NWGI/f64lr3BVGqTJWKJpEkJPSo1xrAq0I/NglXHEV/X
         fzEFIQLfTA56GxSuKS9ggk4C/bCIMU2xV9qXZwQN0aY4JviN/wc/P/dNgDhkFB14Cg1X
         HU3gVCZ22IsEKcYjxQ3N0oz/qsnw2fSz+o1FuJ2YSNIKD0XnCgb931R4vSwU7V/qDpWS
         leblJCdlraP7flC+AywnWWtiMwPVmLWAkoBUo1/oLMuzMf0k/mWDjB35IUXbJo7U1SYT
         jr0A==
X-Forwarded-Encrypted: i=1; AJvYcCXxw/Qjjpmnu8JEqPL7dki6kwcsb/2JuDXAe99uRWMEXrDsjSoFZ7TZepQ7p39Q2z4+Z++C8wat1aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmIaHFH+CiO48IqqkAQ1RL5468WCj16Aprv1/x0FR/+8OihYMK
	NuxE3b2fGdXOG/+Wt3tCLzNGL25ASEyK3yhMsWKGuPr87adm27bNYlnk
X-Gm-Gg: ATEYQzxIAAXvcdLXPosupQ96zy7VSmlGDUpfu8pMv4O47tDCFCpETuCONfkSzY0/hzJ
	slHtIMRh9UFnTkgxDrUTL9uO9rZHAv8x8vMdI7yndcF6nIH3+a5+l5P6XhcbL7mZGVHH+3cCGMn
	ZNwqm+HNajtap4UAvUmSt5Bx/i06p6c45TwXBeOey6M/GxBDNemWmIFq/yvLM49LB6mNCriyvKY
	2FStBLPFFLCGv7XGcG6vCNQzurrxBX0GRAOYD8kCjbenjF6yM2AQuqTVk1x6AccPAsUM9goUyIf
	B850F+f2EGOz1AI6TsOY30CjJuJ0RcKFv4b7Y23zt7ASDmpOo9S8SsOfu5PpxNLFDglLVTyLy5F
	sA+5W30pzfS96hTzFAgkLCe4BwgIeyaJi87F6x6oG51vUEqhHvezJoGfku7ZhfM+DvtrjgalTna
	NmiYSg1rQr+IedmuwKbjq1+76S0+clrO4=
X-Received: by 2002:a17:90b:4a87:b0:352:bdcd:118a with SMTP id 98e67ed59e1d1-359a6a21675mr2061241a91.21.1772633897136;
        Wed, 04 Mar 2026 06:18:17 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:18:16 -0800 (PST)
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
	Hans Zhang <18255117159@163.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
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
Subject: [RFC v1 18/18] PCI: visconti: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:22:01 +0530
Message-ID: <20260304140329.7089-19-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pcie-visconti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
index cdeac6177143..f21cc95fe89f 100644
--- a/drivers/pci/controller/dwc/pcie-visconti.c
+++ b/drivers/pci/controller/dwc/pcie-visconti.c
@@ -324,6 +324,7 @@ static struct platform_driver visconti_pcie_driver = {
 		.name = "visconti-pcie",
 		.of_match_table = visconti_pcie_match,
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 builtin_platform_driver(visconti_pcie_driver);
-- 
2.50.1

