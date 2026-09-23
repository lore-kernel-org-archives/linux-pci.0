Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1F363C53
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128275; cv=none; b=lpB8el0A9cyd0ZuYQutpyoz0ZRwFsBn9K6zElG5QxEcgktq2jqlTyEeisor59oVYHdZ61fM+V9JYdJhJFTa3jBTw02XkZ3qNLT9WGWIFmbYN4aEqIb4qNCrs+kP0xkdc47zIXaPhBB/03GTFqdHvqvmFmRI0I5OLObM0IrTualE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128275; c=relaxed/simple;
	bh=qg8v1Bj0AJ7LrZXBhxVjtYCO330qkDOjIG55GgTZsR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9KAn+Mrs80YEgMCqhwwQ2/Y4bOh3T8t3n29IsCaNZ9wYOYd9letO0/x2Lx92tCE+g+8NJRBu9YtKgFOxsSAHhbI/EaUqB5tFV9arRGZG8xzt3cplK84xBh3CusVMlvh2Yv9HxB9dDaNU9NyIIwuK2Y8SGxnbOcbd/LI05wAIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV5fiFhP; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV5fiFhP"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f6so1909655ad.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 18:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790128273; x=1790733073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L6bw/fsy4XZLqY7688qpNAi5VG6nNf6KIvqtLcr0OWg=;
        b=eV5fiFhP4ngfGRJGojgUb+UXFLwGkoSFKhAgVCdyHpU2gMz32QS+Cc+LEvVmz3ZzG5
         mwkNDq6dgMiwmmFJ0OgW3PTkAYCGR76rnZvFp8Rxlvrs3/DxNBXpi6TtoFgRxKTQth2m
         VSMWSOTQteVlG1tT0DwWE1JObmypDroNxUj2SI4BetB0eJ7SGuuuVmt3oTHeCwRqVKml
         49mC9DiEQS6OgpCzm04YhmIfHbmB/qN4gsgHlImJV0jN9SRIZ8oe+hHB2ovOw6Gmn0ZA
         b8xqADhhSn0R4cJ7kwLcF9aRK0OntZOfp89quGHKUIVKeym50KjqJ65ZAP2Jc8id+upZ
         OFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790128273; x=1790733073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L6bw/fsy4XZLqY7688qpNAi5VG6nNf6KIvqtLcr0OWg=;
        b=S7anXwNUSS0TeXy9vUAVx18XMxZDgt2o+lQNwR3n9NtnxnjNT0XRhWoEt9Z1so4iWg
         +8L53mxGK2UpHVsshiw+84noD0J99CdKNcAodEoGt64Y4Gpph+3TooBfzY8UeZ2Ws1Xw
         5GXclHncaq96HvVxbWMaZD7GAKa9XhpfeQacZ1wB4H3tzYa+ODnXs24Z8Nqybhj8hPbK
         hqSfdlc0PAUCmXxvDdLQ0pLFhAcq0maFGtBcJdT/lKxaM6qNWG7yrQh3rir6EVKzO0O+
         mPDl01ah6br665y85wR8rnlaMfpZUDA94pcyi92umDPz7dYhvWrO7jW/MHwwBwhlYsdg
         vuRw==
X-Gm-Message-State: AFuF++n2pXy0rl2ukzcPPyRw47oASAgY5nt9f554HtrcVWxg0jeetKbu
	GTZua3clyQvZgHSdRW4Mcwpr1+V9e8Xb+Aq5QNtDYEouBsPx61J6vtTi
X-Gm-Gg: AYBFou0XSQcXQx6yO5ruzBUS5aGjHsjIZNDld+/QAQORL66H2TlRmDuwRd+sAXcL1BW
	9yypz8fWFJBKREy93YjGd1ZKqwUQiSKaGBm9pTanDF/PAMknIggTsktqKFHELmhVCtkvoty6IaR
	4EyTjSO/dAp1c5sOp6hi1MhzH1c1FBSMSRlZsm6FvYpP/68TvTo5q1KkdTS7kFEcI1O+iTI9Vru
	IjrobuAElI289OQu9tCn2tMFXvM5U0ZqsR91Oq2hXXr7maRBAACeKZ8pl5Fim/QCA+qYu0qDOn1
	UNDqxL7+oB6iRKWRV1gnaVoN4h+0JAWl7UB31XJxngrjptEJ/a2oFmVSQni3qQFcFZffZPP+MrD
	4+082iMua9zgqsqZHub/l8W9Zz/dTX+dMEEst5NU80valtARGWXxJIEDmKiax3LRVFmcEcQOjQG
	jNan/d+o4kOEISBsfKy0+pNFGf5rk/PT8Qeyxsty5U2uBJfTk=
X-Received: by 2002:a17:903:2c07:b0:2db:257c:9fd5 with SMTP id d9443c01a7336-2df69d3d22amr10510345ad.16.1790128272959;
        Tue, 22 Sep 2026 18:51:12 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5f66b3sm2769165ad.73.2026.09.22.18.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 18:51:12 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sherry Sun <sherry.sun@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Vidya Sagar <vidyas@nvidia.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Randolph Lin <randolph@andestech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v6 0/6] riscv: spacemit: Add PCIe RC controller support for K3
Date: Wed, 23 Sep 2026 09:50:09 +0800
Message-ID: <20260923015016.64069-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe controller on Spacemit K3 is almost a standard Synopsys
Designware PCIe IP with extra control and external MSI controller
(IMSIC).

Add binding and driver support for PCIe RC controller support on K3.

Since v5, multiple vendor fix are included in this series, you can find
in [1]. And this version required [2] for phy bulk data support.

[1] https://github.com/spacemit-com/linux-6.18/commits/k3-br-v1.0.y/drivers/pci/controller/dwc/pcie-spacemit-k1.c
[2] https://lore.kernel.org/linux-phy/20260904083709.425893-1-inochiama@gmail.com/

Changed from v5:
- https://lore.kernel.org/linux-pci/20260907112606.465778-1-inochiama@gmail.com/
patch 1:
1. Return ENODATA for no device data found.
patch 2:
1. Add power_on/power_off suggested in [2].
2. Add zero phy check in the driver.
patch 5:
1. Add K3 device description.
patch 6:
1. Update comments.

Changed from v4:
- https://lore.kernel.org/linux-pci/20260709040027.958400-1-inochiama@gmail.com/
patch 1:
1. fix comments
patch 2:
1. Use phy bulk data to simplify the code
patch 3:
1. Rebased to latest master
patch 6:
1. Apply several fix from the vendor code
2. Use separated init/deinit function for K3.
3. Add some error handle for K3 init function

Changed from v3:
- https://lore.kernel.org/linux-pci/20260703020003.485436-1-inochiama@gmail.com/
patch 5:
1. Add missing interrupt/interrupt-names check for K1

Changed from v2:
- https://lore.kernel.org/linux-pci/20260517014841.254085-1-inochiama@gmail.com/
patch 2:
1. Use unify PCIe phy get/enable/exit function for both K1 and K3.
patch 3:
1. New patch for updating device id for both K1/K3
patch 5:
1. Reuse binding for spacemit,k1-pcie-host
patch 6:
1. Multiple cleanup for the logic already generalized in the previous
   patches.
2. Use generic description for the Kconfig entry.

Changed from v1:
patch 1:
1. Remove post_init callback.
patch 2:
1. Fix devm_kmalloc_array arguments order and error check.
patch 3:
1. Apply Rob's tag.
2. Change check from oneOf to anyOf.
3. Fix spelling mistakes in commit message.
patch 4:
1. Add comment about PHY handle.
2. Remove interrupt "app".
3. Fix spelling mistakes in commit message.
patch 5:
1. Remove all logic related to link up interrupt.
2. Clean up all unused macros.
3. Fix devm_kmalloc_array arguments order and error check.
4. Remove unnecessary start_link logic.
5. Make all magic number as a macro.
6. Fix spelling mistakes in code and commit message.

Inochi Amaoto (6):
  PCI: spacemit-k1: Add device data support
  PCI: spacemit-k1: Add multiple PHY handles support
  PCI: spacemit-k1: Add device id update helper
  dt-bindings: PCI: snps,dw-pcie: Add msi-parent for MSI handle check
  dt-bindings: PCI: spacemit: Introduce Spacemit K3 PCIe host controller
  PCI: spacemit-k1: Add Spacemit K3 PCIe host controller support

 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   7 +-
 .../bindings/pci/spacemit,k1-pcie-host.yaml   |  55 +++-
 drivers/pci/controller/dwc/Kconfig            |   4 +-
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 237 ++++++++++++++++--
 4 files changed, 270 insertions(+), 33 deletions(-)

--
2.55.0

