Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A266C3ADB89
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671089; cv=none; b=g3ZnhxmR2YMBqQ6ayhAG0TqKVp+Wa1SiytN7l/eyag/Bhf6XBcW/BKtCOa27POPpvavosLZa7dC3FFTnbuFIuhQLHe+2BY7Q73LGIpMDhrPjX7D8eFMGDw6Dg83CaCqohedLoKV2tkP6QAAmFi2D7r/3VurMaHgxBswDRxfub64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671089; c=relaxed/simple;
	bh=jbkQDh1WXQk+4/agGxITBZs89OQ7prZRbG+zWy3w8z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5RXEwaynchJUB71clPhkuvIozoFevTLnZEsDJf9WSqqcWJgt3KmbLpw+W274J+0+L6euh181JxgJBNmnLoRV1+fzvYXRvDUYvoDsCyZVZfgE6Dck3++cTrlY9o3MYfttTPo5sDSsAuhxSEBrn+/IMw8jPs0yUN2NGbXw3T3DsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dl8eYLq1; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl8eYLq1"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed9866so27982355ad.2
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 01:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790671087; x=1791275887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bVr9gxAZxb8ElKLswGJsmoMufAJERtFn02OY/z6PAKM=;
        b=dl8eYLq1DnnyOXgi/GI6fg2PMZ0PE47JUQT+EX4KJrHZNFrdOd7xA3tus9e0GhyrJ8
         eSrAhycrD+CEjmmRJqUzRQixoVC6WjL+ElVBsTdcaxHaiVOFYFEVKSge23haI+8JgQNr
         Ps+mWDzC/ShzNJBTtAhG8/EHdYIwX0+wfZVwfHkawScaQQb3+rDF2pvjNTDI+ycHWKth
         MpBR5dojYATLBFXCi9moQXEENtFjj96ClCf+hb4yf3U+HtomoBUqzHl2EcleFyp1WkT3
         2Rlox7qZ8z4ZEb7cxCp9l5ZEuDFH9IP5TTgvE+tYd+SQbVJQNUfq6eZ4XdylVzNaVvAo
         iUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790671087; x=1791275887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bVr9gxAZxb8ElKLswGJsmoMufAJERtFn02OY/z6PAKM=;
        b=BzaneWq5/Y8+jQ3NFjk5qJ9uQJQnG/cFBbNdyBBesWIsJAFIpWqvdIssIhPvrR1TF7
         UqTQ4F9rI5LAAQPPC676nMG6tGd2wvoENmQQ9tFIIyFu/q51+o0VZgjq6CZoEw2GDYiQ
         OqRSlDaxba7tAdyTVa2yM7orX+8odm79Pnp528R+u7y7SXixa3GgvLw0yQSFCJA8YBd7
         hKHCtwLni7wnZmJaiidUZYPBSmgZ3+/RHJHFmQc9TVEVKUNuX6QxZjLbS9bc4ZpDo5mI
         Lv3eWqm0FAE2bP2sADr7jC2+lnCEkTptg0wIzjM0gMoSJFOUn5PcKxm449cBqv2q+fcY
         MILA==
X-Gm-Message-State: AFq9FYK5bDfjWLI/CyN9zQjplfu6qy9g0QbKb1tuPkhHTppga6j9O4HI
	sXLAeA/uePWoUy5AXP3vM3/eqOCPnvSgTLu8dC3icvyHm/f4G96ek3qW
X-Gm-Gg: AYBFou0rXMTASPXd+lNcejKjC4F/9dQcynhT5i68nN3YUDkc04pcxLw1WapMhoSWRB4
	fP6tZ+dtkecIvjrYSAv87Y9TVRQAqTJ5r1LNf34fS8XWVKVuIkV72+jGU0J1yJhWd4B+hFUEyUm
	0MsaFJd/8Hn2dAjAnzlSrKrndzQY/smAkFHgbBohRK9u8cJ7bJR0YWIfT2OGH57FmTM2cGewtCP
	/XNFd10+Hz3qgah5fwPlRGK4ycH3H1bJo05mN1eQgQlbOcGQvTnSkWCvuRlYt0o3oPHUI22FqNC
	EMBuvVki0fOnBNDb2IgsjboVh4efXiRQ8lIa6YGTBgAivbZgkj20RY8+ciZoEYsXQRYRvGyeAmF
	r2F4VVtzrDs0KgXOQfC2HAPo4MbEnQrvhsd7Dcr8InrU+m/qJCL4ovasiKagg74L6Xby73JBYBU
	Dcj97e1f/XJQdkBBnlyQt8B2cBQ9uyce0zlQI1+x04b4HmheK8WMLzXS0udvtRlhAFOe7L
X-Received: by 2002:a17:902:d550:b0:2df:9a4d:650a with SMTP id d9443c01a7336-2e2c0b3b7f9mr20035895ad.29.1790671087430;
        Tue, 29 Sep 2026 01:38:07 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df90fbcaa1sm53065915ad.4.2026.09.29.01.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:38:06 -0700 (PDT)
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
	Arnd Bergmann <arnd@arndb.de>,
	Niklas Cassel <cassel@kernel.org>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Randolph Lin <randolph@andestech.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
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
Subject: [PATCH v7 0/6] riscv: spacemit: Add PCIe RC controller support for K3
Date: Tue, 29 Sep 2026 16:37:46 +0800
Message-ID: <20260929083755.458238-1-inochiama@gmail.com>
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

Changed from v6:
- https://lore.kernel.org/linux-pci/20260923015016.64069-1-inochiama@gmail.com/
patch 6:
1. Keep PERST# when init failed like the deinit.

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

