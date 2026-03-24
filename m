Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF60242D60
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 05:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774329614; cv=none; b=uVgArfqi49HowkLYKDbxABxsl1o8YqlpGRrgiwS9ygLlT2NNNaJWqTCTIfnrUc0OcyWVX2XwN+/uCOuSj27lmWDO/uT6IgllAJH+FkM1/d0NCFW5TROj0evgfMdVfKkqu2A4yvhdGhV0RaPnuC3zJToqI8E37UPyN7/5BB/d+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774329614; c=relaxed/simple;
	bh=O6yLcDDgy7auMeY2lhCjSZbJORE8ur/r7LyyZqeID+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hKb3Z8vkcGhfuso76xYy/eQnM7YmnnJAIKZOJLWpAN9efRotgXBkHgZQ04/GsUqvnSHA2ILKbk6EXkOOx6zoRd8p9TGoGlwECUPCrgizpbO3N9EJDmcWk6v63s0+iJF/c3dnZQEQawEKWW85kjkig74TxW8zbgm4rZGqI12gtQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ne2SXipG; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ne2SXipG"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a1f3f07ebso1704989a91.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 22:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774329611; x=1774934411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HD8JQDMMlIkIx7EMUgVU1ftXT6MPWyC1lmhtj8DtsUY=;
        b=ne2SXipGh/MB1iDLWNAFb5rBNqwJLasMSgq2n0kq+PwBkq0+nsLSGcMgY8t8URqrtI
         bwRoM/nVSpC88/xPecxtKf+r541Hc9ITYZdmksmNRfyQaX1iWNUZNuidcWG7JTjPci3n
         jFPDvOgcZYczNqDW8UdY4xpifWKcoedmMCvgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774329611; x=1774934411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HD8JQDMMlIkIx7EMUgVU1ftXT6MPWyC1lmhtj8DtsUY=;
        b=n+Z46vOFJSXffGdGVSe0TdKRwO7mOgQ7FhKbwu3SHrceZSbo/a/VkRIUlhoQZqVuV7
         vTPTggCv8ZdnRXbswiFW2SW+SfvvlqKWMcZKZU2X3Z7mZ9kraEpD4M6J9sRORwTAJJlA
         sLYjOkCNMir8bhEPzV4eweFfZlaewvt8yKM+Cuv2rziIOu2X5N4EuhBz5HbPulLErcZf
         JiwUtP7OW5RXE22FaU+l3/st/DOZJWrxSoFYcMNrWfgATYL5Bpbh/hqy3EyhlF7NnB/4
         03nUiY2w7/NysheFu4ki3vTVNEcVSvAnvUmfYgwiC9xDUFFc7GyOzBdiyRO7IbiPkcHw
         zFoA==
X-Forwarded-Encrypted: i=1; AJvYcCUIEdjMQocgi7iFOOs5OrKepbB75V0yMJVddTRUra6P+hWWy/nFtMMX4h/YouQIAN030AiNA8WNDdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXCuVc8n0Xe6uZnhPgTYwYqbFabkQCdMGCTZl6AGFm+tG92qv
	ejXkNApclay+uH+x7KYiYoS3vADiELO59nDAb1TI13pVwmznkZTQIEWF0hbBMiVJ3g==
X-Gm-Gg: ATEYQzziPAZ8DEDUkcvTfLPyrHNzokX4t/gIEaf8itqr683r3dnXf6tJMADyjbsHa9x
	mAHX+c3AF1OYKa097Bq2SKIMJ3m72DNDq6hy3JNCBurS5OwzhMEo1M3hwD5wDI5Sq5wx49UdD1C
	LTnPJC1duCf/zWAZfupPpsdZB/hkdlg2PQk2ge8TNAtIAqep+RRhxYIsDTynnCCDMYw8qeqjq4V
	l3kaR3VCQb8+Ihm/M2DXwBMC1ntk3SBH/vIPOpdluz9alQOAOHrQu4On81KBRiynqnVE4+bdLNQ
	M+H6+pYgoDAV3W4Vm4iFJxAb4HuCy2dS5EqGwL4MMYGhzWYv1WeYqKl4Pg1SSVEWwqh2JHD2xQz
	PTpfP7JVANBRUoHDxg/IpC4Hk82KAy3TJwETrofLlIt2C89+yM1n78TxboNipSAONo9PAWaxT0A
	tUurspewCaW7g837/Cm1VQXeuCa/lS63xBJzoHohdIbyOLW9COG0GrXyffBxEHGiU4w2KDbTWoT
	UspDO/N
X-Received: by 2002:a17:90b:4acb:b0:35b:8d89:7198 with SMTP id 98e67ed59e1d1-35bd2be6debmr14451421a91.11.1774329611552;
        Mon, 23 Mar 2026 22:20:11 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:19a5:8f2f:d584:8078])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03124a87sm1068647a91.3.2026.03.23.22.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 22:20:11 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/7] PCI: mediatek-gen3: add power control support
Date: Tue, 24 Mar 2026 13:19:52 +0800
Message-ID: <20260324052002.4072430-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This is v6 of my MediaTek PCIe gen3 controller driver power control
support series. This series is based on next-20260323, with the
commit a2b2ca0c2477 ("Merge branch 'pci/controller/mediatek-gen3'")
reverted to drop the older version.

This series is ready to be merged. Please drop the older version and use
this one instead.

Changes since v5:
- Link to v5: https://lore.kernel.org/all/20260311075223.3303497-1-wenst@chromium.org/
- Adapt to PCI_PWRCTRL_SLOT -> PCI_PWRCTRL_GENERIC Kconfig symbol name change

Changes since v4:
- Link to v4: https://lore.kernel.org/all/20260310091947.2742004-1-wenst@chromium.org/
- Patch 1
  - Expanded tabs in commit message
- Patch 5
  - s/mtk_pcie_device_power_(up|down)/mtk_pcie_devices_power_(up|down)/
- Patch 6
  - Adapted to mtk_pcie_devices_power_down() name change
- Patch 7
  - Fixed label typo causing build break
  - Replaced "exploded" with "populated" in commit message, and added
    more explanation about what "populated onto the mainboard" means.

Changes since v3:
- Link to v3: https://lore.kernel.org/all/20260302053109.1117091-1-wenst@chromium.org/
- Added two patches to move kernel setup code before controller setup
  code, and controller setup code before device setup code, as requested
  by Bjorn
- Dropped dts patches as they are already merged

I kept all the existing reviewed-by tags, since the changes to the
existing patches aren't that big.

Changes since v2:
- Link to v2: https://lore.kernel.org/all/20260226092234.3859740-1-wenst@chromium.org/
- Made PCIE_MEDIATEK_GEN3 select PCI_PWRCTRL_SLOT, following existing
  examples

I do wonder why the existing ones don't select PCI_PWRCTRL instead.
As there are multiple providers, and now even the M.2 power sequencing
driver, I think either we enable the common ones by default, or let
the user pick and choose.

Changes since v1:
- Link to v1: https://lore.kernel.org/all/20260224071258.2654521-1-wenst@chromium.org/
- commit message for patch 3 was rewritten
Jianjun Wang was dropped from the recipients as the email was
bouncing.

This series adds power control support to the MediaTek PCIe gen3
controller driver. This allows proper modeling of WiFi and NVMe
adapters in the device tree and control over their power supplies.

Patch 1 through 6 are cleanups and minor improvements to the driver.

Patch 7 adds power control support using the new pwrctrl API to the
PCIe controller driver.


Thanks
ChenYu

[1] https://lore.kernel.org/linux-pci/20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com/

Chen-Yu Tsai (7):
  PCI: mediatek-gen3: Clean up mtk_pcie_parse_port() with
    dev_err_probe()
  PCI: mediatek-gen3: Move mtk_pcie_setup_irq() out of mtk_pcie_setup()
  PCI: mediatek-gen3: Move controller setup steps before PERST# control
  PCI: mediatek-gen3: Add error path for resume driver callbacks
  PCI: mediatek-gen3: Split out device power helpers
  PCI: mediatek-gen3: Disable device if further setup fails
  PCI: mediatek-gen3: Integrate new pwrctrl API

 drivers/pci/controller/Kconfig              |   1 +
 drivers/pci/controller/pcie-mediatek-gen3.c | 223 +++++++++++---------
 2 files changed, 129 insertions(+), 95 deletions(-)

-- 
2.53.0.983.g0bb29b3bc5-goog

