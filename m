Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C5B3A257F
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633608; cv=none; b=MHNExDsT6fC1EPITtZA++XjuAdAA+dD7eVeglwngYFWRpPepOHbwnC38Hu7c9YgIZbbsanXZhWbKWqgxM54Eb9tNGR83FPkErxGsEAYrmreYr732Dz5dDoP7VaS50MIoJaW+8JWIpagsKJDilwyh4EQaa3VrfrStkoE4Y6vxvkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633608; c=relaxed/simple;
	bh=hQjxT6/mWIpy+sa8NLac0lsuvVehqMlGMOKEzaLhgSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PP/TXvJyIawsvVaVZzW2iBIpVvisaysKND23jEte/vz5hoPG31RIGQ7mtNAZEnwMSd1/lgKO2s1nXpCAfEdfePLIXTqcoOpqYS6Mbu5rHU1HKSY5EDvWdh4R//C9V/2/gcQ+9zannFKDm0ZMJslM4yWOeIZxnbaUchOn3HCUkyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWMeVW81; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWMeVW81"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3598cab697eso2002425a91.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 06:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633607; x=1773238407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDFd5knNMvGZs41+mG0JwsLcBevtPF3DeTcjycQtFwY=;
        b=bWMeVW813iBYyWQUDrTidRXEo0VfwXLT7opiGAiGea9c48cT5a6WCwYwudlWWMPigt
         0PpZy574M1S64crl3NGETg2ke5yUA2s2HatW2B274oJn/w3GZ47CVF4O3wjPysyc4c0B
         Z0hUgppcVdENN+Uqf+jW+jRNjptJs0A1vOvJiOoAUt4SS9hRXhyDORF+3U8Fg8+4AJdQ
         cb9ZvfLpRgEE5NtC2D5jVJckfzgj+t+gC6lk0q+T1/zCEmoW3iAnIzheb3FBTfDx/rT/
         JTjw36zF9N9RTgARlbSqcAwOSmvsjtJalMjCq9CSI1WEzf4oC1JCTpSPrWmnOIGfMuq0
         C56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633607; x=1773238407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zDFd5knNMvGZs41+mG0JwsLcBevtPF3DeTcjycQtFwY=;
        b=MRQz5/q4xxUWZZoMLKCuyjAHuTZ+5R5W9yFYpD7iqhQjGFhw7DQKSLJiRvfSojMO9C
         IaPVA6g3G4EQ9SVAqwKnGnE/TnjbdCktwEZ9jEo3bR78TjvcLlQCwZ/pVQoK7osimEcY
         /ZeFjDIDSlECrli2KtoK9Jz3fWiNohsbmkojmDXrC5DfUbqkmxBayamzMSgF70oe8QBP
         ZpEBBk4qaxDOmqj5fRpWXzdcv1LiYsklPOuX6aG5M4Lt55nBHq+xkeU+YbSYyg9Issc9
         XgeMXynefYCRFZqOuePPDDugP79QULKWQOlMuKUjUK5TyqXYXZDmTRGsmcmFBHnle9m0
         1Blg==
X-Forwarded-Encrypted: i=1; AJvYcCUXPWxxIW/NYQLxfuMtlg0JJCw+XcZIM1XQLHNxWSTJoDDf2k9k1gpTxiO1AvpcNqm84JDrAMh7pL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCCes8xExNQXvagoXyclnjNArGtdpvNQddZ1Fjz1YHmOfEosQi
	y+jkbsXt+kAlplFOppY0XSaAjBiloGRatzSX/ffCwF9FV9sN0UrpxdFr
X-Gm-Gg: ATEYQzx4jQLHgdTevZLQwfqMgjPXujMPxQA6FTzOI644o6E5koQnwKQQpE1mRsirEaf
	qIFRPKRooZ0JkNQ788JQMj/hYmzCPfale7RY43bRs0yiTfhAhtoncNKV/nCPLS+oRbFmnJ688IY
	M5uC5dyAqNf2DzwnCAIXPoNe8u2t0xt4wfedfO/ArT7ayYAGb39LGc8zz0u98MYJ+crrs7povSA
	HWKdTybT0vyjy068ou+kf6DXMQXWfHKSc9jC5MmbXzE1UkOaOuMc4j4PZLeIDtjCnq/FPLCplo4
	9wPKVMVrCGzCvXSvAItY+NEKGI6vGKV5ARN7PEAKdnJ5107h+egwBSLM0lixWXupdLcLR51M/ns
	kF3zgwPRfLx60zBXZwkUflUArxk/LDsYNI+cLJfqVJLnTxgWiaq+0un1U3SsggxfJWQWiITgPR2
	V71i3R5mjhrzBGeiH3nYum
X-Received: by 2002:a17:90b:5286:b0:359:83a3:584d with SMTP id 98e67ed59e1d1-3599ce32dabmr5222786a91.6.1772633607253;
        Wed, 04 Mar 2026 06:13:27 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:13:26 -0800 (PST)
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
	Thomas Gleixner <tglx@kernel.org>,
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
Subject: [RFC v1 12/18] PCI: kirin: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:55 +0530
Message-ID: <20260304140329.7089-13-linux.amoon@gmail.com>
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

Establishing a PCIe link can take a while; allow asynchronous probing so
that link establishment can happen in the background while other devices
are being probed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 91559c8b1866..bc905056a9d7 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -757,6 +757,7 @@ static struct platform_driver kirin_pcie_driver = {
 		.name			= "kirin-pcie",
 		.of_match_table		= kirin_pcie_match,
 		.suppress_bind_attrs	= true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 module_platform_driver(kirin_pcie_driver);
-- 
2.50.1

