Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51903E00B2
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091489; cv=none; b=D+bo9wzErCi+aO+XhmUQZzusPLs0xnM9oWIMs1Zo3rLQmudFxlNRqdAYMU6haE2JLe0uNtE3mxavJcbsWSYh2D5Oe1Nh02DxIaxAi+PNHKc73hHRQTbgN7E7DxTZpFgrYiddH6B4GyVpA0i2lKbUsbyg3YhGsOYZAzisVx/hBc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091489; c=relaxed/simple;
	bh=PXunouNx6flJMIUdlDcTZ0lwTbT8RlEKBbd+k+PsnHc=;
	h=From:To:Cc:Date:Message-ID:Subject:Content-Type:MIME-Version; b=cPDHMJ+w+0co2sRrtPXmZz1hqxW+6ctE2/QK4APVwyNOMRkBR3QU1SDzKAgYviY1CW8pKJ8DkI3/BuLmjgH/bXI5LCGDS9s7668lGUr97THB//xNFJaBD0vNOBDahH8YYRvr59ewNToAqkZxagZ6Khq7p5XFHTQFxqh5E7bVJnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdfC93A2; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdfC93A2"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c80170db7d6so764268a12.0
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 01:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779091487; x=1779696287; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:subject:message-id:date:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HFnv5RAtZZqCB/DQ5TMyFrf4XXbpu5FQe7786lTdjlI=;
        b=sdfC93A2kCOm2tiXuzDYwfD2QLjxKP0+EEnsS/b2aQQ1JudY5df4SsVS6WwW0e+BK0
         m54JNgmHovAoa2mqtMEObwbyp6RM4TQBGxV3AxG9C2HTvFvHNVnRUrS5gAAvSAJ1RRff
         a2urR+N9SF6LtklOoNqNcMehCkjM8PVxT91DoVXiU2QfwIRp3oyGm26YdxfMYyNpPjv5
         XFsLjRWvvEO7k89V0zB1WUTB14nIw79HhbDwu6oJLBvT8CgTayRL/mYydutbFKNC1Qgf
         CEZYVHTxqyuzEUcUeqKmRn89f8pTgMhT54rRu/s0RXxEW+T3+TnxJvBArqyjrOWHhsPB
         blNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779091487; x=1779696287;
        h=mime-version:content-transfer-encoding:subject:message-id:date:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFnv5RAtZZqCB/DQ5TMyFrf4XXbpu5FQe7786lTdjlI=;
        b=fvnvw3SVF6ycvtUooXp2svO0ySEoBznYS7L43WCIpcSAwpNaCnVb8uESXC2UTQKWmc
         R1t3X8jLS0QoGeHPVNuqyBdBMUS7w4tuXlEaRRDRwjUuOkt6+pGUcbEfyXpGkpRdRtw3
         TyKYHzbfWcHVwPWdWoXWc5X6Tcuz5ttys97fpvWvX0+KNjLKhO3sZ6h/GCR/XtoOTHmh
         VHlaSpnRyn9HsITHUOuZWPkJPMlg42QVztuovovAtfJ/VeclBIfPpGuFZ93Hvo+3KK8U
         DP5vhCs+2daE/DpSdtRQQHT9kC1aMmQ//UizOz/nna3BCvhsUr7MyXjAmblRU3yAVRBl
         xM4A==
X-Gm-Message-State: AOJu0YzBMd4QM99HAWQkCBn8BXg4f2VTCMoZAanprJf27YOX/OLcu6j4
	VlQ36kIx/zUaTnuD+Bt9bdAlZxN5eTWrcsWz8ZrTVFyMDpdDzoY5o+Ks
X-Gm-Gg: Acq92OHr73MJTkA7rM6CDZS7P0fMvd8CgZ9yo6Ligzi7eo8DT7u5KyNDazp42bJOgGD
	CShQW5KFV/qZKzvc5FXHGRrSPrqMBPgyLPjkPEHjOL2sXpzykvxX6dD9b8ZPEWrkgAbauxRAHhF
	PV12cKuObHWIWMN5/YyiaRxXOIzn23J4qiwg948LCaio2WjkD4TBuRUPudDyqAgbWc+lkxiwVoW
	gMgvgSZwWVPmcqdjctUTnBKbZH9dUgtzWqEwS+cu+57nC+eswtHpg8UZOvTQWRp26+YixJDjdOJ
	X3nMzBf5tvr/WL4fMjQKnBrmhiCG6ezcnerRLL3tzP7aJOu75q3lReAgnwxkmqZF5QNMp1TAACW
	F/4RIeE9wb0wdiHAqeknqRd/Eg1ZoooY76anee3dIcOgPenAf8XtSQrYXH6AWDG2Czh1LWs8HZ4
	GtPlk0dkJRwOz9M4Ya2boPQ/j8X8DzGuEU3BzA+dss+cvjV0PxfxQV6jC8HyQav2JQklF7rfN0T
	8QPk/SYlhsw3Be3XU611BQuRffZ
X-Received: by 2002:a17:902:b288:b0:2bd:2de3:519f with SMTP id d9443c01a7336-2bd7e97d27cmr110339225ad.19.1779091486960;
        Mon, 18 May 2026 01:04:46 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([110.44.115.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe64a9sm140971935ad.53.2026.05.18.01.04.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2026 01:04:46 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Yue Wang <yue.wang@Amlogic.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>
 =?utf-8?q?=2C?=
 Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 18 May 2026 13:49:40 +0545
Message-ID: <177909148011.9588.6639767953842842291@gmail.com>
Subject: [PATCH] PCI: meson: Propagate devm_add_action_or_reset() failure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

meson_pcie_probe_clock() enables a clock and then registers a devres
action to disable it during teardown. If devm_add_action_or_reset()
fails, it runs the action immediately, disabling the clock.

The return value is currently ignored, so on that failure path
meson_pcie_probe_clock() returns the disabled clock and probe continues.
Return the error so the existing probe error path unwinds normally.

Fixes: 9c0ef6d34fdbf ("PCI: amlogic: Add the Amlogic Meson PCIe controller dr=
iver")
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/=
dwc/pci-meson.c
index 0694084f612b..8d495bcc3a41 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -204,7 +204,9 @@ static inline struct clk *meson_pcie_probe_clock(struct d=
evice *dev,
 		return ERR_PTR(ret);
 	}
=20
-	devm_add_action_or_reset(dev, meson_pcie_disable_clock, clk);
+	ret =3D devm_add_action_or_reset(dev, meson_pcie_disable_clock, clk);
+	if (ret)
+		return ERR_PTR(ret);
=20
 	return clk;
 }
--=20
2.50.0
