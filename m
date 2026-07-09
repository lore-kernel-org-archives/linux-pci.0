Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98143935D
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 04:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569682; cv=none; b=dMpO5qtQlfRiXCYWKD5gxBCtaX5m749+sYGKupgs2vQ0SMSILKunxh/OqTuWsD6nyzTinQNGkHcSLJSAtRBd/hkj9xKsrELIgPu7ECY34Qo0r3icJFcoJFsXLXuqM9upSgPr4w5fWDGvLkGc/ehBv6tfjR0REdT5xtl/ZIdhL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569682; c=relaxed/simple;
	bh=iDi6eMAdavvHdiNKGxpAXcZmLMfTTt/P5T++UkYTMYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jht71ltcptda4ZA30GhAB2+BpST4WkA69ESVTKI7+REmixNz6wcgKjDv3Khy1bj/uS85gGmEJARD5j/QysxM5W/xSLsGzEZ/3eyddG/7R5DzMoMP62swCuiFTH3uzfLxozvYMIz7XY1NSQyAFnKBx73nokKeJLiEHQ0AbbJaOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bmmu5PqP; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bmmu5PqP"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8484f229529so830466b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 21:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783569680; x=1784174480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cvLv9XK6KjcJ7sFC5wHJkjs3i5/edN/xpBE+mpYwY4k=;
        b=Bmmu5PqPGy+9+hXb1Tg98lrpbdanz5f4KXZ1kD12dVkZVIila+ycBakFv2BpWx96io
         CPx4JanrspbAR6UhdYSs9qBWvEuwCIt+bwUg++wbJOcoVAuOArEjgdoIB5T4QTTVNVHz
         V75dLwhcBuOBPv87tJ6tvY44tZfvYeZ9utrbuOVwlHI6nyk3YFNIxHbkbjDLVpxxFre3
         UwPKtXd1tEPrVkmooKfi1/FV94/0/tXGl8Odam2wuB2UQKvvcH0i4o7GCHUcc4X0t8Ln
         cfUy6gfnY5IymYJdvIrwJLWtA3eYyGMIxbtG1Dr4fdbySAPd8UPK0sOLoQvfE3OZlAVz
         w/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783569680; x=1784174480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cvLv9XK6KjcJ7sFC5wHJkjs3i5/edN/xpBE+mpYwY4k=;
        b=H8NI0W6r3F1Bqg/h/+WERjUD3AV7nMadyHNIvTa3jInI08/5CJ/2GvQ1TnpAeet58r
         as9BcvAU2l2jHF1b1VhjkndMtJNcKUJd2fuHuX9PVjBKy4XXl2qt2etzprBJ8IaUkTq7
         41f14DjUPVXBNToYDWRNXsrSTgmxtJ3FcqlHS061kAYrAeJt2j4zq3p3Q8Ye3tmIU3uU
         ZEpYQl1xk+U6ajPn9odd3bnxaRKFxA7bfs/T3XYtSLAJ3CiI9525GrQs+T9eFC6QBOtB
         gapw82r25RVf5UvBCkwA1gIGqFpeuPHQqZ7AKa04FcZSTLU4pPMFrb3pyNo+/6IVxJsu
         jJpw==
X-Gm-Message-State: AOJu0Yz1eXxLLhmHVTbF2zIAkuBAP4KrOqN7k3I9980K4RGlu8Harjw1
	KW19fq8BcrV9rmrZw0pa3zmYA5+xShvqotL9v5bRrZ/xjY/8IicF/+ki
X-Gm-Gg: AfdE7cn/v3jgoqG8ECH52CFOREynKFsNfepjJocie9hPuKkVHahQKt7xAdOUIeIddyi
	LGpUWrnUYTWc0fBIkb/RFSTZ73VDbODKK5jAS+VQYAgDkYv7pFcK5BRCOUeMRw0RGdVpqHz0P3h
	UlC0JtMybN0qxFEORjpBygfPlvXUfq9pj1fuIWc68iykYSQ1ErupDuC5XqwPmmX4KbL+37oC1I1
	ODxpw/YFPyE9ODSoV3PKFW/zaSE+35NtPmUZs1zloo0Fw2F6TGMW8n+2LPKJBTD8yVCceJIEfrS
	5lSxY1feN74Rn0YXd/4IAz1fZU+ZtlM0QAs0knjYKMoUGt5tXJ/x5cf6olG+TiwdXZ5PLFahXr+
	ltc1RaJjEIdSFbWTQA7Lp/6gWV0Azi3Y7/UjCh+y/M7+m6KeOu1pPEk5MQ3H/bodW
X-Received: by 2002:a05:6a00:4405:b0:848:2f74:d8d9 with SMTP id d2e1a72fcca58-84843004857mr5364669b3a.74.1783569680457;
        Wed, 08 Jul 2026 21:01:20 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9a832sm7919258b3a.18.2026.07.08.21.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:01:19 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Nam Cao <namcao@linutronix.de>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v4 0/6] riscv: spacemit: Add PCIe RC controller support for K3
Date: Thu,  9 Jul 2026 12:00:20 +0800
Message-ID: <20260709040027.958400-1-inochiama@gmail.com>
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
 .../bindings/pci/spacemit,k1-pcie-host.yaml   |  50 +++-
 drivers/pci/controller/dwc/Kconfig            |   4 +-
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 237 ++++++++++++++++--
 4 files changed, 271 insertions(+), 27 deletions(-)

--
2.55.0

