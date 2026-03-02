Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A931E1024
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 05:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429479; cv=none; b=hheTW4ib/2Z4OpdOyt3eesaOceok8g3Fcj1RRKjHhs5XIFHRhH2RhnWNxLU3SmlN/O/XDI8YRDlfFWESHM86S6jmVZz3nTgCW8/hhizVVw4PT3ADjsCV28IURXcbhxCLbk30FngLa/pxDNUo2Pn4TbtsTXppjNHOvYpIBvLI+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429479; c=relaxed/simple;
	bh=IQFbfVgWTGD5Wi0tj0F/3p6qYDIAy+yUVgj+XF/oJlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kiSg0aQwdQ3vJPfiqxXjNxBW7b6DR/yhVNi6XaqLOBgmY7Xh2owU0pqqKgTvC/FAsHrI/c0Xjhj1vhk3CH0eRcTIT+Dfdj8bd1B6/WU7vD5qrSXujjZz+ZnK9gZJeKnbamKwNrDKY1wDncvsqTogrbkP6YKXRrdLuc8QRGqd1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DUGV9k6V; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DUGV9k6V"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae50a33ff8so3385205ad.3
        for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 21:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772429477; x=1773034277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KLxzGjkTXzvdIiBMe+u6W4iA0Yjyp+xEhOYadMTR7kw=;
        b=DUGV9k6VmtT71glzdE0QC1+PK+hoI7nY/z+wCYYKP3CaEeTun5U9ClK2+aXXXdlSin
         GUAnej4sCaEJkNJghRXzTyJTyUIr8z4wgzDqdxXxgWIJLkjDu1fwE0M10U3xkUKSejM3
         dbjKh87R7xCU/DnyDfRVB7nR3pwe7hKqKBqY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772429477; x=1773034277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLxzGjkTXzvdIiBMe+u6W4iA0Yjyp+xEhOYadMTR7kw=;
        b=UKz96QT41BZQRxuufvOVKgrRI99YFSGVzTxUSdwuEBg1RVoLgqod//sdfP+NVYhqc/
         UNrBlolmmTxa5L9j7pmQ84FTf8LocX6U7amflJ66CHS490xlchboBjIU0gWv9DLQvpMN
         YgU5nPnhEUI0mEdIvRdRpN0jjlO9cb/pHyhK0a/tzpt2Y3v2g+IUPdltmaoVFdrFh2QF
         C4p/Olr3pryGp9Wn/OqId9huSN5Gbz0SpE4GU2y5U2PQigZy0F+DOqEij/PoGWhL/HUZ
         BOrY5k7T+f6Uc5qUsstENGbsc045sMyzkYt4LNE8vbYI4QT9uk/Y1E7v4QgS3Jo875RV
         s38g==
X-Forwarded-Encrypted: i=1; AJvYcCWj3lqA5NmTouddbY64nhmtStpLm4ey05DqbSrHdihsCx4iDENwLh5uZwt5vWUdHXOtIYM4L6xMVag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn/ikTkna/Uz+5F8RYI4ywVVxpPn5BUSf1wDRqYL5/fGJSxFVT
	IhG2vazWldb778abjYGbNfyIrVEG3VEX51YXJNrdtyX3lC8+ZMborgwULcKo4yUgwA==
X-Gm-Gg: ATEYQzyrIdqOykk68vhurl5L1UbsoouGx41CyRzk0opwLt5KTavCoawSqUo8TtaLeSW
	a5KOdsz0HQBALK4T247wKqHEJN8p99f6QWQao5yH1UnNJh5aJdv86odWhprTX8ROgAyJyzFxT9S
	kCKT7dr7WOoAc0bNJ1BQgKM9r4KmSgJTQM1vQ1TB1HRZHYQQhe4kHiX9nRvZLsdgBQPYM9P022j
	Y3RpWWnaQGKSu0rr6XbmvBeISwLzTicETCTnBrMMYKn1oVpTUcaKG6RcDLifYEMGqf/oDf2klRk
	lhtTURetTz3UbEchFdzeR73+F2VK1EemmBws2Cfn1fncCPhKKwRwijXf518yy8bnQIDkb+Sa5Py
	WYwNcHFcXbeqNZImCB/6Z15jwX1wXTymWCTCJio72e+U7Lh4uUsbD2P6VFd+vDqbbnFCAyLlMLX
	/WZG2b4jtZUDcRxB4kiIHxgzXnixDoLfv3X4t5tOtTRr9N/ribbHWigJ6qIV6eMkxB0yz7waeAf
	wN4JYX6
X-Received: by 2002:a17:903:1250:b0:2a7:cb46:706e with SMTP id d9443c01a7336-2ae2e47e0b7mr107177645ad.35.1772429477411;
        Sun, 01 Mar 2026 21:31:17 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b9b7:93f7:8c3c:59d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5229cda1sm15196435ad.23.2026.03.01.21.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:31:16 -0800 (PST)
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
Subject: [PATCH v3 0/7] PCI: mediatek-gen3: add power control support
Date: Mon,  2 Mar 2026 13:31:00 +0800
Message-ID: <20260302053109.1117091-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This is v3 of my MediaTek PCIe gen3 controller driver power control
support series.

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
 drivers/pci/controller/Kconfig                |   1 +
 drivers/pci/controller/pcie-mediatek-gen3.c   | 185 +++++++++++-------
 4 files changed, 184 insertions(+), 87 deletions(-)

-- 
2.53.0.473.g4a7958ca14-goog

