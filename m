Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE12FFFBE
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004171; cv=none; b=g/RtuKUnS2snKmTcGeRMUzSdfI6adrclofpyabiBSB+mqjtMSr2dVkTQcH2uf+fDXF9+CZpYC48V1aaLhkvrOijmaI0PZoZkjKDEXbKVByerQP2DSvm5yoZ3QXbDnEEXnp/LwAAyH8sw8zikOx+AuDBx2D31bJy+suWHkqyYb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004171; c=relaxed/simple;
	bh=sHRk2Hp0rmz6wExMNKvWvTKY3R8Wd/8NMckreGOzltQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1akcyQv5DrY6MUbqwW2JfZ9cXSN0jfo1KawSMr2cwfJl/EPChPIqqMY25bxmFvmkCs+uaojetRWxJ8uCPvr6emCLseVEGDbqUqONUDQdpvuRbpNLyE+I/NLLvuG6RcVesM37g0J/n3TITDC3ZM4fchijcGbGNQq0x31Ub65KPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ae73mxMS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ae73mxMS"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2adbfab4501so5130625ad.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 23:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772004169; x=1772608969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k8XpTwYaznTB7X95a9deMFZcsmj1UdrXkb3hcBiKjSk=;
        b=ae73mxMSi5L8CeUNzD2aLd/NRhtOAZX/KbcSMYIXNZ6u5BeXVzr6QlvwIpvADjwSuJ
         9bgD0MTYy/dQe0bcLODfzntuQETAANLQfbbgGzUEZkZgi5Oi7LASFJnavnWaij7bp0PD
         1Xq9vnWR6b3mQrgJZd44fq2znQ6p/XmOtfWxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004169; x=1772608969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8XpTwYaznTB7X95a9deMFZcsmj1UdrXkb3hcBiKjSk=;
        b=j8PjGMM+bSRdCSDUCdgebTMSgyddp7VAuG3H5E7/Qr2YMHcyje0FtZlLSFZpOrc66n
         LLCCgLn10apV5GVzqgSqTqaEFNKoCKqQlgDxgqYhmd2pRxobA63HzUb2gqd/FcftxRWN
         W8cDPELbHsU509QIFixWT6S+8IeXFA9AeniQU0jGmfKO5BgU3+6wHGNGct6/wkkNG8Al
         xFqVwEo7FTUDovWjuVANYWBNliJMVOnHkWwd7hPOHYsUTRqKmlBes+XEKp4vx2ZZ5wzT
         XJanOe7Vo7aALuG0X6I+THcBp1D8LfM2ALw8oqL3MI3L6r7tGGDOLFhPgzBMXFBaZ1XK
         m4lg==
X-Forwarded-Encrypted: i=1; AJvYcCUqWi8dfrpSpoYC+ibcUnX3epvphUXzOBMk9YgV4YgyQugGA7fIu6HR/UAKh82/lyGWqX9hlF5HKVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcBwShJRiudrJ88AcuHxZuCDgqj38uhWD991ZLj3AH/XBkU8J4
	HkUi+3IL/k5KUtvLnnE4LfuwPIX/LmCAOhXPNMfXycotl5RzSpAn/SXCliygCpAcaQ==
X-Gm-Gg: ATEYQzxwCd4QfmvaFWhJs0BA7kxzLEnlDmBUxkcMV4lGryG3an/DTSWQ+a7E2UGKUmy
	sfB7+1bdKmUdLGno2FDbQEhsCoyqiIfSclN+nAQUTmx8615bn7WNdBmQIGbPH0OVEQODbnpzdbj
	UKe5m+h/kbPrtobC4BL6PaKNNIx/ykGTbF7vZZH3DaZ60iSPacyTGcWdA3RS4EudCUDgBBfV3wS
	fJluJbf0dm4VaaUodGx5CdSjc/Izv7KRn6s24TJd0sLLbmqqRiofJ2K7JBKMopTvbrvrhBIGCNO
	hfmKV+2+EqxFviZwf8GyghNt8cGGIFHiPtULCyFf7eMhV3jl2ZLWHhsxdj9Ra43ChrhB81uLFhf
	4cYVwbYNjztc22gVYgVeNgtOr70zFpJwR7Hu1SpWyBKcNSEdHHflFEPD7Oum2hkyJym7zpZqQsY
	EvVn045SMUtIi/DiqO9jAf7drEviVUwgT2isA8hiCIW0TSxspBbHyeM/sw3RrSGbHfIR2i4/zLa
	nU7gA==
X-Received: by 2002:a17:902:e80b:b0:2ab:3ac6:8d01 with SMTP id d9443c01a7336-2add1382e48mr18547135ad.29.1772004168768;
        Tue, 24 Feb 2026 23:22:48 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:9d6:2e6a:941b:690])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503fdc9sm130814435ad.80.2026.02.24.23.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 23:22:48 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] PCI: mediatek-gen3: add power control support
Date: Wed, 25 Feb 2026 15:22:17 +0800
Message-ID: <20260225072225.3345307-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

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

