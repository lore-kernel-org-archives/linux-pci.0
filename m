Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2BE43D4E3
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134398; cv=none; b=HuP2zaG5I+qzd4q5ZlFYf9kAvVRIswv9LpMt8dJsPFdCmWgfhoDOxCgLQu+TWlzrl6SbsxPp7jC0hPOXjhYakc4c+2y+3EsdlBFcVlrVB93BydNwncO6v2zO/TpQvfgZX4hkH3jN55aMflQIyPYsz/PalHSdHYkqpEDLrrEGsf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134398; c=relaxed/simple;
	bh=YwlTP1q33Pyze/mJl6vjVbJZKcjmMWoHqKH/paHVgmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNAnwuN310KCC3HcyIWw7Nh89Pm/oNht0YCsZiOtEE0HjYKKTL4UgnrV7DDlKb/QscAuOKhtJ+w8K8686i2FMa4emsH8f5ficWDKd25+MEq54CmdKIQQiGZ/sng7SISJvuBQ+rGZPmX1zB1l5XzaHP6V3Ggt7FDRURreCqMMS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FW0wCHLb; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FW0wCHLb"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-823c56765fdso6285660b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 02:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773134396; x=1773739196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qlvmKtnFIYNHHzbN7pOX0A8KbD9wMlYmNdVVBmFdBJc=;
        b=FW0wCHLba+pkqqphc/WICt9D8sMaeuOcrsCEwNOmVfbhwPEJFGLn5z+LKQmakrOzI1
         xfy9jRzqS27B7U5r0ZYpCiZJFzsyzYbmPD2qi4A2mrWYak3UmMA3HQh/hToSkgs0D5q6
         h7Pk+QsSCR1URLqZcVFkpfvn53RNRLF1bY2p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134396; x=1773739196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlvmKtnFIYNHHzbN7pOX0A8KbD9wMlYmNdVVBmFdBJc=;
        b=pQ+CHOJiS53Fw+ymHJwoQsfsme6lsEa/q4+Hamu9nvsGLWbwYdQaiyu3uy8/P+VVcO
         +sIVQzWbAG9Gn5znB3dUzIeLqjQQyhsWFoh36JAOjBf7kyRDsJr7u0wxFXj+GEEQVZVL
         tQ1ttj0/4HqT7pSPnqM/wYC2BRP3ZhvTvIfFHod4SYI+bPfe7bAwLttk0LNDMN9iHxTZ
         +FTnvRfN/nDUTHjI1SbMh3An+tdecH/SYdwY3UPDI0cxJvGwUSXmhqreUNWGMyHQWeWM
         AhlFNUFKuK4VK9PImZyomxdxhrPbshz9vTI2pEblkm+735mQQltAgnqvtbOroyETAegZ
         MmUA==
X-Forwarded-Encrypted: i=1; AJvYcCVWlSWdpLN3bzxC0ZZBR0dT+5uVegH+BPfhKln3uOd+nClDs6sMAvktRI8/Lvny3iVHfRaEE2CbTTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvQBoAwRt2aWFfsMxhNFytScc5UpB8Dwg5GuwQSe4GB7I6NMLZ
	76f70dHamzoXKc+3BLZ5WSsKlcBYoBHwrPqiAY7TdjlGrBIoaAr6AMl8pwo9W9yD7A==
X-Gm-Gg: ATEYQzwZ95EIQJqP3Rm/+GFtCnMVMLfpu248paQ+ZmK7Mn5SfngV2jfe+jrFyRkinzO
	JFUrzk5bRur1Xwos4TxjHz80SBzqXcN3MIPe1bfiaN7Cv7Gvt33mdBZx+4G6mh9ZBi6UfUfpCG6
	070BaoOQTrwX7+6AyAu7Lsa2QZe+caFLLC7a7+UNXxpVXWtroGqbfGeYYCKetFBEhaqKY+DmYzz
	Nml1j85FYeY+ZeujejJUqRFliA1y3w7xJ05zuqb6a584VolaZumYr+CHwb1/9DiIjXmeL1V2Cq9
	zWnMHH+HK77RXzqkVoDPTLWmXjI/lAORi2iP1h4APlVKImWMMLaL7gm0INqnuUb+ADw/iDshwP4
	LGJ5KtDRfy7mXefD0A6dYCES/LRGIjOemhhn5WTVmLpbFP5b7NCc797Xjo99rYpXR92174Q8nC6
	QhfEaSUsRsZbMNoa/0aBdiFEU5wawaLLOYk26k14Qp1I/L/t4qzvaC+oncNW2NMK6G4hJHruYjc
	iFqTWhF/1xltflOJhk=
X-Received: by 2002:a05:6a00:3d13:b0:829:73f4:6ff with SMTP id d2e1a72fcca58-829a2f428ddmr13331441b3a.37.1773134395959;
        Tue, 10 Mar 2026 02:19:55 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:ee38:e01e:e888:6900])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48a3b74sm16965190b3a.45.2026.03.10.02.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:19:55 -0700 (PDT)
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
Subject: [PATCH v4 0/7] PCI: mediatek-gen3: add power control support
Date: Tue, 10 Mar 2026 17:19:39 +0800
Message-ID: <20260310091947.2742004-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This is v4 of my MediaTek PCIe gen3 controller driver power control
support series.

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

