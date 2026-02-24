Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90EC38B7D8
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935599; cv=none; b=qFcv1gY8gk0KNL8ERG/RQFzzDpo31zQhw4VbQZHbFWouAzLuBxQP6vTYxkDKSP01rzHMv/0TnMzczi6Nx4b9wTqNElPrX/Qzc2fTqLeRsSY2EUom3tzfts0l2AlmJiaklyrmpg/tr4ekn9SQ0edX6Za8n8SZt8rrSB5dp8DZMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935599; c=relaxed/simple;
	bh=a15gvvp+Y5fZlu/XEV0GqfIuDaHqBSVDDZ/1cfRlK54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzImtdEfW6TMJ1ST4IhXCdazGIUza3pO71t1SO4EnSwo4FpJNpImk+C+ayMVGqCNiygP+T2BKL6+hmyVc2rQgyhIOUOuOIsOdESrjJn0pLZUhDER3BZzY3WCw/ne9sxd5cpI5W/SzFppYc6FXq7k/bMhQGtyW/37Oat9HEGYipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNELsXrj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNELsXrj"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-824b5f015bcso5184468b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 04:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771935597; x=1772540397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RVGEkSHpVszbSEuz8gxEX8sx0htTMLCK4ylQEIc8lKU=;
        b=FNELsXrjstFMRvTp8mDk5aEjKSoUczQGjiAwssYlllLRxIroPMDdw706CPQoM3+fRS
         fy5HS30nE0oxEb9Nbndw36s1EIfc2rpJ8jIuCYZDnUV1xTErcRZEOLGUZds50GmXG2OE
         JV3e5vRY5tC0mAXNUrkMQjWk8w4R6Qwe1vVpCewFv5Zp2eyaKq6k7DegVbnLGaLuvD9k
         ts4bYIQHDGpuxpGx/Uwo2Rt2sOezkGG5V8XNnY5RR5WJcQR7UOekNhdbRWA0wXJ/o84o
         0l0bR/W1VIqwH1wFfPxagyUgz5jUl5UflMW8kS9Uq+53Lb/Ns5s6v54MLfqplVGrJk8a
         BHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771935597; x=1772540397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVGEkSHpVszbSEuz8gxEX8sx0htTMLCK4ylQEIc8lKU=;
        b=QCF4bwc7uGqkquunNa0Ho4DimwEmx5mSiNNa3+h7y5nHbX0MXbIm2ja4RB01XYhVEV
         3xFVABt1eItzOGrGPSJPgpI0Oi6Am5uYz08350zuSgnAf2m72rcjUESPFp2rZ7L1Zt40
         tUTLb37vD8X31rubVijK6qni0EtCtWGC7vlNsxbNsbQLNEnMIG/4HfZVIrtN6K/4tP7G
         DPGj457L1vonHIlvtQefnKwLJTvzyOYrGnbzTd0rBb9IeAYb8jypUIFEgJhmoi69MloH
         pIOo0PcZchQvylHhLhHdrsUd0+hbUK2U+UVwBQxzPZxPMg1fKBe9RQbaiSgjJ9lHvQ76
         BzTg==
X-Forwarded-Encrypted: i=1; AJvYcCWB9EZ7yQEiw4JIgd+VqJHThOHCJGV8YcATze6JZejlq53ZJVUVUjy3XMcDH1D1DomCETQqFxkQTms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlaMFMwEfjRpdZ8DvTYHwVBAoliYfW6LYl7tQfEBajMbKdDKVt
	bFQ83VUMHKWiyjszrrHxXRKgparvFieEb/OQ0zaYPTO9RJL7Tk1JJRYR
X-Gm-Gg: AZuq6aLK8TyHQSMihVlgCGBTwCnQrL/R9VSKNDulQUinWk8c8XRNCoet531z1Fi0mkj
	0Atpe7HH9pdB+97q5JH4vJj9bHpkt4ZJ6bKVxtKgt2li75VCn51dT7czCZERoPjYNVp83VZbgOv
	VseNOdvzOELX0GehoHSMJa/KsN8If7mE0vo+izp4aS1W0VVa2RCo7XrncXfqVBfKK8fMl6VZ3+N
	NRS+B2lhGsa/f7oy7O7rESr1HxJCRweWO7Sz3CozgPUvQfnHc5WpKhahagQZ6EFsrwnaS7aGNX1
	eXh1aL0Ge0nNn1wjc1lc5gCMIo1RotZCARTiAbkn3iPN92mOJwebC9oonvCP7Fan640muUMZ9te
	D1H2Vnto5Gld8gm795/kCwYhiVvXMowOZ5p9g8OyGWtkYhcaeUOJL1hoKBQhtgS45EzgBPR6wnD
	nynlmUlLIbJ2hYrWP428A=
X-Received: by 2002:a05:6a00:440f:b0:824:93e4:2ddf with SMTP id d2e1a72fcca58-826da8c0f3emr9998493b3a.13.1771935597103;
        Tue, 24 Feb 2026 04:19:57 -0800 (PST)
Received: from rockpi-5b ([45.112.0.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ba11bsm10613950b3a.50.2026.02.24.04.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 04:19:55 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <webgeek1234@gmail.com>,
	linux-tegra@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v3 0/5] PCI: tegra: A couple of cleanups
Date: Tue, 24 Feb 2026 17:48:56 +0530
Message-ID: <20260224121948.25218-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This small series provides two cleanup patches for the Tegra PCIe driver.
The overall goal is to replace custom, open-coded logic with standard
kernel helper functions.

These changes improve the driver's readability and maintainability by
everaging modern, well-tested APIs for clock management and register
polling.

v3: Fix the DT binding for nvidia,tegra-pcie.yaml
    tried to address issue for Krzysztof and Jon.
    Added missing regulator and new patch to fix the device tree check.
    Added missing entry in MAINTAINERS.

v2: Fix the DT binding for nvidia,tegra-pcie.yaml
    switch back to devm_clk_bulk_get_all to get all the clocks
    improve the commit message.

v1 Added new devicetree binding nvidia,tegra-pcie.yaml file.
   Switch from devm_clk_bulk_get_all() -> devm_clk_bulk_get() api.
   Fixed checkpatch warnings.

Tested on Jetson Nano 4 GB ram.

jetson-nano:~$ lspci -tvv
-[0000:00]-+-01.0-[01]----00.0  Intel Corporation Wireless 8265 / 8275
           \-02.0-[02]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller

v2:   https://lore.kernel.org/linux-tegra/20251215141603.6749-1-linux.amoon@gmail.com/
v1:   https://lore.kernel.org/linux-tegra/20250926072905.126737-1-linux.amoon@gmail.com/
RFC : https://lore.kernel.org/linux-tegra/20250831190055.7952-2-linux.amoon@gmail.com/

Thanks
-Anand

Anand Moon (5):
  dt-bindings: PCI: Convert nvidia,tegra-pcie to DT schema
  arm64: dts: tegra: tegra186-p2771: Fix invalid PCIe nvidia,num-lanes
  PCI: tegra: Simplify clock handling by using clk_bulk*() functions
  PCI: tegra: Use readl_poll_timeout() for link status polling
  PCI: tegra: Use BIT() and GENMASK() macros for register definitions

 .../bindings/pci/nvidia,tegra-pcie.yaml       | 528 ++++++++++++++
 .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------------------
 MAINTAINERS                                   |   2 +-
 .../boot/dts/nvidia/tegra186-p2771-0000.dts   |   2 +-
 drivers/pci/controller/pci-tegra.c            | 237 +++----
 5 files changed, 621 insertions(+), 818 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.50.1

