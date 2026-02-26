Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3108313E10
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092013; cv=none; b=eV3epNLimwgHoFe1/kg0IIfgm8p8yP4xRh3kExHajjuup6jWA5b6SNGN8X63y9VDAj5QM+w9tRem0CzOpdXrqMSwZVi/yGe12ZixQ7hFuUq7QauR8jP7mBC5JJTX1g3pDgKBS12Kcyk1Dk7hi7Pjpbqu9XpGSKPqOvqnol1AQlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092013; c=relaxed/simple;
	bh=7acBJpIlCewr4HGYFrItM5eWQsNaPnshCZNy/zSIIus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cfMsZmaDkuz9VaQJosKhwDRICdhgEKQO/7RZXYVtBJSFJ6xQWn1/uKrHV3+4b2jmKD2NrA3iM4jY3ocGJQ4qvhEJxzOGMr66hHNhp+OL3RUqFlsjp/WjchRWX/H6ithR8FM9dp+7bIpu47sj+1JcaMrDrw5hWjJfOLhjJ/5TFCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RbepcBgX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RbepcBgX"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aad1bb5058so5372815ad.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772092011; x=1772696811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gf3zJTvQLfTgX30VArKzadpRhj3Re5JYD2zOB+P9LVY=;
        b=RbepcBgX+KxLQAuzfo7JfN6Aeth5J3opXIVyrL5Q2AOTuBwPkjTJbHmJyyih+8/ou0
         tP3+dl3bUsEbY21VquJ74eqJ1ljb9lB4dAJLe4J9Uz9etd1HgDZUIrl4810EkuilBC8w
         T1nz/pXyF+W3EuPDK70dfflx6bsiqDYRnjPUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772092011; x=1772696811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gf3zJTvQLfTgX30VArKzadpRhj3Re5JYD2zOB+P9LVY=;
        b=InBQNAgIKPypflf+5Kw5Xu2PdjEGDDMaC2kHMeCO9yfFlVkXyMHLLqJxYbj/x+XFLZ
         kXF3YNr/D5jMA2Trj7c2rzTioFybud0PdI1DVWIgztBm+w70a2/KgXK0BUJeN+gxW/4r
         6lmfRTd4/fsVMqQrAb+EF2zB1bWcxpc+fcHbSu6si1JTQ9CpJa7WozsCqPyxlzNWDe4P
         q2Rbm5NS16wde9Zn/xMBSHgOMeoyCBSQsm+NoPSuS8oRrTOtsYSFw5rL+O4Bm/Gc++lm
         q94yjtCHmQuIQjCFRmCo0KSe0DyFbuQzRF5rEKBWoEmAtv58T45aXlWpqegNdOQPZ+Pj
         yjgg==
X-Forwarded-Encrypted: i=1; AJvYcCVG9wBeUczSo3e7vlUgPOMjK2gaqjGxQ8atwhpGcNYnQrdhHyrnobCRqWI/QimvbikL5v8Xot6RQdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW9h/KH2hMbi7iFooRPUrsy036X50Cjg4VeHpu5uyYm40qtGZP
	n9YOQyYGLRQyQ35dsji9txdKNEanXYSjYiw7XkAYVVtLbY+kaRS9muZPOrwKhqEnhQ==
X-Gm-Gg: ATEYQzw2e7iXCAZoCenyG2zYzw2ZCguhhf18yMG5sn96yfT/aHsa1KiJtk+Mi4FLQ0E
	HB6OL1aa+ft6GSSH/2yUxyE4mYcLQAr0SZASww3SoAo6qLJ+8cqMownX7bAJN56eMP9ZURlBxzd
	SHFZNmd8fhpWS3m1g7x8Ceh3xUCwDmVPI/LTCk3Psx4IlgV5IryBYkc2qhpmgMVnM2dewkXrmli
	o1b1Dd8LV0kdGc4PN70LLM/ST2ZPulLIybS/494zsbBuAYC7bTjBx5GgJjUIzAczSqzgyV7nJ1U
	zA28tS3aENt8J/k0MUG0I3qbb1ZS0YEBGo64GXo5iMKC4M24v04WGLDwrR76Qljm8gD9Wx484K5
	MccbWISYSXDBPLzMvDOjpwCtC2f6IXX8iCK2i6Pf9WyNVTNWqBOWWhH96Z9XNYQFH2RF2q4nEJF
	4mm5eOii0/SiO3XE482iZoRFXMdAp7o7jMslsvIiYnsQYFlOTI+K9UYh0JUOyRIKD4JNbchx87I
	cGqXKwf
X-Received: by 2002:a17:903:90c:b0:2a7:3db0:6e1d with SMTP id d9443c01a7336-2ae022af72amr16230495ad.9.1772092011369;
        Wed, 25 Feb 2026 23:46:51 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bf01:7f64:477a:2f97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b22f3sm15238245ad.12.2026.02.25.23.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:46:50 -0800 (PST)
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
Subject: [PATCH v2 0/7] PCI: mediatek-gen3: add power control support
Date: Thu, 26 Feb 2026 15:45:16 +0800
Message-ID: <20260226074524.3808081-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This is v2 of my MediaTek PCIe gen3 controller driver power control
support series.

The only change is the commit message for patch 3 was rewritten.
Jianjun Wang was dropped from the recipients as the email was
bouncing.

This series adds power control support to the MediaTek PCIe gen3
controller driver. This allows proper modeling of WiFi and NVMe
adapters in the device tree and control over their power supplies.

Patch 1 through 4 are cleanups and minor improvements to the driver.

Patch 5 adds power control support using the new pwrctrl API to the
PCIe controller driver.

Patch 6 adds the WiFi and BT power supplies for the MT8195 Cherry design.
This is actually a M.2 E-key slot, but support for that is still WIP [1].
And even with it merged, support for the USB side still needs to be
figured out.

We can either merge this as is for now, and do another conversion later,
or just keep this one out. However this is still an improvement over
the current device tree, in which the power for the slot is always on
using a pinctrl setting.

Patch 7 adds the M.2 M-key NVMe slot found on MT8195 Dojo Chromebooks.
This change actually makes use of the M.2 pwrseq driver.


Please have a look.


Thanks
ChenYu

[1] https://lore.kernel.org/linux-pci/20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com/

Chen-Yu Tsai (7):
  PCI: mediatek-gen3: Clean up mtk_pcie_parse_port() with
    dev_err_probe()
  PCI: mediatek-gen3: Add error path for probe and resume driver
    callbacks
  PCI: mediatek-gen3: Split out device power helpers
  PCI: mediatek-gen3: Disable device if further setup fails
  PCI: mediatek-gen3: Integrate new pwrctrl API
  arm64: dts: mediatek: mt8195-cherry: add WiFi PCIe and BT USB power
    supplies
  arm64: dts: mediatek: mt8195-cherry-dojo: Describe M.2 M-key NVMe slot

 .../dts/mediatek/mt8195-cherry-dojo-r1.dts    |  38 ++++
 .../boot/dts/mediatek/mt8195-cherry.dtsi      |  47 +++--
 drivers/pci/controller/pcie-mediatek-gen3.c   | 185 +++++++++++-------
 3 files changed, 183 insertions(+), 87 deletions(-)

-- 
2.53.0.414.gf7e9f6c205-goog

