Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6540375F6D
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215562; cv=none; b=RfXrbt3XqM91QkAtNHOVN+3HnJiAE3Oxuvv3YNTn+crkcxEVvdV1A1CBvh/XyaaPxDnDWSGt6BKRf/aK0ssK922HjRAKdUCoZYY3it+lqr2cXFKQAYoWmAKimoy8LdX/vJ5ireTepk4sj543z0jDddPAqtdfd+9dJFN89jrGKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215562; c=relaxed/simple;
	bh=wQAZw1dF17XA5p7s/0pwW+mHw5YmSvK43yi7NnuM6j0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M3uOwCK4pRoO0a2PN4Ym8N+tumM12ehbVBP//ChKzXXt+3yY6bN8do2cs/p/folfXC1anFszJvKTkYbcImaDIiK/NYlKdcLo7cH45izLSJH+qe+o8bh9KoETAgvCelzYZS23xhDveMT7IWA85yzzDwJ070RB81zffc21eXvqs7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KwHl/n93; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KwHl/n93"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so253590a91.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 00:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773215558; x=1773820358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CAbJYo/U6V0Uh0aXX9z/yqJ0AbZ9jHrEzuo7YucNVOg=;
        b=KwHl/n93JL3/VuiZJS1orcGTs7QUFFTTchJUAcvpHwGyAc9vDDYmoAimPCplIyfx9W
         KU5yGxygFIZkin5g/pTbI+4bMQ8aO1XJvBSpEcvsuCUmPtjljh/SZTJNqQ1K5UtoO93E
         vQGXXyeAEsXKiehrY+Zh/0kv1raG1rJNm0zGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215558; x=1773820358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAbJYo/U6V0Uh0aXX9z/yqJ0AbZ9jHrEzuo7YucNVOg=;
        b=m00knr47r3rDyNOKgin8zzGGux5aCsYXR/EgpIfJeOOzElaoJbKlovcawFi8lLcdSh
         wPnwiJMx11AA+S6lnEBEhrJ+GcMjJ8uRDnz5EBUc+xUsgVYF9i/llMr5ComIkzuOak7K
         hlomws0yu80LI2LiWI+2S5e9HrH5mvWn2QMpOyY9YIMhtnMrZMRKCHzSyO9U7vy7wOXf
         iTRAsDMeJZ4F3J36zopyT2mONC3sWhF5VOPc2cDMb3MvI2kyaJLuO7orW6Vvt+UimW7n
         col9Wfm9Txq1ujSFYW+un5kNketGOc+0ZrW26ZZ7M2Z/i7ovERwaNKKDUH6oJ0dkIFrT
         oOhw==
X-Forwarded-Encrypted: i=1; AJvYcCVf4TtGdx1hD93mVpKy7TLshjNLtAlBghjV6ADntNjZxOhzUV45oGtUM3iEcS5XFSBuWKmIinDU9cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIDiWAKBsjIZqyGKCdzRauo9U4AOxVut6gVSe2BdD/UcaWwUPf
	45AIssKgwj4ggpQetQ+KQvCqE48dnSyCgmGmmQ98NSG59dwo0Q/6O/0P55qA7TkgpA==
X-Gm-Gg: ATEYQzyeN9vzkcrA4buTv1ry2gKQr619RzddhtmaRbX2zKyunDSQaKy38NQlMtaNvs7
	qrq257AolcAuvwPsFG8cFizCnQ6YYpDey0a1oTWPwFU28t64kRPOZjdSLCOB1e+O41OGYstP7p8
	m7yFaE774Lt01Nu/+yiGbq3ZcULu8W6eIiM0TR3bU4sSugCLDLt5OR3wddeZvvP1SrnL5tX5dHs
	o8qX0AnkURHrcfKw1D//5RWg2ThaP/BqMl9kdxyOgTpF+xoLRkyqvE4/3Bdzue5TBRN7sxFzgC1
	h4eJ4wu8pjKgwshcK8sUhKR6HheZs7M+mUQ9K/Fs7v/MP3h6IkQPn/QbzXGNPkElhTZvz2KlTYZ
	Fb7kRNTiSuz/ntiAGwt8F73YrWd2naXVxlRm4GiH1TCqQt94s2R5SoHEzm8B+sce6NCGWZKSpFW
	aG6ciKYHJnrgWS0FQuCxUk4LBoQCXhuC2CjUg2QX1Nq/ee8L2OSsT3K9COvB6ktnoo/+8ZmZe/m
	+Y0Pt4I
X-Received: by 2002:a17:90b:3911:b0:359:8a78:5696 with SMTP id 98e67ed59e1d1-35a02690dd5mr1357506a91.1.1773215558073;
        Wed, 11 Mar 2026 00:52:38 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:805b:14e9:f783:bcae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a0236f79asm727816a91.6.2026.03.11.00.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:52:37 -0700 (PDT)
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
Subject: [PATCH v5 0/7] PCI: mediatek-gen3: add power control support
Date: Wed, 11 Mar 2026 15:52:15 +0800
Message-ID: <20260311075223.3303497-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This is v5 of my MediaTek PCIe gen3 controller driver power control
support series.

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



Please have a look.


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
2.53.0.473.g4a7958ca14-goog

