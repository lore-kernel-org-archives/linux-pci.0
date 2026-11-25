Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580134;
	b=5Am4efVvubsciMlzO2pJtjsXniC/MHMMCJi2ZlEYzXXq5daTv3CcqacDVz7w8qwsM8wW
	 SMUSnI2XvFTDQWQdHOgRfq/gIxtpwMXm9tNZcvQgC99j8E28Jum8LToMJpPJjel76ZIYZ
	 wwUMZun+LsUFDVD+f/MDS6BdQfflKm5JjMiimXzDr4xvxsddjtTI00VdG/dKc+qSX8NPV
	 ziL/ZLGgWrs0prff+6vPRJzmDOzxjQIXcye4RWSxcNfVfE32pw2yR/8Ox/klSr6OMkYKp
	 mq0STF5lgjL5OYOXjsHPPSN3FXA1wweJAhPPRA5/4n27J5RdMyPzp+kym0SaiOIsYJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+dZ7m1mSWDeoCgTYM1P+lZfpnqZnFCwEoDUl13Sf3Bs=;
	b=wdjZTRDz0xBVWRvNnUPAk+tM33qjRip5+QefEg8i1s3b8XOwT8eX6i90d9TAxcysVZ9i
	 F1iNAsGWIsA/ijAmjeplEKCYJeMz3hdPZ8pCf2gcUd3NJSm0Q2P7TwOCcjjUzbZ305hmO
	 Yp2ogK8JM8ITksBXIaq3Mr2MDvufzFL+NwWRjdW1opcUVrcIp97ClXtuDwXKl8vEwGyWY
	 o5WX44m/QBxc8az3NiJW6wiZAEKkIuhruwY7KrUdEee1v6cTgTyi5GyzSCrUARVaLsRPU
	 9oFkzyCEg1ZJjrhKYmEeZDvByy+vGe0Gm4xBvbsOUwKMWGHq8DPFk9ao3ddD+oX/9kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=idcRT9xa;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DFF606A31E
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 04:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4DFF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=idcRT9xa
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b3e85baf7cso3191654a91.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 20:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795580133; x=1796184933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+dZ7m1mSWDeoCgTYM1P+lZfpnqZnFCwEoDUl13Sf3Bs=;
        b=idcRT9xaKtp4jkQ/jnT4A+uApNVZBkFwPhQRcn3ozvkAkW9S0lAWBwlPQONb+s4+G6
         RhQgamrOBr5BuMvjnFG37F849ZSLwxdcA4LI3Kqur3EuTN7qyUW6L7oCM4n/QRfY9tGN
         JpN2MS0ungOpXrbkEOvS6cfurVcTVl6aE23xBe0zN5lBt/8mKi/32k9MVlFApYucxa2o
         3EYhY3Ny7iGNGg9lmvQn6jtjPfbOH3ebXwUya12h2m4H5+3iO10Vr/PoAJgJTa+U/let
         7RO8oRQNSGWIWif5sIQ+Vqr7tvyDHCtMBfMnzfl2APG3dgRmvrGz0VYXexkMcKnKw72i
         jyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795580133; x=1796184933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+dZ7m1mSWDeoCgTYM1P+lZfpnqZnFCwEoDUl13Sf3Bs=;
        b=jpblHjhAKm1uSR3fYqA7FCwvUIZIry0svSSV/uFE4Bg+pT+A3Wej2lvv3YimExZM/6
         vVitrb8q6D84U6riA3joMy6huXCyZ8JTRrvdCHn0QwZ3CZTqH6z5CnUxjbCja4PPh9IA
         DLErB9+8H3+4v+OnfWF8buguVA1ZYOjul1jLDyqqaJCYCO35uguqDiz+A2LylE6JpkDL
         u84js3Hj3G2pl3bMT0O9gP5eHbyGwQWBTPl4mdWt1y1bzAD/TiFrlzixkjh9L0ZLRc/e
         51Hl1uKRm3QULXGQ0Y0nJrEVBpGJDrEe++Ehnwyw+3PwVmu6qPP6vHuk2mL7UIb5fElq
         LEvg==
X-Gm-Message-State: APuU4Z8IKFMiwqaUKrq6jBW6Cf7j8Ire0cxlC9AwKFGySeKv79EfrEgk
	sVBcEOHorJaws7hNJUYDaN8tb4c0EimAsKYQgXAmUeS0CRr2hItKpHM+
X-Gm-Gg: AZFdTZfZBDheFg0mbhrgC1tH23Nn6pjVdte92uFeQjqNT4b3N42/TVSl13cBkzPssuL
	nOJQ/jhSo/fn/Iz90tw9cP7YlWZYLE0mOUAtbKWNkpz14kTsuc3ePFE7+2+8wSK69iAZIE1M73v
	UH2Zeq6Zbt9+svu/Z+eEz+/U/WCS5Tp3wEqT8DSg/k1X2en1rcn/ICEpkvBupIR1Pbarg4kL47y
	hv2mF7m5Aa/E0813OMTexDFRFvmbIRbXp43PnwVnYobWDL4nGVVvOgh3FXpAqK8Uvxb1YeEUP0r
	KDpJG7o9PlDIIf1GPAXS/MU3gtzS71sf4FlNHKdwp6PkU3Q7/cwiAeEJ/QdAD298H2ff0ruLbhj
	FQmqr0dCUOklQ9gLG83sBLBZas0aODWDdgv01DeMfS17038J+8C3WJwJgiy3+o7NxVZx3D/OQvM
	PfzTmEaejcZVBB3V9fpUmcUHvwqvMCMGZZQYH/l8MBdA727H9me2+mcuqKq06qiAV7gqBCuselL
	c9xRMjlXHqn0stwrtSdzK276PiG8mbu2GcHofwGTn9q6THrvbufDJEGwwBWArvQyzguQXV0eOkj
	KmHu82YNHy1+Tj4+IOJJUfNQFUM=
X-Received: by 2002:a17:90b:4983:b0:3b4:1357:d529 with SMTP id 98e67ed59e1d1-3b41c97c444mr16500146a91.51.1795580132845;
        Tue, 24 Nov 2026 20:15:32 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm25848152a91.13.2026.11.24.20.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:15:32 -0800 (PST)
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
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Frank Li <Frank.Li@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Randolph Lin <randolph@andestech.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Alex Elder <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v8 0/6] riscv: spacemit: Add PCIe RC controller support for K3
Date: Wed, 25 Nov 2026 12:15:14 +0800
Message-ID: <20261125041523.242588-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe controller on Spacemit K3 is almost a standard Synopsys
Designware PCIe IP with extra control and external MSI controller
(IMSIC).

Add binding and driver support for PCIe RC controller support on K3.

Since v5, multiple vendor fix are included in this series, you can find
in [1]. And this version required [2] for phy bulk data support.

[1] https://github.com/spacemit-com/linux-6.18/commits/k3-br-v1.0.y/drivers/pci/controller/dwc/pcie-spacemit-k1.c
[2] https://lore.kernel.org/linux-phy/20260923023304.78428-1-inochiama@gmail.com/

Changed from v7:
- https://lore.kernel.org/linux-pci/20260929083755.458238-1-inochiama@gmail.com/
1. rebased to v7.4-rc1
2. Apply Andy, Rob, Aurelien's tags to related patches.
patch 1:
1. The const declaration is reserved, as the it hold the pointer of the
   static const data.
patch 6:
1. Add comment to the PCIe topology description to the commit message.
2. Fix some 80 chars line problem.

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
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 235 ++++++++++++++++--
 4 files changed, 268 insertions(+), 33 deletions(-)

--
2.56.1

