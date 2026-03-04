Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8CD3B3C09
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633708; cv=none; b=qs/TSOA2R4458wigd2zVb7kJi1lEEjCPWSuGKe1PQE8bwDxT9LtXWqZ8LY+OfORC6/dOHAxgpXhAiv25DWQXLEhZu28dftLHI3c/vRJbNk7w1jL0TpYdxZpIZhs6384e7btebjGjbCFWhSnkuMVg4ap18tWAlFC+QEhwX9bTVYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633708; c=relaxed/simple;
	bh=HOw1M4d6fLEqGRM9wuHly7wJbsT2rgQ5OGXMw/g0QY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSEmYufjZ5PEIyFDO+vDeedDlOYXtMnxy9C5IKTwF9uiAe4CDFbM4gHSOROvbZXM8U7IOm3Yni29k8T+Yls7ipFbprlr0k2aM/djIDkK5qof9kvkt3lVytk1Xt5/p6dxpDDj7C5me7Ii9qt97eh/0J4b8UBjm8XMyRYpOxvMgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9OPrAyO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9OPrAyO"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3598e60a735so1529981a91.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 06:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633705; x=1773238505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OBV1g9f6o6sz6h2YLW6cb0WqXaVph12Op+HL554xjY=;
        b=H9OPrAyOwo5RY1sZL+TlLHmCrPWRPUMFsaL5AU9D2kc8sj4Im3uSWUU0FRkYJMLuTk
         UtZZPSaHciuS2gJsK7bJqoqcbmSRS6TcnzGpF5bf+LMWrl+Vx4tnI8PnS3rDjHk2g4ng
         Cggmn5+9x/0DOwfeC6ZQr7Y7qrdM6qBjey33CJXauH1NxNZR9Cx+sH78tj1FAAwystVL
         r3jCkTfggQBWIXLv2hubCcqKjCjTthcEHR7lum447nyHGYjAp0g0zBVc/a9NW+KfQu2M
         v+lAp7x4kOVTA0Jso3y1HxcnHBPVayu4bFzdKHAKpF1iBw/LQwWj9khIkZSL1vPTLpyX
         1bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633705; x=1773238505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9OBV1g9f6o6sz6h2YLW6cb0WqXaVph12Op+HL554xjY=;
        b=TIDEHcqEuifdfRhagqRXv1EqccOUFC5sQgLhDburvyq/ro5czYkBdU1Xo+T3tf+VS5
         QZXT9WJiXGdBeJBQaZ8T/PZluXvHIff7VDPuDYe19UL9v3e2RBTBUG2VGJ/4o6alGUHs
         gGkCkceypS/qqQ12LkIi/yphzBEIk8riaMnJEOaQy0zTWqOA2xOcarEaoY5nWCop1ttT
         bimvvvT80WBQrXEAbWITBtjp2NQRc6k8y4egamIIA7KD+5K3xsaucDbVS+kvkaHbkgpc
         /xz6GooL78k/X79UCmTDy/+0FMj4IsLzNs0z/hsKHpBG5a2VyCac9Lda3fDD9MUgFUlI
         vMgA==
X-Forwarded-Encrypted: i=1; AJvYcCXbYwnP6jB/5E2Oj+2vKOKn67GfuK1oYCv2s/rxFwdWQcYQFwRKzPgSWtMBzgsVrfmmualw3rF1Zoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAsd//USZ76EQhZITze+Gk1bbqTjwGJS4W7SloEL4GhyffhnKR
	8ovmcVmgqg567e4MgX7/C7Xcm+t03VvZFgLtrlprDuwuf5GSZPqV2Cx3
X-Gm-Gg: ATEYQzzpVq1/qrqA6MeCSBzesxEHXcq0hIEAMzzGNoz2HQl2TL9MWH6bG9adUXrA+4h
	cPVL8GeJUzdj/8AcX7FJHh7JAEru+Wb23rOGRwdD80RtbEvcByOg5uRQTQtM6K30snMYYB7LtZj
	i96HiHNfhRjZRfm/8gRrnHGMX3WxFg3OyXBLkyxhZPEg4oSVbYWdXHIxZlXOAToMZ/nsVGrT5Dw
	TOBH/LakRIGHUbWfph8ECVjLu9W+PqX/siXWAvPrpi873//aFMZotr0iZp3TWMgYkZv8b7FXus+
	q0W7mEw1eDlGVOUWZwqFKjzPMCoJhRKPbf0XmRJj+pcjnn4j2PaEswwN6UXoupA58LfuFxrruU6
	B+O/atNLjjw7F5RsmWrVKPe53o1DgyGka0VqUlhINaTqErG/ShU3gl8rw8uGQXWvS3nCHdPARub
	Yd0JCfuyRivcM+ClNIEclQ
X-Received: by 2002:a17:90b:164d:b0:359:964f:491b with SMTP id 98e67ed59e1d1-359a69c8cb6mr1870621a91.9.1772633704630;
        Wed, 04 Mar 2026 06:15:04 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:15:03 -0800 (PST)
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
	Koichiro Den <den@valinux.co.jp>,
	Hans Zhang <18255117159@163.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Nagarjuna Kristam <nkristam@nvidia.com>,
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
Subject: [RFC v1 14/18] PCI: meson: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:57 +0530
Message-ID: <20260304140329.7089-15-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pci-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 0694084f612b..280146f7b783 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -467,6 +467,7 @@ static struct platform_driver meson_pcie_driver = {
 	.driver = {
 		.name = "meson-pcie",
 		.of_match_table = meson_pcie_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
-- 
2.50.1

