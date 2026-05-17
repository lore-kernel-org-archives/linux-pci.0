Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A958E1917FB
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778982556; cv=none; b=dWUVli5JPfpJqDuIYwQPtUp9dGd+w6xhsLb1zendD88kfUZsxWNnjJMFhsWMJNVKpixwoHj0XWa3L9+nPreNgt0rYoBZiuT1SP57XZZ56Gp3/Vws8PEPMBL1iWO3/MEna8lwtlJFk06I1xcExlDX1jPcZR/eHgptXyNXV1ZZpek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778982556; c=relaxed/simple;
	bh=VFz+7WbS8QqpbMzmZlj/7iUhU7PPWjD/yohdUY5kCG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UX9SrGObS0IJho5WoV0FuaK2DMYzN2uuDyzd3On/nmtNEyU307z1Is/7lHQZcUkdAavF+uk0+mPPN0j7Xt0Ylf4isNvl7anBFDu7dE5bdsI0h1rOwhE0x8vEQDm582zHm6+YggRrZJ6l5BzbL+EWebnYmY6d5D+uc/d5GMwR89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re6WtIos; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re6WtIos"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-365eecc5885so1032366a91.0
        for <linux-pci@vger.kernel.org>; Sat, 16 May 2026 18:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778982555; x=1779587355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n7RsZByyP81xsWgXZpteSqn5b3NI0aEqfKSesYIzFiI=;
        b=Re6WtIos5GS63PrpMEYWwu1qAjTP9mTx2DpmEdcLD9Sp3kiiYhwW05hIOaF+trDYbQ
         MNltKQPnGgn2hRXf58LbBr3pIJXTKndZWO9GEKu7cRFUBrSwG5fDaTdbZnPD1kQFJ8RD
         mw1qKjsWnAwIt7dWc2JD9xWbzdZDHc653wLiVPD/nnrPluctoAxHKGcsTJKmQB6Rv/1/
         ON/ifL1bM+QNIf6x0R/x8N332QdWKGEJGfraOUfTfGA9CIAOjWPLKx6UpD52GxHxrBXC
         PDLIwQWWYUMOzYl3Km79vd84hfMneSdcOPwKRodIbxm2SUQgE/83K0kisQz4PEUN3i/I
         rVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778982555; x=1779587355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7RsZByyP81xsWgXZpteSqn5b3NI0aEqfKSesYIzFiI=;
        b=a2emmQT0bjEJyNJZBxonKgI05UFFd4f9M5woAE2eCPFCCqlZHAZf0VAmRv1/cfEsgy
         07RwmqJn23/kFxYdrJLt+gisPsmZwu2TWusYJnMp26nxrsp+cGH2cEoZvkxY8BlfGNw2
         ClJMOmfG5DRJMQQYow5dNK/95hfcy3xzcRL0mVwpDOzGqWCr9gxD90Yo6a7WEspOqOJF
         hHFnn0mtMhtdeVoctOKhCuKE3TiKd63YzvssVAAidW6Pxc9Z6us+LJA4fQQh4rne4DRe
         w0ZlRgb1kBoL708szqCR4aR+LS8Svt7L6lnavwB6qqj54oo0ZltqGTZNVyl3FOEUJdCz
         ly3A==
X-Gm-Message-State: AOJu0YxScYpE3PvFd35oTu7LA0es+DAoIgh/ftCBXvIidkE63ZzoDj/I
	DohotWa7J1gK1TriZ07J86rTccMF5Z+w4wKBzyZoCZciOfkZUWId85S/
X-Gm-Gg: Acq92OE5fg8LAjHOHkPkHlXgvs00HejSRCzwqiDK6Eb1VC2wZO3NADlJ/77f9KcNQDW
	8KZ3rIzJnlOlzf1imMIUIndy9oXEn4oVBhedwrjb3vjnRGyhFcPPdNCcLWHdahpI9ztgBNSeGDv
	MbbT+RACQCDLmwZs58xRitZtqgHL3Gg3tkcMNruk93sIRH5srvb3SJmB7zAXVAu3gDEijlkwzqu
	0wSG8E5mgR9XcVCJkPeXteF/DUfqWRy009bd6xdceRUEuy/4dcT6WNCFCeAyn4AQmSL1hXVny6U
	0BbStt76nVzN9gMeeoUJPcE+jU1NpT1WisyUk5FfiTfdYSivOvjZRBE4Q+35pyP7iQzK9GGroaw
	WNhZZNjLayRbxUuZIlZ/sPc1xkahbWy18EFxnS8P4VO0DDoUTHUBeWhHEYNGYF8g4BvWBOZMTmA
	6UPio9ZuJUgcFXW240mlJat4hIUXYxOzVAzQ==
X-Received: by 2002:a17:90a:f10:b0:369:7b04:49d1 with SMTP id 98e67ed59e1d1-3697b044e5dmr2192326a91.1.1778982555040;
        Sat, 16 May 2026 18:49:15 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695155b2c4sm6861899a91.3.2026.05.16.18.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 18:49:14 -0700 (PDT)
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
	Inochi Amaoto <inochiama@gmail.com>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Alex Elder <elder@riscstar.com>,
	Nam Cao <namcao@linutronix.de>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Randolph Lin <randolph@andestech.com>,
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
Subject: [PATCH v2 0/5] riscv: spacemit: Add PCIe RC controller support for K3
Date: Sun, 17 May 2026 09:48:35 +0800
Message-ID: <20260517014841.254085-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Inochi Amaoto (5):
  PCI: spacemit-k1: Add device data support
  PCI: spacemit-k1: Add multiple PHY handles support
  dt-bindings: PCI: snps,dw-pcie: Add msi-parent for MSI handle check
  dt-bindings: PCI: spacemit: Introduce Spacemit K3 PCIe host controller
  PCI: spacemit-k1: Add Spacemit K3 PCIe host controller support

 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   7 +-
 .../bindings/pci/spacemit,k3-pcie-host.yaml   | 135 +++++++++++
 drivers/pci/controller/dwc/Kconfig            |   4 +-
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 210 +++++++++++++++++-
 4 files changed, 344 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml

--
2.54.0

